Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CA1CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42D210E216;
	Tue,  9 Jun 2026 10:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jJ3rlNkP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1AA10E216
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:04:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7B2D42D7A;
 Tue,  9 Jun 2026 10:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758151F00899;
 Tue,  9 Jun 2026 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999477;
 bh=Iy0MpSpN4PGVWdCm3MuoyjAWqtDNjKfixGduevpXMCw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jJ3rlNkP/PZvI3oV12I/5rhrXz2HngmMZA6vuPClGUgPoXcLyimXSqzCcEIV81UjG
 ttMuN1dSh12MRDk4MANzDJd5UTiy6l/F333aAWYyOrECDTmQ5scFERn6iLdT/hqLZ0
 eNSwKrjz0iAUJOOBz1Qp6kWBy3nX2wTp/Z3FgyXKpqotc6iD5/bWYqipTqm02DEFhi
 R5TPDww0uLTV6qADTqvxVQ+9YvZOaeGhyskTXlUzXi1L8kh2DBfmsgsJwRwgcQHo9O
 zo7DZBc0DdS9+WGq5M/C0S8Za+qXuTf2uI5VrvhV+ni8JNhGKGg91zyrdzvh/IMXAA
 1rIb2/YqmZvgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/15] drm/msm/dp: move the pixel clock control to
 its own API
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-7-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-7-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:04:36 +0000
Message-Id: <20260609100437.758151F00899@smtp.kernel.org>
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
- [High] Unhandled error return from `msm_dp_ctrl_on_pixel_clk()` causing p=
otential system crash.
- [High] Invalid `WARN_ON_ONCE` escalation leading to potential Denial of S=
ervice (DoS) on hardware timeouts.

Pre-existing issues:
- [High] Lockless concurrent access to `ctrl->stream_clks_on` between DRM a=
tomic commit and HPD IRQ threads.
--

commit 4ab86d41ec16eead989a4b3a8579ccd95556770a
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: move the pixel clock control to its own API

Enable/Disable of DP pixel clock happens in multiple code paths
leading to code duplication. Move it into individual helpers so that
the helpers can be called wherever necessary.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 1c2eccec6ec6d..a2c44088e6a68 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2171,6 +2171,41 @@ static bool msm_dp_ctrl_send_phy_test_pattern(stru=
ct msm_dp_ctrl_private *ctrl)
>  	return success;
>  }
> =20
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

[Severity: High]
Does this WARN_ON_ONCE() introduce a potential system crash with panic_on_w=
arn
enabled?

If msm_dp_ctrl_wait4video_ready() in msm_dp_ctrl_on_stream() times out, the
function returns an error but leaves ctrl->stream_clks_on as true. This cau=
ses
the caller, msm_dp_display_enable(), to refuse setting
msm_dp_display->power_on =3D true.

Later, on teardown, msm_dp_display_disable() bails out early because power_=
on
is false, skipping msm_dp_ctrl_off_pixel_clk() and leaving
ctrl->stream_clks_on as true.

On the next modeset or hotplug attempt, when msm_dp_ctrl_on_pixel_clk() is
called again, it will trigger this newly added warning. Since external
display hardware timeouts can be triggered by a faulty sink, is it safe to
escalate this from the previous debug print to a warning?

[Severity: High]
This is a pre-existing issue, but does lockless concurrent access to
ctrl->stream_clks_on between DRM atomic commit and HPD IRQ threads risk a N=
oC
error?

The boolean flag ctrl->stream_clks_on and the pixel clock are accessed and
modified in msm_dp_ctrl_on_pixel_clk() and msm_dp_ctrl_off_pixel_clk()
without any synchronization primitives.

msm_dp_ctrl_on_pixel_clk() can be executed by the DRM atomic commit thread
while the asynchronous HPD IRQ worker thread simultaneously handles a PHY t=
est
request via msm_dp_ctrl_process_phy_test_request(). If Thread 1 evaluates
ctrl->stream_clks_on as true to disable the clock concurrently with Thread 2
accessing DP PHY registers, can it lead to a synchronous external abort when
accessing unclocked DP registers?

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

[ ... ]

> @@ -2196,22 +2231,7 @@ static int msm_dp_ctrl_process_phy_test_request(st=
ruct msm_dp_ctrl_private *ctrl
>  	}
> =20
>  	pixel_rate =3D ctrl->panel->msm_dp_mode.drm_mode.clock;
> -	ret =3D clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> -	if (ret) {
> -		DRM_ERROR("Failed to set pixel clock rate. ret=3D%d\n", ret);
> -		return ret;
> -	}
> -
> -	if (ctrl->stream_clks_on) {
> -		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
> -	} else {
> -		ret =3D clk_prepare_enable(ctrl->pixel_clk);
> -		if (ret) {
> -			DRM_ERROR("Failed to start pixel clocks. ret=3D%d\n", ret);
> -			return ret;
> -		}
> -		ctrl->stream_clks_on =3D true;
> -	}
> +	ret =3D msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
> =20
>  	msm_dp_ctrl_send_phy_test_pattern(ctrl);

[Severity: High]
Does this code ignore the return value of msm_dp_ctrl_on_pixel_clk()?

In msm_dp_ctrl_process_phy_test_request(), ret is assigned from
msm_dp_ctrl_on_pixel_clk(), but it isn't checked before calling
msm_dp_ctrl_send_phy_test_pattern().

If clock enablement fails (e.g., due to an unsupported clock rate requested=
 by
a malicious DP sink), the function unconditionally proceeds to send the PHY
test pattern. Will accessing DP PHY and mainlink hardware registers without
the required clock running trigger a synchronous external abort and panic t=
he
kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D7
