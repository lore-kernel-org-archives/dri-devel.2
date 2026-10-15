Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5772CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292F310FA73;
	Thu, 15 Oct 2026 16:15:10 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2972B1121E5
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:36:42 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-93e635220b4so496684985a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792053401; x=1792658201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2STKe93BsxxSjKyZn2b4YvS4oxKmV5oT37N/2nRdsNg=;
 b=DMX6rg4K7vh+1YV7eswZT7WnNyKoDx8hTw/0UhcrYpRNpNeYHtnNw0hu4R0coAd3+/
 Ju38ICSUVB8sEPgBv6g5R6Gee2uWs8tUaulf9mrSYt8xjceYKfIX9GDMsehNiO3TWwx8
 U0RBxWNT8MaOrs00SIpBNLd8gFScZNgj+hk7Hy49MhfATI/zFuD0HhWIz9Q71BDfRDhq
 iK4cNwNwHagX1Bxekt4b87FuASFbCbx0kFVRqI6eAfFljZDYuohR19SvQ+IENGH1WJ8U
 +lr6C9gGOt4Z1bA0HJwgIcXg9SyzNsprCWFeHsITZQmYnbkgEBsRdVFhePCELjToeL80
 ilng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053401; x=1792658201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2STKe93BsxxSjKyZn2b4YvS4oxKmV5oT37N/2nRdsNg=;
 b=ejJsN8rEkY8Y+JfgQPQJYLYN399u2YEsMvELKkntm9IEsjBOCAn+teLQr2IN/I//6E
 liKoKjihN22cL11vV5zrWbFgXIzjMeAFirN6vvzP+30x7bwzheJRTllGXQAQ2Eb3oFw2
 SaQQc27pr4IkMJwLx8C8LwrXlcxuLQXEf8crmFZ+HTxaahUz6AiaVA3gILNZahWDduv1
 95xJh55KjqJRG1QmvAkwnMQcttgmZew3NfHY62NQ5hvU5pSqtYgw5QkPXExYL4yyVZVH
 HFMKA78147egE5jVlkX3j+YGxOm+Q7/docdY2+jR6Wfjf0++m0izXSYoytKmJgVo+dVT
 NzwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2aINNG1T7EsRTME94w2plZ0dlZxwjn7WwaW8A6AiRvifOZJnU+pfCMPzAJbxUIVgH7IUiEpLHXpM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI43WXagYrILdybt/Mr9nB58iIHlBFtqcefQ7kKOAyzkvRzk5xW
 +XqEP8r4y7BqZsoOfaXm4KF7NlJwH8XG2BZduEXBlMoRzHGM2ml3akcg
X-Gm-Gg: AYBFou1F6UlePamaXtBIdfI5VVOCwLvA5mabez6ynYAb5WB7d8tlMfmGnaIwljrpNXS
 RdF1Sd5wyZhPLBbjah7AJ6JtNNgeAJi38Kh0JoW0mneIHQhgQvdMXu1Ze14nT+zLfQT9OBrg1o1
 ocf75OpMxHwmQ2FpPchds7TIJ/6rU4YJozKTtrOfAzPT4caMez1G02lXALt6DtyLcbwOVfMaZ2T
 b+Dn0yZWa6byMAhnnnYEVcjrxYUzhtW5I8KLK+zbNikoKIsdseZ/CVXRtHtBQr7If958yhqCWTF
 UhJd9UfImBsjMokoAG3sJ9kxQ03et7fu4nFvRhalkmpYPZWophWpN0BJ1M/pO+tczELRiyzbzw3
 5EZaoUgR6PuPCIUlaapOW/6dDScin8PUQaYLGniP/sH6cH+8XIrlK+A/Mn4AzHvmyNJ8R48nqjO
 ZZYDYlH1edRFoYObW+yQOB/6tVsxgwFMIhoUtLZYQ5zfV/eLv51VeEDDohPE1BzurdzbRfL7QEr
 /LTuvlAi0GhlmXbSiBUZ4vI8p5TfehbLs0tv5QVdRLei9WPQ0Z7MJrnKLPVqhGNV8arJ53jDKGp
 ZVO12uT6ly9pygF8E4pkgG4A
