Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3024AC4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D9810E963;
	Mon, 20 Jul 2026 14:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fVRIX9lQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A8710E95C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:28:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9308D41384;
 Mon, 20 Jul 2026 14:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C221F000E9;
 Mon, 20 Jul 2026 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784557729;
 bh=AGrJAALXlSbavHfUw+B6G72oi1T1egzamMRPRWTgucU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fVRIX9lQ58V2suPiK1WAY+JI8agfRnGuyN4nQVDCAVJ1Q9judxAsUZ40pzjo5gp8h
 6w/WPCoWCNTTYaZ1XW0mjUk4rt6NKxYEN6mvgZ6+gvVTuWZdxdO5PEkXYIeE/Fc+kU
 27y4GkOnIvI0zDYlQaQlxp3z1KxC56Ujhchl+6h9KlTZRyLHMii/fjuZcKjazwi2fj
 dqSqf52Yq23WcQhw7yBG2tP4kT8kx+kB9NzLYwL74kew3E/xTB9ctcGB+3RXDiq2YB
 AsVLIi8p+sYQE4lKxieUYGlNOCT1mdY+iarHZJsuCaO73UF7VuE5/v8u4RQEXHjRiE
 i1I2IFCsIEVtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/fourcc: Add modifiers for AMD GFX6-8
To: =?utf-8?b?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720142440.22076-2-timur.kristof@gmail.com>
References: <20260720142440.22076-1-timur.kristof@gmail.com>
 <20260720142440.22076-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:28:48 +0000
Message-Id: <20260720142849.56C221F000E9@smtp.kernel.org>
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
- [Low] Missing asterisk prefix in the block comment for the '55:14' bitfie=
ld description.
--

--- Patch [1]: [PATCH 1/4] drm/fourcc: Add modifiers for AMD GFX6-8 ---
commit 215c005d35d2f0c0a64b0b0e5472a7d7f6157bd5
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>

drm/fourcc: Add modifiers for AMD GFX6-8

This commit introduces DRM format modifiers for AMD GFX6-8 GPUs, the oldest
families supported by the amdgpu driver. It defines array modes, micro tile
modes, and macro tile parameters to facilitate sharing buffers between
processes and devices.

> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 3a4d4dc635bf5..d9be41fef478b 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
[ ... ]
> @@ -1646,36 +1646,69 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 m=
odifier)
[ ... ]
> + * DRM format modifier fields on AMD GPUs:
> + *     7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
> + *    12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version=
>_*
> + *      13 DCC                      Delta Color Compression, supported o=
n GFX8 and newer
>       55:14 (chip specific)          See below for details, depends on GF=
X block version
       ^^^^

[Severity: Low]
This isn't a bug, but it looks like the asterisk prefix is missing from this
line of the comment block. Should an asterisk be added here to match the re=
st
of the formatting?

> + *   63:56 Vendor                   Value is DRM_FORMAT_MOD_VENDOR_AMD
> + *
> + * Chip specific fields on Gfx9 and newer:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720142440.2207=
6-1-timur.kristof@gmail.com?part=3D1
