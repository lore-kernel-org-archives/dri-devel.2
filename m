Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC683C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A60710F1A1;
	Fri, 31 Jul 2026 07:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TaHHYffq";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F330A10F1A1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785482472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlfdQUCdawFfgKuWyrR8xpxZg+jcicoefouG9T8fo0o=;
 b=TaHHYffqU8Ypzq/9YVFLEA7/5SeXGRvOuUClaEbC8Yv0zXoAQy9VCFghBAl6SWHw1O+2Q4
 izydVwuhrgmHRfF5Uiy+XUZPbojv9F1htuYOBNvZryl6cJ6ztbjMG65OBMMNk205xa7px6
 GAu8xYC0Hhk46s9RIHF1DeaTJ7aT0iA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-LXngktFWORCVFGOWWaAIwg-1; Fri, 31 Jul 2026 03:21:10 -0400
X-MC-Unique: LXngktFWORCVFGOWWaAIwg-1
X-Mimecast-MFC-AGG-ID: LXngktFWORCVFGOWWaAIwg_1785482469
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-698ac7678f1so600592a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 00:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785482469; x=1786087269;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dlfdQUCdawFfgKuWyrR8xpxZg+jcicoefouG9T8fo0o=;
 b=U+qq+s3D7bdRW3+EZrv6Bl79SAcD520rRscdKHN7/FRCh+m+WXffNOygMBaHs/kjZt
 AxOeHec/ATT5Ikd49TyGmCw0aqZ4ch/eGMfd1KrysLn8/A8hy4y/8hWmyrvao6YTFpcy
 joydqUpPGR1Rnpsr8ewJW0041l7HO26dk7NxQPJN+DdUQFhJfjUESUT6SqYSiYUminpI
 nj7Gsu6nUr6oq1jFxJF9rotqALMDr/9EuwY01ZHW7KyPJkTBb6UBoZ8w7EQKtBcVdBtd
 vjfKF4HbW6Qe1IWgwJD+tPcbxYaZ/Gqa2SLdbwvT3UQ1cPwDmfPibl5GF0kx0LlvGJXl
 s++w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqc7HFPoySjb0GmLSnRU+DSn72L+ze1T0NrCSFPZZIFXMJZcVUMZN7KzSL8VNPG1mVOtGAjzIXQM/0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxaObJ4JctSTxuXgjYfXa5T2jrVdt8sqiOkgMYuJT7FdccKSv3H
 RAckISJToZg7VaYlvKgxoo/ikkaA8Mz4IqMy9RxKX/V3Kw9Afk0NvkNBfzq1I2lHZSpG6/0oapJ
 RvKkP0WZ5rh9Yv7ahnnNiNJrw0DTW68iejv9D2AsFpZVLxRrlgEHAq4/m6OeuGEDz58QbqQ==
X-Gm-Gg: AR+sD13d/4DUwZ9QlpN6Mux9t/rn3ZizVPPrxoA5+tNo/HTynBtpzGJxkQaUoiGf6cv
 y35MofbFY/99rAvBjgHMW7B1Ix2LlRQN8edB0Ov1ZUx262yYeo/HDs29C4FVrd3Mr2NA4J9YsM1
 c4z6ZD2Ddrk2La9a1PszVBYbRBnfKsibjoZH+pmeVWKIrhyZY/Nya2JJsrrcEGYEs5eAJrsCA4o
 5ri9Q3NJlmp4CbeTgkoTvQhBPd/6mvTMeWc36/0fqICcIhrCaShem0+KGA34HI1k545cl8eDYb+
 pd7LKW1dudwSOhp1wkVrolKYJp1/WZ6UfPL5E+JRoUvD60g/PPBrU5BNKeoUWCSeaOHlPykGUoq
 4pHMFAcd23kOGX2zIJYyREJMre3WCw1zPLHhg+CXDTELgpw==
X-Received: by 2002:a05:6402:530d:b0:698:52b4:c2c8 with SMTP id
 4fb4d7f45d1cf-6a098cfa3e3mr404728a12.34.1785482469180; 
 Fri, 31 Jul 2026 00:21:09 -0700 (PDT)
