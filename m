Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FD1C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E86E10E071;
	Sun, 20 Sep 2026 15:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FRXCrKeL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6E110E071;
 Sun, 20 Sep 2026 15:13:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57CEF601DB;
 Sun, 20 Sep 2026 15:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CB21F000FF;
 Sun, 20 Sep 2026 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789917238;
 bh=uskhW3QppAJj/1NNU0uiHhxLbJ4x1v2R7+YF0xtUvtg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FRXCrKeLMKGkj+arWmRQtuiFHeB3QY/j1SduJ/TVNI4W2RggCrvr0uEWX9dotct5Q
 3umdAR8vVG+bimbJkxWItMf+LxqXP//1b9S8HX9ntgXMkTaWc1eOCb9jsOT9tGkh7r
 3dJucHw2x+bWxrJl1uFKRdoqqJYok0UPM1rCAp6r9aojSRCHm2lFcy7i5bLtJFvU7o
 5zHAQfWdyQjVacHPSp1XJ40e/l6nm4DnEBFj25RBFXuCSxIlzF/vRmElqN8nxlOa8H
 s+xW3oUAzaUQQT/uooAtBSXuh22jLCwttheetYZGCIVCrh35J9ps5M72TOlH+Zh/92
 6ZPKaN2ncjrGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] drm/msm: dp: handle the IRQ_HPD events reported
 by USB-C
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-amlogic@lists.infradead.org, intel-xe@lists.freedesktop.org,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260920-hpd-irq-events-v5-6-ff1de0090c72@oss.qualcomm.com>
References: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
 <20260920-hpd-irq-events-v5-6-ff1de0090c72@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 15:13:57 +0000
Message-Id: <20260920151357.A9CB21F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: missing display initialization on coalesced plug and I=
RQ_HPD events
--

commit de969f3016008fcb55e0b380cb8e0c733c719543
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: dp: handle the IRQ_HPD events reported by USB-C

This commit allows the MSM DisplayPort driver to handle IRQ_HPD events
delivered over OOB events (like USB-C AltMode).

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1559,11 +1559,12 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *=
bridge,
[ ... ]
>  	if (status =3D=3D connector_status_connected) {
> -		if (hpd_link_status =3D=3D ISR_HPD_REPLUG_COUNT) {
> +		if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT ||
> +		    event =3D=3D DRM_CONNECTOR_DP_IRQ_HPD) {
> +			msm_dp_irq_hpd_handle(dp);
> +		} else if (hpd_link_status =3D=3D ISR_HPD_REPLUG_COUNT) {
>  			msm_dp_hpd_unplug_handle(dp);
>  			msm_dp_hpd_plug_handle(dp);
> -		} else if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT) {
> -			msm_dp_irq_hpd_handle(dp);
>  		} else {
>  			msm_dp_hpd_plug_handle(dp);
>  		}

[Severity: High]
Does this code handle coalesced connection and IRQ_HPD events correctly?

If the USB Type-C AltMode driver coalesces an initial connection and a pend=
ing
IRQ_HPD event into a single notification, msm_dp_bridge_hpd_notify() receiv=
es
both status =3D=3D connector_status_connected and event =3D=3D
DRM_CONNECTOR_DP_IRQ_HPD.

The mutual exclusion block in drivers/gpu/drm/msm/dp/dp_display.c prioritiz=
es
event =3D=3D DRM_CONNECTOR_DP_IRQ_HPD, branching to msm_dp_irq_hpd_handle()=
 and
entirely skipping msm_dp_hpd_plug_handle().

Because msm_dp_hpd_plug_handle() is skipped, dp->plugged remains false,
the DP PHY is not initialized, and AUX transfers remain disabled. The
subsequent msm_dp_irq_hpd_handle() then attempts an AUX read which immediat=
ely
fails with -ENXIO, abandoning the initialization and leaving the display
blank.

Is it possible to ensure msm_dp_hpd_plug_handle() is still called when a new
connection occurs alongside an IRQ_HPD event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-hpd-irq-ev=
ents-v5-0-ff1de0090c72@oss.qualcomm.com?part=3D6
