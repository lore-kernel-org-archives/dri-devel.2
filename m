Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3377F8809D
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEE110E827;
	Thu, 16 Apr 2026 07:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CQ24Vb73";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA69710E825
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776324408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gf1IxMxD60Lzx27SwwY7B+49Aix912sjP22IqjlKBcE=;
 b=CQ24Vb73OLuJVUgEC0KjeR9z2M0ETT680wGz/p/npweLUfyB1yul/zS+4PPaYFTb0g1RC2
 DfR9f9Z+7FEeqggilRQqiiioU9YAnKSUSWlButp47zkgvPrWiMwTqDXEJF+u+o6TqoWqWX
 9hAShS3dbWuj+77iwm0m44wtuR95nQ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-hjGlFFKJNoq29UUPp0RwUg-1; Thu, 16 Apr 2026 03:26:47 -0400
X-MC-Unique: hjGlFFKJNoq29UUPp0RwUg-1
X-Mimecast-MFC-AGG-ID: hjGlFFKJNoq29UUPp0RwUg_1776324406
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488cc31ea57so49411685e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324406; x=1776929206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gf1IxMxD60Lzx27SwwY7B+49Aix912sjP22IqjlKBcE=;
 b=YgrwKHwXA4gGdS9a/k+Lxp45UWGuKd7EuDkdzfqmYb9kRhsH6QKCuRoFlKB7dJQQW2
 GSH3qGt8gOGxbdRPNoxVr5jdWrCVi893Khwvbiwl68jAMs9vb2+PK9mdsMe7g/toIr2d
 dnZsw7KdGRBlI/04ayJ6bW/yHDjiIvx20A+9rgyAlScD6HHsAE5w/AcrGopszSzRkXIY
 iShWBt8f2QsrutOCvUgBWntwKBF9DCNAdJcIkdxyoDlvV6enzLWK+yyF9dFGmXXaPquM
 uv1mn0C88HSqRfNZZB1PPVQPIV707FE6BcX3X+LQ3raScrJlVKPgBdNTPtxF0cIfxrlP
 252g==
X-Gm-Message-State: AOJu0Yw0BMxmTmxEIotDfwPEIhWjuTFpQunLKJjUa9lpGYN3kdq5I77a
 tGwgnBROhJIWLH2uY2FfqNZjwVetoScK5B2yoOt4KtvYio4lEcUpOa5r1DNG7K6ZGNvCHRDqY8q
 RtvJbRFji/1v45IivIhEUeOvdO5vqZqnuopwrgJiEHSf4Cb9Pbj3WR3cVHgyDkniLpDFeQA==
X-Gm-Gg: AeBDieu8zN+ymdQZJWsNisFWVi1QVRyrnIVbcrWr83YxJvolXC47emS70jTBGUaa9fA
 V3S8m8SufUJGe3/2+yAkLjptezHuzs4SnTM2WmHA8I2q4mijFfLopezu1/hnlqrGmkMVuEmMRqv
 bPz70GUMVDNjfW5+vXdoKaevBVoxus2x9/A2Ow58lCBbwJSiXHYwxoocDNjj/GcouM/CP556PvO
 Gc3L4n8mU6J+pRCsgluZIs0vVpCArXJtk0zgJDpFFjODymbEDR9AwuWeixm3vWBGfJ2RdWMD01H
 LrhNU82ek3nOzAt9fI2cHCgVE/bvcL4kGm+FAf9rZhAdUgQebQ1sTpoiDIIP1uDEGUqrur6vswt
 fM0rY8bsv9Fa2u/WoDpMkFgDPNnWxHOVkaNDO84R1O+/FJL7a0rW9JnUmDYitJw==
X-Received: by 2002:a05:600c:4e16:b0:488:966f:70a7 with SMTP id
 5b1f17b1804b1-488d67bbc7emr358016225e9.2.1776324406009; 
 Thu, 16 Apr 2026 00:26:46 -0700 (PDT)
X-Received: by 2002:a05:600c:4e16:b0:488:966f:70a7 with SMTP id
 5b1f17b1804b1-488d67bbc7emr358015975e9.2.1776324405597; 
 Thu, 16 Apr 2026 00:26:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0edaf47sm38290725e9.35.2026.04.16.00.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:26:45 -0700 (PDT)
