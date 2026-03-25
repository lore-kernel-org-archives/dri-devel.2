Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C191109C044
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC86710E7F4;
	Wed, 25 Mar 2026 16:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Nn+C6op5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4762710E7F4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hag9Om+N0BhkXbwkXBlt0GuHkm0yG2VPjdywxx8ijkg=;
 b=Nn+C6op5otL13zTS+ovdH/iC7+eamkjUhW6vx4vmLCy0QhKlwuJ7vha3Ha06Ri+NLyuUUJ
 inzwU2otCb7U/2rrWEcjfs+ViltCXUlg4LA8eN6jXjMABDWlrwfdfm4QMKWBZL6m3zVDqn
 sJGUhn2gVtH4rhQG4yPftkXMIbanWVU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-9rtiXSY6OzeupekYYrDh4A-1; Wed, 25 Mar 2026 12:44:39 -0400
X-MC-Unique: 9rtiXSY6OzeupekYYrDh4A-1
X-Mimecast-MFC-AGG-ID: 9rtiXSY6OzeupekYYrDh4A_1774457078
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c794ec8eso5875587f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457078; x=1775061878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hag9Om+N0BhkXbwkXBlt0GuHkm0yG2VPjdywxx8ijkg=;
 b=Pr8x0PncQikH45nuBN4ti1Eu/FZREHPYzE9Unn2u2O9Nct3e2fervzrrmwk6XZ3vSU
 OzD6M8mILL0/Vtpqsbi2B7oMhKkaahJHVAy2e/xMg4mtEAbZtDRslnOfk//hC/Ec0Rw7
 W1+myFXH/dvBsWu5sF3QUJ6wySumzZsI62igfAhRSOBa3jrwfVwKK4DJCjqLDcRzDRrq
 QnEoMhW/FtkKEE6I9PUWUB6x/dBRBu13AT8L6pM+rtiNRs9QeytELHZTsWekzkN/9Nwo
 KUOHAD+YdL14ByCIMPyBAHmtf1nsc8Onby+hub6/k6zvXOC7rkzqi4gWHRn45LghcmJn
 Kk1w==
X-Gm-Message-State: AOJu0YymsfXV5OcxnH+JN+n3FQe/AyCA8v2DImLF6t4QJdrc3uf85D2J
 80mf+z6BTFa11ZuI4dVNm1ArOvh/lG0k+PDKUT0ra3gPRFGc8UtKlyk6ry3/JBUqIWcvrna7/0s
 7ojp2LCPDRrpHNeGxiTb3YKmvO2lTcz+Taf92Zwd/NuER1/ZeDctdIvY5M5MZeweRUkRsyA==
X-Gm-Gg: ATEYQzyboT4l8LFhRzPDe7U2Sbiqo7GpDH/1eMRTW17slpKa6WQDA0MmaW9PKxMlM8d
 71kt8s/TuW+281iJMoLBYvCPnPc8JFtHFJNudL49hFfTNkSGUNV4NgXvuVUcZQ7k3Gq5O7otrQt
 ibYccoj5fzmZ7HRTkMQSWA5rIXysvNQqMMOdGqYIF3uiouPvMKPc+mTE8Xzba2xCxYcLClu6aCz
 Zt9DYpa9mw21dSvNOgxVCpcygOUmCDpWqrovLIBrsw1t1EAsZmbi/GqPl1rhNukq3z3Pw15Fg9v
 G6h47G++LaDn1MURT6YSpUbx9DssBAvClcRj++kZGfCUN6wYWpy3HhLAsrXN7RCx288LYiabVKy
 Uk6VWZPWT60S4mkMn7oAGKWr50TbrRgKAbIVHYv6oci5dT49mh0PP2Pyzz8y3CA==
X-Received: by 2002:a05:6000:3101:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-43b889e34edmr6804228f8f.30.1774457078304; 
 Wed, 25 Mar 2026 09:44:38 -0700 (PDT)
X-Received: by 2002:a05:6000:3101:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-43b889e34edmr6804177f8f.30.1774457077805; 
 Wed, 25 Mar 2026 09:44:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e528sm874199f8f.1.2026.03.25.09.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:44:37 -0700 (PDT)
