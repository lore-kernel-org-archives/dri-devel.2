Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C6C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A3C10F2EB;
	Fri, 21 Aug 2026 14:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qrb5ETKZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622B010F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A0764097D;
 Fri, 21 Aug 2026 14:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A524B1F00A3A;
 Fri, 21 Aug 2026 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323285;
 bh=H3qdTZ4c02zguBInuSOGOhIFl7W7zrZSvXN5TFlyV3o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Qrb5ETKZQHVNCa8xbjeotL2zIN0qQs2ZDbAnr6hkNWrG4qP/TKE65fxylG4LHuOL3
 /2NrAP6pqEWjK94y8BbA9kwOnur0to9tDJCyrdPQ3bel02cgUpa2qF9aaHVRYpdjWe
 vYdqZ08vOEWfP2g/rr7PNr5swoCEP/I3cs+FJLUqdNpefX3Muxir0XYAEsLn6WU0pA
 VwWJ45IRqL7I9pxLAbDw8XiQ0ZZG+oQ+8vOiSrOMadRgQ6+UItww8R9JxDF9zjWbTP
 GWYYxYjpFLzEJJNcmWOK5wsEKU8pV7j/X/Sol6sVOMXTGimfFiNrWFtrYc28GDsOpb
 RD11ksDsfdU/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:27 +0200
Subject: [PATCH 51/70] drm/loongson: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-51-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xAdxfHCbC9hMGv85n3fxE7QoI7cVdk1BOOU21EnPjiE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyXxrGfO2cc2O9dKwMj946U7LbQuRojtRde89/326a
 5VXsGxvx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIrAzGOu30aSciPW8uWq9Y
 b/DoxuWGWf9rVVXKpaX+/zoX37enOsTkwgEnOQUurhs9LiJuYhmKjA2vv5fea1fWKp2UxzSxN1t
 a2mnB8cT6k7syG84vkfnO6l6/5+Az89JpYvNcJ2xZXjl77n8A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The loongsoon crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It does
not perform any hardware reset.

Since the atomic_create_state hook is only meant to deal with state
allocation and initialization, convert it accordingly. The hardware
reset through ops->reset() is kept as part of the state creation
since the core currently calls atomic_create_state in the same
context where the reset hook was called.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>
Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: Qianhai Wu <wuqianhai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/loongson/lsdc_crtc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loongson/lsdc_crtc.c
index 97a3443739e1..2815366abc14 100644
--- a/drivers/gpu/drm/loongson/lsdc_crtc.c
+++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
@@ -386,23 +386,22 @@ static const struct lsdc_crtc_hw_ops ls7a2000_crtc_hw_ops[2] = {
 		.get_vblank_counter = lsdc_crtc1_get_vblank_count,
 		.reset = lsdc_crtc1_reset,
 	},
 };
 
-static void lsdc_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *lsdc_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct lsdc_crtc_state *priv_crtc_state;
 
-	if (crtc->state)
-		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
-
 	priv_crtc_state = kzalloc_obj(*priv_crtc_state);
 
 	if (!priv_crtc_state)
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
-	else
-		__drm_atomic_helper_crtc_reset(crtc, &priv_crtc_state->base);
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_crtc_state_init(&priv_crtc_state->base, crtc);
+
+	return &priv_crtc_state->base;
 }
 
 static void lsdc_crtc_atomic_destroy_state(struct drm_crtc *crtc,
 					   struct drm_crtc_state *state)
 {
@@ -705,11 +704,11 @@ static void lsdc_crtc_atomic_print_state(struct drm_printer *p,
 	drm_printf(p, "\tMedium clock multiplier = %u\n", pparms->loopc);
 	drm_printf(p, "\tOutput clock divider = %u\n", pparms->div_out);
 }
 
 static const struct drm_crtc_funcs ls7a1000_crtc_funcs = {
-	.reset = lsdc_crtc_reset,
+	.atomic_create_state = lsdc_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = lsdc_crtc_atomic_duplicate_state,
 	.atomic_destroy_state = lsdc_crtc_atomic_destroy_state,
@@ -719,11 +718,11 @@ static const struct drm_crtc_funcs ls7a1000_crtc_funcs = {
 	.get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
 	.atomic_print_state = lsdc_crtc_atomic_print_state,
 };
 
 static const struct drm_crtc_funcs ls7a2000_crtc_funcs = {
-	.reset = lsdc_crtc_reset,
+	.atomic_create_state = lsdc_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = lsdc_crtc_atomic_duplicate_state,
 	.atomic_destroy_state = lsdc_crtc_atomic_destroy_state,

-- 
2.55.0

