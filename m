Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C884CC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037F310E069;
	Thu,  3 Sep 2026 08:42:36 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A7D10E069
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:42:34 +0000 (UTC)
Received: from loongson.cn (unknown [223.64.69.112])
 by gateway (Coremail) with SMTP id _____8BxW_DvMplqGSUIAA--.23505S3;
 Thu, 03 Sep 2026 16:42:23 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.112])
 by front1 (Coremail) with SMTP id qMiowJAx2c3rMplqryEaAA--.55470S2;
 Thu, 03 Sep 2026 16:42:22 +0800 (CST)
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
Subject: [PATCH V3] drm/loongson: Create blend mode property for cursor plane
Date: Thu,  3 Sep 2026 16:42:12 +0800
Message-ID: <20260903084212.3621540-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx2c3rMplqryEaAA--.55470S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4rtFW3ZF1rWFWfXr47Awc_yoW8ur15pa
 nrCFW8KrZ8CayDJ34DA348ta1avayfGa40qryrJ39F9r1DK39rZr1UGFnIgrW8Jr47W34a
 gryxCryDCF4UKabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
 xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
 jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
 67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
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
blend mode property with DRM_MODE_BLEND_COVERAGE for cursor planes since
it is the only one implemented in the driver.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/loongson/lsdc_plane.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loongson/lsdc_plane.c
index bea42215796d..bcc0ffa17bdf 100644
--- a/drivers/gpu/drm/loongson/lsdc_plane.c
+++ b/drivers/gpu/drm/loongson/lsdc_plane.c
@@ -7,6 +7,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_print.h>
@@ -765,7 +766,7 @@ int ls7a1000_cursor_plane_init(struct drm_device *ddev,
 
 	drm_plane_helper_add(plane, &ls7a1000_cursor_plane_helper_funcs);
 
-	return 0;
+	return drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_COVERAGE));
 }
 
 int ls7a2000_cursor_plane_init(struct drm_device *ddev,
@@ -790,5 +791,5 @@ int ls7a2000_cursor_plane_init(struct drm_device *ddev,
 
 	drm_plane_helper_add(plane, &ls7a2000_cursor_plane_helper_funcs);
 
-	return 0;
+	return drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_COVERAGE));
 }
-- 
2.52.0

