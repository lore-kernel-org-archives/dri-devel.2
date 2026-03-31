Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ADBFF60C6
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B7310E266;
	Tue, 31 Mar 2026 06:01:58 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7F510E859
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:01:44 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.111])
 by APP-05 (Coremail) with SMTP id zQCowAA3yQw8Y8tpZpYFDA--.57367S3;
 Tue, 31 Mar 2026 14:01:36 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH drm-misc-next v4 1/4] drm: verisilicon: make vs_format
 conversion function return int
Date: Tue, 31 Mar 2026 14:01:23 +0800
Message-ID: <20260331060126.1291966-2-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331060126.1291966-1-zhengxingda@iscas.ac.cn>
References: <20260331060126.1291966-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3yQw8Y8tpZpYFDA--.57367S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1Utr47XFWrZr45uw47twb_yoW8tFW8pF
 47CrZFqFs5tw4aqF9rJayUK343Can5Ja4xWrWkGw1Y9r15KFyUAr15GrWFkr98Gr47Gw1I
 yFsayr1DZry2kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43Mx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbn2-7UUUUU==
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

This is for further proper invalid drm_format handling before committing
the plane state change.

The return value is not yet checked yet, and will be checked in
atomic_check in the future.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
Changes in v4:
- Reposition the R-b tag (in v3 it's wrongly placed before SoB).
Changes in v3:
- Add Thomas's R-b.
Changes in v2:
- Move a bogus #include clause to the next patch.

 drivers/gpu/drm/verisilicon/vs_plane.c | 6 ++++--
 drivers/gpu/drm/verisilicon/vs_plane.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/verisilicon/vs_plane.c
index 2f3953e588a34..fa88ed14e41d7 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_plane.c
@@ -12,7 +12,7 @@
 
 #include "vs_plane.h"
 
-void drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format)
+int drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format)
 {
 	switch (drm_format) {
 	case DRM_FORMAT_XRGB4444:
@@ -62,7 +62,7 @@ void drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format)
 		vs_format->color = VSDC_COLOR_FORMAT_A2R10G10B10;
 		break;
 	default:
-		pr_warn("Unexpected drm format!\n");
+		return -EINVAL;
 	}
 
 	switch (drm_format) {
@@ -101,6 +101,8 @@ void drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format)
 
 	/* N/A for non-YUV formats */
 	vs_format->uv_swizzle = false;
+
+	return 0;
 }
 
 dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h b/drivers/gpu/drm/verisilicon/vs_plane.h
index 41875ea3d66a5..a88cc19f2202e 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.h
+++ b/drivers/gpu/drm/verisilicon/vs_plane.h
@@ -63,7 +63,7 @@ struct vs_format {
 	bool uv_swizzle;
 };
 
-void drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format);
+int drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format);
 dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
 			      const struct drm_rect *src_rect);
 
-- 
2.52.0

