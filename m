Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03923C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4499110E1DE;
	Fri, 31 Jul 2026 10:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="tcimYze/";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDFD10E1DE
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=PO5HApjpuCTFoG6dK7eT7+HEMHe6ytFiN3RSifQM+mc=; b=tcimYze/jo5hh4bufcOgKeQjX0
 wyD85SoNiH2b0XUX9aEL+MXU+3z+SdA36ny2eU1ECanI6IXsLOe0NBSp/aX8ISgIwU5qYagsXzEbw
 fEfYU99LsS4ckdkphfm6y2XOZ3Gklbu7qCKM/g5cdMl8vNJZRwydqGO7kcwjYa8XYmwA+2/zppYtO
 4gJJzMXF4qEXt7gGAE1/Ia30GUClhfTMQR3f6+qJw/WdNOr9wAvic+YvSC9hPRtJQJkxrQTD7XNGd
 bRwsooAb0jqRs5cY7R+GK74PY92b4sQrg+naxB7RATVk7BLqA1n+CYGOnRUMSqzUEWpx9UksLSA3g
 WIWEA4rQ==;
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
Date: Fri, 31 Jul 2026 12:30:03 +0200
Message-ID: <5209243.oAaWjsssbx@diego>
In-Reply-To: <44ff5316-43cc-46be-b947-ea6e1f5da1bb@rock-chips.com>
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
 <24131962.ssLaC8jLEa@diego>
 <44ff5316-43cc-46be-b947-ea6e1f5da1bb@rock-chips.com>
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

Am Freitag, 31. Juli 2026, 11:55:42 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Damon Ding:
> On 7/31/2026 5:23 PM, Heiko St=C3=BCbner wrote:
> > Am Freitag, 31. Juli 2026, 05:08:45 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Damon Ding:
> >> On 7/31/2026 2:49 AM, Heiko St=C3=BCbner wrote:
> >>> Am Donnerstag, 30. Juli 2026, 05:27:37 Mitteleurop=C3=A4ische Sommerz=
eit schrieb Damon Ding:
> >>>> This series improves the HPD (Hotplug Detect) interrupt handling in
> >>>> the Analogix DP driver to enable reliable native HPD pin detection on
> >>>> Rockchip platforms, and introduces platform-specific HPD detection
> >>>> schemes with fine-grained interrupt control.
> >>>
> >>> [...]
> >>>
> >>>> Tested on RK3576 with both native HPD pin and GPIO HPD configuration=
s.
> >>>>
> >>>> Native HPD pin mode:
> >>>>
> >>>>     &edp {
> >>>>         status =3D "okay";
> >>>>         pinctrl-names =3D "default";
> >>>>         pinctrl-0 =3D <&edp_txm0_pins>;
> >>>>     };
> >>>>
> >>>> GPIO HPD mode:
> >>>>
> >>>>     &edp {
> >>>>         status =3D "okay";
> >>>>         pinctrl-names =3D "default";
> >>>>         pinctrl-0 =3D <&edp0_hpd>;
> >>>>         hpd-gpios =3D <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
> >>>>     };
> >>>>
> >>>>     &pinctrl {
> >>>>         edp {
> >>>>             edp0_hpd: edp0-hpd {
> >>>>                 rockchip,pins =3D <4 RK_PC1 0 &pcfg_pull_none>;
> >>>>             };
> >>>>         };
> >>>>     };
> >>>
> >>> Yay and thanks a lot for working on that.
> >>>
> >>> If I roll my display-port carrier board back to the analogix-dp being
> >>> the endpoint, this works exactly as expected :-) .
> >>>
> >>> I can plug in the display at some point after the boot and have it
> >>> detected and setup correctly. Same with unplugging it while
> >>> the system is running. The connection status is correctly reported
> >>> in sysfs.
> >>>
> >>>
> >>> Though there is a caveat. When the eDP is not the last part, this doe=
s not
> >>> work anymore. The detect function always returns "connected" if there=
 is
> >>> a next bridge available.
> >>>
> >>> My board [0] has a physical DP connector on it, so models it as
> >>> dp-connector, but in that case the Analogix driver always reports bei=
ng
> >>> connected.
> >>>
> >>>
> >>> [0] https://lore.kernel.org/linux-rockchip/20251009225050.88192-3-hei=
ko@sntech.de/
> >>> ... same effect with hpd-gpios in either the edp node or dp-connector=
 node
