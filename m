Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5AAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D597A10F08E;
	Wed,  1 Jul 2026 18:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Du660YPo";
	dkim-atps=neutral
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com
 [209.85.222.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59F210F08E
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:39:19 +0000 (UTC)
Received: by mail-ua1-f100.google.com with SMTP id
 a1e0cc1a2514c-9667ea2fc22so270019241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782931159; x=1783535959;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/JxzyIbMWOBgcLE6PUDXiCIrbfQPnTTq4sO8ZawTQs=;
 b=sZCWE3CTUyHX3tTXoVvnv4ZlXjzQX4yj4vco/jhlKqqFTnDIKZRd5Ee1e3dViHb+eo
 vU7VoEt9/ARWT5Sk6nW6YISsynEsPPkFU65Cq3MbA4XFuVkv5sQubyevwiL/rJDwmGcl
 xpE5F92vHz1g+tqluRpR24W1sJbSkyNvq03o8cJPLwGMy/TRI7l/v1CnfjID1L4B2KOC
 qilk1O2gRvwYYMS5Wx1ENwBKTzJxxcN91xf9ujVGku5JskiK9PrmhGzJL1a8Rceb78sR
 6Juk/SOg3j7YAnNLElyWOcalZX2nBrfnIxV6ytLActk1+u5cBv7CyWyO8Cfv4MD3Zh3G
 b8mQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVd8RBceIYQJ0fKTltgrwrVarb6PgkaXmbtdIj/havBFEc6TIDvoNnt3AjmdjSVJ2USscHxYKH+EM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7QkML3spQDS+DzQfNhx9sYMcK4vt2fZ/fDnifAY4LTsUgZrQB
 7AYXsilNu6LdqKOpn0jrwct1BE/wwRt6N5LjuRWvcAtCcHnB6aOe+dby/qa1H/Ni0ClQTFMEE/x
 I9zFbcgXjkD7rG3aDuK3uStOwmMDcladMf43609dwGu/fdnWljabO7zqRlEPVy5qdqud5mUF4Er
 hHeo3fn2UK+U7qTvqBOviSpzISn53UqBf24SUvXXDCdH/sHt4v65y8dkl1JsydPPKy3ZyxwnhBs
 +3QAjAExtMX/5ppJWevRTp29Yrb
X-Gm-Gg: AfdE7clww5BWNaDle4Y4Hda7IeG0ti7aRRFES3KyymDeUZ+9Kj/eEbmUEZ9mxQXSSD7
 sYl15X0pZi2huzoiMmDs46bEGSKPUDdkgssZQy1eDJDhzu4PXCDtgw56gLr/nrvCB7aQ81Aja97
 NqaxcA3jGuZk3LSyW4wKexUhUSJ9BtICkBjkq5BrXWoU2+rNmdRCk7v21SattdyeS1fCnfabKsV
 FJyMjbozDGEJg2Yo3pohRkKiw/puYl8/zoE6/mTrkZwCz1gjbi6AozbRiveELPsZXhgyGsOIzbW
 pcDGjuQSLKJrQ3sxjVVTNlxWRTm+9krqg1Q67jl/VO59S6B3AUXBffcIFSo6qhhSR50Ga2Wa8Bb
 zimDNA0xB+FQ83a9+iFOX7sq5LNb6Sa9JRNRCIp0gkpT2PQT4LjHjq6pTbutjl6+HyLK10klyDG
 LQDvdNmYj6F8CckU2FXkXBH/+9bnEj9nSonCdDV5iGL10mAeigyE4=
X-Received: by 2002:a05:6102:80a5:b0:631:2dc6:2f5c with SMTP id
 ada2fe7eead31-73dba87f7fcmr1182913137.0.1782931158654; 
 Wed, 01 Jul 2026 11:39:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-969839b5e80sm2423241.4.2026.07.01.11.39.18
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2026 11:39:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4960487333eso1299269b6e.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1782931158; x=1783535958;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/JxzyIbMWOBgcLE6PUDXiCIrbfQPnTTq4sO8ZawTQs=;
 b=Du660YPo5DGV4k2wqpFKw8r/1ZqGVvX7swkRMGdLpAK9QlDs3Ab0ej4TS+4jFoec0n
 WgW99w8EdioufJneN1NOxWa2zwFAhqUrCv4/AQFNIbnR0FC0yKcrWkrqQShK7yDzjNTc
 bDFTKECtKXzj2eLKXsFH0MvZp+mXH3N/o34+Q=
X-Forwarded-Encrypted: i=1;
 AFNElJ+SYREuOYStamgzAKFQPuMeCMw/tLD2KQzaUdiMmja1aLnEmmf/dqdx0mg3Um6d3fBv2Pl2ft9ZZV4=@lists.freedesktop.org
X-Received: by 2002:a05:6808:190c:b0:48c:4c00:596a with SMTP id
 5614622812f47-4962d70ee64mr1114603b6e.5.1782931157915; 
 Wed, 01 Jul 2026 11:39:17 -0700 (PDT)
X-Received: by 2002:a05:6808:190c:b0:48c:4c00:596a with SMTP id
 5614622812f47-4962d70ee64mr1114533b6e.5.1782931156582; 
 Wed, 01 Jul 2026 11:39:16 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-49606ad4774sm1995857b6e.9.2026.07.01.11.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 11:39:16 -0700 (PDT)
Message-ID: <11cd2e26-1af5-4085-a589-060b96a51076@broadcom.com>
Date: Wed, 1 Jul 2026 11:43:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Fix NULL vs error pointer bug in
 vmw_prime_import_sg_table()
To: Dan Carpenter <error27@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Martin Krastev <martin.krastev@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <akIR3WlKLCiCTb5T@stanley.mountain>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <akIR3WlKLCiCTb5T@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 6/28/26 11:34 PM, Dan Carpenter wrote:
> The vmw_prime_import_sg_table() function is expected to return error
> pointers on error and not NULL.  Otherwise it leads to a NULL dereference
> in the caller drm_gem_prime_import_dev().
> 
> Change the NULL to ERR_PTR(-ENOMEM).
> 
> Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> index 39f8c46550c2..f25db04f8777 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> @@ -184,7 +184,7 @@ struct drm_gem_object *vmw_prime_import_sg_table(struct drm_device *dev,
>  {
>  	int ret;
>  	struct vmw_private *dev_priv = vmw_priv(dev);
> -	struct drm_gem_object *gem = NULL;
> +	struct drm_gem_object *gem = ERR_PTR(-ENOMEM);
>  	struct vmw_bo *vbo;
>  	struct vmw_bo_params params = {
>  		.domain = (dev_priv->has_mob) ? VMW_BO_DOMAIN_SYS : VMW_BO_DOMAIN_VRAM,

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
