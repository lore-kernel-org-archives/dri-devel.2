Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E59CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9180210F211;
	Wed, 30 Sep 2026 07:35:59 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40EFA10F213
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:35:46 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowABHtD7Eu7xqdFHBCQ--.5968S4;
 Wed, 30 Sep 2026 15:35:37 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Paul Walmsley <pjw@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Dominique Belhachemi <domibel@debian.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [RFC PATCH 2/2] drm: verisilicon: support non-coherent DMA
 framebuffers
Date: Wed, 30 Sep 2026 15:35:28 +0800
Message-ID: <20260930073528.3369325-3-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930073528.3369325-1-zhengxingda@iscas.ac.cn>
References: <20260930073528.3369325-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHtD7Eu7xqdFHBCQ--.5968S4
X-Coremail-Antispam: 1UD129KBjvJXoW3XF13Jr43ArW3uw4UKF4xCrg_yoW3Xry5pF
 4DAFWUKrW5ta15G3srJr1qkayaka1fKa4Igry8GwnIv3W5tr9xZan5Ar9ruF4UJrZrKw4S
 qrsFkFn8Cr42kr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
 v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
 6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
 AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
 2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
 C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
 nUUI43ZEXa7VUbH5lUUUUUU==
X-Originating-IP: [112.94.101.54]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

From: Dominique Belhachemi <domibel@debian.org>

Wire up the standard non-coherent path matching the ingenic DRM
driver.

Tested on StarFive JH7110 (VisionFive 2 v1.3B).

Signed-off-by: Dominique Belhachemi <domibel@debian.org>
[Icenowy: add can_map_coherent check, rename vs_drm field to
 map_noncoherent, adapt for cursor planes]
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c |  9 ++++++
 drivers/gpu/drm/verisilicon/vs_drm.c          | 32 ++++++++++++++++++-
 drivers/gpu/drm/verisilicon/vs_drm.h          |  7 ++++
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  9 ++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index 725921ac25d48..7216eaa6ef355 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -13,6 +13,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -23,6 +24,7 @@
 #include "vs_crtc.h"
 #include "vs_plane.h"
 #include "vs_dc.h"
+#include "vs_drm.h"
 #include "vs_hwdb.h"
 #include "vs_cursor_plane_regs.h"
 
@@ -140,6 +142,8 @@ static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
 static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 					   struct drm_atomic_commit *atomic_state)
 {
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(atomic_state,
+									   plane);
 	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
 								       plane);
 	struct drm_framebuffer *fb = state->fb;
@@ -154,6 +158,8 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
+	drm_fb_dma_sync_non_coherent(plane->dev, old_state, state);
+
 	vcrtc = drm_crtc_to_vs_crtc(crtc);
 	output = vcrtc->id;
 	dc = vcrtc->dc;
@@ -275,5 +281,8 @@ struct drm_plane *vs_cursor_plane_init(struct drm_device *drm_dev,
 	drm_plane_helper_add(plane, &vs_cursor_plane_helper_funcs);
 	drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_COVERAGE));
 
+	if (to_vs_drm_dev(drm_dev)->map_noncoherent)
+		drm_plane_enable_fb_damage_clips(plane);
+
 	return plane;
 }
diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c b/drivers/gpu/drm/verisilicon/vs_drm.c
index fd259d53f49f1..6cde0ba7ef6a4 100644
--- a/drivers/gpu/drm/verisilicon/vs_drm.c
+++ b/drivers/gpu/drm/verisilicon/vs_drm.c
@@ -5,6 +5,7 @@
 
 #include <linux/aperture.h>
 #include <linux/dma-mapping.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -12,6 +13,7 @@
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_cache.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_dumb_buffers.h>
 #include <drm/drm_fbdev_dma.h>
