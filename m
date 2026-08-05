Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41264C55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F1310E23D;
	Wed,  5 Aug 2026 23:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="tD1/w/xj";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD1F810E23D
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 23:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=+FwJkaT/hBuV8xYdPramTwYaDQ7VYGl/Z+umXnAoKIs=; b=tD1/w/xj2z8hREey/TfYF1ABO7
 y21ZLsCTa9wIQC3MOjhRpffUlxzN+wxHTLzvM0j476CRWg6G7JlRDpIzJVuQFOwN5NeIDw2TkUGWz
 QkqymDXgowR2n5S1HHiOEGA8FiCX1skT2BHosPIv4tdO6+ndfv+nbrxQhzm7c9KoMDRI42vECjcIH
 0vAvMuBzvvnmB0iHLnKufq20Eb/hcQ58pr16ImBY9wSQjiLINg5KWEtgGqMKrZk8NMQAaMX0jiq/l
 rN1Yw+qv/uJZZ2ihM0daZxtAEEpVOxHYwVAQ0aaRy1Hkc0s+jOuIl97syFcAj4z4LETom7b3E65rU
 5xe1M5dQ==;
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
Subject: Re: [PATCH v2 00/10] Add HPD support for Rockchip Analogix DP
Date: Thu, 06 Aug 2026 01:42:14 +0200
Message-ID: <7775230.ejJDZkT8p0@diego>
In-Reply-To: <29d483f3-2eb2-4886-a4fe-9b4b6d9d14f3@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
 <5609825.iZASKD2KPV@diego>
 <29d483f3-2eb2-4886-a4fe-9b4b6d9d14f3@rock-chips.com>
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

Am Mittwoch, 5. August 2026, 06:06:48 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Damon Ding:
> Hi Heiko,
>=20
> On 8/5/2026 6:39 AM, Heiko St=C3=BCbner wrote:
> > Hi Damon,
> >=20
> > Am Dienstag, 4. August 2026, 10:17:07 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Damon Ding:
> >> Display-connector mode (DP connector without HPD GPIO):
> >>
> >>    &edp_out_conn {
> >>        remote-endpoint =3D <&dp_con_in>;
> >>    };
> >>
> >>    dp-con {
> >>        compatible =3D "dp-connector";
> >>        label =3D "DP OUT";
> >>        type =3D "full-size";
> >>
> >>        port {
> >>            dp_con_in: endpoint {
> >>                remote-endpoint =3D <&edp_out_conn>;
> >>            };
> >>        };
> >>    };
> >>
> >> Display-connector mode (DP connector with HPD GPIO):
> >>
> >>    dp-con {
> >>        compatible =3D "dp-connector";
> >>        label =3D "DP OUT";
> >>        type =3D "full-size";
> >>        pinctrl-0 =3D <&edp0_hpd>;
> >>        pinctrl-names =3D "default";
> >>        hpd-gpios =3D <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
> >>
> >>        port {
> >>            dp_con_in: endpoint {
> >>                remote-endpoint =3D <&edp_out_conn>;
> >>            };
> >>        };
> >>    };
> >>
> >> All four configurations detect cable plug/unplug events correctly.
>=20
> Thanks a lot for your testing and feedback. :-)
>=20
> It seems my test setup gave me the false impression that those cases=20
> worked well.
>=20
> >=20
> > hmm, it wasn't working entirely for me though and was still running into
> > issues when the display was unplugged on boot.
> >=20
>=20
> Are you seeing this boot=E2=80=91unplug issue for both scenarios: DP=E2=
=80=91connector=20
> with HPD=E2=80=91gpio paired with eDP without HPD=E2=80=91gpio, and DP=E2=
=80=91connector without=20
> HPD=E2=80=91gpio paired with eDP with HPD=E2=80=91gpio? I.e. it wrongly r=
eports=20
> connected even with no display plugged in and proceeds into DRM=20
> .atomic_enable()?

Yep it's different. The analogix-dp gpio-hpd works correctly,  because the
analogix driver can do gpiod_get_value() in analogix_dp_get_plug_in_status()

