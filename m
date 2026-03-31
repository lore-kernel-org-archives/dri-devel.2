Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBEAFF60CF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C5710E860;
	Tue, 31 Mar 2026 06:01:46 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A5110E266
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:01:44 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.111])
 by APP-05 (Coremail) with SMTP id zQCowAA3yQw8Y8tpZpYFDA--.57367S4;
 Tue, 31 Mar 2026 14:01:37 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH drm-misc-next v4 2/4] drm: verisilicon: subclass
 drm_plane_state
Date: Tue, 31 Mar 2026 14:01:24 +0800
Message-ID: <20260331060126.1291966-3-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331060126.1291966-1-zhengxingda@iscas.ac.cn>
References: <20260331060126.1291966-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3yQw8Y8tpZpYFDA--.57367S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fuw45KFWftw4DXr18Zrb_yoWrtw15pr
 srAFy5Kr45Aw4DG3srJw1jya9xua18KryIgrZ7GwnavF15try3uFn5tr93CF43JrW7Gw13
 tan2kr4DCr4ayrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8Zw
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
 6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
 vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUczV8UUUUU=
X-Originating-IP: [112.94.100.111]
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

Create a subclass of drm_plane_state to store hardware-specific state
information (e.g. hardware plane format settings) in the future.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
Changes in v4:
- Add code clearing plane->state pointer after freeing it.
- Add Thomas's R-b.

Changes in v3:
- Switch to drm_WARN_ON().
- Stop to memdup the state.
- Move the code freeing the existing plane state to the branch checking
  whether it's not NULL.
- Rename the typecast function to `to_vs_plane_state()`.

Changes in v2:
- Add the #include clause for atomic state helpers, which was wrongly
  placed in the previous patch in v1.
- Switch to kzalloc_obj helper for allocating the state.

 drivers/gpu/drm/verisilicon/vs_plane.c        | 43 +++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_plane.h        | 14 ++++++
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  6 +--
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/verisilicon/vs_plane.c
index fa88ed14e41d7..7c6b905c9e1fa 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_plane.c
@@ -6,9 +6,11 @@
 #include <linux/errno.h>
 #include <linux/printk.h>
 
+#include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_print.h>
 
 #include "vs_plane.h"
 
@@ -124,3 +126,44 @@ dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
 
 	return dma_addr;
 }
+
+struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct vs_plane_state *vs_state;
+
+	if (drm_WARN_ON(plane->dev, !plane->state))
+		return NULL;
+
+	vs_state = kzalloc_obj(*vs_state, GFP_KERNEL);
+	if (!vs_state)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &vs_state->base);
+
+	return &vs_state->base;
+}
+
+void vs_plane_destroy_state(struct drm_plane *plane,
+			    struct drm_plane_state *state)
+{
+	__drm_atomic_helper_plane_destroy_state(state);
+	kfree(state);
+}
+
+/* Called during init to allocate the plane's atomic state. */
+void vs_plane_reset(struct drm_plane *plane)
+{
+	struct vs_plane_state *vs_state;
+
+	if (plane->state) {
+		__drm_atomic_helper_plane_destroy_state(plane->state);
+		kfree(plane->state);
+		plane->state = NULL;
+	}
+
+	vs_state = kzalloc_obj(*vs_state, GFP_KERNEL);
+	if (!vs_state)
+		return;
+
+	__drm_atomic_helper_plane_reset(plane, &vs_state->base);
+}
diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h b/drivers/gpu/drm/verisilicon/vs_plane.h
index a88cc19f2202e..48ed8fc754d18 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.h
+++ b/drivers/gpu/drm/verisilicon/vs_plane.h
@@ -63,10 +63,24 @@ struct vs_format {
 	bool uv_swizzle;
 };
 
+struct vs_plane_state {
+	struct drm_plane_state base;
+};
+
+static inline struct vs_plane_state *to_vs_plane_state(struct drm_plane_state *state)
+{
+	return container_of(state, struct vs_plane_state, base);
+}
+
 int drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format);
 dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
 			      const struct drm_rect *src_rect);
 
+struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane);
+void vs_plane_destroy_state(struct drm_plane *plane,
+			    struct drm_plane_state *state);
+void vs_plane_reset(struct drm_plane *plane);
+
 struct drm_plane *vs_primary_plane_init(struct drm_device *dev, struct vs_dc *dc);
 
 #endif /* _VS_PLANE_H_ */
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index e8fcb5958615c..bad0bc5e3242d 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -145,10 +145,10 @@ static const struct drm_plane_helper_funcs vs_primary_plane_helper_funcs = {
 };
 
 static const struct drm_plane_funcs vs_primary_plane_funcs = {
-	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
-	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= vs_plane_destroy_state,
+	.atomic_duplicate_state	= vs_plane_duplicate_state,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.reset			= drm_atomic_helper_plane_reset,
+	.reset			= vs_plane_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
-- 
2.52.0

