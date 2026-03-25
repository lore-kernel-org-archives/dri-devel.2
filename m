Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB43109C02F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0777110E7C0;
	Wed, 25 Mar 2026 15:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SI7E6yVi";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95EA710E7BF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774453601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOkuli1V66TlYt7wtz1wcGow4tJIkXgsXWRQ1X6HJDM=;
 b=SI7E6yVidgwuWTA/H3tFvGPYj1EzF0vqm5tk8M1qGlgnZ6FE2d5M39hwk1Vzd+jGnpObEq
 ElRg4C1Bs6uUQlCn/QvNU4xPOYUwtp4IE6pnp5Vo1K37V104aF7SQwXrj9mmet8Bu6B1kr
 JXIAEkfalRkm0ON9h99ZtD8yZhCjoiE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-grTAJGJMM-iSXZRud_OUQw-1; Wed, 25 Mar 2026 11:46:39 -0400
X-MC-Unique: grTAJGJMM-iSXZRud_OUQw-1
X-Mimecast-MFC-AGG-ID: grTAJGJMM-iSXZRud_OUQw_1774453598
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48553fdd03dso37185e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774453598; x=1775058398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aOkuli1V66TlYt7wtz1wcGow4tJIkXgsXWRQ1X6HJDM=;
 b=oNpKCWEDfHKfGE+bTqKMagOVCX+3QwZXTEK5/MqkB4GbJW8NvR8RGCrcGu6wuHVpUv
 4A3JM9OHuck8yCSyawmLdkySr+RiYRKX6u3ip1sjkMdWwgdEVkAEo4cyoLcN1Hp4Knz3
 I4ugKYwRfuq634BIUq9Y5p2+d5GZCVx+Tg5vlrIlE9fw/bYxLXNA6jF9oR7D4llhyWWt
 v+7tM3TbeFqcbfNNdEFh65t1tewU0d4JWp6e5FaZ2c+SpnVT9FKZJhsCCbo3GydplV21
 830lrjbWz3WpFKeactUcJxwq4brz9sCCPoptxzatG2iqY+OLMMbl6jXdAiQU9bdXKJQU
 Acng==
X-Gm-Message-State: AOJu0YwXQgx3O3KQkrCvPeKNb7ZXN64bMjDnKmdz5RetTtJBE2YMN3li
 evU4SqPNkXquNcUyl4Ci775QdbLlJap2LsclT4eFH777SpDcIjuEIn6mzqwsd7fBukP+3sxiZQX
 7dIOos2PtquNQIgK39Gg55bLss64MtYjgkGiwW12i4ceebOxm1E6zm/GfYTr/DJ5pa4V/7Q==
X-Gm-Gg: ATEYQzyJqZzQv6YiPAWtq95bgD6cv/LgIWYCJv65dMho2gUBVU6dTBdi18nB9sG1k80
 nvxExsWfXDp6InvdqIdHLS6oaBDAhotQ0ZjIHZ8n5hORSu7jFzSdoQxjn5fiA4C2sKxsp+0H1Xw
 U0/fwxS2Ys84sAEXKWaGHblE4RNGdz64hhHuS30Yus4h2EsjTdEecECbTCSzUqUlneq6ckcR0/o
 XyqZ7x7Ph+LKa4+9EXbGbiLSZwh1lGl752Sp06fL8g5OrEG1V5i+VeABFCEg5sUqjl6e+Io/wjd
 x5rUfJwVbF6gXTiuvm+TDrHIbbu0+4VDpGR+KmkaPnIqNHMVOF4FRQs5EeSsEjpsmTUx/aqRJve
 6fcdGwURMxvi5qzpD/N3jtuSkBW6n4l3c7PF8t4KrRaAfmxenoZ1BpO5QT8px8A==