The dp-connector does not, as with the patch you pointed to, it lost
that ability. So on boot a plugged in display is not detected correctly
because there won't be a hotplug interrupt.

>=20
> > I wiggled around a bit like in the diff below and am now getting correct
> > plug and unplug events.
>=20
> Oh, I see. For the GPIO HPD case, the IRQ needs to be enabled early so=20
> that plug=E2=80=91in interrupts can be properly responded to. However GPI=
O HPD=20
> does not require a runtime PM get. I will better separate these two=20
> scenarios in the next version.
>=20
> >=20
> > But of course, as the dp-variant of the connector does not provide
> > a "detect" and just the "hpd" functionality, it's missing the initial s=
tate.
> >=20
> > I'm currently not sure how to find out _if_ a panel is connected on boo=
t.
> >=20
>=20
> Based on Dmitry's commit cb640b2ca546 ("drm/bridge: display=E2=80=91conne=
ctor:=20
> don't set OP_DETECT for DisplayPorts"), HPD events from DP=E2=80=91varian=
t=20
> connector should be handled by the upstream DP controller. Hence I added=
=20
> analogix_dp_bridge_notify() to retrieve HPD status coming from downstream.
>=20
> As expected, under the bridge=E2=80=91connector framework, the detect res=
ult=20
> from Analogix DP should in theory reflect the actual connection status.
> Let's dig into this boot=E2=80=91time initial=E2=80=91state issue togethe=
r.

One idea I had was, is it possible to do a drm_dp_read_dpcd_caps()
read during bind/... to see if something answers?

Thanks for all your work
Heiko

