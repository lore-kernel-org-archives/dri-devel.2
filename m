Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D28BC5DF81
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 02:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903DE10E1CB;
	Fri, 21 Aug 2026 02:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="LO3dS4qO";
	dkim-atps=neutral
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD2510E1CB
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 02:11:21 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso506467a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787278281; x=1787883081;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/6gFu2KBfj6xyfAuQWkm4XRaiUsUm+P4T5r18Di7NnQ=;
 b=PDU9HXOS3YSuaug5EazZxvtwnlz8MjaXucMX1j8ZrPEWiRRy6FEdAbkeAZmghSOxar
 7p1ZB4NsVGTz1IknhEtiAc3GtAtP9MMpEhvcIaibJOouzp9r06DY7jRtxbAd6c/ZNGTt
 zhW26i+WX5UPIlJ7yHe3F7qypJPr3c7Ab1WJMXP39SABUoxTqAsbZkECOABHaBdqvBdo
 SCNBvlBy/Oy2JuMepxyfsMN9bpH8Vlp2aSch63jXgCSMcQ+KslfjNJ2DNxpbi3Og84R5
 xmxf/MrmIaKtifJopWCHCVKFH3je8WEr7CpWoy3Htrsw2bWLaUM8wwR/Acnznpm9avms
 RO3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RriR3y3RzVlKYjn3FmxprlDZiWB0EoiPtrHTX+EoMBa5B0ZloxzsgFhRzq3P+7oJiIDS2DV1crdhfs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mEO6JFEQ/yyXSfUwnetG1b+TZMDvy4x8kF07KeGipwUW8y9mee
 OfJhqIotjVJ95tYqj3YB6o5qQ+kh/2eFx69ePNwk5iI2VwKTrdWHNGWaQLdB1HSAouGkDx+kO6Y
 5ZjLpsgVyhDxCGjpXoKoM7LX8+sdhEuR4XfzXJjHAdyi4MRCYOga4zlkJGORsbQDuK+fx0UpYAT
 wAzTixAotdg53xTAT0L0qc8X0iEix8kAClTfdHkvOwU6UM0E90uZCnaZsRAKMLMU3cR7U3jW4Dk
 YA9DJITT3LmCxMheFcaU+wDIqMo
X-Gm-Gg: AR+sD11LsCvlJuk9pP5+WaCJDppjfj1RtGQBjDpJFGdS45TRRctl5WGhy2tGNhmSRFl
 Aw7AxLaQT29B6mhvqT2OyA893srKUEtDGZcsscDsg1uqkixf9XyXAfo4GWqN6FcrGt5hM3KuWuI
 rQg0RXA4qkie2ZAFz1Ub3BOtHcgOmUTcY9LBCeZH+283gglpw9IJbXH9i3tc5i7by13tAkeSRA+
 KVO37fxX6JgFyatqEqcBcw5Vro4v/eX1DVUy27zYrqK3TejOZq/324VZQE4CesyYDD3PjzJFjWY
 lXbOOroJ8WDUKxPrw0B+25pR5/9uR4WXOOal/VHOWWBF8HfZdk4F0FvNrMP3wtupWA/4S8myUuz
 4IvtuUnKgJWoGYS6EFjMeU5vXu0M3nHioKH6f6XTsD+lDIX3ZppdMj6jIxRHfDkOhkONaLUpHt1
 aLZlsfVWyBxfLNEhWzey0vKNrXf67dI7JEjXozzoXl
X-Received: by 2002:a17:90b:57ec:b0:38e:9045:babe with SMTP id
 98e67ed59e1d1-395c354e8e1mr5295833a91.7.1787278281162; 
 Thu, 20 Aug 2026 19:11:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-395c44de5cdsm412385a91.3.2026.08.20.19.11.20
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Aug 2026 19:11:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so8781155ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787278279; x=1787883079;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/6gFu2KBfj6xyfAuQWkm4XRaiUsUm+P4T5r18Di7NnQ=;
 b=LO3dS4qOFZMK2DNNmV4sAeGxKZcRwyGPJ2XHX0CQ7KQU94d9VpZ1uoQxZCHipQvQ+s
 MsxNMTt2jDdh1rJJIViz8H1RSlb3Bmfbarck88HX7ho/BJcSl3t1M2DnoECHtKf+ztnS
 /4XCx5ySWvf8y0qB9ZPQqd0CGCD2/uvwbdwI8=
