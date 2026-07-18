Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A57C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AD510E611;
	Sat, 18 Jul 2026 23:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YojWkk+d";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C63710E60E
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:36:48 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso22728025e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784417806; x=1785022606; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LYdVSEJYSxlpPRyHCi7r5tN2RJPa+UFv81a3Ufh1joM=;
 b=YojWkk+dlxfY4Wg0d4k3iYRsw/tXzKzP8fpthl0GwmS0QqvCMLuVy+/OZCQUAUKr4o
 24qFB4HkqrwqIDJu/0zIviCKj5WmSVL2IjJ/5dw6EaR7Syoqu7UC79VALqagkbhG1wY6
 N6iGiLAVy8nlfTDVCHlHwJA0m/W1qm7rZqZ76HTqqQLU/lSTmoLRJiaIv6e1vw4Dr6mX
 pD73EjCkOrWI+PUV9HCktO8U6gQuA85p5R4Waah149mDR4SjVu6JDa+gDJZYzGQjAqxP
 QudymZjMYv27WynzFcOqfezA9xvJhUoX0iJo3cGjRP7ncwnhnSdZYhv7SdH12Wvvvvqb
 EwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784417806; x=1785022606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LYdVSEJYSxlpPRyHCi7r5tN2RJPa+UFv81a3Ufh1joM=;
 b=rig7P+tLmnnZUFVatKmvsojxnDqyR83k07Vclzn0gGmjD4aIXo8e75HpTRg4jl7TSu
 NyiJniW55dgS0i5vcx+Fvsc4XMMqgsaJn24dKa4Slxeq55VkIGJmFOID+6giA0TmJx4p
 ekWU+fOjjR9/QVCbhuT280NHc69Lp6a6u7G4iMgii+Vbm78TOuvrt2LQgEwmF/8eNMDM
 I3f5Ta78QWXjCqWoxN/tg9unTYr0c5/2F0L0soMpg42xvlbl6zCGNB3ETlEfAPgLYwi9
 as226TxeIJgY09aopcvphEyIVwvqbObWvp2ju8d5QFuXe/AySoHqFIPsGNFNHUQ/8cBO
 wDiw==
X-Gm-Message-State: AOJu0YxDxtrlB0cIc1HHxPDkpt8vq3wHpKeJjZ8jhbgP40mF5MtQcaLn
 1CjG5nLbKCRilaQ3TzR/f0FbeCVziec+ke6Rlzd5P9HwH9oansCdSTmQ
X-Gm-Gg: AfdE7ckalJbRLslr3Av6OwOowQeY0KVwBm0kpMkK0i6098KzZ3HrRP0VAau4wwtfooA
 D9nw/hg0GBPrZLCTFbaCp4/2jxofu+ZGVF77K5lupG2OVXxcdSGvGdzeqjp3wCIcAGsvT0iLeMK
 RVstD7gX5eVPeS5NyKHxRhC901ECSTnK45tnEnx7eJ30xBo2IM1oXgoTfmHfK28AkVQTzD3sa6y
 Whl7M2jf7z1Uo6bQaCAc4xxDP/EGxFmjG6qGq+lhRoj2XVTZBu1s6Nytc1EDWe3M+WrvVsKTfo1
 0wEmpl4zEXUCg/+euop8ukcQJ5fQ3plKpV5H/ZtuPHHRRhn4mYKO/icq2haz8OBDTvME1uK35KI
 vG+uDwzgvk8DbfcSY9TvaZm5wAQkdZJd6GLXpTTGErVgYcwYpQtbsaX56Y+ntN90YyM8AzYTQBq
 WIxn0UBzP08g==
X-Received: by 2002:a05:600c:1c28:b0:493:bd2a:93bb with SMTP id
 5b1f17b1804b1-4954a3d0be6mr96444645e9.3.1784417806328; 
 Sat, 18 Jul 2026 16:36:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 16:36:45 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:45 +0200
Subject: [PATCH 14/15] drm/drm_simple: remove deprecated
 drm_simple_encoder_init function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-14-a78c509e3062@gmail.com>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
In-Reply-To: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-doc@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.15.2
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

The simple KMS helpers are deprecated because they only add an
intermediate layer between drivers and atomic modesetting.

All driver users of drm_simple_encoder_init() have been converted to
drm_encoder_init(). Drop the helper and open-code its remaining internal
use in drm_simple_display_pipe_init() to prevent new users.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 13 ++-----------
 include/drm/drm_simple_kms_helper.h     |  4 ----
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 8e1d07b9f1e3..7878b9d7d524 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -20,16 +20,6 @@ static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
 	.destroy = drm_encoder_cleanup,
 };
 
-int drm_simple_encoder_init(struct drm_device *dev,
-			    struct drm_encoder *encoder,
-			    int encoder_type)
-{
-	return drm_encoder_init(dev, encoder,
-				&drm_simple_encoder_funcs_cleanup,
-				encoder_type, NULL);
-}
-EXPORT_SYMBOL(drm_simple_encoder_init);
-
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type)
 {
@@ -363,7 +353,8 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 		return ret;
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(dev, encoder, &drm_simple_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret || !connector)
 		return ret;
 
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index cb672ce0e856..c95f86ff355f 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -68,10 +68,6 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 			const uint64_t *format_modifiers,
 			struct drm_connector *connector);
 
-int drm_simple_encoder_init(struct drm_device *dev,
-			    struct drm_encoder *encoder,
-			    int encoder_type);
-
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type);
 

-- 
2.54.0

