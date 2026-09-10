Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950E0C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC3810F3DF;
	Thu, 10 Sep 2026 09:50:19 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A0610F3DF
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:50:17 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.66])
 by APP-05 (Coremail) with SMTP id zQCowAAHdT9PfaJqKHzSBw--.25577S3;
 Thu, 10 Sep 2026 17:50:10 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH 2/2] drm/verisilicon: remove ARGB formats from primary plane
Date: Thu, 10 Sep 2026 17:50:00 +0800
Message-ID: <20260910095000.3505878-2-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260910095000.3505878-1-zhengxingda@iscas.ac.cn>
References: <20260910095000.3505878-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHdT9PfaJqKHzSBw--.25577S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1fJFy8XrykXr43WFyrCrg_yoW8Kr15pF
 y8Ar97X345ZF10yF4kJ345JrWrAa1UGr48ur4UZ3s2qF1UKayjqFZ8JFyrArZFqry8Aa1x
 tF45Jr4rZr4UGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43Mx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDUUUUUUUU=
X-Originating-IP: [112.94.100.66]
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

As the blending of the primary plane is currently explicitly disabled
(and it's not possible on DC8000), remove the ARGB formats from the
primary plane format tables.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_hwdb.c | 32 ---------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
index 56aa450443068..ebf6f843bc885 100644
--- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
+++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
@@ -15,32 +15,16 @@ static const u32 vs_primary_formats_array_no_yuv444[] = {
 	DRM_FORMAT_XBGR4444,
 	DRM_FORMAT_RGBX4444,
 	DRM_FORMAT_BGRX4444,
-	DRM_FORMAT_ARGB4444,
-	DRM_FORMAT_ABGR4444,
-	DRM_FORMAT_RGBA4444,
-	DRM_FORMAT_BGRA4444,
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_XBGR1555,
 	DRM_FORMAT_RGBX5551,
 	DRM_FORMAT_BGRX5551,
-	DRM_FORMAT_ARGB1555,
-	DRM_FORMAT_ABGR1555,
-	DRM_FORMAT_RGBA5551,
-	DRM_FORMAT_BGRA5551,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_RGBX8888,
 	DRM_FORMAT_BGRX8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_BGRA8888,
-	DRM_FORMAT_ARGB2101010,
-	DRM_FORMAT_ABGR2101010,
-	DRM_FORMAT_RGBA1010102,
-	DRM_FORMAT_BGRA1010102,
 	/* TODO: non-RGB formats */
 };
 
@@ -49,32 +33,16 @@ static const u32 vs_primary_formats_array_with_yuv444[] = {
 	DRM_FORMAT_XBGR4444,
 	DRM_FORMAT_RGBX4444,
 	DRM_FORMAT_BGRX4444,
-	DRM_FORMAT_ARGB4444,
-	DRM_FORMAT_ABGR4444,
-	DRM_FORMAT_RGBA4444,
-	DRM_FORMAT_BGRA4444,
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_XBGR1555,
 	DRM_FORMAT_RGBX5551,
 	DRM_FORMAT_BGRX5551,
-	DRM_FORMAT_ARGB1555,
-	DRM_FORMAT_ABGR1555,
-	DRM_FORMAT_RGBA5551,
-	DRM_FORMAT_BGRA5551,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_RGBX8888,
 	DRM_FORMAT_BGRX8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_BGRA8888,
-	DRM_FORMAT_ARGB2101010,
-	DRM_FORMAT_ABGR2101010,
-	DRM_FORMAT_RGBA1010102,
-	DRM_FORMAT_BGRA1010102,
 	/* TODO: non-RGB formats */
 };
 
-- 
2.52.0

