Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6625CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134F910F192;
	Thu, 28 May 2026 13:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Vc/fRPeq";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F416C10F192
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8J
 +dUm9W37rXxgShjP2ChFk+3+g0TSrBqH/jssS5uR4=; b=Vc/fRPeqtFFv+FdT8R
 3yPCC3GKPUmoFXvYFbHkWnrzYLOSpRuEGoZZV3tRq/td2BTpk6ayTJxFsnYPTM53
 L0/6IcnNJLKyzF82Kf6Ob/gErvzvqCAZIIlgS/aRAKuZGJsC/d5xQn77L3ZVYJ3+
 PSjfvzRQQMrZyYuc7ddOWsB2I=
Received: from 163.com (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgD3v0M_QxhqpAnRFQ--.101S2;
 Thu, 28 May 2026 21:29:39 +0800 (CST)
From: w15303746062@163.com
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, sumit.semwal@linaro.org,
 christian.koenig@amd.com
Cc: jeffy.chen@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] drm/prime: fix dangling dmabuf entries after handle release
Date: Thu, 28 May 2026 21:29:32 +0800
Message-Id: <20260528132932.1078483-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0e12ce28-f5b7-4ffa-849c-df9ad1796e22@amd.com>
References: <0e12ce28-f5b7-4ffa-849c-df9ad1796e22@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgD3v0M_QxhqpAnRFQ--.101S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyUWw1DCw43KFyDuFWDXFb_yoW5XFy3pr
 W3Wryqyr4vyF1Fga42y3WxXF93ua1fJFW7JFW7K39av34Yvr1fCryIyayIkrWUGr93XF4Y
 qF18JryYyF1j93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5EfOUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5AOBZWoYQ0MN5gAA3a
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

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

When a GEM handle already exists in the drm_prime_file_private, repeated
calls to DRM_IOCTL_PRIME_HANDLE_TO_FD can cause drm_prime_add_buf_handle()
to insert multiple entries with the same handle into the handles rb_tree.
Because the insertion walk moves left on equality, duplicate keys are
structurally accepted by the tree.

Later, when the handle is released via drm_gem_release() ->
drm_gem_object_release_handle() -> drm_prime_remove_buf_handle(), the
latter iterates the handles tree, removes the first matching node, and
breaks out of the loop. Any remaining duplicate nodes that share the
same handle are left orphaned in the dmabufs tree - they are no longer
reachable through the handles tree and are never freed.

When the drm file is finally closed, drm_prime_destroy_file_private()
triggers:

	WARN_ON(!RB_EMPTY_ROOT(&prime_fpriv->dmabufs));

because the dmabufs tree is still non-empty. With CONFIG_PANIC_ON_WARN
this becomes a kernel panic:

	------------[ cut here ]------------
	WARNING: CPU: 0 PID: 19739 at drivers/gpu/drm/drm_prime.c:223 drm_prime_destroy_file_private+0x43/0x60
	...
	Kernel panic - not syncing: kernel: panic_on_warn set ...

Fix this by restarting the lookup from the root of the handles tree
after each successful removal, so that all duplicate nodes for the given
handle are erased. The caller (drm_gem_object_release_handle) already
holds prime_fpriv->lock, so this does not change the locking strategy.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
 - Drop the unnecessary mutex_lock addition, as the caller (drm_gem_object_release_handle) already holds the lock.
 - Rewrite the commit message to accurately reflect the root cause (duplicate handle insertions) rather than an assumed lack of synchronization.
 - Restart the rb_tree lookup from the root instead of breaking the loop to ensure all orphaned duplicate nodes are thoroughly removed.

 drivers/gpu/drm/drm_prime.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 9b44c78cd77f..dc28df1c6698 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -202,7 +202,10 @@ void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
 
 			dma_buf_put(member->dma_buf);
 			kfree(member);
-			break;
+			/* Duplicate handles may exist; restart search from root
+			 * to guarantee removal of all matching entries.
+			 */
+			rb = prime_fpriv->handles.rb_node;
 		} else if (member->handle < handle) {
 			rb = rb->rb_right;
 		} else {
-- 
2.34.1

