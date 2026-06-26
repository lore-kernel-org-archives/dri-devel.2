Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6800AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA95B10E3DC;
	Fri, 26 Jun 2026 14:59:57 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F31110E3DC
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.75.66])
 by APP-01 (Coremail) with SMTP id qwCowACHLtfjkz5qSjlrAw--.37345S2;
 Fri, 26 Jun 2026 22:59:48 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Zack Rusin <zack.rusin@broadcom.com>,
	dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Hellstrom <thellstrom@vmware.com>,
 Christian Koenig <christian.koenig@amd.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/vmwgfx: ttm_base_object_init: fix tfile reference
 leak on error paths
Date: Fri, 26 Jun 2026 22:59:46 +0800
Message-Id: <20260626145946.49620-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHLtfjkz5qSjlrAw--.37345S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWUZFy8Gw4kZrW5GFy8Xwb_yoW8Wr1kpa
 yaqry3AryrJr48KrZrAan5XFnIy3sF9rn8KFyYv3ZxZr15Za43Crs5ta1qgFWUGrs7Ar42
 qF4j9F9xZFWUZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
 sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAKA2o+idsaBAAAsd
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

ttm_base_object_init calls ttm_object_file_ref(tfile) to acquire a tfile
  reference early in the function. On error paths (idr_alloc failure and
  ttm_ref_object_add failure), the function returns without calling
  ttm_object_file_unref to release this reference, causing a tfile
  reference leak.

Add proper cleanup in the error paths to release the tfile reference via
  ttm_object_file_unref.

Cc: stable@vger.kernel.org
Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object functionality to the vmwgfx driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 2421b0dd057c..93ae5a07d70a 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -204,7 +204,7 @@ int ttm_base_object_init(struct ttm_object_file *tfile,
 	spin_unlock(&tdev->object_lock);
 	idr_preload_end();
 	if (ret < 0)
-		return ret;
+		goto err_unref_tfile;
 
 	base->handle = ret;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
@@ -218,6 +218,10 @@ int ttm_base_object_init(struct ttm_object_file *tfile,
 	spin_lock(&tdev->object_lock);
 	idr_remove(&tdev->idr, base->handle);
 	spin_unlock(&tdev->object_lock);
+	ttm_object_file_unref(&base->tfile);
+	return ret;
+err_unref_tfile:
+	ttm_object_file_unref(&base->tfile);
 	return ret;
 }
 
-- 
2.39.5 (Apple Git-154)

