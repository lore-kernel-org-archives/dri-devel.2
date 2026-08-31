Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FA6C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8525A10E2D4;
	Mon, 31 Aug 2026 15:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UEkOX7h4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB9F10E97A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:54:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 293C943D72
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9CB1F000E9;
 Mon, 31 Aug 2026 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788191690;
 bh=eaktLATO7nNalE6k5BAINH9uRmCUNttkUWLEYD69Mnk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UEkOX7h4Nod1PE2P/K972jyAoJChJ6iFeHMa1LCBMcABrdiLmlFzq//xV3Ji3XTw6
 MoD+10j7Qxlj5cxjUXO8yJcJHJz9+oVMjwTa5A4e4/pxVnXmVQE39MGOqx3sd2mHub
 AAfo/j5g1Nsaznx3Q/HC0ZdgUVEzG7NpqTpxbOJzL4bSohA5Jtd8IQMoR0sozFoXLX
 Rv2uoNnSZ1I6FKjMHvyBrJT8SLeOPtosiI3XDRa0Yy7aWXNOVJlzf139qXaatCfX5S
 vkOYs0sV+uaC90zmO2ZHxYXj6e97bP/26A2V9kVt93T42u6LVaQhp8AtEEtr1mLHZP
 Ul+NVFawM4rDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] fbdev: Wrap user-invoked calls to
 fb_set_var() in helper
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-356-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-356-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:54:49 +0000
Message-Id: <20260831155449.DE9CB1F000E9@smtp.kernel.org>
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

New issues:
- [High] sh_mobile_lcdcfb updates only the active console instead of all co=
nsoles during display reconfig, dropping the background VCs update.

Pre-existing issues:
- [High] fbcon_modechange_possible() validation can be bypassed because it =
is performed before fb_check_var() bounds the user-provided resolution.
- [High] Potential AB-BA deadlock between console_lock and lock_fb_info acr=
oss core and driver callbacks.
- [High] The font size validation can be bypassed by spoofing `var->rotate`=
, causing an out-of-bounds memory access in fbcon.
--

commit 156965fbba8946918db59885f218ac2448bb25e8
Author: Thomas Zimmermann <tzimmermann@suse.de>
fbdev: Wrap user-invoked calls to fb_set_var() in helper

Handle fbcon during display updates in fb_set_var_from_user(). Check
with fbcon if the mode change is possible, update hardware state and
finally update fbcon. Update all callers.

> diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/c=
ore/fb_chrdev.c
> index 4ebd16b7e3b8d..54f926fb411bd 100644
> --- a/drivers/video/fbdev/core/fb_chrdev.c
> +++ b/drivers/video/fbdev/core/fb_chrdev.c
> @@ -85,11 +85,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned=
 int cmd,
>  		var.activate &=3D ~FB_ACTIVATE_KD_TEXT;
>  		console_lock();
>  		lock_fb_info(info);
> -		ret =3D fbcon_modechange_possible(info, &var);
> -		if (!ret)
> -			ret =3D fb_set_var(info, &var);
> -		if (!ret)
> -			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
> +		ret =3D fb_set_var_from_user(info, &var);

[Severity: High]
This is a pre-existing issue, but does this lock order cause an AB-BA deadl=
ock
between console_lock and lock_fb_info?

do_fb_ioctl() establishes the canonical lock acquisition order:

do_fb_ioctl()
  console_lock();
  lock_fb_info(info);

However, when do_fb_ioctl() routes to a driver's fb_ioctl hook (like
ps3fb_ioctl), lock_fb_info() is already held:

do_fb_ioctl()
  lock_fb_info(info);
  ret =3D fb->fb_ioctl(info, cmd, arg);

ps3fb_ioctl()
  console_lock();

Similarly, closing the device triggers fb_release(), holding lock_fb_info()
while calling sh_mobile_lcdc_release(), which acquires console_lock().

