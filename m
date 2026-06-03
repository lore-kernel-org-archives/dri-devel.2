Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFF9CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D82610FC8A;
	Wed,  3 Jun 2026 11:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fYsSWngr";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565C010FC8A
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=A4X8MBnOB9XqGLdrJtCrNxp/P4ojLEjfbd4+H248P90=; b=fYsSWngrycTg+0gAaRKgZrznnb
 17IHfRN2Dh0VRLlhhBpBIeoQ6+OHR8pipu3l6ZpIlmmfg3iJDk5lkCQEoU4gwh0xof7KMBNcFUxas
 slblxFDFBCo0Min/BgRqYaQePg/Jw/oD0/1A4cglpo5HbVcZNMGFRQ01MeEDNw0atJQYb/ayRqZsD
 Mv3Lt09MrneP+Dwt/zmdXSqeIGwknazLckPUHpRezrGOPcsSG0O1xRhAZQm+zchryKxCGV0mUFcHX
 2SkGX+DlWPWQnonyig52S1irLbtK9hUDOZKHlUIDGjOl5GDWzMvkwKtpdGM/XsqIT92YYMODK8rYk
 86hTNiXQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wUk3D-000NZL-2j; Wed, 03 Jun 2026 13:46:23 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wUk3C-0008pt-1u; Wed, 03 Jun 2026 13:46:23 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/bridge: nwl-dsi: Use dev_err_probe
Date: Wed, 03 Jun 2026 13:46:22 +0200
Message-ID: <4511408.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260313113259.1721914-1-alexander.stein@ew.tq-group.com>
References: <20260313113259.1721914-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28019/Tue Jun  2 08:33:27 2026)
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

Hi,

Am Freitag, 13. M=E4rz 2026, 12:32:58 CEST schrieb Alexander Stein:
> This simplifies the code as well as adding a probe deferral message.

Any feedback on this patch?

