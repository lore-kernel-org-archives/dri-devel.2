Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3C8C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70AE710E149;
	Mon, 20 Jul 2026 06:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZEB8avVO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878E510E149
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:26:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2425416E1;
 Mon, 20 Jul 2026 06:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A5F1F000E9;
 Mon, 20 Jul 2026 06:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784528775;
 bh=FWaSHnq/LahauxRK6tdY1RwFDwR2pWhi4/0qutLjI/4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZEB8avVOGEdTcrcui6SAlxMiQfqeT3tsrbU2Azcrh/YRKLvoOo/k/N8Z6noXnDoOo
 Aytl1YPYF567GkKj8p4bnV4FPi2zQMRHWITJGYictl6DFMB7xFbZcGyirjiT7nsKu5
 gio5B1Zy19N6Ya3/466ckCRexZFewAaRVd9a9baYlk/muVyzGFpvo9W8X3fJXKnn/T
 pi2OsrathZVKonSG0DsLTC3xGxPpcszKllpShy/t7jhkBjwE5krmFq4n3Zt+dTC/Qi
 sWEvEfFBTOL8u7plVELM3vctqDy13BIqz3Ihe7Ol1TGcjbdup47y+9O65IOrOjeO7M
 FtPdqqDpQ26FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/15] drm/msm/dp: move the pixel clock control to
 its own API
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-dp_mstclean-v8-7-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-7-bea261bf4e7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:26:15 +0000
Message-Id: <20260720062615.97A5F1F000E9@smtp.kernel.org>
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
- [Medium] Spurious WARN_ON_ONCE triggered on display enable retry due to u=
nhandled clock state on error path.
- [Low] Incomplete refactoring: msm_dp_ctrl_off_link_stream() still uses op=
en-coded pixel clock disablement.
--

--- Patch [7]: [PATCH v8 07/15] drm/msm/dp: move the pixel clock control to=
 its own API ---
commit 56bf43c0164f110e1bba46e5b2fdcdcbaa97bf82
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: move the pixel clock control to its own API

Enable/Disable of DP pixel clock happens in multiple code paths
leading to code duplication. Move it into individual helpers so that
the helpers can be called wherever necessary.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 711579de899d8..a79d9bb93cd06 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, un=
signed long pixel_rate)
> +{
> +	int ret;
> +
> +	ret =3D clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	if (ret) {
> +		DRM_ERROR("Failed to set pixel clock rate. ret=3D%d\n", ret);
> +		return ret;
> +	}
> +
> +	if (WARN_ON_ONCE(ctrl->stream_clks_on))
> +		return 0;

[Severity: Medium]
Can this WARN_ON_ONCE be triggered by a recoverable hardware timeout?

If msm_dp_ctrl_wait4video_ready() fails in msm_dp_ctrl_on_stream(), it retu=
rns
directly without disabling the pixel clock, leaving ctrl->stream_clks_on set
to true.

Since the display enable failed, msm_dp_display->power_on remains false.
A subsequent cleanup call to msm_dp_display_disable() returns immediately
because power_on is false, which prevents it from cleaning up the clock sta=
te.

When the display is retried, msm_dp_ctrl_on_pixel_clk() will be called again
and hit this new warning.

> +
> +	ret =3D clk_prepare_enable(ctrl->pixel_clk);
> +	if (ret) {
> +		DRM_ERROR("Failed to start pixel clocks. ret=3D%d\n", ret);
> +		return ret;
> +	}
> +	ctrl->stream_clks_on =3D true;
> +
> +	return ret;
> +}
> +
> +static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +
> +	ctrl =3D container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_c=
trl);
> +
> +	if (ctrl->stream_clks_on) {
> +		clk_disable_unprepare(ctrl->pixel_clk);
> +		ctrl->stream_clks_on =3D false;
> +	}
> +}

[Severity: Low]
This isn't a bug, but could this new helper also be used in
msm_dp_ctrl_off_link_stream() to replace the open-coded check?

It looks like msm_dp_ctrl_off_link_stream() still retains the duplicated pi=
xel
clock disablement logic:

if (ctrl->stream_clks_on) {
        clk_disable_unprepare(ctrl->pixel_clk);
        ctrl->stream_clks_on =3D false;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-dp_mstclea=
n-v8-0-bea261bf4e7d@oss.qualcomm.com?part=3D7
