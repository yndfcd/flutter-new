import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neos_post/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/l10n.dart';

class DetailPage extends StatelessWidget{
  ItemArticleTopHeadlinesNewsResponseModel itemArticle;

  DetailPage({@required this.itemArticle, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var strPublishedAt = '';
    if(itemArticle.pub_datetime != null){
      var dateTimePublishedAt = DateFormat('EEE, dd MMM yyyy HH:mm:ss Z', 'en_US').parse(itemArticle.pub_datetime, true);
      strPublishedAt = DateFormat('MMM dd, yyyy HH:mm').format(dateTimePublishedAt);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(itemArticle.subject.trim(),
          style: TextStyle(fontSize: 42.sp),)
      ),
      body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              color: Color(0xFFEFF5F5),
              padding: EdgeInsets.all(48.h),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 48.h),
                    child: Text(itemArticle.subject),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: itemArticle.url2image,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/img_not_found.jpg',
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/img_placeholder.jpg',
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(itemArticle.author ?? 'Neo\'s Post'),
                      Text(strPublishedAt),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 48.h),
                      child: Text(itemArticle.summary)
                  ),
                  InkWell(
                      child: Text(itemArticle.url,
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline
                          )
                      ),
                      onTap: () => launch(itemArticle.url)
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 48.h),
                      child: Text(S.of(context).disclaimer,
                        style: TextStyle(
                          fontSize: 24.sp
                        ),
                      )
                  )
                ],
              )
          )
      )
    );
  }
}