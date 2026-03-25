Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7DB109C045
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F2C10E7FC;
	Wed, 25 Mar 2026 16:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eSbx9U3p";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630CF10E7FC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQESLBp2SZ7avk6O+XL7y4GAA0mL8R7UURDCdnEs7QU=;
 b=eSbx9U3pIafnupiPFTf+xLuP0wvfDTrOVW6XxonKL22wi/UT2Em2x1Ox/3Ucuc2FMKFFR0
 wneXMXjbqRixyhYSOvFU2z7bowJjQ2vdSH0mhVophe6K/uB7EkQZHqVfZcan5UdlFJ95Y5
 KfDo7DMxJiEBtdCl9C+FIZznAtDcghM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-ZTSfTlGKMuO0rHgQdPU0mg-1; Wed, 25 Mar 2026 12:48:02 -0400
X-MC-Unique: ZTSfTlGKMuO0rHgQdPU0mg-1
X-Mimecast-MFC-AGG-ID: ZTSfTlGKMuO0rHgQdPU0mg_1774457281
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-486f89b7f69so3111885e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457281; x=1775062081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LQESLBp2SZ7avk6O+XL7y4GAA0mL8R7UURDCdnEs7QU=;
 b=kXBTdVxsYGP0MRPeS8JzPCNa7uqs31G3niZeeCnrvi0WjdLL7WJERAxYbgVjuzQqQb
 TM+1DfeUhfDYUxPJOryUJlDlBzl55t3pXvmwZJLJbLZgnHpsO4Ca9N+9I7Mbyp0ue7Hb
 rlseqZA/0wqiLmdf7tDt0PZq2VGL0w0DnC6RMQi71Ix/mFbJpm6z8HLaWMjp/FmTUkWw
 T91U4+s+4u1sPUSy7xbl/xtr1nzzzmuh4r8BpfQN1YEesXeSCHc4dFuZiyp3w46FqcoT
 2XDxIKWuwajS1/THEPRogHurzDoibaoJsBNaz/pASN7e8QnjWkFhQSaosD9gxsWSPvE9
 tQNA==
X-Gm-Message-State: AOJu0YxieDD7Ue8egNis5Tl6gqZVjbb7dvnSueSwgF0uHDPV5RLz3XjQ
 +u6Dqo+bf2UDw8nVhTWgQy0AjgUKu9pkFiGd5HVFg4MrMUPY/2lzUzQtGjowRg+IKmOZbLNtzix
 9UCAnYWbH0fV8moLfEcsBfvfB5ONObrkMvp2tA/NsR7eRDAKhagcMHR+aXd7Ufg9KP9TICQ==
X-Gm-Gg: ATEYQzz5IWQA027YYrz0vSieq2fe9Z6zn9nMLPXwkD9JSOr8LT4tOdAT6f6bf32QBZ4
 RgLI/CNllr8BAnn45FY1bSNTJ+ezett+L4nXXkJOUiD2LGPjmbOXbnx2hO7iahqlAnJeWMlxJb5
 SeFRJWSdqoLVkxdFwjkJMZtaM7FIRnM0kmw4yo8/n2eOcbKdsvJJU6A1mESKdOVJJiDT1M7jjdG
 BWS1P3/viI1Lv2SUbVjWxAOdJDgxRYEAtVMNIhfCFjJXMqZXwWFmkUBwlRm318xHgL+oCf7LWjQ
 y+AouF+AyDMs8xw+zplXY4FvnIaVkYplZChDXGCtBYksiFs1skIWDovJdgfqPL+feLHOI1BtwG2
 phu2Cb+RXhgZXxWDZdrm8eBgELluixRBLBKQB7EiTeD9LuYaiCT34wj1qxTPLvQ==
X-Received: by 2002:a05:600c:6087:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-4871605a9a5mr60411425e9.18.1774457280744; 
 Wed, 25 Mar 2026 09:48:00 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-4871605a9a5mr60411025e9.18.1774457280288; 
 Wed, 25 Mar 2026 09:48:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df85csm1180791f8f.28.2026.03.25.09.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:47:59 -0700 (PDT)
