Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ACB109C034
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3C110E7C1;
	Wed, 25 Mar 2026 16:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JSsVgUo8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A8B10E7C1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774454596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7YTN0U467v0LmIV7PQRx2ZHLb0DAYJ6x0QN5nDodG8=;
 b=JSsVgUo8KkPLB+6ELj/A2IvYyP+SIJyycaOwJmA1OPflwOpW8MzKdS32WJGPh7G8qWx/Gy
 z1nyJGjJcFagaQe2ctHni/KBaA3ZgQlU3dad/fa1FclEkp24efjrpAW/orc2JYRxuLlCDj
 sjE1NEuyjJT8Ryq57ICHoyHlzl09Ko0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-W3eE-9EGPxmDR_1FcndXVA-1; Wed, 25 Mar 2026 12:03:14 -0400
X-MC-Unique: W3eE-9EGPxmDR_1FcndXVA-1
X-Mimecast-MFC-AGG-ID: W3eE-9EGPxmDR_1FcndXVA_1774454593
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so14233925e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774454593; x=1775059393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7YTN0U467v0LmIV7PQRx2ZHLb0DAYJ6x0QN5nDodG8=;
 b=hcxbhk4qn+6pcw7TNMOlSUsK7lXUhtIjybt3EibWnvW7XoZcCMZ8leu3GjxjFG+fN7
 Ltd3cQE70lDlop85hsmHKQSjZWg2ifJLWwpiB4qOz/PYF9Se1yWljqHkCznnzxI0wiBo
 mMuZVUfK4Er/zd4I6dQA6BWdnzqo8rhj5wUsX2n6TAlhK7jcvizKQ2pgaGdG4ZRUc3mt
 fpmHNvRB6zY0C/aKb5GudUQiPsth5NWJ45tw/p9ANuMj5f3N5aGyUEliUufTFuz2EL/W
 0AII+nLcTKps6jvRPGgL/WyAz+g1zPsWcHmek2bZjpAcqTXy2OUBcxFC8BcBy9cxy1Mo
 dCeQ==
X-Gm-Message-State: AOJu0YylULWm3tIhEJ3c1RfksqjZYxZD6EzdrQocU5CzYTE18A/FTEnV
 CblfM/4FK+cnsfYATZhGkanfnCXhAsp060PfHc0C51ErEzZnf2hkNUgJWuvDNBn5oxr0NwWxmX2
 wdmHAYkWT6GgSamEekdBcE71vioPAamfz2gtVTAko70pYwldZx3K+IgN2mWMXefzp0HVW3g==
X-Gm-Gg: ATEYQzwBt7KXClVxesd36n91JSvA0yH34wIcsIig6TMs2E0x7RETnVVKQw1RT3BR8CW
 GqwMT2/8dCHykWTECO7tJy9eTQqfg2CDY1K2OdTq+QMbqe5SJDRr+Ic1bzkIjwpoHmTuWecAphS
 Z0cP8lJ3GoR8Xjb0XZnFRN/odt9Z59X3ai3snvZfKnfgNHgnvxIMy8/TuXouNDXGLvFYp5sLR7S
 SQgHDSsQLDqTeVW9vcjU3D7tsefNpK9DpPcLSH2JfIUafkqGxtBPvGy+X4ltyRvaW//E3deyP1W
 qdtOD7/fumkKUcp4ZQEZ6qOlNVBdcPeKomelHJAhuPFA2hznePdxkj+cUxFak2DIcTVBVkAITeq
 BzblSK/c56s72dSaYj5eQI+VjQZbBTcpaFOL47AVaC2AdT1HCfFrV/9Z8fH6x7w==
X-Received: by 2002:a05:600c:6b4b:b0:485:4f11:aabc with SMTP id
 5b1f17b1804b1-4870f22f189mr80492955e9.15.1774454592966; 
 Wed, 25 Mar 2026 09:03:12 -0700 (PDT)
X-Received: by 2002:a05:600c:6b4b:b0:485:4f11:aabc with SMTP id
 5b1f17b1804b1-4870f22f189mr80491985e9.15.1774454592178; 
 Wed, 25 Mar 2026 09:03:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df6d4sm617792f8f.25.2026.03.25.09.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:03:11 -0700 (PDT)
Message-ID: <a5b1cc89-8d52-4f4b-93f6-a3429e49d281@redhat.com>
Date: Wed, 25 Mar 2026 17:03:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] drm/ast: Use constants for AHBC registers
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BCEDOqxC9_1ZHyoqDpTRaV5UDKE26ND3pZnocOgMd7o_1774454593
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
> AHBC is the Advanced High-Speed Bus Controller. AHBC registers are
> located in the memory range within [0x1e600000, 0x1e61ffff]. Refer
> to them with constants named AST_REG_AHBC<n>, where <n> is the byte
> offset into the range.

I think adding a macro AST_REG_AHBC84 doesn't provide more information 
over using directly AST_REG_AHBC(0x84).

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2500.c |  6 +++---
>   drivers/gpu/drm/ast/ast_reg.h  | 11 +++++++++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
> index 2a52af0ded56..f751a27e7eb3 100644
> --- a/drivers/gpu/drm/ast/ast_2500.c
> +++ b/drivers/gpu/drm/ast/ast_2500.c
> @@ -109,9 +109,9 @@ void ast_2500_patch_ahb(void __iomem *regs)
>   	u32 data;
>   
>   	/* Clear bus lock condition */
> -	__ast_moutdwm(regs, 0x1e600000, 0xAEED1A03);
> -	__ast_moutdwm(regs, 0x1e600084, 0x00010000);
> -	__ast_moutdwm(regs, 0x1e600088, 0x00000000);
> +	__ast_moutdwm(regs, AST_REG_AHBC00, AST_REG_AHBC00_PROTECT_KEY);
> +	__ast_moutdwm(regs, AST_REG_AHBC84, 0x00010000);
> +	__ast_moutdwm(regs, AST_REG_AHBC88, 0x00000000);
>   	__ast_moutdwm(regs, 0x1e6e2000, 0x1688A8A8);
>   
>   	data = __ast_mindwm(regs, 0x1e6e2070);
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index ca9403efc7f9..0bc033dbac55 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -87,4 +87,15 @@
>   #define AST_REG_P2A04				AST_REG_P2A(0xf004)
>   #define AST_REG_P2A04_BASE_MASK			GENMASK(31, 16)
>   
> +/*
> + * AHB Controller (0x1e600000 - 0x1e61ffff)
> + */
> +
> +#define AST_REG_AHBC_BASE			(0x1e600000)
> +#define AST_REG_AHBC(__offset)			(AST_REG_AHBC_BASE + (__offset))
> +#define AST_REG_AHBC00				AST_REG_AHBC(0x00)
> +#define AST_REG_AHBC00_PROTECT_KEY		(0xaeed1a03)
> +#define AST_REG_AHBC84				AST_REG_AHBC(0x84)
> +#define AST_REG_AHBC88				AST_REG_AHBC(0x88)
> +
>   #endif

