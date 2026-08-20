Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81E1C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242FE10E625;
	Thu, 20 Aug 2026 22:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=me.com header.i=@me.com header.b="WBDG/9D+";
	dkim-atps=neutral
X-Greylist: delayed 1800 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 19:46:59 UTC
Received: from outbound.pv.icloud.com (pv-2004c-snip4-4.eps.apple.com
 [57.103.65.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BD610E64A
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:46:59 +0000 (UTC)
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id
 B91B4180016D; Thu, 20 Aug 2026 19:08:45 +0000 (UTC)
X-ICL-RepId: 01a02093-64b0-7cb7-8a1a-f9d3290add8b
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwZfEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAAS1oVVRcOAkIfUB9MFldDRx0cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQglJCl0PWApeC0oCWQReH0EUHlYfRQpcXl0NUh9FAnIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1787252929; x=1789844929; bh=lqSz/u1/2VCf8SvVSc3OXjbcwuPuvSa1s9IbgUued5c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WBDG/9D+YeDaGJXpR2ouZvERzO3ucRjkxQC6baBuRXdab9WXVQN33JiFaCNFoMd1pkDnGDHCjtRdrb5Diy6RGKtlquMuIlJklcZbRCznNw0BFSYkkgCj/kXEgq9fLDMrKtBwK7maQsUKTU8tpIU2ip3H4Nxx8ZpJ3dDuxl8hspBWCnKGsLLjC+zUwHoiyyO2yUSY8Q4W4rVDsRVJK/BMV7+phyqDEd/X8z1nBvZrQ+bs1Chx41pj+4jqrndter4Cla2ZCiEDA5maGKFUfqa0APpuFSBbdhPT5Z1FX9pig+Kzjc2Wyi6fXNzzuJwqvJiz6d1Uip5rNAcbXCInIPyXAw==
Received: from ncore (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id
 0C30A1800951; Thu, 20 Aug 2026 19:08:42 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Ferran Duarri <ferran.duarri@me.com>
Subject: [RFC PATCH] dma-buf: add a generic reclaim-priority hint
Date: Thu, 20 Aug 2026 21:08:36 +0200
Message-ID: <20260820190838.221435-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E55wSjGt69XavCovxxmsxk8z5FxpRgzP
X-Proofpoint-ORIG-GUID: E55wSjGt69XavCovxxmsxk8z5FxpRgzP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0NCBTYWx0ZWRfX95gN94OyBxnt
 niybDAM+p9oT1wVWEKLd0Auz6W+as29F4/fc54tRLybaNkwG6iilJl5IAW7WjCIacbCZj5zkrlL
 8YNGvykLCuW2IoR2coOVUWyB+Wi27PXGflVt5/f7RWmANwSZ3JsWT7N6a8NI32DhR9IiDWLEEXA
 FWYsqm4s/U1keJYnoOp/GitU7rkTGsaH5bcuM/z4BF5Ruz6bO7P9AxGcLW8BrBczkhyPAD2XO8m
 hRsa1ixBYAEwrReCDzq30WrEtlHhuleGn5bR8PCCWU+minoeRTe1mOPMZChGqgtPz2lIK41+XDp
 MghsIYLC8aVVwAgL22FOCL5G8SiVOX0fUXEEET4khwmwUxWDoqpEglsDK9aHSg=
X-Authority-Info-Out: v=2.4 cv=M99A6iws c=1 sm=1 tr=0 ts=6a8750bf
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=vJG9-CjCIe9QwPiVznIA:9
X-JNJ: AAAAAAABJLguLdJB61x/JMzfp1usGPOXFoGDwa1YxmZ/VwiyihdcjcJSPYry5rkNJRGRRUhwjXaAiaL9ZKz0GxDGX+IklV356b8CsC3rl69CW6IrqFYfOjfGw7ULlMsKgYYkLyWfjp2KIgwRi+DGAVOgCJ77Eyf4MjLJTxIEuec62o2XxyEHddDYZ4olBJVXyop+wV/egMiIP4qVMsKer5+Ec9DU7xDeFqbcdSxi20GjgYjlkd/7o2fPcQ6CODBY4oklhvfKbg5eC6+Rhs95pHeN6YszBdHD1FcZEVM4K+F8hLwD5YzyOiLhxqHz9SQB8+kXly/XZ+cGSUg1VtKQP9y3FZY+k9Z0DIGeTyAxEZc9bhOfSJyqHTY8iG9d+ICxDOL48Opr91ub2E5mzBZrgXJHn70PWiz2zAkNCjyeReFdfgkaDheDbJM3Hnqsit8vUbpQ4fe8QDiaxW6PQjrH77LbtMbShFjFXPkl0K1zBi6nzoOgMgZQ3lvaJ0GS2WdoTn1/bSFnxuudkchjOwLPpF9yAQxoZDm0XQGDARwlR+c9wKmCr/Emn6BgtNEOshjRCMDx7vcz83U/wDWUXAOQ6juyiFK+x5yRKm72O/jFoKGczpLOty/3YR3ubYXi7iRZkhPe+SlfvB3oTBIMEDKo70eaBgDq1/P+is7XnsMSSsjYnzc8vScNO/syt0zCY/V5ojnBtUmBA/Tu5YtvX54Hv+cUR1y/vLrZTEAPa6ZrDvSKLCeaiEK8qv0m+4OtmORUqzzxna58N1D3TzIdVd6hT4uEneVH4syl2IvzRfO8xHBrZ8gvtCtgqy1GJc37vWYnY2rIMp1R3RRrpJr5rBl1PsTiwml1fH7bAv1wiX9B8ifITTCns42QvR6aIyM2jKM4M2I7NK6/+L/WjvayQlf+YF3p2rLr5oEWk4CSgNQT4EyWLeSgyHkAOVaEuCdkovzRCXgVADCwhH9FFNVLHKiT0CbiVTVT5t3
 ZWDqb/5/kaPZ3gNiTIuPNeZ7w/g2jHDof1Z4ZHQlkvY9uxYRFfUHe8qnkSrjF1G2zEpxDhi5j36vKDZD+mQYJhQdI+0h1gfiUqGSquumqZauQd8ZfBFK3ahNBaxj06WyW+GWEeFgUyXQnAlnfMHaxJCg/j1bYuoe6iY9R1NrM+ejFVvyBV8F0jHA0HGOkQtVJBuWY4TpISV0Z3Pk5o16WYMnbRNu46CLGNbuWWFbH0EbVkW2GTJoqWoBrurGx+PirS85tXQ==
X-Mailman-Approved-At: Thu, 20 Aug 2026 22:53:16 +0000
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

dma-buf has no generic mechanism for a buffer's exporter, importer, or
a cooperating userspace agent to signal how eagerly a given buffer's
backing memory should be given up relative to other buffers when the
system is under memory pressure. Pages pinned via pin_user_pages()/
FOLL_LONGTERM sit outside the normal reclaim path by design, so any
subsystem that wants a "prefer to keep A over B under pressure" policy
for its pinned dma-buf allocations currently has to invent its own
private, driver-specific side channel to express it.

This is a real, recurring pattern: GPU drivers juggling foreground and
background clients want it, and it shows up concretely in large-model
AI/ML inference stacks that tier working sets across VRAM/system-RAM/
NVMe using their own dma-buf exporters -- e.g. an out-of-tree memory
tiering driver we've been using has its own gaming_mode sysfs flag and
a per-buffer "heat" score, moving its own DMA-BUF-backed allocations to
its own private LRU tail under a private IOCTL, purely because there is
nowhere generic to express "this buffer can go first."

Add one small, opt-in hint instead of another private channel:

  - struct dma_buf gains a `priority` field (atomic_t, plain hint, no
    new locking), defaulting to DMA_BUF_PRIORITY_DEFAULT (128) and
    ranging DMA_BUF_PRIORITY_MIN (0) to DMA_BUF_PRIORITY_MAX (255).
    Lower values should be reclaimed EARLIER under memory pressure.

  - dma_buf_set_priority()/dma_buf_get_priority(), exported under the
    DMA_BUF symbol namespace, so any dma-buf exporter (in-tree or an
    out-of-tree module) can set/read it directly.

  - DMA_BUF_IOCTL_SET_PRIORITY / DMA_BUF_IOCTL_GET_PRIORITY so
    userspace holding an fd can do the same, without needing a private
    driver ioctl.

  - The current value is reported via fdinfo (`priority:`) for
    debugging/accounting, next to the existing size/name/exp_name
    fields.

This is deliberately a hint only: dma-buf core stores and reports the
value, it implements no eviction policy of its own, and it changes no
behavior for any existing exporter or importer that doesn't opt in.
No existing dma_buf_ops callback is touched. Compile-tested: drivers/
dma-buf/ (incl. the selftest module) and drivers/gpu/drm/drm_prime.o
both build clean against this change.

Signed-off-by: Ferran Duarri <ferran.duarri@me.com>
---
 drivers/dma-buf/dma-buf.c    | 51 ++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h      | 26 ++++++++++++++++++
 include/uapi/linux/dma-buf.h | 33 +++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..1b1d3ee77f47 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -432,6 +432,39 @@ static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
 	return 0;
 }
 
+/**
+ * dma_buf_set_priority - Set the reclaim-priority hint on a dma_buf.
+ * @dmabuf:   [in] buffer to update.
+ * @priority: [in] new priority, clamped to
+ *                 [DMA_BUF_PRIORITY_MIN, DMA_BUF_PRIORITY_MAX].
+ *
+ * Lower values should be reclaimed EARLIER under memory pressure. This is
+ * a hint only , dma-buf core stores and reports it, it implements no
+ * eviction policy itself. Safe to call at any time, from any context that
+ * can call dma_buf_get()/hold a reference (no locking required beyond
+ * that reference).
+ */
+void dma_buf_set_priority(struct dma_buf *dmabuf, unsigned int priority)
+{
+	if (priority > DMA_BUF_PRIORITY_MAX)
+		priority = DMA_BUF_PRIORITY_MAX;
+	atomic_set(&dmabuf->priority, priority);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_set_priority, "DMA_BUF");
+
+/**
+ * dma_buf_get_priority - Read back the current reclaim-priority hint.
+ * @dmabuf: [in] buffer to query.
+ *
+ * Returns the value most recently set via dma_buf_set_priority() (or
+ * DMA_BUF_PRIORITY_DEFAULT if never set).
+ */
+unsigned int dma_buf_get_priority(struct dma_buf *dmabuf)
+{
+	return atomic_read(&dmabuf->priority);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_get_priority, "DMA_BUF");
+
 #if IS_ENABLED(CONFIG_SYNC_FILE)
 static long dma_buf_export_sync_file(struct dma_buf *dmabuf,
 				     void __user *user_data)
@@ -542,6 +575,7 @@ static long dma_buf_ioctl(struct file *file,
 {
 	struct dma_buf *dmabuf;
 	struct dma_buf_sync sync;
+	struct dma_buf_priority prio;
 	enum dma_data_direction direction;
 	int ret;
 
@@ -580,6 +614,21 @@ static long dma_buf_ioctl(struct file *file,
 	case DMA_BUF_SET_NAME_B:
 		return dma_buf_set_name(dmabuf, (const char __user *)arg);
 
+	case DMA_BUF_IOCTL_SET_PRIORITY:
+		if (copy_from_user(&prio, (void __user *)arg, sizeof(prio)))
+			return -EFAULT;
+		if (prio.pad || prio.priority > DMA_BUF_PRIORITY_MAX)
+			return -EINVAL;
+		dma_buf_set_priority(dmabuf, prio.priority);
+		return 0;
+
+	case DMA_BUF_IOCTL_GET_PRIORITY:
+		memset(&prio, 0, sizeof(prio));
+		prio.priority = dma_buf_get_priority(dmabuf);
+		if (copy_to_user((void __user *)arg, &prio, sizeof(prio)))
+			return -EFAULT;
+		return 0;
+
 #if IS_ENABLED(CONFIG_SYNC_FILE)
 	case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
 		return dma_buf_export_sync_file(dmabuf, (void __user *)arg);
@@ -604,6 +653,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 	if (dmabuf->name)
 		seq_printf(m, "name:\t%s\n", dmabuf->name);
 	spin_unlock(&dmabuf->name_lock);
+	seq_printf(m, "priority:\t%u\n", dma_buf_get_priority(dmabuf));
 }
 
 static const struct file_operations dma_buf_fops = {
@@ -748,6 +798,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	dmabuf->exp_name = exp_info->exp_name;
 	dmabuf->owner = exp_info->owner;
 	spin_lock_init(&dmabuf->name_lock);
+	atomic_set(&dmabuf->priority, DMA_BUF_PRIORITY_DEFAULT);
 	init_waitqueue_head(&dmabuf->poll);
 	dmabuf->cb_in.poll = dmabuf->cb_out.poll = &dmabuf->poll;
 	dmabuf->cb_in.active = dmabuf->cb_out.active = 0;
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..b3d3f2858704 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -354,6 +354,29 @@ struct dma_buf {
 	/** @name_lock: Spinlock to protect name access for read access. */
 	spinlock_t name_lock;
 
+	/**
+	 * @priority:
+	 *
+	 * Reclaim-priority hint for this buffer's backing memory, in the
+	 * range DMA_BUF_PRIORITY_MIN..DMA_BUF_PRIORITY_MAX (see
+	 * include/uapi/linux/dma-buf.h). Lower values should be reclaimed
+	 * EARLIER under memory pressure. Defaults to
+	 * DMA_BUF_PRIORITY_DEFAULT.
+	 *
+	 * This is a hint only: dma-buf core implements no eviction policy
+	 * of its own, it merely stores and reports the value so exporters
+	 * (and cooperating shrinkers) have one shared, generic place to
+	 * look instead of each inventing a private side channel. Read with
+	 * dma_buf_get_priority(), set with dma_buf_set_priority() , also
+	 * reachable from userspace via DMA_BUF_IOCTL_SET_PRIORITY /
+	 * DMA_BUF_IOCTL_GET_PRIORITY.
+	 *
+	 * Plain atomic_t rather than a lock: this is a coarse, racy-by-
+	 * design hint consulted opportunistically, not a value anything
+	 * synchronizes correctness on.
+	 */
+	atomic_t priority;
+
 	/**
 	 * @owner:
 	 *
@@ -566,6 +589,9 @@ void dma_buf_unpin(struct dma_buf_attachment *attach);
 
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
 
+void dma_buf_set_priority(struct dma_buf *dmabuf, unsigned int priority);
+unsigned int dma_buf_get_priority(struct dma_buf *dmabuf);
+
 int dma_buf_fd(struct dma_buf *dmabuf, int flags);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
index e827c9d20c5d..4a1d26e0b0a0 100644
--- a/include/uapi/linux/dma-buf.h
+++ b/include/uapi/linux/dma-buf.h
@@ -168,6 +168,37 @@ struct dma_buf_import_sync_file {
 	__s32 fd;
 };
 
+/**
+ * struct dma_buf_priority - Reclaim-priority hint for a dma-buf
+ *
+ * dma-buf has no generic mechanism for a buffer's exporter, importer, or
+ * a cooperating userspace agent to signal how eagerly this buffer's
+ * backing memory should be given up relative to other buffers when the
+ * system is under memory pressure. Every subsystem that wants this today
+ * (GPU drivers juggling foreground/background clients, memory-tiering
+ * allocators for large ML/AI working sets, ...) has to build its own
+ * private, driver-specific side channel to express it.
+ *
+ * DMA_BUF_IOCTL_SET_PRIORITY / DMA_BUF_IOCTL_GET_PRIORITY add one shared,
+ * generic hint that any dma-buf exporter MAY consult. This is a hint
+ * only: the dma-buf core stores and reports the value, it implements no
+ * eviction policy of its own and by itself changes no behavior for any
+ * existing exporter.
+ */
+struct dma_buf_priority {
+	/**
+	 * @priority: DMA_BUF_PRIORITY_MIN..DMA_BUF_PRIORITY_MAX. Lower
+	 * values should be reclaimed EARLIER under memory pressure.
+	 */
+	__u32 priority;
+	/** @pad: must be zero, reserved for future use. */
+	__u32 pad;
+};
+
+#define DMA_BUF_PRIORITY_MIN		0
+#define DMA_BUF_PRIORITY_DEFAULT	128
+#define DMA_BUF_PRIORITY_MAX		255
+
 #define DMA_BUF_BASE		'b'
 #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
 
@@ -179,5 +210,7 @@ struct dma_buf_import_sync_file {
 #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
 #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
 #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
+#define DMA_BUF_IOCTL_SET_PRIORITY	_IOW(DMA_BUF_BASE, 4, struct dma_buf_priority)
+#define DMA_BUF_IOCTL_GET_PRIORITY	_IOR(DMA_BUF_BASE, 5, struct dma_buf_priority)
 
 #endif
-- 
2.53.0

