Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD97F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PwdrEfh0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EC310E216;
	Tue, 24 Nov 2026 09:37:03 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCCD10E216
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:36:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D1944C4CBEA;
 Tue, 24 Nov 2026 09:37:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 54B30601E1;
 Tue, 24 Nov 2026 09:36:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 84AAC11E68893; Tue, 24 Nov 2026 10:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795513014; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mUK8JpDoInG3VuJFjVZB6WRxQ+kbA+qAqeBOuWnngnE=;
 b=PwdrEfh0QbnmVJcCzNbLaRx8V2B2pMDk386ZarL645isDKiuEhDCb9F6q4knLVPMEGGJyf
 xpzfKEiZ5rSl7D7IUW/bZVZKnG2bH7TqaV3+w+khv3sSW32V5CHN4a40IUYrQsAKB5ZL3W
 TgpAQfDFkXlNqnGeFAGkv/UTPS861BnnqpJ0v1E4xzbGsRbaD9I4aALV4JiYIPe0ECPH6F
 jyHJ/KbrGuea0BALDkEJpQtdRddiWgrGcoPyO5mY1T8H+uqFVhW9T41pu0YBD90RHOETSq
 nBf6SK59sTmJZErei7/IEUQBgaoXUMPN9mXlvJfCMqVOqp9d9blY22i41jXQfA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] drm/mxsfb: lcdif: Fix use-after-free on unbind
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: laurentiu.palcu@oss.nxp.com, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, marek.vasut@mailbox.org, mripard@kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261123223357.535424-1-festevam@gmail.com>
References: <20261123223357.535424-1-festevam@gmail.com>
Date: Tue, 24 Nov 2026 10:36:49 +0100
Message-Id: <179551300942.327856.7174455040291936744.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Fabio,

> lcdif allocates its private data, which embeds the CRTC and primary
> plane, and its encoders using devres. These DRM objects are linked into
> the mode_config lists.
>
> Since mode_config cleanup is DRM-managed, it is deferred until the DRM
> device is released. An open DRM file can keep the DRM device alive after
> the platform device has been unbound and devres has freed those objects.
> The later mode_config cleanup then dereferences freed memory.
>
> Allocate the private data with drmm before initializing mode_config so
> that it remains alive until mode_config cleanup has completed. Allocate
> encoders with drmm_plain_encoder_alloc(), which cleans up each encoder
> and removes it from the mode_config list before freeing its memory.
>
> This can be reproduced on i.MX8MP by keeping the DRM card open across an
> LCDIF unbind and closing it afterwards.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c71d925c03a ("drm: lcdif: Switch to drmm_mode_config_init")
> Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

I'm OK with the change (except a small nit, see below), but I have a
general question: is there any valid use case for removing the lcdif, other
than testing?

> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> index b7be7e17d1d0..bc1a9a2fc6bd 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_module.h>
>  #include <drm/drm_of.h>
> @@ -43,10 +44,6 @@ static const struct drm_mode_config_helper_funcs lcdif_mode_config_helpers = {
>  	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>  };
>
> -static const struct drm_encoder_funcs lcdif_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>  static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  {
>  	struct device *dev = lcdif->drm->dev;
> @@ -74,19 +71,16 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  					     "Failed to get bridge for endpoint%u\n",
>  					     of_ep.id);
>
> -		encoder = devm_kzalloc_obj(dev, *encoder);
> -		if (!encoder)
> -			return dev_err_probe(dev, -ENOMEM,
> -					     "Failed to allocate encoder for endpoint%u\n",
> -					     of_ep.id);
> -
> -		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
> -		ret = drm_encoder_init(lcdif->drm, encoder, &lcdif_encoder_funcs,
> -				       DRM_MODE_ENCODER_NONE, NULL);
> -		if (ret)
> +		encoder = drmm_plain_encoder_alloc(lcdif->drm, NULL,
> +						   DRM_MODE_ENCODER_NONE, NULL);
> +		if (IS_ERR(encoder)) {
> +			ret = PTR_ERR(encoder);
>  			return dev_err_probe(dev, ret,
>  					     "Failed to initialize encoder for endpoint%u\n",
>  					     of_ep.id);
> +		}

No need to use the @ret temporary variable, just replace it with:

		if (IS_ERR(encoder))
 			return dev_err_probe(dev, PTR_ERR(encoder),
 					     "Failed to initialize encoder for endpoint%u\n",
 					     of_ep.id);

With that done you can send v3 and add:
+Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
+Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

