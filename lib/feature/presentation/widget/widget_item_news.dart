import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neos_post/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:neos_post/feature/presentation/page/home/detail_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetItemNews extends StatelessWidget {
  final ItemArticleTopHeadlinesNewsResponseModel itemArticle;
  final String strPublishedAt;

  WidgetItemNews({
    @required this.itemArticle,
    @required this.strPublishedAt,
  });

  void _gotoDetailPage(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => DetailPage(itemArticle: itemArticle,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
      onTap: () async {
        _gotoDetailPage(context);
      },
      child: SizedBox(
        height: 200.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: itemArticle.url2image,
                fit: BoxFit.cover,
                width: 200.w,
                height: 200.w,
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_not_found.jpg',
                      fit: BoxFit.cover,
                      width: 200.w,
                      height: 200.w,
                    ),
                  );
                },
                placeholder: (context, url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_placeholder.jpg',
                      fit: BoxFit.cover,
                      width: 200.w,
                      height: 200.w,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      itemArticle.subject,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 36.sp,
                      ),
                    ),
                  ),
                  itemArticle.author == null
                      ? Container()
                      : Text(
                          itemArticle.author,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 28.sp,
                          ),
                        ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        strPublishedAt,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
