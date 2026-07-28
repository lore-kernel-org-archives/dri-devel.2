Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B595AC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E3C10E3CD;
	Tue, 28 Jul 2026 10:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oM4046/R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692EF10E3CD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:34:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC1C443D42;
 Tue, 28 Jul 2026 10:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5051F00A3E;
 Tue, 28 Jul 2026 10:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785234879;
 bh=GZCCrRTrJ1Oarri6pdnog3jpnxoDt8qJImHu5Z9tyZo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oM4046/RyQoC2GMpDlxWrwlqcg14AOaQ3EvdDBObGBi2tytnMyCKTqqHqkoTpqdxj
 Avv7GwySM/WpC9S/VPsEzhvjGCOPHYrU7mHYlUfo9mblZIuGKeLAKoy1lluB7QNHk1
 VLNsDWFkri77qdeMYdoLHjj179itOZRNdhqHwoi9biGVgoTfT7sjt3hCnM5G+uRdTm
 BUu/6UyfTBBxeJHeTQ03aVAJqrSAMJyvSN1YriICH4GF1LhJybPP61kfqpyPcEoSVS
 k58tta3Fb1R4j5R3u+by2x+osN8YOWKmIrFwscWAy0zjMm9Hnf5B2ixhG94585AIQi
 aK3xgpDH/5p3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/14] drm/msm/dp: break up dp_display_enable into
 two parts
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-dp_mstclean-v9-8-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
 <20260728-dp_mstclean-v9-8-f7779fce10f4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 10:34:39 +0000
Message-Id: <20260728103439.9E5051F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Silent inversion of hardware initialization sequence (pixel clock =
and link retraining)
- [Medium] API split fails to support inserting MST payload programming as =
claimed

Pre-existing issues:
- [High] Unpowered hardware register access causes kernel panic on error pa=
th
--

--- Patch [8]: [PATCH v9 08/14] drm/msm/dp: break up dp_display_enable into=
 two parts ---
commit 722ccac6521827b0527a34404c0521cf56234857
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: break up dp_display_enable into two parts

Split dp_display_enable into prepare and enable APIs. This aims to
support MST bridges_enable inserting MST payload functions between
enabling stream clocks and programming registers.

> dp_display_enable() currently re-trains the link if needed and then
> enables the pixel clock, programs the controller to start sending the
> pixel stream. Split these two parts into prepare/enable APIs, to support
> MST bridges_enable insert the MST payloads funcs between enable
> stream_clks and program register.

[Severity: Medium]
Does this split actually allow inserting MST payload functions between
enabling stream clocks and programming the registers?

Looking at the implementation of msm_dp_ctrl_on_stream() below, the call to
msm_dp_ctrl_on_pixel_clk() and the subsequent register programming are still
tightly coupled in the same function. It doesn't seem possible for an
external caller to inject payload programming between them.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 068d4f8b673f6..43094dda34349 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li=
nk_train)
> +int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool =
force_link_train)
>  {
>  	int ret =3D 0;

[ ... ]

> -	ret =3D msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
> -	if (ret)
> -		return ret;
> -
>  	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
>  		msm_dp_ctrl_link_retrain(ctrl);

[Severity: High]
Does this change invert the hardware initialization sequence?

Before this patch, msm_dp_ctrl_on_stream() called msm_dp_ctrl_on_pixel_clk()
to enable the pixel clock before performing the link retraining.

With the new split, msm_dp_ctrl_prepare_stream_on() performs link retrainin=
g,
but the pixel clock isn't enabled until msm_dp_ctrl_on_stream() is called
later. Could this cause link training failures or black screens by retraini=
ng
before the pixel clock is ready?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 2a84a6ffedbb5..d094d484474cd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> -static int msm_dp_display_enable(struct msm_dp_display_private *dp, bool=
 force_link_train)
> +static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
> +{
> +	struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> +	int rc =3D 0;
> +	bool force_link_train =3D false;
> +
> +	drm_dbg_dp(dp->drm_dev, "sink_count=3D%d\n", dp->link->sink_count);
> +
> +	if (msm_dp_display->is_edp)
> +		msm_dp_hpd_plug_handle(dp);
> +
> +	rc =3D pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
> +	if (rc) {
> +		DRM_ERROR("failed to pm_runtime_resume\n");
> +		return rc;
> +	}

[Severity: High]
This is a pre-existing issue, but if pm_runtime_resume_and_get() fails here,
the device is left unpowered while the DRM state considers it enabled.

Since msm_dp_bridge_atomic_enable() returns void and cannot abort the overa=
ll
atomic commit if this fails, msm_dp_bridge_atomic_disable() will
unconditionally be called later during teardown.

That disable path eventually calls msm_dp_ctrl_push_idle() which accesses
unclocked and unpowered DP hardware registers, leading to a synchronous
external abort (kernel panic).

Should there be a way to prevent hardware access during disable if the
device never successfully resumed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-dp_mstclea=
n-v9-0-f7779fce10f4@oss.qualcomm.com?part=3D8
