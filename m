Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B752CC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133BF10ECAC;
	Wed, 29 Jul 2026 15:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TKCkTYrs";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFC710ECAC
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785339475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vf6pfIfaVLMFzvLPsE8ryO6B6y5q/a5WhsnlX5GEQB4=;
 b=TKCkTYrs0sL7WlhP64Un2hHvXVwriBadJn8Yn/lpI/4lbf2IMc6jnKtu+YF9I+jZnLj+qk
 cj3HGTWL8h6cc7mZluRGxa77dXIoRJKfREdSv6o6BxHpNSVYPE+cqR41Nv2EQiKIrMIpwZ
 RT9yjGf3uemVFOomawF0BnsJ32AXf/M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-2QDvcLNWNI2nca4acvfnww-1; Wed, 29 Jul 2026 11:37:54 -0400
X-MC-Unique: 2QDvcLNWNI2nca4acvfnww-1
X-Mimecast-MFC-AGG-ID: 2QDvcLNWNI2nca4acvfnww_1785339473
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f7700ffdeso506713f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339473; x=1785944273;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vf6pfIfaVLMFzvLPsE8ryO6B6y5q/a5WhsnlX5GEQB4=;
 b=JEuQw/kLhDFrPhd3J/zVA/Kka3jMcag3Bm7KYuhfnCOJReuyCiJe5uW1R5nz8IVG9I
 LEUE+NNMw7v/5lhiM81V+D60Del0EhXycJnsykh6UuWylejtZonf4FDLGnAFnHUweNFP
 MiAhexve9tHLARFREozYaYo+AXWY3kSGvh8gp9m/ilwc3XYD6RSzbguGgjOdzFs90EsF
 fPjXkEP62KvJZXBVOlY+wC8XWhVk2vET9wyxGIFG7WPaEGmCqF4u3KSpI1dJsiO+Ogtn
 C1VbRCA2q+Gpi+IAo+BIPwKPsUdcOfIo3G4zdeICnyUrI2CZ78IefFGQQDRQZPUeJtTS
 CAPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8EPOUZH/Esbj1xbJ2rJvHvu8wqOCRuPVNCVSANdYllujlyFyndnq8FxlVauJmK6egRIz8VJX8aSo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiFIY4AafnRWFS9a+0ACsIAbVL6RhLxrkGMEExA058U+W6Dsvl
 xlnHA7IWCGFdiqJgdwaohUIyWOMf6yJ1QUw9BM6yoImxxNkC+fx+KuaFUUTN4pL1FkOG024Qm8n
 cHD3jiz0kzXDr1lfE30cqiUlpEucUBC2bUYB3/Rq2QBy4lp0prqfebtJlrvuJjZrddoRRSkPITz
 iJWw==
X-Gm-Gg: AR+sD11ECtuG5fPrNE50SoYclHxuLdQ1LAhOBqHC9kj7pU1OllOHZhsmHdGnWO40Vwr
 k3k2BGon2WHct6jbEjLJ6i8pwtESpbiNDYU5zDiKgzCd8Z3qLeRTOGYS+gfRbnr/FUEWVD0hLWv
 yrHqxv0CQ5hJ87JVU66YIkjoKRotV2AjI2eTjAPPnxJmUmmo1iehm+Sj6qrs23QvqQyXVv5P+/v
 ZbpituZp50eIg/3pRCDHVNIjuOEHO+HsQecdFovQiBAdQav3bMNabwFoUpkqYc76niNocah/u6t
 gfcIPrG70zeRt5jKwTkWdCLMAXcnJEcx5SqUQt3/47hZQEhk958gMicc5IT8pIhBR449dZTh+cT
 NRZns3x7TQhIacb1UTSdP6dl+IDRfO0PBVrE0DdBQo52NTg==
X-Received: by 2002:a05:600c:4583:b0:495:44f3:4576 with SMTP id
 5b1f17b1804b1-496c64130a6mr75389525e9.7.1785339472783; 
 Wed, 29 Jul 2026 08:37:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4583:b0:495:44f3:4576 with SMTP id
 5b1f17b1804b1-496c64130a6mr75389125e9.7.1785339472257; 
 Wed, 29 Jul 2026 08:37:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51?
 ([2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4615f5fsm156433295e9.9.2026.07.29.08.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 08:37:51 -0700 (PDT)
Message-ID: <bfb7df7d-8d50-49e5-b6b5-a8d06aec7e1a@redhat.com>
Date: Wed, 29 Jul 2026 17:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/log: Batch vmap/vunmap and flush for record
 drawing
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
References: <20260729084823.693723-1-oushixiong1025@163.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260729084823.693723-1-oushixiong1025@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IqQNiVsespVUA6hcJloUpRGa145WGpUbhEAY5KhfdiU_1785339473
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

On 29/07/2026 10:48, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> drm_log_draw_new_line() calls drm_log_clear_line() and
> drm_log_draw_line(), which independently call
> drm_client_buffer_vmap_local(), drm_client_buffer_vunmap_local(),
> and drm_client_buffer_flush(). For each call to
> drm_log_draw_new_line(), this results in 2 vmap/vunmap pairs and
> 2 flush calls, even though vmap_local maps the entire framebuffer
> each time.
> 
> Refactor drm_log_clear_line() and drm_log_draw_line() to accept a
> pre-mapped iosys_map by value, removing the per-line vmap/vunmap/flush
> calls. Move the single vmap/vunmap pair and flush up to
> drm_log_draw_new_line(), which now maps once before clearing and
> drawing, then issues a single flush after unmapping.

Thanks, it looks good to me.

I think you just need to remove the drm_rect in drm_log_clear_line() and 
drm_log_draw_line(), as they are not used anymore.

Best regards,

-- 

Jocelyn

> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 52 ++++++++++++++++++++-----------
>   1 file changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 63577aeb705c..4896b3e00710 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -109,25 +109,21 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
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
>   	struct drm_rect r = DRM_RECT_INIT(0, line * height, fb->width, height);

only r.y1 is used, so you can remove this rectangle declaration

>   
> -	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
> -		return;
>   	iosys_map_memset(&map, r.y1 * fb->pitches[0], 0, height * fb->pitches[0]);
> -	drm_client_buffer_vunmap_local(scanout->buffer);
> -	drm_client_buffer_flush(scanout->buffer, &r);
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
> @@ -136,10 +132,9 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
>   					  fb->width, (scanout->line + 1) * scanout->scaled_font_h);
>   	u32 i;

same here, the drm_rect r, can be removed.>
> -	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
> -		return;
>   
>   	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
> +
>   	for (i = 0; i < len && i < scanout->columns; i++) {
>   		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
>   		src = font_data_glyph_buf(font->data, font->width, font->height,
> @@ -154,21 +149,40 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
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

