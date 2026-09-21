Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAD9C982EA
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 03:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6E410E067;
	Mon, 21 Sep 2026 03:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="X75U2bih";
	dkim-atps=neutral
Received: from mail-m16023653221.xmail.ntesmail.com
 (mail-m16023653221.xmail.ntesmail.com [160.236.53.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89ABD10E067
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 03:07:45 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4e80fdd69;
 Mon, 21 Sep 2026 11:07:39 +0800 (GMT+08:00)
Message-ID: <975a4d45-9a61-4858-b498-8bc0a1e44746@rock-chips.com>
Date: Mon, 21 Sep 2026 11:07:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] drm/bridge: analogix_dp: don't create a
 panel_bridge
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>,
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa
 <asrivats@redhat.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-19-83afb4f1a707@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-19-83afb4f1a707@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa0c1eefae103a8kunme73f8a94967023
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTR9DVhgfTBpPQkhLT0xDTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=X75U2bih9s1RNl4gfzClJThJySNIjM4kfsKgyjGvKrzGJiFZ2Bwbo3pJPtYca+j/pFYEeq37etQ+OwaS06uBvJwGOmMLXeP6lj8vSUlfLQggrDNilTsa2Uo3+y44fskT/5MTWhtT594XHIv6GphMsqSfSI/V9qtKQ2IakciJ8m0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=HFBDIScTYbc3MGtJrgl0/GYEHYmGNpTutJZEvykLwwM=;
 h=date:mime-version:subject:message-id:from;
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

Hi Luca,

On 9/16/2026 9:45 PM, Luca Ceresoli wrote:
> Now a panel_bridge is automatically created for every drm_panel and the
> panel-bridge API is just a deprecated wrapper to access it.
> 
> Update and simplify the code by just getting a reference to the
> already-existing bridge using of_drm_get_bridge_by_endpoint().
> 
> As of_drm_get_bridge_by_endpoint() returns a refcounted bridge, take care
> of putting the bridge reference. This is not easily done in the remove path
> due to the different probe paths of the user drivers, so add a devm action
> to ensure the reference is put only when it was taken.
> 
> Assisted-by: opencode:deepseek-v4-flash-0731
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   drivers/gpu/drm/bridge/analogix/Kconfig            |  1 -
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 40 +++++++++++++---------
>   drivers/gpu/drm/exynos/exynos_dp.c                 | 36 ++-----------------
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  9 -----
>   include/drm/bridge/analogix_dp.h                   |  1 -
>   5 files changed, 25 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> index da156fd15764..5672d83cb4a1 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -33,7 +33,6 @@ config DRM_ANALOGIX_DP
>   	depends on DRM
>   	depends on OF
>   	select DRM_DISPLAY_DP_AUX_BUS
> -	select DRM_PANEL
>   
>   config DRM_ANALOGIX_ANX7625
>   	tristate "Analogix Anx7625 MIPI to DP interface support"
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 18e76d1e78e1..6df6963740d2 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -29,7 +29,6 @@
>   #include <drm/drm_device.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_of.h>
> -#include <drm/drm_panel.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
>   
> @@ -1567,15 +1566,6 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
>   	if (ret)
>   		goto err_unregister_aux;
>   
> -	if (dp->plat_data->panel) {
> -		dp->plat_data->next_bridge = devm_drm_panel_bridge_add(dp->dev,
> -								       dp->plat_data->panel);
> -		if (IS_ERR(dp->plat_data->next_bridge)) {
> -			ret = PTR_ERR(dp->plat_data->next_bridge);
> -			goto err_unregister_aux;
> -		}
> -	}
> -
>   	ret = drm_bridge_attach(dp->encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>   	if (ret) {
>   		DRM_ERROR("failed to create bridge (%d)\n", ret);
> @@ -1647,6 +1637,11 @@ struct drm_dp_aux *analogix_dp_get_aux(struct analogix_dp_device *dp)
>   }
>   EXPORT_SYMBOL_GPL(analogix_dp_get_aux);
>   
> +static void analogix_dp_put_bridge(void *data)
> +{
> +	drm_bridge_put(data);
> +}
> +
>   static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
>   {
>   	struct analogix_dp_device *dp = to_dp(aux);
> @@ -1655,14 +1650,25 @@ static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
>   	int ret;
>   
>   	/*
> -	 * If drm_of_find_panel_or_bridge() returns -ENODEV, there may be no valid panel
> -	 * or bridge nodes. The driver should go on for the driver-free bridge or the DP
> -	 * mode applications.
> +	 * If of_drm_get_bridge_by_endpoint() returns -ENODEV, there may be no
> +	 * valid panel or bridge nodes. The driver should go on for the
> +	 * driver-free bridge or the DP mode applications.
>   	 */
> -	ret = drm_of_find_panel_or_bridge(dp->dev->of_node, port, 0,
> -					  &plat_data->panel, &plat_data->next_bridge);
> -	if (ret && ret != -ENODEV)
> -		return ret;
> +	plat_data->next_bridge = of_drm_get_bridge_by_endpoint(dp->dev->of_node,
> +							       port, 0);
> +	if (IS_ERR(plat_data->next_bridge)) {
> +		if (PTR_ERR(plat_data->next_bridge) == -ENODEV)
> +			plat_data->next_bridge = NULL;
> +		else
> +			return PTR_ERR(plat_data->next_bridge);
> +	}
> +
> +	if (plat_data->next_bridge) {
> +		ret = devm_add_action_or_reset(dp->dev, analogix_dp_put_bridge,
> +					       plat_data->next_bridge);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return component_add(dp->dev, plat_data->ops);
>   }
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
> index e1c9e2946b8a..82c238829921 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -26,7 +26,6 @@
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_encoder.h>
>   #include <drm/drm_of.h>
> -#include <drm/drm_panel.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
>   #include <drm/exynos_drm.h>
> @@ -147,7 +146,6 @@ static const struct component_ops exynos_dp_ops = {
>   static int exynos_dp_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct device_node *np;
>   	struct exynos_dp_device *dp;
>   
>   	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
> @@ -163,18 +161,6 @@ static int exynos_dp_probe(struct platform_device *pdev)
>   	 */
>   	platform_set_drvdata(pdev, dp);
>   
> -	/* This is for the backward compatibility. */
> -	np = of_parse_phandle(dev->of_node, "panel", 0);
> -	if (np) {
> -		dp->plat_data.panel = of_drm_find_panel(np);
> -
> -		of_node_put(np);
> -		if (IS_ERR(dp->plat_data.panel))
> -			return PTR_ERR(dp->plat_data.panel);
> -
> -		goto out;
> -	}
> -

TIP: In my WIP v3 patch series, I use of_drm_find_panel() together with 
devm_drm_panel_bridge_add() to maintain this backward compatibility. But 
I also think this old approach should be deprecated now. Shall we add 
some notes in the commit message to mention the deprecation of this method?

>   	if (of_get_display_timings(dev->of_node)) {
>   		dp->plat_data.next_bridge = devm_drm_of_display_mode_bridge(dp->dev,
>   									dp->dev->of_node,
> @@ -189,19 +175,11 @@ static int exynos_dp_probe(struct platform_device *pdev)
>   	dp->plat_data.power_off = exynos_dp_poweroff;
>   	dp->plat_data.ops = &exynos_dp_ops;
>   
> -out:
>   	dp->adp = analogix_dp_probe(dev, &dp->plat_data);
> -	if (IS_ERR(dp->adp)) {
> -		/*
> -		 * The driver core does not invoke remove() for failed probes,
> -		 * so release the probe-time panel reference here.
> -		 */
> -		if (dp->plat_data.panel)
> -			drm_panel_put(dp->plat_data.panel);
> +	if (IS_ERR(dp->adp))
>   		return PTR_ERR(dp->adp);
> -	}
>   
> -	if (dp->plat_data.panel || dp->plat_data.next_bridge)
> +	if (dp->plat_data.next_bridge)
>   		return component_add(&pdev->dev, &exynos_dp_ops);
>   	else
>   		return analogix_dp_finish_probe(dp->adp);
> @@ -209,16 +187,6 @@ static int exynos_dp_probe(struct platform_device *pdev)
>   
>   static void exynos_dp_remove(struct platform_device *pdev)
>   {
> -	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> -
> -	/*
> -	 * Release the probe-time reference from of_drm_find_panel(). If bind
> -	 * ran, the panel_bridge holds a second reference that devm cleanup
> -	 * will release when the bridge is destroyed after remove() returns.
> -	 */
> -	if (dp->plat_data.panel)
> -		drm_panel_put(dp->plat_data.panel);
> -
>   	component_del(&pdev->dev, &exynos_dp_ops);
>   }
>   
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 587e60232ec7..071d31aa5288 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -28,7 +28,6 @@
>   #include <drm/drm_bridge_connector.h>
>   #include <drm/bridge/analogix_dp.h>
>   #include <drm/drm_of.h>
> -#include <drm/drm_panel.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
>   
> @@ -488,14 +487,6 @@ static void rockchip_dp_remove(struct platform_device *pdev)
>   {
>   	struct rockchip_dp_device *dp = platform_get_drvdata(pdev);
>   
> -	/*
> -	 * Release the probe-time reference from of_drm_find_panel(). If bind
> -	 * ran, the panel_bridge holds a second reference that devm cleanup
> -	 * will release when the bridge is destroyed after remove() returns.
> -	 */
> -	if (dp->plat_data.panel)
> -		drm_panel_put(dp->plat_data.panel);
> -
>   	component_del(&pdev->dev, &rockchip_dp_component_ops);
>   }
>   
> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
> index 0e0b87abee59..6033137b651e 100644
> --- a/include/drm/bridge/analogix_dp.h
> +++ b/include/drm/bridge/analogix_dp.h
> @@ -35,7 +35,6 @@ static inline bool analogix_dp_is_rockchip(enum analogix_dp_devtype type)
>   
>   struct analogix_dp_plat_data {
>   	enum analogix_dp_devtype dev_type;
> -	struct drm_panel *panel;
>   	struct drm_bridge *next_bridge;
>   	struct drm_encoder *encoder;
>   	struct drm_connector *connector;
> 

I apply this patch series with the related one[0], and the eDP work well 
on my RK3576 board.

Tested-by: Damon Ding <damon.ding@rock-chips.com>

In my patch series for Analogix DP HPD support, Heiko also pointed out 
that devm_drm_of_get_bridge()(deprecated now) can be used to get the 
panel bridge directly, and the redundant &analogix_dp_plat_data.panel 
can be removed[1]. Since your patch series already contains these 
optimizations, I will rebase my patch series on top of yours for 
subsequent updates.

Reviewed-by: Damon Ding <damon.ding@rock-chips.com>

[0] 
https://lore.kernel.org/all/20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com/
[1] https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/