X-Received: by 2002:a05:620a:462b:b0:93d:cbe6:c236 with SMTP id
 af79cd13be357-93ebd4a97edmr3010062885a.66.1792053400997; 
 Thu, 15 Oct 2026 01:36:40 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal
 (ec2-44-200-54-59.compute-1.amazonaws.com. [44.200.54.59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5090050sm711843985a.40.2026.10.15.01.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:36:40 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Deep Shah <deepshah146@gmail.com>, stable@vger.kernel.org
Subject: [PATCH rdma-rc 2/2] RDMA/uverbs: Fix DMABUF use-after-free during
 ufile cleanup
Date: Thu, 15 Oct 2026 08:36:37 +0000
Message-ID: <20261015083637.200958-3-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015083637.200958-1-deepshah146@gmail.com>
References: <20261015083637.200958-1-deepshah146@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

The DMABUF release can race with ufile cleanup. When the cleanup holds
hw_destroy_rwsem for write, uverbs_uobject_release() fails its trylock
and leaves the uobject on the ufile list, but the dma_buf is freed as
soon as the release returns. The cleanup then destroys the uobject and
uses the freed dma_buf:

  BUG: KASAN: slab-use-after-free in uverbs_dmabuf_fd_destroy_uobj+0x46/0x200
  Read of size 8 at addr ff11000109cf14b0 by task repro/435
  Call Trace:
   uverbs_dmabuf_fd_destroy_uobj+0x46/0x200
   destroy_hw_fd_uobject+0x3f/0x50
   uverbs_destroy_uobject+0xc5/0x380
   __uverbs_cleanup_ufile+0x1a8/0x260
   uverbs_destroy_ufile_hw+0x54/0x160
   ib_uverbs_close+0x34/0x110
  Allocated by task 435:
   dma_buf_export+0x1b5/0x530
   ib_uverbs_handler_UVERBS_METHOD_DMABUF_ALLOC+0x223/0x3f0
  Freed by task 436:
   kfree+0x301/0x530
   dentry_kill+0x14c/0x560
   __fput+0x23a/0x4a0

rdma_user_mmap_entry_remove() dereferences the same pointer.

Protect the stored dma_buf pointer with a mutex and clear it before
release returns. Use a shared revoke helper so uobject destruction and
mmap entry removal both skip a cleared pointer. Hold a temporary uobject
reference across uverbs_uobject_release() and the pointer update.

Use a separate mutex because uobject destruction can free the mmap entry
before release finishes. Map and unmap use attachment->dmabuf directly,
so they do not need to take the new mutex while holding the reservation
lock.

Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Deep Shah <deepshah146@gmail.com>
---
 drivers/infiniband/core/ib_core_uverbs.c      | 10 +----
 drivers/infiniband/core/uverbs.h              | 37 ++++++++++++++++++
 .../infiniband/core/uverbs_std_types_dmabuf.c | 39 +++++++++++--------
 3 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index 41c84ffe8c09..2bdb6972fe1a 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -244,16 +244,8 @@ void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry)
 	entry->driver_removed = true;
 	xa_unlock(&entry->ucontext->mmap_xa);
 	list_for_each_entry_safe(uverbs_dmabuf, tmp, &entry->dmabufs, dmabufs_elm) {
-		dma_resv_lock(uverbs_dmabuf->dmabuf->resv, NULL);
 		list_del(&uverbs_dmabuf->dmabufs_elm);
-		uverbs_dmabuf->revoked = true;
-		dma_buf_invalidate_mappings(uverbs_dmabuf->dmabuf);
-		dma_resv_wait_timeout(uverbs_dmabuf->dmabuf->resv,
-				      DMA_RESV_USAGE_BOOKKEEP, false,
-				      MAX_SCHEDULE_TIMEOUT);
-		dma_resv_unlock(uverbs_dmabuf->dmabuf->resv);
-		kref_put(&uverbs_dmabuf->kref, ib_uverbs_dmabuf_done);
-		wait_for_completion(&uverbs_dmabuf->comp);
+		ib_uverbs_dmabuf_revoke(uverbs_dmabuf);
 	}
 	mutex_unlock(&entry->dmabufs_lock);
 
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index c64dd6b94e10..728e09b41992 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -42,6 +42,8 @@
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/cdev.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_umem.h>
@@ -135,6 +137,13 @@ struct ib_uverbs_completion_event_file {
 
 struct ib_uverbs_dmabuf_file {
 	struct ib_uobject uobj;
+	/*
+	 * Serializes users of dmabuf with the dma_buf's release, which sets it
+	 * to NULL. The uobject can outlive the dma_buf while it waits to be
+	 * destroyed. The map and unmap callbacks use attachment->dmabuf
+	 * instead of taking this lock.
+	 */
+	struct mutex dmabuf_release_lock;
 	struct dma_buf *dmabuf;
 	struct list_head dmabufs_elm;
 	struct rdma_user_mmap_entry *mmap_entry;
@@ -359,6 +368,34 @@ static inline void ib_uverbs_dmabuf_done(struct kref *kref)
 	complete(&priv->comp);
 }
 
+/*
+ * Revoke the dmabuf and wait for all of its DMA mappings to be gone. Must be
+ * called with the mmap entry's dmabufs_lock held, after the dmabuf has been
+ * removed from the entry's dmabufs list, so it runs once per dmabuf. Lock
+ * order is dmabufs_lock, dmabuf_release_lock, then the dma_resv lock.
+ */
+static inline void ib_uverbs_dmabuf_revoke(struct ib_uverbs_dmabuf_file *priv)
+{
+	mutex_lock(&priv->dmabuf_release_lock);
+	if (priv->dmabuf) {
+		dma_resv_lock(priv->dmabuf->resv, NULL);
+		priv->revoked = true;
+		dma_buf_invalidate_mappings(priv->dmabuf);
+		dma_resv_wait_timeout(priv->dmabuf->resv,
+				      DMA_RESV_USAGE_BOOKKEEP, false,
+				      MAX_SCHEDULE_TIMEOUT);
+		dma_resv_unlock(priv->dmabuf->resv);
+	} else {
+		/* A released dma_buf has no attachments left to invalidate */
+		priv->revoked = true;
+	}
+	mutex_unlock(&priv->dmabuf_release_lock);
+
+	kref_put(&priv->kref, ib_uverbs_dmabuf_done);
+	/* Wait till all DMA unmaps are completed */
+	wait_for_completion(&priv->comp);
+}
+
 int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 			   enum rdma_remove_reason reason);
 
diff --git a/drivers/infiniband/core/uverbs_std_types_dmabuf.c b/drivers/infiniband/core/uverbs_std_types_dmabuf.c
index d88d30f1e42f..8d8c997a4883 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmabuf.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmabuf.c
@@ -28,7 +28,7 @@ uverbs_dmabuf_map(struct dma_buf_attachment *attachment,
 	struct ib_uverbs_dmabuf_file *priv = attachment->dmabuf->priv;
 	struct sg_table *ret;
 
-	dma_resv_assert_held(priv->dmabuf->resv);
+	dma_resv_assert_held(attachment->dmabuf->resv);
 
 	if (priv->revoked)
 		return ERR_PTR(-ENODEV);
@@ -49,7 +49,7 @@ static void uverbs_dmabuf_unmap(struct dma_buf_attachment *attachment,
 {
 	struct ib_uverbs_dmabuf_file *priv = attachment->dmabuf->priv;
 
-	dma_resv_assert_held(priv->dmabuf->resv);
+	dma_resv_assert_held(attachment->dmabuf->resv);
 	dma_buf_free_sgt(attachment, sgt, dir);
 	kref_put(&priv->kref, ib_uverbs_dmabuf_done);
 }
@@ -74,7 +74,25 @@ static void uverbs_dmabuf_release(struct dma_buf *dmabuf)
 	if (!priv)
 		return;
 
+	/*
+	 * uverbs_uobject_release() may drop the last reference to the uobject,
+	 * keep it around until the dmabuf pointer below has been cleared.
+	 */
+	uverbs_uobject_get(&priv->uobj);
 	uverbs_uobject_release(&priv->uobj);
+
+	/*
+	 * The dma_buf is freed once this function returns. If the uobject was
+	 * not destroyed above, because the ufile is concurrently being cleaned
+	 * up, it is still reachable through the ufile's uobjects list and the
+	 * mmap entry's dmabufs list. Make sure those paths are not in the
+	 * middle of using the dma_buf and cannot use it afterwards.
+	 */
+	mutex_lock(&priv->dmabuf_release_lock);
+	priv->dmabuf = NULL;
+	mutex_unlock(&priv->dmabuf_release_lock);
+
+	uverbs_uobject_put(&priv->uobj);
 }
 
 static const struct dma_buf_ops uverbs_dmabuf_ops = {
@@ -100,6 +118,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMABUF_ALLOC)(
 	off_t pg_off;
 	int ret;
 
+	mutex_init(&uverbs_dmabuf->dmabuf_release_lock);
+
 	ret = uverbs_get_const(&pg_off, attrs, UVERBS_ATTR_ALLOC_DMABUF_PGOFF);
 	if (ret)
 		return ret;
@@ -165,24 +185,11 @@ static void uverbs_dmabuf_fd_destroy_uobj(struct ib_uobject *uobj,
 {
 	struct ib_uverbs_dmabuf_file *uverbs_dmabuf =
 		container_of(uobj, struct ib_uverbs_dmabuf_file, uobj);
-	bool wait_for_comp = false;
 
 	mutex_lock(&uverbs_dmabuf->mmap_entry->dmabufs_lock);
-	dma_resv_lock(uverbs_dmabuf->dmabuf->resv, NULL);
 	if (!uverbs_dmabuf->revoked) {
-		uverbs_dmabuf->revoked = true;
 		list_del(&uverbs_dmabuf->dmabufs_elm);
-		dma_buf_invalidate_mappings(uverbs_dmabuf->dmabuf);
-		dma_resv_wait_timeout(uverbs_dmabuf->dmabuf->resv,
-				      DMA_RESV_USAGE_BOOKKEEP, false,
-				      MAX_SCHEDULE_TIMEOUT);
-		wait_for_comp = true;
-	}
-	dma_resv_unlock(uverbs_dmabuf->dmabuf->resv);
-	if (wait_for_comp) {
-		kref_put(&uverbs_dmabuf->kref, ib_uverbs_dmabuf_done);
-		/* Let's wait till all DMA unmap are completed. */
-		wait_for_completion(&uverbs_dmabuf->comp);
+		ib_uverbs_dmabuf_revoke(uverbs_dmabuf);
 	}
 	mutex_unlock(&uverbs_dmabuf->mmap_entry->dmabufs_lock);
 
