Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F85606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AUU+I9LM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6445610FC69;
	Wed, 18 Nov 2026 13:30:30 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCA010FCA2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:30:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D51C5C4F77E;
 Wed, 18 Nov 2026 13:30:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0BB575FE9B;
 Wed, 18 Nov 2026 13:30:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 10BA911BC1FF8; Wed, 18 Nov 2026 14:30:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795008618; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=hyr0/vBL7xqqhFXVGePqQR+38WonfCDQ4la1hN00s5s=;
 b=AUU+I9LMHP8NCA/NArDhmRH2t9Z8gMXvbKxRnfPRnUnzfJW+kxbnwQk7vc/aqF2kijMsDP
 qOsAWGi9QJ0jAXRW++BVZ5wWpNIAxwqoZWbMNLjzhJlh6eQsG3Tg5PScE0/ofrPXBOI2Jv
 s1GgsqY1UZfk03RtxChUZ8jViQYeo1BqiI/4Y278aFNDnJi3lL2dr/qHoyyPPaTg6u3S4B
 aWET0WA2Qt91rVJc60XaY5uVIjJ5MdPmwZk+9vLKWWIM33oTXv8aY8tsCZyyUoocQ1rDdF
 YQWATLCZNZYvAfGjd84CYnoOypKibSUEiiicvjfgSyCZzWOA4evrZQxF8F8nrg==
Message-ID: <59f417a8-be50-4378-9ded-1adc1148cc6f@bootlin.com>
Date: Wed, 18 Nov 2026 14:30:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/vkms: add support for BGR233
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <20260928005301.367977-6-matheus.aalmeida@inf.ufrgs.br>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260928005301.367977-6-matheus.aalmeida@inf.ufrgs.br>
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



On 9/28/26 02:53, Matheus Alves de Almeida wrote:
> Add support for reading and writing the BGR233 pixel format.
> 
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/vkms_formats.c   | 20 ++++++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_plane.c     |  1 +
>   drivers/gpu/drm/vkms/vkms_writeback.c |  3 ++-
>   3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 0c3bb0618..de25c8a19 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -273,6 +273,12 @@ static struct pixel_argb_u16 argb_u16_from_RGB332(u8 pixel)
>   				    pixel & 0x3, 0xffff, 3, 3, 2, 0);
>   }
>   
> +static struct pixel_argb_u16 argb_u16_from_BGR233(u8 pixel)
> +{
> +	return channels_to_argb_u16(pixel & 0x7, (pixel >> 3) & 0x7,
> +				    (pixel >> 6) & 0x3, 0xffff, 3, 3, 2, 0);
> +}
> +
>   static struct pixel_argb_u16 argb_u16_from_gray8(u8 gray)
>   {
>   	return argb_u16_from_u8888(255, gray, gray, gray);
> @@ -482,6 +488,7 @@ READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
>   READ_LINE(BGR565_read_line, px, __le16, argb_u16_from_BGR565, px)
>   
>   READ_LINE(RGB332_read_line, px, u8, argb_u16_from_RGB332, *px)
> +READ_LINE(BGR233_read_line, px, u8, argb_u16_from_BGR233, *px)
>   
>   READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
>   
> @@ -707,6 +714,15 @@ static void argb_u16_to_RGB332(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
>   	*out_pixel = r << 5 | g << 2 | b;
>   }
>   
> +static void argb_u16_to_BGR233(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
> +{
> +	u16 r, g, b;
> +
> +	argb_u16_to_channels(&r, &g, &b, NULL, 3, 3, 2, 0, in_pixel);
> +
> +	*out_pixel = b << 6 | g << 3 | r;
> +}
> +
>   /**
>    * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
>    * after the blending to write a line in the writeback buffer.
> @@ -771,6 +787,8 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
>   		return &BGR565_read_line;
>   	case DRM_FORMAT_RGB332:
>   		return &RGB332_read_line;
> +	case DRM_FORMAT_BGR233:
> +		return &BGR233_read_line;
>   	case DRM_FORMAT_NV12:
>   	case DRM_FORMAT_NV16:
>   	case DRM_FORMAT_NV24:
> @@ -1013,6 +1031,8 @@ pixel_write_t get_pixel_write_function(u32 format)
>   		return &argb_u16_to_BGR565;
>   	case DRM_FORMAT_RGB332:
>   		return &argb_u16_to_RGB332;
> +	case DRM_FORMAT_BGR233:
> +		return &argb_u16_to_BGR233;
>   	default:
>   		/*
>   		 * This is a bug in vkms_writeback_atomic_check. All the supported
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index fff2d4eb5..89beda57e 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -30,6 +30,7 @@ static const u32 vkms_formats[] = {
>   	DRM_FORMAT_RGB565,
>   	DRM_FORMAT_BGR565,
>   	DRM_FORMAT_RGB332,
> +	DRM_FORMAT_BGR233,
>   	DRM_FORMAT_NV12,
>   	DRM_FORMAT_NV16,
>   	DRM_FORMAT_NV24,
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 54330803e..37042445d 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -23,7 +23,8 @@ static const u32 vkms_wb_formats[] = {
>   	DRM_FORMAT_ARGB16161616,
>   	DRM_FORMAT_RGB565,
>   	DRM_FORMAT_BGR565,
> -	DRM_FORMAT_RGB332
> +	DRM_FORMAT_RGB332,
> +	DRM_FORMAT_BGR233
>   };
>   
>   static const struct drm_connector_funcs vkms_wb_connector_funcs = {

