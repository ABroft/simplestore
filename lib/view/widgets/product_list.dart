import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_store/cubit/store_cubit.dart';
import 'package:simple_store/models/product.dart';
import 'package:simple_store/view/widgets/picture.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key, required this.list, required this.isABasket, required this.isLocalRep,  this.preorderList= const []}) : super(key: key);
  
  
  final bool isLocalRep;
  final bool isABasket;
  final List<Product> preorderList;
  final List<Product> list;
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    
    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: ((context, index) {
                        Product item = list[index];
                        return ListTile(
                          leading: Picture(
                            url: item.imageUrl,
                            radius: 8,
                            width: 69,
                            height: 58,
                            isLocalRep: isLocalRep,
                          ),
                          trailing: (isABasket || preorderList.indexWhere((e) => e.id == item.id) != -1 ) ?
                            IconButton(
                            icon: SvgPicture.asset( 'assets/bin.svg'),
                            onPressed: () {
                               BlocProvider.of<StoreCubit>(context).removeFromPreorderList(product: item);
                            },
                          )
                          : IconButton(
                            icon: SvgPicture.asset( 'assets/basket.svg'),
                            onPressed: () {
                              BlocProvider.of<StoreCubit>(context).addToPreorderList(product: item);
                              Navigator.pushNamed(context, '/basket');
                            },
                          ) ,
                          
                          subtitle: Text(
                            '${item.price.toInt()} \u20BD',
                            style: theme.titleLarge!,
                          ),
                          title: RichText(
                            text: TextSpan(
                                text: '${item.name} ',
                                style: theme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.normal),
                                children: [
                                  const WidgetSpan(
                                      child: Icon(Icons.star,
                                          size: 12.5,
                                          color: Color(
                                            0xFFECB800,
                                          )),
                                      alignment: PlaceholderAlignment.middle),
                                  TextSpan(
                                      text: ' ${item.rating}',
                                      style: theme.titleMedium!
                                          .copyWith(fontSize: 15))
                                ]),
                          ),
                        );
                      }));
  }
}