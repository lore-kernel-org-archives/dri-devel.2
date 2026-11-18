Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324D3606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x3CISAJB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0F110E7E4;
	Wed, 18 Nov 2026 13:27:26 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D9A10E7E4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:27:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4E95E4E40B00;
 Wed, 18 Nov 2026 13:27:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17B9E5FE9B;
 Wed, 18 Nov 2026 13:27:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0ECEB11BC2000; Wed, 18 Nov 2026 14:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795008433; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=qGDF0QdJq6eV3irICcBQAn2r5GsAB1GesRbUX5r+ORw=;
 b=x3CISAJBzWj+v/j41t6dxQL9r9dPwpcUtD8GhKekBMGgOIKGX2nCrPuXl/X4XTIbnnRohg
 xRqkGbRuIJnvT/fCrJxLARo+F++FISE1mwWQnWZWfiSd/d48kCUYsn8MciOPfnoN4SNLYH
 7BKWRSSWuV4J/lT9sIRL/eGf3vRcPXRsBFuy8dK2TB7wpxMYPdH5amWSjvB6f2psXnldLO
 2I47MmT43xDjE/DIKO/L/XRawUwkiI02ajWo+C3byftQ1rhVQL2pyrEc18OSjSjsqcOrIN
 7FYzJU91XJRghW+HI64PRo09rFf4laVCsJjHhExFQxtD4iYaLuMky3g0HN/nHQ==
Message-ID: <bd611fa8-2df2-49ba-9e2d-ce897d42d18e@bootlin.com>
Date: Wed, 18 Nov 2026 14:27:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/vkms: make argb_u16_to_RGB565 round resulting
 values
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <20260928005301.367977-2-matheus.aalmeida@inf.ufrgs.br>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260928005301.367977-2-matheus.aalmeida@inf.ufrgs.br>
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
> Currently, argb_u16_to_RGB565() truncates the resulting channel values.
> Use drm_fixp2int_round() to round them to the nearest representable
> RGB565 values.
> 
> Restore the rounding behavior from commit
> ab87f558dcfb ("drm/vkms: Fix RGB565 pixel conversion") while adding a
> separate helper for channel conversion.
> 
> Fixes: cc4fd2934d41 ("drm/vkms: Isolate writeback pixel conversion functions")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 35 ++++++++++++++++++++---------
>   1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index dfb8e13cb..6d7853e87 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -639,20 +639,35 @@ static void argb_u16_to_XRGB16161616(u8 *out_pixel, const struct pixel_argb_u16
>   	pixel[0] = cpu_to_le16(in_pixel->b);
>   }
>   
> -static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
> +static u16 u16_to_channel(int size, u16 in)
>   {
> -	__le16 *pixel = (__le16 *)out_pixel;
> +	s64 fp_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp((1 << size) - 1));
> +	s64 fp_channel = drm_int2fixp(in);
>   
> -	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
> -	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> +	return drm_fixp2int_round(drm_fixp_div(fp_channel, fp_ratio));
> +}
> +
> +static void argb_u16_to_channels(u16 *out_r, u16 *out_g, u16 *out_b, u16 *out_a,
> +				 unsigned int r_size, unsigned int g_size,
> +				 unsigned int b_size, unsigned int a_size,
> +				 const struct pixel_argb_u16 *in_pixel)
> +{
> +	if (r_size)
> +		*out_r = u16_to_channel(r_size, in_pixel->r);
> +	if (g_size)
> +		*out_g = u16_to_channel(g_size, in_pixel->g);
> +	if (b_size)
> +		*out_b = u16_to_channel(b_size, in_pixel->b);
> +	if (a_size)
> +		*out_a = u16_to_channel(a_size, in_pixel->a);
> +}
>   
> -	s64 fp_r = drm_int2fixp(in_pixel->r);
> -	s64 fp_g = drm_int2fixp(in_pixel->g);
> -	s64 fp_b = drm_int2fixp(in_pixel->b);
> +static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
> +{
> +	__le16 *pixel = (__le16 *)out_pixel;
> +	u16 r, g, b;
>   
> -	u16 r = drm_fixp2int(drm_fixp_div(fp_r, fp_rb_ratio));
> -	u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
> -	u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
> +	argb_u16_to_channels(&r, &g, &b, NULL, 5, 6, 5, 0, in_pixel);
>   
>   	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
>   }

