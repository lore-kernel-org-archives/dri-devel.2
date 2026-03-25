Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8B7109C035
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF10410E7D9;
	Wed, 25 Mar 2026 16:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gqwIOloo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240FC10E7D9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774454956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Zh1fr2iQV6ZRapNVMXyC+ar16a1KnzWPqrnp2XoJ30=;
 b=gqwIOlooW7OL4OK6lgy7QN+4P/qzFFrAdi8ErhQSNpizXDiee6BPNLQCmENofW4/JoQCi8
 5RWsxIwgccFC1LLRwOL1qsz8j9t6b+SpLgWTf5oHoYvII/DkMdZ7FHoQopCK5C88CenZnr
 yJTJQEV697E40gBrZTUoXkQyYpo9LLU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Aj-yiqrYPtSmjV5GM98aSQ-1; Wed, 25 Mar 2026 12:09:15 -0400
X-MC-Unique: Aj-yiqrYPtSmjV5GM98aSQ-1
X-Mimecast-MFC-AGG-ID: Aj-yiqrYPtSmjV5GM98aSQ_1774454954
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48718273180so92445e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774454954; x=1775059754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Zh1fr2iQV6ZRapNVMXyC+ar16a1KnzWPqrnp2XoJ30=;
 b=lgiDcRwDslatGUBgVTXzdIAqrPC2NBRWeuZIewc6SyBcsvSVh8orp/3AjBPE7qhMAL
 TbHZ3Od5zNgSwKQQVV2wRmkVjtHWYu6xzpO4jBumnjHWEvhq2YvjNHs59dlgy4IFA/4s
 OF6F7Iow5cP1VmyRlInBS5woyC9dxJoUsy7rhls3naFt6a7MysTkR5+P+1pGegmDjc57
 nu9wdgX1bjmlLNcgRbSVl/EbYEdVh43Swu+lGZqNIkwYZpHMEE7Sb4NllUPuW3Tfr7kJ
 qHirtTgZGygBebTfAiPZxl8o1PUxGwy3R3qhU651F4yx18gKvOLfQ933V0hajo7daFuA
 Ps3g==
X-Gm-Message-State: AOJu0YyvsIXL3DwFvfsAOzT6yKt+NN6UHtlQxDZXQ/mdtGQAZhOtiZ84
 fqx6AjgNGeItyzJSe/pzHxa3gsbD3b1+DNt/RwCdvcSm5Cphi43Hu+A3vXRIFb1ezi05Q7AIDsN
 /OvkfxYQiGh2gkWIlT4pR0p5gSFRZf3it99x3dPsX//ibfkLvDZCgmy/PheiswIeW+0HZ/A==
X-Gm-Gg: ATEYQzzXVxKkVWYU90+NdGAZWB3jxWTw6t9atE7Ff/O5yJIy5zgZaFplMnalLQ+Q7VJ
 ogi5/12xdPpDHEhwR2nsr3hwh5yyOWH7E6UNyNC/6xaKKvSY3k9kYw05FU0xlYGJreaokeEzg4H
 9CleBOJhORdVWU9IO+8xzn8uZMBPnqddiVDGjGW+T8rzoxJQZLTVf6Ui0A6bbjZi48a7xSPoibh
 gZOZHCzIL63QuuIVGb0Svy0u6oi+00hWtiD3q2LL2acbAarax3fflwtJVFY+N613lpfEbt/++/Z
 qh/DcyFEHcIlpbvj86boXMLLJ/wWpWYqVmzie9mufHLdRhN4Z21UI7jGfEsjsogtH5BhSSUKt6l
 lJNpCB8kYLxkPVCpVXLcExRkTWieeHPYToN+5yLY+HPAx2mhqF+ivSAlNBc1DCQ==
X-Received: by 2002:a05:600c:154a:b0:485:3b00:f939 with SMTP id
 5b1f17b1804b1-48715fd617dmr67211415e9.8.1774454953522; 
 Wed, 25 Mar 2026 09:09:13 -0700 (PDT)
X-Received: by 2002:a05:600c:154a:b0:485:3b00:f939 with SMTP id
 5b1f17b1804b1-48715fd617dmr67210815e9.8.1774454952994; 
 Wed, 25 Mar 2026 09:09:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91942e52sm781157f8f.9.2026.03.25.09.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:09:12 -0700 (PDT)
