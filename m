Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DEB109C045
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC11210E840;
	Wed, 25 Mar 2026 16:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JGK9GP7+";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4585D10E80F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBp0EM/0gMbUmG1WoZ9pCgnQGr1i9P//5UlJPVlMc9s=;
 b=JGK9GP7+bkRL9F0qUgmH27Dtporg8bU/uGU9O+bth7aRfNs+dagE0zp40KBtvQMd5WDUdm
 213iGHtna1d+bRqmWn78YVHC0iPPQivVTpBWYPzBQdJA8ZDKW8rF09u1ycP5cOMSTFsk1c
 /MoMKMOGFdf8jy79ysRm2MJyBTxBgHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-VTu2uXLhPGeYwNU4a0rWpw-1; Wed, 25 Mar 2026 12:46:21 -0400
X-MC-Unique: VTu2uXLhPGeYwNU4a0rWpw-1
X-Mimecast-MFC-AGG-ID: VTu2uXLhPGeYwNU4a0rWpw_1774457180
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-486fcc05b20so346705e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457180; x=1775061980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RBp0EM/0gMbUmG1WoZ9pCgnQGr1i9P//5UlJPVlMc9s=;
 b=riTiaKM9ttYxbyBlckCzpPC5fym4jluE9ePy/eyL1ABMD7yAd3yMkBjTz7GVd9wBL6
 a0G9ZjEihXvG0l7ovm0jwqu0clKfSqB8XlF8kUmVOzKP3CceIg9TD8O9ELXmeTRegva/
 nEc1vT0Nfn1/viRTv80z8ne5i6uku+ID9XPKMdUN7GCMO/PCs1onlQpH4kqbD8RCyChV
 mJClhvHLZgB9ag8kZgWdQ3mDBU0EoKXQvoo4uLVoK7vtOMSbhlHOBP3QgARbQIF/sbas
 zTEllIks35OiIw+Bre+p842U+gNjP39s7x5amKBCyNtQKhNIVwbrnQpP++knXNmZ/4xk
 kRyg==
X-Gm-Message-State: AOJu0YxyqDfQ4n6jfnbYIQqoPe88TCBR/N/+/jTCtkBa0Ald7swg1/5V
 e29IdXYKjcAuXsD2UXzT12TYw6vbssYuONEHcFZaLuxlBBXqvCoVA7AJepH+OsKaaZO3gf3EEbx
 /++Tcn00XZHKUid4n3tGUw8g+x3+7/2Ueyva4C9YIKK4hbDI0c/BhCWdTFI5aPf4/xsPs0A==
X-Gm-Gg: ATEYQzySN/8aQSGtVObXD8pD+8L/bvdoOJWmdZw2r5ZNg29zuDQ0arIRbFfJDXA2fGz
 DlUwKjOmMcs/yrFRzSpM1h5TozzHC5lxj+RA3TrzIDUHcmiGmJgMxuEiKLuzkbXQxORggdFkvcG
 eqevUmNckAlclwY9SGPeoJdMoez6Qybfl9E8S45Fx/rxmVa4JrxnhAgDUOm2BvufK7crXrIAEXa
 /L3WxY5iAnPGFJiVf3H3o/bK6yltv9lPBa5oDlvRY0ZrfzTIWHb93pBu4Pyw01zE8Q4k79GAeHN
 mDrWOlg3geQe9qyz9j2tCDNc68RT4LMUFpg5kd9VdwXIvDmnntQ08i0jUe42sdFtJYs5P5qNgdj
 ClyrSAvWpuZ0Zqd10cPDcVlxT2L0VTGXzoTT+b0f5vTkcMYl+0EVuQic5Y4RKfA==
X-Received: by 2002:a05:600c:c490:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-48715fc7437mr62356465e9.1.1774457179709; 
 Wed, 25 Mar 2026 09:46:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-48715fc7437mr62355975e9.1.1774457179238; 
 Wed, 25 Mar 2026 09:46:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711709e95sm145315835e9.8.2026.03.25.09.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:46:18 -0700 (PDT)
Message-ID: <9c2653db-69e5-40b0-b79b-de5c00fec892@redhat.com>
Date: Wed, 25 Mar 2026 17:46:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] drm/ast: Gen6: Fix open-coded register access
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-14-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-14-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OSowOAGcKov-sTVZ3DuZFZZUcMfyjWD0DGLaMtySROo_1774457180
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
> Replace all open-coded access to SCU registers in Gen6 with the
> appropriate calls to ast_moutdwm() and ast_mindwm(). Use SCU register
> constants. Name variables according to registers.
> 
Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_2500.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
> index 39f401dd1f47..e442cb6a23d9 100644
> --- a/drivers/gpu/drm/ast/ast_2500.c
> +++ b/drivers/gpu/drm/ast/ast_2500.c
> @@ -507,6 +507,8 @@ static void ast_post_chip_2500(struct ast_device *ast)
>   
>   	reg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
>   	if ((reg & AST_IO_VGACRD0_VRAM_INIT_STATUS_MASK) == 0) {/* vga only */
> +		u32 scu008;
> +
>   		/* Clear bus lock condition */
>   		ast_2500_patch_ahb(ast->regs);
>   
> @@ -540,9 +542,9 @@ static void ast_post_chip_2500(struct ast_device *ast)
>   			ast_moutdwm(ast, AST_REG_SCU07C, 0x00004000);
>   
>   		/* Slow down CPU/AHB CLK in VGA only mode */
> -		temp = ast_read32(ast, 0x12008);
> -		temp |= 0x73;
> -		ast_write32(ast, 0x12008, temp);
> +		scu008 = ast_mindwm(ast, AST_REG_SCU008);
> +		scu008 |= 0x00000073;
> +		ast_moutdwm(ast, AST_REG_SCU008, scu008);
>   
>   		if (!ast_dram_init_2500(ast))
>   			drm_err(dev, "DRAM init failed !\n");

