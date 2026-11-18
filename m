Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WoJhJqJr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A92810FC22;
	Wed, 18 Nov 2026 13:25:30 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B86D10FC22
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:25:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BF3131A16D0;
 Wed, 18 Nov 2026 13:25:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 875A85FE9B;
 Wed, 18 Nov 2026 13:25:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B095711BC12C1; Wed, 18 Nov 2026 14:25:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795008317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=GxAZTq7Ao+4XtB3Gk3Rw38IdkfFxSdo1k6VZCcuN1II=;
 b=WoJhJqJrnvjPuwhaF9mH6EaCd9Xtm5DHU+e4UZnoXj9UhyU5+8r6/c5/sWPUzrla/HpGJG
 qkknMkQ3z2AcQO6KJN+smzwQ6Zx9am4QQeyVTU0XOeunNv8DzODahgQjHcxtReYWI8To8L
 zFNaJUO7i0ikm8bmgqAX9BuN6AU9lAFTkAL2l5UF5p1Uj8/PG40r3HN28vCHvsG6sdu5Kz
 VU+4RzSErHDdD/TiVTOw64EFaWUqlu7RmHpcWWMQG535+LrTgp3XVLnM1Cgp4DfBnFSTh4
 yv7EwKf/W53vafgPKwcURoE/gT+l4oyjhR5Tk57I7Uz7rmSZyB0dUi85u6NCXA==
Message-ID: <c8161754-f2a0-4efd-a7cc-72cd6a4696ce@bootlin.com>
Date: Wed, 18 Nov 2026 14:25:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/vkms: add a helper for channel to argb_u16
 conversion
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <20260928005301.367977-4-matheus.aalmeida@inf.ufrgs.br>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260928005301.367977-4-matheus.aalmeida@inf.ufrgs.br>
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
> Other pixel formats have similar conversions to the one implemented in
> the RGB565 helper.
> 
> Add a channels_to_argb_u16() helper to convert individual channels into
> the internal representation, and use it in argb_u16_from_BGR565() and
> argb_u16_from_RGB565().
> 
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 50 +++++++++++++++++------------
>   1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index b44900761..6e4f58207 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -229,24 +229,42 @@ static struct pixel_argb_u16 argb_u16_from_le16161616(__le16 a, __le16 r, __le16
>   				       le16_to_cpu(b));
>   }
>   
> -static struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
> +static u16 channel_to_u16(unsigned int size, u16 in)
> +{
> +	s64 fp_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp((1 << size) - 1));
 > +
> +	s64 fp_channel = drm_int2fixp(in);
> +
> +	return drm_fixp2int_round(drm_fixp_mul(fp_channel, fp_ratio));
> +}
> +
> +static struct pixel_argb_u16 channels_to_argb_u16(u16 in_r, u16 in_g, u16 in_b, u16 in_a,
> +						  unsigned int size_r, unsigned int size_g,
> +						  unsigned int size_b, unsigned int size_a)
>   {
>   	struct pixel_argb_u16 out_pixel;
>   
> -	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
> -	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> +	out_pixel.r = size_r ? channel_to_u16(size_r, in_r) : in_r;
> +	out_pixel.g = size_g ? channel_to_u16(size_g, in_g) : in_g;
> +	out_pixel.b = size_b ? channel_to_u16(size_b, in_b) : in_b;
> +	out_pixel.a = size_a ? channel_to_u16(size_a, in_a) : in_a;
>   
> +	return out_pixel;
> +}
> +
> +static struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
> +{
>   	u16 rgb_565 = le16_to_cpu(*pixel);
> -	s64 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
> -	s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
> -	s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
>   
> -	out_pixel.a = (u16)0xffff;
> -	out_pixel.r = drm_fixp2int_round(drm_fixp_mul(fp_r, fp_rb_ratio));
> -	out_pixel.g = drm_fixp2int_round(drm_fixp_mul(fp_g, fp_g_ratio));
> -	out_pixel.b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
> +	return channels_to_argb_u16((rgb_565 >> 11) & 0x1f, (rgb_565 >> 5) & 0x3f,
> +				    rgb_565 & 0x1f, 0xffff, 5, 6, 5, 0);
> +}
>   
> -	return out_pixel;
> +static struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
> +{
> +	u16 bgr_565 = le16_to_cpu(*pixel);
> +
> +	return channels_to_argb_u16(bgr_565 & 0x1f, (bgr_565 >> 5) & 0x3f,
> +				    (bgr_565 >> 11) & 0x1f, 0xffff, 5, 6, 5, 0);
>   }
>   
>   static struct pixel_argb_u16 argb_u16_from_gray8(u8 gray)
> @@ -259,16 +277,6 @@ static struct pixel_argb_u16 argb_u16_from_grayu16(u16 gray)
>   	return argb_u16_from_u16161616(0xFFFF, gray, gray, gray);
>   }
>   
> -static struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
> -{
> -	struct pixel_argb_u16 out_pixel;
> -
> -	out_pixel = argb_u16_from_RGB565(pixel);
> -	swap(out_pixel.r, out_pixel.b);
> -
> -	return out_pixel;
> -}
> -
>   VISIBLE_IF_KUNIT
>   struct pixel_argb_u16 argb_u16_from_yuv161616(const struct conversion_matrix *matrix,
>   					      u16 y, u16 channel_1, u16 channel_2)