X-Received: by 2002:a05:600c:3491:b0:486:d76c:fa21 with SMTP id
 5b1f17b1804b1-48715ff3539mr58253535e9.12.1774453598202; 
 Wed, 25 Mar 2026 08:46:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3491:b0:486:d76c:fa21 with SMTP id
 5b1f17b1804b1-48715ff3539mr58253045e9.12.1774453597651; 
 Wed, 25 Mar 2026 08:46:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116f17f3sm134165045e9.1.2026.03.25.08.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 08:46:37 -0700 (PDT)
Message-ID: <6b033e90-e93b-41ca-8213-ee0dd8097100@redhat.com>
Date: Wed, 25 Mar 2026 16:46:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] drm/ast: Move 32-bit register-access helpers to
 ast_drv.{c,h}
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-3-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-3-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZrceJs9iD9eue1kuaCUge5Dt549xcqTxsFPv5PHH20o_1774453598
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
> The helpers ast_mindwm() and ast_moutdwm() access the I/O memory of
> the various IP modules on the Aspeed device. This is based on the
> "P-Bus to AHB Bridge" interface.
> 
> Reimplement the access function with properly defined constants and
> helper macros.
> 
> - Define P2A constants for the related registers and addresses. The P2A
> interface is located in the memory range at [0x00000000, 0x00010000].
> 
> - Memory access is segmented. An address' upper 16-bit select the
> memory segment, the lower 16-bit select the offset within the segment.
> Implement segment selection in a shared helper __ast_segsel(). Validate
> that the segment hs been changes. This logic has previously been part
> of __ast_moudwm() and __ast_mindwm(). Relax the CPU while busy-waiting.
> 
> - Put intra-segment reads and writes in the helpers __ast_rdseg32()
> and __ast_wrseg32(). The helpers set the segment offset automatically.
> 
> - Reimplement the existing interfaces on put of these helpers.

Typo, I think it should be "on top of"
> 
> Put the new implementation next to the other I/O helpers.

