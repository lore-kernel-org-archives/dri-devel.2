Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE1FC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DA110E0DC;
	Fri, 14 Aug 2026 07:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cBPf4laY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6756910E0DC
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:01:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2044F600AD;
 Fri, 14 Aug 2026 07:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23B31F000E9;
 Fri, 14 Aug 2026 07:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786690876;
 bh=HdDwBQn6ZaQivdtdMuGrjuJofyOFeCCI++we2mSfYwk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cBPf4laY7BUuCYCgU/Z/EDfatbcy3iOI/5lmDs3BNfP7ioCGPanYI5HeRLpOpqMi7
 VUCpGpfOQrmgnQ4W8OzV9c1LWSsCwK/QX6eEE8FjBE5zgdaDQ1+XV76qEd1SnOfwVq
 0HLi5JWcXn+Is1xubPOweNeaxGLSLvz/EA29CDWZVll5r4HUgUGafXHk/HP4+rHaLP
 17DvarqtPvVPs/TfDWkZtDTOVFOmoM3uNYEoWMoTd/mw4YOPmib7JMy2fdAAgcfehE
 tHGr1kSMvo7sbz3A74DsVbT27rDVk+ykfUTlyCmRarhfKqXwA2qnZbtLT86yms43XZ
 A7xbyzi+K5RDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] video: fbdev: via: refactor strcpy and viafb_name
To: "Ajith P V" <ajithpv.linux@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814065433.269375-1-ajithpv.linux@gmail.com>
References: <20260814065433.269375-1-ajithpv.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:01:16 +0000
Message-Id: <20260814070116.A23B31F000E9@smtp.kernel.org>
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
- [Critical] Changing the driver identification string exposed in the fb_fi=
x_screeninfo structure from "Via" to "viafb" breaks userspace ABI backward =
compatibility.
--

--- Patch [1]: [PATCH v2] video: fbdev: via: refactor strcpy and viafb_name=
 ---
commit 31193988a75e693bb97d9723171d248ff11a2f17
Author: Ajith P V <ajithpv.linux@gmail.com>

video: fbdev: via: refactor strcpy and viafb_name

This commit replaces unbounded strcpy() calls with strscpy() to harden the
framebuffer screen info initialization. It also converts the viafb_name
pointer into a static const char array and changes its string value.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy=
 [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

> diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via=
/viafbdev.c
> index 80f95dac32c8c..b3a2e07b61a7c 100644
> --- a/drivers/video/fbdev/via/viafbdev.c
> +++ b/drivers/video/fbdev/via/viafbdev.c
> @@ -16,7 +16,7 @@
>  #define _MASTER_FILE
>  #include "global.h"
> =20
> -static char *viafb_name =3D "Via";
> +static const char viafb_name[] =3D "viafb";

[Severity: Critical]
Does changing this string from "Via" to "viafb" cause a userspace ABI
regression?

Userspace tools and display servers, such as Xorg's via driver, often
rely on the exact identification string returned in the id field of
fb_fix_screeninfo by the framebuffer ioctl to detect hardware and apply
specific quirks.

Could the compile-time bounds checking and optimization benefits still be
achieved without modifying the exposed string value, perhaps by defining
it as 'static const char viafb_name[] =3D "Via";' instead?

>  static u32 pseudo_pal[17];
> =20
>  /* video mode */

[ ... ]

> @@ -144,7 +144,7 @@ static void viafb_setup_fixinfo(struct fb_fix_screeni=
nfo *fix,
>  	struct viafb_par *viaparinfo)
>  {
>  	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
> -	strcpy(fix->id, viafb_name);
> +	strscpy(fix->id, viafb_name, sizeof(fix->id));
> =20
>  	fix->smem_start =3D viaparinfo->fbmem;
>  	fix->smem_len =3D viaparinfo->fbmem_free;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814065433.2693=
75-1-ajithpv.linux@gmail.com?part=3D1
