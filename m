Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023C60A3804
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dYVwCpdy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A9810EC39;
	Tue, 20 Oct 2026 16:53:09 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A9410E796
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:52:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 25A881A129A;
 Tue, 20 Oct 2026 16:52:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E7CE960393;
 Tue, 20 Oct 2026 16:52:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D6FCF103289A8; 
 Tue, 20 Oct 2026 18:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792515175; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GLdXsNmeIbjCOijJh4ieF8NftgaQHDTYB8E1f/WmycQ=;
 b=dYVwCpdyD92wQz+JCeRfjuWXiDzWAHklB7DPGH8oFtwSYyloIH2w2wCvYj+YC2KtWJhezG
 mRYa6hyJ3gvlC5ZAlc8FZBU3meamkg06H4WIzPEFbMhFaBSGqKZy2SqjuhXcVqC2UkCP1D
 vo0vR1Z1Z15OLOntYCooWWpaXnPLVXI6zav//wE3J1OckY00w2ioPDFernM6nveeNSQWnT
 07LoPl4YrxXleLL4QVudzZae3uYVHUfOzitFpeRtQ3gNOA4tyJk0s/LRGPeh+9PIciU9U7
 Cn077/qne5F3Afqm0uLrtuOB6JhtAfbntUSHQ9Fcb0jNVvrRTpIS4qlII+4yEQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 08/14] drm/bridge: it6505: avoid division by zero in
 audio FS debug print
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>, 
 Pin-yen Lin <treapking@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <26ee2c94c42fb09c081201071cb5730c96c8c25b.1790552614.git.daniel@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
 <26ee2c94c42fb09c081201071cb5730c96c8c25b.1790552614.git.daniel@makrotopia.org>
Date: Tue, 20 Oct 2026 18:51:39 +0200
Message-Id: <179251509978.78870.2485132679226608837.b4-review@b4>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> REG_AUDIO_INPUT_FREQ reads back 0 when no audio clock has been
> latched, and it6505_read() returns a negative errno on i2c failure.
> The debug print divides by the readback, and its arguments are
> evaluated even with debug output disabled. Only print when the value
> is usable as a divisor.
>
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index cf2cd59625d5..0d2101432416 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1623,8 +1623,11 @@ static void it6505_enable_audio(struct it6505 *it6505)
>  	it6505_set_bits(it6505, REG_AUDIO_SRC_CTRL, AUDIO_FIFO_RESET, 0x00);
>  	it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
>  	regbe = it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
> -	DRM_DEV_DEBUG_DRIVER(dev, "regbe:0x%02x audio input fs: %d.%d kHz",
> -			     regbe, 6750 / regbe, (6750 % regbe) * 10 / regbe);
> +	if (regbe > 0)
> +		DRM_DEV_DEBUG_DRIVER(dev,
> +				     "regbe:0x%02x audio input fs: %d.%d kHz",
> +				     regbe, 6750 / regbe,
> +				     (6750 % regbe) * 10 / regbe);
>  	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_AUD_MUTE, 0x00);
>  }
>

By just looking at your patch and the current driver code I'm failing to
understand what's going on with the REG_AUDIO_INPUT_FREQ register:

 * it is read, but never written
 * its value is used by:
   - it6505_enable_audio() only for logging: is that logging really useful?
   - it6505_audio_input(), just checking whether it is 0xFF or not; what's
     that 0xFF? Is it documented? A macro hinting at what 0xFF means would
     be better than just '0xFF'

If you could share what that register is for, it would probably answer some
of those questions.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

