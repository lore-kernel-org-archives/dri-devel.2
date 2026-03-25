Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AFB109C035
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F16810E7CF;
	Wed, 25 Mar 2026 16:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BV1AVPfW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D9A10E7CF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774454950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZalVxZgEcNNnZJt7pjfFHebrqcIrsAS/RYSEgv2xRQ=;
 b=BV1AVPfWPlgbeVsDjV7kzlO6V3nVIsXyZ4+M2uGyhjOD6+YhsVS1FPRqrGRm8NmF4WDP7D
 tbbzfDbfZeYNbkeJtb34WfwYYIEKsNvtjH5JyN2WnG8vKA8RCiE0miGlA+uBJtj5C60sbw
 TdkDQDIbx1MWTlVfn/uorR1Cpduc8hw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-rLVF9YvNOqmATvvmehjpig-1; Wed, 25 Mar 2026 12:08:09 -0400
X-MC-Unique: rLVF9YvNOqmATvvmehjpig-1
X-Mimecast-MFC-AGG-ID: rLVF9YvNOqmATvvmehjpig_1774454885
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439b3011be7so5254173f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774454885; x=1775059685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jZalVxZgEcNNnZJt7pjfFHebrqcIrsAS/RYSEgv2xRQ=;
 b=lLi73cB76a4e5UqcoFmrshSRlijRNlZ0ne6QvxgUMbZzjVRc1Sj+msa8Pvq3AOLp1Y
 sV3b8JkcprrhomLJfG8oXgCNePeUkQkgbKbmV+gKnMee5iQ5Q+isiWFdjZaWjA+4XyhF
 HzsassxZuwE+HO2tI3Ifq97jIJ8luxd8BkTk5UsXPQSKPJVyWJQZhx2+PVG3QEaOJ1ku
 NMZ5YHzLEjMvy6WIllmfHCZtbGJLCKbpY/Ec871xkh+DbyypLhT7btnw+RT8v4J3JLtD
 01Oc50VSIa4MPLFIqUUR6FJ9zlHcwNjWPL6t5dUXcpM6egJpuuiolSWO3075tmLBnJXL
 re5A==
X-Gm-Message-State: AOJu0YyRfIFXUpAtJQSjpYfzSyDhOUQujEL3vM4kM18O+Xmsjp86bzyP
 zASFXrWxRnTPMVYZquURzbu7Ozpoxn0YiLMcMQL07xJszSp6jHhDWv2ln8xviysOp/YaewYpW8u
 0dFb/g4aWq5FffXvxTvE4ld9R/ORM777djYTBVES9BXwvawNj5LZAVPkLYKf9JnUq1I5nPg==
X-Gm-Gg: ATEYQzw17h9Nn+IjG2faZFz4bIo66MTFr3jLCWu8rdAJCajR5tBkvpF4n8CoECEjf/p
 nLqNbPtt8r66GRRmwlZLsVFxsHakDABuMoNaCJ1lJ15yttpxCahvl/bq258934f2tKkVa9MuoXS
 nlIz1zhMGkYGXaLsg3Y0DGNdoBYDRUWeb9LmqXBqw0X7o4GUOw1JYGEnpn8jZcpnzEM9fvbOIvK
 SxOpCbGbbTW51qRoE9u6BJU1QZ9caV43W6fpo4S14JVo5yWKi+vuvGCOpfdfDyrqE7zonAMwqvj
 2n7cBfD4gcmvYJq+ywoJJFKiyt0RFp46GRxVK93+uHQ4gp4JM9D/LOrfaw94bJnpow0D8WyV0I2
 F9nKecxa+Iq9lnx0tOVfwKn3igoqzPlyy5gGTg6Syn9qLT1PMdu/uCW6qXe5RIg==
X-Received: by 2002:a05:6000:18a8:b0:439:b440:b8a2 with SMTP id
 ffacd0b85a97d-43b88a0d156mr5892955f8f.28.1774454884605; 
 Wed, 25 Mar 2026 09:08:04 -0700 (PDT)
