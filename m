Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895E606C934
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxvHSDxS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F46D10E8D9;
	Mon, 19 Oct 2026 16:10:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0893210E111;
 Mon, 19 Oct 2026 16:10:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DFCE560D97;
 Mon, 19 Oct 2026 16:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D21C1F000C7;
 Mon, 19 Oct 2026 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792426248;
 bh=2kewMK/YAZVDDktwbCas0YurS0KhRhbpoCquV++/3ec=;
 h=Date:From:To:Cc:Subject;
 b=nxvHSDxSBB9nElTLl801oUkJhQoYmugXoowFMyWRLDiNDvWlhgigguKlOF8u/3ata
 jDLS5at3ttiVdUBkAH8NNjhWVAAW+Mv97le5S59PuR1qasU+PEX4QtZcNghF9phFNm
 X09RAKIwM4S/vBuqFmylvOE5+POKhtSOMbNU52/WyBHC7DJMMv1vyY+jIrnobl8hdd
 4cA5Z2QEbKL9JyaLD/tFl79yNqm/LfcWSIWKFAFcZEuxzQmqGdNS9Y6NHdcdL/TPjx
 N4IFwstME8nOm3Tf3y7bRo1YYn/qjgnB/9KgtV0bYf7ztFkmffO/2qkhPQbySoGsrN
 8wIslyBc1ajhA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id 1D2291AC57D0; Mon, 19 Oct 2026 17:10:46 +0100 (BST)
Date: Mon, 19 Oct 2026 17:10:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 luyuantao <luyuantao@kylinos.cn>, Simona Vetter <simona.vetter@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <atZBBqj4ON6kYWSK@sirena.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1uoxljRQ3xX7S+Yt"
Content-Disposition: inline
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--1uoxljRQ3xX7S+Yt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/drm_panic.c

