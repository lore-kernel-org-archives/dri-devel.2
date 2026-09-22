Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D538C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5845110E567;
	Tue, 22 Sep 2026 08:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LnTFAd4m";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20CB10E675
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:13:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id CE65E1A0DD6;
 Tue, 22 Sep 2026 08:13:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 96D6460580;
 Tue, 22 Sep 2026 08:13:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D6AFB10328D70; 
 Tue, 22 Sep 2026 10:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790064785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+4tc4WrD7xuF4GfB/Nn6fXDY5uWGKEnQHZ/D87EsmTs=;
 b=LnTFAd4mCzqGDkYK1NWpQqZp+AHMWYe/3N0CTAWuJBghY34EG9idJRaiDyXJAsymobD+IF
 rB701F/hR5e7V7STg6lvSSa8ZmcKpy4nvT+F46xFXO9Mymvy/BQ8XB8M989lvRaB3xE25S
 3hoEf1waSjO0crSI3tT7ge1qgFVFo6ZBPXK9yrs8eEk//hTVglS/nEHgmz0nJDo3wII85h
 9HJEuGPwB17h8DQYcTIPO/aRwcxnPRHvJfobIyLL4CG7d3Z5wykQEnRIFMF6LYZWsGOnRj
 2sNEOcA4RUzf23RHAG3mnsxb2hULULkM1K2sNyeFrunTwcZSKiCDraR3DcoVEw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 10:12:41 +0200
Message-Id: <DLLOZYM6YWJ3.6Q0LRD1WABGW@bootlin.com>
To: "Damon Ding" <damon.ding@rock-chips.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>,
 "Lucas Stach" <l.stach@pengutronix.de>, "Frank Li" <Frank.Li@nxp.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Paul
 Cercueil" <paul@crapouillou.net>, "Paul Kocialkowski" <paulk@sys-base.io>,
 "Linus Walleij" <linusw@kernel.org>, "Inki Dae" <inki.dae@samsung.com>,
 "Jagan Teki" <jagan@amarulasolutions.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Sean Paul" <sean@poorly.run>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 19/19] drm/bridge: analogix_dp: don't create a
 panel_bridge
Cc: "Albert Esteve" <aesteve@redhat.com>, "Anusha Srivatsa"
 <asrivats@redhat.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <asahi@lists.linux.dev>,
 <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <linux-tegra@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
X-Mailer: aerc 0.22.0
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-19-83afb4f1a707@bootlin.com>
 <975a4d45-9a61-4858-b498-8bc0a1e44746@rock-chips.com>
In-Reply-To: <975a4d45-9a61-4858-b498-8bc0a1e44746@rock-chips.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Damon,

