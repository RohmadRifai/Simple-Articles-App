import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_application/features/dashboard/cubit/article_cubit.dart';

import 'widget/list_data.dart';
import 'widget/shimmer.dart';

class DashboardPage extends StatefulWidget {
  final String name;
  const DashboardPage({super.key, required this.name});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<ArticleCubit>().fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: BlocBuilder<ArticleCubit, ArticleState>(
            builder: (context, state) {
              if (state is ArticleFetchSuccess) {
                return ListData(name: widget.name, datas: state.datas);
              } else {
                return buildShimmer();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildShimmer() => ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ShimmerWidget.rectangular(
            width: 144.w,
            height: 24.h,
          ),
          SizedBox(height: 25.h),
          SizedBox(
            height: 179.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(
                      width: 116.w,
                      height: 19.h,
                    ),
                    SizedBox(height: 8.h),
                    ShimmerWidget.rectangular(width: 189.w, height: 152.h)
                  ],
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(
                      width: 116.w,
                      height: 19.h,
                    ),
                    SizedBox(height: 8.h),
                    ShimmerWidget.rectangular(width: 189.w, height: 152.h)
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
          ShimmerWidget.rectangular(
            width: 320.w,
            height: 200.h,
            child: Padding(
                padding: EdgeInsets.all(10.r), child: buildInsideContainer()),
          ),
          SizedBox(height: 20.h),
          ShimmerWidget.rectangular(
            width: 320.w,
            height: 200.h,
            child: Padding(
                padding: EdgeInsets.all(10.r), child: buildInsideContainer()),
          ),
          SizedBox(height: 20.h),
          ShimmerWidget.rectangular(
            width: 320.w,
            height: 200.h,
            child: Padding(
                padding: EdgeInsets.all(10.r), child: buildInsideContainer()),
          ),
        ],
      );

  Widget buildInsideContainer() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6), color: Colors.grey),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 210.w,
                height: 38.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6), color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: 300.w,
            height: 57.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.grey),
          ),
          SizedBox(height: 14.h),
          Container(
            width: 180.w,
            height: 19.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.grey),
          ),
        ],
      );
}