between commits:

  1ba6405638439 ("drm/panic: Fix kmsg screen hang on a long log line")
  b537d87d2632c ("drm/panic: Fix the loop that causes kmsg to not display c=
orrectly")
  3706caf4da279 ("drm/panic: Accept a trailing newline in panic_screen")

=66rom the drm-misc-fixes tree and commit:

  5c3d323984fd1 ("drm/panic: Move panic display code into helper library")

=66rom the drm tree.  This obviously isn't the right merge, it drops the
fixes.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/drm_panic.c
index 5109bfd5d8891,9fe97c4eda6c8..0000000000000
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@@ -7,33 -7,23 +7,23 @@@
   */
 =20
  #include <linux/export.h>
- #include <linux/font.h>
- #include <linux/highmem.h>
  #include <linux/init.h>
- #include <linux/iosys-map.h>
  #include <linux/kdebug.h>
  #include <linux/kmsg_dump.h>
- #include <linux/linux_logo.h>
  #include <linux/list.h>
  #include <linux/math.h>
  #include <linux/module.h>
  #include <linux/overflow.h>
  #include <linux/printk.h>
  #include <linux/types.h>
- #include <linux/utsname.h>
- #include <linux/zlib.h>
 =20
  #include <drm/drm_drv.h>
- #include <drm/drm_fourcc.h>
- #include <drm/drm_framebuffer.h>
- #include <drm/drm_modeset_helper_vtables.h>
  #include <drm/drm_panic.h>
  #include <drm/drm_plane.h>
  #include <drm/drm_print.h>
- #include <drm/drm_rect.h>
 =20
  #include "drm_crtc_internal.h"
- #include "drm_draw_internal.h"
+ #include "drm_panic_internal.h"
 =20
  MODULE_AUTHOR("Jocelyn Falempe");
  MODULE_DESCRIPTION("DRM panic handler");
@@@ -42,789 -32,25 +32,25 @@@ MODULE_LICENSE("GPL")
  /**
   * DOC: overview
   *
-  * To enable DRM panic for a driver, the primary plane must implement a
-  * &drm_plane_helper_funcs.get_scanout_buffer helper function. It is then
-  * automatically registered to the drm panic handler.
-  * When a panic occurs, the &drm_plane_helper_funcs.get_scanout_buffer wi=
ll be
-  * called, and the driver can provide a framebuffer so the panic handler =
can
-  * draw the panic screen on it. Currently only linear buffer and a few co=
lor
-  * formats are supported.
-  * Optionally the driver can also provide a &drm_plane_helper_funcs.panic=
_flush
-  * callback, that will be called after that, to send additional commands =
to the
-  * hardware to make the scanout buffer visible.
-  */
-=20
- /*
-  * This module displays a user friendly message on screen when a kernel p=
anic
-  * occurs. This is conflicting with fbcon, so you can only enable it when=
 fbcon
-  * is disabled.
-  * It's intended for end-user, so have minimal technical/debug informatio=
n.
+  * This module displays a user friendly message on screen when a kernel
+  * panic occurs. It's intended for end users and therefore have minimal
+  * technical/debug information.
   *
-  * Implementation details:
+  * To enable DRM panic for a driver, the at least one primary plane must
+  * implement struct &drm_plane_funcs.display_panic_screen. The plane is
+  * then automatically registered to the drm panic handler.
   *
-  * It is a panic handler, so it can't take lock, allocate memory, run tas=
ks/irq,
-  * or attempt to sleep. It's a best effort, and it may not be able to dis=
play
-  * the message in all situations (like if the panic occurs in the middle =
of a
-  * modesetting).
-  * It will display only one static frame, so performance optimizations ar=
e low
-  * priority as the machine is already in an unusable state.
+  * When a panic occurs, the DRM panic handler calls struct
+  * &drm_plane_funcs.display_panic_screen. See
+  * drm_plane_helper_display_panic_screen() for a generic implementation.
   */
 =20
- struct drm_panic_line {
- 	u32 len;
- 	const char *txt;
- };
-=20
- #define PANIC_LINE(s) {.len =3D sizeof(s) - 1, .txt =3D s}
-=20
- static struct drm_panic_line panic_msg[] =3D {
- 	PANIC_LINE("KERNEL PANIC!"),
- 	PANIC_LINE(""),
- 	PANIC_LINE("Please reboot your computer."),
- 	PANIC_LINE(""),
- 	PANIC_LINE(""), /* will be replaced by the panic description */
- };
-=20
- static const size_t panic_msg_lines =3D ARRAY_SIZE(panic_msg);
-=20
- static const struct drm_panic_line logo_ascii[] =3D {
- 	PANIC_LINE("     .--.        _"),
- 	PANIC_LINE("    |o_o |      | |"),
- 	PANIC_LINE("    |:_/ |      | |"),
- 	PANIC_LINE("   //   \\ \\     |_|"),
- 	PANIC_LINE("  (|     | )     _"),
- 	PANIC_LINE(" /'\\_   _/`\\    (_)"),
- 	PANIC_LINE(" \\___)=3D(___/"),
- };
-=20
- static const size_t logo_ascii_lines =3D ARRAY_SIZE(logo_ascii);
-=20
- #if defined(CONFIG_LOGO) && !defined(MODULE)
- static const struct linux_logo *logo_mono;
-=20
- static int drm_panic_setup_logo(void)
- {
- 	const struct linux_logo *logo =3D fb_find_logo(1);
- 	const unsigned char *logo_data;
- 	struct linux_logo *logo_dup;
-=20
- 	if (!logo || logo->type !=3D LINUX_LOGO_MONO)
- 		return 0;
-=20
- 	/* The logo is __init, so we must make a copy for later use */
- 	logo_data =3D kmemdup(logo->data,
- 			    size_mul(DIV_ROUND_UP(logo->width, BITS_PER_BYTE), logo->height),
- 			    GFP_KERNEL);
- 	if (!logo_data)
- 		return -ENOMEM;
-=20
- 	logo_dup =3D kmemdup(logo, sizeof(*logo), GFP_KERNEL);
- 	if (!logo_dup) {
- 		kfree(logo_data);
- 		return -ENOMEM;
- 	}
-=20
- 	logo_dup->data =3D logo_data;
- 	logo_mono =3D logo_dup;
-=20
- 	return 0;
- }
-=20
- device_initcall(drm_panic_setup_logo);
- #else
- #define logo_mono	((const struct linux_logo *)NULL)
- #endif
-=20
- /*
-  *  Blit & Fill functions
-  */
- static void drm_panic_blit_pixel(struct drm_scanout_buffer *sb, struct dr=
m_rect *clip,
- 				 const u8 *sbuf8, unsigned int spitch, unsigned int scale,
- 				 u32 fg_color)
- {
- 	unsigned int y, x;
-=20
- 	for (y =3D 0; y < drm_rect_height(clip); y++)
- 		for (x =3D 0; x < drm_rect_width(clip); x++)
- 			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
- 				sb->set_pixel(sb, clip->x1 + x, clip->y1 + y, fg_color);
- }
-=20
- static void drm_panic_write_pixel16(void *vaddr, unsigned int offset, u16=
 color)
- {
- 	u16 *p =3D vaddr + offset;
-=20
- 	*p =3D color;
- }
-=20
- static void drm_panic_write_pixel24(void *vaddr, unsigned int offset, u32=
 color)
- {
- 	u8 *p =3D vaddr + offset;
-=20
- 	*p++ =3D color & 0xff;
- 	color >>=3D 8;
- 	*p++ =3D color & 0xff;
- 	color >>=3D 8;
- 	*p =3D color & 0xff;
- }
-=20
- /*
-  * Special case if the pixel crosses page boundaries
-  */
- static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_=
page,
- 					  unsigned int offset, u32 color)
- {
- 	u8 *vaddr2;
- 	u8 *p =3D vaddr + offset;
-=20
- 	vaddr2 =3D kmap_local_page_try_from_panic(next_page);
-=20
- 	*p++ =3D color & 0xff;
- 	color >>=3D 8;
-=20
- 	if (offset =3D=3D PAGE_SIZE - 1)
- 		p =3D vaddr2;
-=20
- 	*p++ =3D color & 0xff;
- 	color >>=3D 8;
-=20
- 	if (offset =3D=3D PAGE_SIZE - 2)
- 		p =3D vaddr2;
-=20
- 	*p =3D color & 0xff;
- 	kunmap_local(vaddr2);
- }
-=20
- static void drm_panic_write_pixel32(void *vaddr, unsigned int offset, u32=
 color)
