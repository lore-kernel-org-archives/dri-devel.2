Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B45CCD4F54
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 02:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3826810E11E;
	Mon, 25 May 2026 02:33:39 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BC610E11E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:33:37 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAAnC+L4tBNqaq8+Eg--.682S2;
 Mon, 25 May 2026 10:33:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] gpu/drm/drm_syncobj: fix syncobj refcount leak on invalid
 flags in find_fence
Date: Mon, 25 May 2026 02:33:24 +0000
Message-Id: <20260525023324.3883862-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAnC+L4tBNqaq8+Eg--.682S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWkGryftr4xuFWUXw4ruFg_yoW8Gry3pr
 s3Kryq9ryrtw4Ivr4IyF9rCFWfAa1xtrW0gF1kAw1YvF1ktr15A3y5G3s0gFyDJrn7Cr1a
 q34qyFW5uFnFkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOlkVUU
 UUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4SA2oTE7fg9gABsc
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

drm_syncobj_find_fence() calls drm_syncobj_find() to obtain a
reference on syncobj, then checks the flags validity. If the flags
are invalid, it returns -EINVAL without releasing the syncobj
reference obtained earlier.

Fix this by using goto to release the reference on error paths.

Cc: stable@vger.kernel.org
Fixes: 18226ba52159 ("drm/syncobj: reject invalid flags in drm_syncobj_find_fence")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_syncobj.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 8d9fd1917c6e..0e986daa8ff9 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -442,11 +442,15 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 	u64 timeout = nsecs_to_jiffies64(DRM_SYNCOBJ_WAIT_FOR_SUBMIT_TIMEOUT);
 	int ret;
 
-	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
-		return -EINVAL;
+	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (!syncobj)
-		return -ENOENT;
+	if (!syncobj) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	/* Waiting for userspace with locks help is illegal cause that can
 	 * trivial deadlock with page faults for example. Make lockdep complain
-- 
2.34.1

