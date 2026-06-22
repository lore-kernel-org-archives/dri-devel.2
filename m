Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CB5CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0501210E514;
	Mon, 22 Jun 2026 08:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RaBC9SVI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D618210E512
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:07:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48D366001A;
 Mon, 22 Jun 2026 08:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FC61F000E9;
 Mon, 22 Jun 2026 08:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782115670;
 bh=UXIm6o3qV11bcb/QOS8si6fiz2as+bQzSBnT//7xKU8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RaBC9SVI06BFjc8+qOUnLfkjVnFas23JRWt0jB353n8XWNqSiVmZWT2YZZvRauDrX
 rpG/Ia9CCwVUSsnHIRAraV74AlJD4pBaV2Bg9NXaCIdaRMnpQ19MPyean/Pw4yET0b
 Ib45nozBDDLV/I7F1RLOJoWp5t7vbcn/X4TwSt/PBfhjxQB3MGAd42+41wLLMOtDLt
 d89TwA6EpeufE9YyOX/NWC+5zH8KYwWdiO8aXFNSeJlWkR43qrJV9O3nBqGrvMRVOf
 Ql2dc8oZ/hXLpoyDSnCU4cH5sYxokYIbEvCn2HT4ts3Hm+p+sIVHOO7P6YZuf++L94
 TCxXobFc4vfKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: fix use-after-free of fb_display[i].mode in
 store_modes()
To: "Ian Bridges" <icb@fastmail.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <ajjoDhAi2y4ArSlz@dev>
References: <ajjoDhAi2y4ArSlz@dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:07:49 +0000
Message-Id: <20260622080749.D7FC61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in show_mode() due to dangling fb_info->mode pointe=
r.
- [High] Data Race and potential Use-After-Free / list corruption when iter=
ating fb_info->modelist.
- [High] NULL pointer dereference in fbcon_new_modelist() for unallocated c=
onsoles.
- [Medium] Data Race and locking violation modifying fb_display in do_unreg=
ister_framebuffer().
--

commit 5e256dfc1372231ec16feb6ee8a3218859b0dd4f
Author: Ian Bridges <icb@fastmail.org>

fbdev: fix use-after-free of fb_display[i].mode in store_modes()

store_modes() replaces a framebuffer's modelist and frees the old entries
with fb_destroy_modelist(), but fb_display[i].mode was left dangling.
This commit fixes the use-after-free by clearing the stale pointers with
fbcon_delete_modelist() before freeing the old list.

Closes: https://syzkaller.appspot.com/bug?extid=3D81c7c6b52649fd07299d

> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/cor=
e/fbsysfs.c
> index baa2bae0fb5b3..c761dcf21dafb 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -111,8 +111,10 @@ static ssize_t store_modes(struct device *device,
>  	if (fb_new_modelist(fb_info)) {

[Severity: High]
This isn't a bug introduced by this patch, but can this fb_new_modelist()
call lead to a NULL pointer dereference for unallocated consoles?

If an unallocated console (where vc_cons[i].d is NULL) is mapped to a
framebuffer, fbcon_set_disp() populates fb_display[i].mode and returns earl=
y.

When store_modes() calls fb_new_modelist() -> fbcon_new_modelist(),
it checks if con2fb_map and fb_display[i].mode are set. Could it then fetch
vc =3D vc_cons[i].d and unconditionally dereference vc->vc_num?

drivers/video/fbdev/core/fbcon.c:fbcon_new_modelist() {
    ...
    vc =3D vc_cons[i].d;
    ...
    fbcon_set_disp(info, &var, vc->vc_num);
    ...
}

>  		fb_destroy_modelist(&fb_info->modelist);
>  		list_splice(&old_list, &fb_info->modelist);
> -	} else
> +	} else {
> +		fbcon_delete_modelist(&old_list);

[Severity: Medium]
This is a pre-existing issue, but since we are properly calling
fbcon_delete_modelist() under console_lock() here, should other callers do
the same?

Looking at do_unregister_framebuffer(), it executes without holding
console_lock():

drivers/video/fbdev/core/fbmem.c:do_unregister_framebuffer() {
    ...
    fbcon_delete_modelist(&fb_info->modelist);
    ...
}

Since fbcon_delete_mode() iterates the global fb_display array and lockless=
ly
assigns NULL to fb_display[i].mode, could this cause a data race with
concurrent readers like FBIOPUT_VSCREENINFO?

>  		fb_destroy_modelist(&old_list);

[Severity: High]
This is a pre-existing issue, but does destroying old_list leave
fb_info->mode dangling?

If fb_info->mode was previously set to point into a struct fb_modelist
element from this list, it doesn't appear to be cleared before the list
is freed.

Could a subsequent read of the sysfs mode attribute trigger a use-after-free
here:

drivers/video/fbdev/core/fbsysfs.c:show_mode() {
    ...
    return mode_string(buf, 0, fb_info->mode);
}

[Severity: High]
This is also a pre-existing issue, but does modifying fb_info->modelist
under lock_fb_info() race with sysfs readers?

Looking at show_modes() and store_mode(), they appear to iterate
fb_info->modelist locklessly:

drivers/video/fbdev/core/fbsysfs.c:show_modes() {
    ...
    list_for_each_entry(modelist, &fb_info->modelist, list) {
    ...
}

Since store_modes() splices, modifies, and destroys this list, could a
concurrent sysfs read/write follow corrupted pointers into freed memory?

> +	}
> =20
>  	unlock_fb_info(fb_info);
>  	console_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ajjoDhAi2y4ArSlz@de=
v?part=3D1