- {
- 	u32 *p =3D vaddr + offset;
-=20
- 	*p =3D color;
- }
-=20
- static void drm_panic_write_pixel(void *vaddr, unsigned int offset, u32 c=
olor, unsigned int cpp)
- {
- 	switch (cpp) {
- 	case 2:
- 		drm_panic_write_pixel16(vaddr, offset, color);
- 		break;
- 	case 3:
- 		drm_panic_write_pixel24(vaddr, offset, color);
- 		break;
- 	case 4:
- 		drm_panic_write_pixel32(vaddr, offset, color);
- 		break;
- 	default:
- 		pr_debug_once("Can't blit with pixel width %d\n", cpp);
- 	}
- }
-=20
- /*
-  * The scanout buffer pages are not mapped, so for each pixel,
-  * use kmap_local_page_try_from_panic() to map the page, and write the pi=
xel.
-  * Try to keep the map from the previous pixel, to avoid too much map/unm=
ap.
-  */
- static void drm_panic_blit_page(struct page **pages, unsigned int dpitch,
- 				unsigned int cpp, const u8 *sbuf8,
- 				unsigned int spitch, struct drm_rect *clip,
- 				unsigned int scale, u32 fg32)
- {
- 	unsigned int y, x;
- 	unsigned int page =3D ~0;
- 	unsigned int height =3D drm_rect_height(clip);
- 	unsigned int width =3D drm_rect_width(clip);
- 	void *vaddr =3D NULL;
-=20
- 	for (y =3D 0; y < height; y++) {
- 		for (x =3D 0; x < width; x++) {
- 			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale)) {
- 				unsigned int new_page;
- 				unsigned int offset;
-=20
- 				offset =3D (y + clip->y1) * dpitch + (x + clip->x1) * cpp;
- 				new_page =3D offset >> PAGE_SHIFT;
- 				offset =3D offset % PAGE_SIZE;
- 				if (new_page !=3D page) {
- 					if (!pages[new_page])
- 						continue;
- 					if (vaddr)
- 						kunmap_local(vaddr);
- 					page =3D new_page;
- 					vaddr =3D kmap_local_page_try_from_panic(pages[page]);
- 				}
- 				if (!vaddr)
- 					continue;
-=20
- 				// Special case for 24bit, as a pixel might cross page boundaries
- 				if (cpp =3D=3D 3 && offset + 3 > PAGE_SIZE)
- 					drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
- 								      offset, fg32);
- 				else
- 					drm_panic_write_pixel(vaddr, offset, fg32, cpp);
- 			}
- 		}
- 	}
- 	if (vaddr)
- 		kunmap_local(vaddr);
- }
-=20
- /*
-  * drm_panic_blit - convert a monochrome image to a linear framebuffer
-  * @sb: destination scanout buffer
-  * @clip: destination rectangle
-  * @sbuf8: source buffer, in monochrome format, 8 pixels per byte.
-  * @spitch: source pitch in bytes
-  * @scale: integer scale, source buffer is scale time smaller than destin=
ation
-  *         rectangle
-  * @fg_color: foreground color, in destination format
-  *
-  * This can be used to draw a font character, which is a monochrome image=
, to a
-  * framebuffer in other supported format.
-  */
- static void drm_panic_blit(struct drm_scanout_buffer *sb, struct drm_rect=
 *clip,
- 			   const u8 *sbuf8, unsigned int spitch,
- 			   unsigned int scale, u32 fg_color)
-=20
- {
- 	struct iosys_map map;
-=20
- 	if (sb->set_pixel)
- 		return drm_panic_blit_pixel(sb, clip, sbuf8, spitch, scale, fg_color);
-=20
- 	if (sb->pages)
- 		return drm_panic_blit_page(sb->pages, sb->pitch[0], sb->format->cpp[0],
- 					   sbuf8, spitch, clip, scale, fg_color);
-=20
- 	map =3D sb->map[0];
- 	iosys_map_incr(&map, clip->y1 * sb->pitch[0] + clip->x1 * sb->format->cp=
p[0]);
-=20
- 	switch (sb->format->cpp[0]) {
- 	case 2:
- 		drm_draw_blit16(&map, sb->pitch[0], sbuf8, spitch,
- 				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
- 	break;
- 	case 3:
- 		drm_draw_blit24(&map, sb->pitch[0], sbuf8, spitch,
- 				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
- 	break;
- 	case 4:
- 		drm_draw_blit32(&map, sb->pitch[0], sbuf8, spitch,
- 				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
- 	break;
- 	default:
- 		WARN_ONCE(1, "Can't blit with pixel width %d\n", sb->format->cpp[0]);
- 	}
- }
-=20
- static void drm_panic_fill_pixel(struct drm_scanout_buffer *sb,
- 				 struct drm_rect *clip,
- 				 u32 color)
- {
- 	unsigned int y, x;
-=20
- 	for (y =3D 0; y < drm_rect_height(clip); y++)
- 		for (x =3D 0; x < drm_rect_width(clip); x++)
- 			sb->set_pixel(sb, clip->x1 + x, clip->y1 + y, color);
- }
-=20
- static void drm_panic_fill_page(struct page **pages, unsigned int dpitch,
- 				unsigned int cpp, struct drm_rect *clip,
- 				u32 color)
- {
- 	unsigned int y, x;
- 	unsigned int page =3D ~0;
- 	void *vaddr =3D NULL;
-=20
- 	for (y =3D clip->y1; y < clip->y2; y++) {
- 		for (x =3D clip->x1; x < clip->x2; x++) {
- 			unsigned int new_page;
- 			unsigned int offset;
-=20
- 			offset =3D y * dpitch + x * cpp;
- 			new_page =3D offset >> PAGE_SHIFT;
- 			offset =3D offset % PAGE_SIZE;
- 			if (new_page !=3D page) {
- 				if (vaddr)
- 					kunmap_local(vaddr);
- 				page =3D new_page;
- 				vaddr =3D kmap_local_page_try_from_panic(pages[page]);
- 			}
- 			if (!vaddr)
- 				continue;
-=20
- 			// Special case for 24bit, as a pixel might cross page boundaries
- 			if (cpp =3D=3D 3 && offset + 3 > PAGE_SIZE)
- 				drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
- 							      offset, color);
- 			else
- 				drm_panic_write_pixel(vaddr, offset, color, cpp);
- 		}
- 	}
- 	if (vaddr)
- 		kunmap_local(vaddr);
- }
-=20
- /*
-  * drm_panic_fill - Fill a rectangle with a color
-  * @sb: destination scanout buffer
-  * @clip: destination rectangle
-  * @color: foreground color, in destination format
-  *
-  * Fill a rectangle with a color, in a linear framebuffer.
-  */
- static void drm_panic_fill(struct drm_scanout_buffer *sb, struct drm_rect=
 *clip,
- 			   u32 color)
- {
- 	struct iosys_map map;
-=20
- 	if (sb->set_pixel)
- 		return drm_panic_fill_pixel(sb, clip, color);
-=20
- 	if (sb->pages)
- 		return drm_panic_fill_page(sb->pages, sb->pitch[0], sb->format->cpp[0],
- 					   clip, color);
-=20
- 	map =3D sb->map[0];
- 	iosys_map_incr(&map, clip->y1 * sb->pitch[0] + clip->x1 * sb->format->cp=
p[0]);
-=20
- 	switch (sb->format->cpp[0]) {
- 	case 2:
- 		drm_draw_fill16(&map, sb->pitch[0], drm_rect_height(clip),
- 				drm_rect_width(clip), color);
- 	break;
- 	case 3:
- 		drm_draw_fill24(&map, sb->pitch[0], drm_rect_height(clip),
- 				drm_rect_width(clip), color);
- 	break;
- 	case 4:
- 		drm_draw_fill32(&map, sb->pitch[0], drm_rect_height(clip),
- 				drm_rect_width(clip), color);
- 	break;
- 	default:
- 		WARN_ONCE(1, "Can't fill with pixel width %d\n", sb->format->cpp[0]);
- 	}
- }
-=20
- static unsigned int get_max_line_len(const struct drm_panic_line *lines, =
int len)
- {
- 	int i;
- 	unsigned int max =3D 0;
-=20
- 	for (i =3D 0; i < len; i++)
- 		max =3D max(lines[i].len, max);
- 	return max;
- }
-=20
- /*
-  * Draw a text in a rectangle on a framebuffer. The text is truncated if =
it overflows the rectangle
-  */
- static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
- 			       const struct font_desc *font,
- 			       const struct drm_panic_line *msg,
- 			       unsigned int msg_lines,
- 			       bool centered,
- 			       struct drm_rect *clip,
- 			       u32 color)
- {
- 	int i, j;
- 	const u8 *src;
- 	size_t font_pitch =3D DIV_ROUND_UP(font->width, 8);
- 	struct drm_rect rec;
-=20
- 	msg_lines =3D min(msg_lines,  drm_rect_height(clip) / font->height);
- 	for (i =3D 0; i < msg_lines; i++) {
- 		size_t line_len =3D min(msg[i].len, drm_rect_width(clip) / font->width);
-=20
- 		rec.y1 =3D clip->y1 +  i * font->height;
- 		rec.y2 =3D rec.y1 + font->height;
- 		rec.x1 =3D clip->x1;
-=20
- 		if (centered)
- 			rec.x1 +=3D (drm_rect_width(clip) - (line_len * font->width)) / 2;
-=20
- 		for (j =3D 0; j < line_len; j++) {
- 			src =3D font_data_glyph_buf(font->data, font->width, font->height,
- 						  (unsigned char)msg[i].txt[j]);
- 			rec.x2 =3D rec.x1 + font->width;
- 			if (src)
- 				drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
- 			rec.x1 +=3D font->width;
- 		}
- 	}
- }
-=20
- static void drm_panic_logo_rect(struct drm_rect *rect, const struct font_=
desc *font)
- {
- 	if (logo_mono) {
- 		drm_rect_init(rect, 0, 0, logo_mono->width, logo_mono->height);
- 	} else {
- 		int logo_width =3D get_max_line_len(logo_ascii, logo_ascii_lines) * fon=
t->width;
-=20
- 		drm_rect_init(rect, 0, 0, logo_width, logo_ascii_lines * font->height);
- 	}
- }
-=20
- static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm=
_rect *rect,
- 				const struct font_desc *font, u32 fg_color)
- {
- 	if (rect->x2 > sb->width || rect->y2 > sb->height)
- 		return;
-=20
- 	if (logo_mono)
- 		drm_panic_blit(sb, rect, logo_mono->data,
- 			       DIV_ROUND_UP(drm_rect_width(rect), 8), 1, fg_color);
- 	else
- 		draw_txt_rectangle(sb, font, logo_ascii, logo_ascii_lines, false, rect,
- 				   fg_color);
- }
-=20
- static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
- {
- 	u32 fg_color =3D drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUN=
D_COLOR,
- 						    sb->format->format);
- 	u32 bg_color =3D drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUN=
D_COLOR,
- 						    sb->format->format);
- 	const struct font_desc *font =3D get_default_font(sb->width, sb->height,=
 NULL, NULL);
