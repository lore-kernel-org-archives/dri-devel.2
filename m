Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1866DC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FBF210F1CD;
	Wed,  2 Sep 2026 13:22:14 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3D41310F1CD
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:22:11 +0000 (UTC)
Received: from loongson.cn (unknown [223.64.69.112])
 by gateway (Coremail) with SMTP id _____8AxYdEAI5hq+8QHAA--.22323S3;
 Wed, 02 Sep 2026 21:22:08 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.112])
 by front1 (Coremail) with SMTP id qMiowJDxTs_4IphqFaYZAA--.54353S2;
 Wed, 02 Sep 2026 21:22:06 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Huacai Chen <chenhuacai@kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>,
 Qianhai Wu <wuqianhai@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] drm/loongson: Create blend mode property for cursor plane
Date: Wed,  2 Sep 2026 21:21:52 +0800
Message-ID: <20260902132152.3170934-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs_4IphqFaYZAA--.54353S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxur43Xw47GFyxKryUCryxtFc_yoW5Wr1kpF
 4DCFy8KrZ0kF4Dtry7Aw1vka13Xa1fGFyIqrWfJ39F9w1DtFW7AF1rKr9I9rW8JF4UG343
 Xr1xAr1DGF48KabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
 xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
 jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
 67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU
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

After commit 860e748bddcc929 ("drm: ensure blend mode supported if pixel
format with alpha exposed") we get warnings at boot:

loongson 0000:00:06.1: [drm] [PLANE:41:ls-cursor-plane-0] pixel format with alpha exposed but blend mode not setup. Please fix.
loongson 0000:00:06.1: [drm] [PLANE:46:ls-cursor-plane-1] pixel format with alpha exposed but blend mode not setup. Please fix.

The reason is the cursor plane supports color formats with alpha but the
driver doesn't create blend mode property, which triggers the warning in
validate_blend_mode_for_alpha_formats().

The loongson DC HW doesn't support DRM_MODE_BLEND_PREMULTI, so create
a blend mode with "DRM_MODE_BLEND_PIXEL_NONE | DRM_MODE_BLEND_COVERAGE"
for cursor planes.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/loongson/lsdc_plane.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loongson/lsdc_plane.c
index bea42215796d..969b2aaa4fd0 100644
--- a/drivers/gpu/drm/loongson/lsdc_plane.c
+++ b/drivers/gpu/drm/loongson/lsdc_plane.c
@@ -7,6 +7,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_print.h>
@@ -747,8 +748,9 @@ int ls7a1000_cursor_plane_init(struct drm_device *ddev,
 			       struct drm_plane *plane,
 			       unsigned int index)
 {
-	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
 	int ret;
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) | BIT(DRM_MODE_BLEND_COVERAGE);
+	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
 
 	ret = drm_universal_plane_init(ddev, plane, 1 << index,
 				       &lsdc_plane_funcs,
@@ -765,15 +767,16 @@ int ls7a1000_cursor_plane_init(struct drm_device *ddev,
 
 	drm_plane_helper_add(plane, &ls7a1000_cursor_plane_helper_funcs);
 
-	return 0;
+	return drm_plane_create_blend_mode_property(plane, blend_caps);
 }
 
 int ls7a2000_cursor_plane_init(struct drm_device *ddev,
 			       struct drm_plane *plane,
 			       unsigned int index)
 {
-	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
 	int ret;
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) | BIT(DRM_MODE_BLEND_COVERAGE);
+	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
 
 	ret = drm_universal_plane_init(ddev, plane, 1 << index,
 				       &lsdc_plane_funcs,
@@ -790,5 +793,5 @@ int ls7a2000_cursor_plane_init(struct drm_device *ddev,
 
 	drm_plane_helper_add(plane, &ls7a2000_cursor_plane_helper_funcs);
 
-	return 0;
+	return drm_plane_create_blend_mode_property(plane, blend_caps);
 }
-- 
2.52.0

