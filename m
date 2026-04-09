Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFECEE98FD2
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300FF10E6EB;
	Thu,  9 Apr 2026 09:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CDW/dyvx";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6F210E6EB
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:57:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C1FA74E4294C;
 Thu,  9 Apr 2026 09:57:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8FF975FDEB;
 Thu,  9 Apr 2026 09:57:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F78D104507FB; 
 Thu,  9 Apr 2026 11:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775728619; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=4o06unlAgoP4zflxzOcT43io3OuS1mtGSGTK8lxH0+4=;
 b=CDW/dyvxMUfjJqgJTtybW8XJRxoM6HQz9TIagxo5J9J9pek1NEweTlw5pfbxyXP8nRwq5l
 1ZJfc365mXmOAXyix3W0A8httrOn8YKS+0MA9DiHwGfzuz0CvKhXJPIc7+GOcYSf/ez6St
 0x+KpVNLcRDS08BXLgfIoFJCyfNtSxfxN8Gfw/TSIcb7hWRW19oDwbud6iIfzgWk2SJCMw
 fENydSCIR2vN7nUDqH7xJRr3G7vvwO1RVNh6tpzYtgT71bFd62jF3DHkMmcMOnA1ypCjCC
 bhwJNtQm+v6ieinI9kH/HtkvYYVohmQ/1knunv1In1Dkw8Gb1rzhAhm+SkAEPg==
Message-ID: <3ea41a49-5ec1-42f2-859d-0293c4b444aa@bootlin.com>
Date: Thu, 9 Apr 2026 11:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_from()
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
 <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-5-8bf786c5c7e6@bootlin.com>
Content-Language: en-US
From: Louis Chauvet <louis.chauvet@bootlin.com>
In-Reply-To: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-5-8bf786c5c7e6@bootlin.com>
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
> These loops in drm_bridge.c iterate over the encoder chain using
> list_for_each_entry_from(), which does not prevent changes to the bridge
> chain while iterating over it.
> 
> Convert most of those loops to instead use
> drm_for_each_bridge_in_chain_from(), which locks the chain.
> 
> This also simplifies code.
> 
> All the "simple" loops are converted here. The only ones not touched are
> those in drm_atomic_bridge_chain_pre_enable() and
> drm_atomic_bridge_chain_post_disable(), because they have nested loops
> which are not well handled by drm_for_each_bridge_in_chain_from(). Those
> two functions are handled by a separate commit.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/drm_bridge.c | 35 ++++++++++++-----------------------
>   1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 42ca4b243579..37feb8143de4 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -725,7 +725,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>   /**
>    * drm_bridge_chain_mode_valid - validate the mode against all bridges in the
>    *				 encoder chain.
> - * @bridge: bridge control structure
> + * @first_bridge: bridge control structure
>    * @info: display info against which the mode shall be validated
>    * @mode: desired mode to be validated
>    *
> @@ -739,17 +739,14 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>    * MODE_OK on success, drm_mode_status Enum error code on failure
>    */
>   enum drm_mode_status
> -drm_bridge_chain_mode_valid(struct drm_bridge *bridge,
> +drm_bridge_chain_mode_valid(struct drm_bridge *first_bridge,
>   			    const struct drm_display_info *info,
>   			    const struct drm_display_mode *mode)
>   {
> -	struct drm_encoder *encoder;
> -
> -	if (!bridge)
> +	if (!first_bridge)
>   		return MODE_OK;
>   
> -	encoder = bridge->encoder;
> -	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
> +	drm_for_each_bridge_in_chain_from(first_bridge, bridge) {
>   		enum drm_mode_status ret;
>   
>   		if (!bridge->funcs->mode_valid)
> @@ -767,7 +764,7 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_valid);
>   /**
>    * drm_bridge_chain_mode_set - set proposed mode for all bridges in the
>    *			       encoder chain
> - * @bridge: bridge control structure
> + * @first_bridge: bridge control structure
>    * @mode: desired mode to be set for the encoder chain
>    * @adjusted_mode: updated mode that works for this encoder chain
>    *
> @@ -776,20 +773,16 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_valid);
>    *
>    * Note: the bridge passed should be the one closest to the encoder
>    */
> -void drm_bridge_chain_mode_set(struct drm_bridge *bridge,
> +void drm_bridge_chain_mode_set(struct drm_bridge *first_bridge,
>   			       const struct drm_display_mode *mode,
>   			       const struct drm_display_mode *adjusted_mode)
>   {
> -	struct drm_encoder *encoder;
> -
> -	if (!bridge)
> +	if (!first_bridge)
>   		return;
>   
> -	encoder = bridge->encoder;
> -	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
> +	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
>   		if (bridge->funcs->mode_set)
>   			bridge->funcs->mode_set(bridge, mode, adjusted_mode);
> -	}
>   }
>   EXPORT_SYMBOL(drm_bridge_chain_mode_set);
>   
> @@ -1013,7 +1006,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
>   
>   /**
>    * drm_atomic_bridge_chain_enable - enables all bridges in the encoder chain
> - * @bridge: bridge control structure
> + * @first_bridge: bridge control structure
>    * @state: atomic state being committed
>    *
>    * Calls &drm_bridge_funcs.atomic_enable (falls back on
> @@ -1023,22 +1016,18 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
>    *
>    * Note: the bridge passed should be the one closest to the encoder
>    */
> -void drm_atomic_bridge_chain_enable(struct drm_bridge *bridge,
> +void drm_atomic_bridge_chain_enable(struct drm_bridge *first_bridge,
>   				    struct drm_atomic_state *state)
>   {
> -	struct drm_encoder *encoder;
> -
> -	if (!bridge)
> +	if (!first_bridge)
>   		return;
>   
> -	encoder = bridge->encoder;
> -	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
> +	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
>   		if (bridge->funcs->atomic_enable) {
>   			bridge->funcs->atomic_enable(bridge, state);
>   		} else if (bridge->funcs->enable) {
>   			bridge->funcs->enable(bridge);
>   		}
> -	}
>   }
>   EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
>   
> 

