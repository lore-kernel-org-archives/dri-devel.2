Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B34FF8809D
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8161710E824;
	Thu, 16 Apr 2026 07:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OrShDTkI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6222910E824
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776324362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=is0JzsFRrM51+5nKpPxzpe53YtDtIQc8fwYnFT/SKus=;
 b=OrShDTkI4ewTUck9bYatd8heh3ES0HKIU3TRJSdPz++MnrR31LbEawGEo9xaYEmpFdixer
 0Gy/wvjgta/bjpKiDiOFBEhmb8UZeTGAgf7cAIp9DQOOoenaGpnHCgemkulFFqGMCBAfdu
 6ISnjUx8cLcJFVBwanjoJv+/L0TS71E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-X30cmqgvOj-iYcschFptCQ-1; Thu, 16 Apr 2026 03:25:59 -0400
X-MC-Unique: X30cmqgvOj-iYcschFptCQ-1
X-Mimecast-MFC-AGG-ID: X30cmqgvOj-iYcschFptCQ_1776324357
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d56f87e8so49280475e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324357; x=1776929157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=is0JzsFRrM51+5nKpPxzpe53YtDtIQc8fwYnFT/SKus=;
 b=r7mGtSCjZZ9pNqlQsNe+oAO3b/NhvjNe6HdH3DUmXbSSu+a+zi+lIfmlaTjuLyHa1R
 yiO1G/auuXL1Z18usY1FBH2u5X4YzVJCUU2rJiZ0NhZIbI+sx0sUt3B2BNL7mfXX61CO
 IDgiiwByCsQlGOy0iTpanDDpACfA/BUT4H1ZxZGsRulhguoqbMkEi8BQHlYUDZwDyluf
 pM9th+BSM2TpF8Osm3uV+h9WRde1CwFqJmeT7y6hE2VHxq52KQpsEk1phIRtrX5KiBLv
 MVTIJ9WnA6Oz8akECouRiX7JMksfOKHVJCT8y6Yz4hmCodFXpk4vGZGXY9cNrCBovL3E
 LIAA==
X-Gm-Message-State: AOJu0YxEga3fsOMbKi+UcaNbVrZqbn7vBbETuLzXK+FaPSJF6Npt5pHg
 t6HzOlAeBhvoychoZTMZrFTQPtAzkb9tuNeuTKYf1lXDdHeNWsiM3++VZA8nvQDSRyrDGP5S07R
 MuFZ7g09iAPxw9ENk3LoLISqdIoYPDhiMyx3KxkV0XWb6FmPxmR5zPJkLPu91zzF5EITcgw==
X-Gm-Gg: AeBDietxKJTnTJMqbCrFZQA5+x77KV7HoC18Q0S9PwpfXJ7pVWFQO5eplew6IBdDhg+
 puiKewDh81xp3lelDLMGxUKjWX27NcEr5kJ6426AjBPI9YuC4TuiBv83VQRImnuDkBaXATBB79j
 eR5e1L950CBA3/QLiHaIHJGCCfjhDwaoglEEQr/TCKbyVL+9XQVEo3a9YqOuuxe+6munb+WASQs
 1zY29AOaZiHXA/R7eaHEfRaW1qWXNWKRfpdkSblNmQbAuslpz+N1GRW+1pJQHbbilNWZj2cJKHm
 dlK+0eu1+16lk3up7XW+IFWC0DcwTfts8cIJLcUyEGaxr3WH+7SHpkmFAMHIlzu9G8B39g9XYSa
 3iM3bv5sfjSINoWZPrHuNI5FQep1V2VfSz1ugAO9tKsauZlf6oTc86WkVSafMMg==
X-Received: by 2002:a05:600c:8706:b0:488:a62d:76d7 with SMTP id
 5b1f17b1804b1-488d67df53cmr349688285e9.1.1776324356845; 
 Thu, 16 Apr 2026 00:25:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8706:b0:488:a62d:76d7 with SMTP id
 5b1f17b1804b1-488d67df53cmr349687945e9.1.1776324356395; 
 Thu, 16 Apr 2026 00:25:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818d70sm52138955e9.4.2026.04.16.00.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:25:55 -0700 (PDT)
