Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F759C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827AE10E6C4;
	Tue, 14 Jul 2026 16:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0f4AODlr";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BD510E089
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:34:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 29BED4E40DB1;
 Tue, 14 Jul 2026 16:34:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F18DE60346;
 Tue, 14 Jul 2026 16:34:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 593A011BD2234; 
 Tue, 14 Jul 2026 18:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784046880; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=E0IcMTMGfz1S5Qk5HK6Iiap0iTukd7f1HD82LoIsjI8=;
 b=0f4AODlrXznX/HInV9ya6JDxQeEi9VHpmLxWY7s0BJzlLFxReZMj0lsVT9AV7Kg2+1V+kW
 BqG0NU1SwlwCBMy9s8ie6kpFuCyS43PaJk+rhGA7aCtzj4ZCzpVGAgytBs0UQh/Rqm1YgI
 aMSSN7/hNAMvZzG4xf8vmdAczB7UxauX3pNph2Ij3xPHikrvY80ggDs4c4eM7ypqojeHDR
 NnpZIotWj0o88DIRVuiiA1yUG2FcId4ZYSw84gik9U7MSbgm5VFPP5wuOjET5HyOLsk5/B
 OTZoKIH8Cts2D9X8UHw8HtUlvAeUmZNRTjY2D+vg0isujKUB3MqyzvSVg6MBYw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RESEND v4 3/3] drm/bridge: sii9234: use extcon cable
 detection logic to detect MHL
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Henrik Grimler <henrik@grimler.se>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260602-exynos4-sii9234-driver-v4-3-9b2fc38e104a@grimler.se>
References: <20260602-exynos4-sii9234-driver-v4-0-9b2fc38e104a@grimler.se>
 <20260602-exynos4-sii9234-driver-v4-3-9b2fc38e104a@grimler.se>
Date: Tue, 14 Jul 2026 18:34:20 +0200
Message-Id: <178404686056.173179.5143201359152396886.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Tue, 02 Jun 2026 20:36:50 +0200, Henrik Grimler <henrik@grimler.se> wrote:

Hello Henrik,

> To use MHL we currently need the MHL chip to be permanently on, which
> consumes unnecessary power. Let's use extcon attached to MUIC to enable
> the MHL chip only if it detects an MHL cable.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>

I have several minor comments, but overall looks OK to me.

>
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 4a57d49b4c6d..11171b4054b5 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -333,6 +333,7 @@ config DRM_SII902X
>  config DRM_SII9234
>  	tristate "Silicon Image SII9234 HDMI/MHL bridge"
>  	depends on OF
> +	depends on EXTCON || !EXTCON

IMO the other syntax is more readable:

          depends on EXTCON if EXTCON

See https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html

>
> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
> index e43248e515b3..72c6aeed6e12 100644
> --- a/drivers/gpu/drm/bridge/sii9234.c
> +++ b/drivers/gpu/drm/bridge/sii9234.c
> @@ -170,8 +172,12 @@ struct sii9234 {
>  	struct drm_bridge bridge;
>  	struct device *dev;
>  	struct gpio_desc *gpio_reset;
> -	int i2c_error;
>  	struct regulator_bulk_data supplies[4];
> +	struct extcon_dev *extcon;
> +	struct notifier_block extcon_nb;
> +	struct work_struct extcon_wq;
> +	int cable_state;
> +	int i2c_error;

Moving i2c_error is unrelated, and apparently unneeded unless I'm missing
something.

> @@ -863,6 +869,70 @@ static int sii9234_init_resources(struct sii9234 *ctx,
>  	return 0;
>  }
>  
> +static void sii9234_extcon_work(struct work_struct *work)
> +{
> +	struct sii9234 *ctx =
> +		container_of(work, struct sii9234, extcon_wq);

Can fit on a single line.

> +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
> +
> +	if (state == ctx->cable_state)
> +		return;
> +
> +	ctx->cable_state = state;
> +
> +	if (state > 0)
> +		sii9234_cable_in(ctx);
> +	else
> +		sii9234_cable_out(ctx);
> +}
> +
> +static int sii9234_extcon_notifier(struct notifier_block *self,

"self" is not a very descriptive name. What about "nb", being a notifier
block?

> +			unsigned long event, void *ptr)
> +{
> +	struct sii9234 *ctx =
> +		container_of(self, struct sii9234, extcon_nb);

Single line here too.

> [ ... skip 14 lines ... ]
> +	/* Then get micro-USB Interface Controller node */
> +	muic = of_get_next_parent(musb);
> +
> +	if (!muic) {
> +		dev_info(ctx->dev,
> +			 "no extcon found, switching to 'always on' mode\n");

Can fit in a line.

> +		return 0;
> +	}
> +
> +	edev = extcon_find_edev_by_node(muic);
> +	of_node_put(muic);
> +	if (IS_ERR(edev)) {
> +		return dev_err_probe(ctx->dev, PTR_ERR(edev),
> +			      "invalid or missing extcon\n");
> +	}

You can drop the curly braces, and perhaps the dev_err_probe() can fit in a
100-chars line.

> +
> +	ctx->extcon = edev;
> +	ctx->extcon_nb.notifier_call = sii9234_extcon_notifier;
> +	INIT_WORK(&ctx->extcon_wq, sii9234_extcon_work);
> +	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
> +	if (ret) {
> +		dev_err(ctx->dev, "failed to register notifier for MHL\n");
> +		return ret;
> +	}

Use dev_err_probe(), and so remove the {}.

> @@ -929,7 +1004,15 @@ static void sii9234_remove(struct i2c_client *client)
>  {
>  	struct sii9234 *ctx = i2c_get_clientdata(client);
>  
> -	sii9234_cable_out(ctx);
> +	if (ctx->extcon) {
> +		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
> +					   &ctx->extcon_nb);

I guess you can use devm_extcon_register_notifier() to simplify a bit the
code.

> +		flush_work(&ctx->extcon_wq);
> +		if (ctx->cable_state > 0)
> +			sii9234_cable_out(ctx);
> +	} else {
> +		sii9234_cable_out(ctx);
> +	}
>  	drm_bridge_remove(&ctx->bridge);
>  }
>  

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

