Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801D0CD4F54
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 02:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E104E10E087;
	Mon, 25 May 2026 02:55:05 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271EE10E087
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:55:03 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowACntMsDuhNqBVI_Eg--.824S2;
 Mon, 25 May 2026 10:54:59 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] gpu/drm/drm_syncobj: fix fence and syncobj refcount leak in
 drm_syncobj_import_sync_file_fence()
Date: Mon, 25 May 2026 02:54:55 +0000
Message-Id: <20260525025455.3887523-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACntMsDuhNqBVI_Eg--.824S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKF4UuF47Kr4kuw4Utw47Jwb_yoW8Jry8pF
 sxGryqkrykta1FvrWfCFWqvFyfGa12qFWFgr17Cw13A3Z5tr1DJw45G392ga4DA3s7Aryf
 tr92kF4YvFn8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8hL5
 UUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYSA2oTok5z+AAAsF
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

In drm_syncobj_import_sync_file_fence(), when point is non-zero and
dma_fence_chain_alloc() fails, the function returns -ENOMEM without
releasing the fence reference (obtained via sync_file_get_fence)
and the syncobj reference (obtained via drm_syncobj_find).

Add dma_fence_put() and drm_syncobj_put() calls on the error path
to properly release both references.

Cc: stable@vger.kernel.org
Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_syncobj.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 0e986daa8ff9..34c87698e316 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -745,8 +745,11 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 	if (point) {
 		struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
-		if (!chain)
+		if (!chain) {
+			dma_fence_put(fence);
+			drm_syncobj_put(syncobj);
 			return -ENOMEM;
+		}
 
 		drm_syncobj_add_point(syncobj, chain, fence, point);
 	} else {
-- 
2.34.1

