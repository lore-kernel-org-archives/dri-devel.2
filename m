Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92E8C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB7610F9AA;
	Fri,  4 Sep 2026 09:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="REMq9cMV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2936410F9AA
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:08:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A10B860211;
 Fri,  4 Sep 2026 09:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCF01F00A3F;
 Fri,  4 Sep 2026 09:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512882;
 bh=iP1TgTdLjKunYBfrXtqDKwVKmM//aOwbizjKYMG7msw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=REMq9cMV0/DlHl577r9RMP2qhp+StPBc3PYHePnb01z08/aNM/tluJFBi6MG1yadU
 2VR2HsIAxZjah1vYBjAVq8T+48os5UJxPsG6HgqpnyKKKAHRlLhb1JTqzSdgzZzswX
 YpSffM1WVtqrZtF3R6+AS0cGtmSMO8VR1hcOzG5zFThv1TINQZDQXiNOL3yCLFjace
 9TIRCQjdpcVr+kPvLkmSmtQgrjACNF6+82O/7TNfANkKxjOt8lvOueveZmApTJeJ1o
 ZGP4c3Sua9pKJOD9clpjXnk+RqmXiwA9AWb9LoMr0eAhIBD5tHYZLR5H7mrtw7W3q2
 dGeE9ilsWM/LA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:26 +0200
Subject: [PATCH v3 08/13] drm/loongson: Move hardware reset to hw_reset
 hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-8-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7Vf6qOZg6CdVxbWcEXwb8C5jUBPy1YWweKwd0DhnzH8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzuvzs1jfVfK29bioT5hG74sFCn7KHp3b0BnzoDdG0b
 zi0cKF7x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIwhOMDX9cHM9wXO+RVTxX
 /6fSZaOsl+Km60nXoixLlFcleSbVHksxL8jVNmrU+74iLy6vdq4yY51Oe9ulhppT0x1dt370VV6
 jY9weHdAjX97voWS041FP44apDKmmjtsPMv5g8ai/rf3yHwA=
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

The loongson crtc reset hook performs both atomic state initialization
using __drm_atomic_helper_crtc_reset() and hardware-level register
writes to reset the CRTC.

The hardware reset is not related to atomic state initialization, and
the reset hook is being converted to atomic_create_state which only
deals with state allocation. Move the hardware reset to the hw_reset
helper hook instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>
Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: Qianhai Wu <wuqianhai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/loongson/lsdc_crtc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loongson/lsdc_crtc.c
index 16b8f36a4071..7cca574e3b6a 100644
--- a/drivers/gpu/drm/loongson/lsdc_crtc.c
+++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
@@ -388,12 +388,10 @@ static const struct lsdc_crtc_hw_ops ls7a2000_crtc_hw_ops[2] = {
 	},
 };
 
 static void lsdc_crtc_reset(struct drm_crtc *crtc)
 {
-	struct lsdc_crtc *lcrtc = to_lsdc_crtc(crtc);
-	const struct lsdc_crtc_hw_ops *ops = lcrtc->hw_ops;
 	struct lsdc_crtc_state *priv_crtc_state;
 
 	if (crtc->state)
 		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
 
@@ -401,13 +399,10 @@ static void lsdc_crtc_reset(struct drm_crtc *crtc)
 
 	if (!priv_crtc_state)
 		__drm_atomic_helper_crtc_reset(crtc, NULL);
 	else
 		__drm_atomic_helper_crtc_reset(crtc, &priv_crtc_state->base);
-
-	/* Reset the CRTC hardware, this is required for S3 support */
-	ops->reset(lcrtc);
 }
 
 static void lsdc_crtc_atomic_destroy_state(struct drm_crtc *crtc,
 					   struct drm_crtc_state *state)
 {
@@ -935,18 +930,28 @@ static bool lsdc_crtc_get_scanout_position(struct drm_crtc *crtc,
 		*etime = ktime_get();
 
 	return true;
 }
 
+static void lsdc_crtc_hw_reset(struct drm_crtc *crtc)
+{
+	struct lsdc_crtc *lcrtc = to_lsdc_crtc(crtc);
+
+	/* Reset the CRTC hardware, this is required for S3 support */
+	if (lcrtc->hw_ops->reset)
+		lcrtc->hw_ops->reset(lcrtc);
+}
+
 static const struct drm_crtc_helper_funcs lsdc_crtc_helper_funcs = {
 	.mode_valid = lsdc_crtc_mode_valid,
 	.mode_set_nofb = lsdc_crtc_mode_set_nofb,
 	.atomic_enable = lsdc_crtc_atomic_enable,
 	.atomic_disable = lsdc_crtc_atomic_disable,
 	.atomic_check = lsdc_crtc_helper_atomic_check,
 	.atomic_flush = lsdc_crtc_atomic_flush,
 	.get_scanout_position = lsdc_crtc_get_scanout_position,
+	.hw_reset = lsdc_crtc_hw_reset,
 };
 
 int ls7a1000_crtc_init(struct drm_device *ddev,
 		       struct drm_crtc *crtc,
 		       struct drm_plane *primary,

-- 
2.55.0