- 	struct drm_rect r_screen, r_logo, r_msg;
- 	unsigned int msg_width, msg_height;
-=20
- 	if (!font)
- 		return;
-=20
- 	r_screen =3D DRM_RECT_INIT(0, 0, sb->width, sb->height);
- 	drm_panic_logo_rect(&r_logo, font);
-=20
- 	msg_width =3D min(get_max_line_len(panic_msg, panic_msg_lines) * font->w=
idth, sb->width);
- 	msg_height =3D min(panic_msg_lines * font->height, sb->height);
- 	r_msg =3D DRM_RECT_INIT(0, 0, msg_width, msg_height);
-=20
- 	/* Center the panic message */
- 	drm_rect_translate(&r_msg, (sb->width - r_msg.x2) / 2, (sb->height - r_m=
sg.y2) / 2);
-=20
- 	/* Fill with the background color, and draw text on top */
- 	drm_panic_fill(sb, &r_screen, bg_color);
-=20
- 	if (!drm_rect_overlap(&r_logo, &r_msg))
- 		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
-=20
- 	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, f=
g_color);
- }
-=20
- /*
-  * Draw one line of kmsg, and handle wrapping if it won't fit in the scre=
en width.
-  * Return the y-offset of the next line.
-  */
- static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struc=
t font_desc *font,
- 			       struct drm_panic_line *line, int yoffset, u32 fg_color)
- {
- 	int chars_per_row =3D sb->width / font->width;
- 	struct drm_rect r_txt =3D DRM_RECT_INIT(0, yoffset, sb->width, font->hei=
ght);
- 	struct drm_panic_line line_wrap;
-=20
- 	if (line->len > chars_per_row) {
- 		line_wrap.len =3D line->len % chars_per_row;
- 		line_wrap.txt =3D line->txt + line->len - line_wrap.len;
- 		draw_txt_rectangle(sb, font, &line_wrap, 1, false, &r_txt, fg_color);
- 		r_txt.y1 -=3D font->height;
- 		if (r_txt.y1 < 0)
- 			return r_txt.y1;
- 		while (line_wrap.txt > line->txt) {
- 			line_wrap.txt -=3D chars_per_row;
- 			line_wrap.len =3D chars_per_row;
- 			draw_txt_rectangle(sb, font, &line_wrap, 1, false, &r_txt, fg_color);
- 			r_txt.y1 -=3D font->height;
- 			if (r_txt.y1 < 0)
- 				return r_txt.y1;
- 		}
- 	} else {
- 		draw_txt_rectangle(sb, font, line, 1, false, &r_txt, fg_color);
- 		r_txt.y1 -=3D font->height;
- 	}
- 	return r_txt.y1;
- }
-=20
- /*
-  * Draw the kmsg buffer to the screen, starting from the youngest message=
 at the bottom,
-  * and going up until reaching the top of the screen.
-  */
- static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
- {
- 	u32 fg_color =3D drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUN=
D_COLOR,
- 						    sb->format->format);
- 	u32 bg_color =3D drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUN=
D_COLOR,
- 						    sb->format->format);
- 	const struct font_desc *font =3D get_default_font(sb->width, sb->height,=
 NULL, NULL);
