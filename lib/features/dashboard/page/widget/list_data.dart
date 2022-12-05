import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_application/features/dashboard/model/article_model.dart';

class ListData extends StatelessWidget {
  final String name;
  final List<Article> datas;
  const ListData({super.key, required this.datas, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        welcoming(),
        SizedBox(height: 19.h),
        category(),
        SizedBox(height: 19.h),
        data()
      ],
    );
  }

  Widget welcoming() => Text.rich(TextSpan(
          text: 'Welcome, ',
          style: TextStyle(fontSize: 20.sp),
          children: [
            TextSpan(
                text: name, style: const TextStyle(fontWeight: FontWeight.w700))
          ]));

  Widget category() => SizedBox(
        height: 190.h,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 16.w),
          scrollDirection: Axis.horizontal,
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 210.w,
              height: 190.h,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    datas[index].title,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    datas[index].content,
                    style: TextStyle(fontSize: 16.sp),
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            );
          },
        ),
      );

  Widget data() => Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 20.h),
          itemCount: datas.length,
          itemBuilder: (context, index) => Container(
              width: 320.w,
              height: 200.h,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).primaryColor.withOpacity(.15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(datas[index].image,
                              width: 80.w, height: 80.h)),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 210.w,
                        height: 38.h,
                        child: Text(datas[index].title,
                            style: TextStyle(fontSize: 16.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 300.w,
                    height: 57.h,
                    child: Text(datas[index].content,
                        style: TextStyle(fontSize: 16.sp),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    width: 180.w,
                    height: 19.h,
                    child: Text(
                      DateFormat('dd MMMM yyyy, H:m:s').format(
                        datas[index].date,
                      ),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              )),
        ),
      );
}
