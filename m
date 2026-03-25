Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0252E109C033
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5667010E7F9;
	Wed, 25 Mar 2026 16:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="I3CA/vDV";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A11B10E7F9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftd/0TQGIE9c59GDOnzxjZSo9Rgf5/Q6QtZeZaOnsDc=;
 b=I3CA/vDVX44nGQ0ZPnYqDbaCnUPU0GNj6PC3cyOn3fN6OHt2rNJrAShq0Xz49vWxSqKUND
 DmYVeY7BecuttqoSuLT/zWX3H8rNKpYUYXyGdnV/7JI1oYttW38QDibsi/5C079qOpjx5j
 iPFjDTNtf0tkI+huwTigvf2wBPdrF6g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-RVHpMEGNNkKihRlZtBSOtw-1; Wed, 25 Mar 2026 12:45:37 -0400
X-MC-Unique: RVHpMEGNNkKihRlZtBSOtw-1
X-Mimecast-MFC-AGG-ID: RVHpMEGNNkKihRlZtBSOtw_1774457136
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-38a4197d57dso3027061fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457136; x=1775061936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ftd/0TQGIE9c59GDOnzxjZSo9Rgf5/Q6QtZeZaOnsDc=;
 b=XoOb6169yUa9WaLcuvl09dWdDlbH5KsvPmOFfg58DH5gNZZc4SezL8bXatXHOY9EOJ
 bHrVdptUNZ5BaoeN/TYCxui3/otJum9kwZiC+dxxszo5sUQahS9dowtuFLSH7Ygxvw05
 4t9VqkE+1biD4eR49UUpfB0qOh3qgE+FO2aekPstt0kAmxMop4MUxfs21Rc3+CSCM6qN
 QoSgwfSY5t1zjeuFYHD1NviXRI81wxHqkBEeE8WdLu/rwsHbXkg3ExFlJNGcHXTteChT
 SbhIguuhAHR+JwqLoKbOew950j9gMLqYlbEoEtqDqmB/aYwFii20gRXSVLSPNJhkyESX
 IPHw==
X-Gm-Message-State: AOJu0Ywhglp+LVE5ZpvQHQa4jrS8DRdfMv4m7y8/9R+anZVtM7PGx4W5
 sERyDuWhTa2WcHHbqfJB4Jqaxe4H2nUttdUovQa5fhKZ33Pl+PZHSHKHWqE4EilczQuYhXmgDri
 s+nSpnc5l+mjoDrXoBjbFfrnTlhnMSMR3H4yaJPTs0lqsPPTUrQ1J+4NmyZif/ivWRUf9kA==
X-Gm-Gg: ATEYQzyqcUdKi+rENiY/Gg5+c7sTXBIV2kyNR7AjJwx0SfyrIKCpYHRjpZYQZjjhy87
 +FWViHuFLdiDF2MJn6oeoxlmo+Dvt7f9eZRJvrDsiZQw4AjZabYrAd00oSbbRaQ1eib54bxZLNC
 8T6etIifAaidtrkRaTeWmkGlWDrzLbkjbMU/isFry974dQm1toS/zdieccXNHW2W78laf+N8LG3
 I3k2dZca3ikocNHTWuSDQb8EqY/ViUWhNxGV6unHtu+O3JtUzFXNc18FBQ66kdk1tGmJ3TrmFgJ
 wr8UaKix/JRg6TxM7hWzgWZeaSocjUx/6Z0q3I3axe9Z7U7KMNQAaPSaWYW5E0Y9vtYirS/O+XP
 4yje8wu1B6b2G9IOMFPbLZJ2dniBd9PCxrFPY7lzm+5hjdGtJ29HUL8iW7F3vNQ==
X-Received: by 2002:a05:6512:318b:b0:5a2:7851:7d46 with SMTP id
 2adb3069b0e04-5a29b9936e9mr1372504e87.35.1774457135456; 
 Wed, 25 Mar 2026 09:45:35 -0700 (PDT)