- 	struct drm_rect r_screen =3D DRM_RECT_INIT(0, 0, sb->width, sb->height);
- 	struct kmsg_dump_iter iter;
- 	/* the size printk formats one record into, too big for the stack */
- 	static char kmsg_buf[2048];
- 	size_t kmsg_len;
- 	struct drm_panic_line line;
- 	int yoffset;
-=20
- 	if (!font || font->width > sb->width)
- 		return;
-=20
- 	yoffset =3D sb->height - font->height - (sb->height % font->height) / 2;
-=20
- 	/* Fill with the background color, and draw text on top */
- 	drm_panic_fill(sb, &r_screen, bg_color);
-=20
- 	kmsg_dump_rewind(&iter);
- 	while (yoffset >=3D 0 && kmsg_dump_get_buffer(&iter, false, kmsg_buf,
- 	       sizeof(kmsg_buf), &kmsg_len)) {
- 		char *start;
- 		char *end;
-=20
- 		/* a record that does not fit comes back empty, every time */
- 		if (!kmsg_len)
- 			break;
-=20
- 		/* ignore terminating NUL and newline */
- 		start =3D kmsg_buf + kmsg_len - 2;
- 		end =3D kmsg_buf + kmsg_len - 1;
- 		while (start > kmsg_buf && yoffset >=3D 0) {
- 			while (start > kmsg_buf && *start !=3D '\n')
- 				start--;
- 			/* don't count the newline character */
- 			line.txt =3D start + (start =3D=3D kmsg_buf ? 0 : 1);
- 			line.len =3D end - line.txt;
-=20
- 			yoffset =3D draw_line_with_wrap(sb, font, &line, yoffset, fg_color);
- 			end =3D start;
- 			start--;
- 		}
- 	}
- }
-=20
  #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
- /*
-  * It is unwise to allocate memory in the panic callback, so the buffers =
are
-  * pre-allocated. Only 2 buffers and the zlib workspace are needed.
-  * Two buffers are enough, using the following buffer usage:
-  * 1) kmsg messages are dumped in buffer1
-  * 2) kmsg is zlib-compressed into buffer2
-  * 3) compressed kmsg is encoded as QR-code Numeric stream in buffer1
-  * 4) QR-code image is generated in buffer2
-  * The Max QR code size is V40, 177x177, 4071 bytes for image, 2956 bytes=
 for
-  * data segments.
-  *
-  * Typically, ~7500 bytes of kmsg, are compressed into 2800 bytes, which =
fits in
-  * a V40 QR-code (177x177).
-  *
-  * If CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL is not set, the kmsg data will =
be put
-  * directly in the QR code.
-  * 1) kmsg messages are dumped in buffer1
-  * 2) kmsg message is encoded as byte stream in buffer2
-  * 3) QR-code image is generated in buffer1
-  */
-=20
  static uint panic_qr_version =3D CONFIG_DRM_PANIC_SCREEN_QR_VERSION;
  module_param(panic_qr_version, uint, 0644);
  MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code=
