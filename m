Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D7606A331
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I42rijCU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BC310F2C7;
	Tue, 20 Oct 2026 07:30:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD45610F2C7
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792481428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6llxhW9oEyefukhLAVR7SUF7vUL3E14Y7sbNFkf92U=;
 b=I42rijCUnoI1jBlFkPqLLrz88l89vTJSDnnMA49M7RkYbkrf8IE4kkKfVORGeS9ImsFpK1
 m87x+QlYexmv+xd2KE3ZSAJo0d2/QlXgyfZpGggxWYE3SND5P0/3wtjL1vS+pEzwp9eF9u
 lyJ1ICv8T/TxHXeISS5/Eb+z8idQjk8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-nYQBJ5skORyNqyDAK-NcVQ-1; Tue, 20 Oct 2026 07:30:26 +0000
X-MC-Unique: nYQBJ5skORyNqyDAK-NcVQ-1
X-Mimecast-MFC-AGG-ID: nYQBJ5skORyNqyDAK-NcVQ_1792481425
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48c415561aaso1967978f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 00:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792481425; x=1793086225;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h6llxhW9oEyefukhLAVR7SUF7vUL3E14Y7sbNFkf92U=;
 b=CHobw6DyLMKjQUQDdgSY9hywqyg7/U0AkmjuwL95qbVStqLFg23FOMdUoiVuoJNn2a
 aJ2qRLGbosJWA/FzT3fFp2MfPtdoO/3DDWe81BmmSfw/cHNMthttzMCmF7iufXI7T8lj
 2Db1AUzii7e+Q6MFY5J6Kgh57DLwmgiDyNinN5VNHBZGmVWDiFupfd9wj5SbYEiaWoBx
 sjOCTLXwMJU1kO3FijWKFqBK3fTw0IdPsd5LCrSCKntB3HB6yhCWeJdhHQyTNyNSZe8S
 DT7eNaYG1eC2mQ9WXupq2gJXOgTlyewqwqgln8xQQhT8+H0SW4vjGHhpWkOA7wEz6hj9
 ZoDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4kTJ4zbL61FsLSEDI29zOChbTykjznu5fzJqtykOU8pbrYkDPZtQe2C+xcFBpAYWuR8+wHp8WPGY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJUDyOjeeMr/4n+6VYzx2Ne1GnicfzQkbq5VeKqISZ/A1QZc7js
 49inG1fXq4B6W+y6ZoHc+cZDKUSqPcrYUMwkt8hq7jCyBBA2e2rzXxOjtnKCK2Sgp5KnIscPZXl
 T+TchUhCr8N46TIL6CMMJd6FXTEkY246YCzQj45cS/nXqOD3rMPqei3RP9NH/+5Dm8rZj7g==
X-Gm-Gg: AYBFou30CgpCj9pkj6Yz1tiiC0s9L/nZG/dfPt+iu4ydVbxFyv7Su7mvj3Sdv4q/Pcv
 KFjm7D6GpuOT5erkryFDYje/EL9V5qBA0+v8zkF7o/5uJeSsQAD2M3NpmcMS0UrtKtzZxAlzEod
 8QCa/FSg9YkPhadTHIfBFAgFjado7G5d1xuzvx1kr1GvJFKADI9sotZP8OOIl3oIN4iFFvlZOem
 FGN8H8qzVOKd2YeP56Pw/vzhPEp/QnmO6JehhGH6kqFHmMR0OuFQf+Id4nhsfFUgeEh2PufHzTw
 DiSswSnBYDOCTm/8HH2oYXMvUFaGUnxc3H+/mB/dSlLk1dWLphExK137oNZ2Of1WH+zqWN6Hg5U
 QyTQ4h4IswqO3PjiXKGhU65HiFhT4pKADEc8j+HCT1kR7
X-Received: by 2002:a05:600c:4f47:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4a1e0db8f0amr199306835e9.3.1792481424905; 
 Tue, 20 Oct 2026 00:30:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4f47:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4a1e0db8f0amr199306195e9.3.1792481424290; 
 Tue, 20 Oct 2026 00:30:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9b4:d000:5461:505a:9dad:66db?
 ([2a01:e0a:9b4:d000:5461:505a:9dad:66db])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d57ef7sm65581055e9.11.2026.10.20.00.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 00:30:23 -0700 (PDT)
Message-ID: <4cb04699-c607-4f20-be66-0d8e21666af5@redhat.com>
Date: Tue, 20 Oct 2026 09:30:12 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
To: Mark Brown <broonie@kernel.org>, Dave Airlie <airlied@redhat.com>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 luyuantao <luyuantao@kylinos.cn>, Simona Vetter <simona.vetter@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <atZBBqj4ON6kYWSK@sirena.co.uk>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <atZBBqj4ON6kYWSK@sirena.co.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YfM42VCZGIwxjImUny6g_t5KsdzJ2cBm_U9tvnf10_0_1792481425
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 18:10, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the drm tree got a conflict in:
> 
>    drivers/gpu/drm/drm_panic.c
> 
> between commits:
> 
>    1ba6405638439 ("drm/panic: Fix kmsg screen hang on a long log line")
>    b537d87d2632c ("drm/panic: Fix the loop that causes kmsg to not display correctly")
>    3706caf4da279 ("drm/panic: Accept a trailing newline in panic_screen")
> 
> from the drm-misc-fixes tree and commit:
> 
>    5c3d323984fd1 ("drm/panic: Move panic display code into helper library")
> 
> from the drm tree.  This obviously isn't the right merge, it drops the
> fixes.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Sorry, normally I fixed this conflict in drm-tip, but maybe I missed 
something.
Devin has the right conflict resolution, some of the code has moved to 
drm_panic_helper.c, and two of the 3 commits should be applied there.

Best regards,

-- 

Jocelyn

