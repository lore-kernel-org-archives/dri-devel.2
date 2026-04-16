Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A508F433FE
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B43410E19E;
	Thu, 16 Apr 2026 07:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MXXn87OE";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1D710E19E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776324254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efNqR9LMGDtcneYEyqBvFuywLToc7cTPHKjqSrhywkQ=;
 b=MXXn87OEMRjB2lkUeQF5btC8HGU8PRk2HAFf43xbgWPkZ0VRHFRN8uGAsdIkpV5EV991UM
 E9jXpCrymoMV6QNGWfHzAXo76qc/JOXPkakEr2jJxp3E4OJroL1zmbWMb8zjpP47AYP8RM
 xEN6jMGYJIDeohMD8/deebfQ5j52ENE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-j7yEgMtzMjusZrhd-WWsAg-1; Thu, 16 Apr 2026 03:24:13 -0400
X-MC-Unique: j7yEgMtzMjusZrhd-WWsAg-1
X-Mimecast-MFC-AGG-ID: j7yEgMtzMjusZrhd-WWsAg_1776324252
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43cf5b4dac8so8289290f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324252; x=1776929052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efNqR9LMGDtcneYEyqBvFuywLToc7cTPHKjqSrhywkQ=;
 b=sYHAiDX1Q2MMF43iWyhTpx3D4v1dOSGPte8YB5YMqmj6FWFCgdUnEaFp8CxeWNs9Sb
 SqUzAW7BjzjlShAF7Ul3mJQNWcjZfsiRO8TfNQzY2SJWoEavG2QogwgdSOHDVRZn+2st
 OHkS1fnudheYMesPGdk4mjLCUMqEFghvuGI8i7bWeTYWJnJoZWR71JPhJCY2gNjNa5T/
 QShxxlM3C1oTC+bFQ+0DQOBLpESC5B4OqEZPfkwrhnOpwIfOwOvEMMxx/FqHbJo8vSve
 CiMUVy+5pq+FGu/p7xalQuw11fal1mOVDszA/H+pRclrwwWhY1K7R1jrxSMxSK/2BgBu
 iOZA==
X-Gm-Message-State: AOJu0YxAn/v742WvPhMvZONmlXn7TAlC6GwxxO+UrTaOVsn5lzGtZqIj
 usNHkfjjtMOWA7YOdfXtBdzbVqhDFWVgd9bUY4tH6DdgEvhInE8XMnvpQ6NZIqPE2P11Ja59LjQ
 2ZhfTW0u6XRtEMT2rNywnSX8gXKrKU7WT/ElonKbQJBEKLKefnBPLO9xWBR1yjd5bwoFfSw==
X-Gm-Gg: AeBDieu0+MBcJJzStscuyAYLonk9Ze5q/knVh07R7V9+aX7dkbL3J49gyeMpwwGczog
 f30F+Z7IV3/0Wd5pyLT2AW10JQ09QQvqEcxkw7ivT1ZIm4nBC/BLGI4Cn3RwzTAkfa4vE8ReZfl
 yHVA+wp1BNNF1UWoQRDVOF30zZuHsJ/L1mTvC1X6eN5/l7n/7wKxZViRsKHSd3B8DtRBykThNcG
 8HpNOKyXOQfNWFxFa0ZuJB4rCUqh4xwF+4iensd2G2kIYX4Nf1Wty407EjrA5mjrm6VbTNnesWK
 1mA40lQBdZbJuZfpb/+HIxsQMeDMM6XPDyV19U3buHpUg8DwlbejBQ0+35JZjJaMvyQ0Vs7gFBR
 t2jCr4CUoEgm9HB1J4lRRiY6XsndxYHezaD3pFtATXMov38IJQ8kxRC805T1eMw==
X-Received: by 2002:a5d:5d85:0:b0:43d:73de:abd2 with SMTP id
 ffacd0b85a97d-43d73dead51mr25021092f8f.26.1776324252058; 
 Thu, 16 Apr 2026 00:24:12 -0700 (PDT)
X-Received: by 2002:a5d:5d85:0:b0:43d:73de:abd2 with SMTP id
 ffacd0b85a97d-43d73dead51mr25021051f8f.26.1776324251519; 
 Thu, 16 Apr 2026 00:24:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3564d8sm12803254f8f.10.2026.04.16.00.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:24:10 -0700 (PDT)
Message-ID: <858ff813-85d6-4939-989c-a87877996d31@redhat.com>
Date: Thu, 16 Apr 2026 09:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/ast: Add constant for VGACR91
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260414070522.33943-1-tzimmermann@suse.de>
 <20260414070522.33943-2-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260414070522.33943-2-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iLERcZd1Q6nVfgQnFN9ubls33iFPb0D9JvVhTMbCNg4_1776324252
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

On 14/04/2026 09:02, Thomas Zimmermann wrote:
> Register VGACR91 receives a password that enables the new mode-info
> header in other registers. Replace the password's magic value with a
> constant.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_mode.c | 4 ++--
>   drivers/gpu/drm/ast/ast_reg.h  | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 21abb6a6d8bc..c150b83aaca7 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -168,7 +168,7 @@ static void ast_set_vbios_color_reg(struct ast_device *ast,
>   	ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0x00);
>   
>   	if (vmode->flags & NewModeInfo) {
> -		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0xa8);
> +		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, AST_IO_VGACR91_PASSWORD);
>   		ast_set_index_reg(ast, AST_IO_VGACRI, 0x92, format->cpp[0] * 8);
>   	}
>   }
> @@ -188,7 +188,7 @@ static void ast_set_vbios_mode_reg(struct ast_device *ast,
>   	ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0x00);
>   
>   	if (vmode->flags & NewModeInfo) {
> -		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0xa8);
> +		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, AST_IO_VGACR91_PASSWORD);
>   		ast_set_index_reg(ast, AST_IO_VGACRI, 0x93, adjusted_mode->clock / 1000);
>   		ast_set_index_reg(ast, AST_IO_VGACRI, 0x94, adjusted_mode->crtc_hdisplay);
>   		ast_set_index_reg(ast, AST_IO_VGACRI, 0x95, adjusted_mode->crtc_hdisplay >> 8);
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index ea7dc382aee7..99d0a8322f89 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -31,6 +31,7 @@
>   #define AST_IO_VGACRI			(0x54)
>   #define AST_IO_VGACR17_SYNC_ENABLE	BIT(7) /* called "Hardware reset" in docs */
>   #define AST_IO_VGACR80_PASSWORD		(0xa8)
> +#define AST_IO_VGACR91_PASSWORD		(0xa8)
>   #define AST_IO_VGACR99_VGAMEM_RSRV_MASK	GENMASK(1, 0)
>   #define AST_IO_VGACRA1_VGAIO_DISABLED	BIT(1)
>   #define AST_IO_VGACRA1_MMIO_ENABLED	BIT(2)

