Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAF606A339
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635BA112819;
	Fri, 30 Oct 2026 13:32:52 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6383E10E0D2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:32:50 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-03 (Coremail) with SMTP id rQCowAAXGzl1nORq+UwHDA--.23464S5;
 Fri, 30 Oct 2026 21:32:44 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joey Lu <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH RESEND 3/3] drm/verisilicon: stop to reuse atomic_disable for
 invisible planes
Date: Fri, 30 Oct 2026 21:32:33 +0800
Message-ID: <20261030133233.197189-4-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030133233.197189-1-zhengxingda@iscas.ac.cn>
References: <20261030133233.197189-1-zhengxingda@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXGzl1nORq+UwHDA--.23464S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGryxWFykAr18uF1UGFyfZwb_yoWrXr43pr
 4ayFy8Krs5XayvqF9rJr4DKFW3C3WxK34Igrs3G390vrn8twsrW3W8tF93uF4DJr97Ga1f
 tFsFkan8Ar40kFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
 C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
 vjDU0xZFpf9x0JUHWlkUUUUU=
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

When a plane is configured to be invisible, the atomic_update
implementation currently just calls the atomic_disable function.

However these two functions behave differently when disabling planes:
atomic_update disables the plane specified in the NEW state, but
atomic_disable disables the plane specified in the OLD state, so this
shortcut may lead to NULL dereference if the old state doesn't have a
CRTC bound.

Fixes: dbf21777caa8 ("drm: verisilicon: add a driver for Verisilicon display controllers")
Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c  | 17 +++++++++++------
 drivers/gpu/drm/verisilicon/vs_primary_plane.c | 15 ++++++++++-----
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index da456dced88aa..725921ac25d48 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -98,6 +98,15 @@ static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int output)
 			VSDC_CURSOR_CONFIG_IMG_UPDATE);
 }
 
+static void vs_cursor_plane_disable(struct vs_dc *dc, unsigned int output)
+{
+	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
+			   VSDC_CURSOR_CONFIG_FMT_MASK,
+			   VSDC_CURSOR_CONFIG_FMT_OFF);
+
+	vs_cursor_plane_commit(dc, output);
+}
+
 static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
 					   struct drm_atomic_commit *atomic_state)
 {
@@ -125,11 +134,7 @@ static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
 	unsigned int output = vcrtc->id;
 	struct vs_dc *dc = vcrtc->dc;
 
-	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
-			   VSDC_CURSOR_CONFIG_FMT_MASK,
-			   VSDC_CURSOR_CONFIG_FMT_OFF);
-
-	vs_cursor_plane_commit(dc, output);
+	vs_cursor_plane_disable(dc, output);
 }
 
 static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
@@ -145,7 +150,7 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 	dma_addr_t dma_addr;
 
 	if (!state->visible) {
-		vs_cursor_plane_atomic_disable(plane, atomic_state);
+		vs_cursor_plane_disable(dc, output);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index d5563c3b825c3..594d56bf32410 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -59,6 +59,14 @@ static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int output)
 			VSDC_FB_CONFIG_EX_COMMIT);
 }
 
+static void vs_primary_plane_disable(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
+			  VSDC_FB_CONFIG_EX_FB_EN);
+
+	vs_primary_plane_commit(dc, output);
+}
+
 static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
 					   struct drm_atomic_commit *atomic_state)
 {
@@ -88,10 +96,7 @@ static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
 	unsigned int output = vcrtc->id;
 	struct vs_dc *dc = vcrtc->dc;
 
-	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
-			  VSDC_FB_CONFIG_EX_FB_EN);
-
-	vs_primary_plane_commit(dc, output);
+	vs_primary_plane_disable(dc, output);
 }
 
 static void vs_primary_plane_atomic_update(struct drm_plane *plane,
@@ -108,7 +113,7 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 	dma_addr_t dma_addr;
 
 	if (!state->visible) {
-		vs_primary_plane_atomic_disable(plane, atomic_state);
+		vs_primary_plane_disable(dc, output);
 		return;
 	}
 
-- 
2.56.0

