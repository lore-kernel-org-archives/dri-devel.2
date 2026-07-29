Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CD8C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731C410EC6D;
	Wed, 29 Jul 2026 15:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="crOkM4if";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD5E10EC6D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785337224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPXqgOsUU/0okBVvf36ZOSIn4QoJV6rSpP8eJJD/9jc=;
 b=crOkM4ifiWTpG/KfmT68ZfWNF1YQUz3rp52f7XBujFq6oCClmjASSlSod4De0yhW9bxdxm
 MIXLPl03s1g65nYU/+io0kR4h7zb6S8JmAI/J/TKp2YhpnHKmux3fM5mcV455PyeALoz+z
 YZxIWckVedepyfKnpsO8VwWZ7w5YorU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-Rd7mahd7PZCKkVMHmCiQNw-1; Wed, 29 Jul 2026 11:00:23 -0400
X-MC-Unique: Rd7mahd7PZCKkVMHmCiQNw-1
X-Mimecast-MFC-AGG-ID: Rd7mahd7PZCKkVMHmCiQNw_1785337222
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f6d70223dso814528f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785337222; x=1785942022;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPXqgOsUU/0okBVvf36ZOSIn4QoJV6rSpP8eJJD/9jc=;
 b=mopx3sp7uKNVT5sIvTdczGsRgyDOVEuay+R3wfFqaSha07jY1Hv4TOpAYe5OXFK9mi
 Xfd7EffC7eR65I7MNPLlyAawKh2SILXMsTte8l48PKxu6hqSTz4cyas3EgX6SyirdbEA
 Pqdp4LnqUJqMsYpCBtLRo/KuPjwh3YIAlZufgiho7GCHaykSa2wsaqLs67UMYhr/03uO
 0NNY6flWV3VWxOLrmfHQrG6uwBwqPhYO37huCUZ/U47cVBiWfIcMxr4KFAa7Lnp8j6MG
 htAR7T/IstpovHfPWWpYpQODy9FPCO7vii+jOnxWIqeN+RnckGIh+txUC1+eXLwdmM9B
 Juag==
X-Forwarded-Encrypted: i=1;
 AHgh+RoglIqxIARKxzXIXgxX3q+pfI6VpafOrdy4LetiXNuvsrwyKWLkn6igbGHEjr9fwPp7lNq0ppCZCm8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhREsMsF9A3Wla7Cl/U/xvBg+qzC3BK0XMDx3HLvF5Dj8m1ph3
 CsLKAS8lQIRAViN+h6fEizPcE6WPS4zSSK186Fpeno6pn6eGrsZpgoEyoTJq2drVnIYKDMlHfk8
 3jPDIvVDSr7n2l/oXOFf78AenerR/wNhC6O+vJLsPXxA4OkVjIti3+1AI2jva3g6GCIccqA==
X-Gm-Gg: AR+sD13D6Yeenfp+XBEAcUk8VvA1AxfACWcuHt38P81g+wUGSE6wpAYPBB5YZ4PFbin
 hWJ05KzFaW6UjeD0NP15l/Zt5u6VvVepcWvmmUuhKUp2KWnsg291W0SukeYD7gYwZ/8zh22gjDy
 0s0fGHNHqMRaPVyT+o++6f3H8veOq1mg+Bhk44Z+8OpFvPtxNbXSOclwLGXMm4Jcsqk85M+pEmD
 Jwfgl85IeALU3/GzgENGtq+xAVwLiwXhwnGEiX8TW7EKevG9OoXkbwF6ZpAxB8Dllf6IRULp+gs
 bkXfutjooxkE68/VE6E8twfv5YP/l4N9umMzlNWBW7eTOgAUA8Qz+E6NiG0fezYNau08PyN5Enb
 C2OYMfNS3zZ3vWVHmLt6zJNObR2FksK83EKCAWupqpvakZQ==
X-Received: by 2002:a05:600c:6986:b0:495:6840:9728 with SMTP id
 5b1f17b1804b1-496c659d6e2mr90221465e9.38.1785337221573; 
 Wed, 29 Jul 2026 08:00:21 -0700 (PDT)
X-Received: by 2002:a05:600c:6986:b0:495:6840:9728 with SMTP id
 5b1f17b1804b1-496c659d6e2mr90220695e9.38.1785337221018; 
 Wed, 29 Jul 2026 08:00:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51?
 ([2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d777afsm77073955e9.4.2026.07.29.08.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 08:00:20 -0700 (PDT)
Message-ID: <8012b9ea-a39d-437a-8539-9e4c3836d1bd@redhat.com>
Date: Wed, 29 Jul 2026 17:00:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/log: Fix division by zero when scale module
 parameter is 0
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
References: <20260729105840.865696-1-oushixiong1025@163.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260729105840.865696-1-oushixiong1025@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jUR_R1ZQUYSEGFH1-weGPG4sVSKeUIV5hxm6GdOlmD8_1785337222
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

On 29/07/2026 12:58, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> The scale module parameter can be set to 0 via kernel command line or
> sysfs. When scale is 0, scaled_font_h and scaled_font_w become 0,
> causing a division by zero in the rows/columns calculation.
> 
> Introduce a drm_log_scale() helper that returns scale ?: 1, and use it
> at all read sites. This avoids a race that a setter-based clamp would
> have between param_set_uint() and the subsequent check, where another
> CPU could observe scale == 0.

The scale module parameter is read only (that's the meaning of 0444 in 
module_param()) so it can't be set by sysfs, or change at runtime.

So this check can be done only once in drm_log_register().

Best regards,

-- 

Jocelyn
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> v1->v2:
>     Introduce a drm_log_scale() helper.
> 
>   drivers/gpu/drm/clients/drm_log.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 294b3be1a6b3..9522c1344123 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -29,6 +29,11 @@ static unsigned int scale = 1;
>   module_param(scale, uint, 0444);
>   MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
>   
> +static inline unsigned int drm_log_scale(void)
> +{
> +	return scale ?: 1;
> +}
> +
>   /**
>    * DOC: overview
>    *
> @@ -76,13 +81,13 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>   {
>   	switch (px_width) {
>   	case 2:
> -		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>   		break;
>   	case 3:
> -		drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>   		break;
>   	case 4:
> -		drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>   		break;
>   	default:
>   		WARN_ONCE(1, "Can't blit with pixel width %d\n", px_width);
> @@ -216,8 +221,8 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
>   		return -ENOMEM;
>   	}
>   	mode_set->fb = scanout->buffer->fb;
> -	scanout->scaled_font_h = scanout->font->height * scale;
> -	scanout->scaled_font_w = scanout->font->width * scale;
> +	scanout->scaled_font_h = scanout->font->height * drm_log_scale();
> +	scanout->scaled_font_w = scanout->font->width * drm_log_scale();
>   	scanout->rows = height / scanout->scaled_font_h;
>   	scanout->columns = width / scanout->scaled_font_w;
>   	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);

