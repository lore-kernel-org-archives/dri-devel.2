Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B756AC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3007210EEA4;
	Tue,  7 Jul 2026 18:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Aoj40qEU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D7310EEA4
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 18:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D1E360018;
 Tue,  7 Jul 2026 18:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C7F1F000E9;
 Tue,  7 Jul 2026 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783447553;
 bh=3M0V20MaVGXTCETTA1Mjgf02wgOqKtZKPqFMIuBDXR0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Aoj40qEU+tn/zAx1MoM6Q+tpxoW+wcllSV/Q6feq8udpmCimEfGhjkQjGjT3bJXVQ
 8w2/aF2+brLVGZOfguohzsdFcfuJUFTZ+7Og4oQnFZ7BlTBGBIDtmrukDdtsVX38SK
 Ge/1VvkxKSMs3P8srMPHHbFHCzeZnuh4KaimlliYa+w2taKQR7W0Uj1Pp1K4ZHf67/
 nepImUdKKtEtblWavclXcbIaioLoU7MKkNNXw2DL93hw0yhl3UKSR1Ysxi4cH2Gyje
 FNV2oxTKH9OKseeCVPZ6rnMb8POG4PeiU0wxRPwHeVfSluz9dsfIxsqcgEwrdhap4X
 SUdVf7yfEFEaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/msm/dp: Disable stream clock after video-ready
 timeout
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707175212.412699-1-dbgh9129@gmail.com>
References: <20260707175212.412699-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 18:05:53 +0000
Message-Id: <20260707180553.78C7F1F000E9@smtp.kernel.org>
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
- [High] Disabling the pixel clock while the DP controller is actively in t=
he SEND_VIDEO state violates the teardown sequence and can lock up the hard=
ware.
--

--- Patch [1]: [PATCH v1] drm/msm/dp: Disable stream clock after video-read=
y timeout ---
commit d51f59f75198361a5116081d3f135fd586dbcb66
Author: Yuho Choi <dbgh9129@gmail.com>

drm/msm/dp: Disable stream clock after video-ready timeout

This commit routes the video-ready timeout path in msm_dp_ctrl_on_stream()=
=20
through a cleanup path. It disables the stream pixel clock and clears the
stream_clks_on flag if the clock was enabled during the call.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 86ef8c89ad443..139e9fa25d6a7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
[ ... ]
> @@ -2543,13 +2545,17 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm=
_dp_ctrl, bool force_link_train
> =20
>  	ret =3D msm_dp_ctrl_wait4video_ready(ctrl);
>  	if (ret)
> -		return ret;
> +		goto end;
> =20
>  	mainlink_ready =3D msm_dp_ctrl_mainlink_ready(ctrl);
>  	drm_dbg_dp(ctrl->drm_dev,
>  		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
> =20
>  end:
> +	if (stream_clk_enabled && ret) {
> +		clk_disable_unprepare(ctrl->pixel_clk);
> +		ctrl->stream_clks_on =3D false;
> +	}

[Severity: High]
Does this error path leave the DP controller in an active state without
reverting it before disabling the pixel clock?

Earlier in this function, the controller is programmed to send video:

	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);

	ret =3D msm_dp_ctrl_wait4video_ready(ctrl);

If wait4video_ready times out, the code jumps to the end label and disables
the pixel clock. However, if the caller ignores this failure and DRM later
disables the bridge, the teardown sequence will invoke msm_dp_ctrl_push_idl=
e().

Since the controller was left in DP_STATE_CTRL_SEND_VIDEO but its pixel
clock is now disabled, could writing DP_STATE_CTRL_PUSH_IDLE cause a
timeout or wedge the hardware because it cannot process the state transition
without the clock?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707175212.4126=
99-1-dbgh9129@gmail.com?part=3D1
