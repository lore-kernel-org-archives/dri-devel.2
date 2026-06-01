Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43B6CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304E810E762;
	Mon,  1 Jun 2026 11:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HlwNkrI9";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D9810E762
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780312803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mw1aJssJMADYiwtop5nLysiutoOYtsyWQrC1VUIyR8M=;
 b=HlwNkrI9fAEPZc9v2bxlDFlQnAh9EbjAsHyQJW6hF3cDCiJOAqgjdfllBhnzgm0yPZWzJn
 6Z5ANs/n/pYeNZlgBaDJHfP5yVoGms7Rrx8zB8YYzryd4wYmgmIT4+R5JLai6q8KOEUch9
 9hdHXyGJko3DoaaDJ68WhFTdalygDyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-oJsdwytHMPiGa1ec5GrvDg-1; Mon, 01 Jun 2026 07:20:02 -0400
X-MC-Unique: oJsdwytHMPiGa1ec5GrvDg-1
X-Mimecast-MFC-AGG-ID: oJsdwytHMPiGa1ec5GrvDg_1780312801
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a7627763so14133935e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 04:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780312801; x=1780917601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mw1aJssJMADYiwtop5nLysiutoOYtsyWQrC1VUIyR8M=;
 b=b/M6XkmJgKLTcgtBYSZ63JnXU4ecj47l6N3XadloaWSwbETz5oOsXZF5CNzV+L0gJA
 b1aJuC/4Hh8jCnRKlb9B8wYxj+KK6ZJZgtZOuK4aQaMe+jZTqv1ZHCAiRQaogRmf0CLz
 rMsXdbbEcAupLHsTeagJvnzmOjfGLZDOF0/Dw4kQxxUouDvCum08qFth7EsQzbfEkJFc
 SGKRZS8c/F8jMXuJVePlI710UE2bZSDfw9IdmQS/iXVckKdVx4fqkeqMdwMfWpit5SIh
 pqohdSzc+yNowKb9waJSxpdYkuKQ186Y3riwdSQdyoD2kpZwpn+OVAhiCGgyTLG8fbHo
 IM7Q==
X-Gm-Message-State: AOJu0YwO+poTINzjqAQba9ztpVXmoJjx8ZOr4A9WRquAfiQyUz10bAQ8
 Nd+UzsiJmN3Jgwh3V1BV3428zS2LCCxbReL10FcF9ncZ61HJ1+iZ/Rvl+9VA5iThP3sulXnsunQ
 2wyiqBqIC1nonDs308AmeMEl5xkLRjAzcKuj6R/LzqhDIsECLKSzzvArzhJxMalQfNfoqfw==
X-Gm-Gg: Acq92OGP20cfKIFUJqSzrmwXL/cV6VvDmgohbKxzzxOIdue0QnJReUX4nUJINUg7e6/
 230tIHeSnAzATntk7Wn6/CIpM0B7M0BaLG2ragNeZrdWY84z5nzJEHgIUPNXpqsfNVIy/4mFN7o
 02Vb6kRfUUfLFWFz2fF5eCDMXvxNYNexnVZWtN8giLV1PWxOntjtN+kVpjzcYOEr08C1bYn0Yig
 IdxBzWOPYBNoRS5DFxnmR63Bm7zWnXHiJPlo8y3l2DZkGMIeVHUAzjEgxWZMDH2riBuurl9vuv3
 csLArf2j7oSXxnm6XZbh2B1pPUBXRZDVVi/T2oWJesMpWewxh2TsNb4AMpiSOa1UBIcJx1sRLxj
 nQrp1VhFlBLg1ZCP2xS5skHOoL1w44nMKrhm86Zf4zXvvrC5xblLVS/w3YFCFx2NtKi+/BORP
X-Received: by 2002:a05:600c:8b71:b0:490:add9:7f88 with SMTP id
 5b1f17b1804b1-490af395bffmr12333095e9.21.1780312800465; 
 Mon, 01 Jun 2026 04:20:00 -0700 (PDT)
X-Received: by 2002:a05:600c:8b71:b0:490:add9:7f88 with SMTP id
 5b1f17b1804b1-490af395bffmr12332645e9.21.1780312800101; 
 Mon, 01 Jun 2026 04:20:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8?
 ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6eb3adsm244431395e9.11.2026.06.01.04.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 04:19:59 -0700 (PDT)
Message-ID: <f651bfc5-1a8e-4daa-bfae-49547c1e9aeb@redhat.com>
Date: Mon, 1 Jun 2026 13:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/draw: Remove unused helper
 drm_draw_get_char_bitmap()
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-5-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260529140759.529929-5-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XXowd_J3Xh2rqZ9SnVgB4dlTic3312xTWV9svuhk5VU_1780312801
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

On 29/05/2026 16:01, Thomas Zimmermann wrote:
> Glyph-shape lookup has been integrated into the font-data interface
> and all callers have been updated. Remove the old helper.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_draw_internal.h | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
> index 261967145635..44ddcee4744c 100644
> --- a/drivers/gpu/drm/drm_draw_internal.h
> +++ b/drivers/gpu/drm/drm_draw_internal.h
> @@ -7,7 +7,6 @@
>   #ifndef __DRM_DRAW_INTERNAL_H__
>   #define __DRM_DRAW_INTERNAL_H__
>   
> -#include <linux/font.h>
>   #include <linux/types.h>
>   
>   struct iosys_map;
> @@ -18,12 +17,6 @@ static inline bool drm_draw_is_pixel_fg(const u8 *sbuf8, unsigned int spitch, in
>   	return (sbuf8[(y * spitch) + x / 8] & (0x80 >> (x % 8))) != 0;
>   }
>   
> -static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
> -						 char c, size_t font_pitch)
> -{
> -	return font->data + (c * font->height) * font_pitch;
> -}
> -
>   bool drm_draw_can_convert_from_xrgb8888(u32 format);
>   
>   u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);

