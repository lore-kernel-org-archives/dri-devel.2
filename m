Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80377CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D74113200;
	Mon,  1 Jun 2026 11:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LeCY7vSI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12DD1131FE
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780312725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6mo8ZBNI+D8bVnfzYhv3FnsH9wtvJpIKQXiEBDOnCQ=;
 b=LeCY7vSIg9hZfIVVFMp+Mo827u/9QDAmLOr7QTUUq2LKJUCefeoQ3f7o/pZ/G4sln9bNix
 HNi3kvjUSZ+vRBfpwnA0X6ko4jwOoUDPTj99wqOZ1RF5QnFcoZ+CffpBuqc5RT3/hv8urk
 CIA6WY8EAqLNKc7X5P3+54voAFOqR9s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-t279Rr0SMUOy7rwsaTzytg-1; Mon, 01 Jun 2026 07:18:44 -0400
X-MC-Unique: t279Rr0SMUOy7rwsaTzytg-1
X-Mimecast-MFC-AGG-ID: t279Rr0SMUOy7rwsaTzytg_1780312723
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4903dcb32f8so86661295e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 04:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780312723; x=1780917523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6mo8ZBNI+D8bVnfzYhv3FnsH9wtvJpIKQXiEBDOnCQ=;
 b=EnHpU45Nk40IOT6iqCuYxUDfP9zPoUJdRm1MdRgFaC7AhBvJc+CW5PxyDy6XvIl545
 i8rrdV87DDz7RVG1q+EOZr3FMtCdgOd8+8r/hs3kX27dCHP2BHER6qES6Ceck6fM5UVO
 bj4HVPKZXmOGzTY58LgpNNyTOuB+xUcGXRDDAX6C1rtqoPvOD7ttudkIJWqlLxD5Flkn
 ffUEnfa26k/1sbVEhZsdxZmMdY+38GwnsBOwqIJJa+c2uxFHpYBDKqs/faqEslfoN2+F
 LAWTJ1it2dslHIN3WV66N3rgqUvou/oOUYkCkpUNGiBk0QRFnzuFvgp7DUHsCW8tIoIq
 VRug==
X-Gm-Message-State: AOJu0Yyjbocx4fCVHk9X+zDiWHwXtAcYpNBGcpGFPIwKyvHVtHChelOY
 PURpC7mzxMiLGMRFKvzeQ32BqztFnBUuZHl9z1X/ZCKfHOJHEG0M7ay0VNxu/k3lf2bNy89UdE5
 UZVDo38CmrwjcyItBIgsm9sonLa+YjN2OoAyt5TwX/xJoEQCvs/PfqR/V+F3zXi9pZq2qSg==
X-Gm-Gg: Acq92OHT9bMLHXfRmoa4GH3DynYCA+gRJiRV/bQxH/9i8iJjwAVew3ThoEpnj8gA784
 LA824HhJQdhlOsZ5nImc9635tXctUVZVR6SBOxhRkfEuWAUvY7y4My4hoQLMluIOcM7YwgF+7cV
 hF56pukdjI7INRyoAOI6XZ7kOIc0+BNGNO111oiHRRiM0chzgDrQRA1oFFgm6whcyJFMkudbEvd
 Q25TCnRVDrRM+xIDoTDO6YqPfsGTmW9WGCyEm+9DGo77Jbnh0PJcvPgx6JflbECngM0NUqjuucV
 qDZD92E7Xa11igHYKPiw3KnGrmosBIb9SUHxk3Le3j+6cOi0Fmmgbg3wXrozwp+9T7LkQ8XZoLi
 HCsdcp0JVsvuDHccMDHLcOZv8m0DzRX3Br+FPJuC8c/Dx71ZkUo5Em2OUcDrI7F0B4pEIz2ga
X-Received: by 2002:a05:600c:2242:b0:490:5321:2466 with SMTP id
 5b1f17b1804b1-490a2941ea3mr123965175e9.20.1780312723041; 
 Mon, 01 Jun 2026 04:18:43 -0700 (PDT)
X-Received: by 2002:a05:600c:2242:b0:490:5321:2466 with SMTP id
 5b1f17b1804b1-490a2941ea3mr123964885e9.20.1780312722684; 
 Mon, 01 Jun 2026 04:18:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8?
 ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a04e2sm22332510f8f.1.2026.06.01.04.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 04:18:42 -0700 (PDT)
Message-ID: <db9abca9-0174-46fc-8952-aaa23a4e4574@redhat.com>
Date: Mon, 1 Jun 2026 13:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] lib/fonts: Look up glyph data with
 font_data_glyph_buf()
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-2-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260529140759.529929-2-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qRZI02-HqT0y_dHE1jyn2v7Vt_RkViCA_0trMzFGxws_1780312723
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
> Add font_data_glyph_buf() to retrieve a character's glyph data or NULL
> otherwise. Console fonts can currently contain 256 or 512 glyphs. The
> kernel-internal characters are of type char, unsigned short or unsigned
> int. Catch all of them by accepting unsigned int. Callers possibly have
> to cast from signed to unsigned types to reach all glyphs in a font.

Thanks, yes I missed to check font_data_num_glyphs(), and using signed 
index is also problematic.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   include/linux/font.h |  3 +++
>   lib/fonts/fonts.c    | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/font.h b/include/linux/font.h
> index 6845f02d739a..ea23b727388b 100644
> --- a/include/linux/font.h
> +++ b/include/linux/font.h
> @@ -101,6 +101,9 @@ font_data_t *font_data_import(const struct console_font *font, unsigned int vpit
>   void font_data_get(font_data_t *fd);
>   bool font_data_put(font_data_t *fd);
>   unsigned int font_data_size(font_data_t *fd);
> +const unsigned char *font_data_glyph_buf(font_data_t *fd,
> +					 unsigned int width, unsigned int vpitch,
> +					 unsigned int c);
>   bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
>   int font_data_export(font_data_t *fd, struct console_font *font, unsigned int vpitch);
>   
> diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
> index f5d5333450a0..4fc66722d00d 100644
> --- a/lib/fonts/fonts.c
> +++ b/lib/fonts/fonts.c
> @@ -178,6 +178,37 @@ unsigned int font_data_size(font_data_t *fd)
>   }
>   EXPORT_SYMBOL_GPL(font_data_size);
>   
> +static unsigned int font_data_num_glyphs(font_data_t *fd, unsigned int width, unsigned int height)
> +{
> +	return font_data_size(fd) / font_glyph_size(width, height);
> +}
> +
> +/**
> + * font_data_glyph_buf() - Returns the glyph for a specific character as raw bytes
> + * @fd: The font data
> + * @width: The glyph width in bits per scanline
> + * @vpitch: The number of scanlines per glyph
> + * @c: The character
> + *
> + * Glyphs start at fixed intervals within the font data. font_data_glyph_buf()
> + * returns the glyph shape of the specified character. If no such glyph
> + * exists in the font, it returns NULL.
> + *
> + * Returns:
> + * The character's raw glyph shape, or NULL if no glyph exists for the character. The
> + * provided buffer is read-only.
> + */
> +const unsigned char *font_data_glyph_buf(font_data_t *fd,
> +					 unsigned int width, unsigned int vpitch,
> +					 unsigned int c)
> +{
> +	if (c >= font_data_num_glyphs(fd, width, vpitch))
> +		return NULL;
> +
> +	return font_data_buf(fd) + font_glyph_size(width, vpitch) * c;
> +}
> +EXPORT_SYMBOL_GPL(font_data_glyph_buf);
> +
>   /**
>    * font_data_is_equal - Compares font data for equality
>    * @lhs: Left-hand side font data

