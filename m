Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004FFFF60C8
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4006B10E853;
	Tue, 31 Mar 2026 06:01:59 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3259710E266
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:01:46 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.111])
 by APP-05 (Coremail) with SMTP id zQCowAA3yQw8Y8tpZpYFDA--.57367S6;
 Tue, 31 Mar 2026 14:01:39 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH drm-misc-next v4 4/4] drm: verisilicon: fill plane's vs_format
 in atomic_check
Date: Tue, 31 Mar 2026 14:01:26 +0800
Message-ID: <20260331060126.1291966-5-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331060126.1291966-1-zhengxingda@iscas.ac.cn>
References: <20260331060126.1291966-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3yQw8Y8tpZpYFDA--.57367S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XF13JF18Jr45ZFyftrW7twb_yoW7Xr17pr
 4DAFy8Kr4rAry8Gr9rJw4kt39xua1fGryIgrWkGwnavF15trW3Cw1DJrZ3CFs8JrZrGw4x
 tanaywsxAw42yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtV
 W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
 6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
 Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
 Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
 IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU
 =
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

Move the conversion from drm_format to vs_format to atomic_check, which
is before the point of no return and can properly bail out.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
Changes in v4:
- Make atomic_check early return if the plane isn't visible.
- Added Thomas's R-b.

Changes in v3:
- Move the code filling vs_format to after drm_atomic_helper_check_plane_state()
  call.
- Add drm_WARN_ON_ONCE when filling vs_format fails.
- Add code copying vs_format in vs_plane_duplicate_state (because it no
  longer memdup's the whole struct vs_plane_state).

Changes in v2:
- Add non-NULL check for drm_plane_state->fb.

 drivers/gpu/drm/verisilicon/vs_plane.c        |  7 +++-
 drivers/gpu/drm/verisilicon/vs_plane.h        |  2 ++
 .../gpu/drm/verisilicon/vs_primary_plane.c    | 36 +++++++++++++------
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/verisilicon/vs_plane.c
index 7c6b905c9e1fa..d81f7b8f4c650 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_plane.c
@@ -129,17 +129,22 @@ dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
 
 struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane)
 {
-	struct vs_plane_state *vs_state;
+	struct vs_plane_state *vs_state, *vs_state_old;
 
 	if (drm_WARN_ON(plane->dev, !plane->state))
 		return NULL;
 
+	vs_state_old = to_vs_plane_state(plane->state);
+
 	vs_state = kzalloc_obj(*vs_state, GFP_KERNEL);
 	if (!vs_state)
 		return NULL;
 
 	__drm_atomic_helper_plane_duplicate_state(plane, &vs_state->base);
 
+	memcpy(&vs_state->format, &vs_state_old->format,
+	       sizeof(struct vs_format));
+
 	return &vs_state->base;
 }
 
diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h b/drivers/gpu/drm/verisilicon/vs_plane.h
index 48ed8fc754d18..f18c36ef4cd90 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.h
+++ b/drivers/gpu/drm/verisilicon/vs_plane.h
@@ -65,6 +65,8 @@ struct vs_format {
 
 struct vs_plane_state {
 	struct drm_plane_state base;
+
+	struct vs_format format;
 };
 
 static inline struct vs_plane_state *to_vs_plane_state(struct drm_plane_state *state)
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 421d6f9dc547b..3576dd524f5c4 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -25,17 +25,32 @@ static int vs_primary_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
+	struct vs_plane_state *new_vs_plane_state = to_vs_plane_state(new_plane_state);
+	struct drm_framebuffer *fb = new_plane_state->fb;
 	struct drm_crtc *crtc = new_plane_state->crtc;
 	struct drm_crtc_state *crtc_state = NULL;
+	int ret;
 
 	if (crtc)
 		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
-	return drm_atomic_helper_check_plane_state(new_plane_state,
-						   crtc_state,
-						   DRM_PLANE_NO_SCALING,
-						   DRM_PLANE_NO_SCALING,
-						   false, true);
+	ret = drm_atomic_helper_check_plane_state(new_plane_state,
+						  crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, true);
+	if (ret)
+		return ret;
+
+	if (!new_plane_state->visible)
+		return 0;
+
+	ret = drm_format_to_vs_format(fb->format->format,
+				      &new_vs_plane_state->format);
+	if (drm_WARN_ON_ONCE(plane->dev, ret))
+		return ret;
+
+	return 0;
 }
 
 static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int output)
@@ -84,11 +99,11 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 {
 	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
 								       plane);
+	struct vs_plane_state *vs_state = to_vs_plane_state(state);
 	struct drm_framebuffer *fb = state->fb;
 	struct drm_crtc *crtc = state->crtc;
 	struct vs_dc *dc;
 	struct vs_crtc *vcrtc;
-	struct vs_format fmt;
 	unsigned int output;
 	dma_addr_t dma_addr;
 
@@ -101,16 +116,15 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 	output = vcrtc->id;
 	dc = vcrtc->dc;
 
-	drm_format_to_vs_format(state->fb->format->format, &fmt);
-
 	regmap_update_bits(dc->regs, VSDC_FB_CONFIG(output),
 			   VSDC_FB_CONFIG_FMT_MASK,
-			   VSDC_FB_CONFIG_FMT(fmt.color));
+			   VSDC_FB_CONFIG_FMT(vs_state->format.color));
 	regmap_update_bits(dc->regs, VSDC_FB_CONFIG(output),
 			   VSDC_FB_CONFIG_SWIZZLE_MASK,
-			   VSDC_FB_CONFIG_SWIZZLE(fmt.swizzle));
+			   VSDC_FB_CONFIG_SWIZZLE(vs_state->format.swizzle));
 	regmap_assign_bits(dc->regs, VSDC_FB_CONFIG(output),
-			   VSDC_FB_CONFIG_UV_SWIZZLE_EN, fmt.uv_swizzle);
+			   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
+			   vs_state->format.uv_swizzle);
 
 	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
 
-- 
2.52.0

