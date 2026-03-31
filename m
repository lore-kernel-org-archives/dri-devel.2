Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD8A1061B3C
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494F910EA17;
	Tue, 31 Mar 2026 12:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UPGQZ/ES";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CECB10EA17
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774960272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qywi7ozJpAOVApe14ykhQ23+WXfQ13sP2QxoRhqseiw=;
 b=UPGQZ/ESoFJRYnnN4Z8kJwShpB+kEOELljgNPf4xlLxBd2RYvhPDRuc21EW3Syw9EeesXt
 ej0a8/fQ2FT0HuRtcwsAdy5+Ydf97orEnsF2ZBbX2e750nAKfBjuBxa/X07FNRS0OrxbDb
 UgmjcGRmcq+/zh7+8sunU+c/O/eQDZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-rpp1KaplPJaCk30j_RUUjQ-1; Tue, 31 Mar 2026 08:31:10 -0400
X-MC-Unique: rpp1KaplPJaCk30j_RUUjQ-1
X-Mimecast-MFC-AGG-ID: rpp1KaplPJaCk30j_RUUjQ_1774960270
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48881eac1f2so16805e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 05:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774960269; x=1775565069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qywi7ozJpAOVApe14ykhQ23+WXfQ13sP2QxoRhqseiw=;
 b=mBPqsDqQX//2SnBC3Jpd/i8SHFl39XaNkCgUe2ptwo/gO2mLqjdU/u41ICWhtGvbdZ
 wIDvByPKL17QmlYla+DYga6sFiO1icvIfgoQtoFYUc6axIuEizyl0e7ZaegkvxLbOhKE
 MO9KjoUGZVTHkI/PxC0csN3Vo6UYixni6vgkE6l1SDf1oGg/PkG+4NBd9374xv3LlCTq
 p59kHhOr/EQapsx4xb4rtic4/PNbNf9dBKcd8datalV7+yPsj2SNzJTdAgf5sai2pV8v
 WpzEDt4Ydu5rAzre0ZY4pHX84yrR8EUNb3GlzN6h3MAr8HnPA3fD+1Gy6CbYx6WzzmTP
 n00w==
X-Gm-Message-State: AOJu0YxY7Ex9JF9ykl+9wRkQ2jQdzBKDSS5zeqQYc6WQb4dE5fZRAr3H
 cKhS3CanAQclMd1r1RbWBkumzdeWNjln4xNNgZrL71Rq+A7HwbycrB5rUZmy3aIklmqXY0p5Z7W
 6EhdPwc1/rQijXbc4cT7zYVP7RsgTRJAWG5HHKqHW4DuSfqfHPxqDq1gH0qsc7pcnDsrFAg==
X-Gm-Gg: ATEYQzyNmfP+SyySdQEqaG8VQVI/HLbwo1m8E+19qg+CvctNe1PDhFTscmqdduTXaUe
 YUp5unCn9MSH5dcvbgDgmzgIiS9VzAJyiFR9HF2Edqs6bml9+JO+NcSJuN2CTnlUYOIM+7iYN7x
 ohWXRJlnkMiAkd48JdrnkB4nn60OZOTZZkgyIlEbZskWI5bkxuZcnbGZCxiov1+JTd+I/c3YqV1
 Resq18BWa/hJTyNcQijGPEduWunqZkR7SyyfHcT9K/onZ/P1vmfeyBhaVqh2jpCFGOAPnrsGQsJ
 vGZAXdqQkOoLuOT2BleSuLSKVv3W87OI74ZVe+aw7wmrZA+9pu6RAKMkQcI8SL2/7fHlUEe6aYH
 4Txuq6bYsKOEhaWpreQ147w9pN6F3oSvW5/c2KARkQ/olQ6Jyg+2JFIAMIuhNOQ==
X-Received: by 2002:a05:600c:160a:b0:486:d76c:fa21 with SMTP id
 5b1f17b1804b1-48735166d0amr108920265e9.12.1774960269461; 
 Tue, 31 Mar 2026 05:31:09 -0700 (PDT)
X-Received: by 2002:a05:600c:160a:b0:486:d76c:fa21 with SMTP id
 5b1f17b1804b1-48735166d0amr108919845e9.12.1774960268956; 
 Tue, 31 Mar 2026 05:31:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e82e262sm34244735e9.10.2026.03.31.05.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 05:31:08 -0700 (PDT)
Message-ID: <3f9664d0-2252-4dc1-ab3d-03193fa9764f@redhat.com>
Date: Tue, 31 Mar 2026 14:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: Fix panic logo alignment
To: Dileep Sankhla <dileepsankhla.ds@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260329102454.11357-1-dileepsankhla.ds@gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260329102454.11357-1-dileepsankhla.ds@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vkwSIcGRA5k7MqtW9fNTXY6c7pNUpxGZZlQ3Mcd8cbM_1774960270
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

On 29/03/2026 12:24, Dileep Sankhla wrote:
> Display the panic logo at the top center of the screen when
> drm_panic_type is set to DRM_PANIC_TYPE_USER to keep the layout
> properly aligned.

Hi,

I think this is more a preference, than a fix.
At boot the logo is at the top left corner, and I choose to let it at 
the same place.
Additionally, on low resolution (like 800x600) the logo has less chance 
to overlap the text, so the user is more likely to see it.

Best regards,

-- 

Jocelyn
> 
> Signed-off-by: Dileep Sankhla <dileepsankhla.ds@gmail.com>
> ---
>   drivers/gpu/drm/drm_panic.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index d6d3b8d85dea..c7fecc5e857a 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -491,6 +491,8 @@ static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
>   
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   	drm_panic_logo_rect(&r_logo, font);
> +	/* Center the panic logo */
> +	drm_rect_translate(&r_logo, (sb->width - r_logo.x2) / 2, 0);
>   
>   	msg_width = min(get_max_line_len(panic_msg, panic_msg_lines) * font->width, sb->width);
>   	msg_height = min(panic_msg_lines * font->height, sb->height);

