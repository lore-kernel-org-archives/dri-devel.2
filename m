Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F9FC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EF310EC81;
	Wed, 22 Jul 2026 07:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JRJCBdpQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E47710EC81
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:03:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E995260A64;
 Wed, 22 Jul 2026 07:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F02F1F000E9;
 Wed, 22 Jul 2026 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703813;
 bh=fMeQi/iytPFu6JtXIKCghIfuAZK7zjJE6z+B6e8fRfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JRJCBdpQWJl7RH1btHuBIO+H3mShP7JGYnIvpz7Pr+K6OBDDrf6sbh0swiDc5gSK0
 JPhanMPYkKaV840otfMxUPlRP1UoXwoH3cB2a/wplFCpqXo63xAYWs9LV0EBIyRGMu
 8hR/cChLFrgMqQ/zcDp/lW9ZvoFIUTHAIV2mApZDvuO2lo+rjSLFLH5w+VycluXIvS
 n30AZ0yDyeiKYat48Pd5UOpfqvNlEm3A7q2I8N62CJKIy7YcRqstx+omg2XMNtewbO
 ngM2+IGqXrMeaFI/uxzZAbImWMyntDHoukGB7W3QU83+6x+Ey/G1NKi/IuneaOHCUU
 QvqbPLPHG5AoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/24] drm/msm/dp: reject YUV420-only modes without VSC
 SDP support
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-1-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-1-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:03:33 +0000
Message-Id: <20260722070333.7F02F1F000E9@smtp.kernel.org>
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
- [High] The patch relies on mode filtering to replace explicit VSC SDP sup=
port checks, but fails to apply this filtering to eDP, causing a DPU/DP sta=
te mismatch.

Pre-existing issues:
- [High] msm_dp_wide_bus_available() incorrectly uses the currently active =
hardware state to determine if wide bus can be used for a proposed mode, po=
tentially rejecting valid high-bandwidth modes.
--

--- Patch [1]: [PATCH 01/24] drm/msm/dp: reject YUV420-only modes without V=
SC SDP support ---
commit 978b7d550fcfcaed1db8ec32849e99ffcd2880a7
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dp: reject YUV420-only modes without VSC SDP support

This patch updates DP mode validation to explicitly reject YUV420-only
modes if the panel lacks VSC SDP support. By filtering these out, the
DPU encoder logic is simplified to assume any validated 420-only mode
has VSC SDP support.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 778e231d49677..1f20695f81e35 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -710,8 +710,7 @@ void dpu_encoder_update_topology(struct drm_encoder *=
drm_enc,
>  		if (fb && MSM_FORMAT_IS_YUV(msm_framebuffer_format(fb)))
>  			topology->num_cdm++;
>  	} else if (disp_info->intf_type =3D=3D INTF_DP) {
> -		if (msm_dp_is_yuv_420_enabled(priv->kms->dp[disp_info->h_tile_instance=
[0]],
> -					      adj_mode))
> +		if (drm_mode_is_420_only(&connector->display_info, adj_mode))
>  			topology->num_cdm++;

[Severity: High]
Does this change break mode validation for eDP displays by assuming VSC SDP
support is always present for 420-only modes?

This patch adds mode filtering to msm_dp_bridge_mode_valid() to reject modes
without VSC SDP, so that dpu_encoder_update_topology() can assume all
420-only modes are fully supported.

However, the eDP validation function, msm_edp_bridge_mode_valid(), does not
appear to have the same filtering logic applied.

If an eDP sink advertises a YUV420-only mode without VSC SDP support, will =
it
pass validation, causing dpu_encoder_update_topology() to allocate a CDM
block (expecting YUV420) while the DP controller is still configured for RG=
B?

>  	}
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index dc6f33809ca5f..e0c44eef3abab 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -709,9 +710,16 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct=
 drm_bridge *bridge,
>  	msm_dp_display =3D container_of(dp, struct msm_dp_display_private, msm_=
dp_display);
>  	link_info =3D &msm_dp_display->panel->link_info;
> =20
> -	if ((drm_mode_is_420_only(&dp->connector->display_info, mode) &&
> -	     msm_dp_display->panel->vsc_sdp_supported) ||
> -	     msm_dp_wide_bus_available(dp))
> +	is_yuv_420 =3D drm_mode_is_420_only(&dp->connector->display_info, mode);
> +
> +	/*
> +	 * YUV 420 is carried over DP by signalling the colorimetry through a
> +	 * VSC SDP, so a 420-only mode cannot be driven without VSC SDP support.
> +	 */
> +	if (is_yuv_420 && !msm_dp_display->panel->vsc_sdp_supported)
> +		return MODE_NO_420;
> +
> +	if (is_yuv_420 || msm_dp_wide_bus_available(dp))
>  		mode_pclk_khz /=3D 2;

[Severity: High]
This is a pre-existing issue, but does msm_dp_wide_bus_available() check
the active hardware state rather than the proposed mode?

During mode validation in msm_dp_bridge_mode_valid(), the code checks:
	if (is_yuv_420 || msm_dp_wide_bus_available(dp))

However, msm_dp_wide_bus_available() evaluates the currently active modeset
instead of the proposed mode:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_wide_bus_available() {
	...
	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
		return false;
	...
}

If userspace probes a high-bandwidth RGB mode while the current display sta=
te
is YUV420, could this incorrectly restrict hardware capability based on
the transient state and improperly reject valid modes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D1
