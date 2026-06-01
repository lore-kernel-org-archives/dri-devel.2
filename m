Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D1FCD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51635113203;
	Mon,  1 Jun 2026 11:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gJRAuC0l";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03AA3113203
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780312760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuGEK1SkcuHAPgz9gEDQStCi7pNGC+sChcUFL1++fKI=;
 b=gJRAuC0l/J6zxlW9l0X68odnyV+3wT9E2M7oE0h1zdpIV38BDZPvxEWUdSHUyVqPxgahQP
 k0bC5f6MSyfhVGRkI+tr6j6WhbTHjU7Rtl/Ltmb/3XkJ7hQ07z7ksSl3VVlNDvv64EOvsh
 jNsSR1GhEkeMLFSVk2EnNafte3z4C+Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-0Gz22vy8PeKtwFaWGNONDA-1; Mon, 01 Jun 2026 07:19:19 -0400
X-MC-Unique: 0Gz22vy8PeKtwFaWGNONDA-1
X-Mimecast-MFC-AGG-ID: 0Gz22vy8PeKtwFaWGNONDA_1780312758
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a762bcbaso11121095e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 04:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780312758; x=1780917558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GuGEK1SkcuHAPgz9gEDQStCi7pNGC+sChcUFL1++fKI=;
 b=Fmw1EXFAQQs63TRzeSf1tevVjO86AM+bNtkgqa9RggNCis22kVGdNXDd9YHWtyNmyQ
 X+rBNru4+Ye91CLnbXB7/+Qdkx8WK5BU5UB5PT4WoZBT5Atm2G4v4TTje/Zd/qO0wTl2
 WLu8BS3lRHctuUMxSdwAvAIaxtquZhBahRFTtMxlGGjbEwT7yu5h6apbkOIp7JPMGSXp
 NWDKPClOH7woAKEA+qtaSE1tEIMLNn3+kT5trcCf24Ewj8BWN57wwS33cLP7GNPr563d
 vtABGd/xKTJS1ma08C5eOQncnpbo45opxD3ocVKaPGqnmbt3abIue9giUUuBpvoE623j
 F3Sw==
X-Gm-Message-State: AOJu0YxuEOyOJ2jo3VdP8E7V9DyzHngj198UXCJeYAPH9P4+hFKlD8XD
 yv7M0kr698n77kkXXlLow6cltkB71pYgk39aqYV6PWT21yKIkyDBTmYVWOmADSY5cpbrxcnJXEk
 5LGmCkCpWAUZBeF2g7a3FBY+dh/aplBb1ePzcEstKIqU3Hnj8loWUXIdKFIs1D9IturP4og==
X-Gm-Gg: Acq92OFD4VQsqeWm2ctIjDnNZ72y7hkKDQ35xnCoiAmw/Zrz1kDRupsHg9jDHBOW9oN
 sjK+b75M+535ITXIAhrdUFtlmd5vbTZiGcfkoCUDuh+KgBwVM04hvomlhv0gQEvhn5VyAA+gcoO
 kf2coR6iuHGsuhewACezlVrMKe1zC+1z059gCXSkJpTHjGnYxxSvLIwgObGIDOMlgc7A3AXrzIu
 lAIHtcBTN6t/MV9i+tNumBVYX4ghMtQzQLO+2IsX9liplWO98MuLjWoiY52+UHjueBhWSy1XWY0
 bpHN40xCmrWrzqQZjvvsVeqBJ5QUZyGX4Z2G5PdqfsTsE8C8cNBRM2iT7XSymNReHgTfQRmj7Dl
 atTeK9PTeFOQaCn1SbfRIIzvcJY+m2ggH5WhRhLKuDfLBBp2lyDW8Iqgo7LCJ9lI6+r+3kUSK
X-Received: by 2002:a05:600c:1d2a:b0:490:a964:14f8 with SMTP id
 5b1f17b1804b1-490a9641586mr78813375e9.8.1780312756557; 
 Mon, 01 Jun 2026 04:19:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1d2a:b0:490:a964:14f8 with SMTP id
 5b1f17b1804b1-490a9641586mr78811755e9.8.1780312755336; 
 Mon, 01 Jun 2026 04:19:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8?
 ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0e8c1bsm100153935e9.3.2026.06.01.04.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 04:19:14 -0700 (PDT)
Message-ID: <864d92ed-3f54-45c4-8000-167ccc343f11@redhat.com>
Date: Mon, 1 Jun 2026 13:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/client: log: Look up glyph shape with font helper
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-3-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260529140759.529929-3-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KlPveA014htgCUc3MN7fBFCYYLgOh5ohuBVHlhZUcbg_1780312758
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
> Look up glyph shapes with font_data_glyph_buf(). Handle non-existing
> glyphs gracefully. Enable extended ASCII by casting to unsigned char.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 8d21b785bead..e3e02c84a4cf 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -122,10 +122,12 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
>   	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
>   	for (i = 0; i < len && i < scanout->columns; i++) {
>   		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
> -		src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
> -		drm_log_blit(&map, fb->pitches[0], src, font_pitch,
> -			     scanout->scaled_font_h, scanout->scaled_font_w,
> -			     px_width, color);
> +		src = font_data_glyph_buf(font->data, font->width, font->height,
> +					  (unsigned char)s[i]);
> +		if (src)
> +			drm_log_blit(&map, fb->pitches[0], src, font_pitch,
> +				     scanout->scaled_font_h, scanout->scaled_font_w,
> +				     px_width, color);
>   		iosys_map_incr(&map, scanout->scaled_font_w * px_width);
>   	}
>   