X-Forwarded-Encrypted: i=1;
 AHgh+RpEy2sqHqywKnkRbFWucQAxyblYLDnTImiUNjbAiT/xzJkkvgMuzqHEAQKnFYA35nMiXEbXw9IwsKo=@lists.freedesktop.org
X-Received: by 2002:a17:903:f84:b0:2cf:82e6:a5 with SMTP id
 d9443c01a7336-2d64b06e5d6mr60768435ad.13.1787278279585; 
 Thu, 20 Aug 2026 19:11:19 -0700 (PDT)
X-Received: by 2002:a17:903:f84:b0:2cf:82e6:a5 with SMTP id
 d9443c01a7336-2d64b06e5d6mr60767415ad.13.1787278279137; 
 Thu, 20 Aug 2026 19:11:19 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327c98ba384sm16570789eec.30.2026.08.20.19.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 19:11:18 -0700 (PDT)
Message-ID: <39dfb011-0f83-4656-a6c8-426271fc8609@broadcom.com>
Date: Thu, 20 Aug 2026 19:11:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/vmwgfx: Fix typos in comments
To: liupeng <liupeng01@kylinos.cn>, dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, zack.rusin@broadcom.com, christian.koenig@amd.com,
 bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, matthew.auld@intel.com,
 matthew.brost@intel.com
References: <20260820085737.52124-1-liupeng01@kylinos.cn>
 <20260820085737.52124-3-liupeng01@kylinos.cn>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260820085737.52124-3-liupeng01@kylinos.cn>
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

On 8/20/26 1:57 AM, liupeng wrote:
> Fix misspellings of "separate", "whether" and "compatibility".
> 
> Signed-off-by: liupeng <liupeng01@kylinos.cn>
> ---
>  drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h | 2 +-
>  drivers/gpu/drm/vmwgfx/ttm_object.c                    | 2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h b/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
> index f84376718086..d4cdd9f14294 100644
> --- a/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
> +++ b/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
> @@ -125,7 +125,7 @@ typedef __attribute__((aligned(32))) struct MKSGuestStatInfoEntry {
>   * interpret the pointers.
>   *
>   * Because the host side code never acknowledges anything back to the
> - * guest there is no strict requirement to maintain compatability
> + * guest there is no strict requirement to maintain compatibility
>   * across releases.  If the interface changes the host might not be
>   * able to log stats, but the guest will continue to run normally.
>   */
> diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
> index f9042bafdc93..38b6a1787865 100644
> --- a/drivers/gpu/drm/vmwgfx/ttm_object.c
> +++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
> @@ -431,7 +431,7 @@ ttm_object_device_init(const struct dma_buf_ops *ops)
>  
>  	/*
>  	 * Our base is at VMWGFX_NUM_MOB + 1 because we want to create
> -	 * a seperate namespace for GEM handles (which are
> +	 * a separate namespace for GEM handles (which are
>  	 * 1..VMWGFX_NUM_MOB) and the surface handles. Some ioctl's
>  	 * can take either handle as an argument so we want to
>  	 * easily be able to tell whether the handle refers to a
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> index bd0563741e89..7bf128edfd4a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -445,7 +445,7 @@ static int vmw_legacy_srf_create(struct vmw_resource *res)
>   *                  vmw_surface.
>   * @val_buf:        Pointer to a struct ttm_validate_buffer containing
>   *                  information about the backup buffer.
> - * @bind:           Boolean wether to DMA to the surface.
> + * @bind:           Boolean whether to DMA to the surface.
>   *
>   * Transfer backup data to or from a legacy surface as part of the
>   * validation process.

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
