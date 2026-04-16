Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317DEF8809B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC9A10E829;
	Thu, 16 Apr 2026 07:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VU01Z0D5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91CB10E829
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776324740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7a3oYw9PFnMq5UJb2LyKYnaDhHWc1jDkpjpnGzMLyAo=;
 b=VU01Z0D5o+KUGfoWAVsu8nnXsRbiuruxlnsTxeUh5UslRV2DYO5ZRBl9BTizzjWB+22oQP
 ZUAMTOSlRdhUETdT2U6CQ+Yxp1wIQKhKcXs5V86bodKrldzZ1sZt/LaRmJH0QiefcFE032
 a6F8ObgeTLFVADyByQ5lFU2LGt4EFG8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-An39KK5XNYW-ju-c4K-XZw-1; Thu, 16 Apr 2026 03:32:18 -0400
X-MC-Unique: An39KK5XNYW-ju-c4K-XZw-1
X-Mimecast-MFC-AGG-ID: An39KK5XNYW-ju-c4K-XZw_1776324738
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d7730e9e3so2445602f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324737; x=1776929537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7a3oYw9PFnMq5UJb2LyKYnaDhHWc1jDkpjpnGzMLyAo=;
 b=LjX5RT9kJTrfejv4I8xUN7jT5S9BN5A2o9cXLGjH3HS0R9nB88wGFnpOEW6gZ8Vab/
 UOZsztaMcpEoh4PxF3QIqy8TFYuyT/m+TMbSI/tPGb+LzqOFzU0bW6iAHP/Ev+M2EDxc
 7X+xYnStPE2D744B5qCDXgB/dD+HcZn2ALPIFxSMgJWNABC7Bk9vHPjvSWjNNb/8FkkE
 yDjUUbmRBru9vlGXBmzkprIMCOouNWt+qu2x0JtZHL7zLj/UTEUvVLydAhnKlbg7xcUF
 E+6w4DDBoVgPzp173imw4J72HaPewko+dTX4M0OgGnpuhXmdEAO4Rvpz8xilX/np6nBW
 u1ZQ==
X-Gm-Message-State: AOJu0YxqdTb00bPm7u//nMOEx7v6JPI6qYj6Vd4b7x7LvHymAGZDdbgb
 yiQ4oQmoq4tWXpaE14fa0fuLWf/2zg17pDRHtcKw+xWzSldsgPh3iuUrSqUyrmBAwecu10qJiE0
 OhLBQcg8wFHL/IWIw9VeAZZDHjUL2b6xRjgfx2TQGBt4ntMKvQmYYRYFyBtrOlOsc1n/cNw==
X-Gm-Gg: AeBDieva+BUfo1GJsFcvsMibSjuTDmx6EgqcBcz2yVvBQV/B9erqTQO4UQ0ZNabJlaB
 ztczRUrBhdq8UbbTiQJzRwA57hx+MRFiukXBWVmcRMjR7IfufmyDw1GoWHzwqDQsioBDmhIDGR1
 NTI4FYQEC8aafBUctXi906sbUI+q+f9xQ5ZwfxD5Z4kZ3d8lSEfFA8gZHcGCvH6YNoVUZMtsJUu
 yvomRS67iwbPte1ZTEj2dEq9Ff0z3zHY/+/FgTRGscnAzPXo/wxaHdS2+LWb48ShjujSPeLCp2c
 Xs2F39thbB5cpew7H0drdOqjfsCr5gdl5lYPDnIdUshuZPXE49bdmcRSoRYD8Se63A4HSuTxu2g
 V4DQ7cSNnDbuZRpngXDXhofJQ4AW82+EQVorptxJj/WtuK8KvJmTfmUuBGwIB+Q==
X-Received: by 2002:a05:6000:400e:b0:43d:1c39:26fd with SMTP id
 ffacd0b85a97d-43d642dc79bmr37070912f8f.43.1776324737414; 
 Thu, 16 Apr 2026 00:32:17 -0700 (PDT)
