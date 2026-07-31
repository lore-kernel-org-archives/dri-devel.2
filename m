Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B35C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6D710E1C9;
	Fri, 31 Jul 2026 09:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="B/JJqca+";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DC110E1C9
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=oFHrJog3XUbgCM9lluuv2EFqo2uk4k0XFykLEC/aems=; b=B/JJqca+bPMKWjUiWl5Ddpdrou
 /GV08FXx0rPSiUWzPmjNIMqI0Yz+rT5qhA02yhHndBqmS2OD2DhNX0ahpXwavNj+e48+Tv0Gu0y71
 MEH4nbUPhcSxHaH8jdJWMPrtTNN2OFIsS9o1gN33KtBkmdPy/a+fJsy+yYUODYWD9AP0zO0/mHM0W
 pLY1m4cyT75b+EinDrycvjePS+9ujH0A4J8QhevV9UaGdtEdMVp8cWWDMIagU5ZIk32lZ0FmauK+P
 qLHJatO/RaIwRJoVgGawN2vA34bmRRp1/xn7+1xhIbaqtC60E0hRPMZwIpW+ACoiynPNImVx9KOAY
 Fv9/JhCA==;
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
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/7] Add HPD support for Rockchip Analogix DP
Date: Fri, 31 Jul 2026 11:23:43 +0200
Message-ID: <24131962.ssLaC8jLEa@diego>
In-Reply-To: <f0bec6c2-5bc9-4c06-abe0-cf6189382314@rock-chips.com>
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
 <2014349.VZ3vTMCxA0@diego>
 <f0bec6c2-5bc9-4c06-abe0-cf6189382314@rock-chips.com>
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

Am Freitag, 31. Juli 2026, 05:08:45 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Damon Ding:
> On 7/31/2026 2:49 AM, Heiko St=C3=BCbner wrote:
> > Am Donnerstag, 30. Juli 2026, 05:27:37 Mitteleurop=C3=A4ische Sommerzei=
t schrieb Damon Ding:
> >> This series improves the HPD (Hotplug Detect) interrupt handling in
> >> the Analogix DP driver to enable reliable native HPD pin detection on
> >> Rockchip platforms, and introduces platform-specific HPD detection
> >> schemes with fine-grained interrupt control.
> >=20
> > [...]
> >=20
> >> Tested on RK3576 with both native HPD pin and GPIO HPD configurations.
> >>
> >> Native HPD pin mode:
> >>
> >>    &edp {
> >>        status =3D "okay";
> >>        pinctrl-names =3D "default";
> >>        pinctrl-0 =3D <&edp_txm0_pins>;
> >>    };
> >>
> >> GPIO HPD mode:
> >>
> >>    &edp {
> >>        status =3D "okay";
> >>        pinctrl-names =3D "default";
> >>        pinctrl-0 =3D <&edp0_hpd>;
> >>        hpd-gpios =3D <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
> >>    };
> >>
> >>    &pinctrl {
> >>        edp {
> >>            edp0_hpd: edp0-hpd {
> >>                rockchip,pins =3D <4 RK_PC1 0 &pcfg_pull_none>;
> >>            };
> >>        };
> >>    };
> >=20
> > Yay and thanks a lot for working on that.
> >=20
> > If I roll my display-port carrier board back to the analogix-dp being
> > the endpoint, this works exactly as expected :-) .
> >=20
> > I can plug in the display at some point after the boot and have it
> > detected and setup correctly. Same with unplugging it while
> > the system is running. The connection status is correctly reported
> > in sysfs.
> >=20
> >=20
> > Though there is a caveat. When the eDP is not the last part, this does =
not
> > work anymore. The detect function always returns "connected" if there is
> > a next bridge available.
> >=20
> > My board [0] has a physical DP connector on it, so models it as
> > dp-connector, but in that case the Analogix driver always reports being
> > connected.
> >=20
> >=20
> > [0] https://lore.kernel.org/linux-rockchip/20251009225050.88192-3-heiko=
@sntech.de/
> > ... same effect with hpd-gpios in either the edp node or dp-connector n=
ode
> >=20
> >=20
>=20
> My previous tests were carried out on the modified RK3576 IOTEST board=20
> DTS based on RK3576 EVB1, which includes dp-connector by default. I also=
=20
> did extra verification without dp-connector, and HPD detection works=20
> correctly in both cases.
>=20
> I've taken a look at the Tiger board DT configuration. The pinctrl=20
> settings for the eDP HPD GPIO may need adjustment:
>=20
> &pinctrl {
> 	edp0 {
> 		edp0_hpd_l: edp0-hpd-l-pin {
> 			rockchip,pins =3D <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> 		};
> 	};
> };
>=20
> It is recommended to configure GPIO4B5 as pull-down or pll-none. Pull-up=
=20
> configuration may prevent GPIO interrupts from being triggered properly,=
=20
> resulting in a permanent "connected" status.

At least on that DP-carrier the pin direction is different.
I.e. it is active-low, meaning 0 for plugged in.

In the schematics I do see a hw pull up too - so pull-none in the pinconfig
would also be possible, but pull-down is definitly wrong on _this_ board.

So we're talking about the same code, I put the dts up on [0] .

