Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5C8C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F41F10E751;
	Mon, 24 Aug 2026 11:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e0KanVja";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D5510E751
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:40:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 858C56013A;
 Mon, 24 Aug 2026 11:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F8B1F000E9;
 Mon, 24 Aug 2026 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787571630;
 bh=GwE5uDtGz0EH9Gvdg9euI8g5rfiCsOHRqdpI8yxqBFc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e0KanVjahEqoojMbYWq5DQCPJX4c740wfoTuYxxSBrpxh2WzJXhLqn9zx6DwYNAgD
 JrdcnSKGzuOPRvFDzykkf27nCESYuxIqQXu/0vJtj5kYMosn2NdW8GRZntH12nI3zK
 42E2Z+Ya2DXlizicGQTHXMHh3R4ptNNvn4jeTeEprfBv3c2tzFeC8+0y9Vwlh8biTt
 B7LjmeS+ChXAojFoSaI53tzyH6bTso4d6Aa61aV8gQONFh4hLbtGAJ9ADDvPRxDIqA
 fom8qBnh4XOFyOHEN1JINlOvA4S4x3OBmJxvfRKHNAPuDdHmOsY4MF8qOhcQ0Q8jy4
 d5MA9jLSpLWjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/msm/dp: continue link training downgrade when
 cable is still plugged
To: "Saurabh Anand" <saurabh.anand@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com, neil.armstrong@linaro.org, vkoul@kernel.org
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-4-2825e5bf8a96@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-4-2825e5bf8a96@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:40:29 +0000
Message-Id: <20260824114029.F1F8B1F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Lockless read of dp->plugged in msm_dp_display_prepare_link() ca=
uses a data race.

Pre-existing issues:
- [High] The return value of drm_dp_dpcd_read_link_status() is ignored, cau=
sing uninitialized stack memory to be used if the DPCD read fails.
--

--- Patch [4]: [PATCH 4/4] drm/msm/dp: continue link training downgrade whe=
n cable is still plugged ---
commit ad6d2e949e22a448345ebdb67f36f42020cff884
Author: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

drm/msm/dp: continue link training downgrade when cable is still plugged

During a Type-C reconnect the AUX channel may report link-disconnected
transiently while the physical cable is still present. The link training
retry loop in msm_dp_ctrl_on_link() was aborting immediately on any
msm_dp_aux_is_link_connected() failure, preventing the rate/lane downgrade
path from running.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 59070f399e2d3..e8fd8f4c75fec 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2379,7 +2379,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_=
ctrl,
>  			break;
>  		} else if (training_step =3D=3D DP_TRAINING_1) {
>  			/* link train_1 failed */
> -			if (!msm_dp_aux_is_link_connected(ctrl->aux))
> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !msm_dp_ctrl->plugged)
>  				break;
> =20
>  			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);

[Severity: High]
This is a pre-existing issue, but by allowing the loop to continue when AUX
is disconnected, is it possible we'll perform a DPCD read that fails, leavi=
ng
the link_status stack array uninitialized?

If drm_dp_dpcd_read_link_status() fails (which is likely if the link is
disconnected), the error return value is ignored. Uninitialized stack memor=
y is
then evaluated by msm_dp_ctrl_clock_recovery_any_ok() below to make hardware
configuration decisions.

Does this also affect the DP_TRAINING_2 case below, as well as
msm_dp_ctrl_channel_eq_ok()?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 1f60c78a463dd..93a37a44273f0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -644,6 +644,7 @@ static int msm_dp_display_prepare_link(struct msm_dp_=
display_private *dp)
>  	if (!msm_dp_display->power_on) {
>  		msm_dp_display_host_phy_init(dp);
>  		force_link_train =3D true;
> +		dp->ctrl->plugged =3D dp->plugged;

[Severity: Medium]
Is it safe to read dp->plugged here without holding the dp->plugged_lock mu=
tex?

This assignment runs in msm_dp_display_prepare_link() during atomic commit,
which could run concurrently with HPD plug/unplug events that modify
dp->plugged.

Could this lead to a data race where a stale value is read?

>  	}
> =20
>  	rc =3D msm_dp_ctrl_on_link(dp->ctrl, dp->panel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-qcom-dp-ty=
pec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com?part=3D4
