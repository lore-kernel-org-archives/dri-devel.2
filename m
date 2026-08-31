Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1B6C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B558610E762;
	Mon, 31 Aug 2026 08:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BpsWcfez";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D469D10E762
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:49:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0128660120;
 Mon, 31 Aug 2026 08:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8866D1F000E9;
 Mon, 31 Aug 2026 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788166152;
 bh=OyB7+U/8xRTnuTrcqTLEJbe4W7PQNIOQyc7fiInmv5U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BpsWcfezh+nPQBuuaq767HgmKK685x/I1p1TFPxoC2XB9q1uW32azByHO+oUtZT5S
 J4u+F/BlDEzrqa2yCZiAOcd1m5bXCqx9L03mPuU7VptaB3wseEhJVEol5qHj/4Ah0r
 omrd4O6TDdwFLR3gyAK6iRaCl8pBY3hWSzCwfRufGU47u1oiBmNEhgiUZajftyE66c
 LilmcUpqwKMUdy4op7YKOAn8tk3P4CchmaNa+N2X9/jecr9nUuaojqBtWdXKGbZPPM
 bFp3HNMvZnaWyFs38IGv+UONeH47NaYR1iG4MbchBekxM9km2RYxTKGsqsuz6F8ySr
 qawuZWIJWIxYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/29] drm/msm/dp: add support to send ACT packets
 for MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-8-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-8-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:49:12 +0000
Message-Id: <20260831084912.8866D1F000E9@smtp.kernel.org>
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
- [High] Calling a sleeping function msleep() from an atomic context during=
 DRM atomic commits.
- [High] Build/link error on 32-bit platforms due to 64-bit division using =
DIV_ROUND_UP.
- [Medium] Incorrect memory barrier used to flush MMIO posted write.
--

commit c7be0c8d679031927a088cf466f79335ab3bce4b
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
drm/msm/dp: add support to send ACT packets for MST

This commit adds the infrastructure to send action control trigger (ACT)
sequences for the DP controller when operating in MST mode. This is used
to notify the sink whenever virtual channel slot allocation changes during
the start and stop of the pixel stream.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index e1614bc49a7ca..65d22505c2b67 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
[ ... ]
> @@ -244,6 +245,37 @@ static int msm_dp_aux_link_configure(struct drm_dp_a=
ux *aux,
>  	return err;
>  }
> =20
> +int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
> +			     struct msm_dp_panel *panel)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +	const struct drm_display_mode *mode;
> +	u32 frame_time_ms;
> +
> +	ctrl =3D container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_c=
trl);
> +
> +	if (!ctrl->mst_active)
> +		return 0;
> +
> +	mode =3D &panel->msm_dp_mode.drm_mode;
> +	frame_time_ms =3D DIV_ROUND_UP((u64)mode->htotal * mode->vtotal,
> +				     mode->clock) + 1;

[Severity: High]
Does this cause a build error on 32-bit platforms due to a 64-bit division?

The macro DIV_ROUND_UP() performs a division using the / operator. Because
the numerator is explicitly cast to a 64-bit unsigned integer, this attempt=
s a
64-bit division, which can fail to link on 32-bit architectures (e.g., ARM3=
2)
with an undefined reference to __udivdi3.

Should this use DIV_ROUND_UP_ULL() or div_u64() instead when performing 64-=
bit
division?

> +
> +	msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
> +	/* make sure ACT signal is performed */
> +	wmb();

[Severity: Medium]
Is this the correct way to flush an MMIO posted write?

wmb() only enforces CPU memory ordering; it does not flush posted MMIO writ=
es
to the hardware. The ACT signal write may sit in the bus fabric's posted wr=
ite
buffer while the CPU goes to sleep. This reduces the effective hardware wait
time and could cause the hardware timeout check to fail incorrectly.

Should a dummy read from the same device (e.g., msm_dp_read_link()) be used
instead to ensure the write is flushed?

> +
> +	msleep(frame_time_ms);

[Severity: High]
Is it safe to use a sleeping function here?

msm_dp_ctrl_mst_send_act() is invoked from the bridge's atomic disable call=
back
(msm_dp_display_atomic_disable) and atomic enable callback
(msm_dp_ctrl_on_stream). The DRM subsystem guidelines explicitly dictate th=
at
DRM atomic enable/disable callbacks run in an atomic context where sleeping
functions are strictly forbidden.

Calling msleep() here can cause kernel warnings, system instability, and
potential deadlocks. Should a non-sleeping delay function like udelay() or
ndelay() be used instead?

> +
> +	/* Hardware clears this bit after sending 4 ACT headers */
> +	if (msm_dp_read_link(ctrl, REG_DP_MST_ACT)) {
> +		drm_dbg_dp(ctrl->drm_dev, "MST ACT trigger complete failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index d0fc4ff508dc6..52c13823e8d7d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -1497,6 +1497,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *d=
p)
>  	msm_dp_display =3D container_of(dp, struct msm_dp_display_private, msm_=
dp_display);
> =20
>  	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
> +	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D8
