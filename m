Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA74BCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE57610E25E;
	Wed, 30 Sep 2026 10:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="dQDZx7GN";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736C410E25A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=sh5fC0CUc10hXDTzkPBdCZZkzPfnJFt3NuMWURsgHZU=; b=dQDZx7GNYaKjOyAprY0oq3+rhC
 /eRsMVCp7CHstO2amzfLwnWMpuZhOwZLV5zCzcz4BYLIiyI9kZ1yw0r9OgHEv+aIvi44sdtTirKwa
 OQzxVHJQX/qDklqrlWPmwXgnqqXLejnfAonFjc6ADre+i/BSBCvUdjrrSrOrH6Dl1fxjxFXnwhCso
 IPBJy26ZLjCtumpQqqejgo1MnBy4oKjXWyaJFjYC+jjpGjIJA0/q0xkiOVJoP0A2jPCkz/ZCOtkxz
 ncKW0RperYZyh/uHq/5ZVrtrNlVK174R8UiChq058TY1LetGeH75URGVPxm0LcveI87AsX1YnSDo2
 tHqzyTzg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH v5 08/21] drm/bridge: inno-hdmi: Split probe out of bind
Date: Wed, 30 Sep 2026 12:02:56 +0200
Message-ID: <6535891.44csPzL39Z@diego>
In-Reply-To: <20260929-jh7110-clean-send-v5-8-82b4d8e3c6c7@samsung.com>
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103221eucas1p264107850882dde96fcda4772332d4f41@eucas1p2.samsung.com>
 <20260929-jh7110-clean-send-v5-8-82b4d8e3c6c7@samsung.com>
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

Am Dienstag, 29. September 2026, 12:31:05 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Michal Wilczynski:
> inno_hdmi_bind() both sets up the bridge and attaches it to a DRM
> encoder. A platform whose HDMI controller is a child of a larger device
> needs the first half without the second, since it registers as its own
> platform driver and lets the DRM core bind the bridge later.
>=20
> Move the setup into a new exported inno_hdmi_probe(), and reduce
> inno_hdmi_bind() to a wrapper around it.
>=20
> No functional change intended.
>=20
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/bridge/inno-hdmi.c | 49 ++++++++++++++++++++++++++++++++=
+-----
>  include/drm/bridge/inno_hdmi.h     |  4 ++++
>  2 files changed, 47 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index d7c33b92e2ddf4ced84d17304463f44be52270b8..7a9f54dce2647f0320d77629a=
28154eade14385f 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -929,7 +929,14 @@ static irqreturn_t inno_hdmi_irq(int irq, void *dev_=
id)
>  {
>  	struct inno_hdmi *hdmi =3D dev_id;
> =20
> -	drm_helper_hpd_irq_event(hdmi->bridge.dev);
> +	/*
> +	 * The interrupt is requested in probe, but bridge.dev is only set once
> +	 * the DRM master binds and attaches the bridge, which may never happen.
> +	 * Drop hotplug events that arrive before then rather than dereference a
> +	 * NULL drm_device.
> +	 */
> +	if (hdmi->bridge.dev)
> +		drm_helper_hpd_irq_event(hdmi->bridge.dev);

This is not part of the commit description and while true, should likely
be its own patch with its own description.


> =20
>  	return IRQ_HANDLED;
>  }
> @@ -1061,11 +1068,24 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(=
struct inno_hdmi *hdmi)
>  	return adap;
>  }
> =20
> -struct inno_hdmi *inno_hdmi_bind(struct device *dev,
> -				 struct drm_encoder *encoder,
> -				 const struct inno_hdmi_plat_data *plat_data)
> +/**
> + * inno_hdmi_probe - Internal helper to perform common setup
> + * @pdev: platform device
> + * @plat_data: SoC-specific platform data
> + *
> + * This function handles all the common hardware setup: allocating the m=
ain
> + * struct, mapping registers, getting clocks, initializing the hardware,
> + * setting up the IRQ, and initializing the DDC adapter and bridge struc=
t.
> + * It returns a pointer to the inno_hdmi struct on success, or an ERR_PTR
> + * on failure.
> + *
> + * This function is used by modern, decoupled MFD/glue drivers. It regis=
ters
> + * the bridge but does not attach it.
> + */
> +struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
> +				  const struct inno_hdmi_plat_data *plat_data)
>  {
> -	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct device *dev =3D &pdev->dev;
>  	struct inno_hdmi *hdmi;
>  	int irq;
>  	int ret;
> @@ -1128,7 +1148,24 @@ struct inno_hdmi *inno_hdmi_bind(struct device *de=
v,
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
> -	ret =3D drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTA=
CH_NO_CONNECTOR);
> +	return hdmi;
> +}
> +EXPORT_SYMBOL_GPL(inno_hdmi_probe);
> +
> +struct inno_hdmi *inno_hdmi_bind(struct device *dev,
> +				 struct drm_encoder *encoder,
> +				 const struct inno_hdmi_plat_data *plat_data)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct inno_hdmi *hdmi;
> +	int ret;
> +
> +	hdmi =3D inno_hdmi_probe(pdev, plat_data);
> +	if (IS_ERR(hdmi))
> +		return hdmi;
> +
> +	ret =3D drm_bridge_attach(encoder, &hdmi->bridge, NULL,
> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>  	if (ret)
>  		return ERR_PTR(ret);

This clutters up the structure even more than it is right now. From "bind"
back to "probe" and "dev" back to "pdev" and calling a function called
"probe" from the bind callback.

You are right, that all the resource allocation can (and probably should)
live in the drivers probe-path, but then please call that probe function
from the actual probe path.

=46or example you could look at how all the Synopsys bridges do that.


Thanks
Heiko