X-Received: by 2002:a05:6512:318b:b0:5a2:7851:7d46 with SMTP id
 2adb3069b0e04-5a29b9936e9mr1372478e87.35.1774457134879; 
 Wed, 25 Mar 2026 09:45:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2a063eec2sm18067e87.1.2026.03.25.09.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:45:34 -0700 (PDT)
Message-ID: <3c8c508d-5048-4be7-8bf6-ec3c704d4943@redhat.com>
Date: Wed, 25 Mar 2026 17:45:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] drm/ast: Gen4: Fix open-coded register access
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-13-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-13-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tjqNN2foYQWkJjOLBQpusq42G8l5d2Y9mvo_h5de3GQ_1774457136
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
> Replace all open-coded access to MCR and SCU registers in Gen4 with the
> appropriate calls to ast_moutdwm() and ast_mindwm(). Use MCR and SCU
> register constants. Name variables according to registers.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2300.c | 24 +++++++++---------------
>   drivers/gpu/drm/ast/ast_reg.h  |  1 +
>   2 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2300.c b/drivers/gpu/drm/ast/ast_2300.c
> index 96d9909d942c..cbeac6990c27 100644
> --- a/drivers/gpu/drm/ast/ast_2300.c
> +++ b/drivers/gpu/drm/ast/ast_2300.c
> @@ -1245,22 +1245,15 @@ static void ast_post_chip_2300(struct ast_device *ast)
>   
>   	reg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
>   	if ((reg & 0x80) == 0) {/* vga only */
> -		ast_write32(ast, 0xf004, AST_REG_MCR00);
> -		ast_write32(ast, 0xf000, 0x1);
> -		ast_write32(ast, 0x12000, 0x1688a8a8);
> -		do {
> -			;
> -		} while (ast_read32(ast, 0x12000) != 0x1);
> +		u32 scu008, scu040;
>   
> -		ast_write32(ast, 0x10000, 0xfc600309);
> -		do {
> -			;
> -		} while (ast_read32(ast, 0x10000) != 0x1);
> +		ast_moutdwm_poll(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY, 0x01);
> +		ast_moutdwm_poll(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY, 0x01);
>   
>   		/* Slow down CPU/AHB CLK in VGA only mode */
> -		temp = ast_read32(ast, 0x12008);
> -		temp |= 0x73;
> -		ast_write32(ast, 0x12008, temp);
> +		scu008 = ast_mindwm(ast, AST_REG_SCU008);
> +		scu008 |= 0x00000073;
> +		ast_moutdwm(ast, AST_REG_SCU008, scu008);
>   
>   		param.dram_freq = 396;
>   		param.dram_type = AST_DDR3;
> @@ -1306,8 +1299,9 @@ static void ast_post_chip_2300(struct ast_device *ast)
>   			ddr2_init(ast, &param);
>   		}
>   
> -		temp = ast_mindwm(ast, AST_REG_SCU040);
> -		ast_moutdwm(ast, AST_REG_SCU040, temp | 0x40);
> +		scu040 = ast_mindwm(ast, AST_REG_SCU040);
> +		scu040 |= 0x00000040;
> +		ast_moutdwm(ast, AST_REG_SCU040, scu040);
>   	}
>   
>   	/* wait ready */
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index 9ebdbbde9a47..c3473cad4545 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -183,6 +183,7 @@
>   #define AST_REG_SCU(__offset)			(AST_REG_SCU_BASE + (__offset))
>   #define AST_REG_SCU000				AST_REG_SCU(0x000)
>   #define AST_REG_SCU000_PROTECTION_KEY		(0x1688a8a8)
> +#define AST_REG_SCU008				AST_REG_SCU(0x008)
>   #define AST_REG_SCU00C				AST_REG_SCU(0x00c)
>   #define AST_REG_SCU020				AST_REG_SCU(0x020)
>   #define AST_REG_SCU040				AST_REG_SCU(0x040)