X-Received: by 2002:a05:6000:400e:b0:43d:1c39:26fd with SMTP id
 ffacd0b85a97d-43d642dc79bmr37070858f8f.43.1776324736931; 
 Thu, 16 Apr 2026 00:32:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3ebd38sm11904148f8f.31.2026.04.16.00.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:32:16 -0700 (PDT)
Message-ID: <7782a8ac-c319-4a5e-a95a-37d5fc0bd5c5@redhat.com>
Date: Thu, 16 Apr 2026 09:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/mgag200: Set scale from DRM format
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260415152625.101710-1-tzimmermann@suse.de>
 <20260415152625.101710-3-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260415152625.101710-3-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jeIMawPpuh4S8q2jujE3kdGRrtKzc51b4i0jvHX_TiA_1776324738
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
> Replace the deprecated cpp value from struct drm_format_info with the
> format's 4CC code when setting the scale value in CRTCEXT3. While at it,
> remove the scale variable and add a mask constant.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/mgag200/mgag200_mode.c | 30 +++++++++++++++-----------
>   drivers/gpu/drm/mgag200/mgag200_reg.h  |  1 +
>   2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index 316413d814ae..5b526aebaeb8 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -343,24 +343,31 @@ static void mgag200_set_offset(struct mga_device *mdev,
>   
>   void mgag200_set_format_regs(struct mga_device *mdev, const struct drm_format_info *format)
>   {
> -	unsigned int bpp, bppshift, scale;
>   	u8 xmulctrl = 0;
>   	u8 crtcext3;
>   
> -	bpp = format->cpp[0] * 8;
> +	RREG_ECRT(3, crtcext3);
>   
> -	bppshift = mgag200_get_bpp_shift(format);
> -	switch (bpp) {
> -	case 24:
> -		scale = ((1 << bppshift) * 3) - 1;
> +	switch (format->format) {
> +	case DRM_FORMAT_C8:
> +		crtcext3 &= ~MGAREG_CRTCEXT3_SCALE_MASK;
> +		crtcext3 |= 0x0;
>   		break;
> -	default:
> -		scale = (1 << bppshift) - 1;
> +	case DRM_FORMAT_XRGB1555:
> +	case DRM_FORMAT_RGB565:
> +		crtcext3 &= ~MGAREG_CRTCEXT3_SCALE_MASK;
> +		crtcext3 |= 0x01;
> +		break;
> +	case DRM_FORMAT_RGB888:
> +		crtcext3 &= ~MGAREG_CRTCEXT3_SCALE_MASK;
> +		crtcext3 |= 0x02;
> +		break;
> +	case DRM_FORMAT_XRGB8888:
> +		crtcext3 &= ~MGAREG_CRTCEXT3_SCALE_MASK;
> +		crtcext3 |= 0x03;
>   		break;
>   	}
>   
> -	RREG_ECRT(3, crtcext3);
> -
>   	switch (format->format) {
>   	case DRM_FORMAT_C8:
>   		xmulctrl = MGA1064_MUL_CTL_8bits;
> @@ -379,9 +386,6 @@ void mgag200_set_format_regs(struct mga_device *mdev, const struct drm_format_in
>   		break;
>   	}
>   
> -	crtcext3 &= ~GENMASK(2, 0);
> -	crtcext3 |= scale;
> -
>   	WREG_DAC(MGA1064_MUL_CTL, xmulctrl);
>   
>   	WREG_GFX(0, 0x00);
> diff --git a/drivers/gpu/drm/mgag200/mgag200_reg.h b/drivers/gpu/drm/mgag200/mgag200_reg.h
> index d4fef8f25871..088b6c16f7f6 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_reg.h
> +++ b/drivers/gpu/drm/mgag200/mgag200_reg.h
> @@ -265,6 +265,7 @@
>   #define MGAREG_CRTCEXT1_HRSTEN		BIT(3)
>   
>   #define MGAREG_CRTCEXT3_MGAMODE		BIT(7)
> +#define MGAREG_CRTCEXT3_SCALE_MASK	GENMASK(2, 0)
>   
>   /* Cursor X and Y position */
>   #define MGA_CURPOSXL 0x3c0c

