Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30721C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 22:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EC5710EBE5;
	Tue,  4 Aug 2026 22:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="tKlXMgpH";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669BD10EBE5
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=/j2uzAZhQxgwE4ZqlG1NwZ+n42HBZvLc30dmyOCIIDc=; b=tKlXMgpHpsKfcsFbugXKoX47cv
 PWexKvcUfggrRpoY/SsA/6G9xeHzbqnbpboHOquImuE9MXMAb2LnR3g/RzS6fqgfFrv6bSjf/UR9Z
 ZoOcrZz8feZlDAt33YaOdgey1P/Ps8Sq5XlyL5eFbTjOMyT8PmnXEonvtGU1JWm4L5NEP5wAnA7Tf
 TKnNqqJdXifFlNNFw0R2T0+vWWkZQf3aHJPuDkfpmJfcHbS9OyQYKl0UvIxWEGknPjMD5Eda4oKCh
 A0+ZzItV+XUyPgNIh4TRmNuGzKGNIEyMdc3W10ZrObeyCgpDHA+rHTdOMDkUoomrVCP2H5OPpGvS3
 8LZmUPKw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andy Yan <andy.yan@rock-chips.com>, Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v2 00/10] Add HPD support for Rockchip Analogix DP
Date: Wed, 05 Aug 2026 00:39:27 +0200
Message-ID: <5609825.iZASKD2KPV@diego>
In-Reply-To: <20260804081717.741404-1-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Damon,

Am Dienstag, 4. August 2026, 10:17:07 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Damon Ding:
> Display-connector mode (DP connector without HPD GPIO):
>=20
>   &edp_out_conn {
>       remote-endpoint =3D <&dp_con_in>;
>   };
>=20
>   dp-con {
>       compatible =3D "dp-connector";
>       label =3D "DP OUT";
>       type =3D "full-size";
>=20
>       port {
>           dp_con_in: endpoint {
>               remote-endpoint =3D <&edp_out_conn>;
>           };
>       };
>   };
>=20
> Display-connector mode (DP connector with HPD GPIO):
>=20
>   dp-con {
>       compatible =3D "dp-connector";
>       label =3D "DP OUT";
>       type =3D "full-size";
>       pinctrl-0 =3D <&edp0_hpd>;
>       pinctrl-names =3D "default";
>       hpd-gpios =3D <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
>=20
>       port {
>           dp_con_in: endpoint {
>               remote-endpoint =3D <&edp_out_conn>;
>           };
>       };
>   };
>=20
> All four configurations detect cable plug/unplug events correctly.

hmm, it wasn't working entirely for me though and was still running into
issues when the display was unplugged on boot.

I wiggled around a bit like in the diff below and am now getting correct
plug and unplug events.

But of course, as the dp-variant of the connector does not provide
a "detect" and just the "hpd" functionality, it's missing the initial state.

I'm currently not sure how to find out _if_ a panel is connected on boot.


In other review comments:
=2D the bridge could use devm_drm_of_get_bridge() as suggested in
  the documentation of drm_of_find_panel_or_bridge(), as that would
  remove the separate panel_bridge creation
=2D instead of using plat_data->next_bridge _inside_ the driver
  struct drm_bridge has a field next_bridge already.


Heiko


=2D------ 8< -------
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/g=
pu/drm/bridge/analogix/analogix_dp_core.c
index 877e1b3ca7525..1388640a27de7 100644
=2D-- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -43,7 +43,7 @@ static const bool verify_fast_training;
 static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device *=
dp)
 {
 	return analogix_dp_is_rockchip(dp->plat_data->dev_type) && !dp->hpd_gpiod=
 &&
=2D	       !dp->force_hpd;
+	       !dp->hpd_bridge && !dp->force_hpd;
 }
=20
 static void analogix_dp_init_dp(struct analogix_dp_device *dp)
@@ -72,7 +72,7 @@ static int analogix_dp_detect_hpd(struct analogix_dp_devi=
ce *dp)
 	 * Trust connection status from downstream bridge (e.g.,
 	 * display-connector with hpd-gpios).
 	 */
