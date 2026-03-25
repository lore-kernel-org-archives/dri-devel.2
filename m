Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0D7109C03E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1864610E7ED;
	Wed, 25 Mar 2026 16:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QpZovXWt";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC49610E7ED
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774456826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWF5451DdJjpuCOBGxODnCSZvDdxLZoAb40UluyoYsw=;
 b=QpZovXWtA4FFmgYSWQudn0+e4DZeOL1kiwPmrhzElVfLhwFNgnS6zaLgoBpYX5NOK1u2Gl
 pgI7p/qvM8JSuFQ3nNMpzRDgmsiNm4NnapHB85pGlYmHsApzUjAwmfKeQ16y8KUM9iB8Vb
 mTJ8VLmy0CjfS1XigmHGUmP1dsy0oLA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-8u-FjYT7PZ67It53CJNIHA-1; Wed, 25 Mar 2026 12:40:24 -0400
X-MC-Unique: 8u-FjYT7PZ67It53CJNIHA-1
X-Mimecast-MFC-AGG-ID: 8u-FjYT7PZ67It53CJNIHA_1774456823
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439c794ec8eso5864120f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774456823; x=1775061623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QWF5451DdJjpuCOBGxODnCSZvDdxLZoAb40UluyoYsw=;
 b=LZ68eUAj348nwIi0PDfv+HkD2/Zo4YosSgrqFryeL+LRNSd6pLyPX+nG3Vj+Z+lW3F
 Rfalcq7PDYBu7Aeo9taTvt3jD8iXob9OKo4+u0G2m1nkuTcDJfA6Bia5QpSduaYUZ7ro
 mUIIjCeVIatYDdje3WIsowzXvUgm61YOCJwjef8nOQkOBRnjSD/NDf/zvU6FF6uAAhH+
 cP5W/eAsYFKqAWzr1TVJdOJLh33t2a7uMXZR415UY+N/OAFQ61xHyHYlP7AjaFhuD3O0
 kwNiOJ3aZICIkM0B2pXwjMmOEMyDnFWN9FI8DpJrff058QIFd5uDfWdR4d5m2V8eOBUj
 hS2w==
X-Gm-Message-State: AOJu0YwlkV/soc1V1rQ/aHCBzjWZW5WYc7wd127GhYI5nUIDuwJuZxQO
 y+D5UqJ5aYpEOBM4iHvk3B0GN+7gpQoXTYf4temcCre/fjdSK24P8e/D6/ftlhymzNZgQMqspmX
 +9jTjMT+7HrzlSwCk3QgYepxcixRXpSC35dMIKVOeSk5hROr1Juttj0quTI8hkynwJCCKZA==
X-Gm-Gg: ATEYQzwy1AzjGDWirQ/nHUjWl3/3hayDG2QuAFt0rZ1ctuKZnTyYUUtolTySICDyxX8
 J7yBZLQqdO6ugFwXnuYRUNwzm7ocGgib54ZnLUtJLs/IYy+ArfWcLFbJGP1j2V3cVjRUmD6xbxb
 +bO9r6XD6BI66idBnzOEi5ChPZcD1xGKDpAMxCGazArGJWEy1C2OSKWwaE8FK50Rz9gz0bQyfdh
 5PcULosmNng/xZEr2sh8C+NxrxZPGkE00FxM2Js7wF4TKSkUqJ3MU4ua16t07Ml+7sDJ6a7BgOB
 YO2QKE5gYuHZDyql9As4A/U8yGzs/koTqSChwmB1EbjO+BRNwkwK4wScPjGyyEtGZck5e9rVWbs
 ahTShN17n+KnndtyM0jZhCN+VTWritfJRfWZmUlnwUlO0wegq+vONwQ+PB2abCw==
X-Received: by 2002:a05:6000:230c:b0:43b:5767:8f2a with SMTP id
 ffacd0b85a97d-43b889991ecmr6257689f8f.22.1774456823126; 
 Wed, 25 Mar 2026 09:40:23 -0700 (PDT)
X-Received: by 2002:a05:6000:230c:b0:43b:5767:8f2a with SMTP id
 ffacd0b85a97d-43b889991ecmr6257648f8f.22.1774456822665; 
 Wed, 25 Mar 2026 09:40:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919dfb54sm918421f8f.31.2026.03.25.09.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:40:22 -0700 (PDT)
