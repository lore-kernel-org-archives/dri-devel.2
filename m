Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF308606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOtA1Msu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2293510F547;
	Tue, 27 Oct 2026 13:50:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7658310F547
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:50:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B605601FE;
 Tue, 27 Oct 2026 13:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B19A1F01825;
 Tue, 27 Oct 2026 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793109016;
 bh=35S9i99xSjmbkcw11JZGMrWUDoyfNY2Zx3y4KVe5tbA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QOtA1MsumN1ym/AwrHCTcYhgayLZLyfnpR+2iTpXjxpyQg5UzMR15z2XI0FPFbLh7
 ZZ1tZGGVG2My/b5POOR10jxBanQ/uTg3RuFQnKsO4X6Z7Ml5yS5/OA+HZdai7tI8mv
 YcBFY6XJ39IZxPQtPZccFrjXUZqh4LlcJqRy5WIx7eUEEcmUmm2V+a5MHhcoQREN9V
 oOzmmftgumiBMfF9hfTq5Qu1jrxuhJ7x/4bpQ5QGBw69PrJG15sRj/ZnX8N3PQTKdX
 AbMmaBsc7p2f/Uje2IsgxRfVrNMW59o9Wx7fPonmBA0nlbxYtAxhg+hhEbnboAhyWO
 kKq8Mca/NW4ig==
Message-ID: <sashiko-outbox-186667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/18] drm/bridge: analogix_dp: Declare
 DRM_BRIDGE_OP_HPD for hotplug reporting
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027132810.1746118-17-damon.ding@rock-chips.com>
References: <20261027132810.1746118-1-damon.ding@rock-chips.com>
 <20261027132810.1746118-17-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:50:15 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/bridge: analogix_dp: analogix_dp_irq_thread() ignores force_co=
nnected_mode
- [Medium] drm/bridge: analogix_dp: unconditional DRM_BRIDGE_OP_HPD breaks =
polling
--

commit 38abbb3331a9d5db0a9b89496e297a81a0f82400
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Declare DRM_BRIDGE_OP_HPD for hotplug reporting

This commit declares DRM_BRIDGE_OP_HPD on the Analogix DP bridge, adds no-op
.hpd_enable and .hpd_disable callbacks, and switches analogix_dp_irq_thread=
()
from drm_helper_hpd_irq_event() to drm_bridge_hpd_notify().

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index fdf3edfd298a2..44d431a89ff6f 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

> @@ -741,9 +740,13 @@ static irqreturn_t analogix_dp_irq_thread(int irq, v=
oid *arg)
>  		hpd_detected =3D (irq_type & DP_IRQ_TYPE_HP_CABLE_IN) ||
>  			       (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT);
>  	if (hpd_detected) {
> +		enum drm_connector_status status;
> +
>  		dev_dbg(dp->dev, "Detected cable status changed!\n");
> -		if (dp->drm_dev)
> -			drm_helper_hpd_irq_event(dp->drm_dev);
> +
> +		status =3D analogix_dp_get_plug_in_status(dp) =3D=3D 0 ? connector_sta=
tus_connected :
> +								   connector_status_disconnected;
> +		drm_bridge_hpd_notify(&dp->bridge, status);
>  	}

[Severity: High]
Does reporting raw analogix_dp_get_plug_in_status() via
drm_bridge_hpd_notify() here bypass dp->force_connected_mode and
dp->force_hpd?

Previously, drm_helper_hpd_irq_event() routed through
analogix_dp_bridge_detect(), which honours both flags:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_bridge_detec=
t() {
	if (dp->force_connected_mode)
		return connector_status_connected;

	ret =3D pm_runtime_resume_and_get(dp->dev);
	if (ret)
		return connector_status_unknown;

	if (!analogix_dp_detect_hpd(dp))
		status =3D connector_status_connected;
	...
}

In contrast, drm_bridge_hpd_notify() calls drm_bridge_connector_handle_hpd(=
),
which directly overwrites connector->status without calling .detect():

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_handle_=
hpd() {
	mutex_lock(&dev->mode_config.mutex);
	connector->status =3D status;
	mutex_unlock(&dev->mode_config.mutex);

	drm_bridge_connector_hpd_notify(connector, status);

	drm_kms_helper_connector_hotplug_event(connector);
}

On boards where the bridge chain ends with a fixed panel (where
dp->force_connected_mode is true) and HPD is wired up, powering down the
panel or downstream bridge (such as nxp,ptn3460 or parade,ps8625) during DP=
MS
off or after ptn3460_edid_read() drops the HPD line. When
analogix_dp_irq_thread() runs, won't it report connector_status_disconnected
for the built-in panel and, on PTN3460 boards, trigger a continuous hotplug
and EDID read loop?

[ ... ]

> @@ -1611,7 +1624,8 @@ int analogix_dp_bind(struct analogix_dp_device *dp,=
 struct drm_device *drm_dev)
>  		return ret;
>  	}
> =20
> -	bridge->ops =3D DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
> +	bridge->ops =3D DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT |
> +		      DRM_BRIDGE_OP_HPD;

[Severity: Medium]
What happens on platforms where hardware HPD interrupts cannot fire while t=
he
DP controller is runtime-suspended if DRM_BRIDGE_OP_HPD is set
unconditionally?

In drm_bridge_connector_init(), setting DRM_BRIDGE_OP_HPD switches
connector->polled from DRM_CONNECTOR_POLL_CONNECT |
DRM_CONNECTOR_POLL_DISCONNECT to DRM_CONNECTOR_POLL_HPD, which disables
periodic polling in output_poll_execute():

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_init() {
	if (bridge_connector->bridge_hpd)
		connector->polled =3D DRM_CONNECTOR_POLL_HPD;
	else if (bridge_connector->bridge_detect)
		connector->polled =3D DRM_CONNECTOR_POLL_CONNECT
				  | DRM_CONNECTOR_POLL_DISCONNECT;
}

However, without dp->hpd_gpiod, the Analogix DP controller requires its clo=
cks
and PHY power to remain active to generate native HPD interrupts, and
analogix_dp_bind() only holds a runtime PM reference when
analogix_dp_require_pm_for_hpd_irq() is true:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_require_pm_f=
or_hpd_irq() {
	return (dp->plat_data->dev_type =3D=3D RK3576_EDP || dp->plat_data->dev_ty=
pe =3D=3D RK3588_EDP) &&
	       !dp->hpd_gpiod && !dp->force_hpd && !dp->force_connected_mode;
}

On RK3288_DP, RK3399_EDP, and EXYNOS_DP without hpd-gpios (or when
dp->force_hpd is set), the device stays runtime-suspended when idle and can=
not
raise HPD interrupts. Won't advertising DRM_BRIDGE_OP_HPD unconditionally
stop hotplug detection from working on those configurations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027132810.1746=
118-1-damon.ding@rock-chips.com?part=3D16