=2D	if (dp->plat_data->next_bridge && dp->connection_notified)
+	if (dp->hpd_bridge && dp->connection_notified)
 		return 0;
=20
 	while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
@@ -926,10 +926,10 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, =
struct drm_connector *conne
 	 */
 	if (dp->plat_data->next_bridge && dp->last_bridge_is_panel)
 		status =3D connector_status_connected;
=2D
=2D	if (!analogix_dp_detect_hpd(dp))
+	else if (!analogix_dp_detect_hpd(dp))
 		status =3D connector_status_connected;
=20
+printk("---> %s status %d\n", __func__, status);
 	return status;
 }
=20
@@ -1044,7 +1044,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_=
device *dp)
 		goto out_dp_init;
 	}
=20
=2D	if (!analogix_dp_require_pm_for_hpd_irq(dp))
+	if (!analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_bridge)
 		enable_irq(dp->irq);
 	return 0;
=20
@@ -1187,7 +1187,7 @@ static void analogix_dp_bridge_disable(struct drm_bri=
dge *bridge)
 	if (dp->dpms_mode !=3D DRM_MODE_DPMS_ON)
 		return;
=20
=2D	if (!analogix_dp_require_pm_for_hpd_irq(dp))
+	if (!analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_bridge)
 		disable_irq(dp->irq);
=20
 	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
@@ -1264,6 +1264,7 @@ static void analogix_dp_bridge_notify(struct drm_brid=
ge *bridge, struct drm_conn
 	struct analogix_dp_device *dp =3D to_dp(bridge);
=20
 	dp->connection_notified =3D (status =3D=3D connector_status_connected);
+printk("---> %s connection_notified %d\n", __func__, dp->connection_notifi=
ed);
 }
=20
 static const struct drm_bridge_funcs analogix_dp_bridge_funcs =3D {
@@ -1641,6 +1642,13 @@ static int analogix_dp_aux_done_probing(struct drm_d=
p_aux *aux)
 	if (ret && ret !=3D -ENODEV)
 		return ret;
=20
+	/*
+	 * There is a next link in the chain which is not a panel, we should
+	 * expect hotplug-information coming from there.
+	 */
+	if (plat_data->next_bridge && !drm_bridge_is_panel(plat_data->next_bridge=
))
+		dp->hpd_bridge =3D true;
+
 	return component_add(dp->dev, plat_data->ops);
 }
=20
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/g=
pu/drm/bridge/analogix/analogix_dp_core.h
index d0fb25e543ea0..ecca3b87b4456 100644
=2D-- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -169,6 +169,7 @@ struct analogix_dp_device {
 	bool			fast_train_enable;
 	bool			psr_supported;
 	bool			last_bridge_is_panel;
+	bool			hpd_bridge;
 	bool			connection_notified;
=20
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gp=
u/drm/bridge/analogix/analogix_dp_reg.c
index ec5950066f838..6f0d642739ffd 100644
=2D-- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -182,7 +182,7 @@ void analogix_dp_config_interrupt(struct analogix_dp_de=
vice *dp)
 	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
 	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
=20
=2D	if (dp->hpd_gpiod) {
+	if (dp->hpd_gpiod || dp->hpd_bridge) {
 		analogix_dp_mute_hpd_interrupt(dp, HPD_IRQ);
 	} else {
 		/*
@@ -438,7 +438,7 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
 {
 	u32 reg;
=20
=2D	if (dp->hpd_gpiod)
+	if (dp->hpd_gpiod || dp->hpd_bridge)
 		return;
=20
 	analogix_dp_clear_hotplug_interrupts(dp, HPD_IRQ);
@@ -539,6 +539,9 @@ int analogix_dp_get_plug_in_status(struct analogix_dp_d=
evice *dp)
 	if (dp->hpd_gpiod) {
 		if (gpiod_get_value(dp->hpd_gpiod))
 			return 0;
+	} else if (dp->hpd_bridge) {
+		if (dp->connection_notified)
+			return 0;
 	} else {
 		reg =3D readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 		if (reg & HPD_STATUS)



