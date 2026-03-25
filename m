Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FEA109C035
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869EB10E7DA;
	Wed, 25 Mar 2026 16:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="iomDEz+y";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F36C10E7DA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774455032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrLOZjMRRMpHvaVd/RH8pK6AOA7E+mUv+gFDvXCLukI=;
 b=iomDEz+y30sGtFAarubC+OsKjAxloeK/MjPwEDWcntJIhrw8ZP4HkENikoc2EZ8z6e2AKf
 N3ybDY8U/ZgHLYshOP9t0b1MSBas+UrdfXbYpM2eGcGE5GQ6gBWl3Sg5XaaRnmT3VScACR
 qVYo9zqv/nC/4AY94HAaaMrnCGmyBKU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-QH-LMquTOV6sE0HK18QS2g-1; Wed, 25 Mar 2026 12:10:31 -0400
X-MC-Unique: QH-LMquTOV6sE0HK18QS2g-1
X-Mimecast-MFC-AGG-ID: QH-LMquTOV6sE0HK18QS2g_1774455030
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43b42eee946so954613f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774455030; x=1775059830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wrLOZjMRRMpHvaVd/RH8pK6AOA7E+mUv+gFDvXCLukI=;
 b=m4DFj8YBkvlZUgartc2CzTPwRTGKKM4b55sEs5zTfr3b/reew+iW5rDgaaGy4f3ZI6
 ujAG78AagNWBSg2ngpnZeNjCeCzLtFHyFnbJUn21bVfw80TzxRWcNEO7JnkclyAC39l2
 dSt1m+EPKeBR2kwIddfOX3S/pagFhCrpEaYV4yNQvGi3Fxbl199c0JXK+ESAc9Mudb05
 LhkATlZc25Ngq3nfnta7T8MKxNfs9hTUJnahqGv3OOX3deUVS3PP4PhyAKcSTWNC4Gnb
 JrQ7zLtpKtjd5F2bW5Ose2MSJnJIfDM6vjt4BA2cFaYh7XHq8rgfIhpCgLgyWzG4+ihA
 jUFA==
X-Gm-Message-State: AOJu0Yz+GXIzvRVWfKGhzgsbpfC0T/Q8oV6OtJKREs0URlwKE3RX/ZGi
 HgzdPAZ/dZU89SbP+3FKkG6q7WOZ/6B2dUhYV3b9RL4ld+BVwRTdcI98OnxEsmqfMWlnUOEy75h
 AnLbgHi0w8By2+wVzPA6fc5CtSxGyhTVwmaX9UgPrPeeDu3BkpLX6VKewm/DUqcqqyU4AjA==
X-Gm-Gg: ATEYQzxyV5bH7PKbHbrdte5kBseyWqKNkLJNy/ptFHWnVE6CcF4I3ueEvcNVvL0KbR9
 /2rSINjCQGDWyfHHXQdDqZfKB4iBb4p+kvj0Sg4AZw4UZf/yV2B0OHysUitHZaUeBpNOa1TGoAb
 ws/2+WztCiob5Wl07VT0S3qk6/BIN4WxPjFCx0Bp1bJv8fEAKgcC3VOv+mx8Bt7eCzWpOzbs76S
 FLggjdVy1yROifjnfYaJHQ9KuOK/wNQXmM3h5izbb84Et0VggKaoq4FmIHDCYvkXGMtS6lm4G5W
 HBHISZFQcYY+i4Qef+GVmNAi8Hbjs0hFZhjlV+TdWr1rPgToJRs68jvVRYOz76+BHfkHrW94WPV
 DYf19ciwrTlzRbu8nlXXYhT2ZVbYo/OSMbohyH3e3NMrJFiWmR7CgFODnWBTuMQ==
X-Received: by 2002:a05:600c:656:b0:487:1ed:6bf4 with SMTP id
 5b1f17b1804b1-4870f1eb195mr94851215e9.3.1774455029857; 
 Wed, 25 Mar 2026 09:10:29 -0700 (PDT)
X-Received: by 2002:a05:600c:656:b0:487:1ed:6bf4 with SMTP id
 5b1f17b1804b1-4870f1eb195mr94850875e9.3.1774455029365; 
 Wed, 25 Mar 2026 09:10:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9194311asm985659f8f.10.2026.03.25.09.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:10:28 -0700 (PDT)
