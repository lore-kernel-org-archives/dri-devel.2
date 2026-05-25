Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5905CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 15:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0923C10E18E;
	Mon, 25 May 2026 15:36:30 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAC610E3AF
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 15:36:28 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.115])
 by APP-03 (Coremail) with SMTP id rQCowAAHKeB0bBRqlfhTEg--.434S2;
 Mon, 25 May 2026 23:36:21 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH drm-misc-next] drm: verisilicon: fix build failure of cursor
 plane code
Date: Mon, 25 May 2026 23:36:18 +0800
Message-ID: <20260525153618.1336239-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAHKeB0bBRqlfhTEg--.434S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xWry8Zw18Gr4fGw1kGrg_yoW8tw4xpw
 4DAF98Krs0q3WkGasrJrs2y3y3ua1Fk34IqrZ5GwsaqF13Kr13u3WkJr9rur45JrykW34f
 JF42yr1DGF4IyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
 C2KfnxnUUI43ZEXa7VUb_Ma5UUUUU==
X-Originating-IP: [112.94.100.115]
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

The cursor plane patch was stalled for a too long time that the
struct drm_atomic_state parameter of atomic modeset hooks has been
changed to struct drm_atomic_commit.

Fix this by replacing the parameter's type. All helpers that retrieve
information from this struct are also changed so simply replacing the
type works.

Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index acb9854fa67ed..fa4f601dd0c87 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -40,7 +40,7 @@ static bool vs_cursor_plane_check_coord(int32_t coord)
 }
 
 static int vs_cursor_plane_atomic_check(struct drm_plane *plane,
-					struct drm_atomic_state *state)
+					struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
@@ -98,7 +98,7 @@ static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int output)
 }
 
 static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
-					   struct drm_atomic_state *atomic_state)
+					   struct drm_atomic_commit *atomic_state)
 {
 	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
 								       plane);
@@ -115,7 +115,7 @@ static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
 }
 
 static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
-					    struct drm_atomic_state *atomic_state)
+					    struct drm_atomic_commit *atomic_state)
 {
 	struct drm_plane_state *state = drm_atomic_get_old_plane_state(atomic_state,
 								       plane);
@@ -132,7 +132,7 @@ static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
 }
 
 static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
-					   struct drm_atomic_state *atomic_state)
+					   struct drm_atomic_commit *atomic_state)
 {
 	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
 								       plane);
-- 
2.52.0

