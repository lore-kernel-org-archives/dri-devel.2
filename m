Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D8606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE97410FDF1;
	Wed, 18 Nov 2026 15:35:20 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044C710FDED
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:35:04 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.23])
 by APP-05 (Coremail) with SMTP id zQCowAB31bqdxf1qc3xpAQ--.6681S5;
 Wed, 18 Nov 2026 23:34:59 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joey Lu <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>
Cc: David Airlie <airlied@gmail.com>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH v3 3/5] drm/verisilicon: nuke planes' atomic_enable hooks
Date: Wed, 18 Nov 2026 23:34:46 +0800
Message-ID: <20261118153448.375639-4-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118153448.375639-1-zhengxingda@iscas.ac.cn>
References: <20261118153448.375639-1-zhengxingda@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAB31bqdxf1qc3xpAQ--.6681S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGF47Cw1rtw4Dur1fAFWkJFb_yoWrtw48pr
 4YyFykKw4FqaykWFyDtr4vqay3G3W0k34Igrs5GwsIqrnxtw47u3W8tr97uF4DJr9rGa1f
 JFs2y3Z8Ar1IyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
 v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
 6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
 AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
 2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
 C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
 nUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The atomic_update hooks of both planes are just bailing out early when
the planes are invisible, so it's reasonable to just remove these hooks
and update the enabled state in atomic_update.

This fixes the problem that invisible but enabled planes won't be
shown when made visible, as pointed by Sashiko.

Fixes: dbf21777caa8 ("drm: verisilicon: add a driver for Verisilicon display controllers")
Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 22 +++-------------
 .../gpu/drm/verisilicon/vs_primary_plane.c    | 26 +++++--------------
 2 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index 1fa6b7578b27e..1e1805eb88704 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -99,23 +99,6 @@ static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int output)
 			VSDC_CURSOR_CONFIG_IMG_UPDATE);
 }
 
-static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
-					   struct drm_atomic_commit *atomic_state)
-{
-	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
-								       plane);
-	struct drm_crtc *crtc = state->crtc;
-	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
-	unsigned int output = vcrtc->id;
-	struct vs_dc *dc = vcrtc->dc;
-
-	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
-			   VSDC_CURSOR_CONFIG_FMT_MASK,
-			   VSDC_CURSOR_CONFIG_FMT_ARGB8888);
-
-	vs_cursor_plane_commit(dc, output);
-}
-
 static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
 					    struct drm_atomic_commit *atomic_state)
 {
@@ -154,6 +137,10 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 	output = vcrtc->id;
 	dc = vcrtc->dc;
 
+	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
+			   VSDC_CURSOR_CONFIG_FMT_MASK,
+			   VSDC_CURSOR_CONFIG_FMT_ARGB8888);
+
 	/* Other sizes should be rejected by atomic_check */
 	switch (state->crtc_w) {
 	case 32:
@@ -227,7 +214,6 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 static const struct drm_plane_helper_funcs vs_cursor_plane_helper_funcs = {
 	.atomic_check	= vs_cursor_plane_atomic_check,
 	.atomic_update	= vs_cursor_plane_atomic_update,
-	.atomic_enable	= vs_cursor_plane_atomic_enable,
 	.atomic_disable	= vs_cursor_plane_atomic_disable,
 };
 
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index c12fe54096c33..7add4669f5803 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -60,25 +60,6 @@ static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int output)
 			VSDC_FB_CONFIG_EX_COMMIT);
 }
 
-static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
-					   struct drm_atomic_commit *atomic_state)
-{
-	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
-								       plane);
-	struct drm_crtc *crtc = state->crtc;
-	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
-	unsigned int output = vcrtc->id;
-	struct vs_dc *dc = vcrtc->dc;
-
-	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
-			VSDC_FB_CONFIG_EX_FB_EN);
-	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
-			   VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
-			   VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
-
-	vs_primary_plane_commit(dc, output);
-}
-
 static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
 					    struct drm_atomic_commit *atomic_state)
 {
@@ -149,13 +130,18 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
 		     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
 
+	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
+			VSDC_FB_CONFIG_EX_FB_EN);
+	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
+			   VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
+			   VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
+
 	vs_primary_plane_commit(dc, output);
 }
 
 static const struct drm_plane_helper_funcs vs_primary_plane_helper_funcs = {
 	.atomic_check	= vs_primary_plane_atomic_check,
 	.atomic_update	= vs_primary_plane_atomic_update,
-	.atomic_enable	= vs_primary_plane_atomic_enable,
 	.atomic_disable	= vs_primary_plane_atomic_disable,
 };
 
-- 
2.56.0

