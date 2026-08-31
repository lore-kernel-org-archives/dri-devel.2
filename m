Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D49AC624CF
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8605B10E955;
	Mon, 31 Aug 2026 15:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fR2kWyJ2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F9910E952
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:35:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90EFF43451;
 Mon, 31 Aug 2026 15:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA74C1F000E9;
 Mon, 31 Aug 2026 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190500;
 bh=ZHUUdDSwTZFASeDil4oF5cIzvYud/4E0XjMZxFhdCtA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fR2kWyJ2nahnfDU5YKRTk9Wa5IXpTByb61obwDw2/snIrwnHZ5xoV9gzO4yUygFPI
 CsDhbzeLTp2TzVc3VggBpyoyUPe7UyjtNFL5a6Z4A8QfinO3XP0Sakhb0lotyPV6iL
 s0w3NTdQeYk/9+aCSocMQeypk+ZWPjXI3rrdoq9sS5/4nXpNHQnDY0ECA5n7Fiogji
 fuVVx7jdLJqx3rL1R17gsLguiOjxK9kzx7YmP/SYEDUgBccZ6TY9FDTNGYzAahSc96
 tXFhIXBhMzUPEt9E2huJDbZNwm9WKd1Bcce6OSeUT0ksZvZXMzbhvVBMVPMYnMr+QM
 AplzPArE2rlWg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 17:34:21 +0200
Subject: [PATCH v2 08/13] drm/loongson: Move hardware reset to CRTC
 creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-crtc-reset-v2-8-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2824; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zdfzn2cFsGfiQDhB08qWQ/Ixt8J71/NPc/N65yElJTg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5/17dnj5nSdulZ9uHnmp+ZXNpL8t9+dne74tUpo7o
 5fXxr260zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmcqyeseFVVJf0wfqC3S2r
 nljlLZCWdZXd5cZ2MGn6xfXf+213FAb8dFJKjzb3uxqZ4fJctHr5VcaGk++Xr1n8TiN+w4t1XB9
 8Xt6ZGe0yOZPF2fWYduCC396fMxm/+byXUxf7aKg442SxWUciAA==
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
deals with state allocation. Move the hardware reset to the CRTC
creation path instead.

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