I'm currently running with a printk diff [1] to showcase the issue.

So on boot, with the display unplugged I get:
[   14.757911] ---> drm_bridge_connector_detect: detect
[   14.757914] ---> analogix_dp_bridge_detect a
[   14.757918] ---> drm_bridge_connector_detect: detect
[   14.773779] ---> analogix_dp_bridge_detect a
[   14.838658] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
[   14.838662] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 dp commit error, ret =3D -110
[   14.838670] rockchip-dp fdec0000.edp: failed to set bridge, retry: 0
[   14.884791] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
[   14.884793] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 dp commit error, ret =3D -110
[   14.884796] rockchip-dp fdec0000.edp: failed to set bridge, retry: 1
[   14.930925] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
[   14.930927] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 dp commit error, ret =3D -110
[   14.930930] rockchip-dp fdec0000.edp: failed to set bridge, retry: 2
[   14.977032] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
[   14.977034] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 dp commit error, ret =3D -110
[   14.977037] rockchip-dp fdec0000.edp: failed to set bridge, retry: 3
[   15.023150] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
[   15.023152] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 dp commit error, ret =3D -110
[   15.023155] rockchip-dp fdec0000.edp: failed to set bridge, retry: 4
[   15.023168] rockchip-dp fdec0000.edp: too many times retry set bridge, g=
ive it up
[   15.052485] Console: switching to colour frame buffer device 80x30
[   15.210457] rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb fra=
me buffer device
[   15.223444] ---> drm_bridge_connector_detect: detect
[   15.231974] ---> analogix_dp_bridge_detect a
[   15.239587] ---> drm_bridge_connector_detect: detect
[   15.245341] ---> analogix_dp_bridge_detect a

So analogix_dp_bridge_detect() is called and always returns connected.

Plugging in the the display, I get:
[  290.592096] ---> display_connector_detect gpio value is 1   {display-con=
nector returning connected}
[  290.598648] ---> drm_bridge_connector_detect: detect
[  290.604637] ---> analogix_dp_bridge_detect a
[  290.609826] ---> drm_bridge_connector_detect: detect
[  290.615784] ---> analogix_dp_bridge_detect a

Unplugging the display, I get:
[  302.081444] ---> display_connector_detect gpio value is 0   {display-con=
nector returning disconnected}
[  302.087996] ---> drm_bridge_connector_detect: detect
[  302.093945] ---> analogix_dp_bridge_detect a
[  302.099131] ---> drm_bridge_connector_detect: detect
[  302.105090] ---> analogix_dp_bridge_detect a
[  302.144834] ---> drm_bridge_connector_detect: detect
[  302.150784] ---> analogix_dp_bridge_detect a
[  302.155933] ---> drm_bridge_connector_detect: detect
[  302.161859] ---> analogix_dp_bridge_detect a


So it looks like on the gpio-side the detection is correct and/but
analogix_dp_bridge_detect() is always returning a connected state
("b" output is never reached).

I'm still working on understanding how the whole detection logic works
in drm ;-) .


Heiko


[0] https://github.com/mmind/linux-rockchip/blob/dev/v7.3/rk3588-tiger-dp-c=
arrier-v5/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts
[1]
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/g=
pu/drm/bridge/analogix/analogix_dp_core.c
index 7a89548a7a885..0accdf62637ae 100644
=2D-- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -915,8 +915,10 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, s=
truct drm_connector *conne
        struct analogix_dp_device *dp =3D to_dp(bridge);
        enum drm_connector_status status =3D connector_status_disconnected;
=20
+printk("---> %s a\n", __func__);
        if (dp->plat_data->next_bridge)
                return connector_status_connected;
+printk("---> %s b\n", __func__);
=20
        if (!analogix_dp_detect_hpd(dp))
                status =3D connector_status_connected;
diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/b=
ridge/display-connector.c
index 16c0631adeb18..b0c07694b82e3 100644
=2D-- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -45,6 +45,7 @@ static enum drm_connector_status display_connector_detect=
(struct drm_bridge *bri
        struct display_connector *conn =3D to_display_connector(bridge);
=20
        if (conn->hpd_gpio) {
+printk("---> %s gpio value is %d\n", __func__, gpiod_get_value_cansleep(co=
nn->hpd_gpio));
                if (gpiod_get_value_cansleep(conn->hpd_gpio))
                        return connector_status_connected;
                else
@@ -84,6 +85,7 @@ static enum drm_connector_status display_connector_detect=
(struct drm_bridge *bri
 static enum drm_connector_status
 display_connector_bridge_detect(struct drm_bridge *bridge, struct drm_conn=
ector *connector)
 {
+printk("---> %s\n", __func__);
        return display_connector_detect(bridge);
 }
=20
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/d=
rm/display/drm_bridge_connector.c
index 649969fca1413..8816d837c9a77 100644
=2D-- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -218,6 +218,7 @@ drm_bridge_connector_detect(struct drm_connector *conne=
ctor, bool force)
        enum drm_connector_status status;
=20
        if (detect) {
+printk("---> %s: detect\n", __func__);
                status =3D detect->funcs->detect(detect, connector);
=20
                if (hdmi)