Message-ID: <d7c5f9cc-9588-4154-96b5-312062c9e19a@redhat.com>
Date: Wed, 25 Mar 2026 17:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] drm/ast: Use constants for SDRAM registers
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-9-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-9-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tj59eh1PsxE5Mq1SQVIbJVzVnSFpmDA6IKY-gBXnWPo_1774455030
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 23/03/2026 16:56, Thomas Zimmermann wrote:
> Aspeed hardware allows for acceessing the SDRAM from the host. SDRAM
> registers are located at the memory range at [0x80000000, 0xffffffff].
> 
> Refer to memory access with the macro AST_SDRAM(). Also add a TODO item
> for the nonsensical documentation next to its caller.
> 

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2500.c | 17 ++++++++++-------
>   drivers/gpu/drm/ast/ast_reg.h  |  7 +++++++
>   2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
> index f0639f1ef062..39f401dd1f47 100644
> --- a/drivers/gpu/drm/ast/ast_2500.c
> +++ b/drivers/gpu/drm/ast/ast_2500.c
> @@ -225,6 +225,9 @@ static void ddr_phy_init_2500(struct ast_device *ast)
>   }
>   
>   /*
> + * TODO: Review and fix the comments. The function below only detects
> + *       up to 1 GiB of SDRAM.
> + *
>    * Check DRAM Size
>    * 1Gb : 0x80000000 ~ 0x87FFFFFF
>    * 2Gb : 0x80000000 ~ 0x8FFFFFFF
> @@ -238,21 +241,21 @@ static void check_dram_size_2500(struct ast_device *ast, u32 tRFC)
>   	reg_04 = ast_mindwm(ast, AST_REG_MCR04) & 0xfffffffc;
>   	reg_14 = ast_mindwm(ast, AST_REG_MCR14) & 0xffffff00;
>   
> -	ast_moutdwm(ast, 0xA0100000, 0x41424344);
> -	ast_moutdwm(ast, 0x90100000, 0x35363738);
> -	ast_moutdwm(ast, 0x88100000, 0x292A2B2C);
> -	ast_moutdwm(ast, 0x80100000, 0x1D1E1F10);
> +	ast_moutdwm(ast, AST_SDRAM(0x20100000), 0x41424344);
> +	ast_moutdwm(ast, AST_SDRAM(0x10100000), 0x35363738);
> +	ast_moutdwm(ast, AST_SDRAM(0x08100000), 0x292A2B2C);
> +	ast_moutdwm(ast, AST_SDRAM(0x00100000), 0x1D1E1F10);
>   
>   	/* Check 8Gbit */
> -	if (ast_mindwm(ast, 0xA0100000) == 0x41424344) {
> +	if (ast_mindwm(ast, AST_SDRAM(0x20100000)) == 0x41424344) {
>   		reg_04 |= 0x03;
>   		reg_14 |= (tRFC >> 24) & 0xFF;
>   		/* Check 4Gbit */
> -	} else if (ast_mindwm(ast, 0x90100000) == 0x35363738) {
> +	} else if (ast_mindwm(ast, AST_SDRAM(0x10100000)) == 0x35363738) {
>   		reg_04 |= 0x02;
>   		reg_14 |= (tRFC >> 16) & 0xFF;
>   		/* Check 2Gbit */
> -	} else if (ast_mindwm(ast, 0x88100000) == 0x292A2B2C) {
> +	} else if (ast_mindwm(ast, AST_SDRAM(0x08100000)) == 0x292A2B2C) {
>   		reg_04 |= 0x01;
>   		reg_14 |= (tRFC >> 8) & 0xFF;
>   	} else {
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index 5effe6897b51..78fabe2a9c81 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -209,4 +209,11 @@
>   #define AST_REG_WDT1C(__n)			AST_REG_WDT((__n), 0x1c)
>   #define AST_REG_WDT2C(__n)			AST_REG_WDT((__n), 0x2c)
>   
> +/*
> + * SDRAM (0x80000000 - 0xffffffff)
> + */
> +
> +#define AST_SDRAM_BASE				(0x80000000)
> +#define AST_SDRAM(__offset)			(AST_SDRAM_BASE + (__offset))
> +
>   #endif