Message-ID: <9e9ba14f-ab89-4b1d-8207-ff22af087bf7@redhat.com>
Date: Wed, 25 Mar 2026 17:40:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] drm/ast: Gen1: Fix open-coded register access
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-11-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-11-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n6TSu8BO7kqC6I64B-uGuNKlDh-d2hfya2_4qanTOM8_1774456823
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
> Replace all open-coded access to MCR registers in Gen1 with the
> appropriate calls to ast_moutdwm() and ast_mindwm(). Use MCR register
> constants.
> 
> For the poll loop on MCR100, add ast_moutdwm_poll(). The helper polls
> the register until it has been updated to the given value. Relax the
> CPU while busy-waiting.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2000.c | 18 +++++++-----------
>   drivers/gpu/drm/ast/ast_drv.c  | 12 ++++++++++++
>   drivers/gpu/drm/ast/ast_drv.h  |  1 +
>   drivers/gpu/drm/ast/ast_reg.h  |  2 ++
>   4 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2000.c b/drivers/gpu/drm/ast/ast_2000.c
> index e683edf595e2..4cf951b3533d 100644
> --- a/drivers/gpu/drm/ast/ast_2000.c
> +++ b/drivers/gpu/drm/ast/ast_2000.c
> @@ -99,20 +99,15 @@ static const struct ast_dramstruct ast2000_dram_table_data[] = {
>   static void ast_post_chip_2000(struct ast_device *ast)
>   {
>   	u8 j;
> -	u32 temp, i;
> -	const struct ast_dramstruct *dram_reg_info;
> +	u32 i;
>   
>   	j = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
>   
>   	if ((j & 0x80) == 0) { /* VGA only */
> -		dram_reg_info = ast2000_dram_table_data;
> -		ast_write32(ast, 0xf004, AST_REG_MCR00);
> -		ast_write32(ast, 0xf000, 0x1);
> -		ast_write32(ast, 0x10100, 0xa8);
> +		const struct ast_dramstruct *dram_reg_info = ast2000_dram_table_data;
> +		u32 mcr140;
>   
> -		do {
> -			;
> -		} while (ast_read32(ast, 0x10100) != 0xa8);
> +		ast_moutdwm_poll(ast, AST_REG_MCR100, 0xa8, 0xa8);
>   
>   		while (!AST_DRAMSTRUCT_IS(dram_reg_info, INVALID)) {
>   			if (AST_DRAMSTRUCT_IS(dram_reg_info, UDELAY)) {
> @@ -124,8 +119,9 @@ static void ast_post_chip_2000(struct ast_device *ast)
>   			dram_reg_info++;
>   		}
>   
> -		temp = ast_read32(ast, 0x10140);
> -		ast_write32(ast, 0x10140, temp | 0x40);
> +		mcr140 = ast_mindwm(ast, AST_REG_MCR140);
> +		mcr140 |= 0x00000040;
> +		ast_moutdwm(ast, AST_REG_MCR140, mcr140);
>   	}
>   
>   	/* wait ready */
> diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> index 3da0cce0a3f6..6fe549f16309 100644
> --- a/drivers/gpu/drm/ast/ast_drv.c
> +++ b/drivers/gpu/drm/ast/ast_drv.c
> @@ -102,6 +102,18 @@ void ast_moutdwm(struct ast_device *ast, u32 r, u32 v)
>   	__ast_moutdwm(ast->regs, r, v);
>   }
>   
> +void ast_moutdwm_poll(struct ast_device *ast, u32 r, u32 v, u32 res)
> +{
> +	void __iomem *regs = ast->regs;
> +
> +	__ast_selseg(regs, r);
> +	__ast_wrseg32(regs, r, v);
> +
> +	do {
> +		cpu_relax();
> +	} while (__ast_rdseg32(regs, r) != res);
> +}
> +
>   /*
>    * AST device
>    */
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index 3eedf8239333..4f221b848d68 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -361,6 +361,7 @@ u32 __ast_mindwm(void __iomem *regs, u32 r);
>   void __ast_moutdwm(void __iomem *regs, u32 r, u32 v);
>   u32 ast_mindwm(struct ast_device *ast, u32 r);
>   void ast_moutdwm(struct ast_device *ast, u32 r, u32 v);
> +void ast_moutdwm_poll(struct ast_device *ast, u32 r, u32 v, u32 res);
>   
>   /*
>    * VBIOS
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index a01af2bfbae6..9ebdbbde9a47 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -140,8 +140,10 @@
>   #define AST_REG_MCR80				AST_REG_MCR(0x80)
>   #define AST_REG_MCR84				AST_REG_MCR(0x84)
>   #define AST_REG_MCR88				AST_REG_MCR(0x88)
> +#define AST_REG_MCR100				AST_REG_MCR(0x100)
>   #define AST_REG_MCR108				AST_REG_MCR(0x108)
>   #define AST_REG_MCR120				AST_REG_MCR(0x120)
> +#define AST_REG_MCR140				AST_REG_MCR(0x140)
>   #define AST_REG_MCR200				AST_REG_MCR(0x200)
>   #define AST_REG_MCR204				AST_REG_MCR(0x204)
>   #define AST_REG_MCR208				AST_REG_MCR(0x208)