It looks good to me, with the typo fixed:

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_drv.c  | 59 ++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/ast/ast_drv.h  | 59 +++++++++++++++++++++-------------
>   drivers/gpu/drm/ast/ast_post.c | 38 ----------------------
>   drivers/gpu/drm/ast/ast_post.h |  3 --
>   drivers/gpu/drm/ast/ast_reg.h  | 12 +++++++
>   5 files changed, 108 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> index b9a9b050b546..05ec3542ab62 100644
> --- a/drivers/gpu/drm/ast/ast_drv.c
> +++ b/drivers/gpu/drm/ast/ast_drv.c
> @@ -47,6 +47,65 @@ static int ast_modeset = -1;
>   MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
>   module_param_named(modeset, ast_modeset, int, 0400);
>   
> +/*
> + * Register access
> + */
> +
> +/* Select R/W segment */
> +static void __ast_selseg(void __iomem *regs, u32 r)
> +{
> +	u32 p2a04, p2a04_base;
> +
> +	p2a04 = r & AST_REG_P2A04_BASE_MASK;
> +	__ast_write32(regs, AST_REG_P2A04, p2a04);
> +	__ast_write32(regs, AST_REG_P2A00, AST_REG_P2A00_PROTECTION_KEY);
> +
> +	do {
> +		cpu_relax();
> +		p2a04_base = __ast_read32(regs, AST_REG_P2A04);
> +		p2a04_base &= AST_REG_P2A04_BASE_MASK;
> +	} while (p2a04_base != p2a04);
> +}
> +
> +/* Read within segment */
> +static u32 __ast_rdseg32(void __iomem *regs, u32 r)
> +{
> +	return __ast_read32(regs, AST_REG_P2A_ADDR(r));
> +}
> +
> +/* Write within segment */
> +static void __ast_wrseg32(void __iomem *regs, u32 r, u32 v)
> +{
> +	__ast_write32(regs, AST_REG_P2A_ADDR(r), v);
> +}
> +
> +u32 __ast_mindwm(void __iomem *regs, u32 r)
> +{
> +	__ast_selseg(regs, r);
> +
> +	return __ast_rdseg32(regs, r);
> +}
> +
> +void __ast_moutdwm(void __iomem *regs, u32 r, u32 v)
> +{
> +	__ast_selseg(regs, r);
> +	__ast_wrseg32(regs, r, v);
> +}
> +
> +u32 ast_mindwm(struct ast_device *ast, u32 r)
> +{
> +	return __ast_mindwm(ast->regs, r);
> +}
> +
> +void ast_moutdwm(struct ast_device *ast, u32 r, u32 v)
> +{
> +	__ast_moutdwm(ast->regs, r, v);
> +}
> +
> +/*
> + * AST device
> + */
> +
>   void ast_device_init(struct ast_device *ast,
>   		     enum ast_chip chip,
>   		     enum ast_config_mode config_mode,
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index 787e38c6c17d..3eedf8239333 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -259,26 +259,20 @@ static inline bool __ast_gen_is_eq(struct ast_device *ast, unsigned long gen)
>   #define IS_AST_GEN6(__ast)	__ast_gen_is_eq(__ast, 6)
>   #define IS_AST_GEN7(__ast)	__ast_gen_is_eq(__ast, 7)
>   
> +/*
> + * MMIO access
> + */
> +
>   static inline u8 __ast_read8(const void __iomem *addr, u32 reg)
>   {
>   	return ioread8(addr + reg);
>   }
>   
> -static inline u32 __ast_read32(const void __iomem *addr, u32 reg)
> -{
> -	return ioread32(addr + reg);
> -}
> -
>   static inline void __ast_write8(void __iomem *addr, u32 reg, u8 val)
>   {
>   	iowrite8(val, addr + reg);
>   }
>   
> -static inline void __ast_write32(void __iomem *addr, u32 reg, u32 val)
> -{
> -	iowrite32(val, addr + reg);
> -}
> -
>   static inline u8 __ast_read8_i(void __iomem *addr, u32 reg, u8 index)
>   {
>   	__ast_write8(addr, reg, index);
> @@ -307,16 +301,6 @@ static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index,
>   	__ast_write8_i(addr, reg, index, tmp | val);
>   }
>   
> -static inline u32 ast_read32(struct ast_device *ast, u32 reg)
> -{
> -	return __ast_read32(ast->regs, reg);
> -}
> -
> -static inline void ast_write32(struct ast_device *ast, u32 reg, u32 val)
> -{
> -	__ast_write32(ast->regs, reg, val);
> -}
> -
>   static inline u8 ast_io_read8(struct ast_device *ast, u32 reg)
>   {
>   	return __ast_read8(ast->ioregs, reg);
> @@ -349,6 +333,39 @@ static inline void ast_set_index_reg_mask(struct ast_device *ast, u32 base, u8 i
>   	__ast_write8_i_masked(ast->ioregs, base, index, preserve_mask, val);
>   }
>   
> +/*
> + * Register access
> + */
> +
> +static inline u32 __ast_read32(const void __iomem *addr, u32 reg)
> +{
> +	return ioread32(addr + reg);
> +}
> +
> +static inline void __ast_write32(void __iomem *addr, u32 reg, u32 val)
> +{
> +	iowrite32(val, addr + reg);
> +}
> +
> +static inline u32 ast_read32(struct ast_device *ast, u32 reg)
> +{
> +	return __ast_read32(ast->regs, reg);
> +}
> +
> +static inline void ast_write32(struct ast_device *ast, u32 reg, u32 val)
> +{
> +	__ast_write32(ast->regs, reg, val);
> +}
> +
> +u32 __ast_mindwm(void __iomem *regs, u32 r);
> +void __ast_moutdwm(void __iomem *regs, u32 r, u32 v);
> +u32 ast_mindwm(struct ast_device *ast, u32 r);
> +void ast_moutdwm(struct ast_device *ast, u32 r, u32 v);
> +
> +/*
> + * VBIOS
> + */
> +
>   struct ast_vbios_stdtable {
>   	u8 misc;
>   	u8 seq[4];
> @@ -517,8 +534,6 @@ struct drm_device *ast_2600_device_create(struct pci_dev *pdev,
>   
>   /* ast post */
>   int ast_post_gpu(struct ast_device *ast);
> -u32 ast_mindwm(struct ast_device *ast, u32 r);
> -void ast_moutdwm(struct ast_device *ast, u32 r, u32 v);
>   
>   int ast_vga_output_init(struct ast_device *ast);
>   int ast_sil164_output_init(struct ast_device *ast);
> diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
> index b72914dbed38..5cec5d735b6a 100644
> --- a/drivers/gpu/drm/ast/ast_post.c
> +++ b/drivers/gpu/drm/ast/ast_post.c
> @@ -34,44 +34,6 @@
>   #include "ast_drv.h"
>   #include "ast_post.h"
>   
> -u32 __ast_mindwm(void __iomem *regs, u32 r)
> -{
> -	u32 data;
> -
> -	__ast_write32(regs, 0xf004, r & 0xffff0000);
> -	__ast_write32(regs, 0xf000, 0x1);
> -
> -	do {
> -		data = __ast_read32(regs, 0xf004) & 0xffff0000;
> -	} while (data != (r & 0xffff0000));
> -
> -	return __ast_read32(regs, 0x10000 + (r & 0x0000ffff));
> -}
> -
> -void __ast_moutdwm(void __iomem *regs, u32 r, u32 v)
> -{
> -	u32 data;
> -
> -	__ast_write32(regs, 0xf004, r & 0xffff0000);
> -	__ast_write32(regs, 0xf000, 0x1);
> -
> -	do {
> -		data = __ast_read32(regs, 0xf004) & 0xffff0000;
> -	} while (data != (r & 0xffff0000));
> -
> -	__ast_write32(regs, 0x10000 + (r & 0x0000ffff), v);
> -}
> -
> -u32 ast_mindwm(struct ast_device *ast, u32 r)
> -{
> -	return __ast_mindwm(ast->regs, r);
> -}
> -
> -void ast_moutdwm(struct ast_device *ast, u32 r, u32 v)
> -{
> -	__ast_moutdwm(ast->regs, r, v);
> -}
> -
>   int ast_post_gpu(struct ast_device *ast)
>   {
>   	int ret;
> diff --git a/drivers/gpu/drm/ast/ast_post.h b/drivers/gpu/drm/ast/ast_post.h
> index aa5d247bebe8..41cd753b7f67 100644
> --- a/drivers/gpu/drm/ast/ast_post.h
> +++ b/drivers/gpu/drm/ast/ast_post.h
> @@ -35,9 +35,6 @@ struct ast_dramstruct {
>   #define AST_DRAMSTRUCT_IS(_entry, _name) \
>   	((_entry)->index == __AST_DRAMSTRUCT_INDEX(_name))
>   
> -u32 __ast_mindwm(void __iomem *regs, u32 r);
> -void __ast_moutdwm(void __iomem *regs, u32 r, u32 v);
> -
>   bool mmc_test(struct ast_device *ast, u32 datagen, u8 test_ctl);
>   bool mmc_test_burst(struct ast_device *ast, u32 datagen);
>   
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index 30578e3b07e4..ca9403efc7f9 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -75,4 +75,16 @@
>   #define AST_IO_VGAIR1_R			(0x5A)
>   #define AST_IO_VGAIR1_VREFRESH		BIT(3)
>   
> +/*
> + * P-Bus to AHB Bridge (0x00000000 - 0x0001ffff)
> + */
> +
> +#define AST_REG_P2A_BASE			(0x00000000)
> +#define AST_REG_P2A(__offset)			(AST_REG_P2A_BASE + (__offset))
> +#define AST_REG_P2A_ADDR(__addr)		AST_REG_P2A(0x10000 + ((__addr) & GENMASK(15, 0)))
> +#define AST_REG_P2A00				AST_REG_P2A(0xf000)
> +#define AST_REG_P2A00_PROTECTION_KEY		(0x01)
> +#define AST_REG_P2A04				AST_REG_P2A(0xf004)
> +#define AST_REG_P2A04_BASE_MASK			GENMASK(31, 16)
> +
>   #endif

