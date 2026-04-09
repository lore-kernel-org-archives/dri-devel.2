Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7757FE98FDD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C1110E6F0;
	Thu,  9 Apr 2026 09:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="efS0wf+b";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D383F10E6F0
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:57:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 97A14C5B1A0;
 Thu,  9 Apr 2026 09:57:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EF6E55FDEB;
 Thu,  9 Apr 2026 09:57:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B41F2104500DC; 
 Thu,  9 Apr 2026 11:57:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775728632; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=eEchKB+r7i4/YwY7RKiJKjKP3eW5V6E5trl50E3B2ys=;
 b=efS0wf+b5LyoTXx6AgeQVMuWcNoHXNjqE40jxSkExUYTGCfkzzZFaO1Gx7bxZqUIMsWjl7
 oa1op6wx5+cI881XhwpS4wwWSYamU0GWdstL5ujSrsq25HVcMyMCVMSfhbecfs32vgSGsS
 2ZAqBhfG4qFRGd8CKTSEE9KaUcydWLH2z+Y4k1ePW5V95cOeOIzb+loASLu8BvAG8RYDCe
 ZXOY6HynVnN/yG5Z0vITzrjtK5TlsGB6wPmKrY0Q80S0IyL7qpa5YpVCknj+EdGiEf9Bda
 /RK35elxDWRwCDfZk+UnQiV0EpcJNNlXiQrXJJVkHpRFULN8rI2cbaM9jpgnmw==
Message-ID: <9e517e8d-f944-4934-9f97-07101ec98711@bootlin.com>
Date: Thu, 9 Apr 2026 11:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_reverse()
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
 <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-6-8bf786c5c7e6@bootlin.com>
Content-Language: en-US
From: Louis Chauvet <louis.chauvet@bootlin.com>
In-Reply-To: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-6-8bf786c5c7e6@bootlin.com>
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
> list_for_each_entry_reverse(), which does not prevent changes to the bridge
> chain while iterating over it.
> 
> Take the encoder chain mutex while iterating to avoid chain changes while
> iterating.
> 
> All the "simple" loops are converted. drm_atomic_bridge_chain_pre_enable()
> and drm_atomic_bridge_chain_post_disable() are handled by a separate
> commit.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> 
> Changes in v3:
> - Lock encoder->bridge_chain_mutex directly, no wrappers
> 
> Changes in v2: none
> ---
>   drivers/gpu/drm/drm_bridge.c | 40 ++++++++++++++++++++++------------------
>   1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 37feb8143de4..c76f3451af39 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -808,6 +808,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
>   		return;
>   
>   	encoder = bridge->encoder;
> +	mutex_lock(&encoder->bridge_chain_mutex);
>   	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
>   		if (iter->funcs->atomic_disable) {
>   			iter->funcs->atomic_disable(iter, state);
> @@ -818,6 +819,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
>   		if (iter == bridge)
>   			break;
>   	}
> +	mutex_unlock(&encoder->bridge_chain_mutex);
>   }
>   EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
>   
> @@ -1322,25 +1324,27 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
>   		return ret;
>   
>   	encoder = bridge->encoder;
> -	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
> -		int ret;
> -
> -		/*
> -		 * Bus flags are propagated by default. If a bridge needs to
> -		 * tweak the input bus flags for any reason, it should happen
> -		 * in its &drm_bridge_funcs.atomic_check() implementation such
> -		 * that preceding bridges in the chain can propagate the new
> -		 * bus flags.
> -		 */
> -		drm_atomic_bridge_propagate_bus_flags(iter, conn,
> -						      crtc_state->state);
> -
> -		ret = drm_atomic_bridge_check(iter, crtc_state, conn_state);
> -		if (ret)
> -			return ret;
> +	scoped_guard(mutex, &encoder->bridge_chain_mutex) {
> +		list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
> +			int ret;
> +
> +			/*
> +			 * Bus flags are propagated by default. If a bridge needs to
> +			 * tweak the input bus flags for any reason, it should happen
> +			 * in its &drm_bridge_funcs.atomic_check() implementation such
> +			 * that preceding bridges in the chain can propagate the new
> +			 * bus flags.
> +			 */
> +			drm_atomic_bridge_propagate_bus_flags(iter, conn,
> +							      crtc_state->state);
> +
> +			ret = drm_atomic_bridge_check(iter, crtc_state, conn_state);
> +			if (ret)
> +				return ret;
>   
> -		if (iter == bridge)
> -			break;
> +			if (iter == bridge)
> +				break;
> +		}
>   	}
>   
>   	return 0;
> 

