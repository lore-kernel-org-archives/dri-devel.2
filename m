Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A3606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMzZoLBT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1829010E906;
	Tue, 10 Nov 2026 05:11:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1946510E906
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:11:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28AB2609FA;
 Tue, 10 Nov 2026 05:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B517C1F0089F;
 Tue, 10 Nov 2026 05:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794287473;
 bh=gGXbCUO0n3pX8c9aV2liytRA/KwdObpJvwVCoiS0zXk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eMzZoLBTwo1jMsJPwJeRvDoZuOC6TvIPBgJ5G0iOnwVNayNfftc13+xhKbhnIytT2
 BxRvC2Rouf0wCr5haDGIO4g5tz29OF3v8TYdpmq5tDVQ9/4kcoJN2FUxjEu0Czycsg
 c5T0vt1BCjhqc7Vx9BwtEFZwLHUorlmaYMSXN9v2znUxXWpU/4z1/og28xsc1iDlyM
 FwSLQ9lijYtGGc+cLGgBBytHTAdThL6UCCicuJFZDsCW1iWtjB+MVD3z0YNGrq6T9I
 jO4h4EIDfxGZeybqHqgFB2ljDyn6cBVZJubfzYlFWckuSSrbciBkCXMl5YW5fqW41I
 8gWnDW9MyG8ug==
Message-ID: <sashiko-outbox-206265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/29] drm/msm/dp: add support to send ACT packets
 for MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-2-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-2-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:11:13 +0000
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
- [Medium] drm/msm/dp: pixel clock leak on error in
  msm_dp_ctrl_on_stream()
--

commit 87df8767e6c3210a012dfaba1dae900d3f34cb90
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add support to send ACT packets for MST

This commit adds REG_DP_MST_ACT and msm_dp_ctrl_mst_send_act() to trigger
and poll the MST action control sequence when enabling or disabling a DP
stream in MST mode.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 32d4d5743eb36..288f84c33275f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -2666,6 +2701,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_=
dp_ctrl, struct msm_dp_panel *
> =20
>  	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
> =20
> +	ret =3D msm_dp_ctrl_mst_send_act(msm_dp_ctrl, panel);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D msm_dp_ctrl_wait4video_ready(ctrl);
>  	if (ret)
>  		return ret;

[Severity: Medium]
Does returning early here (or on the existing msm_dp_ctrl_wait4video_ready()
error path below) leak the stream pixel clock enabled earlier in
msm_dp_ctrl_on_stream() by msm_dp_ctrl_on_pixel_clk()?

When msm_dp_ctrl_on_stream() fails, msm_dp_display_enable() leaves
msm_dp_display->power_on false, so msm_dp_display_disable() returns early
without calling msm_dp_ctrl_off_pixel_clk().  That leaves
ctrl->pixel_clk[panel->stream_id] prepared and enabled and
ctrl->stream_clks_on[panel->stream_id] set to true, causing subsequent
calls to msm_dp_ctrl_on_pixel_clk() for that stream to hit WARN_ON_ONCE()
and fail with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D2
