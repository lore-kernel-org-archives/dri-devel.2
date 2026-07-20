Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A44BC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850BD10E6A4;
	Mon, 20 Jul 2026 06:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Aa+vnLWZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0680910E6A3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:28:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D5C9601D9;
 Mon, 20 Jul 2026 06:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1081F000E9;
 Mon, 20 Jul 2026 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784528885;
 bh=aNLf25i92HQulgnCjIjxUGihIrtI2tIHqKHdG3GKDP0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Aa+vnLWZHTfSgheBgAYUj4dxW4pSz33qCZmlRpsgAWmWTx8YW+Lsb7skrh1x+aeWg
 U5JJVETkDMKsRX3IpRWNuhHSIStvuUZLr69Iao0QhSZHt3OVRDbQabeKaHgjq2tOvN
 r/NAn6bgCoU9BQHxakVvn6Dx8oEj2qn66uhG1DCwlEno/noGo0GL6kPo4UEaBq1OQC
 FxdeW2OBaZOxv3nh5a2PnaOFCHlfrLajFK28mRA5htKqgr2CiOfKLnBLaAlXwJq3qQ
 uzuVZhImRfZK7L5RNK3sh68xCWLf52q/o1Jv+woOlzSkbCwNIZCR2kWnvLyZ8vh5yX
 UF1y5ADTjBtKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/15] drm/msm/dp: simplify link and clock disable
 sequence
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-dp_mstclean-v8-12-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-12-bea261bf4e7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:28:04 +0000
Message-Id: <20260720062804.DE1081F000E9@smtp.kernel.org>
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
- [High] The refactored code introduces a Time-of-Check to Time-of-Use (TOC=
TOU) race condition by evaluating `dp->link->sink_count =3D=3D 0` twice.
--

--- Patch [12]: [PATCH v8 12/15] drm/msm/dp: simplify link and clock disabl=
e sequence ---
commit 84b41be14edf75da081c987f79e9f547234b2511
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: simplify link and clock disable sequence

This commit moves common disable steps out of the sink_count check to
make the flow easier to follow. No functional change is intended.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 1ecd700a474fe..d1a3a6f6c303d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -718,27 +718,19 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp)
> =20
>  	msm_dp_panel_disable_vsc_sdp(dp->panel);
> =20
> -	/* dongle is still connected but sinks are disconnected */
> -	if (dp->link->sink_count =3D=3D 0) {
> -		/*
> -		 * irq_hpd with sink_count =3D 0
> -		 * hdmi unplugged out of dongle
> -		 */
> +	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> =20
> -		/* set dongle to D3 (power off) mode */
> +	/* dongle is still connected but sinks are disconnected */
> +	if (dp->link->sink_count =3D=3D 0)
>  		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> -		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +
> +	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +
> +	if (dp->link->sink_count =3D=3D 0)

[Severity: High]
Can checking dp->link->sink_count twice in this function introduce a race
condition?

If a hotplug or unplug event occurs exactly between these two checks, the
IRQ thread could dynamically update dp->link->sink_count via
msm_dp_irq_hpd_handle() -> msm_dp_link_process_request() while
msm_dp_display_disable() is executing.

Since there are no locks serializing the IRQ thread update against this
atomic disable sequence, could this result in an inconsistent hardware stat=
e?

For example, the dongle might be put into D3 power-off mode during the first
check, but if sink_count changes before the second check, the host PHY
might be exited instead of re-initialized.

The original code evaluated sink_count once and used an if/else block,
which guaranteed a mutually exclusive and consistent teardown sequence.
Would it be safer to cache the value of sink_count in a local variable
prior to the first check and use that local variable for both conditions?

> +		/* re-init the PHY so that we can listen to Dongle disconnect */
>  		msm_dp_ctrl_reinit_phy(dp->ctrl);
> -	} else {
> -		/*
> -		 * unplugged interrupt
> -		 * dongle unplugged out of DUT
> -		 */
> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> -		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +	else
>  		msm_dp_display_host_phy_exit(dp);
> -	}
> =20
>  	msm_dp_display->power_on =3D false;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-dp_mstclea=
n-v8-0-bea261bf4e7d@oss.qualcomm.com?part=3D12
