Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D7606A31B
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZG0DhMsC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9948010E3F6;
	Sun, 25 Oct 2026 22:50:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CEF10E3F6
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:50:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2555A600AA;
 Sun, 25 Oct 2026 22:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FA61F01825;
 Sun, 25 Oct 2026 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792968614;
 bh=Rp4z2kzfMPHK5oeKxjiNxWscDHyNV+ud93Jr+JGfXyk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZG0DhMsCT3b74bhJnHkcJLwzo9O1BWr74fakgt5M0FibssZN3ZgvfxdnuVXOlMPRY
 rD067HTE90jw8sk6sFn/mZlTX9seTpi93NVz/p3yhKhv3WdAaRQB+2RWzD9brnOQwF
 w7r34fjVzaD5Q6BBVTFEtdGpkmxpHYyJxzNrNi1DjEn/3Mx9vhN7s7pPQIhoMyw6Wr
 qd8GtUjvV3DrIldZW9goi3U0NmpHkibuETeEg17iBbBIYub2Sika2MGs9CPqwOVa2S
 aYV6oWGJkSVFVYFnysCK2B0aQ/L+RDZrJdHpk0qh9YIBYpL4pSQ16Taxx1e6uozTx4
 C8d4UVcmpNuPQ==
Message-ID: <sashiko-outbox-184506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/tegra: Support YVU formats
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261025-tegra-drm-yvu420-v4-2-30b3bb0d0752@gmail.com>
References: <20261025-tegra-drm-yvu420-v4-0-30b3bb0d0752@gmail.com>
 <20261025-tegra-drm-yvu420-v4-2-30b3bb0d0752@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:50:14 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/tegra: missing DRM_FORMAT_YVU422 in tegra_shared_plane_forma=
ts[]
--

commit e7e49e62ddbbdc37f4015e827f67d01e9ee20c45
Author: Aaron Kling <webgeek1234@gmail.com>

drm/tegra: Support YVU formats

This commit adds support for the YVU420, YVU422, and YVU444 pixel formats to
the Tegra DRM plane and display controller drivers by mapping them to the
corresponding YCbCr planar formats with UV plane swapping enabled.

> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index 5a86f8260f136..46756c749e674 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -51,6 +51,7 @@ static const u32 tegra_shared_plane_formats[] =3D {
>  	DRM_FORMAT_YUYV,
>  	DRM_FORMAT_YUV420,
>  	DRM_FORMAT_YUV422,
> +	DRM_FORMAT_YVU420,
>  };

[Severity: Medium]
Should DRM_FORMAT_YVU422 also be included in tegra_shared_plane_formats[]?

The commit message notes that YVU422 and YVU444 are added where supported,
and tegra_shared_plane_formats[] already includes DRM_FORMAT_YUV422. In
drivers/gpu/drm/tegra/plane.c, tegra_plane_format() translates
DRM_FORMAT_YVU422 to WIN_COLOR_DEPTH_YCbCr422P with swap_uv set to true, and
tegra_shared_plane_atomic_update() in drivers/gpu/drm/tegra/hub.c programs
SWAP_UV in DC_WIN_PRECOMP_WGRP_PARAMS.

Without DRM_FORMAT_YVU422 in tegra_shared_plane_formats[], commits or format
queries for DRM_FORMAT_YVU422 on shared planes created via
tegra_shared_plane_create() will be rejected by
drm_plane_check_pixel_format().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-tegra-drm-=
yvu420-v4-0-30b3bb0d0752@gmail.com?part=3D2