Thanks and best regards
Alexander

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 114 +++++++++++--------------------
>  1 file changed, 40 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index 2f7429b24fc20..0a39643b128ba 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -9,6 +9,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/clk.h>
> +#include <linux/dev_printk.h>
>  #include <linux/irq.h>
>  #include <linux/math64.h>
>  #include <linux/mfd/syscon.h>
> @@ -975,68 +976,46 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
>  	struct platform_device *pdev =3D to_platform_device(dsi->dev);
>  	struct clk *clk;
>  	void __iomem *base;
> -	int ret;
> =20
>  	dsi->phy =3D devm_phy_get(dsi->dev, "dphy");
> -	if (IS_ERR(dsi->phy)) {
> -		ret =3D PTR_ERR(dsi->phy);
> -		if (ret !=3D -EPROBE_DEFER)
> -			DRM_DEV_ERROR(dsi->dev, "Could not get PHY: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(dsi->phy))
> +		return dev_err_probe(dsi->dev, PTR_ERR(dsi->phy),
> +				     "Could not get PHY\n");
> =20
>  	clk =3D devm_clk_get(dsi->dev, "lcdif");
> -	if (IS_ERR(clk)) {
> -		ret =3D PTR_ERR(clk);
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get lcdif clock: %d\n",
> -			      ret);
> -		return ret;
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dsi->dev, PTR_ERR(clk),
> +				     "Failed to get lcdif clock\n");
>  	dsi->lcdif_clk =3D clk;
> =20
>  	clk =3D devm_clk_get(dsi->dev, "core");
> -	if (IS_ERR(clk)) {
> -		ret =3D PTR_ERR(clk);
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get core clock: %d\n",
> -			      ret);
> -		return ret;
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dsi->dev, PTR_ERR(clk),
> +				     "Failed to get core clock\n");
>  	dsi->core_clk =3D clk;
> =20
>  	clk =3D devm_clk_get(dsi->dev, "phy_ref");
> -	if (IS_ERR(clk)) {
> -		ret =3D PTR_ERR(clk);
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get phy_ref clock: %d\n",
> -			      ret);
> -		return ret;
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dsi->dev, PTR_ERR(clk),
> +				     "Failed to get phy_ref clock\n");
>  	dsi->phy_ref_clk =3D clk;
> =20
>  	clk =3D devm_clk_get(dsi->dev, "rx_esc");
> -	if (IS_ERR(clk)) {
> -		ret =3D PTR_ERR(clk);
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get rx_esc clock: %d\n",
> -			      ret);
> -		return ret;
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dsi->dev, PTR_ERR(clk),
> +				     "Failed to get rx_esc clock\n");
>  	dsi->rx_esc_clk =3D clk;
> =20
>  	clk =3D devm_clk_get(dsi->dev, "tx_esc");
> -	if (IS_ERR(clk)) {
> -		ret =3D PTR_ERR(clk);
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get tx_esc clock: %d\n",
> -			      ret);
> -		return ret;
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dsi->dev, PTR_ERR(clk),
> +				     "Failed to get tx_esc clock\n");
>  	dsi->tx_esc_clk =3D clk;
> =20
>  	dsi->mux =3D devm_mux_control_get(dsi->dev, NULL);
> -	if (IS_ERR(dsi->mux)) {
> -		ret =3D PTR_ERR(dsi->mux);
> -		if (ret !=3D -EPROBE_DEFER)
> -			DRM_DEV_ERROR(dsi->dev, "Failed to get mux: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(dsi->mux))
> +		return dev_err_probe(dsi->dev, PTR_ERR(dsi->mux),
> +				     "Failed to get mux\n");
> =20
>  	base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
> @@ -1044,44 +1023,31 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
> =20
>  	dsi->regmap =3D
>  		devm_regmap_init_mmio(dsi->dev, base, &nwl_dsi_regmap_config);
> -	if (IS_ERR(dsi->regmap)) {
> -		ret =3D PTR_ERR(dsi->regmap);
> -		DRM_DEV_ERROR(dsi->dev, "Failed to create NWL DSI regmap: %d\n",
> -			      ret);
> -		return ret;
> -	}
> +	if (IS_ERR(dsi->regmap))
> +		return dev_err_probe(dsi->dev, PTR_ERR(dsi->regmap),
> +				     "Failed to create NWL DSI regmap\n");
> =20
>  	dsi->irq =3D platform_get_irq(pdev, 0);
> -	if (dsi->irq < 0) {
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get device IRQ: %d\n",
> -			      dsi->irq);
> -		return dsi->irq;
> -	}
> +	if (dsi->irq < 0)
> +		return dev_err_probe(dsi->dev, dsi->irq,
> +				     "Failed to get device IRQ\n");
> =20
>  	dsi->rst_pclk =3D devm_reset_control_get_exclusive(dsi->dev, "pclk");
> -	if (IS_ERR(dsi->rst_pclk)) {
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get pclk reset: %ld\n",
> -			      PTR_ERR(dsi->rst_pclk));
> -		return PTR_ERR(dsi->rst_pclk);
> -	}
> +	if (IS_ERR(dsi->rst_pclk))
> +		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rst_pclk),
> +				     "Failed to get pclk reset\n");
>  	dsi->rst_byte =3D devm_reset_control_get_exclusive(dsi->dev, "byte");
> -	if (IS_ERR(dsi->rst_byte)) {
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get byte reset: %ld\n",
> -			      PTR_ERR(dsi->rst_byte));
> -		return PTR_ERR(dsi->rst_byte);
> -	}
> +	if (IS_ERR(dsi->rst_byte))
> +		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rst_byte),
> +				     "Failed to get byte reset\n");
>  	dsi->rst_esc =3D devm_reset_control_get_exclusive(dsi->dev, "esc");
> -	if (IS_ERR(dsi->rst_esc)) {
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get esc reset: %ld\n",
> -			      PTR_ERR(dsi->rst_esc));
> -		return PTR_ERR(dsi->rst_esc);
> -	}
> +	if (IS_ERR(dsi->rst_esc))
> +		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rst_esc),
> +				     "Failed to get esc reset\n");
>  	dsi->rst_dpi =3D devm_reset_control_get_exclusive(dsi->dev, "dpi");
> -	if (IS_ERR(dsi->rst_dpi)) {
> -		DRM_DEV_ERROR(dsi->dev, "Failed to get dpi reset: %ld\n",
> -			      PTR_ERR(dsi->rst_dpi));
> -		return PTR_ERR(dsi->rst_dpi);
> -	}
> +	if (IS_ERR(dsi->rst_dpi))
> +		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rst_dpi),
> +				     "Failed to get dpi reset\n");
>  	return 0;
>  }
> =20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


