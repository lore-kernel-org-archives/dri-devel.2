Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19869606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X03GOyY9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B1F112B6C;
	Fri, 23 Oct 2026 14:06:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F50112B73;
 Fri, 23 Oct 2026 14:05:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01AB0421EF;
 Fri, 23 Oct 2026 14:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867291F01829;
 Fri, 23 Oct 2026 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792764349;
 bh=bN4K8C2gcJoq6iVuHKcSfWsvC4b7uQWBypjpJ05w2EM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X03GOyY9GFgm7DNoST/RH7kZYWrgOstVN6nOQFjox6sr9vNJbi4EmBCUCvcHsNJL4
 ZfR3Vw49qUPPwZmq8HE8oWD/pMOSIctkgQBml98RvNAE8hi5mnXo/q+OrfCa148o3W
 632IiHtQzmzBlDwJc//IRddS5R6qKoFDdm3AmOzH2GbsnxAKbMuMG68PnqhGGJQ4gy
 /n6hWMUtf0NwoY2KM640k/Fn64e6h9foVCk3DZnmDJ6BEoOQDHGnL7oJKEYVpUUIT5
 /N7psXaH3xh2ZpEiOk8O3B27t8E81nqjraDvUP7sBxNPw82fhHXTPBTtFjAbSTNMcm
 yoCWngz9taYlA==
Message-ID: <sashiko-outbox-182863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] drm/msm/dp: handle the IRQ_HPD events reported
 by USB-C
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261023-hpd-irq-events-v7-7-57a3aea3f09e@oss.qualcomm.com>
References: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
 <20261023-hpd-irq-events-v7-7-57a3aea3f09e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 14:05:49 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dp: msm_dp_bridge_hpd_notify() runs irq_hpd on unpowered l=
ink
--

commit 378c862ef1c761eb90130da10b12f8747c15b1a2
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dp: handle the IRQ_HPD events reported by USB-C

This commit updates msm_dp_bridge_hpd_notify() to handle out-of-band
DRM_CONNECTOR_DP_IRQ_HPD events reported via USB-C AltMode notifications
and restructures the connected branch so that msm_dp_hpd_plug_handle() runs
prior to msm_dp_irq_hpd_handle().

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index ce919a26fba28..771c8b0744aee 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1566,11 +1566,13 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *=
bridge,
>  		if (hpd_link_status =3D=3D ISR_HPD_REPLUG_COUNT) {
>  			msm_dp_hpd_unplug_handle(dp);
>  			msm_dp_hpd_plug_handle(dp);
> -		} else if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT) {
> -			msm_dp_irq_hpd_handle(dp);
>  		} else {
>  			msm_dp_hpd_plug_handle(dp);
>  		}
> +
> +		if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT ||
> +		    event =3D=3D DRM_CONNECTOR_DP_IRQ_HPD)
> +			msm_dp_irq_hpd_handle(dp);

[Severity: High]
Can calling msm_dp_irq_hpd_handle(dp) unconditionally after
msm_dp_hpd_plug_handle(dp) trigger link maintenance while the mainlink and
link clocks are still off?

Previously, msm_dp_hpd_plug_handle(dp) and msm_dp_irq_hpd_handle(dp) were in
mutually exclusive branches in msm_dp_bridge_hpd_notify(). With this change,
when status is connector_status_connected and either event is
DRM_CONNECTOR_DP_IRQ_HPD or hpd_link_status is ISR_IRQ_HPD_PULSE_COUNT,
msm_dp_hpd_plug_handle(dp) runs first and is immediately followed by
msm_dp_irq_hpd_handle(dp).

When dp->plugged is false on entry (such as when a USB-C AltMode driver
reports both HPD_STATE and IRQ_HPD together on initial plug, or when a
monitor is plugged into a connected USB-C branch device whose prior
sink_count =3D=3D 0 caused msm_dp_hpd_unplug_handle() to clear dp->plugged)=
, or
after msm_dp_hpd_unplug_handle(dp) in the ISR_HPD_REPLUG_COUNT path,
msm_dp_hpd_plug_handle(dp) runs:

