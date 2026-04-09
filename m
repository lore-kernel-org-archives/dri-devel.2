Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A016AE98FDD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F24710E6E8;
	Thu,  9 Apr 2026 09:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UMAlW2Y6";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E4710E6E8
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:56:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id CD7101A3236;
 Thu,  9 Apr 2026 09:56:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9AA885FDEB;
 Thu,  9 Apr 2026 09:56:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 26C1E104500DC; 
 Thu,  9 Apr 2026 11:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775728602; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=og7A9CWzp20T8+kYE/xTpokPQuPu0SDZDu89tndMdLA=;
 b=UMAlW2Y62sGPi/u4DoDpeipzrWHCGCC11F2qNPZiamRZTrfBYs0F3Pa1rNwoQKuo2sreZ6
 2DiSzF/Sm2x6wd5J3b0Z1p8rbHXvj03goSL0D5rdA1VPJMzOH6Y79bVgV/w58GY3WXHAgy
 BmFBgA0ILX+9zrdatetxWuzP5HJOdrS5/EVHYaeLzjNkF14BQSRzNok0yEkfVxnU/Mn/28
 Xh5fW5NycNyl62Ud3M9agLAbQmgxyNdhJLKPvN2LzUTiJq3uCq5unyq5V31di39uTkQP9V
 INKptbEoJ8rzoQYTE4iPxEhD8qcWsktqd4f+yXJ7RdAkG0pyZB+nrMi2QzPObw==
Message-ID: <c5531b0f-271c-4e12-b77c-f8943cae8bcc@bootlin.com>
Date: Thu, 9 Apr 2026 11:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] drm/bridge: drm_bridge_attach: lock the encoder
 chain mutex during insertion
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
 <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-3-8bf786c5c7e6@bootlin.com>
Content-Language: en-US
From: Louis Chauvet <louis.chauvet@bootlin.com>
In-Reply-To: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-3-8bf786c5c7e6@bootlin.com>
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
> drm_bridge_attach() modifies the encoder bridge chain, so take a mutex
> around such operations to allow users of the chain to protect themselves
> from chain modifications while iterating.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> 
> Changes in v3:
> - Lock encoder->bridge_chain_mutex directly, no wrappers
> 
> Changes in v2:
> - Removed comment before on drm_bridge_detach()
> ---
>   drivers/gpu/drm/drm_bridge.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 30d957675d87..42ca4b243579 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -574,10 +574,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>   	bridge->dev = encoder->dev;
>   	bridge->encoder = encoder;
>   
> +	mutex_lock(&encoder->bridge_chain_mutex);
>   	if (previous)
>   		list_add(&bridge->chain_node, &previous->chain_node);
>   	else
>   		list_add(&bridge->chain_node, &encoder->bridge_chain);
> +	mutex_unlock(&encoder->bridge_chain_mutex);
>   
>   	if (bridge->funcs->attach) {
>   		ret = bridge->funcs->attach(bridge, encoder, flags);
> @@ -594,7 +596,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>   err_reset_bridge:
>   	bridge->dev = NULL;
>   	bridge->encoder = NULL;
> +	mutex_lock(&encoder->bridge_chain_mutex);
>   	list_del(&bridge->chain_node);
> +	mutex_unlock(&encoder->bridge_chain_mutex);
>   
>   	if (ret != -EPROBE_DEFER)
>   		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> 

