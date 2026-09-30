Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21CBCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBAB10F3D0;
	Wed, 30 Sep 2026 12:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F2x4rqgr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC38210F3AB
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:57:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48D3943D6C;
 Wed, 30 Sep 2026 12:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011DB1F000FF;
 Wed, 30 Sep 2026 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790773060;
 bh=Dg10WxJnrnZlxPq6/Eyc+g3b13lNM4i3pQCpDYfopVA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F2x4rqgrrNTNCmcCfIdgFU1W6XxxF+r8omzeHbILURWmRPDIwGMXEwLOvzdjmej7A
 xZ+SxP4j87K4b9D19R8H/bWPyFBP8C42SPxcm5OC3GfIOu2ix6W09/5psLANbPpBij
 P7hHmalMP6lGk+dPNtsR7UXc9c81ViODwtdFYUCOy+P7GEBHUIDYAOnXlG4DcAH0nS
 y34whpbYKq7W50RsToPs8Wqf94Nb1vpt/OLBdUvhX0RhLr/tF3+Le3+WWtUfGfQ/78
 3dmika4TuHfAsknifvGbGEG3Uzh12b7rqGWg2UuLLKAWqJjI97MiJNoxroBHJUG0it
 Kxg89GK0p5C2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] drm/msm/dp: Signal BT.2020 RGB on DP and eDP
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930-msm-dp-hdr10-v1-10-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-10-dbbf8b2b42bc@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 12:57:39 +0000
Message-Id: <20260930125740.011DB1F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: PSR state mismatch causes blank screen for YUV420 modes
--

commit 1a1587a85fbd9d8b79a76366fd11f806251ab09b
Author: Xilin Wu <sophon@radxa.com>
Subject: drm/msm/dp: Signal BT.2020 RGB on DP and eDP

This commit exposes the DP Colorspace property and handles VSC packets
in the bridge atomic state. It disables PSR in the controller and sink
while colorimetry VSC packets are active, as they cannot share the
automatic PSR packet generator.

> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_=
drm.c
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -208,12 +208,13 @@ static int msm_edp_bridge_atomic_check(struct drm_b=
ridge *drm_bridge,
>  	if (WARN_ON(!conn_state))
>  		return -ENODEV;
> =20
> -	conn_state->self_refresh_aware =3D dp->psr_supported;
> +	conn_state->self_refresh_aware =3D dp->psr_supported &&
> +		conn_state->colorspace =3D=3D DRM_MODE_COLORIMETRY_DEFAULT;

[Severity: High]
Does this logic create a state mismatch for YUV420 modes between software
and hardware?

In msm_dp_display_atomic_check(), state->vsc_enabled is correctly set to
true for YUV420 modes:

msm_dp_display_atomic_check() {
    ...
    state->vsc_enabled =3D drm_mode_is_420_only(info, mode) ||
                         state->colorspace !=3D DRM_MODE_COLORIMETRY_DEFAUL=
T;
    ...
}

When vsc_enabled is true, hardware PSR is then disabled in
msm_dp_display_post_enable():

msm_dp_display_post_enable() {
    ...
    if (msm_dp_display->psr_supported)
        msm_dp_ctrl_config_psr(dp->ctrl, dp->panel, !dp->panel->vsc_enabled=
);
    ...
}

However, msm_edp_bridge_atomic_check() only checks the colorspace against
DRM_MODE_COLORIMETRY_DEFAULT to determine if the connector is self-refresh
aware. Because it misses the check for YUV420 modes, the DRM core might
believe PSR is supported and active, while the driver explicitly disables
hardware PSR.

Could this cause the host to stop transmitting video data for self-refresh
while the panel is not actually in self-refresh mode, leading to a blank
screen or PSR entry timeouts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-msm-dp-hdr=
10-v1-0-dbbf8b2b42bc@radxa.com?part=3D10
