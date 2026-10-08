Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE00CA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F2B10FB9E;
	Thu,  8 Oct 2026 21:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b7sulWUJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1521B10FB9E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:06:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD12C40B93;
 Thu,  8 Oct 2026 21:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901A01F000FF;
 Thu,  8 Oct 2026 21:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791493562;
 bh=1TZSEIrQD9ZFj08rbHC3nXsKWNOOguCZqrJktQPY32o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b7sulWUJnDAXEt8/m09ma+k5SikPRIM/hjsZYw11XIVUjyLRMZbhqHr7aQKIEe9ou
 HtFiKj08tww2rSOyZDbtq+Z0wEKV4nRQsP77MxYFzhJiR2DfIkR5HJ2ENcigAUPwcF
 anaq30YMMGlWxJc7lOSpNpHy8sDsa3dnkUgiHH7Xw79ULozNhqusDyS9NOSGbHb6HK
 qjiQjQUpMX7cke2aqbI8NtIPAPCi42t9D5zcvR7XisYfGhC9vvpOr5d9PdB8jFFUD9
 DC5b9w0REkjii2Ld2TszZn4sjIlC/CkVJ32MXMTESwSJwNe9ELEbaectwSzY5GG0tl
 6X/psEMo4gJuw==
Message-ID: <sashiko-outbox-164596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/tegra: Support YVU420
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-tegra-drm-yvu420-v1-2-dc1c443c00f3@gmail.com>
References: <20261008-tegra-drm-yvu420-v1-0-dc1c443c00f3@gmail.com>
 <20261008-tegra-drm-yvu420-v1-2-dc1c443c00f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 21:06:02 +0000
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
- [Medium] drm/tegra: DRM_FORMAT_YVU420 missing from tegra20_overlay_formats
--

commit f3a502c3f44845d367e8abc769d6a35f5bac0739
Author: Aaron Kling <webgeek1234@gmail.com>

drm/tegra: Support YVU420

This commit adds support for the YVU420 video format. It updates the format
lists for tegra114, tegra124, and shared planes, and adds logic to handle
UV swapping in the plane format configuration.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 76d3841a17b8b..57146c41c0972 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -1312,6 +1312,7 @@ static const u32 tegra114_overlay_formats[] =3D {
>  	DRM_FORMAT_YUYV,
>  	DRM_FORMAT_YUV420,
>  	DRM_FORMAT_YUV422,
> +	DRM_FORMAT_YVU420,

[Severity: Medium]
Should this format also be added to tegra20_overlay_formats?

The commit adds DRM_FORMAT_YVU420 to tegra114_overlay_formats,
tegra124_overlay_formats, and tegra_shared_plane_formats, but it appears
to be omitted from tegra20_overlay_formats in the same file.

Since YVU420 support relies purely on software configuration by setting
swap_uv =3D true, which directs the driver to swap the pointers programmed
into the U and V hardware registers in tegra_dc_setup_window() and
tegra_shared_plane_atomic_update(), is it fully compatible with
Tegra20/30 platforms since they already support DRM_FORMAT_YUV420?

If so, does omitting it unnecessarily block Tegra20/30 platforms from
advertising YVU420 support to userspace, causing fallbacks to software
composition for video playback?

For context, tegra20_overlay_formats currently only includes:

static const u32 tegra20_overlay_formats[] =3D {
...
	DRM_FORMAT_UYVY,
	DRM_FORMAT_YUYV,
	DRM_FORMAT_YUV420,
	DRM_FORMAT_YUV422,
};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-tegra-drm-=
yvu420-v1-0-dc1c443c00f3@gmail.com?part=3D2
