Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04781CD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F99F10E67A;
	Sun,  7 Jun 2026 21:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kCkTKb1D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D774210E67A
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:48:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FEEB60018;
 Sun,  7 Jun 2026 21:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05091F00893;
 Sun,  7 Jun 2026 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780868910;
 bh=U8/nAEIUsIEuWNhzHG7THuc153jQDkJAzRdpq4tLzZM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kCkTKb1D/8B8+RSIzStZbrpXcdbecpV33zyZzGdOB90Bdp7QyfyKCLE8X63+liL42
 cxYuLgXeVh2VydzTqidijq9JOD76nvMULXEu6u3FGSaMIYV2uzeu55c+3FZ8dbNme4
 4G+XElSTMlTqh1aro4r4WmnhxccJ8rTSXbZGEOGkoygNRj8HPfKPF/fnR2y95nFaBc
 J05GfWPDVX3UjKmWky6GiXyswbC89esphgTKrIiMqv+bvnu+s7aZymt5xbQxMwVOHz
 srBVtiLCO4R6QjLcht9vvhfXT+O/h54JWgYqzK7CkCnG8PLsOxKgN+I3cc42LJVyXS
 IFiwDAT7TS36Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/8] drm/msm: dp: handle the IRQ_HPD events reported
 by USB-C
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260608-hpd-irq-events-v4-6-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-6-30b62b335487@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:48:29 +0000
Message-Id: <20260607214829.B05091F00893@smtp.kernel.org>
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
- [High] Initial connection and replug events are incorrectly bypassed if a=
ccompanied by an IRQ_HPD status, leaving the display disconnected.

Pre-existing issues:
- [High] `msm_dp_irq_hpd_handle` modifies shared state without acquiring `d=
p->plugged_lock`, leading to unprotected concurrent modification of DPCD an=
d link state.
--

commit 48a78358ae98020ff3993aab3250dd8c32cc6835
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: dp: handle the IRQ_HPD events reported by USB-C

This patch adds support for tracking and handling IRQ_HPD events
delivered over out-of-band events (such as USB-C AltMode handlers)
in the MSM DisplayPort driver.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index c0f6a8ff9b99d..743d8fa40dc68 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1533,11 +1533,12 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *=
bridge,
>  		   msm_dp_display->connector_type, hpd_link_status, status);
> =20
>  	if (status =3D=3D connector_status_connected) {
> -		if (hpd_link_status =3D=3D ISR_HPD_REPLUG_COUNT) {
> +		if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT ||
> +		    extra_status =3D=3D DRM_CONNECTOR_DP_IRQ_HPD) {
> +			msm_dp_irq_hpd_handle(dp);

[Severity: High]
This is a pre-existing issue, but does msm_dp_irq_hpd_handle() need to
acquire the dp->plugged_lock?

Since msm_dp_irq_hpd_handle() can call msm_dp_display_process_hpd_high(),
which reads from DPCD and modifies shared driver state (like
dp->link->lttpr_count, dp->panel->dpcd, and dp->audio_supported), it seems
like it could race. Other HPD handlers like msm_dp_hpd_plug_handle() use
guard(mutex)(&dp->plugged_lock) to safely synchronize access.

With out-of-band events processed via workqueues, can this function
run concurrently with other HPD handlers or msm_dp_bridge_detect() and
corrupt the internal representation of the hardware configuration?

[Severity: High]
If an out-of-band handler reports an initial connection with both hpd_state=
=3D1
and hpd_irq=3D1 simultaneously, does this new ordering bypass the required =
plug
sequence?

By placing the IRQ_HPD check at the top of the if/else chain, if
extra_status =3D=3D DRM_CONNECTOR_DP_IRQ_HPD, the code will execute
msm_dp_irq_hpd_handle() and skip msm_dp_hpd_plug_handle().

If msm_dp_hpd_plug_handle() is skipped, dp->plugged remains false, PHY
initialization (msm_dp_display_host_phy_init) never occurs, and
msm_dp_aux_enable_xfers() is never called. Won't the subsequent AUX reads
within msm_dp_irq_hpd_handle() fail with -ENXIO, aborting the initialization
and leaving the display disconnected?

> +		} else if (hpd_link_status =3D=3D ISR_HPD_REPLUG_COUNT) {
>  			msm_dp_hpd_unplug_handle(dp);
>  			msm_dp_hpd_plug_handle(dp);
> -		} else if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT) {
> -			msm_dp_irq_hpd_handle(dp);
>  		} else {
>  			msm_dp_hpd_plug_handle(dp);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-hpd-irq-ev=
ents-v4-0-30b62b335487@oss.qualcomm.com?part=3D6
