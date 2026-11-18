Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BD606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fwCrutfr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CDA10E766;
	Wed, 18 Nov 2026 14:45:02 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5483010E766
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:44:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 25D0F4E40B00;
 Wed, 18 Nov 2026 14:44:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DEF625FE9B;
 Wed, 18 Nov 2026 14:44:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 96F2B11BC22E9; Wed, 18 Nov 2026 15:44:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795013089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=a+x1/c9WXV+iW4qvMYQqYnNelxitH7p/E+9HgmQlRn0=;
 b=fwCrutfr5vVeuRZ/8Zs+QY4fx/3ikoIb7X06p1iZG3NgatPLGs1fYxfnmAWrdH0B0gcufQ
 dtdpctYWeRka399Nqrx1oXcOj8KErMDBBjUkH5nALL2o8HXcgXUE9alrAopW9nb/0iDefv
 7BTs/pqmqA959eY53M2VjcOB4vNfNioxMS+OQ3NpjOPxOzght0Mksfex6wm+spp/xgX7Xm
 6TnDqO5znD/6zMUNJZJFPY7d8pfa8zH7ME4WBbczWltxlgyTYI1sNEhqyBG7hVTZYULmE5
 Dx/rpXPmxBrvv87oFynEDG60Vj/aecqNRAGLD58XAhf6seSEY7RM36WDdvTs4Q==
Message-ID: <6c9dcddb-6ae9-4b90-968b-79c81f7e75f9@bootlin.com>
Date: Wed, 18 Nov 2026 15:44:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] drm/vkms: rename get_lut_index() to
 get_uniform_lut_index()
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-9-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-9-leandro.ribeiro@collabora.com>
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
> In the next commits we'll add non-uniform LUTs, and this function will
> be used exclusively by uniform LUTs. So rename it to make this clearer.
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/tests/vkms_color_test.c | 28 ++++++++++----------
>   drivers/gpu/drm/vkms/vkms_composer.c         |  6 ++---
>   drivers/gpu/drm/vkms/vkms_composer.h         |  2 +-
>   3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> index c223797a542a..06cec3591c5c 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> @@ -86,31 +86,31 @@ static const struct vkms_color_lut test_linear_lut = {
>   	.channel_value2index_ratio = 0xf000fll
>   };
>   
> -static void vkms_color_test_get_lut_index(struct kunit *test)
> +static void vkms_color_test_get_uniform_lut_index(struct kunit *test)
>   {
>   	s64 lut_index;
>   	int i;
>   
> -	lut_index = get_lut_index(&test_linear_lut, test_linear_array[0].red);
> +	lut_index = get_uniform_lut_index(&test_linear_lut, test_linear_array[0].red);
>   	KUNIT_EXPECT_EQ(test, drm_fixp2int(lut_index), 0);
>   
>   	for (i = 0; i < test_linear_lut.lut_length; i++) {
> -		lut_index = get_lut_index(&test_linear_lut, test_linear_array[i].red);
> +		lut_index = get_uniform_lut_index(&test_linear_lut, test_linear_array[i].red);
>   		KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(lut_index), i);
>   	}
>   
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int(get_lut_index(&srgb_eotf, 0x0)), 0x0);
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_lut_index(&srgb_eotf, 0x0)), 0x0);
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_lut_index(&srgb_eotf, 0x101)), 0x1);
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_lut_index(&srgb_eotf, 0x202)), 0x2);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int(get_uniform_lut_index(&srgb_eotf, 0x0)), 0x0);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0x0)), 0x0);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0x101)), 0x1);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0x202)), 0x2);
>   
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int(get_lut_index(&srgb_inv_eotf, 0x0)), 0x0);
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_lut_index(&srgb_inv_eotf, 0x0)), 0x0);
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_lut_index(&srgb_inv_eotf, 0x101)), 0x1);
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_lut_index(&srgb_inv_eotf, 0x202)), 0x2);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int(get_uniform_lut_index(&srgb_inv_eotf, 0x0)), 0x0);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_inv_eotf, 0x0)), 0x0);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_inv_eotf, 0x101)), 0x1);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_inv_eotf, 0x202)), 0x2);
>   
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_lut_index(&srgb_eotf, 0xfefe)), 0xfe);
> -	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_lut_index(&srgb_eotf, 0xffff)), 0xff);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0xfefe)), 0xfe);
> +	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0xffff)), 0xff);
>   }
>   
>   static void vkms_color_test_lerp(struct kunit *test)
> @@ -392,7 +392,7 @@ static void vkms_color_ctm_3x4_bt709(struct kunit *test)
>   }
>   
>   static struct kunit_case vkms_color_test_cases[] = {
> -	KUNIT_CASE(vkms_color_test_get_lut_index),
> +	KUNIT_CASE(vkms_color_test_get_uniform_lut_index),
>   	KUNIT_CASE(vkms_color_test_lerp),
>   	KUNIT_CASE(vkms_color_test_linear),
>   	KUNIT_CASE(vkms_color_srgb_inv_srgb),
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 640a1a03f06f..faf4515f024c 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -93,19 +93,19 @@ static inline u16 lut_channel_value(const struct drm_color_lut *lut,
>   	return 0;
>   }
>   
> -VISIBLE_IF_KUNIT s64 get_lut_index(const struct vkms_color_lut *lut, u16 channel_value)
> +VISIBLE_IF_KUNIT s64 get_uniform_lut_index(const struct vkms_color_lut *lut, u16 channel_value)
>   {
>   	s64 color_channel_fp = drm_int2fixp(channel_value);
>   
>   	return drm_fixp_mul(color_channel_fp, lut->channel_value2index_ratio);
>   }
> -EXPORT_SYMBOL_IF_KUNIT(get_lut_index);
> +EXPORT_SYMBOL_IF_KUNIT(get_uniform_lut_index);
>   
>   VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 channel_value,
>   						enum lut_channel channel)
>   {
>   	const struct drm_color_lut *lut_y_floor, *lut_y_ceil;
> -	s64 lut_index = get_lut_index(lut, channel_value);
> +	s64 lut_index = get_uniform_lut_index(lut, channel_value);
>   	u16 floor_channel_value, ceil_channel_value;
>   
>   	/*
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.h b/drivers/gpu/drm/vkms/vkms_composer.h
> index 04dd5646f672..fa003af12f85 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.h
> +++ b/drivers/gpu/drm/vkms/vkms_composer.h
> @@ -19,7 +19,7 @@ enum lut_channel {
>   
>   #if IS_ENABLED(CONFIG_KUNIT)
>   u16 lerp_u16(u16 a, u16 b, s64 t);
> -s64 get_lut_index(const struct vkms_color_lut *lut, u16 channel_value);
> +s64 get_uniform_lut_index(const struct vkms_color_lut *lut, u16 channel_value);
>   u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 channel_value,
>   			       enum lut_channel channel);
>   void apply_3x4_matrix(struct pixel_argb_s32 *pixel, const struct drm_color_ctm_3x4 *matrix);

