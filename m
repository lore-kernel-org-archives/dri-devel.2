Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF137C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A0710E687;
	Mon, 20 Jul 2026 06:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gIjrU8gN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307CF10E687
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:27:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19BD94122D;
 Mon, 20 Jul 2026 06:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E741F000E9;
 Mon, 20 Jul 2026 06:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784528828;
 bh=ENm+VSnesq8pGr3OlPDcuxVkIN37q9le4dCi4YnvPRg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gIjrU8gN9fOhmlH11KGqmc4EDJnNd6t7fCee3xnfom/98lb9X0ZMMzqxublf/pdTK
 X12Qk6PNqAXe4gn3bGieCp43kzB+gqC93xrZDf1aYYqKF5oJ5Tv+MPtm6MEngNcvay
 0303rnOQnNPhDXDv/5Z6hTynTxz1MSFn7crEPcrcR+VnsTCqBalSioOczM7Si0w8gb
 BhWNQaX/yLsho1pN5HTX6KqXd32FGPws4rXlPv2WTOoWBd6/z1X2GXW3fa9GPygr8P
 hqpQibRd+1r3SvO1ST+1MNGGOMIkTYPrzwjUP1MAukTiF5tCsVQsvXb+fpJvSS+ncc
 PkWUTm7JMnqGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/15] drm/msm/dp: make bridge helpers use dp_display
 to allow re-use
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-dp_mstclean-v8-13-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-13-bea261bf4e7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:27:07 +0000
Message-Id: <20260720062707.C6E741F000E9@smtp.kernel.org>
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
- [Medium] The refactoring of `msm_dp_display_atomic_enable` hardcodes the =
primary bridge's encoder, breaking the MST reuse it was explicitly intended=
 to support.
--

--- Patch [13]: [PATCH v8 13/15] drm/msm/dp: make bridge helpers use dp_dis=
play to allow re-use ---
commit 94e6d1d4d94637e92b8d6868e076b0bb8d8e32d0
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
drm/msm/dp: make bridge helpers use dp_display to allow re-use

This commit refactors the DP bridge helpers to directly take a msm_dp_displ=
ay
object instead of a drm_bridge. The stated goal is to allow the upcoming MST
bridge implementation to reuse these same helpers.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -1408,11 +1405,9 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_disp=
lay, struct drm_device *dev,
>  	return 0;
>  }
> =20
> -void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> -				 struct drm_atomic_commit *state)
> +void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
> +				  struct drm_atomic_commit *state)
>  {
> -	struct msm_dp_bridge *msm_dp_bridge =3D to_dp_bridge(drm_bridge);
> -	struct msm_dp *msm_dp_display =3D msm_dp_bridge->msm_dp_display;
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *crtc_state;
>  	int rc =3D 0;
> @@ -1421,7 +1416,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge =
*drm_bridge,
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
>  	crtc =3D drm_atomic_get_new_crtc_for_encoder(state,
> -						   drm_bridge->encoder);
> +						   msm_dp_display->bridge->encoder);

[Severity: Medium]
The commit message mentions this refactoring is done so the MST bridge can
re-use these helpers. However, doesn't replacing the caller-provided
drm_bridge->encoder with the hardcoded primary encoder break that intended
reuse?

If an MST stream calls this helper with its own virtual encoder's state,
drm_atomic_get_new_crtc_for_encoder() will evaluate the primary encoder
instead. Because the primary encoder won't be attached to the MST stream's
CRTC in this atomic state, crtc will be NULL, causing this function to
silently return early.

Would it be better to retain the drm_bridge parameter or pass the drm_encod=
er
directly so that MST callers can specify their virtual encoder?

>  	if (!crtc)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-dp_mstclea=
n-v8-0-bea261bf4e7d@oss.qualcomm.com?part=3D13
