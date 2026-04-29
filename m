Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6CFCD1297
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F3610F012;
	Wed, 29 Apr 2026 13:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RZZ+cyIc";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6824710F01E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:40:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 85488C5EF2A;
 Wed, 29 Apr 2026 13:41:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 66378601DF;
 Wed, 29 Apr 2026 13:40:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB82E10729DF7; 
 Wed, 29 Apr 2026 15:40:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777470015; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=PT9GRRbeJ/cph6+zH69L1Yz0rfwQkgNxdEF+Q//Gyeg=;
 b=RZZ+cyIc2VvXLM6buu74ESrr0/OnXsrkuOqg9n3ht9wjJqfmHQnQLzwa0ZsgLIU0JNsw6C
 XTFDLzQJqychAvQRNcmq1htXkf9GlEZ6PCdQVYd+DiB+ard/8gN6U44Acg/zHWN7PWVbAA
 6CblIB2JRg/aGyfFXwwcwY3/OhBqp+sBNkjRs1ghV0DSlrBDIDVJaLQGwJGTFQiE93hIuM
 GcBXFQ5fp3N+TKUj8j/qGzysN622iCqcciP/Eowd92DFVTmfM6vzt7uEipHAkSl95GwPjb
 LcTzPSc2NbZcCMgqDpys8+Nt9wZgWUDrRhpctIDV+2GBjR4/VIO12JACg0uR8A==
Message-ID: <a30256a6-e451-4258-89e8-c92a83db6162@bootlin.com>
Date: Wed, 29 Apr 2026 15:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Fix DYNAMIC_DEBUG_MODULE propagation to
 subdirectories
To: Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Cc: Sean Paul <seanpaul@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jim Cromie <jim.cromie@gmail.com>
References: <20260420160425.3919114-1-sean@poorly.run>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260420160425.3919114-1-sean@poorly.run>
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



On 4/20/26 18:04, Sean Paul wrote:
> From: Sean Paul <seanpaul@google.com>
> 
> Switch incompatible CFLAGS-y to ccflags-* and propagate the flag
> to subdirectories to avoid implicit declaration errors for
> _dynamic_func_call_cls when DRM_USE_DYNAMIC_DEBUG is enabled.
> 
> Note that this flag is still disabled due to depends on BROKEN.
> 
> Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
> Signed-off-by: Sean Paul <seanpaul@google.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> 
> a wild seanpaul appears...
> 
>   drivers/gpu/drm/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd783..7082ff6449fb 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -3,7 +3,8 @@
>   # Makefile for the drm device driver.  This driver provides support for the
>   # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>   
> -CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
> +ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
> +subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
>   
>   # Unconditionally enable W=1 warnings locally
>   # --- begin copy-paste W=1 warnings from scripts/Makefile.warn

