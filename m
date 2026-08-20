Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F706C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C90B10F12C;
	Thu, 20 Aug 2026 17:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="F3tU2Bta";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2619210F127
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787245695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLiaqJfdZPiVkLiAyQhGsqALdMhxud7zy/2Rp0UqKa4=;
 b=F3tU2Bta+6lmrjiv+DFn/NqdU3jhMX2gpr73DufRCrghOCcOizuJYxeyvC1/XG1J3nrXsf
 D882TIiO5we/dZbrW1Zob3p810GMOVKR1pjqM2jeNzWWzGUmBOyj+XpoAyUODqK4qM1sFe
 Oqn3ICgt/FIOLIOvh2uA3xTZpa4OAs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-dYufgNi1PQySYtK-nvpLfw-1; Thu, 20 Aug 2026 13:08:13 -0400
X-MC-Unique: dYufgNi1PQySYtK-nvpLfw-1
X-Mimecast-MFC-AGG-ID: dYufgNi1PQySYtK-nvpLfw_1787245689
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-499574e98a1so262625e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787245689; x=1787850489;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uLiaqJfdZPiVkLiAyQhGsqALdMhxud7zy/2Rp0UqKa4=;
 b=A6JBIy3vZkkSr06rFeTaw7uqX6BdBHMG1lMd7otDDKyGtAdAAeq2fIHv2vcGimgizP
 XY3fnGbvIN4o4DwtxvMxEype6G0NCqGRNEXIcwpQbA0FC6idWHNLk1d++2E+J1B3oASB
 6XXSZ/QIKOh5qPwOMMSSxVSc7ahSNMxqJALmZUHaDMGOlpeuBREFF89QXTMh0XBdqtfL
 nmnuCwEkKgwveaklo0uDn0OedrmutitPBlXxo43ZmJQVhR1u6oDfeCzwJGqnlLhsqSsW
 hJHnkPGmXInONeHgN4vhi7lt7iWypiA3sgMkXJTo5/yHhB7jQd6lG4aXnM5H6Yh7K95D
 3GlQ==
X-Gm-Message-State: AOJu0YynwmorFr/JL6oF9BYlMWdTx4pC1FKfL67mblxCwimYJWjxuy11
 DqAwkdh/4Rk23zYBn9gIaTDvy1gbxCiLdxMVDtJvu+vTi38KUuYGMPTmlGGItX0uuxtCeoFAbQr
 izTuFa29G0zQUBTv2YHbVtloaD9pydJhgrRf+jO7jCZxXeDU5Af9PScVXRcX4fR6HuFODMA==
X-Gm-Gg: AR+sD11PUybXXBku19Sfx+tlOauUzpEaCSjYDjpvEwUlwIR4pf00z0LDxXHgLiyFa7o
 nVDfGGXNDtvSPEZOHYerJncLXA5rc4SCFd6KfkmYShvFdzovjTtYeRYdcUGqPu9/SGYmKCpY7Fe
 BVkT3A7Nz6I4lGbCV6vMYwCL5/CvaLHmTpUaD5fQ6DcNaFpSeZPGy0+oxXMBPH4S02hAqC9LAgb
 FQ9hcHiVJQP5fTwF8NPdh/nc52j5BS7fOfTJZYwPM89HapJbvdHMkKMa0UzkkEYu8xG6IW2BE8E
 2BDEWGYSA7cQAVRlHgEvoSVJ3h8blje2uAukozxbefUzw8dvIkx6E7VM6OxOCYGbV0dBTTo6N3W
 CFC135xmWnB0t6wxgvG13tzyuZBUVKXCkFsslQXnJrBorDA==
X-Received: by 2002:a05:600c:19cc:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-499b847725emr5442825e9.15.1787245689208; 
 Thu, 20 Aug 2026 10:08:09 -0700 (PDT)
X-Received: by 2002:a05:600c:19cc:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-499b847725emr5441695e9.15.1787245688826; 
 Thu, 20 Aug 2026 10:08:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb?
 ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm96595825e9.4.2026.08.20.10.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 10:08:08 -0700 (PDT)
Message-ID: <9598769e-597b-45da-b8d6-710c11227858@redhat.com>
Date: Thu, 20 Aug 2026 19:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] drm/panic: Pass colors to draw_panic_dispatch()
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-6-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-6-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LyJ8QyMxernSiXdmDYZi8Szr1zR0VlfrUUUdtwACi84_1787245689
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

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> Set the panic-screen colors in draw_panic_plane() as a single point
> of truth. Pass the values into the individual drawing functions.
> 
> In the test cases, replace the Kconfig-defined colors with white and
> black. Allows for removal of the tests' limitations and dependency on
> the exact values. All tests now always verify the generated output.
> 
> Hardcoding the test colors will later also allow for building the
> test case without having DRM panic handling enabled.