Can concurrent ioctl or release operations trigger a system freeze here?

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index e7e07eb2142eb..e594a69163489 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -2784,7 +2783,6 @@ int fbcon_modechange_possible(struct fb_info *info,=
 struct fb_var_screeninfo *va
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(fbcon_modechange_possible);

[Severity: High]
This is a pre-existing issue, but can the font size validation in
fbcon_modechange_possible() be bypassed by spoofing var->rotate?

fbcon_modechange_possible() uses the user-controlled var->rotate to swap
width and height when verifying the resolution against the font size:

    if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) =
||
        vc->vc_font.height > FBCON_SWAP(var->rotate, var->yres, var->xres))

However, the actual execution logic in fbcon_modechanged() uses the interna=
l,
trusted ops->rotate state:

    cols =3D FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
    rows =3D FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);

If a user intentionally sets var->rotate to mismatch ops->rotate, passing a
heavily undersized xres (e.g., 4) alongside a large yres, the validation
logic swaps them and approves the mode. But execution does not swap them,
resulting in 0 columns and out-of-bounds memory writes during text renderin=
g.

> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/=
fbmem.c
> index eff757ebbed14..8950a6ba26d7d 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
[ ... ]
> @@ -346,6 +346,19 @@ fb_set_var(struct fb_info *info, struct fb_var_scree=
ninfo *var)
>  }
>  EXPORT_SYMBOL(fb_set_var);
> =20
> +int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo =
*var)
> +{
> +	int ret =3D fbcon_modechange_possible(info, var);
> +
> +	if (!ret)
> +		ret =3D fb_set_var(info, var);

[Severity: High]
This isn't a bug introduced by this patch, but can fbcon_modechange_possibl=
e()
validation be bypassed because it is performed before fb_check_var() bounds
the user-provided resolution?

Validation happens here on the unmutated user input, before hardware
constraints are applied. However, inside fb_set_var():

    ret =3D info->fbops->fb_check_var(var, info);

The driver may mutate var bounds downwards to fit hardware constraints,
invalidating the previous font size checks.

If a user issues an ioctl with a resolution that is initially larger than t=
he
font size, it passes validation. If the driver then rounds it down below the
font size, the undersized resolution is applied to the hardware and passed
to fbcon_update_vcs(), completely bypassing the validation and resulting in
out-of-bounds memory access in fbcon rendering.

> +	if (!ret)
> +		fbcon_update_vcs(info, var->activate & FB_ACTIVATE_ALL);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(fb_set_var_from_user);

> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev=
/sh_mobile_lcdcfb.c
> index dd950e4ab5ceb..6038f217ab427 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
[ ... ]
> @@ -1765,11 +1764,9 @@ static void sh_mobile_fb_reconfig(struct fb_info *=
info)
>  	var.height =3D ch->display.height;
>  	var.activate =3D FB_ACTIVATE_NOW;
> =20
> -	if (fb_set_var(info, &var) < 0)
> +	if (fb_set_var_from_user(info, &var) < 0)
>  		/* Couldn't reconfigure, hopefully, can continue as before */
>  		return;
> -
> -	fbcon_update_vcs(info, true);
>  }

[Severity: High]
Does this change unintentionally drop the update for background consoles du=
ring
display reconfig?

Previously, sh_mobile_fb_reconfig() explicitly updated all consoles by pass=
ing
true to fbcon_update_vcs():

    fbcon_update_vcs(info, true);

By switching to fb_set_var_from_user(), the update scope relies on
var.activate & FB_ACTIVATE_ALL:

    fbcon_update_vcs(info, var->activate & FB_ACTIVATE_ALL);

Since sh_mobile_fb_reconfig() hardcodes var.activate =3D FB_ACTIVATE_NOW (0=
),
the bitwise check results in false, downgrading the console update scope fr=
om
all VCs to just the foreground VC.

If the display was replaced with a smaller one via a hotplug event, backgro=
und
virtual consoles will retain dimensions corresponding to the old display
resolution. Switching to a background VC later could cause fbcon to render
past the new, smaller framebuffer bounds, leading to an out-of-bounds memory
access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-356-sashal@kernel.org?part=3D1