X-Received: by 2002:a05:6000:18a8:b0:439:b440:b8a2 with SMTP id
 ffacd0b85a97d-43b88a0d156mr5892908f8f.28.1774454883992; 
 Wed, 25 Mar 2026 09:08:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91942f24sm940224f8f.11.2026.03.25.09.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:08:03 -0700 (PDT)
Message-ID: <e6c0838f-66f0-4e2a-a8b4-067267619ea9@redhat.com>
Date: Wed, 25 Mar 2026 17:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] drm/ast: Use constants for A2P registers
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-7-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-7-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PzKlCXkZYxpwQqjZ5QZtF8uV4a2HTqou4Qeuiu5cjIA_1774454885
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
> A2P is the AHB-to-P Bridge. A2P registers are located at the memory
> range at [0x1e720000, 0x1e73ffff]. Refer to them with constants named
> AST_REG_A2P<n>, where <n> is the byte offset into the range.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2300.c | 6 +++---
>   drivers/gpu/drm/ast/ast_reg.h  | 8 ++++++++
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2300.c b/drivers/gpu/drm/ast/ast_2300.c
> index 1fe947178124..96d9909d942c 100644
> --- a/drivers/gpu/drm/ast/ast_2300.c
> +++ b/drivers/gpu/drm/ast/ast_2300.c
> @@ -508,7 +508,7 @@ static bool cbr_dll2(struct ast_device *ast, struct ast2300_dram_param *param)
>   	dlli  = (dllmin[1] + dllmax[1]) >> 1;
>   	dlli <<= 8;
>   	dlli += (dllmin[0] + dllmax[0]) >> 1;
> -	ast_moutdwm(ast, AST_REG_MCR68, ast_mindwm(ast, 0x1E720058) | (dlli << 16));
> +	ast_moutdwm(ast, AST_REG_MCR68, ast_mindwm(ast, AST_REG_A2P58) | (dlli << 16));
>   	return status;
>   } /* CBRDLL2 */
>   
> @@ -826,7 +826,7 @@ static void ddr3_init(struct ast_device *ast, struct ast2300_dram_param *param)
>   		data = ast_mindwm(ast, AST_REG_MCR1C);
>   		data = (data >> 8) & 0xff;
>   	}
> -	ast_moutdwm(ast, 0x1E720058, ast_mindwm(ast, AST_REG_MCR68) & 0xffff);
> +	ast_moutdwm(ast, AST_REG_A2P58, ast_mindwm(ast, AST_REG_MCR68) & 0xffff);
>   	data = ast_mindwm(ast, AST_REG_MCR18) | 0xC00;
>   	ast_moutdwm(ast, AST_REG_MCR18, data);
>   
> @@ -1188,7 +1188,7 @@ static void ddr2_init(struct ast_device *ast, struct ast2300_dram_param *param)
>   		data = ast_mindwm(ast, AST_REG_MCR1C);
>   		data = (data >> 8) & 0xff;
>   	}
> -	ast_moutdwm(ast, 0x1E720058, ast_mindwm(ast, AST_REG_MCR08) & 0xffff);
> +	ast_moutdwm(ast, AST_REG_A2P58, ast_mindwm(ast, AST_REG_MCR08) & 0xffff);
>   	data = ast_mindwm(ast, AST_REG_MCR18) | 0xC00;
>   	ast_moutdwm(ast, AST_REG_MCR18, data);
>   
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index e8d4991186ca..730072a3c2cd 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -188,4 +188,12 @@
>   #define AST_REG_SCU104				AST_REG_SCU(0x104)
>   #define AST_REG_SCU160				AST_REG_SCU(0x160)
>   
> +/*
> + * AHB-to-P Bus Bridge (0x1e720000 - 0x1e73ffff)
> + */
> +
> +#define AST_REG_A2P_BASE			(0x1e720000)
> +#define AST_REG_A2P(__offset)			(AST_REG_A2P_BASE + (__offset))
> +#define AST_REG_A2P58				AST_REG_A2P(0x58)
> +
>   #endif