@@ -49,6 +51,31 @@ static int vs_gem_dumb_create(struct drm_file *file_priv,
 
 DEFINE_DRM_GEM_FOPS(vs_drm_driver_fops);
 
+static struct drm_gem_object *vs_gem_create_object(struct drm_device *drm,
+						   size_t size)
+{
+	struct drm_gem_dma_object *obj;
+
+	obj = kzalloc_obj(*obj);
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+
+	obj->map_noncoherent = to_vs_drm_dev(drm)->map_noncoherent;
+
+	return &obj->base;
+}
+
+static struct drm_framebuffer *
+vs_gem_fb_create(struct drm_device *drm, struct drm_file *file,
+		 const struct drm_format_info *info,
+		 const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (to_vs_drm_dev(drm)->map_noncoherent)
+		return drm_gem_fb_create_with_dirty(drm, file, info, mode_cmd);
+
+	return drm_gem_fb_create(drm, file, info, mode_cmd);
+}
+
 static const struct drm_driver vs_drm_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
 	.fops			= &vs_drm_driver_fops,
@@ -58,12 +85,13 @@ static const struct drm_driver vs_drm_driver = {
 	.minor	= DRIVER_MINOR,
 
 	/* GEM Operations */
+	.gem_create_object	= vs_gem_create_object,
 	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(vs_gem_dumb_create),
 	DRM_FBDEV_DMA_DRIVER_OPS,
 };
 
 static const struct drm_mode_config_funcs vs_mode_config_funcs = {
-	.fb_create		= drm_gem_fb_create,
+	.fb_create		= vs_gem_fb_create,
 	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 };
@@ -98,6 +126,8 @@ int vs_drm_initialize(struct vs_dc *dc, struct platform_device *pdev)
 
 	drm = &vdrm->base;
 	vdrm->dc = dc;
+	vdrm->map_noncoherent = !of_dma_is_coherent(dev->of_node) &&
+				!drm_arch_can_map_coherent();
 	dc->drm_dev = vdrm;
 
 	ret = drmm_mode_config_init(drm);
diff --git a/drivers/gpu/drm/verisilicon/vs_drm.h b/drivers/gpu/drm/verisilicon/vs_drm.h
index 606338206a427..ee6a3317cc556 100644
--- a/drivers/gpu/drm/verisilicon/vs_drm.h
+++ b/drivers/gpu/drm/verisilicon/vs_drm.h
@@ -18,8 +18,15 @@ struct vs_drm_dev {
 
 	struct vs_dc *dc;
 	struct vs_crtc *crtcs[VSDC_MAX_OUTPUTS];
+
+	bool map_noncoherent;
 };
 
+static inline struct vs_drm_dev *to_vs_drm_dev(struct drm_device *drm)
+{
+	return container_of(drm, struct vs_drm_dev, base);
+}
+
 int vs_drm_initialize(struct vs_dc *dc, struct platform_device *pdev);
 void vs_drm_finalize(struct vs_dc *dc);
 void vs_drm_shutdown_handler(struct vs_dc *dc);
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 594d56bf32410..633e46638dc2b 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -8,6 +8,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -18,6 +19,7 @@
 #include "vs_crtc.h"
 #include "vs_plane.h"
 #include "vs_dc.h"
+#include "vs_drm.h"
 #include "vs_primary_plane_regs.h"
 
 static int vs_primary_plane_atomic_check(struct drm_plane *plane,
@@ -102,6 +104,8 @@ static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
 static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 					   struct drm_atomic_commit *atomic_state)
 {
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(atomic_state,
+									   plane);
 	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
 								       plane);
 	struct vs_plane_state *vs_state = to_vs_plane_state(state);
@@ -117,6 +121,8 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
+	drm_fb_dma_sync_non_coherent(plane->dev, old_state, state);
+
 	vcrtc = drm_crtc_to_vs_crtc(crtc);
 	output = vcrtc->id;
 	dc = vcrtc->dc;
@@ -184,5 +190,8 @@ struct drm_plane *vs_primary_plane_init(struct drm_device *drm_dev, struct vs_dc
 
 	drm_plane_helper_add(plane, &vs_primary_plane_helper_funcs);
 
+	if (to_vs_drm_dev(drm_dev)->map_noncoherent)
+		drm_plane_enable_fb_damage_clips(plane);
+
 	return plane;
 }
-- 
2.55.0

