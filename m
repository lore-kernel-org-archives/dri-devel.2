Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061A610F9953
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 15:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C5710E2E7;
	Wed,  8 Apr 2026 15:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="w0D4skP8";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC6EF10E2E7
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 15:26:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 03AD3C5AA98;
 Wed,  8 Apr 2026 15:27:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A1D93603CB;
 Wed,  8 Apr 2026 15:26:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6F5C3104500FE; 
 Wed,  8 Apr 2026 17:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775661987; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=72Qg8MBIKhTgh9OmiZH+JlMoUCsH5TjRk01SfHXWUxI=;
 b=w0D4skP86rtIcvz0e/xGYVNX/Mc4WZr+VcjZoYNNq3MM/sNEg7BqG5riRmhSCcBoFlf0kd
 GbqrrSWSgvHeruEyE+Gkbs4LsD8LDfBG4Pls+oqsw90G/yfTgVNwJx7NBsxe900ZbkAdE4
 cl6qMC+kWVXJjIKR1/YqmQ+dwpYT2fUrJxCvYbhfv6yqKXdnmQ7UmkEko4w4uRYLjjtBNM
 1AIjqgf73qH9qsKCtxWp17UhWiwLluhQMhEf4y4cVXQZn3/RC7dkpyYMJit2YeF9feA54x
 ffc6mK6I/8CULWpFpR7Wq0r+/n7wbWQXq74pelng+L34rxGGytd9qHuxDOU7RA==
Message-ID: <3b55fd8c-f7c7-49ef-bcd5-5603d38950f1@bootlin.com>
Date: Wed, 8 Apr 2026 17:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/bridge: drm_bridge_get/put(): document NULL
 pointer behaviour
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Liu Ying <victor.liu@nxp.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260324-drm-bridge-alloc-getput-document-null-check-v1-1-fb0877c49d7e@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260324-drm-bridge-alloc-getput-document-null-check-v1-1-fb0877c49d7e@bootlin.com>
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



On 3/24/26 10:08, Luca Ceresoli wrote:
> drm_bridge_get and drm_bridge_put() do nothing when they are passed a NULL
> pointer, and they do so since their initial addition in commit 30d1b37d4c02
> ("drm/bridge: add support for refcounting").
> 
> This allows simpler code in various places when using these
> functions. However it's not documented, so it's not clear whether it is
> part of the API "contract" or just a current implementation detail that
> might change in the future.
> 
> There is no visible reason to remove this NULL check, so document it,
> making it part of the contract, letting users count on it.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> Historical note: I thought this was documented from the beginning and
> realized it's not the case when someone proposed adding a 'if (bridge)
> drm_bridge_put(bridge)' to a driver [0]. Let's fix it now.
> 
> [0] https://lore.kernel.org/lkml/DG0CHD0TAH9A.27UW4KKY2O9V7@bootlin.com/
> ---
>   drivers/gpu/drm/drm_bridge.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 3b165a0d1e77..3108249a63cd 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -282,7 +282,7 @@ static void __drm_bridge_free(struct kref *kref)
>   
>   /**
>    * drm_bridge_get - Acquire a bridge reference
> - * @bridge: DRM bridge
> + * @bridge: DRM bridge; if NULL this function does nothing
>    *
>    * This function increments the bridge's refcount.
>    *
> @@ -300,7 +300,7 @@ EXPORT_SYMBOL(drm_bridge_get);
>   
>   /**
>    * drm_bridge_put - Release a bridge reference
> - * @bridge: DRM bridge
> + * @bridge: DRM bridge; if NULL this function does nothing
>    *
>    * This function decrements the bridge's reference count and frees the
>    * object if the reference count drops to zero.
> 
> ---
> base-commit: a50007089e078a1b7a826559a02277b1601ee189
> change-id: 20260129-drm-bridge-alloc-getput-document-null-check-a551e64b8fc1
> 
> Best regards,