> 
> diff --combined drivers/gpu/drm/drm_panic.c
> index 5109bfd5d8891,9fe97c4eda6c8..0000000000000
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@@ -7,33 -7,23 +7,23 @@@
>     */
>    
>    #include <linux/export.h>
> - #include <linux/font.h>
> - #include <linux/highmem.h>
>    #include <linux/init.h>
> - #include <linux/iosys-map.h>
>    #include <linux/kdebug.h>
>    #include <linux/kmsg_dump.h>
> - #include <linux/linux_logo.h>
>    #include <linux/list.h>
>    #include <linux/math.h>
>    #include <linux/module.h>
>    #include <linux/overflow.h>
>    #include <linux/printk.h>
>    #include <linux/types.h>
> - #include <linux/utsname.h>
> - #include <linux/zlib.h>
>    
>    #include <drm/drm_drv.h>
> - #include <drm/drm_fourcc.h>
> - #include <drm/drm_framebuffer.h>
> - #include <drm/drm_modeset_helper_vtables.h>
>    #include <drm/drm_panic.h>
>    #include <drm/drm_plane.h>
>    #include <drm/drm_print.h>
> - #include <drm/drm_rect.h>
>    
>    #include "drm_crtc_internal.h"
> - #include "drm_draw_internal.h"
> + #include "drm_panic_internal.h"
>    
>    MODULE_AUTHOR("Jocelyn Falempe");
>    MODULE_DESCRIPTION("DRM panic handler");
> @@@ -42,789 -32,25 +32,25 @@@ MODULE_LICENSE("GPL")
>    /**
>     * DOC: overview
>     *
> -  * To enable DRM panic for a driver, the primary plane must implement a
> -  * &drm_plane_helper_funcs.get_scanout_buffer helper function. It is then
> -  * automatically registered to the drm panic handler.
> -  * When a panic occurs, the &drm_plane_helper_funcs.get_scanout_buffer will be
> -  * called, and the driver can provide a framebuffer so the panic handler can
> -  * draw the panic screen on it. Currently only linear buffer and a few color
> -  * formats are supported.
> -  * Optionally the driver can also provide a &drm_plane_helper_funcs.panic_flush
> -  * callback, that will be called after that, to send additional commands to the
> -  * hardware to make the scanout buffer visible.
> -  */
> -
> - /*
> -  * This module displays a user friendly message on screen when a kernel panic
> -  * occurs. This is conflicting with fbcon, so you can only enable it when fbcon
> -  * is disabled.
> -  * It's intended for end-user, so have minimal technical/debug information.
> +  * This module displays a user friendly message on screen when a kernel
> +  * panic occurs. It's intended for end users and therefore have minimal
> +  * technical/debug information.
>     *
> -  * Implementation details:
> +  * To enable DRM panic for a driver, the at least one primary plane must
> +  * implement struct &drm_plane_funcs.display_panic_screen. The plane is
> +  * then automatically registered to the drm panic handler.
>     *
> -  * It is a panic handler, so it can't take lock, allocate memory, run tasks/irq,
> -  * or attempt to sleep. It's a best effort, and it may not be able to display
> -  * the message in all situations (like if the panic occurs in the middle of a
> -  * modesetting).
> -  * It will display only one static frame, so performance optimizations are low
> -  * priority as the machine is already in an unusable state.
> +  * When a panic occurs, the DRM panic handler calls struct
> +  * &drm_plane_funcs.display_panic_screen. See
> +  * drm_plane_helper_display_panic_screen() for a generic implementation.
>     */
>    
> - struct drm_panic_line {
> - 	u32 len;
> - 	const char *txt;
> - };
> -
> - #define PANIC_LINE(s) {.len = sizeof(s) - 1, .txt = s}
> -
> - static struct drm_panic_line panic_msg[] = {
> - 	PANIC_LINE("KERNEL PANIC!"),
> - 	PANIC_LINE(""),
> - 	PANIC_LINE("Please reboot your computer."),
> - 	PANIC_LINE(""),
> - 	PANIC_LINE(""), /* will be replaced by the panic description */
> - };
> -
> - static const size_t panic_msg_lines = ARRAY_SIZE(panic_msg);
> -
> - static const struct drm_panic_line logo_ascii[] = {
> - 	PANIC_LINE("     .--.        _"),
> - 	PANIC_LINE("    |o_o |      | |"),
> - 	PANIC_LINE("    |:_/ |      | |"),
> - 	PANIC_LINE("   //   \\ \\     |_|"),
> - 	PANIC_LINE("  (|     | )     _"),
> - 	PANIC_LINE(" /'\\_   _/`\\    (_)"),
> - 	PANIC_LINE(" \\___)=(___/"),
> - };
> -
> - static const size_t logo_ascii_lines = ARRAY_SIZE(logo_ascii);
> -
> - #if defined(CONFIG_LOGO) && !defined(MODULE)
> - static const struct linux_logo *logo_mono;
> -
> - static int drm_panic_setup_logo(void)
> - {
> - 	const struct linux_logo *logo = fb_find_logo(1);
> - 	const unsigned char *logo_data;
> - 	struct linux_logo *logo_dup;
> -
> - 	if (!logo || logo->type != LINUX_LOGO_MONO)
> - 		return 0;
> -
> - 	/* The logo is __init, so we must make a copy for later use */
> - 	logo_data = kmemdup(logo->data,
> - 			    size_mul(DIV_ROUND_UP(logo->width, BITS_PER_BYTE), logo->height),
> - 			    GFP_KERNEL);
> - 	if (!logo_data)
> - 		return -ENOMEM;
> -
> - 	logo_dup = kmemdup(logo, sizeof(*logo), GFP_KERNEL);
> - 	if (!logo_dup) {
> - 		kfree(logo_data);
> - 		return -ENOMEM;
> - 	}
> -
> - 	logo_dup->data = logo_data;
> - 	logo_mono = logo_dup;
> -
> - 	return 0;
> - }
> -
> - device_initcall(drm_panic_setup_logo);
> - #else
> - #define logo_mono	((const struct linux_logo *)NULL)
> - #endif
> -
> - /*
> -  *  Blit & Fill functions
> -  */
> - static void drm_panic_blit_pixel(struct drm_scanout_buffer *sb, struct drm_rect *clip,
> - 				 const u8 *sbuf8, unsigned int spitch, unsigned int scale,
> - 				 u32 fg_color)
> - {
> - 	unsigned int y, x;
> -
> - 	for (y = 0; y < drm_rect_height(clip); y++)
> - 		for (x = 0; x < drm_rect_width(clip); x++)
> - 			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
> - 				sb->set_pixel(sb, clip->x1 + x, clip->y1 + y, fg_color);
> - }
> -
> - static void drm_panic_write_pixel16(void *vaddr, unsigned int offset, u16 color)
> - {
> - 	u16 *p = vaddr + offset;
> -
> - 	*p = color;
> - }
> -
> - static void drm_panic_write_pixel24(void *vaddr, unsigned int offset, u32 color)
> - {
> - 	u8 *p = vaddr + offset;
> -
> - 	*p++ = color & 0xff;
> - 	color >>= 8;
> - 	*p++ = color & 0xff;
> - 	color >>= 8;
> - 	*p = color & 0xff;
> - }
> -
> - /*
> -  * Special case if the pixel crosses page boundaries
> -  */
> - static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_page,
> - 					  unsigned int offset, u32 color)
> - {
> - 	u8 *vaddr2;
> - 	u8 *p = vaddr + offset;
> -
> - 	vaddr2 = kmap_local_page_try_from_panic(next_page);
> -
> - 	*p++ = color & 0xff;
> - 	color >>= 8;
> -
> - 	if (offset == PAGE_SIZE - 1)
> - 		p = vaddr2;
> -
> - 	*p++ = color & 0xff;
> - 	color >>= 8;
> -
> - 	if (offset == PAGE_SIZE - 2)
> - 		p = vaddr2;
> -
> - 	*p = color & 0xff;
> - 	kunmap_local(vaddr2);
> - }
> -
> - static void drm_panic_write_pixel32(void *vaddr, unsigned int offset, u32 color)
> - {
> - 	u32 *p = vaddr + offset;
> -
> - 	*p = color;
> - }
> -
> - static void drm_panic_write_pixel(void *vaddr, unsigned int offset, u32 color, unsigned int cpp)
> - {
> - 	switch (cpp) {
> - 	case 2:
> - 		drm_panic_write_pixel16(vaddr, offset, color);
> - 		break;
> - 	case 3:
> - 		drm_panic_write_pixel24(vaddr, offset, color);
> - 		break;
> - 	case 4:
> - 		drm_panic_write_pixel32(vaddr, offset, color);
> - 		break;
> - 	default:
> - 		pr_debug_once("Can't blit with pixel width %d\n", cpp);
> - 	}
> - }
> -
> - /*
> -  * The scanout buffer pages are not mapped, so for each pixel,
> -  * use kmap_local_page_try_from_panic() to map the page, and write the pixel.
> -  * Try to keep the map from the previous pixel, to avoid too much map/unmap.
> -  */
> - static void drm_panic_blit_page(struct page **pages, unsigned int dpitch,
> - 				unsigned int cpp, const u8 *sbuf8,
> - 				unsigned int spitch, struct drm_rect *clip,
> - 				unsigned int scale, u32 fg32)
> - {
> - 	unsigned int y, x;
> - 	unsigned int page = ~0;
> - 	unsigned int height = drm_rect_height(clip);
> - 	unsigned int width = drm_rect_width(clip);
> - 	void *vaddr = NULL;
> -
> - 	for (y = 0; y < height; y++) {
> - 		for (x = 0; x < width; x++) {
> - 			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale)) {
> - 				unsigned int new_page;
> - 				unsigned int offset;
> -
> - 				offset = (y + clip->y1) * dpitch + (x + clip->x1) * cpp;
> - 				new_page = offset >> PAGE_SHIFT;
> - 				offset = offset % PAGE_SIZE;
> - 				if (new_page != page) {
> - 					if (!pages[new_page])
> - 						continue;
> - 					if (vaddr)
> - 						kunmap_local(vaddr);
> - 					page = new_page;
> - 					vaddr = kmap_local_page_try_from_panic(pages[page]);
> - 				}
> - 				if (!vaddr)
> - 					continue;
> -
> - 				// Special case for 24bit, as a pixel might cross page boundaries
> - 				if (cpp == 3 && offset + 3 > PAGE_SIZE)
> - 					drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
> - 								      offset, fg32);
> - 				else
> - 					drm_panic_write_pixel(vaddr, offset, fg32, cpp);
> - 			}
> - 		}
> - 	}
> - 	if (vaddr)
> - 		kunmap_local(vaddr);
> - }
> -
> - /*
> -  * drm_panic_blit - convert a monochrome image to a linear framebuffer
> -  * @sb: destination scanout buffer
> -  * @clip: destination rectangle
> -  * @sbuf8: source buffer, in monochrome format, 8 pixels per byte.
> -  * @spitch: source pitch in bytes
> -  * @scale: integer scale, source buffer is scale time smaller than destination
> -  *         rectangle
> -  * @fg_color: foreground color, in destination format
> -  *
> -  * This can be used to draw a font character, which is a monochrome image, to a
> -  * framebuffer in other supported format.
> -  */
> - static void drm_panic_blit(struct drm_scanout_buffer *sb, struct drm_rect *clip,
> - 			   const u8 *sbuf8, unsigned int spitch,
> - 			   unsigned int scale, u32 fg_color)
> -
> - {
> - 	struct iosys_map map;
> -
> - 	if (sb->set_pixel)
> - 		return drm_panic_blit_pixel(sb, clip, sbuf8, spitch, scale, fg_color);
> -
> - 	if (sb->pages)
> - 		return drm_panic_blit_page(sb->pages, sb->pitch[0], sb->format->cpp[0],
> - 					   sbuf8, spitch, clip, scale, fg_color);
> -
> - 	map = sb->map[0];
> - 	iosys_map_incr(&map, clip->y1 * sb->pitch[0] + clip->x1 * sb->format->cpp[0]);
> -
> - 	switch (sb->format->cpp[0]) {
> - 	case 2:
> - 		drm_draw_blit16(&map, sb->pitch[0], sbuf8, spitch,
> - 				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
> - 	break;
> - 	case 3:
> - 		drm_draw_blit24(&map, sb->pitch[0], sbuf8, spitch,
> - 				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
> - 	break;
> - 	case 4:
> - 		drm_draw_blit32(&map, sb->pitch[0], sbuf8, spitch,
> - 				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
> - 	break;
> - 	default:
> - 		WARN_ONCE(1, "Can't blit with pixel width %d\n", sb->format->cpp[0]);
> - 	}
> - }
> -
> - static void drm_panic_fill_pixel(struct drm_scanout_buffer *sb,
> - 				 struct drm_rect *clip,
> - 				 u32 color)
> - {
> - 	unsigned int y, x;
> -
> - 	for (y = 0; y < drm_rect_height(clip); y++)
> - 		for (x = 0; x < drm_rect_width(clip); x++)
> - 			sb->set_pixel(sb, clip->x1 + x, clip->y1 + y, color);
> - }
> -
> - static void drm_panic_fill_page(struct page **pages, unsigned int dpitch,
> - 				unsigned int cpp, struct drm_rect *clip,
> - 				u32 color)
> - {
> - 	unsigned int y, x;
> - 	unsigned int page = ~0;
> - 	void *vaddr = NULL;
> -
> - 	for (y = clip->y1; y < clip->y2; y++) {
> - 		for (x = clip->x1; x < clip->x2; x++) {
> - 			unsigned int new_page;
> - 			unsigned int offset;
> -
> - 			offset = y * dpitch + x * cpp;
> - 			new_page = offset >> PAGE_SHIFT;
> - 			offset = offset % PAGE_SIZE;
> - 			if (new_page != page) {
> - 				if (vaddr)
> - 					kunmap_local(vaddr);
> - 				page = new_page;
> - 				vaddr = kmap_local_page_try_from_panic(pages[page]);
> - 			}
> - 			if (!vaddr)
> - 				continue;
> -
> - 			// Special case for 24bit, as a pixel might cross page boundaries
> - 			if (cpp == 3 && offset + 3 > PAGE_SIZE)
> - 				drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
> - 							      offset, color);
> - 			else
> - 				drm_panic_write_pixel(vaddr, offset, color, cpp);
> - 		}
> - 	}
> - 	if (vaddr)
> - 		kunmap_local(vaddr);
> - }
> -
> - /*
> -  * drm_panic_fill - Fill a rectangle with a color
> -  * @sb: destination scanout buffer
> -  * @clip: destination rectangle
> -  * @color: foreground color, in destination format
> -  *
> -  * Fill a rectangle with a color, in a linear framebuffer.
> -  */
> - static void drm_panic_fill(struct drm_scanout_buffer *sb, struct drm_rect *clip,
> - 			   u32 color)
> - {
> - 	struct iosys_map map;
> -
> - 	if (sb->set_pixel)
> - 		return drm_panic_fill_pixel(sb, clip, color);
> -
> - 	if (sb->pages)
> - 		return drm_panic_fill_page(sb->pages, sb->pitch[0], sb->format->cpp[0],
> - 					   clip, color);
> -
> - 	map = sb->map[0];
> - 	iosys_map_incr(&map, clip->y1 * sb->pitch[0] + clip->x1 * sb->format->cpp[0]);
> -
> - 	switch (sb->format->cpp[0]) {
> - 	case 2:
> - 		drm_draw_fill16(&map, sb->pitch[0], drm_rect_height(clip),
> - 				drm_rect_width(clip), color);
> - 	break;
> - 	case 3:
> - 		drm_draw_fill24(&map, sb->pitch[0], drm_rect_height(clip),
> - 				drm_rect_width(clip), color);
> - 	break;
> - 	case 4:
> - 		drm_draw_fill32(&map, sb->pitch[0], drm_rect_height(clip),
> - 				drm_rect_width(clip), color);
> - 	break;
> - 	default:
> - 		WARN_ONCE(1, "Can't fill with pixel width %d\n", sb->format->cpp[0]);
> - 	}
> - }
> -
> - static unsigned int get_max_line_len(const struct drm_panic_line *lines, int len)
> - {
> - 	int i;
> - 	unsigned int max = 0;
> -
> - 	for (i = 0; i < len; i++)
> - 		max = max(lines[i].len, max);
> - 	return max;
> - }
> -
> - /*
> -  * Draw a text in a rectangle on a framebuffer. The text is truncated if it overflows the rectangle
> -  */
> - static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
> - 			       const struct font_desc *font,
> - 			       const struct drm_panic_line *msg,
> - 			       unsigned int msg_lines,
> - 			       bool centered,
> - 			       struct drm_rect *clip,
> - 			       u32 color)
> - {
> - 	int i, j;
> - 	const u8 *src;
> - 	size_t font_pitch = DIV_ROUND_UP(font->width, 8);
> - 	struct drm_rect rec;
> -
> - 	msg_lines = min(msg_lines,  drm_rect_height(clip) / font->height);
> - 	for (i = 0; i < msg_lines; i++) {
> - 		size_t line_len = min(msg[i].len, drm_rect_width(clip) / font->width);
> -
> - 		rec.y1 = clip->y1 +  i * font->height;
> - 		rec.y2 = rec.y1 + font->height;
> - 		rec.x1 = clip->x1;
> -
> - 		if (centered)
> - 			rec.x1 += (drm_rect_width(clip) - (line_len * font->width)) / 2;
> -
> - 		for (j = 0; j < line_len; j++) {
> - 			src = font_data_glyph_buf(font->data, font->width, font->height,
> - 						  (unsigned char)msg[i].txt[j]);
> - 			rec.x2 = rec.x1 + font->width;
> - 			if (src)
> - 				drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
> - 			rec.x1 += font->width;
> - 		}
> - 	}
> - }
> -
> - static void drm_panic_logo_rect(struct drm_rect *rect, const struct font_desc *font)
> - {
> - 	if (logo_mono) {
> - 		drm_rect_init(rect, 0, 0, logo_mono->width, logo_mono->height);
> - 	} else {
> - 		int logo_width = get_max_line_len(logo_ascii, logo_ascii_lines) * font->width;
> -
> - 		drm_rect_init(rect, 0, 0, logo_width, logo_ascii_lines * font->height);
> - 	}
> - }
> -
> - static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *rect,
> - 				const struct font_desc *font, u32 fg_color)
> - {
> - 	if (rect->x2 > sb->width || rect->y2 > sb->height)
> - 		return;
> -
> - 	if (logo_mono)
> - 		drm_panic_blit(sb, rect, logo_mono->data,
> - 			       DIV_ROUND_UP(drm_rect_width(rect), 8), 1, fg_color);
> - 	else
> - 		draw_txt_rectangle(sb, font, logo_ascii, logo_ascii_lines, false, rect,
> - 				   fg_color);
> - }
> -
> - static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
> - {
> - 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
> - 						    sb->format->format);
> - 	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
> - 						    sb->format->format);
> - 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
> - 	struct drm_rect r_screen, r_logo, r_msg;
> - 	unsigned int msg_width, msg_height;
> -
> - 	if (!font)
> - 		return;
> -
> - 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
> - 	drm_panic_logo_rect(&r_logo, font);
> -
> - 	msg_width = min(get_max_line_len(panic_msg, panic_msg_lines) * font->width, sb->width);
> - 	msg_height = min(panic_msg_lines * font->height, sb->height);
> - 	r_msg = DRM_RECT_INIT(0, 0, msg_width, msg_height);
> -
> - 	/* Center the panic message */
> - 	drm_rect_translate(&r_msg, (sb->width - r_msg.x2) / 2, (sb->height - r_msg.y2) / 2);
> -
> - 	/* Fill with the background color, and draw text on top */
> - 	drm_panic_fill(sb, &r_screen, bg_color);
> -
> - 	if (!drm_rect_overlap(&r_logo, &r_msg))
> - 		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
> -
> - 	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, fg_color);
> - }
> -
> - /*
> -  * Draw one line of kmsg, and handle wrapping if it won't fit in the screen width.
> -  * Return the y-offset of the next line.
> -  */
> - static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_desc *font,
> - 			       struct drm_panic_line *line, int yoffset, u32 fg_color)
> - {
> - 	int chars_per_row = sb->width / font->width;
> - 	struct drm_rect r_txt = DRM_RECT_INIT(0, yoffset, sb->width, font->height);
> - 	struct drm_panic_line line_wrap;
> -
> - 	if (line->len > chars_per_row) {
> - 		line_wrap.len = line->len % chars_per_row;
> - 		line_wrap.txt = line->txt + line->len - line_wrap.len;
> - 		draw_txt_rectangle(sb, font, &line_wrap, 1, false, &r_txt, fg_color);
> - 		r_txt.y1 -= font->height;
> - 		if (r_txt.y1 < 0)
> - 			return r_txt.y1;
> - 		while (line_wrap.txt > line->txt) {
> - 			line_wrap.txt -= chars_per_row;
> - 			line_wrap.len = chars_per_row;
> - 			draw_txt_rectangle(sb, font, &line_wrap, 1, false, &r_txt, fg_color);
> - 			r_txt.y1 -= font->height;
> - 			if (r_txt.y1 < 0)
> - 				return r_txt.y1;
> - 		}
> - 	} else {
> - 		draw_txt_rectangle(sb, font, line, 1, false, &r_txt, fg_color);
> - 		r_txt.y1 -= font->height;
> - 	}
> - 	return r_txt.y1;
> - }
> -
> - /*
> -  * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
> -  * and going up until reaching the top of the screen.
> -  */
> - static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
> - {
> - 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
> - 						    sb->format->format);
> - 	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
> - 						    sb->format->format);
> - 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
> - 	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
> - 	struct kmsg_dump_iter iter;
> - 	/* the size printk formats one record into, too big for the stack */
> - 	static char kmsg_buf[2048];
> - 	size_t kmsg_len;
> - 	struct drm_panic_line line;
> - 	int yoffset;
> -
> - 	if (!font || font->width > sb->width)
> - 		return;
> -
> - 	yoffset = sb->height - font->height - (sb->height % font->height) / 2;
> -
> - 	/* Fill with the background color, and draw text on top */
> - 	drm_panic_fill(sb, &r_screen, bg_color);
> -
> - 	kmsg_dump_rewind(&iter);
> - 	while (yoffset >= 0 && kmsg_dump_get_buffer(&iter, false, kmsg_buf,
> - 	       sizeof(kmsg_buf), &kmsg_len)) {
> - 		char *start;
> - 		char *end;
> -
> - 		/* a record that does not fit comes back empty, every time */
> - 		if (!kmsg_len)
> - 			break;
> -
> - 		/* ignore terminating NUL and newline */
> - 		start = kmsg_buf + kmsg_len - 2;
> - 		end = kmsg_buf + kmsg_len - 1;
> - 		while (start > kmsg_buf && yoffset >= 0) {
> - 			while (start > kmsg_buf && *start != '\n')
> - 				start--;
> - 			/* don't count the newline character */
> - 			line.txt = start + (start == kmsg_buf ? 0 : 1);
> - 			line.len = end - line.txt;
> -
> - 			yoffset = draw_line_with_wrap(sb, font, &line, yoffset, fg_color);
> - 			end = start;
> - 			start--;
> - 		}
> - 	}
> - }
> -
>    #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> - /*
> -  * It is unwise to allocate memory in the panic callback, so the buffers are
> -  * pre-allocated. Only 2 buffers and the zlib workspace are needed.
> -  * Two buffers are enough, using the following buffer usage:
> -  * 1) kmsg messages are dumped in buffer1
> -  * 2) kmsg is zlib-compressed into buffer2
> -  * 3) compressed kmsg is encoded as QR-code Numeric stream in buffer1
> -  * 4) QR-code image is generated in buffer2
> -  * The Max QR code size is V40, 177x177, 4071 bytes for image, 2956 bytes for
> -  * data segments.
> -  *
> -  * Typically, ~7500 bytes of kmsg, are compressed into 2800 bytes, which fits in
> -  * a V40 QR-code (177x177).
> -  *
> -  * If CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL is not set, the kmsg data will be put
> -  * directly in the QR code.
> -  * 1) kmsg messages are dumped in buffer1
> -  * 2) kmsg message is encoded as byte stream in buffer2
> -  * 3) QR-code image is generated in buffer1
> -  */
> -
>    static uint panic_qr_version = CONFIG_DRM_PANIC_SCREEN_QR_VERSION;
>    module_param(panic_qr_version, uint, 0644);
>    MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code");
> -
> - #define MAX_QR_DATA 2956
> - #define MAX_ZLIB_RATIO 3
> - #define QR_BUFFER1_SIZE (MAX_ZLIB_RATIO * MAX_QR_DATA) /* Must also be > 4071  */
> - #define QR_BUFFER2_SIZE 4096
> - #define QR_MARGIN	4	/* 4 modules of foreground color around the qr code */
> -
> - /* Compression parameters */
> - #define COMPR_LEVEL 6
> - #define WINDOW_BITS 12
> - #define MEM_LEVEL 4
> -
> - static char *qrbuf1;
> - static char *qrbuf2;
> - static struct z_stream_s stream;
> -
> - static void __init drm_panic_qr_init(void)
> - {
> - 	qrbuf1 = kmalloc(QR_BUFFER1_SIZE, GFP_KERNEL);
> - 	qrbuf2 = kmalloc(QR_BUFFER2_SIZE, GFP_KERNEL);
> - 	stream.workspace = kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
> - 				   GFP_KERNEL);
> - }
> -
> - static void drm_panic_qr_exit(void)
> - {
> - 	kfree(qrbuf1);
> - 	qrbuf1 = NULL;
> - 	kfree(qrbuf2);
> - 	qrbuf2 = NULL;
> - 	kfree(stream.workspace);
> - 	stream.workspace = NULL;
> - }
> -
> - static int drm_panic_get_qr_code_url(u8 **qr_image)
> - {
> - 	struct kmsg_dump_iter iter;
> - 	char url[256];
> - 	size_t kmsg_len, max_kmsg_size;
> - 	char *kmsg;
> - 	int max_qr_data_size, url_len;
> -
> - 	url_len = snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL "?a=%s&v=%s&z=",
> - 			   utsname()->machine, utsname()->release);
> -
> - 	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);
> - 	max_kmsg_size = min(MAX_ZLIB_RATIO * max_qr_data_size, QR_BUFFER1_SIZE);
> -
> - 	/* get kmsg to buffer 1 */
> - 	kmsg_dump_rewind(&iter);
> - 	kmsg_dump_get_buffer(&iter, false, qrbuf1, max_kmsg_size, &kmsg_len);
> -
> - 	if (!kmsg_len)
> - 		return -ENODATA;
> - 	kmsg = qrbuf1;
> -
> - try_again:
> - 	if (zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
> - 			      MEM_LEVEL, Z_DEFAULT_STRATEGY) != Z_OK)
> - 		return -EINVAL;
> -
> - 	stream.next_in = kmsg;
> - 	stream.avail_in = kmsg_len;
> - 	stream.total_in = 0;
> - 	stream.next_out = qrbuf2;
> - 	stream.avail_out = QR_BUFFER2_SIZE;
> - 	stream.total_out = 0;
> -
> - 	if (zlib_deflate(&stream, Z_FINISH) != Z_STREAM_END)
> - 		return -EINVAL;
> -
> - 	if (zlib_deflateEnd(&stream) != Z_OK)
> - 		return -EINVAL;
> -
> - 	if (stream.total_out > max_qr_data_size) {
> - 		/* too much data for the QR code, so skip the first line and try again */
> - 		kmsg = strchr(kmsg, '\n');
> - 		if (!kmsg)
> - 			return -EINVAL;
> - 		/* skip the first \n */
> - 		kmsg += 1;
> - 		kmsg_len = strlen(kmsg);
> - 		goto try_again;
> - 	}
> - 	*qr_image = qrbuf2;
> -
> - 	/* generate qr code image in buffer2 */
> - 	return drm_panic_qr_generate(url, qrbuf2, stream.total_out, QR_BUFFER2_SIZE,
> - 				     qrbuf1, QR_BUFFER1_SIZE);
> - }
> -
> - static int drm_panic_get_qr_code_raw(u8 **qr_image)
> - {
> - 	struct kmsg_dump_iter iter;
> - 	size_t kmsg_len;
> - 	size_t max_kmsg_size = min(drm_panic_qr_max_data_size(panic_qr_version, 0),
> - 				   QR_BUFFER1_SIZE);
> -
> - 	kmsg_dump_rewind(&iter);
> - 	kmsg_dump_get_buffer(&iter, false, qrbuf1, max_kmsg_size, &kmsg_len);
> - 	if (!kmsg_len)
> - 		return -ENODATA;
> -
> - 	*qr_image = qrbuf1;
> - 	return drm_panic_qr_generate(NULL, qrbuf1, kmsg_len, QR_BUFFER1_SIZE,
> - 				     qrbuf2, QR_BUFFER2_SIZE);
> - }
> -
> - static int drm_panic_get_qr_code(u8 **qr_image)
> - {
> - 	if (strlen(CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL) > 0)
> - 		return drm_panic_get_qr_code_url(qr_image);
> - 	else
> - 		return drm_panic_get_qr_code_raw(qr_image);
> - }
> -
> - /*
> -  * Draw the panic message at the center of the screen, with a QR Code
> -  */
> - static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
> - {
> - 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
> - 						    sb->format->format);
> - 	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
> - 						    sb->format->format);
> - 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
> - 	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
> - 	unsigned int max_qr_size, scale;
> - 	unsigned int msg_width, msg_height;
> - 	int qr_width, qr_canvas_width, qr_pitch, v_margin;
> - 	u8 *qr_image;
> -
> - 	if (!font || !qrbuf1 || !qrbuf2 || !stream.workspace)
> - 		return -ENOMEM;
> -
> - 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
> -
> - 	drm_panic_logo_rect(&r_logo, font);
> -
> - 	msg_width = min(get_max_line_len(panic_msg, panic_msg_lines) * font->width, sb->width);
> - 	msg_height = min(panic_msg_lines * font->height, sb->height);
> - 	r_msg = DRM_RECT_INIT(0, 0, msg_width, msg_height);
> -
> - 	max_qr_size = min(3 * sb->width / 4, 3 * sb->height / 4);
> -
> - 	qr_width = drm_panic_get_qr_code(&qr_image);
> - 	if (qr_width <= 0)
> - 		return -ENOSPC;
> -
> - 	qr_canvas_width = qr_width + QR_MARGIN * 2;
> - 	scale = max_qr_size / qr_canvas_width;
> - 	/* QR code is not readable if not scaled at least by 2 */
> - 	if (scale < 2)
> - 		return -ENOSPC;
> -
> - 	pr_debug("QR width %d and scale %d\n", qr_width, scale);
> - 	r_qr_canvas = DRM_RECT_INIT(0, 0, qr_canvas_width * scale, qr_canvas_width * scale);
> -
> - 	v_margin = sb->height - drm_rect_height(&r_qr_canvas) - drm_rect_height(&r_msg);
> - 	if (v_margin < 0)
> - 		return -ENOSPC;
> - 	v_margin /= 5;
> -
> - 	drm_rect_translate(&r_qr_canvas, (sb->width - r_qr_canvas.x2) / 2, 2 * v_margin);
> - 	r_qr = DRM_RECT_INIT(r_qr_canvas.x1 + QR_MARGIN * scale, r_qr_canvas.y1 + QR_MARGIN * scale,
> - 			     qr_width * scale, qr_width * scale);
> -
> - 	/* Center the panic message */
> - 	drm_rect_translate(&r_msg, (sb->width - r_msg.x2) / 2,
> - 			   3 * v_margin + drm_rect_height(&r_qr_canvas));
> -
> - 	/* Fill with the background color, and draw text on top */
> - 	drm_panic_fill(sb, &r_screen, bg_color);
> -
> - 	if (!drm_rect_overlap(&r_logo, &r_msg) && !drm_rect_overlap(&r_logo, &r_qr_canvas))
> - 		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
> -
> - 	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, fg_color);
> -
> - 	/* Draw the qr code */
> - 	qr_pitch = DIV_ROUND_UP(qr_width, 8);
> - 	drm_panic_fill(sb, &r_qr_canvas, fg_color);
> - 	drm_panic_fill(sb, &r_qr, bg_color);
> - 	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
> - 	return 0;
> - }
> -
> - static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
> - {
> - 	if (_draw_panic_screen_qr_code(sb))
> - 		draw_panic_screen_user(sb);
> - }
> - #else
> - static void drm_panic_qr_init(void) {};
> - static void drm_panic_qr_exit(void) {};
>    #endif
>    
> - enum drm_panic_type {
> - 	DRM_PANIC_TYPE_KMSG,
> - 	DRM_PANIC_TYPE_USER,
> - 	DRM_PANIC_TYPE_QR,
> - };
> -
>    static enum drm_panic_type drm_panic_type = -1;
>    
>    static const char *drm_panic_type_map[] = {
> @@@ -840,7 -66,7 +66,7 @@@ static int drm_panic_type_set(const cha
>    	unsigned int i;
>    
>    	for (i = 0; i < ARRAY_SIZE(drm_panic_type_map); i++) {
>   -		if (!strcmp(val, drm_panic_type_map[i])) {
>   +		if (sysfs_streq(val, drm_panic_type_map[i])) {
>    			drm_panic_type = i;
>    			return 0;
>    		}
> @@@ -869,91 -95,34 +95,34 @@@ MODULE_PARM_DESC(panic_screen
>    #endif
>    		 CONFIG_DRM_PANIC_SCREEN "]");
>    
> - /*
> -  * drm_panic_is_format_supported()
> -  * @format: a fourcc color code
> -  * Returns: true if supported, false otherwise.
> -  *
> -  * Check if drm_panic will be able to use this color format.
> -  */
> - static bool drm_panic_is_format_supported(const struct drm_format_info *format)
> - {
> - 	if (format->num_planes != 1)
> - 		return false;
> - 	return drm_draw_can_convert_from_xrgb8888(format->format);
> - }
> + #define drm_panic_trylock(dev, flags) \
> + 	raw_spin_trylock_irqsave(&(dev)->mode_config.panic_lock, flags)
>    
> - static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
> + static void drm_panic_display_panic_screen(struct drm_plane *plane, const char *description)
>    {
> - 	switch (drm_panic_type) {
> - 	case DRM_PANIC_TYPE_KMSG:
> - 		draw_panic_screen_kmsg(sb);
> - 		break;
> -
> - #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> - 	case DRM_PANIC_TYPE_QR:
> - 		draw_panic_screen_qr_code(sb);
> - 		break;
> + #if defined(CONFIG_DRM_PANIC_FOREGROUND_COLOR)
> + 	u32 fg_color = CONFIG_DRM_PANIC_FOREGROUND_COLOR;
> + #else
> + 	u32 fg_color = 0x00ffffff;
>    #endif
> -
> - 	case DRM_PANIC_TYPE_USER:
> - 	default:
> - 		draw_panic_screen_user(sb);
> - 	}
> - }
> -
> - static void drm_panic_set_description(const char *description)
> - {
> - 	u32 len;
> -
> - 	if (description) {
> - 		struct drm_panic_line *desc_line = &panic_msg[panic_msg_lines - 1];
> -
> - 		desc_line->txt = description;
> - 		len = strlen(description);
> - 		/* ignore the last newline character */
> - 		if (len && description[len - 1] == '\n')
> - 			len -= 1;
> - 		desc_line->len = len;
> - 	}
> - }
> -
> - static void drm_panic_clear_description(void)
> - {
> - 	struct drm_panic_line *desc_line = &panic_msg[panic_msg_lines - 1];
> -
> - 	desc_line->len = 0;
> - 	desc_line->txt = NULL;
> - }
> -
> - static void draw_panic_plane(struct drm_plane *plane, const char *description)
> - {
> - 	struct drm_scanout_buffer sb = { };
> - 	int ret;
> + #if defined(CONFIG_DRM_PANIC_BACKGROUND_COLOR)
> + 	u32 bg_color = CONFIG_DRM_PANIC_BACKGROUND_COLOR;
> + #else
> + 	u32 bg_color = 0x00000000;
> + #endif
> + #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> + 	unsigned int qr_version = panic_qr_version;
> + #else
> + 	unsigned int qr_version = 0;
> + #endif
> + 	struct drm_device *dev = plane->dev;
>    	unsigned long flags;
>    
> - 	if (!drm_panic_trylock(plane->dev, flags))
> - 		return;
> -
> - 	ret = plane->helper_private->get_scanout_buffer(plane, &sb);
> -
> - 	if (ret || !drm_panic_is_format_supported(sb.format))
> - 		goto unlock;
> -
> - 	/* One of these should be set, or it can't draw pixels */
> - 	if (!sb.set_pixel && !sb.pages && iosys_map_is_null(&sb.map[0]))
> - 		goto unlock;
> -
> - 	drm_panic_set_description(description);
> -
> - 	draw_panic_dispatch(&sb);
> - 	if (plane->helper_private->panic_flush)
> - 		plane->helper_private->panic_flush(plane);
> -
> - 	drm_panic_clear_description();
> -
> - unlock:
> - 	drm_panic_unlock(plane->dev, flags);
> + 	if (drm_panic_trylock(dev, flags)) {
> + 		plane->funcs->display_panic_screen(plane, description, drm_panic_type,
> + 						   fg_color, bg_color, qr_version);
> + 		drm_panic_unlock(dev, flags);
> + 	}
>    }
>    
>    static struct drm_plane *to_drm_plane(struct kmsg_dumper *kd)
> @@@ -966,10 -135,9 +135,9 @@@ static void drm_panic(struct kmsg_dumpe
>    	struct drm_plane *plane = to_drm_plane(dumper);
>    
>    	if (detail->reason == KMSG_DUMP_PANIC)
> - 		draw_panic_plane(plane, detail->description);
> + 		drm_panic_display_panic_screen(plane, detail->description);
>    }
>    
> -
>    /*
>     * DEBUG FS, This is currently unsafe.
>     * Create one file per plane, so it's possible to debug one plane at a time.
> @@@ -986,7 -154,7 +154,7 @@@ static ssize_t debugfs_trigger_write(st
>    	if (kstrtobool_from_user(user_buf, count, &run) == 0 && run) {
>    		struct drm_plane *plane = file->private_data;
>    
> - 		draw_panic_plane(plane, "Test from debugfs");
> + 		drm_panic_display_panic_screen(plane, "Test from debugfs");
>    	}
>    	return count;
>    }
> @@@ -1022,9 -190,13 +190,13 @@@ bool drm_panic_is_enabled(struct drm_de
>    	if (!dev->mode_config.num_total_plane)
>    		return false;
>    
> - 	drm_for_each_plane(plane, dev)
> - 		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
> - 			return true;
> + 	drm_for_each_plane(plane, dev) {
> + 		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
> + 			continue;
> + 		if (!plane->funcs || !plane->funcs->display_panic_screen)
> + 			continue;
> + 		return true;
> + 	}
>    	return false;
>    }
>    EXPORT_SYMBOL(drm_panic_is_enabled);
> @@@ -1042,7 -214,9 +214,9 @@@ void drm_panic_register(struct drm_devi
>    		return;
>    
>    	drm_for_each_plane(plane, dev) {
> - 		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
> + 		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
> + 			continue;
> + 		if (!plane->funcs || !plane->funcs->display_panic_screen)
>    			continue;
>    		plane->kmsg_panic.dump = drm_panic;
>    		plane->kmsg_panic.max_reason = KMSG_DUMP_PANIC;
> @@@ -1069,7 -243,9 +243,9 @@@ void drm_panic_unregister(struct drm_de
>    		return;
>    
>    	drm_for_each_plane(plane, dev) {
> - 		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
> + 		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
> + 			continue;
> + 		if (!plane->funcs || !plane->funcs->display_panic_screen)
>    			continue;
>    		kmsg_dump_unregister(&plane->kmsg_panic);
>    	}
> @@@ -1085,17 -261,4 +261,4 @@@ void __init drm_panic_init(void
>    			CONFIG_DRM_PANIC_SCREEN);
>    		drm_panic_type = DRM_PANIC_TYPE_USER;
>    	}
> - 	drm_panic_qr_init();
>    }
> -
> - /**
> -  * drm_panic_exit() - Free the resources taken by drm_panic_exit()
> -  */
> - void drm_panic_exit(void)
> - {
> - 	drm_panic_qr_exit();
> - }
> -
> - #ifdef CONFIG_DRM_KUNIT_TEST
> - #include "tests/drm_panic_test.c"
> - #endif