");
-=20
- #define MAX_QR_DATA 2956
- #define MAX_ZLIB_RATIO 3
- #define QR_BUFFER1_SIZE (MAX_ZLIB_RATIO * MAX_QR_DATA) /* Must also be > =
4071  */
- #define QR_BUFFER2_SIZE 4096
- #define QR_MARGIN	4	/* 4 modules of foreground color around the qr code */
-=20
- /* Compression parameters */
- #define COMPR_LEVEL 6
- #define WINDOW_BITS 12
- #define MEM_LEVEL 4
-=20
- static char *qrbuf1;
- static char *qrbuf2;
- static struct z_stream_s stream;
-=20
- static void __init drm_panic_qr_init(void)
- {
- 	qrbuf1 =3D kmalloc(QR_BUFFER1_SIZE, GFP_KERNEL);
- 	qrbuf2 =3D kmalloc(QR_BUFFER2_SIZE, GFP_KERNEL);
- 	stream.workspace =3D kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM=
_LEVEL),
- 				   GFP_KERNEL);
- }
-=20
- static void drm_panic_qr_exit(void)
- {
- 	kfree(qrbuf1);
- 	qrbuf1 =3D NULL;
- 	kfree(qrbuf2);
- 	qrbuf2 =3D NULL;
- 	kfree(stream.workspace);
- 	stream.workspace =3D NULL;
- }
-=20
- static int drm_panic_get_qr_code_url(u8 **qr_image)
- {
- 	struct kmsg_dump_iter iter;
- 	char url[256];
- 	size_t kmsg_len, max_kmsg_size;
- 	char *kmsg;
- 	int max_qr_data_size, url_len;
-=20
- 	url_len =3D snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_U=
RL "?a=3D%s&v=3D%s&z=3D",
- 			   utsname()->machine, utsname()->release);
-=20
- 	max_qr_data_size =3D drm_panic_qr_max_data_size(panic_qr_version, url_le=
n);
- 	max_kmsg_size =3D min(MAX_ZLIB_RATIO * max_qr_data_size, QR_BUFFER1_SIZE=
);
-=20
- 	/* get kmsg to buffer 1 */
- 	kmsg_dump_rewind(&iter);
- 	kmsg_dump_get_buffer(&iter, false, qrbuf1, max_kmsg_size, &kmsg_len);
-=20
- 	if (!kmsg_len)
- 		return -ENODATA;
- 	kmsg =3D qrbuf1;
-=20
- try_again:
- 	if (zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
- 			      MEM_LEVEL, Z_DEFAULT_STRATEGY) !=3D Z_OK)
- 		return -EINVAL;
-=20
- 	stream.next_in =3D kmsg;
- 	stream.avail_in =3D kmsg_len;
- 	stream.total_in =3D 0;
- 	stream.next_out =3D qrbuf2;
- 	stream.avail_out =3D QR_BUFFER2_SIZE;
- 	stream.total_out =3D 0;
-=20
- 	if (zlib_deflate(&stream, Z_FINISH) !=3D Z_STREAM_END)
- 		return -EINVAL;
-=20
- 	if (zlib_deflateEnd(&stream) !=3D Z_OK)
- 		return -EINVAL;
-=20
- 	if (stream.total_out > max_qr_data_size) {
- 		/* too much data for the QR code, so skip the first line and try again =
*/
- 		kmsg =3D strchr(kmsg, '\n');
- 		if (!kmsg)
- 			return -EINVAL;
- 		/* skip the first \n */
- 		kmsg +=3D 1;
- 		kmsg_len =3D strlen(kmsg);
- 		goto try_again;
- 	}
- 	*qr_image =3D qrbuf2;
-=20
- 	/* generate qr code image in buffer2 */
- 	return drm_panic_qr_generate(url, qrbuf2, stream.total_out, QR_BUFFER2_S=
IZE,
- 				     qrbuf1, QR_BUFFER1_SIZE);
- }
-=20
- static int drm_panic_get_qr_code_raw(u8 **qr_image)
- {
- 	struct kmsg_dump_iter iter;
- 	size_t kmsg_len;
- 	size_t max_kmsg_size =3D min(drm_panic_qr_max_data_size(panic_qr_version=
, 0),
- 				   QR_BUFFER1_SIZE);
-=20
- 	kmsg_dump_rewind(&iter);
- 	kmsg_dump_get_buffer(&iter, false, qrbuf1, max_kmsg_size, &kmsg_len);
- 	if (!kmsg_len)
- 		return -ENODATA;
-=20
- 	*qr_image =3D qrbuf1;
- 	return drm_panic_qr_generate(NULL, qrbuf1, kmsg_len, QR_BUFFER1_SIZE,
- 				     qrbuf2, QR_BUFFER2_SIZE);
- }
-=20
- static int drm_panic_get_qr_code(u8 **qr_image)
- {
- 	if (strlen(CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL) > 0)
- 		return drm_panic_get_qr_code_url(qr_image);
- 	else
- 		return drm_panic_get_qr_code_raw(qr_image);
- }
-=20
- /*
-  * Draw the panic message at the center of the screen, with a QR Code
-  */
- static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
- {
- 	u32 fg_color =3D drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUN=
D_COLOR,
- 						    sb->format->format);
- 	u32 bg_color =3D drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUN=
D_COLOR,
- 						    sb->format->format);
- 	const struct font_desc *font =3D get_default_font(sb->width, sb->height,=
 NULL, NULL);
