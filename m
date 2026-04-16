Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2303F8809B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6512110E82A;
	Thu, 16 Apr 2026 07:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="X47SUuTh";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A354710E82A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776324877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnlRvzmY75mUjJ7sNAMOXVyw0CFaDzBmi+rJzDRayDM=;
 b=X47SUuThG5yamTsoaLWEMykRM8KPcXmK86lWv2D5fO0py05q8J6i3BAB3TAm1Md5bldgQV
 OmgDB3ByJvKeddto9hxoP8emi4eTEaLiaIlbcR3HRJXqHBSMNpzURUq2AhEPJejLcqtqnF
 QfJS9oEoLCJK+noOskjF4407Yj2ABgo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-SHU14F5QOSSjc6HW7_Efkg-1; Thu, 16 Apr 2026 03:34:36 -0400
X-MC-Unique: SHU14F5QOSSjc6HW7_Efkg-1
X-Mimecast-MFC-AGG-ID: SHU14F5QOSSjc6HW7_Efkg_1776324875
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43ea728e38cso2458376f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324875; x=1776929675;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bnlRvzmY75mUjJ7sNAMOXVyw0CFaDzBmi+rJzDRayDM=;
 b=Y6DsFg09TJujZoPW7xbKehr1xwIteAvRAUDovt+BEeb4Mao9EGDuuxsuMgwPmDLU4H
 kh/HDDGPhEMFwaXHPZTl7foq1OWRypPdMmC0idM1ZWcAVsQdF4AOnOcLPCRdIIL5Gfpv
 Iba8boCjcL1fmKi3pGI5qaApe81wIL5Z0V+/brjgr17rPb/ORadLELO2pjuoz5s58oRu
 QmwTQ/3LYeU/9+KMvlFn4qxXmLqyyWlFAgzx/bTbWqzL5Sf8MmcG/l5A2+rwCVWwL0ok
 fEFTTL5pg2MnaLtXt0GX6UFF9eQbaux4ohK2/1Ighpu2v9YeXFRwLMNijjISaNgI2dY1
 VFSQ==
X-Gm-Message-State: AOJu0YwNM2lYSc0ECQ8eJG1FIeLhVY9o0qLsXxyrAawsajvrVQu34pZN
 vWyneycdZ6iComaSDwIOBmEBeHg3+OF3XVIRHj+AsB0WHqwvC/Hlt9PWvLVbu4BSCc5eXZ0PUHB
 YYqz2IZq/9VGh/gl6EaiAcHGZ8DmxF9iA940TCmBEQ3HMGs45qltu9UV/JbiL/f2z8rK6zg==
X-Gm-Gg: AeBDieueKRwz4Xy6iWDKxVgwkdVE51pFudT6hgHVMYYduWRUYeWcyiKu+5dCui2mr98
 6z5cg3ngNeCJE9u9cKWt5JLgRLgrLPyD0363/reC20BkxWOJ/Ru047CI9KThKl/dAXRw4yLnyMr
 fbfr/59H5ZZxenl9XNTULOnG7uaqct50dIi4iqGvRR9dsPty8HVXDHV+vCAcr6m8Bs2vZPj40w9
 R9SwSs3r16I4hkHlGQboSOqsEnOs+D4ikc3rxS0urtcfxRGzjiu8Ly7pu7k07+c8dsfH3ZtJGTt
 6kIOiQu9nZhmFzKiMz200zuYKn4Aggkut7ZTR4Bu1s0ZP20ymBA8MIc7+0eih7tTA63Xd9M6Iv+
 2UO2mKiOWtPEfgyiJH6X0DO0tCewP5//r0kGBfGAv6mPqzKvogadHQR7wAN/e8Q==
X-Received: by 2002:a05:6000:144c:b0:43d:761e:e57a with SMTP id
 ffacd0b85a97d-43d761ee6dbmr25932016f8f.1.1776324875049; 
 Thu, 16 Apr 2026 00:34:35 -0700 (PDT)
X-Received: by 2002:a05:6000:144c:b0:43d:761e:e57a with SMTP id
 ffacd0b85a97d-43d761ee6dbmr25931953f8f.1.1776324874516; 
 Thu, 16 Apr 2026 00:34:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3f92f4sm9751836f8f.34.2026.04.16.00.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:34:34 -0700 (PDT)
Message-ID: <99d0ae68-9168-4c1c-ac72-993f650e5dd9@redhat.com>
Date: Thu, 16 Apr 2026 09:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/mgag200: Simplify offset calculation
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260415152625.101710-1-tzimmermann@suse.de>
 <20260415152625.101710-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260415152625.101710-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7mkWlyRn9Fo9Y6LXn1XVuHT1oTR8sOxcP1j1JUOarUo_1776324875
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

On 15/04/2026 17:23, Thomas Zimmermann wrote:
> The offset value sets the distance in bytes between two consecutive
> scanlines. Reduce the calculation to the minimum.
> 
> According to the Matrox programming manual, Sec 4.6.5, the offset
> is the scanline pitch in bits divided by 128. The field pitches[0] in
> struct drm_framebuffer stores the scanline pitch in bytes, so we have
> to divide by 16 only. Reducing the existing bpp-shift look-up and
> offset calculations also returns exactly this for all formats.
> 
I've sent a similar patch a few years ago with:
https://patchwork.freedesktop.org/patch/531878/?series=116381&rev=1

So that looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/mgag200/mgag200_mode.c | 28 +-------------------------
>   1 file changed, 1 insertion(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index 5b526aebaeb8..57c9f731a4bf 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -298,37 +298,11 @@ void mgag200_set_mode_regs(struct mga_device *mdev, const struct drm_display_mod
>   	WREG8(MGA_MISC_OUT, misc);
>   }
>   
> -static u8 mgag200_get_bpp_shift(const struct drm_format_info *format)
> -{
> -	static const u8 bpp_shift[] = {0, 1, 0, 2};
> -
> -	return bpp_shift[format->cpp[0] - 1];
> -}
> -
> -/*
> - * Calculates the HW offset value from the framebuffer's pitch. The
> - * offset is a multiple of the pixel size and depends on the display
> - * format.
> - */
> -static u32 mgag200_calculate_offset(struct mga_device *mdev,
> -				    const struct drm_framebuffer *fb)
> -{
> -	u32 offset = fb->pitches[0] / fb->format->cpp[0];
> -	u8 bppshift = mgag200_get_bpp_shift(fb->format);
> -
> -	if (fb->format->cpp[0] * 8 == 24)
> -		offset = (offset * 3) >> (4 - bppshift);
> -	else
> -		offset = offset >> (4 - bppshift);
> -
> -	return offset;
> -}
> -
>   static void mgag200_set_offset(struct mga_device *mdev,
>   			       const struct drm_framebuffer *fb)
>   {
>   	u8 crtc13, crtcext0;
> -	u32 offset = mgag200_calculate_offset(mdev, fb);
> +	u32 offset = fb->pitches[0] / 16;
>   
>   	RREG_ECRT(0, crtcext0);
>   