Message-ID: <2852aba1-6f2e-4078-9a43-1b5d22d59d3f@redhat.com>
Date: Wed, 25 Mar 2026 17:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] drm/ast: dp501: Fix open-coded register access
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-15-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-15-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dFA3-j3uz9OaFt_Kn_gZv-Gsm2zxPB3Kl5D36QVozCw_1774457281
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
> Replace all open-coded access to SCU registers in DP501 support with
> the appropriate calls to ast_moutdwm() and ast_mindwm(). Use SCU register
> constants. Name variables according to registers.
> 
Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_dp501.c | 124 +++++++++++++++-----------------
>   drivers/gpu/drm/ast/ast_reg.h   |   6 ++
>   2 files changed, 64 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
> index 23142119d733..98d8491ce6c9 100644
> --- a/drivers/gpu/drm/ast/ast_dp501.c
> +++ b/drivers/gpu/drm/ast/ast_dp501.c
> @@ -347,68 +347,65 @@ static int ast_dp512_read_edid_block(void *data, u8 *buf, unsigned int block, si
>   static bool ast_init_dvo(struct ast_device *ast)
>   {
>   	u8 jreg;
> -	u32 data;
> -	ast_write32(ast, 0xf004, AST_REG_MCR00);
> -	ast_write32(ast, 0xf000, 0x1);
> -	ast_write32(ast, 0x12000, 0x1688a8a8);
> +	u32 scu02c;
> +
> +	ast_moutdwm(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
>   
>   	jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
>   	if (!(jreg & 0x80)) {
> +		u32 scu008;
> +
>   		/* Init SCU DVO Settings */
> -		data = ast_read32(ast, 0x12008);
> -		/* delay phase */
> -		data &= 0xfffff8ff;
> -		data |= 0x00000500;
> -		ast_write32(ast, 0x12008, data);
> +
> +		scu008 = ast_mindwm(ast, AST_REG_SCU008);
> +		scu008 &= 0xfffff8ff;
> +		scu008 |= 0x00000500; /* delay phase */
> +		ast_moutdwm(ast, AST_REG_SCU008, scu008);
>   
>   		if (IS_AST_GEN4(ast)) {
> -			data = ast_read32(ast, 0x12084);
> -			/* multi-pins for DVO single-edge */
> -			data |= 0xfffe0000;
> -			ast_write32(ast, 0x12084, data);
> -
> -			data = ast_read32(ast, 0x12088);
> -			/* multi-pins for DVO single-edge */
> -			data |= 0x000fffff;
> -			ast_write32(ast, 0x12088, data);
> -
> -			data = ast_read32(ast, 0x12090);
> -			/* multi-pins for DVO single-edge */
> -			data &= 0xffffffcf;
> -			data |= 0x00000020;
> -			ast_write32(ast, 0x12090, data);
> +			u32 scu084, scu088, scu090;
> +
> +			scu084 = ast_mindwm(ast, AST_REG_SCU084);
> +			scu084 |= 0xfffe0000; /* multi-pins for DVO single-edge */
> +			ast_moutdwm(ast, AST_REG_SCU084, scu084);
> +
> +			scu088 = ast_mindwm(ast, AST_REG_SCU088);
> +			scu088 |= 0x000fffff; /* multi-pins for DVO single-edge */
> +			ast_moutdwm(ast, AST_REG_SCU088, scu088);
> +
> +			scu090 = ast_mindwm(ast, AST_REG_SCU090);
> +			scu090 &= 0xffffffcf;
> +			scu090 |= 0x00000020; /* multi-pins for DVO single-edge */
> +			ast_moutdwm(ast, AST_REG_SCU090, scu090);
>   		} else { /* AST GEN5+ */
> -			data = ast_read32(ast, 0x12088);
> -			/* multi-pins for DVO single-edge */
> -			data |= 0x30000000;
> -			ast_write32(ast, 0x12088, data);
> -
> -			data = ast_read32(ast, 0x1208c);
> -			/* multi-pins for DVO single-edge */
> -			data |= 0x000000cf;
> -			ast_write32(ast, 0x1208c, data);
> -
> -			data = ast_read32(ast, 0x120a4);
> -			/* multi-pins for DVO single-edge */
> -			data |= 0xffff0000;
> -			ast_write32(ast, 0x120a4, data);
> -
> -			data = ast_read32(ast, 0x120a8);
> -			/* multi-pins for DVO single-edge */
> -			data |= 0x0000000f;
> -			ast_write32(ast, 0x120a8, data);
> -
> -			data = ast_read32(ast, 0x12094);
> -			/* multi-pins for DVO single-edge */
> -			data |= 0x00000002;
> -			ast_write32(ast, 0x12094, data);
> +			u32 scu088, scu08c, scu0a4, scu0a8, scu094;
> +
> +			scu088 = ast_mindwm(ast, AST_REG_SCU088);
> +			scu088 |= 0x30000000; /* multi-pins for DVO single-edge */
> +			ast_moutdwm(ast, AST_REG_SCU088, scu088);
> +
> +			scu08c = ast_mindwm(ast, AST_REG_SCU08C);
> +			scu08c |= 0x000000cf; /* multi-pins for DVO single-edge */
> +			ast_moutdwm(ast, AST_REG_SCU08C, scu08c);
> +
> +			scu0a4 = ast_mindwm(ast, AST_REG_SCU0A4);
> +			scu0a4 |= 0xffff0000; /* multi-pins for DVO single-edge */
> +			ast_moutdwm(ast, AST_REG_SCU0A4, scu0a4);
> +
> +			scu0a8 = ast_mindwm(ast, AST_REG_SCU0A8);
> +			scu0a8 |= 0x0000000f; /* multi-pins for DVO single-edge */
> +			ast_moutdwm(ast, AST_REG_SCU0A8, scu0a8);
> +
> +			scu094 = ast_mindwm(ast, AST_REG_SCU094);
> +			scu094 |= 0x00000002; /* multi-pins for DVO single-edge */
> +			ast_moutdwm(ast, AST_REG_SCU094, scu094);
>   		}
>   	}
>   
>   	/* Force to DVO */
> -	data = ast_read32(ast, 0x1202c);
> -	data &= 0xfffbffff;
> -	ast_write32(ast, 0x1202c, data);
> +	scu02c = ast_mindwm(ast, AST_REG_SCU02C);
> +	scu02c &= 0xfffbffff;
> +	ast_moutdwm(ast, AST_REG_SCU02C, scu02c);
>   
>   	/* Init VGA DVO Settings */
>   	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xcf, 0x80);
> @@ -418,25 +415,20 @@ static bool ast_init_dvo(struct ast_device *ast)
>   
>   static void ast_init_analog(struct ast_device *ast)
>   {
> -	u32 data;
> +	u32 scu02c;
>   
>   	/*
>   	 * Set DAC source to VGA mode in SCU2C via the P2A
> -	 * bridge. First configure the P2U to target the SCU
> -	 * in case it isn't at this stage.
> +	 * bridge.
>   	 */
> -	ast_write32(ast, 0xf004, AST_REG_MCR00);
> -	ast_write32(ast, 0xf000, 0x1);
> -
> -	/* Then unlock the SCU with the magic password */
> -	ast_write32(ast, 0x12000, 0x1688a8a8);
> -	ast_write32(ast, 0x12000, 0x1688a8a8);
> -	ast_write32(ast, 0x12000, 0x1688a8a8);
> -
> -	/* Finally, clear bits [17:16] of SCU2c */
> -	data = ast_read32(ast, 0x1202c);
> -	data &= 0xfffcffff;
> -	ast_write32(ast, 0x1202c, data);
> +
> +	/* Unlock the SCU with the magic password */
> +	ast_moutdwm_poll(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY, 0x01);
> +
> +	/* Clear bits [17:16] of SCU2C */
> +	scu02c = ast_mindwm(ast, AST_REG_SCU02C);
> +	scu02c &= 0xfffcffff;
> +	ast_moutdwm(ast, AST_REG_SCU02C, scu02c);
>   
>   	/* Disable DVO */
>   	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xcf, 0x00);
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index c3473cad4545..9d6ea0765990 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -186,11 +186,17 @@
>   #define AST_REG_SCU008				AST_REG_SCU(0x008)
>   #define AST_REG_SCU00C				AST_REG_SCU(0x00c)
>   #define AST_REG_SCU020				AST_REG_SCU(0x020)
> +#define AST_REG_SCU02C				AST_REG_SCU(0x02c)
>   #define AST_REG_SCU040				AST_REG_SCU(0x040)
>   #define AST_REG_SCU070				AST_REG_SCU(0x070)
>   #define AST_REG_SCU07C				AST_REG_SCU(0x07c)
> +#define AST_REG_SCU084				AST_REG_SCU(0x084)
> +#define AST_REG_SCU088				AST_REG_SCU(0x088)
> +#define AST_REG_SCU08C				AST_REG_SCU(0x08c)
>   #define AST_REG_SCU090				AST_REG_SCU(0x090)
>   #define AST_REG_SCU094				AST_REG_SCU(0x094)
> +#define AST_REG_SCU0A4				AST_REG_SCU(0x0a4)
> +#define AST_REG_SCU0A8				AST_REG_SCU(0x0a8)
>   #define AST_REG_SCU100				AST_REG_SCU(0x100)
>   #define AST_REG_SCU104				AST_REG_SCU(0x104)
>   #define AST_REG_SCU160				AST_REG_SCU(0x160)

