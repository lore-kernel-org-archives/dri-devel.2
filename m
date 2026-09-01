Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA731C624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68FB10E0AE;
	Tue,  1 Sep 2026 08:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L3H86ObB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4502C10E0AE
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:32:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 102AC40234;
 Tue,  1 Sep 2026 08:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD111F00ADB;
 Tue,  1 Sep 2026 08:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788251560;
 bh=MzLTXSMUMp+q8f4h4l08w7ZRoiZ3rFm/e9DpUdHS60I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L3H86ObBt0EnV9dA1Xe+RLKVUkPIJbnP/Vqkys/DvHCnn4VZL+ERP5q7UqylO+MVj
 MppMrnrnVxkS8HY16WVDNJHOOlyMBKgtST6VmYS+8NpDJiXFgXx6FkreB/qEDK7CPQ
 rJQ6gk82ObVRwath0GIqMSroUVMWEIR9BoGTFocLH8Q1J+MwBCoq3UHSuDZSPf3W9S
 4uJdxA76vzW/lApplyEXxqicGPLHtjOUH86T1NPbye4lMFuTyJpBh6+moCcmu6KqIZ
 PyzRkSJWantM//K6yH97frHC5cBrnq69Gpv0plQ0cXNeFG4DiGOpssMHFfNpRtKCsg
 2bzaURXiWLo5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] firmware/sysfb: Remove rotation quirk for Lenovo
 D330
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901082057.37617-2-tzimmermann@suse.de>
References: <20260901082057.37617-1-tzimmermann@suse.de>
 <20260901082057.37617-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:32:40 +0000
Message-Id: <20260901083240.BBD111F00ADB@smtp.kernel.org>
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
- [High] Removing the sysfb swap quirk breaks display rotation on Lenovo D3=
30 systems with older BIOS versions.
--

commit f8f13abb4b89a4b4aa3805bfd4d2f46d356e038c
Author: Thomas Zimmermann <tzimmermann@suse.de>

firmware/sysfb: Remove rotation quirk for Lenovo D330

This commit removes the sysfb width/height swap quirk for the Lenovo D330.
It notes that the quirk breaks the display geometry on the tested firmware,
but acknowledges the behavior might depend on the BIOS release and advises
users to update their firmware to avoid issues.

> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysf=
b_efi.c
> index 685283bb7327a..2338de73c62c9 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
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
Does unconditionally removing this quirk cause a regression for users on
older BIOS versions?

If a user boots a Lenovo D330-10IGM with an older BIOS that incorrectly
reports a landscape resolution (e.g., 1280x800) for a portrait-stride
hardware setup, removing this dynamic swap leaves the dimensions uncorrecte=
d.

For drivers like simpledrm (which do not use EDID) or even efidrm (where the
framebuffer geometry is derived from the uncorrected si->lfb_width and
si->lfb_height), this will result in complete display corruption due to
mismatched strides.

Since the kernel has a strict policy against regressions, advising users to
update their firmware to fix a kernel-introduced regression might not be
sufficient.

Could this be fixed by keeping the quirk but conditionally applying the swap
inside efifb_swap_width_height() only if si->lfb_width > si->lfb_height?
This approach might fix the geometry for newer BIOS releases without breaki=
ng
the older ones.

>  	{
>  		/*
>  		 * Lenovo IdeaPad Duet 3 10IGL5 and 10IGL5-LTE with

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901082057.3761=
7-1-tzimmermann@suse.de?part=3D1
