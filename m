Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302D9C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B76910ECBC;
	Tue, 29 Sep 2026 04:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VqcQnc4r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8489310ECBC
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:42:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0799B60210;
 Tue, 29 Sep 2026 04:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EB11F000FF;
 Tue, 29 Sep 2026 04:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790656975;
 bh=JAtzg6Y75cJkfeq5C4Yn6FG/nty/jBEyyHCHnEOAQvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VqcQnc4rz7cdHt9+IDk+QCABCXq/Zz2ZTV7fs91ntWPYH3f4/WODenlHn98iaTnbx
 d8F75KVtmsAwJKN6tLqEtTcXmfYr8qem9DXZwN4BTN9YGhNIPpBgjhPfaf0Ny2Q03m
 0Wkki+v6CFEFdh3lFGTe5K894iWnAxEdrJWRJ0U698VfnzGhNoLRn3Go6OxpZEYR4N
 JNJe6zyLKthyscN7/g2SRDpRM/76kH3Vub4i8Xr1EkcM/UBjqwT/m/A88afyVnaqwM
 OnGsZL5mTUU4QPIC8XELZpU0A5A8QvOVoKXPAEl2cXiyYfSZE9Zm6qCeT6hZBiN/hU
 XI2KdtVpYTYiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/35] drm/msm/dp: add support to send ACT packets
 for MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:42:55 +0000
Message-Id: <20260929044255.87EB11F000FF@smtp.kernel.org>
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
- [High] drm/msm: msleep() called from atomic modesetting context
- [Low] msm: linker error on 32-bit platforms due to 64-bit DIV_ROUND_UP
- [Low] msm: ineffective memory barrier used for MMIO write ordering
--

commit 9d59610b2e4fe65438a505df688ad0556d4e6917
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

    drm/msm/dp: add support to send ACT packets for MST
   =20
    Whenever virtual channel slot allocation changes, the DP
    source must send the action control trigger sequence to notify
    the sink about the same. This would be applicable during the
    start and stop of the pixel stream. Add the infrastructure
    to be able to send ACT packets for the DP controller when
    operating in MST mode.

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

[Severity: Low]
Does casting the dividend to u64 here force a 64-bit division that causes
a linker error for the missing __udivdi3 symbol on 32-bit platforms?

Should we use the DIV_ROUND_UP_ULL() macro instead for 64-bit dividends?

> +
> +	msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
> +	/* make sure ACT signal is performed */
> +	wmb();

[Severity: Low]
Does this wmb() guarantee the MMIO write has reached the device?

Since msm_dp_write_link() uses writel() which already handles pre-write
barriers, the trailing CPU memory barrier does not flush interconnect write
buffers.

Should we perform a dummy read-back of the register instead to ensure the
write has reached the device synchronously?

> +
> +	msleep(frame_time_ms);

[Severity: High]
Is it safe to call msleep() here?

This function is called from the atomic modesetting context:

msm_dp_display_atomic_disable() ->
  msm_dp_ctrl_mst_send_act()

Sleeping in atomic context can lead to kernel warnings and system
instability. Should we use a non-sleeping delay function like udelay()
instead?

> +
> +	/* Hardware clears this bit after sending 4 ACT headers */
> +	if (msm_dp_read_link(ctrl, REG_DP_MST_ACT)) {
> +		drm_dbg_dp(ctrl->drm_dev, "MST ACT trigger complete failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D8
