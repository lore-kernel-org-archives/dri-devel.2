Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31549C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6072910E7B3;
	Mon, 31 Aug 2026 09:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V4rjqRNG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3830910E7B3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:47:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA81D418C3;
 Mon, 31 Aug 2026 09:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916A31F000E9;
 Mon, 31 Aug 2026 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788169661;
 bh=62Cxagf2WVOjRdXbjRVZ4cvTQDxWQ1yv35//3CQoAwo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V4rjqRNGO34DNwgQ5x8JPQetgwlx1/5Yl8v1VrY40dB9eEkbkPPecKi3rhW6u0s4R
 DklrJwzdl/AxhzsBImgMIyyoUbejz7eynVGWJFBtfU56Gz2wU24DYg0HRydi7YIoEu
 R+CHl8+rptgLHJDRIYCitPYeDxtysbpAOcopSePnx8Dp4l8ehewTb+8DF9xP64xVyj
 /IK4Jd0Ru4ecTpO1gbMrmWnfo+mxm9QTFIf65XaV8mueebclmxHGtcbpo6DGq+vz7I
 Jju3Rs0TIY1ncYSVnETGxFwesGZA4F03rBveQBVI+rEj7nFV2bmAjRSQYEY9vxx6DK
 pPCIKft+OfV6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] firmware/sysfb: Remove rotation quirk for Lenovo
 D330
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831093020.494701-2-tzimmermann@suse.de>
References: <20260831093020.494701-1-tzimmermann@suse.de>
 <20260831093020.494701-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:47:41 +0000
Message-Id: <20260831094741.916A31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the sysfb swap quirk entirely will break display renderin=
g and panel orientation detection for Lenovo D330 devices running older fir=
mware.
--

commit 3f9b6b6dbd6e5dddf9820e6534eb1bfb33ccbc60
Author: Thomas Zimmermann <tzimmermann@suse.de>

firmware/sysfb: Remove rotation quirk for Lenovo D330

This commit removes the DMI match for the Lenovo D330 in sysfb_efi.c, which
previously swapped display width and height. The intent is to keep the
display as-is so DRM drivers can pick the correct panel orientation.

> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysf=
b_efi.c
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c

[ ... ]

> @@ -301,15 +301,6 @@ static const struct dmi_system_id efifb_dmi_swap_wid=
th_height[] __initconst =3D {
>  		},
>  		.callback =3D efifb_swap_width_height,
>  	},
> -	{
> -		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
> -		.matches =3D {
> -			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
> -					"Lenovo ideapad D330-10IGM"),
> -		},
> -		.callback =3D efifb_swap_width_height,
> -	},

[Severity: High]
Will removing this DMI match entirely break display rendering for Lenovo D3=
30
devices running older firmware?

While newer BIOS versions correctly report the native portrait geometry
(making the previous unconditional swap incorrect), older BIOS versions
genuinely reported the wrong landscape EFI geometry and relied on this quirk
to fix the lfb_width, lfb_height, and lfb_linelength fields.=20

Unconditionally removing the DMI match appears to fix newer BIOSes but
introduces a regression for older BIOSes where early boot framebuffers
(sysfb/simpledrm) might use the incorrect EFI-reported dimensions. This can
result in severely corrupted display output (garbage on screen) until a
native DRM driver loads.

Since later patches in this series updating the panel orientation quirk log=
ic
do not correct the underlying fb_mode and fb_pitch used by drm_sysfb_mode(),
would it be safer to retain the quirk but modify the callback to only swap =
if
the reported width is greater than the height (e.g., if
si->lfb_width > si->lfb_height)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831093020.4947=
01-1-tzimmermann@suse.de?part=3D1