> > In other review comments:
> > - the bridge could use devm_drm_of_get_bridge() as suggested in
> >    the documentation of drm_of_find_panel_or_bridge(), as that would
> >    remove the separate panel_bridge creation
> > - instead of using plat_data->next_bridge _inside_ the driver
> >    struct drm_bridge has a field next_bridge already.
>=20
> Great suggestions, I will incorporate them for the next version=20
> alongside Sashiko's comments.
>=20
> Best regards,
> Damon
>=20
> >=20
> >=20
> > Heiko
> >=20
> >=20
> > ------- 8< -------
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drive=
rs/gpu/drm/bridge/analogix/analogix_dp_core.c
> > index 877e1b3ca7525..1388640a27de7 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > @@ -43,7 +43,7 @@ static const bool verify_fast_training;
> >   static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_dev=
ice *dp)
> >   {
> >   	return analogix_dp_is_rockchip(dp->plat_data->dev_type) && !dp->hpd_=
gpiod &&
> > -	       !dp->force_hpd;
> > +	       !dp->hpd_bridge && !dp->force_hpd;
> >   }
> >  =20
> >   static void analogix_dp_init_dp(struct analogix_dp_device *dp)
> > @@ -72,7 +72,7 @@ static int analogix_dp_detect_hpd(struct analogix_dp_=
device *dp)
> >   	 * Trust connection status from downstream bridge (e.g.,
> >   	 * display-connector with hpd-gpios).
> >   	 */
> > -	if (dp->plat_data->next_bridge && dp->connection_notified)
> > +	if (dp->hpd_bridge && dp->connection_notified)
> >   		return 0;
> >  =20
> >   	while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
> > @@ -926,10 +926,10 @@ analogix_dp_bridge_detect(struct drm_bridge *brid=
ge, struct drm_connector *conne
> >   	 */
> >   	if (dp->plat_data->next_bridge && dp->last_bridge_is_panel)
> >   		status =3D connector_status_connected;
> > -
> > -	if (!analogix_dp_detect_hpd(dp))
> > +	else if (!analogix_dp_detect_hpd(dp))
> >   		status =3D connector_status_connected;
> >  =20
> > +printk("---> %s status %d\n", __func__, status);
> >   	return status;
> >   }
> >  =20
> > @@ -1044,7 +1044,7 @@ static int analogix_dp_set_bridge(struct analogix=
_dp_device *dp)
> >   		goto out_dp_init;
> >   	}
> >  =20
> > -	if (!analogix_dp_require_pm_for_hpd_irq(dp))
> > +	if (!analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_bridge)
> >   		enable_irq(dp->irq);
> >   	return 0;
> >  =20
> > @@ -1187,7 +1187,7 @@ static void analogix_dp_bridge_disable(struct drm=
_bridge *bridge)
> >   	if (dp->dpms_mode !=3D DRM_MODE_DPMS_ON)
> >   		return;
> >  =20
> > -	if (!analogix_dp_require_pm_for_hpd_irq(dp))
> > +	if (!analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_bridge)
> >   		disable_irq(dp->irq);
> >  =20
> >   	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
> > @@ -1264,6 +1264,7 @@ static void analogix_dp_bridge_notify(struct drm_=
bridge *bridge, struct drm_conn
> >   	struct analogix_dp_device *dp =3D to_dp(bridge);
> >  =20
> >   	dp->connection_notified =3D (status =3D=3D connector_status_connecte=
d);
> > +printk("---> %s connection_notified %d\n", __func__, dp->connection_no=
tified);
> >   }
> >  =20
> >   static const struct drm_bridge_funcs analogix_dp_bridge_funcs =3D {
> > @@ -1641,6 +1642,13 @@ static int analogix_dp_aux_done_probing(struct d=
rm_dp_aux *aux)
> >   	if (ret && ret !=3D -ENODEV)
> >   		return ret;
> >  =20
> > +	/*
> > +	 * There is a next link in the chain which is not a panel, we should
> > +	 * expect hotplug-information coming from there.
> > +	 */
> > +	if (plat_data->next_bridge && !drm_bridge_is_panel(plat_data->next_br=
idge))
> > +		dp->hpd_bridge =3D true;
> > +
> >   	return component_add(dp->dev, plat_data->ops);
> >   }
> >  =20
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drive=
rs/gpu/drm/bridge/analogix/analogix_dp_core.h
> > index d0fb25e543ea0..ecca3b87b4456 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> > @@ -169,6 +169,7 @@ struct analogix_dp_device {
> >   	bool			fast_train_enable;
> >   	bool			psr_supported;
> >   	bool			last_bridge_is_panel;
> > +	bool			hpd_bridge;
> >   	bool			connection_notified;
> >  =20
> >   	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/driver=
s/gpu/drm/bridge/analogix/analogix_dp_reg.c
> > index ec5950066f838..6f0d642739ffd 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> > @@ -182,7 +182,7 @@ void analogix_dp_config_interrupt(struct analogix_d=
p_device *dp)
> >   	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
> >   	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
> >  =20
> > -	if (dp->hpd_gpiod) {
> > +	if (dp->hpd_gpiod || dp->hpd_bridge) {
> >   		analogix_dp_mute_hpd_interrupt(dp, HPD_IRQ);
> >   	} else {
> >   		/*
> > @@ -438,7 +438,7 @@ void analogix_dp_init_hpd(struct analogix_dp_device=
 *dp)
> >   {
> >   	u32 reg;
> >  =20
> > -	if (dp->hpd_gpiod)
> > +	if (dp->hpd_gpiod || dp->hpd_bridge)
> >   		return;
> >  =20
> >   	analogix_dp_clear_hotplug_interrupts(dp, HPD_IRQ);
> > @@ -539,6 +539,9 @@ int analogix_dp_get_plug_in_status(struct analogix_=
dp_device *dp)
> >   	if (dp->hpd_gpiod) {
> >   		if (gpiod_get_value(dp->hpd_gpiod))
> >   			return 0;
> > +	} else if (dp->hpd_bridge) {
> > +		if (dp->connection_notified)
> > +			return 0;
> >   	} else {
> >   		reg =3D readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
> >   		if (reg & HPD_STATUS)
> >=20
> >=20
> >=20
> >=20
> >=20
>=20
>=20




