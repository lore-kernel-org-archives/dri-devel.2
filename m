Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177E3109C03E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740E510E158;
	Wed, 25 Mar 2026 16:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SHAbF07B";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9631610E158
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774456751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oG4PqbbruPpYziR89xrK1ah/DdgRwB8VP/ojpA4rGqI=;
 b=SHAbF07B46zl87uar22LqpQ+sn7vFeBxMaHEXdlP1va8/ZRuk9LpI+EkzlrWirjd5sEL47
 kuYK8p2htOEb7hZNWopHX7fhWVr9B5W1orA51o03IaG/ztS8OUoi9/wQ6P9mCNErje9UW/
 +0RdVCGqK1ln+LBCQCqYh9kP4MsG578=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-UH1wmq_6M_u695akhyvXsg-1; Wed, 25 Mar 2026 12:39:07 -0400
X-MC-Unique: UH1wmq_6M_u695akhyvXsg-1
X-Mimecast-MFC-AGG-ID: UH1wmq_6M_u695akhyvXsg_1774456747
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b8ac8da30so1170872f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774456746; x=1775061546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oG4PqbbruPpYziR89xrK1ah/DdgRwB8VP/ojpA4rGqI=;
 b=j4F+rCojcGsrjHGQZ7zYUeU981JUmg94V3u+EsURnscRkViNN0N3me40trfYLRCBRC
 3x0TaXeFVAnVas26FLGm50nbB82YPaTCf1c3OHQ63kZ4oxDb0KFn7U6fOhVWDzMqMDoa
 tt3Kx8hZjlxluI0zxLcgUsiMlOrbJsqNeeozSbmSIGhCBV4lswaK/eEbExfM2bZVwus4
 OMe9IZGqXc4NjA6tR80pDnytpcgXMvNE4MJsKclUf33OLcP9YXrkHewVDceKVW0VnTUN
 fLp7PLfUQUXZg9VrJONoo1kcGFVtfiV8A9qto9s8EVkjHXyWnPmFeNT3jbTVCmOPoUeS
 VRiw==
X-Gm-Message-State: AOJu0YxTU64ybzJ2l32peVlnZf3CidR/O2mSHVsMD57Ls8e7zU39X0p8
 8erGVexDzCDDLRU7S7/Zm1MjLn6yBw84dn6/ImE/A20diwliSm4MppEK0kJUgp/Ltq3NDbpdzR3
 GL+Q1YQu1IFVW5na8IoGmbFynCxX3JTo88RGEvesgpkaiX62yO6ucf18Nfl/jPb6tbkRNOQ==
X-Gm-Gg: ATEYQzxVxXQ2aksXDuTUA5YRKIwHAD20fnafmp9HJ6Jys3+YFAofqUuDdxk4kzRrpzr
 EjlkfMFWjfoA4UAtA20FgZWr9Ppj4IijTo5t+t1krUx9BY5nBsL9oCO9W1WuRDovsJrzTROUCod
 wFhDnnobYNuD2C2H22IVWmL8bVcatvjhMPyBkotX0SVnrv4JVhl2vSjveis6rjSBD32JlFtIiKG
 z/lchljiWdJrjWDV0Gr6h0D/GrpXSggPTWNUop5uAvbSQ1fKkMiN4wAyjPVumqVxgJTzmoqf5WQ
 PHqrIiwS5icEDFXY5ioaRXKpgc4xgCNMTgfTDwSBk2wM6hl++l+5OtR21EbD+HPvqmfUU+J6RyD
 p1ek8EuoU1fYFIY4uOl3IJP3sYw0xZ8LomSJ2ySFTj6MYDvLnDVQCr03u0GxSng==
X-Received: by 2002:a05:6000:2406:b0:43b:87d9:af18 with SMTP id
 ffacd0b85a97d-43b88a217cemr6503151f8f.35.1774456746432; 
 Wed, 25 Mar 2026 09:39:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2406:b0:43b:87d9:af18 with SMTP id
 ffacd0b85a97d-43b88a217cemr6503102f8f.35.1774456745865; 
 Wed, 25 Mar 2026 09:39:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919432f0sm1070324f8f.13.2026.03.25.09.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:39:05 -0700 (PDT)