msm_dp_hpd_plug_handle()
  -> msm_dp_display_process_hpd_high()
       -> msm_dp_link_process_request()
            -> msm_dp_link_process_ds_port_status_change()

At this point, msm_dp_hpd_plug_handle(dp) only enables AUX transfers and
initializes the PHY; dp->msm_dp_display.power_on and ctrl->link_clks_on
remain false until msm_dp_display_atomic_enable() is called. However,
msm_dp_link_process_ds_port_status_change() has already updated
link->prev_sink_count to match link->msm_dp_link.sink_count.

When msm_dp_irq_hpd_handle(dp) then runs immediately afterward (or when an
IRQ_HPD arrives while dp->plugged is true before atomic_enable() has enabled
the mainlink):

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_irq_hpd_handle() {
	rc =3D msm_dp_link_process_request(dp->link);
	if (!rc) {
		sink_request =3D dp->link->sink_request;
		drm_dbg_dp(dp->drm_dev, "sink_request=3D%d\n", sink_request);
		if (sink_request & DS_PORT_STATUS_CHANGED)
			rc =3D msm_dp_display_process_hpd_high(dp);
		else
			rc =3D msm_dp_display_handle_irq_hpd(dp);
	}
}

If DP_DOWNSTREAM_PORT_STATUS_CHANGED is still set in
DP_LANE_ALIGN_STATUS_UPDATED, msm_dp_display_process_hpd_high(dp) is called
a second time, redundantly re-initializing LTTPRs and re-reading DPCD and
EDID.

Otherwise, because link->prev_sink_count already equals sink_count,
msm_dp_link_process_ds_port_status_change() returns -EINVAL and
msm_dp_link_process_request() falls through to
msm_dp_link_process_link_status_update():

drivers/gpu/drm/msm/dp/dp_link.c:msm_dp_link_process_request() {
	...
	} else {
		ret =3D msm_dp_link_process_link_status_update(link);
		if (!ret) {
			msm_dp_link->sink_request |=3D DP_LINK_STATUS_UPDATED;
}

Because the link has not been trained yet (dp->msm_dp_display.power_on is
false and DP_INTERLANE_ALIGN_DONE is 0), drm_dp_channel_eq_ok() is false, so
msm_dp_link_process_link_status_update() returns 0 and flags
DP_LINK_STATUS_UPDATED.

msm_dp_irq_hpd_handle(dp) then takes the else branch into
msm_dp_display_handle_irq_hpd(dp) -> msm_dp_ctrl_handle_sink_request() ->
msm_dp_ctrl_link_maintenance():

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_link_maintenance() {
	int ret =3D 0;
	int training_step =3D DP_TRAINING_NONE;

	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);

	ctrl->link->phy_params.p_level =3D 0;
	ctrl->link->phy_params.v_level =3D 0;

	ret =3D msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
	if (ret)
		goto end;

	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);

	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);

	ret =3D msm_dp_ctrl_wait4video_ready(ctrl);
}

This drives msm_dp_ctrl_push_idle() and writes to link_base registers while
!dp->msm_dp_display.power_on and !ctrl->link_clks_on, which causes unclocked
register accesses, PUSH_IDLE timeouts, or a TrustZone force-stop and SoC
reset (as noted in msm_dp_display_atomic_disable() where
msm_dp_ctrl_push_idle() is guarded by dp->power_on).

Should msm_dp_irq_hpd_handle(dp) be skipped when msm_dp_hpd_plug_handle(dp)
just handled a fresh plug, and should link maintenance in the IRQ_HPD path
check that the mainlink is powered on before attempting to retrain the link?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-hpd-irq-ev=
ents-v7-0-57a3aea3f09e@oss.qualcomm.com?part=3D7
