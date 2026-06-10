Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCBFCD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 22:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD8510E48D;
	Wed, 10 Jun 2026 22:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="AKvUzWRE";
	dkim-atps=neutral
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA52410E4FD
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:00:28 +0000 (UTC)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2bf36a6905cso52123025ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781128828; x=1781733628;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifrWdwmMtnSLIzspQXoLqNd92UGj3f+HmaYSM1XCOxs=;
 b=SyEdKbJncx3E3xvp+SEWGDzCcwTFV2eVGps9gn09URfG3e7FWVtz7sQgBuQePwqmF/
 KDZy76hZLf7KWTYEc2JoaKzw1LTl1r1+E7wNTOOkq/6XlsYJW9YIFLwMF9zEoyZnTnr6
 zclCr/sGlsScHh9EygiSGZo/rYoNpCzbN6dmAPXuj6MfpEjE40XSLpAf1YuVpk4QRzVE
 F9hEowgHVSEx3ov9Qtf2BZGV4Hb/oyfrLOO1b00faT3u/LuDqGRQs1/7059qMnQogl0m
 AYf3mT4RTYmjRFQmjLt6wcZHbAkr07/QsabGSggrAPMPP7CilicJS+hbNxQGG2/EbSiU
 IwDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fYobOy2ZDENc1KR0AABn5EWst7lKjT6UgT20xP4dPgLXBxzHvjJAzQOQmJsPYdIBRzTRuNBvHB0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/InT6ihBxprBx66QS+9SUHEZIkFadRvYGUiqtl3cOJrEODGot
 8D0BHDc1KwSpF5XVL6LKs4wlt6njw04GfDMjqx4xClAUR8RHI5jLw4zjatZj/TzqXuzlY4i6OdT
 bLaB5DtaW/G6xLnk6zpDR3VV3ee+d5EeooUptQKPIOsyrdsY6CZLCwsdcjeKcXEnqCp3RBotsGL
 w6NNQGt66nkRSubRAA3/6lJAimZa5D4Go60XLXxHkCCmc/I8ACty+kvp7KpqQ0trlf7VFc7oILW
 rZw5wXfCDSAPzqQDWMQIUaVBvGG
X-Gm-Gg: Acq92OHV2SaZs5mOeOZVEYEVMREdGyQ/28goetWk7Fj1LZQMMXlORRBSfNhLhjm2G3M
 sjacaGAAAgVNuz7TBBI7tEz7gSuGM2AFbUnCJOA8/Kvu36tJJGnqYFKPtqJEo5fy7G/mhro3T8b
 Di1MkZzCoStBLJnUpiopY2GwrtsPIqCzn1Zi2G8ygAA0OcqcPtCz+1JQp0dfAYCgfO/kuN9NaiW
 94J9E76Q3b6qEaGOxtxUkKv1CVOLY0yW/781UVhtkWIFwLv2xbzObvWn5TJTm4DCkanat0IsNkQ
 /5hm4INnt5hKlLxP3Vgop4NMrl4y7wtCMXCxyUHOLg+pCBot4g0v2Lq/ujUNOElLkZkueEdLeUL
 gCxttkSnlLSR1QagkvcITmsjPjmgeKWlBgk4FLQNdbhbbQnxnnTP7LA4QdhztxWdeYER3IcwRgy
 UD1MtStzjszIjPykPBuN2KRIZYdTDdFxBNWd0Ia9F3EB9lomjMKEG8/+cQJVkAklAsCsJsF8/zE
 1I=
X-Received: by 2002:a17:903:11c9:b0:2c2:21e9:5a7d with SMTP id
 d9443c01a7336-2c2a1cb65cemr105908555ad.34.1781128828053; 
 Wed, 10 Jun 2026 15:00:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c164f71aedsm24689715ad.3.2026.06.10.15.00.27
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 15:00:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30761ab3483so4847183eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1781128826; x=1781733626;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ifrWdwmMtnSLIzspQXoLqNd92UGj3f+HmaYSM1XCOxs=;
 b=AKvUzWREmTYkbBTrFLmuBdhrtjyUN0JoImyKNbOFtHWsZvtgNlzuG6eF1agznpRAA8
 D7g0jK/HnEiwPSsBILOVGB4NqVJ7H1h2dZuIH4yLNzA0YvtzO4GXuXDcXY8/haJqHRTT
 SBW/BiGWBj2XXUdGnOpjnOEMmkSLSewxYHyHo=
X-Forwarded-Encrypted: i=1;
 AFNElJ8nsEK38mW0mMKG7XLTL/G48i0xgWvTJwCqwbWZU0X4xHpMPmENWNsxE39f7BG54D4OjbiGNKkr3Ks=@lists.freedesktop.org
X-Received: by 2002:a05:7300:7305:b0:304:c520:4e0c with SMTP id
 5a478bee46e88-3080479b610mr95426eec.6.1781128821346; 
 Wed, 10 Jun 2026 15:00:21 -0700 (PDT)
X-Received: by 2002:a05:7300:7305:b0:304:c520:4e0c with SMTP id
 5a478bee46e88-3080479b610mr95382eec.6.1781128820606; 
 Wed, 10 Jun 2026 15:00:20 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30791f9da69sm19593521eec.31.2026.06.10.15.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 15:00:19 -0700 (PDT)
Message-ID: <de7acf2e-e07c-4a94-92c7-ae0c9311c8a5@broadcom.com>
Date: Wed, 10 Jun 2026 15:04:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Don't use UTS_RELEASE directly
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Zack Rusin <zack.rusin@broadcom.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260504073422.1130008-2-u.kleine-koenig@baylibre.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260504073422.1130008-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 5/4/26 12:34 AM, Uwe Kleine-König (The Capable Hub) wrote:
> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> uncommitted changes in the source tree or new commits). So when checking
> if a patch introduces changes to the resulting binary each usage of
> UTS_RELEASE is source of annoyance.
> 
> Instead of using UTS_RELEASE directly use init_utsname()->release which
> evaluates to the same string but with that a change of UTS_RELEASE
> doesn't affect vmwgfx_drv.o.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> an alternative way to address this is to drop the kernel version string
> completely. But I'm not sure how redundant this really is so I chose the
> init_utsname() approach.
> 
> Best regards
> Uwe
> 
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 0f101aedb49a..12f5f288ae15 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -24,7 +24,6 @@
>  #include <drm/drm_sysfs.h>
>  #include <drm/ttm/ttm_range_manager.h>
>  #include <drm/ttm/ttm_placement.h>
> -#include <generated/utsrelease.h>
>  
>  #ifdef CONFIG_X86
>  #include <asm/hypervisor.h>
> @@ -35,6 +34,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/utsname.h>
>  #include <linux/version.h>
>  #include <linux/vmalloc.h>
>  
> @@ -1115,7 +1115,7 @@ static int vmw_driver_load(struct vmw_private *dev_priv, u32 pci_id)
>  	vmw_print_sm_type(dev_priv);
>  	vmw_host_printf("vmwgfx: Module Version: %d.%d.%d (kernel: %s)",
>  			VMWGFX_DRIVER_MAJOR, VMWGFX_DRIVER_MINOR,
> -			VMWGFX_DRIVER_PATCHLEVEL, UTS_RELEASE);
> +			VMWGFX_DRIVER_PATCHLEVEL, init_utsname()->release);
>  	vmw_write_driver_id(dev_priv);
>  
>  	dev_priv->pm_nb.notifier_call = vmwgfx_pm_notifier;
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

Sorry for missing this patch earlier. Unfortunately our maintainer Zack
is out for two weeks so we'll merge this patch at that time.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
