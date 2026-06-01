Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C20FCD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C7C10E65C;
	Mon,  1 Jun 2026 11:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="C6/3IcaG";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C877610E65C
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780312782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDdMHQ4QMIhEirSuORxkFsO4/PRX5BsSB4zaAcWgpLM=;
 b=C6/3IcaGuOZ1GkX6mhPcjkBFcOAr8jR97Cv46IcQq9QpGazwogNHG+ApCIm413CZVuY6Wx
 FnsqJIWYB1xm4lpjwHRVzAKvAINLmmrdI/qqQJTtc68yKSImuiV9Z9kHAa275+CadAmxGN
 SIc988xmnCqos+lly1c+5EBCqbhRmfE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-gCydXX-QPj2wRtd4UX-uHA-1; Mon, 01 Jun 2026 07:19:41 -0400
X-MC-Unique: gCydXX-QPj2wRtd4UX-uHA-1
X-Mimecast-MFC-AGG-ID: gCydXX-QPj2wRtd4UX-uHA_1780312781
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ef5e38a18so1260559f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 04:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780312780; x=1780917580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rDdMHQ4QMIhEirSuORxkFsO4/PRX5BsSB4zaAcWgpLM=;
 b=S/masnm/s7j0V1id2bZqGFoE1fbtEZhXlpc1UTq13Q90Zn7SLSBDR0lVbcuGVUnm49
 W8hVzD0BX1+WYy0l7CDVI8ooGsuYZat6CGI8jSiX+s2JP4XCLqpWR2VW6HPexXEIv+2N
 7a6rIBGtQfokoy/9ovnI7ngHvkOti/DKXYCNdq99CW/y6jPgpRIDGU7f//utajf9pIcU
 O67vZpMMTo8hFkvKIvS/fRZSW2vucoWYVN9hsptoTiJrYtx+YmuTsOJf551DEvPULOci
 36Pz4HOBasRWO8R6A8k/VxSP0qS87ri7WGm4gYZYicyasylpEe3vXrWq6fDBVrhwsdNZ
 zxIA==
X-Gm-Message-State: AOJu0Yw0TnFK/T73aY2Ovn2CpmKPnZaCJTJYIFcnbU2Im6rd8uVKx80Q
 DeAny2DaI5DA7/qTGOAI5tmH20LYOSFEH/T8xvm1vkKO05EchTwtvPFmxoJ3zY1Z/A95cqWQ5NC
 QKkzos3K0IgVyb/qj3bGl2b5ua522ElGY+J+nyBGN31lTO9LnVIZT854UT394JR8itxFdWfkLrR
 Wqsg==
X-Gm-Gg: Acq92OE1i8dXpHmIPI1JThDIXsoA5sF6eC/T8RXEpBwMsBUXrY8RaY9s/NeDEM3Ar4d
 PqdcaK1+6BJhFPcGCfYkpZ6xaU9+9VVxioKW+VGwJtM+CAYwEAi1e//iUO1BV0mKf7lhU7qIBaF
 bbt+Px6XUX6tzwJQjaSmtirCicLY4DwDlQtB+0dVtSumnrGYGk3feDjY02htokqkQOJY3e4iGWB
 zYffVc3v71jNdAs+keWAhV0oCP8dQwgFZ1wA4utNYsGvjxI6ikJ5rNQ0AjcplAgITnXnG4oBKht
 l4WQNury20DSatnQaHgyO3U1WKtlskH4H/SKmHFBrPibYhQhvGzbsAeObrdT1JjU5QAZizcBDlm
 N9e/iRxKZ3WKOpSr/aFn3pjN48mYcTft/sk7rlS01h7nLqhaLw1JRZIWOpfeFZmGg79AH0QtO
X-Received: by 2002:a05:600c:8b10:b0:490:5cb3:e94a with SMTP id
 5b1f17b1804b1-490a2900d9dmr190001895e9.2.1780312780551; 
 Mon, 01 Jun 2026 04:19:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8b10:b0:490:5cb3:e94a with SMTP id
 5b1f17b1804b1-490a2900d9dmr190001155e9.2.1780312780147; 
 Mon, 01 Jun 2026 04:19:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8?
 ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68a925sm372611805e9.2.2026.06.01.04.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 04:19:39 -0700 (PDT)
Message-ID: <f66a0169-305b-4b72-a9bb-c114a81ed30e@redhat.com>
Date: Mon, 1 Jun 2026 13:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/panic: Look up glyph shape with font helper
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260529140759.529929-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: THeOQZkIbS2zEd0rZqq7j_kUF8fkKdpaRbRSJURHhHI_1780312781
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
>   drivers/gpu/drm/drm_panic.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index d6d3b8d85dea..e576c4791861 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -443,9 +443,11 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
>   			rec.x1 += (drm_rect_width(clip) - (line_len * font->width)) / 2;
>   
>   		for (j = 0; j < line_len; j++) {
> -			src = drm_draw_get_char_bitmap(font, msg[i].txt[j], font_pitch);
> +			src = font_data_glyph_buf(font->data, font->width, font->height,
> +						  (unsigned char)msg[i].txt[j]);
>   			rec.x2 = rec.x1 + font->width;
> -			drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
> +			if (src)
> +				drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
>   			rec.x1 += font->width;
>   		}
>   	}