On Mon Sep 21, 2026 at 5:07 AM CEST, Damon Ding wrote:
> Hi Luca,
>
> On 9/16/2026 9:45 PM, Luca Ceresoli wrote:
>> Now a panel_bridge is automatically created for every drm_panel and the
>> panel-bridge API is just a deprecated wrapper to access it.
>>
>> Update and simplify the code by just getting a reference to the
>> already-existing bridge using of_drm_get_bridge_by_endpoint().
>>
>> As of_drm_get_bridge_by_endpoint() returns a refcounted bridge, take car=
e
>> of putting the bridge reference. This is not easily done in the remove p=
ath
>> due to the different probe paths of the user drivers, so add a devm acti=
on
>> to ensure the reference is put only when it was taken.
>>
>> Assisted-by: opencode:deepseek-v4-flash-0731
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>>   drivers/gpu/drm/bridge/analogix/Kconfig            |  1 -
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 40 +++++++++++++-=
--------
>>   drivers/gpu/drm/exynos/exynos_dp.c                 | 36 ++------------=
-----
>>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  9 -----
>>   include/drm/bridge/analogix_dp.h                   |  1 -
>>   5 files changed, 25 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/b=
ridge/analogix/Kconfig
>> index da156fd15764..5672d83cb4a1 100644
>> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
>> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
>> @@ -33,7 +33,6 @@ config DRM_ANALOGIX_DP
>>   	depends on DRM
>>   	depends on OF
>>   	select DRM_DISPLAY_DP_AUX_BUS
>> -	select DRM_PANEL
>>
>>   config DRM_ANALOGIX_ANX7625
>>   	tristate "Analogix Anx7625 MIPI to DP interface support"
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/driver=
s/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 18e76d1e78e1..6df6963740d2 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -29,7 +29,6 @@
>>   #include <drm/drm_device.h>
>>   #include <drm/drm_edid.h>
>>   #include <drm/drm_of.h>
>> -#include <drm/drm_panel.h>
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_probe_helper.h>
>>
>> @@ -1567,15 +1566,6 @@ int analogix_dp_bind(struct analogix_dp_device *d=
p, struct drm_device *drm_dev)
>>   	if (ret)
>>   		goto err_unregister_aux;
>>
>> -	if (dp->plat_data->panel) {
>> -		dp->plat_data->next_bridge =3D devm_drm_panel_bridge_add(dp->dev,
>> -								       dp->plat_data->panel);
>> -		if (IS_ERR(dp->plat_data->next_bridge)) {
>> -			ret =3D PTR_ERR(dp->plat_data->next_bridge);
>> -			goto err_unregister_aux;
>> -		}
>> -	}
>> -
>>   	ret =3D drm_bridge_attach(dp->encoder, bridge, NULL, DRM_BRIDGE_ATTAC=
H_NO_CONNECTOR);
>>   	if (ret) {
>>   		DRM_ERROR("failed to create bridge (%d)\n", ret);
>> @@ -1647,6 +1637,11 @@ struct drm_dp_aux *analogix_dp_get_aux(struct ana=
logix_dp_device *dp)
>>   }
>>   EXPORT_SYMBOL_GPL(analogix_dp_get_aux);
>>
>> +static void analogix_dp_put_bridge(void *data)
>> +{
>> +	drm_bridge_put(data);
>> +}
>> +
>>   static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
>>   {
>>   	struct analogix_dp_device *dp =3D to_dp(aux);
>> @@ -1655,14 +1650,25 @@ static int analogix_dp_aux_done_probing(struct d=
rm_dp_aux *aux)
>>   	int ret;
>>
>>   	/*
>> -	 * If drm_of_find_panel_or_bridge() returns -ENODEV, there may be no v=
alid panel
>> -	 * or bridge nodes. The driver should go on for the driver-free bridge=
 or the DP
>> -	 * mode applications.
>> +	 * If of_drm_get_bridge_by_endpoint() returns -ENODEV, there may be no
>> +	 * valid panel or bridge nodes. The driver should go on for the
>> +	 * driver-free bridge or the DP mode applications.
>>   	 */
>> -	ret =3D drm_of_find_panel_or_bridge(dp->dev->of_node, port, 0,
>> -					  &plat_data->panel, &plat_data->next_bridge);
>> -	if (ret && ret !=3D -ENODEV)
>> -		return ret;
>> +	plat_data->next_bridge =3D of_drm_get_bridge_by_endpoint(dp->dev->of_n=
ode,
>> +							       port, 0);
>> +	if (IS_ERR(plat_data->next_bridge)) {
>> +		if (PTR_ERR(plat_data->next_bridge) =3D=3D -ENODEV)
>> +			plat_data->next_bridge =3D NULL;
>> +		else
>> +			return PTR_ERR(plat_data->next_bridge);
>> +	}
>> +
>> +	if (plat_data->next_bridge) {
>> +		ret =3D devm_add_action_or_reset(dp->dev, analogix_dp_put_bridge,
>> +					       plat_data->next_bridge);
>> +		if (ret)
>> +			return ret;
>> +	}
>>
>>   	return component_add(dp->dev, plat_data->ops);
>>   }
>> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos=
/exynos_dp.c
>> index e1c9e2946b8a..82c238829921 100644
>> --- a/drivers/gpu/drm/exynos/exynos_dp.c
>> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
>> @@ -26,7 +26,6 @@
>>   #include <drm/drm_crtc.h>
>>   #include <drm/drm_encoder.h>
>>   #include <drm/drm_of.h>
>> -#include <drm/drm_panel.h>
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_probe_helper.h>
>>   #include <drm/exynos_drm.h>
>> @@ -147,7 +146,6 @@ static const struct component_ops exynos_dp_ops =3D =
{
>>   static int exynos_dp_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev =3D &pdev->dev;
>> -	struct device_node *np;
>>   	struct exynos_dp_device *dp;
>>
>>   	dp =3D devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
>> @@ -163,18 +161,6 @@ static int exynos_dp_probe(struct platform_device *=
pdev)
>>   	 */
>>   	platform_set_drvdata(pdev, dp);
>>
>> -	/* This is for the backward compatibility. */
>> -	np =3D of_parse_phandle(dev->of_node, "panel", 0);
>> -	if (np) {
>> -		dp->plat_data.panel =3D of_drm_find_panel(np);
>> -
>> -		of_node_put(np);
>> -		if (IS_ERR(dp->plat_data.panel))
>> -			return PTR_ERR(dp->plat_data.panel);
>> -
>> -		goto out;
>> -	}
>> -
>
> TIP: In my WIP v3 patch series, I use of_drm_find_panel() together with
> devm_drm_panel_bridge_add() to maintain this backward compatibility. But
> I also think this old approach should be deprecated now. Shall we add
> some notes in the commit message to mention the deprecation of this metho=
d?

What is the "WIP v3" series exactly? Do you have a link (to v2 in case v3
is not yet public)?

>>   	if (of_get_display_timings(dev->of_node)) {
>>   		dp->plat_data.next_bridge =3D devm_drm_of_display_mode_bridge(dp->de=
v,
>>   									dp->dev->of_node,
>> @@ -189,19 +175,11 @@ static int exynos_dp_probe(struct platform_device =
*pdev)
>>   	dp->plat_data.power_off =3D exynos_dp_poweroff;
>>   	dp->plat_data.ops =3D &exynos_dp_ops;
>>
>> -out:
>>   	dp->adp =3D analogix_dp_probe(dev, &dp->plat_data);
>> -	if (IS_ERR(dp->adp)) {
>> -		/*
>> -		 * The driver core does not invoke remove() for failed probes,
>> -		 * so release the probe-time panel reference here.
>> -		 */
>> -		if (dp->plat_data.panel)
>> -			drm_panel_put(dp->plat_data.panel);
>> +	if (IS_ERR(dp->adp))
>>   		return PTR_ERR(dp->adp);
>> -	}
>>
>> -	if (dp->plat_data.panel || dp->plat_data.next_bridge)
>> +	if (dp->plat_data.next_bridge)
>>   		return component_add(&pdev->dev, &exynos_dp_ops);
>>   	else
>>   		return analogix_dp_finish_probe(dp->adp);
>> @@ -209,16 +187,6 @@ static int exynos_dp_probe(struct platform_device *=
pdev)
>>
>>   static void exynos_dp_remove(struct platform_device *pdev)
>>   {
>> -	struct exynos_dp_device *dp =3D platform_get_drvdata(pdev);
>> -
>> -	/*
>> -	 * Release the probe-time reference from of_drm_find_panel(). If bind
>> -	 * ran, the panel_bridge holds a second reference that devm cleanup
>> -	 * will release when the bridge is destroyed after remove() returns.
>> -	 */
>> -	if (dp->plat_data.panel)
>> -		drm_panel_put(dp->plat_data.panel);
>> -
>>   	component_del(&pdev->dev, &exynos_dp_ops);
>>   }
>>
>> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/g=
pu/drm/rockchip/analogix_dp-rockchip.c
>> index 587e60232ec7..071d31aa5288 100644
>> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> @@ -28,7 +28,6 @@
>>   #include <drm/drm_bridge_connector.h>
>>   #include <drm/bridge/analogix_dp.h>
>>   #include <drm/drm_of.h>
>> -#include <drm/drm_panel.h>
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_probe_helper.h>
>>
>> @@ -488,14 +487,6 @@ static void rockchip_dp_remove(struct platform_devi=
ce *pdev)
>>   {
>>   	struct rockchip_dp_device *dp =3D platform_get_drvdata(pdev);
>>
>> -	/*
>> -	 * Release the probe-time reference from of_drm_find_panel(). If bind
>> -	 * ran, the panel_bridge holds a second reference that devm cleanup
>> -	 * will release when the bridge is destroyed after remove() returns.
>> -	 */
>> -	if (dp->plat_data.panel)
>> -		drm_panel_put(dp->plat_data.panel);
>> -
>>   	component_del(&pdev->dev, &rockchip_dp_component_ops);
>>   }
>>
>> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analo=
gix_dp.h
>> index 0e0b87abee59..6033137b651e 100644
>> --- a/include/drm/bridge/analogix_dp.h
>> +++ b/include/drm/bridge/analogix_dp.h
>> @@ -35,7 +35,6 @@ static inline bool analogix_dp_is_rockchip(enum analog=
ix_dp_devtype type)
>>
>>   struct analogix_dp_plat_data {
>>   	enum analogix_dp_devtype dev_type;
>> -	struct drm_panel *panel;
>>   	struct drm_bridge *next_bridge;
>>   	struct drm_encoder *encoder;
>>   	struct drm_connector *connector;
>>
>
> I apply this patch series with the related one[0], and the eDP work well
> on my RK3576 board.
>
> Tested-by: Damon Ding <damon.ding@rock-chips.com>
>
> In my patch series for Analogix DP HPD support, Heiko also pointed out
> that devm_drm_of_get_bridge()(deprecated now) can be used to get the
> panel bridge directly, and the redundant &analogix_dp_plat_data.panel
> can be removed[1]. Since your patch series already contains these
> optimizations, I will rebase my patch series on top of yours for
> subsequent updates.

Yes, I confirm with this series devm_drm_of_get_bridge() becomes a
complicated equivalent of of_drm_get_bridge_by_endpoint(). So what Heiko
suggested is correct for current upstream code, but this patch goes a step
further, using just the bridge API as the new recommended practice will be
as soon as this series is applied.

FYI this series is now fully acked, so I plan to apply it by the end of
this week or early next week.

> Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
>
> [0]
> https://lore.kernel.org/all/20260915-drm-bridge-drm_panel-cleanup-v4-0-30=
401d9406f3@bootlin.com/
> [1] https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/

Thanks for reviewing and testing!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