Message-ID: <8a6b7dcb-ccf0-4e18-9be1-c3662df48997@redhat.com>
Date: Thu, 16 Apr 2026 09:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/ast: Support DRM_FORMAT_XRGB1555 on the primary
 plane
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260414070522.33943-1-tzimmermann@suse.de>
 <20260414070522.33943-5-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260414070522.33943-5-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p-tF2BDhvUX1x13-wuB71W-sZf4VKs1rpeBtVcavneg_1776324406
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
> Export DRM_FORMAT_XRGB1555 in the primary plane's format array and
> handle the format in the color-format updates. With this, ast is now
> feature complete wrt. color-format support.
> 
> Also update the comments in the gamma-LUT code to reflect the ast
> manual's terminology.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_mode.c | 15 +++++++++++++--
>   drivers/gpu/drm/ast/ast_reg.h  |  1 +
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 340ea680df47..91b83ec00e9c 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -105,8 +105,9 @@ static void ast_crtc_fill_gamma(struct ast_device *ast,
>   		/* gamma table is used as color palette */
>   		drm_crtc_fill_palette_8(crtc, ast_set_gamma_lut);
>   		break;
> +	case DRM_FORMAT_XRGB1555:
>   	case DRM_FORMAT_RGB565:
> -		/* also uses 8-bit gamma ramp on low-color modes */
> +		/* also uses 24-bit gamma correction on high-color modes */
>   		fallthrough;
>   	case DRM_FORMAT_XRGB8888:
>   		drm_crtc_fill_gamma_888(crtc, ast_set_gamma_lut);
> @@ -129,8 +130,9 @@ static void ast_crtc_load_gamma(struct ast_device *ast,
>   		/* gamma table is used as color palette */
>   		drm_crtc_load_palette_8(crtc, lut, ast_set_gamma_lut);
>   		break;
> +	case DRM_FORMAT_XRGB1555:
>   	case DRM_FORMAT_RGB565:
> -		/* also uses 8-bit gamma ramp on low-color modes */
> +		/* also uses 24-bit gamma correction on high-color modes */
>   		fallthrough;
>   	case DRM_FORMAT_XRGB8888:
>   		drm_crtc_load_gamma_888(crtc, lut, ast_set_gamma_lut);
> @@ -154,6 +156,10 @@ static void ast_set_vbios_color_reg(struct ast_device *ast,
>   		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_VGA;
>   		vgacr92 = 8;
>   		break;
> +	case DRM_FORMAT_XRGB1555:
> +		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_15_BPP;
> +		vgacr92 = 15;
> +		break;
>   	case DRM_FORMAT_RGB565:
>   		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_16_BPP;
>   		vgacr92 = 16;
> @@ -396,6 +402,9 @@ static void ast_set_color_reg(struct ast_device *ast,
>   		vgacra8 &= ~AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
>   		break;
>   	case DRM_FORMAT_XRGB1555:
> +		vgacra3 |= AST_IO_VGACRA3_15_BPP;
> +		vgacra8 |= AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
> +		break;
>   	case DRM_FORMAT_RGB565:
>   		vgacra3 |= AST_IO_VGACRA3_16_BPP;
>   		vgacra8 |= AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
> @@ -493,6 +502,7 @@ void __iomem *ast_plane_vaddr(struct ast_plane *ast_plane)
>   static const uint32_t ast_primary_plane_formats[] = {
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_XRGB1555,
>   	DRM_FORMAT_C8,
>   };
>   
> @@ -766,6 +776,7 @@ static int ast_crtc_helper_atomic_check(struct drm_crtc *crtc,
>   	case DRM_FORMAT_C8:
>   		ast_state->std_table = &vbios_stdtable[VGAModeIndex];
>   		break;
> +	case DRM_FORMAT_XRGB1555:
>   	case DRM_FORMAT_RGB565:
>   		ast_state->std_table = &vbios_stdtable[HiCModeIndex];
>   		break;
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index 9267b70a3ec8..b808b0a02ba8 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -62,6 +62,7 @@
>   #define AST_IO_VGACRA3_DVO_ENABLED		BIT(7)
>   #define AST_IO_VGACRA3_32_BPP			BIT(3)
>   #define AST_IO_VGACRA3_16_BPP			BIT(2)
> +#define AST_IO_VGACRA3_15_BPP			BIT(1)
>   #define AST_IO_VGACRA3_256_COLORS		BIT(0)
>   
>   #define AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED	BIT(1)