Thanks, that makes sense, I should've think about it, as this colors was 
a bit painful when writing the KUnit tests.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c            | 54 +++++++++++++++-----------
>   drivers/gpu/drm/tests/drm_panic_test.c | 26 +++++++++----
>   2 files changed, 49 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 594235661710..ede620b27515 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -478,12 +478,8 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
>   				   fg_color);
>   }
>   
> -static int draw_panic_screen_user(struct drm_scanout_buffer *sb)
> +static int draw_panic_screen_user(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
>   {
> -	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
> -						    sb->format->format);
> -	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
> -						    sb->format->format);
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg;
>   	unsigned int msg_width, msg_height;
> @@ -491,6 +487,9 @@ static int draw_panic_screen_user(struct drm_scanout_buffer *sb)
>   	if (!font)
>   		return -EINVAL;
>   
> +	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
> +	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
> +
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   	drm_panic_logo_rect(&r_logo, font);
>   
> @@ -549,12 +548,8 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
>    * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
>    * and going up until reaching the top of the screen.
>    */
> -static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
> +static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
>   {
> -	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
> -						    sb->format->format);
> -	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
> -						    sb->format->format);
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   	struct kmsg_dump_iter iter;
> @@ -566,6 +561,9 @@ static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
>   	if (!font || font->width > sb->width)
>   		return -EINVAL;
>   
> +	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
> +	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
> +
>   	yoffset = sb->height - font->height - (sb->height % font->height) / 2;
>   
>   	/* Fill with the background color, and draw text on top */
> @@ -748,12 +746,9 @@ static int drm_panic_get_qr_code(u8 **qr_image)
>   /*
>    * Draw the panic message at the center of the screen, with a QR Code
>    */
> -static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
> +static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> +				      u32 fg_color, u32 bg_color)
>   {
> -	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
> -						    sb->format->format);
> -	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
> -						    sb->format->format);
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
>   	unsigned int max_qr_size, scale;
> @@ -766,6 +761,9 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>   	if (!font)
>   		return -EINVAL;
>   
> +	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
> +	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
> +
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   
>   	drm_panic_logo_rect(&r_logo, font);
> @@ -818,10 +816,10 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>   	return 0;
>   }
>   
> -static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
>   {
> -	if (_draw_panic_screen_qr_code(sb))
> -		draw_panic_screen_user(sb);
> +	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color))
> +		draw_panic_screen_user(sb, fg_color, bg_color);
>   	return 0;
>   }
>   #else
> @@ -893,22 +891,22 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
>   	return drm_draw_can_convert_from_xrgb8888(format->format);
>   }
>   
> -static int draw_panic_dispatch(struct drm_scanout_buffer *sb)
> +static int draw_panic_dispatch(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
>   {
>   	int ret;
>   
>   	switch (drm_panic_type) {
>   	case DRM_PANIC_TYPE_KMSG:
> -		ret = draw_panic_screen_kmsg(sb);
> +		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
>   		break;
>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   	case DRM_PANIC_TYPE_QR:
> -		ret = draw_panic_screen_qr_code(sb);
> +		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color);
>   		break;
>   #endif
>   	case DRM_PANIC_TYPE_USER:
>   	default:
> -		ret = draw_panic_screen_user(sb);
> +		ret = draw_panic_screen_user(sb, fg_color, bg_color);
>   	}
>   
>   	return ret;
> @@ -943,6 +941,16 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
>   	struct drm_scanout_buffer sb = { };
>   	int ret;
>   	unsigned long flags;
> +#if defined(CONFIG_DRM_PANIC_FOREGROUND_COLOR)
> +	u32 fg_color = CONFIG_DRM_PANIC_FOREGROUND_COLOR;
> +#else
> +	u32 fg_color = 0x00ffffff;
> +#endif
> +#if defined(CONFIG_DRM_PANIC_BACKGROUND_COLOR)
> +	u32 bg_color = CONFIG_DRM_PANIC_BACKGROUND_COLOR;
> +#else
> +	u32 bg_color = 0x00000000;
> +#endif
>   
>   	if (!drm_panic_trylock(plane->dev, flags))
>   		return;
> @@ -958,7 +966,7 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
>   
>   	drm_panic_set_description(description);
>   
> -	ret = draw_panic_dispatch(&sb);
> +	ret = draw_panic_dispatch(&sb, fg_color, bg_color);
>   	if (!ret) {
>   		/*
>   		 * Only flush if we have a panic screen to display. Otherwise
> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
> index fdd77b0cc54c..969a096ec840 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
> @@ -14,17 +14,10 @@
>   #include <linux/units.h>
>   #include <linux/vmalloc.h>
>   
> -/* Check the framebuffer color only if the panic colors are the default */
> -#if (CONFIG_DRM_PANIC_BACKGROUND_COLOR == 0 && \
> -	CONFIG_DRM_PANIC_FOREGROUND_COLOR == 0xffffff)
> -
>   static void drm_panic_check_color_byte(struct kunit *test, u8 b)
>   {
>   	KUNIT_EXPECT_TRUE(test, (b == 0 || b == 0xff));
>   }
> -#else
> -static void drm_panic_check_color_byte(struct kunit *test, u8 b) {}
> -#endif
>   
>   struct drm_test_mode {
>   	const int width;
> @@ -48,10 +41,27 @@ struct drm_test_mode {
>   	.width = w, \
>   	.height = h, \
>   	.format = f, \
> -	.draw_screen = draw_panic_screen_##name, \
> +	.draw_screen = draw_panic_screen_ ## name ## _default, \
>   	.fname = #name, \
>   	}, \
>   
> +static int draw_panic_screen_user_default(struct drm_scanout_buffer *sb)
> +{
> +	return draw_panic_screen_user(sb, 0x00ffffff, 0x00000000);
> +}
> +
> +static int draw_panic_screen_kmsg_default(struct drm_scanout_buffer *sb)
> +{
> +	return draw_panic_screen_kmsg(sb, 0x00ffffff, 0x00000000);
> +}
> +
> +#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *sb)
> +{
> +	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000);
> +}
> +#endif
> +
>   static const struct drm_test_mode drm_test_modes_cases[] = {
>   	DRM_TEST_MODE_LIST(user)
>   	DRM_TEST_MODE_LIST(kmsg)

