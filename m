Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29B6CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4101B10F624;
	Fri, 19 Jun 2026 14:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CmSN3Tai";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FBE10F624
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:13:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D817D4077C;
 Fri, 19 Jun 2026 14:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945271F000E9;
 Fri, 19 Jun 2026 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781878437;
 bh=zPDvVcTvjVVEsuTHXXp+vqqU25WRX1PLbLXdBhPbA8A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CmSN3TaiGoDJlNvDLn/mVx57HqK85Id9IEHDABuFhHi7pc2pifHHZxHLM/HHc8COe
 Mb4nZPiVsEHiCfpaX7szf1q3knB3ofXaNKdmy3UYJ6pggzsC1Z2iljSx1dDCDbaNZ+
 EX0qyQiLeUa0Kkor3KssZg4FZZPXBEqefYgYJiXsJpNd5E0B/H4y8R4OsZ4MZAixVN
 pL8dvv7rftVepnGLn40sGugH8c5dk2kkA+hgtgFZ8FGpjXvAPMRt/cStxupksvbNeH
 TNeUcnEKxp8kWunrQpCC/kkuyNuVVB1tJZrG9+eRuj24h6MdDYRqchXED4ubjtDNTL
 ah7Bj+pFptJlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/sysfb: simpledrm: Improve framebuffer-size
 validation
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619135847.309664-2-tzimmermann@suse.de>
References: <20260619135847.309664-1-tzimmermann@suse.de>
 <20260619135847.309664-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 14:13:57 +0000
Message-Id: <20260619141357.945271F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch updates all callers of the local static wrapper `simplefb=
_get_validated_int0()` to call `drm_sysfb_get_validated_int0()` directly, b=
ut leaves the static function definition behind, causing a compiler warning.

Pre-existing issues:
- [High] Missing validation between the firmware-provided framebuffer dimen=
sions (stride, width, height) and the size of the memory region allows out-=
of-bounds virtual memory writes.
--

commit 934b7fe8edd3f05582affbe138506d555774f080
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: simpledrm: Improve framebuffer-size validation

Validate the framebuffer size from the firmware against the limitations of
struct drm_display_mode. Fail probing on errors if the size exceeds the
16-bit fields.

> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index fc168920f2c64..03bd19fadccd5 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -88,14 +88,14 @@ static int
>  simplefb_get_width_pd(struct drm_device *dev,
>  		      const struct simplefb_platform_data *pd)
>  {
> -	return simplefb_get_validated_int0(dev, "width", pd->width);
> +	return drm_sysfb_get_validated_int0(dev, "width", pd->width, U16_MAX);
>  }

[Severity: Low]
Does this leave simplefb_get_validated_int0() as an unused static function?

Since all four callers (simplefb_get_width_pd, simplefb_get_height_pd,
simplefb_get_width_of, simplefb_get_height_of) are updated to call
drm_sysfb_get_validated_int0() directly, simplefb_get_validated_int0()
appears to have zero callers remaining in simpledrm.c. This can trigger a
-Wunused-function compiler warning.

[Severity: High]
This isn't a bug introduced by this patch, but while we are improving the
validation of framebuffer dimensions from firmware, should we also validate
that the resulting framebuffer size actually fits within the mapped memory
region?

The firmware-provided stride and height are used to calculate the framebuff=
er
size, but when acquiring the memory region:

drivers/gpu/drm/sysfb/simpledrm.c:simpledrm_device_create() {
    ...
	screen_base =3D devm_memremap(dev->dev, mem->start, resource_size(mem), ME=
MREMAP_WC);
    ...
}

or the fallback:

drivers/gpu/drm/sysfb/simpledrm.c:simpledrm_device_create() {
    ...
	screen_base =3D devm_ioremap_wc(&pdev->dev, mem->start, resource_size(mem)=
);
    ...
}

It seems we map exactly resource_size(mem) bytes without verifying if
(stride * height) exceeds that size. If the firmware provides a mismatched
configuration, out-of-bounds writes could occur during plane updates when
copying pixel data into sysfb->fb_addr.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619135847.3096=
64-1-tzimmermann@suse.de?part=3D1
