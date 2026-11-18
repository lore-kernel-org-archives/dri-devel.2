Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A5606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hMTS4L/R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1ED10FC74;
	Wed, 18 Nov 2026 13:29:42 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5BD10FC83
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:29:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B09944E40B00;
 Wed, 18 Nov 2026 13:29:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 67CC75FE9B;
 Wed, 18 Nov 2026 13:29:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D349511BC2034; Wed, 18 Nov 2026 14:29:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795008573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=44mbmV05nqG9EEv6VPRKKnsOWjYfhVuVI8Fj1zcBOBs=;
 b=hMTS4L/RLWn9gmZAv/GAXdi+q4pvG45kj4d4XIbMTk5lrQHh50Y62p6cCmG+LXj0aH+8ZK
 9A3ZBZGlPpQNn9ePUq/3d5ipVz1euNTfzE4ZDoiqUNtaElCX2xcLW6u7YNmS7nTE/PSDaU
 1gcDv+Wov+10o1Jm96DbfFg+34xPBhZAcdIvEaCzQ7Y3yBw1GumavZpOxTO5RIaISAhu7B
 grqijTzxClys07RkfXKar+Y5uZevSVVcvdExsHcwRrMm/qus4gkKYj8vCl6vgTsChzOXc4
 da/80ieJlUnNvPT9U/y+ivAF6zKjcw47QiEmtq+XGbIyjDWOTR82U216KiefzA==
Message-ID: <6de5fa9a-f8d7-4f5d-a822-b8577831a6ea@bootlin.com>
Date: Wed, 18 Nov 2026 14:29:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/vkms: support BGR565 writeback
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <20260928005301.367977-3-matheus.aalmeida@inf.ufrgs.br>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260928005301.367977-3-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/28/26 02:52, Matheus Alves de Almeida wrote:
> While BGR565 read is currently supported, the format code is missing
> support for BGR565 write.
> 
> Implement argb_u16_to_BGR565(), add it to get_pixel_write_function()
> and advertise BGR565 support in vkms_wb_formats.
> 
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/vkms_formats.c   | 12 ++++++++++++
>   drivers/gpu/drm/vkms/vkms_writeback.c |  3 ++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 6d7853e87..b44900761 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -672,6 +672,16 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
>   	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
>   }
>   
> +static void argb_u16_to_BGR565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
> +{
> +	__le16 *pixel = (__le16 *)out_pixel;
> +	u16 r, g, b;
> +
> +	argb_u16_to_channels(&r, &g, &b, NULL, 5, 6, 5, 0, in_pixel);
> +
> +	*pixel = cpu_to_le16(b << 11 | g << 5 | r);
> +}
> +
>   /**
>    * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
>    * after the blending to write a line in the writeback buffer.
> @@ -972,6 +982,8 @@ pixel_write_t get_pixel_write_function(u32 format)
>   		return &argb_u16_to_XRGB16161616;
>   	case DRM_FORMAT_RGB565:
>   		return &argb_u16_to_RGB565;
> +	case DRM_FORMAT_BGR565:
> +		return &argb_u16_to_BGR565;
>   	default:
>   		/*
>   		 * This is a bug in vkms_writeback_atomic_check. All the supported
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index ecf29a2c0..f64b90908 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -21,7 +21,8 @@ static const u32 vkms_wb_formats[] = {
>   	DRM_FORMAT_ABGR8888,
>   	DRM_FORMAT_XRGB16161616,
>   	DRM_FORMAT_ARGB16161616,
> -	DRM_FORMAT_RGB565
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_BGR565
>   };
>   
>   static const struct drm_connector_funcs vkms_wb_connector_funcs = {

