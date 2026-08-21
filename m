Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8D8C5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B424F10F2D3;
	Fri, 21 Aug 2026 14:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WO8Bp0CO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4AC10F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E1F061126;
 Fri, 21 Aug 2026 14:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDC21F00A3A;
 Fri, 21 Aug 2026 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323282;
 bh=YF4ulTFPQ9dpuEkLl67S86krnE1Gf413sUpyieImxns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WO8Bp0COI4RBryw1wwhyNO9y+y2AeQaqT4UiM8K/a0rkVdCRwQy5zvWkswnmeLj7o
 1WzNMTDY3qplj91JxRadLoQQA3gKFyo8/MJ9/K982beV5I6us++9voJFZL27WZgTmZ
 UrHYniGNFKPxGaIM4KAhWWFUj3ONr8BaaFoMuQ9MhbkQQ2ZfzLysim4q/Iy+ITYHK/
 wLHUlS4IoYvDI3Y1ODUlG+4LrNuaBfoCxoPq4Ihopc+Rm0CvfvwKN41fzbq2u5Ee0g
 YIShQRu0N3Nnpva9BVMwrSvscVqi3KDMQalXUKb17aX8/sc9vpkI+iKMXk329sMn4Y
 NaBNsMdNNTAbg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:26 +0200
Subject: [PATCH 50/70] drm/loongsoon: Move hardware reset to CRTC creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-50-fb793475c05a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Whe0PlznCc1qyS/hKnL/XWGrq2KFLjexP/waJoaK/BM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyXzm1fPTGFKfCTsErVhfZ/lSmlvu1ea7Nple/68Fb
 JX3F9rRMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYivJqxPregQ19qSufT226t
 J1pv7n8/aWbdESPephKZqfxFi0UevXN13np0xXLdTwKblN0PlXnmMzZsPtd5uz94lWjFf5bOF4c
 PujxJ3K/lk3x1wVXmvmXOLyvteu4fPlGyabvTZLbyKO+sT8wA
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

The loongsoon crtc reset hook performs both atomic state initialization
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
 drivers/gpu/drm/loongson/lsdc_crtc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loongson/lsdc_crtc.c
index 16b8f36a4071..97a3443739e1 100644
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
@@ -981,10 +976,13 @@ int ls7a1000_crtc_init(struct drm_device *ddev,
 	if (ret)
 		return ret;
 
 	drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
 
+	/* Reset the CRTC hardware, this is required for S3 support */
+	lcrtc->hw_ops->reset(lcrtc);
+
 	return 0;
 }
 
 int ls7a2000_crtc_init(struct drm_device *ddev,
 		       struct drm_crtc *crtc,
@@ -1020,7 +1018,10 @@ int ls7a2000_crtc_init(struct drm_device *ddev,
 	if (ret)
 		return ret;
 
 	drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
 
+	/* Reset the CRTC hardware, this is required for S3 support */
+	lcrtc->hw_ops->reset(lcrtc);
+
 	return 0;
 }

-- 
2.55.0

