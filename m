Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC23606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451B110E592;
	Mon,  2 Nov 2026 07:57:30 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46E810E5AF
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:57:28 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-01 (Coremail) with SMTP id qwCowADH8PpcQuhqxn0oAA--.14870S4;
 Mon, 02 Nov 2026 15:57:20 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joey Lu <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH v2 2/4] drm/verisilicon: nuke planes' atomic_enable hooks
Date: Mon,  2 Nov 2026 15:57:08 +0800
Message-ID: <20261102075710.1286456-3-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102075710.1286456-1-zhengxingda@iscas.ac.cn>
References: <20261102075710.1286456-1-zhengxingda@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADH8PpcQuhqxn0oAA--.14870S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGF47Cw1rtw4Dur1fAFWkJFb_yoWrtw48pr
 4YyFykKw4FqayvgFyDtr4qgay3G3WIk34Igrs5GwnIqrnrtw47u3W8tr93uF4DJr97Ga1f
 JFsayFn8Ar1IyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
 xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
 kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
 6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
 vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
 vjDU0xZFpf9x0JUQXo7UUUUU=
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
index da456dced88aa..5295dc2f9ee2e 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -98,23 +98,6 @@ static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int output)
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
@@ -153,6 +136,10 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 	output = vcrtc->id;
 	dc = vcrtc->dc;
 
+	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
+			   VSDC_CURSOR_CONFIG_FMT_MASK,
+			   VSDC_CURSOR_CONFIG_FMT_ARGB8888);
+
 	/* Other sizes should be rejected by atomic_check */
 	switch (state->crtc_w) {
 	case 32:
@@ -225,7 +212,6 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 static const struct drm_plane_helper_funcs vs_cursor_plane_helper_funcs = {
 	.atomic_check	= vs_cursor_plane_atomic_check,
 	.atomic_update	= vs_cursor_plane_atomic_update,
-	.atomic_enable	= vs_cursor_plane_atomic_enable,
 	.atomic_disable	= vs_cursor_plane_atomic_disable,
 };
 
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 8e94491693019..fca692f4f7d5c 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -59,25 +59,6 @@ static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int output)
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
@@ -144,13 +125,18 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
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