X-Received: by 2002:a05:6402:530d:b0:698:52b4:c2c8 with SMTP id
 4fb4d7f45d1cf-6a098cfa3e3mr404719a12.34.1785482468774; 
 Fri, 31 Jul 2026 00:21:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51?
 ([2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c5a09acsm362236a12.4.2026.07.31.00.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 00:21:08 -0700 (PDT)
Message-ID: <b5205a31-9df8-426c-a95d-af64a3a27207@redhat.com>
Date: Fri, 31 Jul 2026 09:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/log: Batch vmap/vunmap and flush for record drawing
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20260730105950.670892-1-oushixiong1025@163.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260730105950.670892-1-oushixiong1025@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YMKpjibd7Bd2-8zeCU1jl-jj09Aa6xpQHSZSS2FcQsM_1785482469
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

On 30/07/2026 12:59, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> drm_log_draw_new_line() calls drm_log_clear_line() and drm_log_draw_line(),
> which independently call drm_client_buffer_vmap_local(),
> drm_client_buffer_vunmap_local(), and drm_client_buffer_flush(). For each
> call to drm_log_draw_new_line(), this results in 2 vmap/vunmap pairs and
> 2 flush calls, even though vmap_local maps the entire framebuffer
> each time.
> 
> Refactor drm_log_clear_line() and drm_log_draw_line() to accept a
> pre-mapped iosys_map by value, removing the per-line vmap/vunmap/flush
> calls. Move the single vmap/vunmap pair and flush up to
> drm_log_draw_new_line(), which now maps once before clearing and
> drawing, then issues a single flush after unmapping.
> 
> Also remove the now-unused drm_rect from both functions.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> v1->v2:
>     Remove unused drm_rect from drm_log_clear_line() and
>     drm_log_draw_line().
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index ac10c978f917..52563e2a1c45 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -94,37 +94,28 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>   	}
>   }
>   
> -static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line)
> +static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line,
> +			       struct iosys_map map)
>   {
>   	struct drm_framebuffer *fb = scanout->buffer->fb;
>   	unsigned long height = scanout->scaled_font_h;
> -	struct iosys_map map;
> -	struct drm_rect r = DRM_RECT_INIT(0, line * height, fb->width, height);
>   
> -	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
> -		return;
> -	iosys_map_memset(&map, r.y1 * fb->pitches[0], 0, height * fb->pitches[0]);
> -	drm_client_buffer_vunmap_local(scanout->buffer);
> -	drm_client_buffer_flush(scanout->buffer, &r);
> +	iosys_map_memset(&map, line * height * fb->pitches[0], 0, height * fb->pitches[0]);
>   }
>   
>   static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
> -			      unsigned int len, unsigned int prefix_len)
> +			      unsigned int len, unsigned int prefix_len,
> +			      struct iosys_map map)
>   {
>   	struct drm_framebuffer *fb = scanout->buffer->fb;
> -	struct iosys_map map;
>   	const struct font_desc *font = scanout->font;
>   	size_t font_pitch = DIV_ROUND_UP(font->width, 8);
>   	const u8 *src;
>   	u32 px_width = fb->format->cpp[0];
> -	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * scanout->scaled_font_h,
> -					  fb->width, (scanout->line + 1) * scanout->scaled_font_h);
>   	u32 i;
>   
> -	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
> -		return;
> +	iosys_map_incr(&map, scanout->line * scanout->scaled_font_h * fb->pitches[0]);
>   
> -	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
>   	for (i = 0; i < len && i < scanout->columns; i++) {
>   		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
>   		src = font_data_glyph_buf(font->data, font->width, font->height,
> @@ -139,21 +130,40 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
>   	scanout->line++;
>   	if (scanout->line >= scanout->rows)
>   		scanout->line = 0;
> -	drm_client_buffer_vunmap_local(scanout->buffer);
> -	drm_client_buffer_flush(scanout->buffer, &r);
>   }
>   
>   static void drm_log_draw_new_line(struct drm_log_scanout *scanout,
> -				  const char *s, unsigned int len, unsigned int prefix_len)
> +				  const char *s, unsigned int len,
> +				  unsigned int prefix_len)
>   {
> +	struct iosys_map map;
> +	struct drm_framebuffer *fb = scanout->buffer->fb;
> +	u32 height = scanout->scaled_font_h;
> +	u32 line = scanout->line;
> +	u32 y2;
> +	struct drm_rect dirty;
> +
> +	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
> +		return;
> +
>   	if (scanout->line == 0) {
> -		drm_log_clear_line(scanout, 0);
> -		drm_log_clear_line(scanout, 1);
> -		drm_log_clear_line(scanout, 2);
> -	} else if (scanout->line + 2 < scanout->rows)
> -		drm_log_clear_line(scanout, scanout->line + 2);
> +		drm_log_clear_line(scanout, 0, map);
> +		drm_log_clear_line(scanout, 1, map);
> +		drm_log_clear_line(scanout, 2, map);
> +		y2 = min(3, scanout->rows) * height;
> +	} else if (scanout->line + 2 < scanout->rows) {
> +		drm_log_clear_line(scanout, scanout->line + 2, map);
> +		y2 = (line + 3) * height;
> +	} else {
> +		y2 = (line + 1) * height;
> +	}
> +
> +	drm_log_draw_line(scanout, s, len, prefix_len, map);
> +
> +	drm_client_buffer_vunmap_local(scanout->buffer);
>   
> -	drm_log_draw_line(scanout, s, len, prefix_len);
> +	dirty = DRM_RECT_INIT(0, line * height, fb->width, y2 - line * height);
> +	drm_client_buffer_flush(scanout->buffer, &dirty);
>   }
>   
>   /*
> --
> 2.25.1
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 

