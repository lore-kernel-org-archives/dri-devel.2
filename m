Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046E410FDF0;
	Wed, 18 Nov 2026 15:35:28 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8181210FDF6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:35:09 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.23])
 by APP-05 (Coremail) with SMTP id zQCowAB31bqdxf1qc3xpAQ--.6681S7;
 Wed, 18 Nov 2026 23:35:03 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joey Lu <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>
Cc: David Airlie <airlied@gmail.com>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH v3 5/5] drm/verisilicon: nuke planes' atomic_disable hooks
Date: Wed, 18 Nov 2026 23:34:48 +0800
Message-ID: <20261118153448.375639-6-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118153448.375639-1-zhengxingda@iscas.ac.cn>
References: <20261118153448.375639-1-zhengxingda@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAB31bqdxf1qc3xpAQ--.6681S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kGr45GFyxur1Utr4UXFb_yoW5Kw18pw
 45AFyDKr4Fqayqqa4DJr4qyay3ua1Fk34Igrs5GwnIqr13Kr47u3W8tF97uF4UJry8Gw4f
 JF12kr1DCr10yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
 IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x0JUQFxUUUUUU=
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

As the plane disable routine is called in atomic_update hooks and the
atomic_enable hooks doesn't exit any longer, having atomic_disable hooks
seems to be meaningless and misleading.

Nuke the hooks and leave the disabling routines as subroutines of
atomic_update hooks.

Fixes: dbf21777caa8 ("drm: verisilicon: add a driver for Verisilicon display controllers")
Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c  | 7 +++----
 drivers/gpu/drm/verisilicon/vs_primary_plane.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index a58e4a47cf286..8bb26b9e23f6b 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -99,8 +99,8 @@ static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int output)
 			VSDC_CURSOR_CONFIG_IMG_UPDATE);
 }
 
-static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
-					    struct drm_atomic_commit *atomic_state)
+static void vs_cursor_plane_disable(struct drm_plane *plane,
+				    struct drm_atomic_commit *atomic_state)
 {
 	struct drm_plane_state *state = drm_atomic_get_old_plane_state(atomic_state,
 								       plane);
@@ -136,7 +136,7 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 	dma_addr_t dma_addr;
 
 	if (!state->visible) {
-		vs_cursor_plane_atomic_disable(plane, atomic_state);
+		vs_cursor_plane_disable(plane, atomic_state);
 		return;
 	}
 
@@ -221,7 +221,6 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 static const struct drm_plane_helper_funcs vs_cursor_plane_helper_funcs = {
 	.atomic_check	= vs_cursor_plane_atomic_check,
 	.atomic_update	= vs_cursor_plane_atomic_update,
-	.atomic_disable	= vs_cursor_plane_atomic_disable,
 };
 
 static const struct drm_plane_funcs vs_cursor_plane_funcs = {
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 730dab6204e98..397e95bd6de3f 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -60,8 +60,8 @@ static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int output)
 			VSDC_FB_CONFIG_EX_COMMIT);
 }
 
-static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
-					    struct drm_atomic_commit *atomic_state)
+static void vs_primary_plane_disable(struct drm_plane *plane,
+				     struct drm_atomic_commit *atomic_state)
 {
 	struct drm_plane_state *state = drm_atomic_get_old_plane_state(atomic_state,
 								       plane);
@@ -97,7 +97,7 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 	dma_addr_t dma_addr;
 
 	if (!state->visible) {
-		vs_primary_plane_atomic_disable(plane, atomic_state);
+		vs_primary_plane_disable(plane, atomic_state);
 		return;
 	}
 
@@ -149,7 +149,6 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 static const struct drm_plane_helper_funcs vs_primary_plane_helper_funcs = {
 	.atomic_check	= vs_primary_plane_atomic_check,
 	.atomic_update	= vs_primary_plane_atomic_update,
-	.atomic_disable	= vs_primary_plane_atomic_disable,
 };
 
 static const struct drm_plane_funcs vs_primary_plane_funcs = {
-- 
2.56.0