- 	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
- 	unsigned int max_qr_size, scale;
- 	unsigned int msg_width, msg_height;
- 	int qr_width, qr_canvas_width, qr_pitch, v_margin;
- 	u8 *qr_image;
-=20
- 	if (!font || !qrbuf1 || !qrbuf2 || !stream.workspace)
- 		return -ENOMEM;
-=20
- 	r_screen =3D DRM_RECT_INIT(0, 0, sb->width, sb->height);
-=20
- 	drm_panic_logo_rect(&r_logo, font);
-=20
- 	msg_width =3D min(get_max_line_len(panic_msg, panic_msg_lines) * font->w=
idth, sb->width);
- 	msg_height =3D min(panic_msg_lines * font->height, sb->height);
- 	r_msg =3D DRM_RECT_INIT(0, 0, msg_width, msg_height);
-=20
- 	max_qr_size =3D min(3 * sb->width / 4, 3 * sb->height / 4);
-=20
- 	qr_width =3D drm_panic_get_qr_code(&qr_image);
- 	if (qr_width <=3D 0)
- 		return -ENOSPC;
-=20
- 	qr_canvas_width =3D qr_width + QR_MARGIN * 2;
- 	scale =3D max_qr_size / qr_canvas_width;
- 	/* QR code is not readable if not scaled at least by 2 */
- 	if (scale < 2)
- 		return -ENOSPC;
-=20
- 	pr_debug("QR width %d and scale %d\n", qr_width, scale);
- 	r_qr_canvas =3D DRM_RECT_INIT(0, 0, qr_canvas_width * scale, qr_canvas_w=
idth * scale);
-=20
- 	v_margin =3D sb->height - drm_rect_height(&r_qr_canvas) - drm_rect_heigh=
t(&r_msg);
- 	if (v_margin < 0)
- 		return -ENOSPC;
- 	v_margin /=3D 5;
-=20
- 	drm_rect_translate(&r_qr_canvas, (sb->width - r_qr_canvas.x2) / 2, 2 * v=
_margin);
- 	r_qr =3D DRM_RECT_INIT(r_qr_canvas.x1 + QR_MARGIN * scale, r_qr_canvas.y=
1 + QR_MARGIN * scale,
- 			     qr_width * scale, qr_width * scale);
-=20
- 	/* Center the panic message */
- 	drm_rect_translate(&r_msg, (sb->width - r_msg.x2) / 2,
- 			   3 * v_margin + drm_rect_height(&r_qr_canvas));
-=20
- 	/* Fill with the background color, and draw text on top */
- 	drm_panic_fill(sb, &r_screen, bg_color);
-=20
- 	if (!drm_rect_overlap(&r_logo, &r_msg) && !drm_rect_overlap(&r_logo, &r_=
qr_canvas))
- 		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
-=20
- 	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, f=
g_color);
-=20
- 	/* Draw the qr code */
- 	qr_pitch =3D DIV_ROUND_UP(qr_width, 8);
- 	drm_panic_fill(sb, &r_qr_canvas, fg_color);
- 	drm_panic_fill(sb, &r_qr, bg_color);
- 	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
- 	return 0;
- }
-=20
- static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
- {
- 	if (_draw_panic_screen_qr_code(sb))
- 		draw_panic_screen_user(sb);
- }
- #else
- static void drm_panic_qr_init(void) {};
- static void drm_panic_qr_exit(void) {};
  #endif
 =20
