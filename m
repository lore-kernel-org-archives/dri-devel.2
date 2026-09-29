Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B53C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E7A10ECBD;
	Tue, 29 Sep 2026 04:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H8HDhsMi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E8910ECBD
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:43:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A80460210;
 Tue, 29 Sep 2026 04:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC341F000FF;
 Tue, 29 Sep 2026 04:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790656986;
 bh=Do1H7o1I4mQpdnRG5+CsaV4jEnTgQwUd1Ut6Rjpkesg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H8HDhsMiM/W+bepsQJRvkI/3LtXTl/kYaLGavv4ZShw2SWmb5Uq0XFcqqEUadsefw
 9zMr59mGjoIUMS/V5e4iYYrpQOR9qAiWuyaTZb41+ITES4qkpwYjvnoE1xPZ4cQh2t
 1PtKbdNiwNpJGWIUXH3umDgF8dUOtUP+afBNs6Jz+L8tzTLVUkatvT04UpI8XXuZVL
 roYNdBFVhho3/iHSme3iOgIkYr4LJcBEvGiP98mbUGLBpgQHWac5JOQ2raL2+ha23H
 OUD42oWb5ZdL0QPgzqPQ/JRsTIMeiYeoyrIVMI5p9+EpucvEFDAwpPtIrNdxQ1/B5H
 uTNbQ5fdKNcZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/35] drm/msm/dp: factor out _helper variants of
 bridge ops accepting a panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-15-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-15-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:43:05 +0000
Message-Id: <20260929044306.2CC341F000FF@smtp.kernel.org>
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
- [Medium] msm_dp_display_post_enable() hardcodes root dp->panel, breaking =
stream-specific PSR config
--

commit ce954c1f87fec9b4ffb2b11bf4184d722dd05ced
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: factor out _helper variants of bridge ops accepting a panel

The atomic bridge callbacks (set_mode / enable / disable /
post_disable) on dp_display currently hard-code dp->panel. This
commit introduces helper variants that take a struct msm_dp_panel
pointer to allow the upcoming DP MST encoder to drive link-level
prepare and unprepare uniformly.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> +void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
> +				  struct msm_dp_panel *msm_dp_panel)
> +{
> +	int rc =3D 0;
> +	struct msm_dp_display_private *dp;
> +
> +	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> +
> +	rc =3D msm_dp_display_enable(dp, msm_dp_panel);
> +	if (rc)
> +		DRM_ERROR("DP display enable failed, rc=3D%d\n", rc);
> +
> +	rc =3D msm_dp_display_post_enable(msm_dp_display);

[Severity: Medium]
Does this call correctly configure PSR for MST streams?

This helper correctly accepts a stream-specific msm_dp_panel, but
msm_dp_display_post_enable() was not refactored to take a panel argument.

Looking at msm_dp_display_post_enable():

static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
{
        ...
        if (msm_dp_display->psr_supported)
                msm_dp_ctrl_config_psr(dp->ctrl, dp->panel);
        ...
}

It still hardcodes the root dp->panel instead of the active stream's panel.
Could this misconfiguration lead to missing or incorrect PSR setup on MST
streams?

> +	if (rc) {
> +		DRM_ERROR("DP display post enable failed, rc=3D%d\n", rc);
> +		msm_dp_display_disable(dp, msm_dp_panel);
> +	}
> +
> +	drm_dbg_dp(msm_dp_display->drm_dev, "type=3D%d Done\n", msm_dp_display-=
>connector_type);
> +}
[ ... ]
> +void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
> +				   struct msm_dp_panel *msm_dp_panel)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
>  	/*
>  	 * If .atomic_enable() bailed out - link training failure is the common
> @@ -1521,17 +1542,28 @@ void msm_dp_display_atomic_disable(struct msm_dp =
*dp)
>  	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
>  	 * There is nothing to push idle, so leave it alone.
>  	 */
> -	if (!dp->power_on)
> +	if (!msm_dp_display->active_stream_cnt)
>  		return;

[Severity: High]
This is a pre-existing issue, but could this safety guard be bypassed if a
stream fails to enable?

Looking at msm_dp_display_enable(), active_stream_cnt is incremented
unconditionally even if msm_dp_ctrl_on_stream() fails:

static int msm_dp_display_enable(struct msm_dp_display_private *dp,
                                 struct msm_dp_panel *msm_dp_panel)
{
        rc =3D msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, ...);
        msm_dp_display->active_stream_cnt++;
        return rc;
}

If msm_dp_ctrl_on_stream() returns an error during standard atomic commit p=
aths
(e.g., due to a transient hardware failure like pixel clock enablement),
active_stream_cnt is artificially greater than zero. Later, when the stream=
 is
disabled, this check evaluates to true.

Pushing idle patterns to a controller that failed to enable will time out,
which as documented here can cause a TrustZone-level SOCCP/ADSP force-stop =
and
a silent SoC reset.

Can we avoid incrementing active_stream_cnt when msm_dp_ctrl_on_stream()
fails?

> -	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
> -	msm_dp_ctrl_mst_timeslot_setup(msm_dp_display->ctrl);
> -	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
> +	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D15
