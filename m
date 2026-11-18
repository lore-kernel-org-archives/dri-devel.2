Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDD606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NG1SZo66
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C910310FD60;
	Wed, 18 Nov 2026 14:44:00 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD5D10FD6A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:43:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0C66B4E4162B;
 Wed, 18 Nov 2026 14:43:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BFBFB5FE9B;
 Wed, 18 Nov 2026 14:43:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AC53411BC22DF; Wed, 18 Nov 2026 15:43:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795013027; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RuoK7SHlccTvW+KBXVmm9tIGmcELxfywFYrOMCIIMAs=;
 b=NG1SZo66mYmaxwSwSF0I9HdIki8dspQKEwD682IvKYbGBWJNcNpS1+IxF1+9WqL7488dl8
 oVExbeseyH53sG1RKw1WrXuf2S6i1eoetCS7exY7CfAfkt0ryAaSSEuq8ojdm/dJ/Tk6Jp
 x7ZA1/rh2k8gl15syw65pzgVOJbG+s1fRlOQQwKGD36GU+nkaouGR//FJFyTQpWac8yGSP
 VgwIs6+UyZm17Qd8y55Jr7JHxMES2ydshpPzs2GWarUP0YDs2TXBKCY/Pbrj7oxSYzT64j
 xSs4WV0oAInPIw2x6KLdNAhVZ5IWHwuiSH7ABMMzSQ1NvWPdClPJUZsgrRljnw==
Message-ID: <929e5bb7-2ace-4ad1-b154-e8c36a56f3a8@bootlin.com>
Date: Wed, 18 Nov 2026 15:43:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] drm/vkms: improve the way in which we access LUT
 member
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-7-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-7-leandro.ribeiro@collabora.com>
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



On 11/6/26 21:18, Leandro Ribeiro wrote:
> apply_lut_to_channel_value() indexes a struct drm_color_lut array, and
> then cast to (__u16 *) and index with the channel (r -> index 0, g ->
> index 1, b -> index 2). This is a bit fragile and prone to issues.
> 
> Instead, add a more robust helper lut_channel_value() such that, given a
> struct drm_color_lut and a color channel, it retrives the value.
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/vkms_composer.c | 30 ++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 0fc915a954ba..b4a433be1b2d 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -75,6 +75,24 @@ VISIBLE_IF_KUNIT u16 lerp_u16(u16 a, u16 b, s64 t)
>   }
>   EXPORT_SYMBOL_IF_KUNIT(lerp_u16);
>   
> +static inline u16 lut_channel_value(const struct drm_color_lut *lut,
> +				    enum lut_channel channel)
> +{
> +	switch (channel) {
> +	case LUT_RED:
> +		return lut->red;
> +	case LUT_BLUE:
> +		return lut->blue;
> +	case LUT_GREEN:
> +		return lut->green;
> +	case LUT_RESERVED:
> +		DRM_DEBUG_DRIVER("LUT_RESERVED channel should not be accessed");
> +		return 0;
> +	}
> +	DRM_DEBUG_DRIVER("unknown LUT channel");
> +	return 0;
> +}
> +
>   VISIBLE_IF_KUNIT s64 get_lut_index(const struct vkms_color_lut *lut, u16 channel_value)
>   {
>   	s64 color_channel_fp = drm_int2fixp(channel_value);
> @@ -86,8 +104,8 @@ EXPORT_SYMBOL_IF_KUNIT(get_lut_index);
>   VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 channel_value,
>   						enum lut_channel channel)
>   {
> +	const struct drm_color_lut *lut_y_floor, *lut_y_ceil;
>   	s64 lut_index = get_lut_index(lut, channel_value);
> -	u16 *floor_lut_value, *ceil_lut_value;
>   	u16 floor_channel_value, ceil_channel_value;
>   
>   	/*
> @@ -96,15 +114,15 @@ VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut
>   	 */
>   	static_assert(sizeof(struct drm_color_lut) == sizeof(__u16) * 4);
>   
> -	floor_lut_value = (__u16 *)&lut->base[drm_fixp2int(lut_index)];
> +	lut_y_floor = &lut->base[drm_fixp2int(lut_index)];
>   	if (drm_fixp2int(lut_index) == (lut->lut_length - 1))
>   		/* We're at the end of the LUT array, use same value for ceil and floor */
> -		ceil_lut_value = floor_lut_value;
> +		lut_y_ceil = lut_y_floor;
>   	else
> -		ceil_lut_value = (__u16 *)&lut->base[drm_fixp2int_ceil(lut_index)];
> +		lut_y_ceil = &lut->base[drm_fixp2int_ceil(lut_index)];
>   
> -	floor_channel_value = floor_lut_value[channel];
> -	ceil_channel_value = ceil_lut_value[channel];
> +	floor_channel_value = lut_channel_value(lut_y_floor, channel);
> +	ceil_channel_value = lut_channel_value(lut_y_ceil, channel);
>   
>   	return lerp_u16(floor_channel_value, ceil_channel_value,
>   			lut_index & DRM_FIXED_DECIMAL_MASK);