- enum drm_panic_type {
- 	DRM_PANIC_TYPE_KMSG,
- 	DRM_PANIC_TYPE_USER,
- 	DRM_PANIC_TYPE_QR,
- };
-=20
  static enum drm_panic_type drm_panic_type =3D -1;
 =20
  static const char *drm_panic_type_map[] =3D {
@@@ -840,7 -66,7 +66,7 @@@ static int drm_panic_type_set(const cha
  	unsigned int i;
 =20
  	for (i =3D 0; i < ARRAY_SIZE(drm_panic_type_map); i++) {
 -		if (!strcmp(val, drm_panic_type_map[i])) {
 +		if (sysfs_streq(val, drm_panic_type_map[i])) {
  			drm_panic_type =3D i;
  			return 0;
  		}
@@@ -869,91 -95,34 +95,34 @@@ MODULE_PARM_DESC(panic_screen
  #endif
  		 CONFIG_DRM_PANIC_SCREEN "]");
 =20
- /*
-  * drm_panic_is_format_supported()
-  * @format: a fourcc color code
-  * Returns: true if supported, false otherwise.
-  *
-  * Check if drm_panic will be able to use this color format.
-  */
- static bool drm_panic_is_format_supported(const struct drm_format_info *f=
ormat)
- {
- 	if (format->num_planes !=3D 1)
- 		return false;
- 	return drm_draw_can_convert_from_xrgb8888(format->format);
- }
+ #define drm_panic_trylock(dev, flags) \
+ 	raw_spin_trylock_irqsave(&(dev)->mode_config.panic_lock, flags)
 =20
- static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
+ static void drm_panic_display_panic_screen(struct drm_plane *plane, const=
 char *description)
  {
- 	switch (drm_panic_type) {
- 	case DRM_PANIC_TYPE_KMSG:
- 		draw_panic_screen_kmsg(sb);
- 		break;
-=20
- #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
- 	case DRM_PANIC_TYPE_QR:
- 		draw_panic_screen_qr_code(sb);
- 		break;
+ #if defined(CONFIG_DRM_PANIC_FOREGROUND_COLOR)
+ 	u32 fg_color =3D CONFIG_DRM_PANIC_FOREGROUND_COLOR;
+ #else
+ 	u32 fg_color =3D 0x00ffffff;
  #endif
-=20
- 	case DRM_PANIC_TYPE_USER:
- 	default:
- 		draw_panic_screen_user(sb);
- 	}
- }
-=20
- static void drm_panic_set_description(const char *description)
- {
- 	u32 len;
-=20
- 	if (description) {
- 		struct drm_panic_line *desc_line =3D &panic_msg[panic_msg_lines - 1];
-=20
- 		desc_line->txt =3D description;
- 		len =3D strlen(description);
- 		/* ignore the last newline character */
- 		if (len && description[len - 1] =3D=3D '\n')
- 			len -=3D 1;
- 		desc_line->len =3D len;
- 	}
- }
-=20
- static void drm_panic_clear_description(void)
- {
- 	struct drm_panic_line *desc_line =3D &panic_msg[panic_msg_lines - 1];
-=20
- 	desc_line->len =3D 0;
- 	desc_line->txt =3D NULL;
- }
-=20
- static void draw_panic_plane(struct drm_plane *plane, const char *descrip=
tion)
- {
- 	struct drm_scanout_buffer sb =3D { };
- 	int ret;
+ #if defined(CONFIG_DRM_PANIC_BACKGROUND_COLOR)
+ 	u32 bg_color =3D CONFIG_DRM_PANIC_BACKGROUND_COLOR;
+ #else
+ 	u32 bg_color =3D 0x00000000;
+ #endif
+ #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+ 	unsigned int qr_version =3D panic_qr_version;
+ #else
+ 	unsigned int qr_version =3D 0;
+ #endif
+ 	struct drm_device *dev =3D plane->dev;
  	unsigned long flags;
 =20
- 	if (!drm_panic_trylock(plane->dev, flags))
- 		return;
-=20
- 	ret =3D plane->helper_private->get_scanout_buffer(plane, &sb);
-=20
- 	if (ret || !drm_panic_is_format_supported(sb.format))
- 		goto unlock;
-=20
- 	/* One of these should be set, or it can't draw pixels */
- 	if (!sb.set_pixel && !sb.pages && iosys_map_is_null(&sb.map[0]))
- 		goto unlock;
-=20
- 	drm_panic_set_description(description);
-=20
- 	draw_panic_dispatch(&sb);
- 	if (plane->helper_private->panic_flush)
- 		plane->helper_private->panic_flush(plane);
-=20
- 	drm_panic_clear_description();
-=20
- unlock:
- 	drm_panic_unlock(plane->dev, flags);
+ 	if (drm_panic_trylock(dev, flags)) {
+ 		plane->funcs->display_panic_screen(plane, description, drm_panic_type,
+ 						   fg_color, bg_color, qr_version);
+ 		drm_panic_unlock(dev, flags);
+ 	}
  }
 =20
  static struct drm_plane *to_drm_plane(struct kmsg_dumper *kd)
@@@ -966,10 -135,9 +135,9 @@@ static void drm_panic(struct kmsg_dumpe
  	struct drm_plane *plane =3D to_drm_plane(dumper);
 =20
  	if (detail->reason =3D=3D KMSG_DUMP_PANIC)
- 		draw_panic_plane(plane, detail->description);
+ 		drm_panic_display_panic_screen(plane, detail->description);
  }
 =20
-=20
  /*
   * DEBUG FS, This is currently unsafe.
   * Create one file per plane, so it's possible to debug one plane at a ti=
me.
@@@ -986,7 -154,7 +154,7 @@@ static ssize_t debugfs_trigger_write(st
  	if (kstrtobool_from_user(user_buf, count, &run) =3D=3D 0 && run) {
  		struct drm_plane *plane =3D file->private_data;
 =20
- 		draw_panic_plane(plane, "Test from debugfs");
+ 		drm_panic_display_panic_screen(plane, "Test from debugfs");
  	}
  	return count;
  }
@@@ -1022,9 -190,13 +190,13 @@@ bool drm_panic_is_enabled(struct drm_de
  	if (!dev->mode_config.num_total_plane)
  		return false;
 =20
- 	drm_for_each_plane(plane, dev)
- 		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
- 			return true;
+ 	drm_for_each_plane(plane, dev) {
+ 		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
+ 			continue;
+ 		if (!plane->funcs || !plane->funcs->display_panic_screen)
+ 			continue;
+ 		return true;
+ 	}
  	return false;
  }
  EXPORT_SYMBOL(drm_panic_is_enabled);
@@@ -1042,7 -214,9 +214,9 @@@ void drm_panic_register(struct drm_devi
  		return;
 =20
  	drm_for_each_plane(plane, dev) {
- 		if (!plane->helper_private || !plane->helper_private->get_scanout_buffe=
r)
+ 		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
+ 			continue;
+ 		if (!plane->funcs || !plane->funcs->display_panic_screen)
  			continue;
  		plane->kmsg_panic.dump =3D drm_panic;
  		plane->kmsg_panic.max_reason =3D KMSG_DUMP_PANIC;
@@@ -1069,7 -243,9 +243,9 @@@ void drm_panic_unregister(struct drm_de
  		return;
 =20
  	drm_for_each_plane(plane, dev) {
- 		if (!plane->helper_private || !plane->helper_private->get_scanout_buffe=
r)
+ 		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
+ 			continue;
+ 		if (!plane->funcs || !plane->funcs->display_panic_screen)
  			continue;
  		kmsg_dump_unregister(&plane->kmsg_panic);
  	}
@@@ -1085,17 -261,4 +261,4 @@@ void __init drm_panic_init(void
  			CONFIG_DRM_PANIC_SCREEN);
  		drm_panic_type =3D DRM_PANIC_TYPE_USER;
  	}
- 	drm_panic_qr_init();
  }
-=20
- /**
-  * drm_panic_exit() - Free the resources taken by drm_panic_exit()
-  */
- void drm_panic_exit(void)
- {
- 	drm_panic_qr_exit();
- }
-=20
- #ifdef CONFIG_DRM_KUNIT_TEST
- #include "tests/drm_panic_test.c"
- #endif

--1uoxljRQ3xX7S+Yt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatZBBQAKCRAv73Ows9A4
iVwPAP9NZy71TLZPRCsXYoSR2r8eJo18cdNhYnQcGkgD7aPrjgD+MjHoUfsEpEkm
hhIPzby7BHOGEp7w31SxznDR7ASgLgM=
=IUOH
-----END PGP SIGNATURE-----

--1uoxljRQ3xX7S+Yt--
