Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEF606A32E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fYoXIAYm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9E510E9EE;
	Fri,  6 Nov 2026 10:39:53 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6AD10E9EE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 10:39:47 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1ae18eb9ad0so682721c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793961586; x=1794566386;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0jFx9X9ijYmEuuqlS+6ReLoSBlbDgO7KnvPAxuJX2v0=;
 b=fYoXIAYmzql16h/kosPGDRGzAxnMKPSJJBx59KQBNqKZHDZEp3sJXTtDcqtDNC4o0C
 JLUYyq3QXgdLr/VNkQvQ7cxJ4TAWgf7JEWHhmjdnRdEgQeXqC04Kn4Gr1ApK9bvIJV7a
 Wf4cogivqUu8q6HqTvc+iTh36enRFH2Ew4U5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793961586; x=1794566386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0jFx9X9ijYmEuuqlS+6ReLoSBlbDgO7KnvPAxuJX2v0=;
 b=FMh25VCfRDmLpxqZjP8dVtfGvXSG/ARIF/KQNMcWkVxl56jZO4rQ60s/INJHYhyTYK
 RJQg8SFgvAvvVrpQmLW3BJpGWh0NwiNhiW3aOCBOmIzOPioNe9hKc/v0EmrW0hxE8DmQ
 2qh2IEilM2AzqaW/QoZPBCXhtNjCkuH3GFz1x1aVKF+v/rISmNdU38pQwyvZbO3WNZQG
 6LUKiYS6dCy00LWO7WpENcC/xJxkB0wP4JlkeJvDeMW28say5qUtCgNXhkr48QfdKuge
 sQH7HaAbCMfAPlKk3p9nrfMzlDGzVOLw8+0i2xfQgvoqkk/mWtQu6xDmRLKwO6+L4+d8
 O8Vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8cGjDv9gQhaGz9F70BRK1yFrDgwLodquweJh5UKnV4FxsFz5zr8ApHwf5QLfvjoYeNJam63Qu8E8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9UJaVCO7xS3zx39kOpDnQKspuwJm6qT4ZjCNU4UKUitNs7mBuW
 DEITfwiEc85bxroIry3sOlFIlJuhOxVJPGt9GnT4BlBz5AGpnLsU604e6hbAuo+8xw==
X-Gm-Gg: AYBFou2CjKHkJ5wBHnK7yb0PPyMeMl4TwoZLWQlERauIkGX8dXvOWXG66ck+GE5YhaH
 u38k6g55TPgzaIcHtNO4eylAk0uae7mvpqCNbp5ZFaQSeJ+0rnfBCZbzbBSemxRSNhOymqvAa6O
 X/VsHfWUdP+qMVkzbftc1i7ZVBU38p+uzrnF8tSJ5PGtJYpVkjWvgji6yUDSJzlF5OyNedTuZJk
 s0VmsyM/6pdaZCvIOj8UKW+tSREVc+ZD2XfCmCqvG24tQQhFVfykTFxmJsakURrU6tTFC6xNuFR
 n1BBe5KN7CKyPL6uJl8oKl48etzhHyORlkyT0aZy4wCXruTmU6W9kFwFUmyidRodsew9t2SOZCh
 o/ryJpuektFcZWuAXJxkqnuI704oKewWkGSG375RyvUusnoZ0pSRRJeBVrHe3pHnlmmPmIPRCLN
 1RufLSZ/XZJC15NfIHKa4JeQTjoQVuemz6ZiavusbCnrAxB0xGu6J4bo9xhrbNRudsOLOYuKBRz
 Tzh/Hk6gUkGZiTaEnifjwrBRB8lcGNqi9n8XNu+iTvVeFLybym72Mv45WF/vFG7SsBR9amJZgKR
 MhTr2UJwu/D5ibr/Y0XcbiScaak1MKyJt22rIKhxeIpc1lIahodvCZO5PA+eOL015Oz023MDFnW
 2IA3EbCDU0/By0V+y
X-Received: by 2002:a05:7022:fc0b:b0:16a:c6f2:60c2 with SMTP id
 a92af1059eb24-1b25d315d2emr2054258c88.12.1793961586179; 
 Fri, 06 Nov 2026 02:39:46 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com.com
 (61.14.81.34.bc.googleusercontent.com. [34.81.14.61])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4c1df6sm5133779c88.14.2026.11.06.02.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 02:39:45 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>, David Airlie <airlied@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] drm/mediatek: Validate gamma_lut size
Date: Fri,  6 Nov 2026 18:39:05 +0800
Message-ID: <20261106103932.1219696-1-fshao@chromium.org>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DRM core checks that a gamma_lut blob is aligned to
sizeof(struct drm_color_lut) and at most GAMMA_LUT_SIZE entries, so
shorter blobs still reach the driver. mtk_aal_gamma_set() and
mtk_gamma_set() read up to the fixed hardware LUT size, which is an OOB
read when the blob is shorter.

Add mtk_crtc_atomic_check() and reject gamma_lut if its entry count does
not match crtc->gamma_size.

Fixes: 2f3f4dda747c ("drm/mediatek: Add gamma correction.")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- Use drm_color_lut_size() and check against crtc->gamma_size, which
  mtk_crtc_create() already sets for the pipeline. This drops the
  ddp_comp[] loop and avoids the NULL conn_routes slot before enable.
- Move mtk_crtc_atomic_check() before mtk_crtc_atomic_begin() so the
  patch applies cleanly both to linux-next (next-20261104) and on top of
  the mediatek-drm restructuring series.
  https://lore.kernel.org/r/20260714114414.184512-1-angelogioacchino.delregno@collabora.com

 drivers/gpu/drm/mediatek/mtk_crtc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 2920f3198ef6..67c2288ab8e0 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -841,6 +841,17 @@ static void mtk_crtc_atomic_disable(struct drm_crtc *crtc,
 	mtk_crtc->enabled = false;
 }
 
+static int mtk_crtc_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_property_blob *gamma_lut = crtc_state->gamma_lut;
+
+	if (gamma_lut && drm_color_lut_size(gamma_lut) != crtc->gamma_size)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void mtk_crtc_atomic_begin(struct drm_crtc *crtc,
 				  struct drm_atomic_commit *state)
 {
@@ -895,6 +906,7 @@ static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
 	.mode_fixup	= mtk_crtc_mode_fixup,
 	.mode_set_nofb	= mtk_crtc_mode_set_nofb,
 	.mode_valid	= mtk_crtc_mode_valid,
+	.atomic_check	= mtk_crtc_atomic_check,
 	.atomic_begin	= mtk_crtc_atomic_begin,
 	.atomic_flush	= mtk_crtc_atomic_flush,
 	.atomic_enable	= mtk_crtc_atomic_enable,
-- 
2.56.0.455.g6c5a503b38-goog