Message-ID: <1042a83e-05f1-4258-b6fa-8f45f267ed13@redhat.com>
Date: Wed, 25 Mar 2026 17:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] drm/ast: Use constants for WDT registers
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-8-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-8-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 92AeHA_REylr5xXHlnWwZSZ_xysf02w4ROIE_PwtErc_1774454954
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
> WDT is the Watchdog timer. WDC registers are located at the memory
> range at [0x1e785000, 0x1e785fff]. There are currently up to 8
> watchdog timers in the range, of which 2 are being used by AST2500.
> 
> Refer to them with macros named AST_REG_WDT<n>, where <n> is the byte
> offset into the watchdog timer's memory range. Each macro also takes
> the index of the watchdog timer to access. A new watchdog timer starts
> at each 0x40 byte offset.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2500.c | 20 ++++++++++----------
>   drivers/gpu/drm/ast/ast_reg.h  | 13 +++++++++++++
>   2 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
> index d141b34548a9..f0639f1ef062 100644
> --- a/drivers/gpu/drm/ast/ast_2500.c
> +++ b/drivers/gpu/drm/ast/ast_2500.c
> @@ -127,9 +127,9 @@ void ast_2500_patch_ahb(void __iomem *regs)
>   		 *	[1]:= 1:WDT will be cleeared and disabled after timeout occurs
>   		 *	[0]:= 1:WDT enable
>   		 */
> -		__ast_moutdwm(regs, 0x1E785004, 0x00000010);
> -		__ast_moutdwm(regs, 0x1E785008, 0x00004755);
> -		__ast_moutdwm(regs, 0x1E78500c, 0x00000033);
> +		__ast_moutdwm(regs, AST_REG_WDT04(0), 0x00000010);
> +		__ast_moutdwm(regs, AST_REG_WDT08(0), 0x00004755);
> +		__ast_moutdwm(regs, AST_REG_WDT0C(0), 0x00000033);
>   		udelay(1000);
>   	}
>   
> @@ -304,12 +304,12 @@ static void set_mpll_2500(struct ast_device *ast)
>   
>   static void reset_mmc_2500(struct ast_device *ast)
>   {
> -	ast_moutdwm(ast, 0x1E78505C, 0x00000004);
> -	ast_moutdwm(ast, 0x1E785044, 0x00000001);
> -	ast_moutdwm(ast, 0x1E785048, 0x00004755);
> -	ast_moutdwm(ast, 0x1E78504C, 0x00000013);
> +	ast_moutdwm(ast, AST_REG_WDT1C(1), 0x00000004);
> +	ast_moutdwm(ast, AST_REG_WDT04(1), 0x00000001);
> +	ast_moutdwm(ast, AST_REG_WDT08(1), 0x00004755);
> +	ast_moutdwm(ast, AST_REG_WDT0C(1), 0x00000013);
>   	mdelay(100);
> -	ast_moutdwm(ast, 0x1E785054, 0x00000077);
> +	ast_moutdwm(ast, AST_REG_WDT14(1), 0x00000077);
>   	ast_moutdwm(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY);
>   }
>   
> @@ -508,8 +508,8 @@ static void ast_post_chip_2500(struct ast_device *ast)
>   		ast_2500_patch_ahb(ast->regs);
>   
>   		/* Disable watchdog */
> -		ast_moutdwm(ast, 0x1E78502C, 0x00000000);
> -		ast_moutdwm(ast, 0x1E78504C, 0x00000000);
> +		ast_moutdwm(ast, AST_REG_WDT2C(0), 0x00000000);
> +		ast_moutdwm(ast, AST_REG_WDT0C(1), 0x00000000);
>   
>   		/*
>   		 * Reset USB port to patch USB unknown device issue
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index 730072a3c2cd..5effe6897b51 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -196,4 +196,17 @@
>   #define AST_REG_A2P(__offset)			(AST_REG_A2P_BASE + (__offset))
>   #define AST_REG_A2P58				AST_REG_A2P(0x58)
>   
> +/*
> + * Watchdog timer (0x1e785000 - 0x1e785fff)
> + */
> +
> +#define AST_REG_WDT_BASE(__n)			(0x1e785000 + (__n) * 0x40)
> +#define AST_REG_WDT(__n, __offset)		(AST_REG_WDT_BASE((__n)) + (__offset))
> +#define AST_REG_WDT04(__n)			AST_REG_WDT((__n), 0x04)
> +#define AST_REG_WDT08(__n)			AST_REG_WDT((__n), 0x08)
> +#define AST_REG_WDT0C(__n)			AST_REG_WDT((__n), 0x0c)
> +#define AST_REG_WDT14(__n)			AST_REG_WDT((__n), 0x14)
> +#define AST_REG_WDT1C(__n)			AST_REG_WDT((__n), 0x1c)
> +#define AST_REG_WDT2C(__n)			AST_REG_WDT((__n), 0x2c)
> +
>   #endif

