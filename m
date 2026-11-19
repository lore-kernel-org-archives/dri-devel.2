Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303C606A338
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6b945BF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C94111218E;
	Thu, 19 Nov 2026 08:41:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45ED311218E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:41:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BA8F47871;
 Thu, 19 Nov 2026 08:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9441F000C6;
 Thu, 19 Nov 2026 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795077665;
 bh=AV/erBw/k4KzjHXr4eEGKkSKWChH3lqU/mu/W84MX7k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k6b945BFGnB7M6Xw8Zebowwp+UaKBVSXHrZGmV4BWJ+jtKzF1KIK4ttIJDHf3sMKz
 egmnUZ0KofOI1ZTmTcPldjpTNnUV5p/GFnJ77bQ8V7G1QvdOOLADa572GoXRkQMxDq
 5motl2X9iWWIt7pmBF2JoxOyMrpMNhyfa7RqjKpM7JZ730Z+jq2z77iA3zHorjm9m2
 YU1CpO4TuzSkbrsn9gZdmG8QiL6Go9WacA3GYHMewbyEE2muP0oJ+UfbSJOnd7dskU
 Y6wv7QQSpXX5t5C+QuEz1S0NW/VSm1s/DA1XPeIGwNhRwe2bRvqQutL6mC+nrlaVp9
 p38m9trJJs+iQ==
Message-ID: <sashiko-outbox-222696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/29] drm/msm/dp: move link capabilities to dp_link
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-17-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-17-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:41:05 +0000
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
- [Medium] drm/msm/dp: msm_dp_display_mode_valid() ignores info for
  dp->connector
--

commit 9b5a2b4fd3cc486b889af124992a49541fad1c12
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: move link capabilities to dp_link

This commit moves link_info (renamed to link_caps) and vsc_sdp_supported
from struct msm_dp_panel to struct msm_dp_link so that SST and MST panels
share the physical link capabilities.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index fb72b77e9c95e..a77a286a24629 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -813,7 +813,7 @@ enum drm_mode_status msm_dp_display_mode_valid(struct=
 msm_dp *dp,
>  	}
> =20
>  	msm_dp_display =3D container_of(dp, struct msm_dp_display_private, msm_=
dp_display);
> -	link_info =3D &msm_dp_display->panel->link_info;
> +	link_info =3D &msm_dp_display->link->link_caps;
> =20
>  	is_yuv_420 =3D drm_mode_is_420_only(&dp->connector->display_info, mode);
> =20
> @@ -821,7 +821,7 @@ enum drm_mode_status msm_dp_display_mode_valid(struct=
 msm_dp *dp,
>  	 * YUV 420 is carried over DP by signalling the colorimetry through a
>  	 * VSC SDP, so a 420-only mode cannot be driven without VSC SDP support.
>  	 */
> -	if (is_yuv_420 && !msm_dp_display->panel->vsc_sdp_supported)
> +	if (is_yuv_420 && !msm_dp_display->link->vsc_sdp_supported)
>  		return MODE_NO_420;
> =20
>  	link_pclk_khz =3D is_yuv_420 ? mode_pclk_khz / 2 : mode_pclk_khz;

[Severity: Medium]
Should msm_dp_display_mode_valid() use its info parameter instead of
dp->connector->display_info when checking drm_mode_is_420_only() and
reading info->bpc?

In MST mode, msm_dp_mst_connector_mode_valid() passes the per-port MST
connector's display_info as info, whereas dp->connector is the root SST
connector whose EDID is not read for MST sinks.  Using
dp->connector->display_info causes YUV 4:2:0-only modes on MST sinks to
go undetected (skipping the vsc_sdp_supported check and failing to halve
the pixel clock, which can reject valid 4:2:0 modes with MODE_CLOCK_HIGH
or MODE_BAD) and computes mode_bpp from the wrong connector.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D17
