import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqwest/SRC/Application/Services/AuthServices/auth_services.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/categories_service.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/user_services.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class TaskService {
  TaskService._();
  static TaskService get instance => TaskService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<TaskModel> cachedTasks = [];

  Future createTask(TaskModel task) async {
    try {
      final docRef = _firestore.collection('tasks').doc();
      task.docId = docRef.id;
      await docRef.set(task.toJson());

      TaskModel? newTaskModel = await getTaskById(docRef.id);
      return newTaskModel;
    } catch (e) {
      return e.toString();
    }
  }

  Stream<List<TaskModel>> getTasksForCurrentUser(String currentUserId) async* {
    await for (var snapshot
        in _firestore.collection('tasks').where('requestedBy', isEqualTo: currentUserId).snapshots()) {
      List<TaskModel> tasks = [];
      for (var doc in snapshot.docs) {
        TaskModel task = TaskModel.fromJson(doc.data());
        if (task.requestedBy != null) {
          final userDoc = await UserServices.getUser(docId: task.requestedBy!);
          if (userDoc is UserModel) {
            task.requestedByUser = userDoc;
          }
        }
        if (task.assignTo != null) {
          final userDoc = await UserServices.getUser(docId: task.assignTo!);
          if (userDoc is UserModel) {
            final userCatDoc = await CategoriesService.instance.getCategoryById(userDoc.categoryId!);
            task.assignToUser = userDoc;
            task.assignToUser?.categoryModel = userCatDoc;
          }
        }
        if (task.service != null) {
          final catDoc = await CategoriesService.instance.getCategoryById(task.service!);
          if (catDoc is CategoryModel) {
            task.categoryModel = catDoc;
          }
        }
        tasks.add(task);
      }
      cachedTasks = tasks;
      yield tasks;
    }
  }

  Stream<List<TaskModel>> getAllTasks() async* {
    List<UserModel> users = await UserServices.getAllUsers();
    List<CategoryModel> categories = await CategoriesService.instance.getCategories();
    //
    log('Users: ${users.length}');
    log('Categories: ${categories.length}');
    await for (var snapshot in _firestore.collection('tasks').snapshots()) {
      List<TaskModel> tasks = [];
      for (var doc in snapshot.docs) {
        TaskModel task = TaskModel.fromJson(doc.data());
        if (task.requestedBy != null) {
          final userDoc = users.where((user) => user.docId == task.requestedBy).firstOrNull;
          task.requestedByUser = userDoc;
        }
        if (task.assignTo != null) {
          final userDoc = users.where((user) => user.docId == task.assignTo).firstOrNull;
          task.assignToUser = userDoc;
        }
        if (task.service != null) {
          final catDoc = categories.where((cat) => cat.id == task.service).firstOrNull;
          if (catDoc is CategoryModel) {
            task.categoryModel = catDoc;
          }
        }
        tasks.add(task);
      }
      cachedTasks = tasks;
      yield tasks;
    }
  }

  Stream<List<TaskModel>> getTasksForCurrentUserStaff(String currentUserId) async* {
    await for (var snapshot
        in _firestore.collection('tasks').where('assignTo', isEqualTo: currentUserId).snapshots()) {
      List<TaskModel> tasks = [];
      for (var doc in snapshot.docs) {
        TaskModel task = TaskModel.fromJson(doc.data());
        if (task.requestedBy != null) {
          final userDoc = await UserServices.getUser(docId: task.requestedBy!);
          if (userDoc is UserModel) {
            task.requestedByUser = userDoc;
          }
        }
        task.assignToUser = AuthServices.instance.userModel;
        final userCatDoc =
            await CategoriesService.instance.getCategoryById(AuthServices.instance.userModel!.categoryId!);
        task.assignToUser?.categoryModel = userCatDoc;
        if (task.service != null) {
          final catDoc = await CategoriesService.instance.getCategoryById(task.service!);
          if (catDoc is CategoryModel) {
            task.categoryModel = catDoc;
          }
        }
        tasks.add(task);
      }
      cachedTasks = tasks;
      yield tasks;
    }
  }

  Future<TaskModel?> getTaskById(String taskId) async {
    try {
      final docSnapshot = await _firestore.collection('tasks').doc(taskId).get();
      if (docSnapshot.exists) {
        TaskModel task = TaskModel.fromJson(docSnapshot.data()!);

        if (task.requestedBy != null) {
          final userDoc = await UserServices.getUser(docId: task.requestedBy!);
          if (userDoc is UserModel) {
            task.requestedByUser = userDoc;
          }
        }
        if (task.assignTo != null) {
          final userDoc = await UserServices.getUser(docId: task.assignTo!);
          if (userDoc is UserModel) {
            task.assignToUser = userDoc;
          }
        }
        if (task.service != null) {
          final catDoc = await CategoriesService.instance.getCategoryById(task.service!);
          if (catDoc is CategoryModel) {
            task.categoryModel = catDoc;
          }
        }

        return task;
      }
      return null;
    } catch (e) {
      log('Error fetching task by ID: $e');
      return null;
    }
  }

  Future updateTask(TaskModel task) async {
    try {
      await _firestore.collection('tasks').doc(task.docId).update(task.toJson());
      return 'Task updated successfully';
    } catch (e) {
      return e.toString();
    }
  }

  // Future<void> deleteTask(String id) async {
  //   try {
  //     await _firestore.collection('tasks').doc(id).delete();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Stream<List<TaskModel>> getTasks() {
  //   return _firestore.collection('tasks').snapshots().map((snapshot) =>
  //       snapshot.docs.map((doc) => TaskModel.fromSnapshot(doc)).toList());
  // }
}