> >>>
> >>>
> >>
> >> My previous tests were carried out on the modified RK3576 IOTEST board
> >> DTS based on RK3576 EVB1, which includes dp-connector by default. I al=
so
> >> did extra verification without dp-connector, and HPD detection works
> >> correctly in both cases.
> >>
> >> I've taken a look at the Tiger board DT configuration. The pinctrl
> >> settings for the eDP HPD GPIO may need adjustment:
> >>
> >> &pinctrl {
> >> 	edp0 {
> >> 		edp0_hpd_l: edp0-hpd-l-pin {
> >> 			rockchip,pins =3D <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> >> 		};
> >> 	};
> >> };
> >>
> >> It is recommended to configure GPIO4B5 as pull-down or pll-none. Pull-=
up
> >> configuration may prevent GPIO interrupts from being triggered properl=
y,
> >> resulting in a permanent "connected" status.
> >=20
> > At least on that DP-carrier the pin direction is different.
> > I.e. it is active-low, meaning 0 for plugged in.
> >=20
> > In the schematics I do see a hw pull up too - so pull-none in the pinco=
nfig
> > would also be possible, but pull-down is definitly wrong on _this_ boar=
d.
> >=20
> > So we're talking about the same code, I put the dts up on [0] .
> >=20
> > I'm currently running with a printk diff [1] to showcase the issue.
> >=20
> > So on boot, with the display unplugged I get:
> > [   14.757911] ---> drm_bridge_connector_detect: detect
> > [   14.757914] ---> analogix_dp_bridge_detect a
> > [   14.757918] ---> drm_bridge_connector_detect: detect
> > [   14.773779] ---> analogix_dp_bridge_detect a
> > [   14.838658] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
> > [   14.838662] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ER=
ROR* dp commit error, ret =3D -110
> > [   14.838670] rockchip-dp fdec0000.edp: failed to set bridge, retry: 0
> > [   14.884791] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
> > [   14.884793] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ER=
ROR* dp commit error, ret =3D -110
> > [   14.884796] rockchip-dp fdec0000.edp: failed to set bridge, retry: 1
> > [   14.930925] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
> > [   14.930927] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ER=
ROR* dp commit error, ret =3D -110
> > [   14.930930] rockchip-dp fdec0000.edp: failed to set bridge, retry: 2
> > [   14.977032] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
> > [   14.977034] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ER=
ROR* dp commit error, ret =3D -110
> > [   14.977037] rockchip-dp fdec0000.edp: failed to set bridge, retry: 3
> > [   15.023150] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
> > [   15.023152] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ER=
ROR* dp commit error, ret =3D -110
> > [   15.023155] rockchip-dp fdec0000.edp: failed to set bridge, retry: 4
> > [   15.023168] rockchip-dp fdec0000.edp: too many times retry set bridg=
e, give it up
> > [   15.052485] Console: switching to colour frame buffer device 80x30
> > [   15.210457] rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb=
 frame buffer device
> > [   15.223444] ---> drm_bridge_connector_detect: detect
> > [   15.231974] ---> analogix_dp_bridge_detect a
> > [   15.239587] ---> drm_bridge_connector_detect: detect
> > [   15.245341] ---> analogix_dp_bridge_detect a
> >=20
> > So analogix_dp_bridge_detect() is called and always returns connected.
> >=20
> > Plugging in the the display, I get:
> > [  290.592096] ---> display_connector_detect gpio value is 1   {display=
=2Dconnector returning connected}
> > [  290.598648] ---> drm_bridge_connector_detect: detect
> > [  290.604637] ---> analogix_dp_bridge_detect a
> > [  290.609826] ---> drm_bridge_connector_detect: detect
> > [  290.615784] ---> analogix_dp_bridge_detect a
> >=20
> > Unplugging the display, I get:
> > [  302.081444] ---> display_connector_detect gpio value is 0   {display=
=2Dconnector returning disconnected}
> > [  302.087996] ---> drm_bridge_connector_detect: detect
> > [  302.093945] ---> analogix_dp_bridge_detect a
> > [  302.099131] ---> drm_bridge_connector_detect: detect
> > [  302.105090] ---> analogix_dp_bridge_detect a
> > [  302.144834] ---> drm_bridge_connector_detect: detect
> > [  302.150784] ---> analogix_dp_bridge_detect a
> > [  302.155933] ---> drm_bridge_connector_detect: detect
> > [  302.161859] ---> analogix_dp_bridge_detect a
> >=20
> >=20
> > So it looks like on the gpio-side the detection is correct and/but
> > analogix_dp_bridge_detect() is always returning a connected state
> > ("b" output is never reached).
> >=20
> > I'm still working on understanding how the whole detection logic works
> > in drm ;-) .
> >=20
> >=20
>=20
> I think I've spotted the environmental difference between our setups.
> Your DTS places the hpd-gpios property under the dp-connector node,
> which is a scenario I haven't covered yet. I will reproduce and test=20
> this case locally.
>=20
> As a quick experiment, could you try removing hpd-gpios from=20
> dp-connector and move it under the edp node instead? As expected, GPIO=20
> HPD should work properly with that configuration.

