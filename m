Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEF606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DG/1pdRK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A9110E306;
	Sat, 21 Nov 2026 13:23:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB7110E306
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:22:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C3A560A75;
 Sat, 21 Nov 2026 13:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BCF1F000C4;
 Sat, 21 Nov 2026 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795267374;
 bh=Bl6XKMpKrqylb5koi+Nuo2mllMBjHmIeQHIce2h6dtY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DG/1pdRK79zJP3hPRXoCz1Kgf3kJHpm94L8FiAq4KTG1Mc/gRrUbDeG5MrRmzhLOw
 yae7F979BaZHe3rFVKvcJ7mUdfwtJlBP6W57p9xuym/7j8fT2lhYsUR80Xb1L9kapZ
 d7kd/8HbKqrcdH5pKl5//QeBetgBz+sQqYRjm54UJShu6rOvp8ziuk4muNxT2NqdNv
 qqROrV5vSXu1e+3SY8uQT9Q8VT/Z1CESCt9T39a9UO6KuJsfKG8rnoH0DQH5wemE8K
 gyK02Ier7iDCIFEIFhqlJO4BR9wyNcWujHhfOta8mEEyaU1LxNyK+vTfLTrtp39JjV
 bJ2TVPrbOcJeA==
Message-ID: <sashiko-outbox-227067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] drm/rockchip: vop2: Select the CSC matrix from
 the DRM colorimetry
To: =?utf-8?b?SmFuIENsYXXDn2Vu?= <jan.claussen10@web.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261121131126.3358-7-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
 <20261121131126.3358-7-jan.claussen10@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 13:22:53 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/rockchip: vop2: dropped BT.601 mappings in
  vop2_convert_csc_mode()
--

commit 2d1b69aeefd3a8b09e750140ac04acf448f1e9ea
Author: Jan Clau=C3=9Fen <jan.claussen10@web.de>

drm/rockchip: vop2: Select the CSC matrix from the DRM colorimetry

This commit replaces the V4L2 colorspace field in struct
rockchip_crtc_state with enum drm_colorspace and selects the VOP2 CSC
format directly from DRM_MODE_COLORIMETRY_* values.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index bfb3841425687..41035bf27491d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -647,20 +645,13 @@ static void vop2_setup_scale(struct vop2 *vop2, con=
st struct vop2_win *win,
>  	}
>  }
> =20
> -static int vop2_convert_csc_mode(int csc_mode)
> +static enum vop_csc_format
> +vop2_convert_csc_mode(enum drm_colorspace colorspace)
>  {
> -	switch (csc_mode) {
> -	case V4L2_COLORSPACE_SMPTE170M:
> -	case V4L2_COLORSPACE_470_SYSTEM_M:
> -	case V4L2_COLORSPACE_470_SYSTEM_BG:
> -		return CSC_BT601L;
> -	case V4L2_COLORSPACE_REC709:
> -	case V4L2_COLORSPACE_SMPTE240M:
> -	case V4L2_COLORSPACE_DEFAULT:
> -		return CSC_BT709L;
> -	case V4L2_COLORSPACE_JPEG:
> -		return CSC_BT601F;
> -	case V4L2_COLORSPACE_BT2020:
> +	switch (colorspace) {
> +	case DRM_MODE_COLORIMETRY_BT2020_RGB:
> +	case DRM_MODE_COLORIMETRY_BT2020_YCC:
> +	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
>  		return CSC_BT2020L;
>  	default:
>  		return CSC_BT709L;

[Severity: Low]
Should vop2_convert_csc_mode() keep mappings for BT.601 colorimetries (such
as DRM_MODE_COLORIMETRY_SMPTE_170M_YCC and DRM_MODE_COLORIMETRY_BT601_YCC),
or should the unused BT.601 matrix tables be dropped if BT.601 is not
needed?

Dropping CSC_BT601L and CSC_BT601F here causes any BT.601 colorspace to
fall back to CSC_BT709L and leaves the CSC_BT601L and CSC_BT601F cases (and
rgb2yuv_bt601l / rgb2yuv_bt601f) in vop2_rgb2yuv_get_matrix() unreachable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121131126.3358=
-1-jan.claussen10@web.de?part=3D6