Message-ID: <6215e65a-ac10-47b2-8b75-f696e7fb6f5e@redhat.com>
Date: Thu, 16 Apr 2026 09:25:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/ast: Replace references to struct
 drm_format_info.cpp
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260414070522.33943-1-tzimmermann@suse.de>
 <20260414070522.33943-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260414070522.33943-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RYEghPf2sqhbcUrIGuzI8XTxxMRBjOka41HhB-fE438_1776324357
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
> Replace all uses of struct drm_format_info.cpp with the corresponding
> 4CC constant. Color-mode selection uses switch statements that branch
> by cpp in several places. While at it, also name the involved variables
> according to register names and replace magic values with constants.
> 
> Replace the use of *ModeIndex constants in ast_set_vbios_color_reg()
> with correct register constants. The former are array indices and do
> not belong into registers.
> 
> In ast_set_color_reg(), vgacra0 is independent from the color format,
> so move it out from the switch statements.
> 
> There is also a flag for gamma correction in vgacra8, which currently
> ast_set_color_reg() handles as part of the primary plane. The gamma LUT
> and its programming is located in the CRTC. A future update should
> consolidate gamma correction in the primary plane and implement the
> functionality with DRM's colorop helpers.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_mode.c | 65 ++++++++++++++++++----------------
>   drivers/gpu/drm/ast/ast_reg.h  | 55 +++++++++++++++++++++-------
>   2 files changed, 77 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 49585fd16267..340ea680df47 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -146,29 +146,31 @@ static void ast_set_vbios_color_reg(struct ast_device *ast,
>   				    const struct drm_format_info *format,
>   				    const struct ast_vbios_enhtable *vmode)
>   {
> -	u32 color_index;
> +	u8 vgacr8c = 0x00;
> +	u8 vgacr92 = 0x00;
>   
> -	switch (format->cpp[0]) {
> -	case 1:
> -		color_index = VGAModeIndex - 1;
> +	switch (format->format) {
> +	case DRM_FORMAT_C8:
> +		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_VGA;
> +		vgacr92 = 8;
>   		break;
> -	case 2:
> -		color_index = HiCModeIndex;
> +	case DRM_FORMAT_RGB565:
> +		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_16_BPP;
> +		vgacr92 = 16;
>   		break;
> -	case 4:
> -		color_index = TrueCModeIndex;
> +	case DRM_FORMAT_XRGB8888:
> +		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_32_BPP;
> +		vgacr92 = 32;
>   		break;
> -	default:
> -		return;
>   	}
>   
> -	ast_set_index_reg(ast, AST_IO_VGACRI, 0x8c, (u8)((color_index & 0x0f) << 4));
> +	ast_set_index_reg(ast, AST_IO_VGACRI, 0x8c, vgacr8c);
>   
>   	ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0x00);
>   
>   	if (vmode->flags & NewModeInfo) {
>   		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, AST_IO_VGACR91_PASSWORD);
> -		ast_set_index_reg(ast, AST_IO_VGACRI, 0x92, format->cpp[0] * 8);
> +		ast_set_index_reg(ast, AST_IO_VGACRI, 0x92, vgacr92);
>   	}
>   }
>   
> @@ -380,30 +382,33 @@ static void ast_set_dclk_reg(struct ast_device *ast,
>   static void ast_set_color_reg(struct ast_device *ast,
>   			      const struct drm_format_info *format)
>   {
> -	u8 jregA0 = 0, jregA3 = 0, jregA8 = 0;
> +	u8 vgacra0 = 0x00;
> +	u8 vgacra3 = 0x00;
> +	u8 vgacra8 = 0x00;
>   
> -	switch (format->cpp[0] * 8) {
> -	case 8:
> -		jregA0 = 0x70;
> -		jregA3 = 0x01;
> -		jregA8 = 0x00;
> +	vgacra0 |= AST_IO_VGACRA0_MEMORY_CHAIN4_MODE |
> +		   AST_IO_VGACRA0_LINEAR_EXT_ACCESS |
> +		   AST_IO_VGACRA0_SEGMENTED_EXT_ACCESS;
> +
> +	switch (format->format) {
> +	case DRM_FORMAT_C8:
> +		vgacra3 |= AST_IO_VGACRA3_256_COLORS;
> +		vgacra8 &= ~AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
>   		break;
> -	case 15:
> -	case 16:
> -		jregA0 = 0x70;
> -		jregA3 = 0x04;
> -		jregA8 = 0x02;
> +	case DRM_FORMAT_XRGB1555:
> +	case DRM_FORMAT_RGB565:
> +		vgacra3 |= AST_IO_VGACRA3_16_BPP;
> +		vgacra8 |= AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
>   		break;
> -	case 32:
> -		jregA0 = 0x70;
> -		jregA3 = 0x08;
> -		jregA8 = 0x02;
> +	case DRM_FORMAT_XRGB8888:
> +		vgacra3 |= AST_IO_VGACRA3_32_BPP;
> +		vgacra8 |= AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
>   		break;
>   	}
>   
> -	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa0, 0x8f, jregA0);
> -	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xf0, jregA3);
> -	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa8, 0xfd, jregA8);
> +	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa0, 0x8f, vgacra0);
> +	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xf0, vgacra3);
> +	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa8, 0xfd, vgacra8);
>   }
>   
>   static void ast_set_crtthd_reg(struct ast_device *ast)
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index 99d0a8322f89..9267b70a3ec8 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -28,19 +28,48 @@
>   #define AST_IO_VGAPDR		        (0x49)
>   #define AST_IO_VGAGRI			(0x4E)
>   
> -#define AST_IO_VGACRI			(0x54)
> -#define AST_IO_VGACR17_SYNC_ENABLE	BIT(7) /* called "Hardware reset" in docs */
> -#define AST_IO_VGACR80_PASSWORD		(0xa8)
> -#define AST_IO_VGACR91_PASSWORD		(0xa8)
> -#define AST_IO_VGACR99_VGAMEM_RSRV_MASK	GENMASK(1, 0)
> -#define AST_IO_VGACRA1_VGAIO_DISABLED	BIT(1)
> -#define AST_IO_VGACRA1_MMIO_ENABLED	BIT(2)
> -#define AST_IO_VGACRA3_DVO_ENABLED	BIT(7)
> -#define AST_IO_VGACRAA_VGAMEM_SIZE_MASK	GENMASK(1, 0)
> -#define AST_IO_VGACRB6_HSYNC_OFF	BIT(0)
> -#define AST_IO_VGACRB6_VSYNC_OFF	BIT(1)
> -#define AST_IO_VGACRCB_HWC_16BPP	BIT(0) /* set: ARGB4444, cleared: 2bpp palette */
> -#define AST_IO_VGACRCB_HWC_ENABLED	BIT(1)
> +#define AST_IO_VGACRI				(0x54)
> +#define AST_IO_VGACR17_SYNC_ENABLE		BIT(7) /* called "Hardware reset" in docs */
> +#define AST_IO_VGACR80_PASSWORD			(0xa8)
> +
> +#define AST_IO_VGACR8C_NEW_MODE_MASK		GENMASK(3, 0)
> +#define AST_IO_VGACR8C_NEW_MODE_EGA		(0x00)
> +#define AST_IO_VGACR8C_NEW_MODE_VGA		(0x01)
> +#define AST_IO_VGACR8C_NEW_MODE_15_BPP		(0x02)
> +#define AST_IO_VGACR8C_NEW_MODE_16_BPP		(0x03)
> +#define AST_IO_VGACR8C_NEW_MODE_32_BPP		(0x04)
> +#define AST_IO_VGACR8C_NEW_MODE_CGA		(0x0f)
> +#define AST_IO_VGACR8C_NEW_MODE_TEXT		(0x0e)
> +#define AST_IO_VGACR8C_CUR_MODE_MASK		GENMASK(7, 4)
> +#define AST_IO_VGACR8C_CUR_MODE_EGA		(0x00)
> +#define AST_IO_VGACR8C_CUR_MODE_VGA		(0x10)
> +#define AST_IO_VGACR8C_CUR_MODE_15_BPP		(0x20)
> +#define AST_IO_VGACR8C_CUR_MODE_16_BPP		(0x30)
> +#define AST_IO_VGACR8C_CUR_MODE_32_BPP		(0x40)
> +#define AST_IO_VGACR8C_CUR_MODE_CGA		(0xf0)
> +#define AST_IO_VGACR8C_CUR_MODE_TEXT		(0xe0)
> +
> +#define AST_IO_VGACR91_PASSWORD			(0xa8)
> +#define AST_IO_VGACR99_VGAMEM_RSRV_MASK		GENMASK(1, 0)
> +
> +#define AST_IO_VGACRA0_MEMORY_CHAIN4_MODE	BIT(6)
> +#define AST_IO_VGACRA0_LINEAR_EXT_ACCESS	BIT(5)
> +#define AST_IO_VGACRA0_SEGMENTED_EXT_ACCESS	BIT(4)
> +
> +#define AST_IO_VGACRA1_VGAIO_DISABLED		BIT(1)
> +#define AST_IO_VGACRA1_MMIO_ENABLED		BIT(2)
> +
> +#define AST_IO_VGACRA3_DVO_ENABLED		BIT(7)
> +#define AST_IO_VGACRA3_32_BPP			BIT(3)
> +#define AST_IO_VGACRA3_16_BPP			BIT(2)
> +#define AST_IO_VGACRA3_256_COLORS		BIT(0)
> +
> +#define AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED	BIT(1)
> +#define AST_IO_VGACRAA_VGAMEM_SIZE_MASK		GENMASK(1, 0)
> +#define AST_IO_VGACRB6_HSYNC_OFF		BIT(0)
> +#define AST_IO_VGACRB6_VSYNC_OFF		BIT(1)
> +#define AST_IO_VGACRCB_HWC_16BPP		BIT(0) /* set: ARGB4444, cleared: 2bpp palette */
> +#define AST_IO_VGACRCB_HWC_ENABLED		BIT(1)
>   
>   /* mirrors SCU100[7:0] */
>   #define AST_IO_VGACRD0_VRAM_INIT_STATUS_MASK	GENMASK(7, 6)

