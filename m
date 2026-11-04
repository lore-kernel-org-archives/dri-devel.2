Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D5606A332
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/LtkE+J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C663112C6C;
	Fri,  6 Nov 2026 09:19:00 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477B810FCD5
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:51:27 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so196650f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793807485; x=1794412285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5MryvWougc8oZCTNV6AOfjFxzrIHneZrJJ6z1cTNnJA=;
 b=g/LtkE+J/YExNddtfXaKk6NcUOk+8sPKFjg8MKX+4ivChFstuUFGqXEj97gVjcUxdb
 k/befIqRFr322MP/sOdZmACLckAAHLgKRqmJQSwCck0JKON97riEbMIb5cNcusBG3O2C
 I7DhbQ6VelKjilwkLr9TC9pe5MUjQaHJgcVDFk0Nzyb8EzkaZ1iESH8hyssE0xSYR5cP
 3gzbcNNh7EItQ+mqfQNB8i2JJZ8t9ynVCKHO6wxE2yIisojZObequI407EIEG7vazPsl
 Dn7uUSbcsee12LzxwTMgDM/7w7KCayPLGAdVRuOE4zEnqDHUAp45d4l2NpsfayB1CZxW
 7rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793807485; x=1794412285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5MryvWougc8oZCTNV6AOfjFxzrIHneZrJJ6z1cTNnJA=;
 b=DzU188SaSwHSaqIQwXSoSCvC6cUFrDhoVu2Vf8KXqrx1WWYpdb6gsIdb9MBkZ9SKU7
 QkEMr5XGPFRGknYRF2EH/Igh3m2eciDjjk4/I4M2MXlWt1LUQZcaQEL36f8lF2nS6lvn
 DiSVWATns78n4QHcwdYhdfhGlkOnteNrQlHtgxkXRCbvJL+19qQZIupGnZpFpGbP4m51
 k+5ewPqYv0061NE7oLK3Cgea7O6bqb64T3uybaWktM2Lgyyzbqy5DjmSbfWxAbA3nPkh
 EaOiZ68htpIPMRawY3EVdCNYPbwZjUQIuebMlSwJ/Riqw1uQHKa9watsmQDh/dqJJKUN
 JaOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7+mGwjSJQYnpYHdS1Pi5O3k8FcEjM3dVv16mmlTcvHLbJZS+W8J5pJi9JSEO45FTyjFuVtH99lDk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Upl5CiVQBVZuslaAe7lXj1zNM7xG6wNmB6CD5R88MIMtQY/g7
 qT0MIjeN4mNCDFslfyE6wNhGfqcHbFMp+pnnUwFaEdicw2zKZ/D4szmf
X-Gm-Gg: AYBFou08K3GTEU59SeSOV2ZXZJnRpjm4Eq+5mfmzz0o8ABdbCLgA99O5IaKoGcaORSx
 l9P2VVuSJeATOyEYCevsxTUI82PaQSdBFxAD+qc0jlfPzJLd8tmEN+8GMScU4qnhbbImcoVF0S7
 9L/DIdtgTMGybsp+uAFvXIbQMxjRkZlkwP5d0325876uojZPFklMbejOVQJTx5yIG105AfLZzEE
 NvoFA71nouSFH4hVzC2U+CmMHd2ENw3KmTu8KeHlJEyWq27hPUL3s7bKkjprBZvelaMP2V1hsgw
 2qC3xhIuIpqiKsIiuUZSPHyD2E64hdpYUIS6wcVutasGzch3JOXIRTjj8dvfkoh5XNE2+yY8XJb
 jw6rppV/B5AcV9cAYqCWuXfbVginyocTzGEV1sSVMtxa8PcyToboP7RkIi4Apg32rO8ev+0hm6q
 0BHFHhAcf5okaHopT18i/bVdz9X7vUKA/63zEeAIEkbiGhvqSHCQ2oXHvXBrc2hSgUfjJomMZzc
 PQqNlenKts1mU2CWhIV2OTn96u01uH3HkyczN8Cg00jZrucQMGp0BljYNQDxAmVBBb30NrosPiR
 F4Fx4l+WVHej7jxvTJSQDKdbBLlrUvgd/Y7w+GE4Lw5s8A==
X-Received: by 2002:a05:6000:402c:b0:48e:76ab:7906 with SMTP id
 ffacd0b85a97d-48e76ab7f39mr33469456f8f.9.1793807485352; 
 Wed, 04 Nov 2026 07:51:25 -0800 (PST)
Received: from localhost.localdomain ([79.117.198.103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecac2772sm4394985f8f.18.2026.11.04.07.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:51:24 -0800 (PST)
From: Jose Nieto <jnieto.alaber@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jose Nieto <jnieto.alaber@gmail.com>
Subject: [PATCH] drm/meson: plane: add pixel blend mode property
Date: Wed,  4 Nov 2026 16:51:19 +0100
Message-ID: <20261104155119.284708-1-jnieto.alaber@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The primary plane exposes ARGB8888, a format with alpha, but never set up
the pixel blend mode property. This makes the DRM core warn at boot:

  [PLANE:...:meson_primary_plane] pixel format with alpha exposed but
  blend mode not setup. Please fix.

Advertise PIXEL_NONE and COVERAGE and derive OSD_REPLACE_EN from the
requested blend mode. Formats without alpha (e.g. XRGB8888) keep the
previous opaque behaviour.

Signed-off-by: Jose Nieto <jnieto.alaber@gmail.com>
---
 drivers/gpu/drm/meson/meson_plane.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index cf8c90158fcf..115849a0b0c8 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -233,18 +233,13 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 		}
 	}
 
-	switch (fb->format->format) {
-	case DRM_FORMAT_XRGB8888:
-	case DRM_FORMAT_XBGR8888:
-		/* For XRGB, replace the pixel's alpha by 0xFF */
+	if (!fb->format->has_alpha ||
+	    new_state->pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
+		/* Ignore the pixel's alpha */
 		priv->viu.osd1_ctrl_stat2 |= OSD_REPLACE_EN;
-		break;
-	case DRM_FORMAT_ARGB8888:
-	case DRM_FORMAT_ABGR8888:
-		/* For ARGB, use the pixel's alpha */
+	else
+		/* Use the pixel's alpha */
 		priv->viu.osd1_ctrl_stat2 &= ~OSD_REPLACE_EN;
-		break;
-	}
 
 	/* Default scaler parameters */
 	vsc_bot_rcv_num = 0;
@@ -536,6 +531,7 @@ int meson_plane_create(struct meson_drm *priv)
 	struct drm_plane *plane;
 	const uint64_t *format_modifiers = format_modifiers_default;
 	int ret;
+	unsigned int blend_modes = BIT(DRM_MODE_BLEND_PIXEL_NONE) | BIT(DRM_MODE_BLEND_COVERAGE);
 
 	meson_plane = devm_kzalloc(priv->drm->dev, sizeof(*meson_plane),
 				   GFP_KERNEL);
@@ -566,6 +562,10 @@ int meson_plane_create(struct meson_drm *priv)
 	/* For now, OSD Primary plane is always on the front */
 	drm_plane_create_zpos_immutable_property(plane, 1);
 
+	ret = drm_plane_create_blend_mode_property(plane, blend_modes);
+	if (ret)
+		return ret;
+
 	priv->primary_plane = plane;
 
 	return 0;
-- 
2.47.3

