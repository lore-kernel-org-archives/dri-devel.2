Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA83BCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 09:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCA410ED6C;
	Thu, 18 Jun 2026 09:48:48 +0000 (UTC)
X-Greylist: delayed 539 seconds by postgrey-1.36 at gabe;
 Thu, 18 Jun 2026 09:48:48 UTC
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C11710ED6C
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 09:48:48 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5DFB1200F09;
 Thu, 18 Jun 2026 11:39:46 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e]
 helo=lupine)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1wa9Du-003Prb-0w;
 Thu, 18 Jun 2026 11:39:46 +0200
Received: from pza by lupine with local (Exim 4.98.2)
 (envelope-from <p.zabel@pengutronix.de>) id 1wa9Du-00000000532-0eH7;
 Thu, 18 Jun 2026 11:39:46 +0200
Message-ID: <7c79f233c863654b0266de4b5ec5a8c72bb17715.camel@pengutronix.de>
Subject: Re: [PATCH 2/9] drm/rockchip: vop2: Reset AXI and DCLK to improve
 robustness
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Sandy Huang	
 <hjc@rock-chips.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda	 <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>,  Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman	
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2026 11:39:45 +0200
In-Reply-To: <20260617-dw-hdmi-qp-yuv-v1-2-a665cfd06d7d@collabora.com>
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <20260617-dw-hdmi-qp-yuv-v1-2-a665cfd06d7d@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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

On Mi, 2026-06-17 at 21:51 +0300, Cristian Ciocaltea wrote:
> Assert the AXI reset in the CRTC disable path, and the VP DCLK reset in
> the enable path.
>=20
> These resets are intended to leave the hardware in a clean state for the
> next use, helping recover from exceptions such as IOMMU page faults, as
> well as to prevent random display output glitches, such as a blank
> image, observed when switching modes that also change the color format,
> e.g. from RGB to YUV420 and vice versa.
>=20
> For now this seems to affect only the RK3588, hence the resets are
> optional and will be provided in the device tree for this SoC only.
>=20
> Co-developed-by: Andy Yan <andy.yan@rock-chips.com>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 35 ++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  4 ++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 4cce3e336f5b..2833fb49ad81 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/swab.h>
> =20
>  #include <drm/drm.h>
> @@ -860,6 +861,26 @@ static int vop2_core_clks_prepare_enable(struct vop2=
 *vop2)
>  	return ret;
>  }
> =20
> +static void vop2_clk_reset(struct vop2 *vop2, struct reset_control *rstc=
)

The _clk part of the function name is misleading ...

[...]
> @@ -938,6 +959,8 @@ static void vop2_disable(struct vop2 *vop2)
>  {
>  	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);
> =20
> +	vop2_clk_reset(vop2, vop2->axi_rst);

... because this function is also called with the AXI reset control.

> +
>  	pm_runtime_put_sync(vop2->dev);
> =20
>  	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
> @@ -1948,6 +1971,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc=
 *crtc,
> =20
>  	vop2_crtc_atomic_try_set_gamma(vop2, vp, crtc, crtc_state);
> =20
> +	vop2_clk_reset(vop2, vp->dclk_rst);
> +
>  	drm_crtc_vblank_on(crtc);
> =20
>  	vop2_unlock(vop2);
> @@ -2531,6 +2556,11 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk),
>  					     "failed to get %s\n", dclk_name);
> =20
> +		vp->dclk_rst =3D devm_reset_control_get_optional(vop2->dev, dclk_name)=
;

Please use devm_reset_control_get_optional_exclusive() directly.

> +		if (IS_ERR(vp->dclk_rst))
> +			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk_rst),
> +					     "failed to get %s reset\n", dclk_name);
> +
>  		np =3D of_graph_get_remote_node(dev->of_node, i, -1);
>  		if (!np) {
>  			drm_dbg(vop2->drm, "%s: No remote for vp%d\n", __func__, i);
> @@ -2890,6 +2920,11 @@ static int vop2_bind(struct device *dev, struct de=
vice *master, void *data)
>  		return dev_err_probe(drm->dev, PTR_ERR(vop2->pll_hdmiphy1),
>  				     "failed to get pll_hdmiphy1\n");
> =20
> +	vop2->axi_rst =3D devm_reset_control_get_optional(vop2->dev, "axi");

Same as above, devm_reset_control_get_optional_exclusive().

regards
Philipp