Message-ID: <eb849fe9-b328-405b-9df5-8bdf26e1ac75@redhat.com>
Date: Wed, 25 Mar 2026 17:39:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] drm/ast: Store register addresses in struct
 ast_dramstruct
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-10-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-10-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sjNDlDSJIaiOQEMsS25vgiDne_BpW5gPjjM3chA1RLQ_1774456747
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
> Struct ast_dramstruct contains a 16-bit index field that either
> contains a magic value or serves as index into the P2A address
> segment at 0x1e600000. This segment serves MCR and SCU registers,
> which the ast_dramstruct programs. It's fragile and relies upon
> the ast_post_chip_*() functions to set up the segment correctly.
> 
> Replace the 16-bit index with a full 32-bit address of the SCU
> and MCR addresses. Initialize the DRAM tables with full register
> constants and write them out with ast_moutdwm(). This sets the
> correct segment on each write.
> 
> Drop __AST_DRAMSTRUCT_DRAM_TYPE as it simply referred to MCR04.
> Use the latter for initializing the DRAM tables.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2000.c |  43 ++++----
>   drivers/gpu/drm/ast/ast_2100.c | 195 ++++++++++++++++-----------------
>   drivers/gpu/drm/ast/ast_post.h |  17 +--
>   drivers/gpu/drm/ast/ast_reg.h  |   4 +
>   4 files changed, 131 insertions(+), 128 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2000.c b/drivers/gpu/drm/ast/ast_2000.c
> index 204646bb1fa0..e683edf595e2 100644
> --- a/drivers/gpu/drm/ast/ast_2000.c
> +++ b/drivers/gpu/drm/ast/ast_2000.c
> @@ -69,30 +69,30 @@ void ast_2000_set_def_ext_reg(struct ast_device *ast)
>   }
>   
>   static const struct ast_dramstruct ast2000_dram_table_data[] = {
> -	{ 0x0108, 0x00000000 },
> -	{ 0x0120, 0x00004a21 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR108, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR120, 0x00004a21),
>   	AST_DRAMSTRUCT_UDELAY(67u),
> -	{ 0x0000, 0xFFFFFFFF },
> -	AST_DRAMSTRUCT_INIT(DRAM_TYPE, 0x00000089),
> -	{ 0x0008, 0x22331353 },
> -	{ 0x000C, 0x0d07000b },
> -	{ 0x0010, 0x11113333 },
> -	{ 0x0020, 0x00110350 },
> -	{ 0x0028, 0x1e0828f0 },
> -	{ 0x0024, 0x00000001 },
> -	{ 0x001C, 0x00000000 },
> -	{ 0x0014, 0x00000003 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR00, 0xffffffff), /* FIXME: This locks the MCR registers. */
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR04, 0x00000089), /* DRAM type */
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR08, 0x22331353),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR0C, 0x0d07000b),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR10, 0x11113333),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR20, 0x00110350),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x1e0828f0),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR24, 0x00000001),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR1C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR14, 0x00000003),
>   	AST_DRAMSTRUCT_UDELAY(67u),
> -	{ 0x0018, 0x00000131 },
> -	{ 0x0014, 0x00000001 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR18, 0x00000131),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR14, 0x00000001),
>   	AST_DRAMSTRUCT_UDELAY(67u),
> -	{ 0x0018, 0x00000031 },
> -	{ 0x0014, 0x00000001 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR18, 0x00000031),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR14, 0x00000001),
>   	AST_DRAMSTRUCT_UDELAY(67u),
> -	{ 0x0028, 0x1e0828f1 },
> -	{ 0x0024, 0x00000003 },
> -	{ 0x002C, 0x1f0f28fb },
> -	{ 0x0030, 0xFFFFFE01 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x1e0828f1),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR24, 0x00000003),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR2C, 0x1f0f28fb),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR30, 0xfffffe01),
>   	AST_DRAMSTRUCT_INVALID,
>   };
>   
> @@ -119,8 +119,7 @@ static void ast_post_chip_2000(struct ast_device *ast)
>   				for (i = 0; i < 15; i++)
>   					udelay(dram_reg_info->data);
>   			} else {
> -				ast_write32(ast, 0x10000 + dram_reg_info->index,
> -					    dram_reg_info->data);
> +				ast_moutdwm(ast, dram_reg_info->index, dram_reg_info->data);
>   			}
>   			dram_reg_info++;
>   		}
> diff --git a/drivers/gpu/drm/ast/ast_2100.c b/drivers/gpu/drm/ast/ast_2100.c
> index 28cd36571b7f..930e9f2d0ccf 100644
> --- a/drivers/gpu/drm/ast/ast_2100.c
> +++ b/drivers/gpu/drm/ast/ast_2100.c
> @@ -72,108 +72,108 @@ static enum ast_dram_layout ast_2100_get_dram_layout_p2a(struct ast_device *ast)
>    */
>   
>   static const struct ast_dramstruct ast1100_dram_table_data[] = {
> -	{ 0x2000, 0x1688a8a8 },
> -	{ 0x2020, 0x000041f0 },
> +	AST_DRAMSTRUCT_REG(AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY),
> +	AST_DRAMSTRUCT_REG(AST_REG_SCU020, 0x000041f0),
>   	AST_DRAMSTRUCT_UDELAY(67u),
> -	{ 0x0000, 0xfc600309 },
> -	{ 0x006C, 0x00909090 },
> -	{ 0x0064, 0x00050000 },
> -	AST_DRAMSTRUCT_INIT(DRAM_TYPE, 0x00000585),
> -	{ 0x0008, 0x0011030f },
> -	{ 0x0010, 0x22201724 },
> -	{ 0x0018, 0x1e29011a },
> -	{ 0x0020, 0x00c82222 },
> -	{ 0x0014, 0x01001523 },
> -	{ 0x001C, 0x1024010d },
> -	{ 0x0024, 0x00cb2522 },
> -	{ 0x0038, 0xffffff82 },
> -	{ 0x003C, 0x00000000 },
> -	{ 0x0040, 0x00000000 },
> -	{ 0x0044, 0x00000000 },
> -	{ 0x0048, 0x00000000 },
> -	{ 0x004C, 0x00000000 },
> -	{ 0x0050, 0x00000000 },
> -	{ 0x0054, 0x00000000 },
> -	{ 0x0058, 0x00000000 },
> -	{ 0x005C, 0x00000000 },
> -	{ 0x0060, 0x032aa02a },
> -	{ 0x0064, 0x002d3000 },
> -	{ 0x0068, 0x00000000 },
> -	{ 0x0070, 0x00000000 },
> -	{ 0x0074, 0x00000000 },
> -	{ 0x0078, 0x00000000 },
> -	{ 0x007C, 0x00000000 },
> -	{ 0x0034, 0x00000001 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR6C, 0x00909090),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR64, 0x00050000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR04, 0x00000585), // DRAM type
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR08, 0x0011030f),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR10, 0x22201724),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR18, 0x1e29011a),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR20, 0x00c82222),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR14, 0x01001523),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR1C, 0x1024010d),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR24, 0x00cb2522),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR38, 0xffffff82),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR3C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR40, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR44, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR48, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR4C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR50, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR54, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR58, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR5C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR60, 0x032aa02a),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR64, 0x002d3000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR68, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR70, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR74, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR78, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR7C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR34, 0x00000001),
>   	AST_DRAMSTRUCT_UDELAY(67u),
> -	{ 0x002C, 0x00000732 },
> -	{ 0x0030, 0x00000040 },
> -	{ 0x0028, 0x00000005 },
> -	{ 0x0028, 0x00000007 },
> -	{ 0x0028, 0x00000003 },
> -	{ 0x0028, 0x00000001 },
> -	{ 0x000C, 0x00005a08 },
> -	{ 0x002C, 0x00000632 },
> -	{ 0x0028, 0x00000001 },
> -	{ 0x0030, 0x000003c0 },
> -	{ 0x0028, 0x00000003 },
> -	{ 0x0030, 0x00000040 },
> -	{ 0x0028, 0x00000003 },
> -	{ 0x000C, 0x00005a21 },
> -	{ 0x0034, 0x00007c03 },
> -	{ 0x0120, 0x00004c41 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR2C, 0x00000732),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR30, 0x00000040),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000005),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000007),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000003),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000001),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR0C, 0x00005a08),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR2C, 0x00000632),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000001),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR30, 0x000003c0),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000003),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR30, 0x00000040),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000003),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR0C, 0x00005a21),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR34, 0x00007c03),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR120, 0x00004c41),
>   	AST_DRAMSTRUCT_INVALID,
>   };
>   
>   static const struct ast_dramstruct ast2100_dram_table_data[] = {
> -	{ 0x2000, 0x1688a8a8 },
> -	{ 0x2020, 0x00004120 },
> +	AST_DRAMSTRUCT_REG(AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY),
> +	AST_DRAMSTRUCT_REG(AST_REG_SCU020, 0x00004120),
>   	AST_DRAMSTRUCT_UDELAY(67u),
> -	{ 0x0000, 0xfc600309 },
> -	{ 0x006C, 0x00909090 },
> -	{ 0x0064, 0x00070000 },
> -	AST_DRAMSTRUCT_INIT(DRAM_TYPE, 0x00000489),
> -	{ 0x0008, 0x0011030f },
> -	{ 0x0010, 0x32302926 },
> -	{ 0x0018, 0x274c0122 },
> -	{ 0x0020, 0x00ce2222 },
> -	{ 0x0014, 0x01001523 },
> -	{ 0x001C, 0x1024010d },
> -	{ 0x0024, 0x00cb2522 },
> -	{ 0x0038, 0xffffff82 },
> -	{ 0x003C, 0x00000000 },
> -	{ 0x0040, 0x00000000 },
> -	{ 0x0044, 0x00000000 },
> -	{ 0x0048, 0x00000000 },
> -	{ 0x004C, 0x00000000 },
> -	{ 0x0050, 0x00000000 },
> -	{ 0x0054, 0x00000000 },
> -	{ 0x0058, 0x00000000 },
> -	{ 0x005C, 0x00000000 },
> -	{ 0x0060, 0x0f2aa02a },
> -	{ 0x0064, 0x003f3005 },
> -	{ 0x0068, 0x02020202 },
> -	{ 0x0070, 0x00000000 },
> -	{ 0x0074, 0x00000000 },
> -	{ 0x0078, 0x00000000 },
> -	{ 0x007C, 0x00000000 },
> -	{ 0x0034, 0x00000001 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR6C, 0x00909090),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR64, 0x00070000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR04, 0x00000489), // DRAM type
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR08, 0x0011030f),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR10, 0x32302926),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR18, 0x274c0122),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR20, 0x00ce2222),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR14, 0x01001523),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR1C, 0x1024010d),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR24, 0x00cb2522),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR38, 0xffffff82),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR3C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR40, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR44, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR48, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR4C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR50, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR54, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR58, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR5C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR60, 0x0f2aa02a),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR64, 0x003f3005),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR68, 0x02020202),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR70, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR74, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR78, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR7C, 0x00000000),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR34, 0x00000001),
>   	AST_DRAMSTRUCT_UDELAY(67u),
> -	{ 0x002C, 0x00000942 },
> -	{ 0x0030, 0x00000040 },
> -	{ 0x0028, 0x00000005 },
> -	{ 0x0028, 0x00000007 },
> -	{ 0x0028, 0x00000003 },
> -	{ 0x0028, 0x00000001 },
> -	{ 0x000C, 0x00005a08 },
> -	{ 0x002C, 0x00000842 },
> -	{ 0x0028, 0x00000001 },
> -	{ 0x0030, 0x000003c0 },
> -	{ 0x0028, 0x00000003 },
> -	{ 0x0030, 0x00000040 },
> -	{ 0x0028, 0x00000003 },
> -	{ 0x000C, 0x00005a21 },
> -	{ 0x0034, 0x00007c03 },
> -	{ 0x0120, 0x00005061 },
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR2C, 0x00000942),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR30, 0x00000040),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000005),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000007),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000003),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000001),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR0C, 0x00005a08),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR2C, 0x00000842),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000001),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR30, 0x000003c0),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000003),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR30, 0x00000040),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR28, 0x00000003),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR0C, 0x00005a21),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR34, 0x00007c03),
> +	AST_DRAMSTRUCT_REG(AST_REG_MCR120, 0x00005061),
>   	AST_DRAMSTRUCT_INVALID,
>   };
>   
> @@ -328,7 +328,7 @@ static void ast_post_chip_2100(struct ast_device *ast)
>   			if (AST_DRAMSTRUCT_IS(dram_reg_info, UDELAY)) {
>   				for (i = 0; i < 15; i++)
>   					udelay(dram_reg_info->data);
> -			} else if (AST_DRAMSTRUCT_IS(dram_reg_info, DRAM_TYPE)) {
> +			} else if (AST_DRAMSTRUCT_IS_REG(dram_reg_info, AST_REG_MCR04)) {
>   				switch (dram_layout) {
>   				case AST_DRAM_1Gx16:
>   					data = 0x00000d89;
> @@ -344,10 +344,9 @@ static void ast_post_chip_2100(struct ast_device *ast)
>   				temp = ast_read32(ast, 0x12070);
>   				temp &= 0xc;
>   				temp <<= 2;
> -				ast_write32(ast, 0x10000 + dram_reg_info->index, data | temp);
> +				ast_moutdwm(ast, dram_reg_info->index, data | temp);
>   			} else {
> -				ast_write32(ast, 0x10000 + dram_reg_info->index,
> -					    dram_reg_info->data);
> +				ast_moutdwm(ast, dram_reg_info->index, dram_reg_info->data);
>   			}
>   			dram_reg_info++;
>   		}
> diff --git a/drivers/gpu/drm/ast/ast_post.h b/drivers/gpu/drm/ast/ast_post.h
> index 41cd753b7f67..41b2db08a870 100644
> --- a/drivers/gpu/drm/ast/ast_post.h
> +++ b/drivers/gpu/drm/ast/ast_post.h
> @@ -10,13 +10,10 @@ struct ast_device;
>   
>   /* DRAM timing tables */
>   struct ast_dramstruct {
> -	u16 index;
> +	u32 index;
>   	u32 data;
>   };
>   
> -/* hardware fields */
> -#define __AST_DRAMSTRUCT_DRAM_TYPE      0x0004
> -
>   /* control commands */
>   #define __AST_DRAMSTRUCT_UDELAY         0xff00
>   #define __AST_DRAMSTRUCT_INVALID        0xffff
> @@ -24,14 +21,18 @@ struct ast_dramstruct {
>   #define __AST_DRAMSTRUCT_INDEX(_name) \
>   	(__AST_DRAMSTRUCT_ ## _name)
>   
> -#define AST_DRAMSTRUCT_INIT(_name, _value) \
> -	{ __AST_DRAMSTRUCT_INDEX(_name), (_value) }
> +#define __AST_DRAMSTRUCT_INIT(_index, _value) \
> +	{ (_index), (_value) }
>   
> +#define AST_DRAMSTRUCT_REG(_reg, _value) \
> +	__AST_DRAMSTRUCT_INIT(_reg, _value)
>   #define AST_DRAMSTRUCT_UDELAY(_usecs) \
> -	AST_DRAMSTRUCT_INIT(UDELAY, _usecs)
> +	__AST_DRAMSTRUCT_INIT(__AST_DRAMSTRUCT_UDELAY, _usecs)
>   #define AST_DRAMSTRUCT_INVALID \
> -	AST_DRAMSTRUCT_INIT(INVALID, U32_MAX)
> +	__AST_DRAMSTRUCT_INIT(__AST_DRAMSTRUCT_INVALID, U32_MAX)
>   
> +#define AST_DRAMSTRUCT_IS_REG(_entry, _reg) \
> +	((_entry)->index == (_reg))
>   #define AST_DRAMSTRUCT_IS(_entry, _name) \
>   	((_entry)->index == __AST_DRAMSTRUCT_INDEX(_name))
>   
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index 78fabe2a9c81..a01af2bfbae6 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -120,12 +120,15 @@
>   #define AST_REG_MCR30				AST_REG_MCR(0x30)
>   #define AST_REG_MCR34				AST_REG_MCR(0x34)
>   #define AST_REG_MCR38				AST_REG_MCR(0x38)
> +#define AST_REG_MCR3C				AST_REG_MCR(0x3c)
>   #define AST_REG_MCR40				AST_REG_MCR(0x40)
>   #define AST_REG_MCR44				AST_REG_MCR(0x44)
>   #define AST_REG_MCR48				AST_REG_MCR(0x48)
>   #define AST_REG_MCR4C				AST_REG_MCR(0x4C)
>   #define AST_REG_MCR50				AST_REG_MCR(0x50)
>   #define AST_REG_MCR54				AST_REG_MCR(0x54)
> +#define AST_REG_MCR58				AST_REG_MCR(0x58)
> +#define AST_REG_MCR5C				AST_REG_MCR(0x5c)
>   #define AST_REG_MCR60				AST_REG_MCR(0x60)
>   #define AST_REG_MCR64				AST_REG_MCR(0x64)
>   #define AST_REG_MCR68				AST_REG_MCR(0x68)
> @@ -137,6 +140,7 @@
>   #define AST_REG_MCR80				AST_REG_MCR(0x80)
>   #define AST_REG_MCR84				AST_REG_MCR(0x84)
>   #define AST_REG_MCR88				AST_REG_MCR(0x88)
> +#define AST_REG_MCR108				AST_REG_MCR(0x108)
>   #define AST_REG_MCR120				AST_REG_MCR(0x120)
>   #define AST_REG_MCR200				AST_REG_MCR(0x200)
>   #define AST_REG_MCR204				AST_REG_MCR(0x204)

