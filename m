Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A849CC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB56110E5A6;
	Tue, 28 Jul 2026 13:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="neYmXUgC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFA210E5A6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:34:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3C264022C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EFC1F00A3A;
 Tue, 28 Jul 2026 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785245686;
 bh=Q+DUXQQXZSfXIwoA+JQSRihd3tdmnoCefr4c806V2ng=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=neYmXUgC/nDrs5yM6LOCJaO+N4GC/xEu6NIxsG/VJB/YOYsfHyjJ7RzmaUHEgqgjp
 n5C5zBJBUzY3T6RqCcQocgCMFlHh1W1ARZCs8zVOs6hzh95jyE9BLULsIK0kgHC/47
 n9luv4sHbqcN2AErc4xfajTpMqzboy7EtyhRzqfSzBU7GjDVI72NVbqrn+AcxGD87p
 31voJw/eiHb3Pxgn0NYwGYdjjvODuMNKF+8Kacdgf5J7mo5QMdKk7oldWYq2y+NOZF
 d696LTn29v25waBNu3Y+JcidtUWqZRLbUaA6+c3Rw74Zro/1uVFsKlNdNVTU2qUB1r
 +HiDjOiTswDGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/msm/dp: Drop dev_pm_opp_set_rate(0)
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-topic-dpu_power-v1-2-e7783b859a70@oss.qualcomm.com>
References: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
 <20260728-topic-dpu_power-v1-2-e7783b859a70@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 13:34:45 +0000
Message-Id: <20260728133446.66EFC1F00A3A@smtp.kernel.org>
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
- [Medium] Removing `dev_pm_opp_set_rate(0)` entirely introduces a permanen=
t performance state (voltage) vote leak when the display is disabled but th=
e monitor remains plugged in.
--

--- Patch [2]: [PATCH 2/3] drm/msm/dp: Drop dev_pm_opp_set_rate(0) ---
commit bc14685e819772f265842e7901b3f8c5d0779863
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

drm/msm/dp: Drop dev_pm_opp_set_rate(0)

This commit removes explicit calls to dev_pm_opp_set_rate(0) in the DP link
disable and deinitialization paths. The commit message notes that it does
not actually park the clock and makes it run without the necessary power
backing.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 86ef8c89ad443..e09924eae5a7a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1950,13 +1950,12 @@ static int msm_dp_ctrl_reinitialize_mainlink(stru=
ct msm_dp_ctrl_private *ctrl)
>  	msm_dp_ctrl_mainlink_disable(ctrl);
>  	ctrl->phy_opts.dp.lanes =3D ctrl->link->link_params.num_lanes;
>  	phy_configure(phy, &ctrl->phy_opts);
> +
>  	/*
>  	 * Disable and re-enable the mainlink clock since the
>  	 * link clock might have been adjusted as part of the
>  	 * link maintenance.
>  	 */
> -	dev_pm_opp_set_rate(ctrl->dev, 0);
> -
>  	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
> =20
>  	phy_power_off(phy);
> @@ -1982,7 +1981,6 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct=
 msm_dp_ctrl_private *ctrl)
> =20
>  	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
> =20
> -	dev_pm_opp_set_rate(ctrl->dev, 0);
>  	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
> =20
>  	phy_power_off(phy);

[Severity: Medium]
Does removing this call introduce a permanent performance state (voltage)
vote leak when the display is disabled but the monitor remains plugged in?

When a user connects a DP monitor, msm_dp_hpd_plug_handle() holds a
runtime PM reference for the duration of the plug. If the link is enabled
for display, the clocks are enabled and an OPP rate is set.

Later, if the display is turned off via DRM DPMS or screen timeout, this
deinitialization path disables the clocks. However, because the monitor is
still physically connected, the runtime PM reference is held. This means
the device never runtime suspends and genpd will not automatically drop
the performance vote.

Without explicitly dropping the OPP vote here, the SoC power domain might
stay in a high performance state indefinitely, causing a continuous
power regression.

> @@ -2573,7 +2571,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl=
 *msm_dp_ctrl)
>  		ctrl->stream_clks_on =3D false;
>  	}
> =20
> -	dev_pm_opp_set_rate(ctrl->dev, 0);
>  	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
> =20
>  	phy_power_off(phy);

[Severity: Medium]
Similarly, could dropping the OPP vote here in msm_dp_ctrl_off_link_stream()
leave the voltage vote active indefinitely while the link stream is off?

> @@ -2602,7 +2599,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctr=
l)
>  		ctrl->stream_clks_on =3D false;
>  	}
> =20
> -	dev_pm_opp_set_rate(ctrl->dev, 0);
>  	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
> =20
>  	phy_power_off(phy);

[Severity: Medium]
This removal in msm_dp_ctrl_off() appears to cause the same voltage vote
leak when the display is turned off but remains plugged in.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-topic-dpu_=
power-v1-0-e7783b859a70@oss.qualcomm.com?part=3D2
