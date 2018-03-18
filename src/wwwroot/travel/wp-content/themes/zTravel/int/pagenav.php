<?php/* Template Name: 分页 */ function pagenavi( $before = '', $after = '', $p = 5 ) {	if ( is_singular() ) return;	global $wp_query, $paged;	$max_page = $wp_query->max_num_pages;	if ( $max_page == 1 ) return;	if ( empty( $paged ) ) $paged = 1;	echo $before.'<div id="Pager" class="paginator">'."\n";	if ( $paged > 1 ) p_link( $paged - 1, '&laquo;', '上一页' );	if ( $paged > $p + 1 ) p_link( 1, 'First' );	if ( $paged > $p + 2 ) echo '<span class="cpb">...</span>';	for( $i = $paged - $p; $i <= $paged + $p; $i++ ) {		if ( $i > 0 && $i <= $max_page ) $i == $paged ? print "<span class='cpb'>{$i}</span>" : p_link( $i );	}	if ( $paged < $max_page - $p - 1 ) echo '<span class="cpb">...</span>';	if ( $paged < $max_page - $p ) p_link( $max_page, 'Last' );	if ( $paged < $max_page ) p_link( $paged + 1,'&raquo;', '下一页' );	echo '</div>'.$after."\n";}function p_link( $i, $title = '', $linktype = '' ) {	if ( $title == '' ) $title = "{$i}";	if ( $linktype == '' ) { $linktext = $i; } else { $linktext = $linktype; }	echo "<a href='", esc_html( get_pagenum_link( $i ) ), "' title='{$title}'>{$linktext}</a>";}?>