I've updated the branch in [0] with that hpd move to the edp node, but
the result is similar:

With the panel _disconnected_ on boot I see
[   12.887555] ---> drm_bridge_connector_detect: detect
[   12.893104] ---> analogix_dp_bridge_detect a
[   12.897881] ---> drm_bridge_connector_detect: detect
[   12.903424] ---> analogix_dp_bridge_detect a
[   14.124848] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 failed to get hpd single ret =3D -110
[   14.124891] rockchip-dp fdec0000.edp: failed to set bridge, retry: 0
[   14.236031] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 failed to get hpd single ret =3D -110
[   14.236074] rockchip-dp fdec0000.edp: failed to set bridge, retry: 1
[   14.346940] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 failed to get hpd single ret =3D -110
[   14.346990] rockchip-dp fdec0000.edp: failed to set bridge, retry: 2
[   14.458590] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 failed to get hpd single ret =3D -110
[   14.458638] rockchip-dp fdec0000.edp: failed to set bridge, retry: 3
[   14.570262] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR*=
 failed to get hpd single ret =3D -110
[   14.570312] rockchip-dp fdec0000.edp: failed to set bridge, retry: 4
[   14.570328] rockchip-dp fdec0000.edp: too many times retry set bridge, g=
ive it up
[   14.751371] ---> drm_bridge_connector_detect: detect
[   14.757207] ---> analogix_dp_bridge_detect a

So with the diff from earlier, analogix_dp_bridge_detect() still runs,
finds its next bridge and returns "connected".

I.e. the
> >          if (dp->plat_data->next_bridge)
> >                  return connector_status_connected;

part.


Heiko



> > [0] https://github.com/mmind/linux-rockchip/blob/dev/v7.3/rk3588-tiger-=
dp-carrier-v5/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier=
=2Edts
> > [1]
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drive=
rs/gpu/drm/bridge/analogix/analogix_dp_core.c
> > index 7a89548a7a885..0accdf62637ae 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > @@ -915,8 +915,10 @@ analogix_dp_bridge_detect(struct drm_bridge *bridg=
e, struct drm_connector *conne
> >          struct analogix_dp_device *dp =3D to_dp(bridge);
> >          enum drm_connector_status status =3D connector_status_disconne=
cted;
> >  =20
> > +printk("---> %s a\n", __func__);
> >          if (dp->plat_data->next_bridge)
> >                  return connector_status_connected;
> > +printk("---> %s b\n", __func__);
> >  =20
> >          if (!analogix_dp_detect_hpd(dp))
> >                  status =3D connector_status_connected;
> > diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/d=
rm/bridge/display-connector.c
> > index 16c0631adeb18..b0c07694b82e3 100644
> > --- a/drivers/gpu/drm/bridge/display-connector.c
> > +++ b/drivers/gpu/drm/bridge/display-connector.c
> > @@ -45,6 +45,7 @@ static enum drm_connector_status display_connector_de=
tect(struct drm_bridge *bri
> >          struct display_connector *conn =3D to_display_connector(bridge=
);
> >  =20
> >          if (conn->hpd_gpio) {
> > +printk("---> %s gpio value is %d\n", __func__, gpiod_get_value_canslee=
p(conn->hpd_gpio));
> >                  if (gpiod_get_value_cansleep(conn->hpd_gpio))
> >                          return connector_status_connected;
> >                  else
> > @@ -84,6 +85,7 @@ static enum drm_connector_status display_connector_de=
tect(struct drm_bridge *bri
> >   static enum drm_connector_status
> >   display_connector_bridge_detect(struct drm_bridge *bridge, struct drm=
_connector *connector)
> >   {
> > +printk("---> %s\n", __func__);
> >          return display_connector_detect(bridge);
> >   }
> >  =20
> > diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/g=
pu/drm/display/drm_bridge_connector.c
> > index 649969fca1413..8816d837c9a77 100644
> > --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> > +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> > @@ -218,6 +218,7 @@ drm_bridge_connector_detect(struct drm_connector *c=
onnector, bool force)
> >          enum drm_connector_status status;
> >  =20
> >          if (detect) {
> > +printk("---> %s: detect\n", __func__);
> >                  status =3D detect->funcs->detect(detect, connector);
> >  =20
> >                  if (hdmi)
> >=20
> >=20
> >=20
> >=20
> >=20
>=20
>=20




