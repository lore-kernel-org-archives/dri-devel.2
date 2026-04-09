Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A27E98FDD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4007089711;
	Thu,  9 Apr 2026 09:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VWbdV3u2";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12AB89711
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:56:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id AE3EA1A3242;
 Thu,  9 Apr 2026 09:56:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7A2BF5FDEB;
 Thu,  9 Apr 2026 09:56:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 63136104501F4; 
 Thu,  9 Apr 2026 11:56:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775728565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=v+A3qNJqOEnafW1jXfD7En7I8x7btIPnWkfLN1JElUg=;
 b=VWbdV3u2OC6lWMAhbE6VWZ7TMtaCu3BJ+zYRu1nKNEBHi8PCy8jbSMG9n6Ac3RHD7xDl2i
 UyFRfVAXppmoffCWBhrx7wVC6kMAFSHnxwmMyn1p+QUz96k4bYV5OfL9Ohjj7SuJZXuEmU
 4vEx8LqTEJo2T5IYBSa+TCNkRXQ8/D9rCWHyFphHH6oEVy/2eYh/Y2DroWnPBuaerKEbVj
 fzsHzV9UHGRe6jSQXI9aS+gHXQY8UPLkqJqUnWOxIHGWaDpQtvQAIyBuNGMd+yHka/kY1Y
 vqun6xNQujLLs5SwfHHDhAl/6Q7pi8LKNZjCqnQ2JcsF8uSHOt7w7t549hx4yA==
Message-ID: <c8f081ab-507d-42c1-9d17-1325e4be777b@bootlin.com>
Date: Thu, 9 Apr 2026 11:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] drm/encoder: add mutex to protect the bridge chain
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ian Ray <ian.ray@gehealthcare.com>
References: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-0-8bf786c5c7e6@bootlin.com>
 <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-1-8bf786c5c7e6@bootlin.com>
Content-Language: en-US
From: Louis Chauvet <louis.chauvet@bootlin.com>
In-Reply-To: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-1-8bf786c5c7e6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 3/24/26 9:58 AM, Luca Ceresoli wrote:
> The per-encoder bridge chain is currently assumed to be static once it is
> fully initialized. Work is in progress to add hot-pluggable bridges,
> breaking that assumption.
> 
> With bridge removal, the encoder chain can change without notice, removing
> tail bridges. This can be problematic while iterating over the chain.
> 
> Add a mutex to be taken whenever looping or changing the encoder chain.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> 
> Changes in v3:
> - Removed the drm_encoder_chain_[un]lock() wrappers
> 
> Changes in v2:
> - Added documentation to new APIs
> ---
>   drivers/gpu/drm/drm_encoder.c | 2 ++
>   include/drm/drm_encoder.h     | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
> index 8f2bc6a28482..3261f142baea 100644
> --- a/drivers/gpu/drm/drm_encoder.c
> +++ b/drivers/gpu/drm/drm_encoder.c
> @@ -129,6 +129,7 @@ static int __drm_encoder_init(struct drm_device *dev,
>   	}
>   
>   	INIT_LIST_HEAD(&encoder->bridge_chain);
> +	mutex_init(&encoder->bridge_chain_mutex);
>   	list_add_tail(&encoder->head, &dev->mode_config.encoder_list);
>   	encoder->index = dev->mode_config.num_encoder++;
>   
> @@ -202,6 +203,7 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
>   	kfree(encoder->name);
>   	list_del(&encoder->head);
>   	dev->mode_config.num_encoder--;
> +	mutex_destroy(&encoder->bridge_chain_mutex);
>   
>   	memset(encoder, 0, sizeof(*encoder));
>   }
> diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
> index 977a9381c8ba..eded7c34481a 100644
> --- a/include/drm/drm_encoder.h
> +++ b/include/drm/drm_encoder.h
> @@ -25,6 +25,7 @@
>   
>   #include <linux/list.h>
>   #include <linux/ctype.h>
> +#include <linux/mutex.h>
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_mode.h>
>   #include <drm/drm_mode_object.h>
> @@ -189,6 +190,9 @@ struct drm_encoder {
>   	 */
>   	struct list_head bridge_chain;
>   
> +	/** @bridge_chain_mutex: protect bridge_chain from changes while iterating */
> +	struct mutex bridge_chain_mutex;
> +
>   	const struct drm_encoder_funcs *funcs;
>   	const struct drm_encoder_helper_funcs *helper_private;
>   
> 