Message-ID: <0ed60038-1511-49a4-8c68-44f264ad4373@redhat.com>
Date: Wed, 25 Mar 2026 17:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] drm/ast: Gen2: Fix open-coded register access
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-12-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-12-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hx4nBu4Q3H6eammctU0KYcovHMb1TFIy3HZs7nh6Src_1774457078
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
> Replace all open-coded access to MCR and SCU registers in Gen2 with the
> appropriate calls to ast_moutdwm() and ast_mindwm(). Use MCR and SCU
> register constants. Name variables according to registers.
> 
> The values in MCR04 that control VRAM allocation do not look correct.
> Leave a FIXME comment for later investigation.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2100.c | 73 ++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2100.c b/drivers/gpu/drm/ast/ast_2100.c
> index 930e9f2d0ccf..5cf8ad9c3446 100644
> --- a/drivers/gpu/drm/ast/ast_2100.c
> +++ b/drivers/gpu/drm/ast/ast_2100.c
> @@ -40,21 +40,19 @@
>   
>   static enum ast_dram_layout ast_2100_get_dram_layout_p2a(struct ast_device *ast)
>   {
> -	u32 mcr_cfg;
> +	u32 mcr04;
>   	enum ast_dram_layout dram_layout;
>   
> -	ast_write32(ast, 0xf004, AST_REG_MCR00);
> -	ast_write32(ast, 0xf000, 0x1);
> -	mcr_cfg = ast_read32(ast, 0x10004);
> +	mcr04 = ast_mindwm(ast, AST_REG_MCR04);
>   
> -	switch (mcr_cfg & 0x0c) {
> +	switch (mcr04 & GENMASK(3, 2)) {
>   	case 0:
>   	case 4:
>   	default:
>   		dram_layout = AST_DRAM_512Mx16;
>   		break;
>   	case 8:
> -		if (mcr_cfg & 0x40)
> +		if (mcr04 & 0x40)
>   			dram_layout = AST_DRAM_1Gx16;
>   		else
>   			dram_layout = AST_DRAM_512Mx32;
> @@ -300,51 +298,52 @@ static void cbrdlli_ast2150(struct ast_device *ast, int busw)
>   static void ast_post_chip_2100(struct ast_device *ast)
>   {
>   	u8 j;
> -	u32 data, temp, i;
> -	const struct ast_dramstruct *dram_reg_info;
> -	enum ast_dram_layout dram_layout  = ast_2100_get_dram_layout_p2a(ast);
> +	u32 i;
> +	enum ast_dram_layout dram_layout = ast_2100_get_dram_layout_p2a(ast);
> +	u32 mcr120;
> +	u32 scu00c, scu040;
>   
>   	j = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
>   
>   	if ((j & 0x80) == 0) { /* VGA only */
> +		const struct ast_dramstruct *dram_reg_info;
> +
>   		if (ast->chip == AST2100 || ast->chip == AST2200)
>   			dram_reg_info = ast2100_dram_table_data;
>   		else
>   			dram_reg_info = ast1100_dram_table_data;
>   
> -		ast_write32(ast, 0xf004, AST_REG_MCR00);
> -		ast_write32(ast, 0xf000, 0x1);
> -		ast_write32(ast, 0x12000, 0x1688A8A8);
> -		do {
> -			;
> -		} while (ast_read32(ast, 0x12000) != 0x01);
> -
> -		ast_write32(ast, 0x10000, 0xfc600309);
> -		do {
> -			;
> -		} while (ast_read32(ast, 0x10000) != 0x01);
> +		ast_moutdwm_poll(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY, 0x01);
> +		ast_moutdwm_poll(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY, 0x01);
>   
>   		while (!AST_DRAMSTRUCT_IS(dram_reg_info, INVALID)) {
>   			if (AST_DRAMSTRUCT_IS(dram_reg_info, UDELAY)) {
>   				for (i = 0; i < 15; i++)
>   					udelay(dram_reg_info->data);
>   			} else if (AST_DRAMSTRUCT_IS_REG(dram_reg_info, AST_REG_MCR04)) {
> +				u32 mcr04;
> +				u32 scu070;
> +
>   				switch (dram_layout) {
>   				case AST_DRAM_1Gx16:
> -					data = 0x00000d89;
> +					mcr04 = 0x00000d89;
>   					break;
>   				case AST_DRAM_1Gx32:
> -					data = 0x00000c8d;
> +					mcr04 = 0x00000c8d;
>   					break;
>   				default:
> -					data = dram_reg_info->data;
> +					mcr04 = dram_reg_info->data;
>   					break;
>   				}
>   
> -				temp = ast_read32(ast, 0x12070);
> -				temp &= 0xc;
> -				temp <<= 2;
> -				ast_moutdwm(ast, dram_reg_info->index, data | temp);
> +				/*
> +				 * FIXME: There might be bits already in MCR04[5:4]. Should
> +				 *        we only do this in the default case?
> +				 */
> +				scu070 = ast_mindwm(ast, AST_REG_SCU070);
> +				mcr04 |= (scu070 & GENMASK(3, 2)) << 2;
> +
> +				ast_moutdwm(ast, dram_reg_info->index, mcr04);
>   			} else {
>   				ast_moutdwm(ast, dram_reg_info->index, dram_reg_info->data);
>   			}
> @@ -352,19 +351,23 @@ static void ast_post_chip_2100(struct ast_device *ast)
>   		}
>   
>   		/* AST 2100/2150 DRAM calibration */
> -		data = ast_read32(ast, 0x10120);
> -		if (data == 0x5061) { /* 266Mhz */
> -			data = ast_read32(ast, 0x10004);
> -			if (data & 0x40)
> +		mcr120 = ast_mindwm(ast, AST_REG_MCR120);
> +		if (mcr120 == 0x5061) { /* 266Mhz */
> +			u32 mcr04 = ast_mindwm(ast, AST_REG_MCR04);
> +
> +			if (mcr04 & 0x40)
>   				cbrdlli_ast2150(ast, 16); /* 16 bits */
>   			else
>   				cbrdlli_ast2150(ast, 32); /* 32 bits */
>   		}
>   
> -		temp = ast_read32(ast, 0x1200c);
> -		ast_write32(ast, 0x1200c, temp & 0xfffffffd);
> -		temp = ast_read32(ast, 0x12040);
> -		ast_write32(ast, 0x12040, temp | 0x40);
> +		scu00c = ast_mindwm(ast, AST_REG_SCU00C);
> +		scu00c &= 0xfffffffd;
> +		ast_moutdwm(ast, AST_REG_SCU00C, scu00c);
> +
> +		scu040 = ast_mindwm(ast, AST_REG_SCU040);
> +		scu040 |= 0x00000040;
> +		ast_moutdwm(ast, AST_REG_SCU040, scu040);
>   	}
>   
>   	/* wait ready */

