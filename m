Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F7DC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1943010E772;
	Mon, 31 Aug 2026 09:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZOstk24V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD1510E772
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:01:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B097643B6E;
 Mon, 31 Aug 2026 09:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6F31F000E9;
 Mon, 31 Aug 2026 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788166883;
 bh=AsLvywh97tWoMLE1dP3LcmrqBMHLohFtKWi6BDw+w2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZOstk24VMDYiLcr1tryqBNnsxtMsOA+g468k/bTS0IhuPvtOZ2rCuSepVDQuYLzx6
 EKx7T3nOcqxXbEqfP7I4DHmMmeKzxjgC1FN3M8mL9cwYmzVoJub1MqwSstx3/AbiFb
 PG6vFcfCGJXgtQlVEac2l97oRtMYJp5S/Z3cf8+qw5TTofIQy8TrUUcplORSpHU5cd
 k0zz3hSyBCGCghGV3Kr9UaoG70ktbgxD4Zi4YCUCTV3SKZ/KdZjXBI0ld/KEwAXwpl
 4wp51ByAn4QfW96L3SQiB/aBiwXIIe/OSSH8mz/3+hQEtTRMJR314cATdFMm9mqugP
 8B816yYtjBufQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/29] drm/msm/dp: add support to enable MST in
 mainlink control
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-9-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-9-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:01:22 +0000
Message-Id: <20260831090123.5B6F31F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Sleeping function msleep() is called in an atomic commit context v=
ia msm_dp_ctrl_mst_send_act().
--

commit 10a0de5e53b18299bcdd23065b77d3e1f1d02df3
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add support to enable MST in mainlink control

This commit adds support to program the MST enable bit in the mainlink cont=
rol=20
register when an MST session is active or being disabled.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 65d22505c2b67..cd6ae0d5372c9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -276,6 +276,19 @@ int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm=
_dp_ctrl,

[Severity: High]
This isn't a bug introduced by this patch, but it is a pre-existing High
severity issue that persists through the end of the series.

Does this code call a sleeping function from an atomic context?

Looking at msm_dp_ctrl_mst_send_act(), it executes a sleeping delay:

int msm_dp_ctrl_mst_send_act(...)
{
    ...
    msleep(frame_time_ms);
    ...
}

Calling a sleeping function like msleep() from an atomic context causes ker=
nel
warnings (might_sleep()), system instability, and potential deadlocks on hot
paths.

This appears to be triggered on an atomic commit path:
msm_dp_display_atomic_enable() (an encoder/bridge atomic enable callback)
calls msm_dp_display_enable(), which calls msm_dp_ctrl_on_stream(), which in
turn calls msm_dp_ctrl_mst_send_act().

A similar path exists during disable:
msm_dp_display_atomic_disable() -> msm_dp_ctrl_mst_send_act().

The DRM Subsystem Details explicitly define encoder atomic enable/disable
callbacks as atomic context paths where sleeping is strictly forbidden. Only
non-sleeping delays (udelay, ndelay) are safe.

Checking the final state of the series (commit 48ec7f7903ee) confirms this =
bug
is not resolved later; dpu_encoder_mst_atomic_disable() still calls
msm_dp_mst_stream_disable(), which reaches msm_dp_ctrl_mst_send_act() and
sleeps.

>  	return 0;
>  }
> =20
> +static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, boo=
l enable)
> +{
> +	u32 mainlink_ctrl;
> +
> +	mainlink_ctrl =3D msm_dp_read_link(ctrl, REG_DP_MAINLINK_CTRL);
> +	if (enable)
> +		mainlink_ctrl |=3D DP_MAINLINK_CTRL_MST_EN;
> +	else
> +		mainlink_ctrl &=3D ~DP_MAINLINK_CTRL_MST_EN;
> +
> +	msm_dp_write_link(ctrl, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D9
