Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914AF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Gh1MOyij
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0172C10EB97;
	Tue, 17 Nov 2026 16:11:46 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D06910EB97
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:11:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 491C34E41591;
 Tue, 17 Nov 2026 16:11:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 144195FDAD;
 Tue, 17 Nov 2026 16:11:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC52911BC0041; Tue, 17 Nov 2026 17:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794931896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=NdX8rZc88M2SsKjHPh+1wD3oLhJHiw2YYjPjsmyyxSU=;
 b=Gh1MOyijcv4KG4FFbUzCniAQ2Br5TAyhLfw97L3kfO/jdwxaDKJ3azdXxMPO7wR8bEQyaM
 Hq/zoX4DsHzhXn/PetKZ2ZUYgbJ3wFh6XeemzJ3gij7YlLPN3KGnfQIWkQ7eHqIyhEyPnr
 tv1BjVNUYRtoNgbm5pv+5XKeZjPpryz+EXP5Zea/pLpoER/lYU8oLZ8dnDD7RY39Vf4/gb
 pBUxjlbWWhGV3s5DW+V8MFEgQ2fPt+ceZkvDkIBtW2AUB8ln2xj6xZHnKxaFD8WwPNz0qI
 ExFCHl44exOZt3RapJ0L+Wd2Xc+rIbl/ap4hlDWi5LP8PlLcjOdg7rny7SNCdg==
Message-ID: <9a6373c3-f8df-4464-8ff7-75dd594a7e80@bootlin.com>
Date: Tue, 17 Nov 2026 17:11:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/vkms: add support for RGB332
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <20260928005301.367977-5-matheus.aalmeida@inf.ufrgs.br>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260928005301.367977-5-matheus.aalmeida@inf.ufrgs.br>
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
> Add support for reading and writing the RGB332 pixel format.
> 
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/vkms_formats.c   | 21 +++++++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_plane.c     |  1 +
>   drivers/gpu/drm/vkms/vkms_writeback.c |  3 ++-
>   3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 6e4f58207..0c3bb0618 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -267,6 +267,12 @@ static struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
>   				    (bgr_565 >> 11) & 0x1f, 0xffff, 5, 6, 5, 0);
>   }
>   
> +static struct pixel_argb_u16 argb_u16_from_RGB332(u8 pixel)
> +{
> +	return channels_to_argb_u16((pixel >> 5) & 0x7, (pixel >> 2) & 0x7,
> +				    pixel & 0x3, 0xffff, 3, 3, 2, 0);
> +}
> +
>   static struct pixel_argb_u16 argb_u16_from_gray8(u8 gray)
>   {
>   	return argb_u16_from_u8888(255, gray, gray, gray);
> @@ -475,6 +481,8 @@ READ_LINE_le16161616(XBGR16161616_read_line, px, cpu_to_le16(0xFFFF), px[0], px[
>   READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
>   READ_LINE(BGR565_read_line, px, __le16, argb_u16_from_BGR565, px)
>   
> +READ_LINE(RGB332_read_line, px, u8, argb_u16_from_RGB332, *px)
> +
>   READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
>   
>   /*
> @@ -690,6 +698,15 @@ static void argb_u16_to_BGR565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
>   	*pixel = cpu_to_le16(b << 11 | g << 5 | r);
>   }
>   
> +static void argb_u16_to_RGB332(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
> +{
> +	u16 r, g, b;
> +
> +	argb_u16_to_channels(&r, &g, &b, NULL, 3, 3, 2, 0, in_pixel);
> +
> +	*out_pixel = r << 5 | g << 2 | b;
> +}
> +
>   /**
>    * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
>    * after the blending to write a line in the writeback buffer.
> @@ -752,6 +769,8 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
>   		return &RGB565_read_line;
>   	case DRM_FORMAT_BGR565:
>   		return &BGR565_read_line;
> +	case DRM_FORMAT_RGB332:
> +		return &RGB332_read_line;
>   	case DRM_FORMAT_NV12:
>   	case DRM_FORMAT_NV16:
>   	case DRM_FORMAT_NV24:
> @@ -992,6 +1011,8 @@ pixel_write_t get_pixel_write_function(u32 format)
>   		return &argb_u16_to_RGB565;
>   	case DRM_FORMAT_BGR565:
>   		return &argb_u16_to_BGR565;
> +	case DRM_FORMAT_RGB332:
> +		return &argb_u16_to_RGB332;
>   	default:
>   		/*
>   		 * This is a bug in vkms_writeback_atomic_check. All the supported
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 68cb2a333..fff2d4eb5 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -29,6 +29,7 @@ static const u32 vkms_formats[] = {
>   	DRM_FORMAT_ABGR16161616,
>   	DRM_FORMAT_RGB565,
>   	DRM_FORMAT_BGR565,
> +	DRM_FORMAT_RGB332,
>   	DRM_FORMAT_NV12,
>   	DRM_FORMAT_NV16,
>   	DRM_FORMAT_NV24,
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index f64b90908..54330803e 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -22,7 +22,8 @@ static const u32 vkms_wb_formats[] = {
>   	DRM_FORMAT_XRGB16161616,
>   	DRM_FORMAT_ARGB16161616,
>   	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_BGR565
> +	DRM_FORMAT_BGR565,
> +	DRM_FORMAT_RGB332
>   };
>   
>   static const struct drm_connector_funcs vkms_wb_connector_funcs = {

