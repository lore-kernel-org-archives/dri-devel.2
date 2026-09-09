Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D03EC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 19:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB6410F261;
	Wed,  9 Sep 2026 19:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fdj6L30u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC8610F261
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 19:28:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5139240436;
 Wed,  9 Sep 2026 19:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2105E1F000FF;
 Wed,  9 Sep 2026 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788982100;
 bh=4b21H7el1UQdRa7b9riXfS1yW0LY9veqRZk4N9jLdHY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fdj6L30uL6K4dvQEWKqzJQwnhd2bngM7uSsrS13WIVue96kxVkga/YtEo/NZDMaDE
 fb6Oq6Pe+4xOfchk92wWXEWJHtj8S77ZpXyEqYQ9k9f4CxwuXNpI1exJZezwmKGjMw
 OO+YWIKLiW+ObKiW/XvsPaoGlscuv8+Cpvh3JuwblRRQitv1lWf8e0xi8RZS+tDS33
 dhBxWsGBc+vxpXITMBsiz4vDlpM2b0nKvGw9dIKfM3qLhJ4gM76Rh0feG/GjTnB24y
 essnSW2BpwH2snyrBv7BkaffdzazWmrycuqj10scTgaqHGL/JvU703k6MvOQHcRVhP
 0y8VTvh+QcxNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: vfb: defer cleanup until the last reference
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909191022.847295-2-bestswngs@gmail.com>
References: <20260909191022.847295-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 19:28:19 +0000
Message-Id: <20260909192820.2105E1F000FF@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] fb_release calls module_put before put_fb_info, allowing a concurr=
ent module unload to unmap the driver's code before fb_destroy is executed.
- [High] If fbcon_fb_registered fails, do_register_framebuffer returns an e=
rror without unwinding the registration, leaving a freed pointer in the glo=
bal registered_fb array.
- [High] Concurrent execution of `unregister_framebuffer` and `FBIOPUT_VSCR=
EENINFO` causes Use-After-Free on `info->modelist`.
--

commit 58269d102e8231ba399afb90f35aad905f703fbf
Author: Weiming Shi <bestswngs@gmail.com>

fbdev: vfb: defer cleanup until the last reference

This patch defers the freeing of the vfb colormap and screen buffer
until the final reference to the framebuffer is released. It accomplishes
this by moving the cleanup code into a new fb_destroy callback to prevent
use-after-free issues during concurrent ioctls.

Link: https://lore.kernel.org/linux-fbdev/f2Kf9GYn1lKR5S1dbvGVtykMxK1RlgP5z=
8sW@bugs.sh/

> diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> index 5b7965f36c5ed..de137b2bdaedc 100644
> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -87,6 +94,7 @@ static const struct fb_ops vfb_ops =3D {
>  	.fb_pan_display	=3D vfb_pan_display,
>  	__FB_DEFAULT_SYSMEM_OPS_DRAW,
>  	.fb_mmap	=3D vfb_mmap,
> +	.fb_destroy	=3D vfb_destroy,

[Severity: High]
This isn't a bug introduced by this patch, but does adding this callback ex=
pose
a race with module unloading?

In drivers/video/fbdev/core/fb_chrdev.c:fb_release(), the module reference =
is
released before calling put_fb_info():

    module_put(info->fbops->owner);
    unlock_fb_info(info);
    put_fb_info(info);

If a user opens the device and a concurrent rmmod is initiated, the rmmod
blocks until the module refcount reaches zero. When the user closes the
device, fb_release() calls module_put(), which unblocks rmmod and unloads
the module. Then fb_release() proceeds to call put_fb_info(), which
executes:

    if (fb_info->fbops->fb_destroy)
        fb_info->fbops->fb_destroy(fb_info);

Since the module has been unloaded, info->fbops->fb_destroy now points to
unmapped memory. Does the core framework need to defer module_put() until
after put_fb_info(), or is there another mechanism preventing this?

>  };
> =20
[ ... ]
> @@ -485,9 +493,6 @@ static void vfb_remove(struct platform_device *dev)
> =20
>  	if (info) {
>  		unregister_framebuffer(info);

[Severity: High]
This is another pre-existing issue in the core framework, but can
unregister_framebuffer() race with concurrent ioctls modifying the
modelist?

In drivers/video/fbdev/core/fbmem.c:do_unregister_framebuffer(), the
modelist items are freed without holding info->lock:

    fb_destroy_modelist(&fb_info->modelist);
    registered_fb[fb_info->node] =3D NULL;

If an ioctl like FBIOPUT_VSCREENINFO concurrently executes fb_set_var() on
an open file descriptor, it iterates over the modelist:

    if (info->modelist.prev && info->modelist.next &&
        !list_empty(&info->modelist))
        ret =3D fb_add_videomode(&mode, &info->modelist);

Can this lead to a use-after-free when accessing the freed modelist
pointers? Is it possible to hold info->lock during the modelist cleanup?

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of a memory
leak or use-after-free in the core registration error path?

In drivers/video/fbdev/core/fbmem.c:do_register_framebuffer(), if
fbcon_fb_registered() fails, it returns an error but leaves the pointer in
the global registered_fb[] array:

    return fbcon_fb_registered(fb_info);

If this probe error path executes, the driver attempts to free the
framebuffer, but it fails because info->count is still 1. If the driver
frees the backing videomemory, subsequent opens of /dev/fb0 could fetch
the leaked fb_info from the array and operate on freed videomemory. Can
do_register_framebuffer() unwind the registered_fb[i] assignment on this
error path?

> -		vfree(videomemory);
> -		fb_dealloc_cmap(&info->cmap);
> -		framebuffer_release(info);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909191022.8472=
95-2-bestswngs@gmail.com?part=3D1
