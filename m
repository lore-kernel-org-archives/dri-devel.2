Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A00F43841
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4028810E82D;
	Thu, 16 Apr 2026 07:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="h7vZji4a";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A515B10E82D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776325119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2hbegIZIOb/isl7Ygsd2jiGcSALGpeCnfsmVa9LT9M=;
 b=h7vZji4aajV4MiGhuC0BjcHVhN4t7zn07CEN/taZujhG7CwDCJBCqgcMVi6LgjhM/mEEkw
 IHxOwot6u5ulyaciYkNWo4GfP8orzAPSlFy0rE77+zaHPepUjeRFO/XPaAiXXAFIy0Tm/u
 Azh24nykrCah5VRQL9Ar5etZ77BwWkQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-RdBmbc-JM82TFTSkbW8kJg-1; Thu, 16 Apr 2026 03:38:37 -0400
X-MC-Unique: RdBmbc-JM82TFTSkbW8kJg-1
X-Mimecast-MFC-AGG-ID: RdBmbc-JM82TFTSkbW8kJg_1776325116
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d6ebe9cfso51822255e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776325116; x=1776929916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2hbegIZIOb/isl7Ygsd2jiGcSALGpeCnfsmVa9LT9M=;
 b=nvHnee327SIKGfOM8jEkFJ2cWAKoQws3WCs/aY1hsaDNkwBi24rTIzRWcaaJaxR5yW
 9DBT2vLPJ3VEO8aaKzoOWzIMmFh8F4whsY5dPgwwCjOvYbCeSAM1H413ASqFvhaNc4Id
 l7pVV4vPzYNTrl87w6JuKbiPRO6QJ4bvHbJ2nGDICylCAhXC99udTDK7CJ5rvypk4BIf
 7Y/onYfhMNjVi8RqZxJryNnSpn1l9oz/GQwIhOOFUbjCNmuTbDvJXI1HvDrxMA7I280t
 kg7zLtnLuhFMlig7FGlMZb8UzBQN5br3S8O0ltPWTBcAmWUpHKc6TmZbvvECWx4uLOUp
 z1jg==
X-Gm-Message-State: AOJu0YyvbLZ9nYkm+5nOawYexf640KawlnD/p422Ij+JyvwUnPVzwr9V
 QJXz3rHl0AXCu2PUiak5xvTphmXDvtyLmHSzFjECjcBT2lJBN42834n8vWvrMUxlfkSw0lMuTZ1
 94DNHaXd5pu+Z7qSn0zw7T8MtZJPxLBucne8+1j62LK4cWSQkBE/49jcp1nAFz2aJ9hH1ww==
X-Gm-Gg: AeBDiev7K0AFCBKRXsUnr1ZyEEes6LOjefbeT4la3i2o8FQrRYgKoRUI/y9QFWAElnU
 cbfMNnHlzU0X+kNMFNn+UMds+Mw2Xhbgpi5Ug9iD74wqYCnruVJg4ibK8gbC6ZhfphbzerZZL9M
 DZ5M2phGxpiHTHr4qUqnz9eBZoyVs+GzFFg9vBdXUkduzxhk4Ld9wYrFdjcU3/YchAFf/4xGOq+
 r2NyNWjl9dX9Qo6N+Zr9VmLkGH+VniZniMnhxTJybrGsvi7n94g1zhds7DSc079PMXhfRIu/TBt
 Qvslb3Ne/erxDP0DUOetw8bzj4jV44j0D2yt1HPIyq+uNPvZMJDHGHk6nWPyMCf62KbpQzMibhR
 F8j+GcCXtg3G2h+Jc0T8AoOXOxt7wEGhAzIlehd8Je6sCu6Un9xGcyLitYys1dQ==
X-Received: by 2002:a05:600c:8907:b0:488:a14d:3d8e with SMTP id
 5b1f17b1804b1-488d67f4c6fmr242120465e9.11.1776325116103; 
 Thu, 16 Apr 2026 00:38:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8907:b0:488:a14d:3d8e with SMTP id
 5b1f17b1804b1-488d67f4c6fmr242119675e9.11.1776325115065; 
 Thu, 16 Apr 2026 00:38:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5827da4sm29779215e9.14.2026.04.16.00.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:38:34 -0700 (PDT)
Message-ID: <1fa8f10a-5bdc-459f-ad4d-596eaf33de34@redhat.com>
Date: Thu, 16 Apr 2026 09:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/mgag200: Enable DRM_FORMAT_XRGB1555 on the
 primary plane
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260415152625.101710-1-tzimmermann@suse.de>
 <20260415152625.101710-7-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260415152625.101710-7-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ARelI2eMzzLYjpRDFFgR2azffdndZ9jP4srTtEz3fyA_1776325116
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
> The driver already sets the format for the depth value in the XMULCTRL
> register. Add the format to the other switch statements, set the helpers
> for gamma correction and export the XRGB1555 in the primary plane's
> format array.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/mgag200/mgag200_g200se.c | 1 +
>   drivers/gpu/drm/mgag200/mgag200_mode.c   | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> index 746ce11b75fb..5c2185d6b707 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> @@ -82,6 +82,7 @@ static void mgag200_g200se_set_hiprilvl(struct mga_device *mdev,
>   			bpp = 32;
>   			break;
>   		case DRM_FORMAT_RGB565:
> +		case DRM_FORMAT_XRGB1555:
>   			bpp = 16;
>   			break;
>   		case DRM_FORMAT_C8:
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index 7fe1d492083e..bd346b828773 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -59,6 +59,9 @@ void mgag200_crtc_fill_gamma(struct mga_device *mdev,
>   	case DRM_FORMAT_C8:
>   		drm_crtc_fill_palette_8(crtc, mgag200_set_gamma_lut);
>   		break;
> +	case DRM_FORMAT_XRGB1555:
> +		drm_crtc_fill_gamma_555(crtc, mgag200_set_gamma_lut);
> +		break;
>   	case DRM_FORMAT_RGB565:
>   		drm_crtc_fill_gamma_565(crtc, mgag200_set_gamma_lut);
>   		break;
> @@ -83,6 +86,9 @@ void mgag200_crtc_load_gamma(struct mga_device *mdev,
>   	case DRM_FORMAT_C8:
>   		drm_crtc_load_palette_8(crtc, lut, mgag200_set_gamma_lut);
>   		break;
> +	case DRM_FORMAT_XRGB1555:
> +		drm_crtc_load_gamma_555_from_888(crtc, lut, mgag200_set_gamma_lut);
> +		break;
>   	case DRM_FORMAT_RGB565:
>   		drm_crtc_load_gamma_565_from_888(crtc, lut, mgag200_set_gamma_lut);
>   		break;
> @@ -180,6 +186,7 @@ static void mgag200_set_datasiz(struct mga_device *mdev, u32 format)
>   
>   	/* Big-endian byte-swapping */
>   	switch (format) {
> +	case DRM_FORMAT_XRGB1555:
>   	case DRM_FORMAT_RGB565:
>   		opmode |= 0x10100;
>   		break;
> @@ -443,6 +450,7 @@ static void mgag200_handle_damage(struct mga_device *mdev, const struct iosys_ma
>   const uint32_t mgag200_primary_plane_formats[] = {
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_XRGB1555,
>   	DRM_FORMAT_RGB888,
>   	DRM_FORMAT_C8,
>   };

