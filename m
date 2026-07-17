Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725BEC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E965E10F500;
	Fri, 17 Jul 2026 10:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="NItu6mby";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7649110F4FF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:48:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7A27169E;
 Fri, 17 Jul 2026 03:48:29 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com
 [10.2.198.107])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2171A3F7D8;
 Fri, 17 Jul 2026 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784285314; bh=9cPPT0hhQ4cO7VIRLqsU2E5h9uEzkzPUVVwnMnUldOs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NItu6mbyTmXQIaqf6zBOV+8styqpg93BBRgFxoCtT51N2/2uc9g/YkIi5mGqcgpSn
 DX/1k3E1W/5oFTAb7wXEUG2gs2iPAt58JbxFfJjni23EAa+kX7F+xKPCjvLEtetgJN
 PQpQj8/p6lKLJrAgq2CuDwWP3IndZZWXnLF70kzE=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: [RFC PATCH v1 7/8] misc/arm-cla: Manage domain contexts
Date: Fri, 17 Jul 2026 11:47:51 +0100
Message-ID: <20260717104759.123203-8-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717104759.123203-1-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A CLA domain cannot be used by multiple address spaces concurrently
because its devices share a memory translation context and may
communicate without isolation. Represent each user of a domain with a
context keyed by the mm_struct and device file description, and track
contexts in a per-domain hash table.

Add a domain scheduler that queues contexts for assignment and gives
each one a fixed time slice. Before switching, revoke the outgoing
context's mappings from all VMAs for the device file. Then save its
accelerator state and remove its MTC, before installing the incoming
context's MTC and restoring the incoming accelerator state.

Run hardware operations through CPU-bound kthread workers, since each
CLA can only be accessed from its local CPU. Coordinate the per-device
workers with a domain worker so that every CLA in the domain is switched
as a single assignment unit.

Defer context deassignment and destruction when the final mapping
disappears to avoid taking mmap_lock in the wrong order. Keep the mm and
file alive until the context has been removed from hardware and
reclaimed.

Treat a failure on any device as a failure of the whole domain. Stop
further assignments and wake all waiters when a domain becomes unusable.

Co-developed-by: Jean-Philippe Brucker <jpb@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 drivers/misc/arm-cla/Makefile       |   2 +
 drivers/misc/arm-cla/arm-cla.h      | 128 ++++++++
 drivers/misc/arm-cla/cla-ctx.c      | 142 +++++++++
 drivers/misc/arm-cla/cla-init.c     |  48 +++
 drivers/misc/arm-cla/cla-sched.c    | 474 ++++++++++++++++++++++++++++
 drivers/misc/arm-cla/cla-topology.c |   9 +
 6 files changed, 803 insertions(+)
 create mode 100644 drivers/misc/arm-cla/cla-ctx.c
 create mode 100644 drivers/misc/arm-cla/cla-sched.c

diff --git a/drivers/misc/arm-cla/Makefile b/drivers/misc/arm-cla/Makefile
index df3ad7e4a1b4..a92c3594e5c9 100644
--- a/drivers/misc/arm-cla/Makefile
+++ b/drivers/misc/arm-cla/Makefile
@@ -2,9 +2,11 @@
 
 arm-cla-y := \
 	cla-init.o \
+	cla-ctx.o \
 	cla-mtc.o \
 	cla-ops.o \
 	cla-regs.o \
+	cla-sched.o \
 	cla-topology.o
 
 obj-$(CONFIG_ARM_CLA) += arm-cla.o
diff --git a/drivers/misc/arm-cla/arm-cla.h b/drivers/misc/arm-cla/arm-cla.h
index ffdb82e5e09c..041d4a8d7e91 100644
--- a/drivers/misc/arm-cla/arm-cla.h
+++ b/drivers/misc/arm-cla/arm-cla.h
@@ -7,9 +7,21 @@
 #ifndef _ARM_CLA_H_
 #define _ARM_CLA_H_
 
+#include <linux/atomic.h>
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/kref.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/mutex.h>
+#include <linux/rhashtable-types.h>
+#include <linux/rwsem.h>
 #include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include "arm-cla-regs.h"
 
@@ -18,8 +30,21 @@
 #define CLA_NUM_DATA_REGS	8
 #define CLA_SRSTATE_LEN		8
 
+/* Quantum of CLA assignment */
+#define CLA_SLICE_MS		100
+
 struct cla_domain;
 
+struct cla_call_on_cpu {
+	int ret;
+	struct {
+		struct cla_ctx *prev_ctx;
+		struct cla_ctx *next_ctx;
+		unsigned int ctx_id;
+	} sched;
+	struct kthread_work switch_ctx;
+};
+
 /**
  * struct cla_dev - CLA device
  *
@@ -36,6 +61,9 @@ struct cla_domain;
  * Mutable, only accessed under @lock:
  * @lock:		Protects the following members.
  * @broken:		Hardware failure.
+ * @worker:		CPU-bound worker to communicate with CLA.
+ * @worker_sem:		Serialize running @call against @worker destruction.
+ * @call:		Scheduling work.
  */
 struct cla_dev {
 	unsigned int cpu;
@@ -49,22 +77,50 @@ struct cla_dev {
 
 	struct mutex lock;
 	bool broken;
+	struct kthread_worker *worker;
+	struct rw_semaphore worker_sem;
+	struct cla_call_on_cpu call;
 };
 
 /**
  * struct cla_domain - Collection of cla_dev
  *
+ * The whole domain is assigned to a single cla_ctx at a time.
+ *
  * Immutable state:
  * @id:			Domain identifier, from FW or generated.
  * @pg_offset:		Mmap offset of the first device.
  * @nr_devs:		Number of devices in the domain.
  * @devs:		Devices.
+ *
+ * Mutable, only accessed under @lock:
+ * @lock:		Protects the following members.
+ * @ctxs:		All live contexts, keyed on mm_struct and file ptr.
+ * @queued_ctxs:	Queue of contexts waiting for assignment.
+ * @dying_ctxs:		Contexts waiting for reclaim.
+ * @worker:		Kthread worker to coordinate reassignment.
+ * @reassign:		Delayed work that switches contexts with time slicing.
+ * @reclaim:		Work to release and free contexts (after reassignment).
+ *
+ * Mutable, some reads outside the lock:
+ * @broken:		Hardware failure in any device in the domain.
+ * @assigned_ctx:	Context to which domain is currently assigned.
  */
 struct cla_domain {
 	unsigned int id;
 	unsigned long pg_offset;
 	unsigned int nr_devs;
 	struct cla_dev **devs;
+
+	struct mutex lock;
+	bool broken;
+	struct rhashtable ctxs;
+	struct list_head queued_ctxs;
+	struct list_head dying_ctxs;
+	struct cla_ctx *assigned_ctx;
+	struct kthread_worker *worker;
+	struct kthread_delayed_work reassign;
+	struct kthread_delayed_work reclaim;
 };
 
 /**
@@ -84,6 +140,46 @@ struct cla_regs {
 	u64 regstate[];
 };
 
+struct cla_ctx_key {
+	struct mm_struct *mm;
+	struct file *file;
+};
+
+/**
+ * struct cla_ctx - Domain context
+ *
+ * Immutable state:
+ * @domain:		The domain of this context.
+ * @key:		Key in cla_domain::ctxs hashtable.
+ * @node:		Node in cla_domain::ctxs hashtable.
+ *
+ * Mutable, protected by domain::lock:
+ * @refcnt:		Current users of this context.
+ * @queue_node:		Node in cla_domain::queued_ctxs or
+ *			cla_domain::dying_ctxs.
+ * @waitq:		Faulting threads sleep until assignment.
+ *
+ * Mutable, protected by domain::lock, some reads outside the lock:
+ * @mapped:		Number of VMAs mapping the context.
+ *
+ * Mutable, written only by domain::reassign and dev::switch_ctx:
+ * @regs:		State for each device in domain.
+ * @asid:		Pinned ASID of live context.
+ */
+struct cla_ctx {
+	struct kref refcnt;
+	struct rhash_head node;
+
+	struct cla_domain *domain;
+	struct cla_ctx_key key;
+
+	refcount_t mapped;
+	struct list_head queue_node;
+	struct cla_regs **regs;
+	wait_queue_head_t waitq;
+	unsigned int asid;
+};
+
 extern struct xarray cla_domains;
 extern unsigned int cla_nr_domains;
 extern struct cla_dev **cla_lut_cpu;
@@ -126,6 +222,38 @@ static inline void cla_reg_write(struct cla_dev *dev, off_t reg, u64 val)
 struct cla_domain *cla_dev_domain_get(struct cla_dev *dev);
 int cla_domains_finalise(void);
 void cla_domains_free(void);
+int cla_domain_sched_init(struct cla_domain *domain);
+void cla_domain_sched_exit(struct cla_domain *domain);
+void cla_domain_set_broken(struct cla_domain *domain);
+struct cla_ctx *cla_domain_lookup_ctx(struct cla_domain *domain,
+				      struct mm_struct *mm, struct file *file);
+int cla_domain_insert_ctx(struct cla_domain *domain, struct cla_ctx *ctx);
+void cla_domain_remove_ctx(struct cla_domain *domain, struct cla_ctx *ctx);
+void cla_domain_schedule_reassignment(struct cla_domain *domain,
+				      unsigned long ms);
+void cla_domain_schedule_reclaim(struct cla_domain *domain);
+struct cla_ctx *cla_ctx_map(struct cla_domain *domain, struct mm_struct *mm,
+			    struct file *file);
+void cla_ctx_unmap(struct cla_domain *domain, struct mm_struct *mm,
+		   struct file *file);
+void cla_ctx_free(struct kref *ref);
+
+static inline void cla_ctx_get(struct cla_ctx *ctx)
+{
+	kref_get(&ctx->refcnt);
+}
+
+static inline void cla_ctx_put(struct cla_ctx *ctx)
+{
+	kref_put(&ctx->refcnt, cla_ctx_free);
+}
+
+static inline bool cla_ctx_is_dying(struct cla_ctx *ctx)
+{
+	return refcount_read(&ctx->mapped) == 0;
+}
+
+void cla_dev_switch_ctx(struct kthread_work *work);
 
 int cla_op_wait_lresp(struct cla_dev *dev, u64 *lresp);
 int cla_op_reset(struct cla_dev *dev, unsigned int accid);
diff --git a/drivers/misc/arm-cla/cla-ctx.c b/drivers/misc/arm-cla/cla-ctx.c
new file mode 100644
index 000000000000..db2bf5b7f106
--- /dev/null
+++ b/drivers/misc/arm-cla/cla-ctx.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/err.h>
+#include <linux/file.h>
+#include <linux/gfp.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+
+#include "arm-cla.h"
+
+/**
+ * cla_ctx_map - Map a process and file to a CLA domain context
+ * @domain: CLA domain
+ * @mm: process address space
+ * @file: CLA device file
+ *
+ * Reuse an existing context for the same @mm and @file, or allocate and insert
+ * a new context into @domain. The context mapping count is incremented before
+ * returning.
+ *
+ * Return: the mapped context on success, or an error pointer on failure
+ */
+struct cla_ctx *cla_ctx_map(struct cla_domain *domain, struct mm_struct *mm,
+			    struct file *file)
+{
+	struct cla_ctx *ctx;
+	int ret = -ENOMEM;
+
+	mutex_lock(&domain->lock);
+	if (domain->broken) {
+		ret = -EIO;
+		goto err_unlock;
+	}
+
+	ctx = cla_domain_lookup_ctx(domain, mm, file);
+	if (ctx) {
+		refcount_inc(&ctx->mapped);
+		mutex_unlock(&domain->lock);
+		return ctx;
+	}
+
+	ctx = kzalloc_obj(*ctx, GFP_KERNEL_ACCOUNT);
+	if (!ctx)
+		goto err_unlock;
+
+	kref_init(&ctx->refcnt);
+	refcount_set(&ctx->mapped, 1);
+	ctx->domain = domain;
+	ctx->regs = cla_regs_alloc_domain(domain);
+	if (!ctx->regs)
+		goto err_free;
+
+	mmgrab(mm);
+	ctx->key.mm = mm;
+	get_file(file);
+	ctx->key.file = file;
+	INIT_LIST_HEAD(&ctx->queue_node);
+	init_waitqueue_head(&ctx->waitq);
+
+	ret = cla_domain_insert_ctx(domain, ctx);
+	if (ret)
+		goto err_mmdrop;
+	mutex_unlock(&domain->lock);
+
+	return ctx;
+
+err_mmdrop:
+	mmdrop(ctx->key.mm);
+	fput(ctx->key.file);
+	cla_regs_free_domain(domain, ctx->regs);
+err_free:
+	kfree(ctx);
+err_unlock:
+	mutex_unlock(&domain->lock);
+	return ERR_PTR(ret);
+}
+
+/**
+ * cla_ctx_unmap - Unmap a process and file from a CLA domain context
+ * @domain: CLA domain
+ * @mm: process address space
+ * @file: CLA device file
+ *
+ * Drop a context mapping. When the final mapping is removed, wake waiters,
+ * remove the context from @domain, and schedule it for deassignment and
+ * reclaim.
+ */
+void cla_ctx_unmap(struct cla_domain *domain, struct mm_struct *mm,
+		   struct file *file)
+{
+	struct cla_ctx *ctx;
+
+	mutex_lock(&domain->lock);
+	ctx = cla_domain_lookup_ctx(domain, mm, file);
+	WARN_ON(!ctx);
+
+	if (!refcount_dec_and_test(&ctx->mapped)) {
+		mutex_unlock(&domain->lock);
+		return;
+	}
+
+	/* Notify waiters that their context is dying. */
+	wake_up_all(&ctx->waitq);
+	cla_domain_remove_ctx(domain, ctx);
+
+	/*
+	 * Since we're holding the mmap_lock for writing, and reassignment work
+	 * may be waiting to grab it for reading, we cannot wait for
+	 * reassignment here. The context holds a reference to mm_count, so the
+	 * mm_struct or pgd are not going away until cla_ctx_free().
+	 * If the mm is exiting, the accelerators will now access memory through
+	 * an empty pgd and fault silently.
+	 *
+	 * Schedule deassignment followed by reclaim. If reassignment is
+	 * currently running, it reschedules itself once it re-takes the lock:
+	 * - After deassigning this context, schedule reassignment as usual. If
+	 *   no more contexts are queued, the following reassignment is a NOP.
+	 * - After assigning this context, insert a deassignment before reclaim.
+	 */
+	if (domain->assigned_ctx == ctx)
+		cla_domain_schedule_reassignment(domain, 0);
+	list_move(&ctx->queue_node, &domain->dying_ctxs);
+	cla_domain_schedule_reclaim(domain);
+	mutex_unlock(&domain->lock);
+}
+
+/**
+ * cla_ctx_free - Free a CLA domain context
+ * @ref: context reference counter
+ *
+ * Release resources held by a dying context after final reference is dropped.
+ */
+void cla_ctx_free(struct kref *ref)
+{
+	struct cla_ctx *ctx = container_of(ref, struct cla_ctx, refcnt);
+
+	WARN_ON(!cla_ctx_is_dying(ctx));
+	mmdrop(ctx->key.mm);
+	fput(ctx->key.file);
+	cla_regs_free_domain(ctx->domain, ctx->regs);
+	kfree(ctx);
+}
diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-init.c
index 0451d97bc95b..5335c55568ad 100644
--- a/drivers/misc/arm-cla/cla-init.c
+++ b/drivers/misc/arm-cla/cla-init.c
@@ -160,6 +160,7 @@ static void cla_dev_reinit(struct cla_dev *dev)
 		mutex_lock(&dev->lock);
 		dev->broken = true;
 		mutex_unlock(&dev->lock);
+		cla_domain_set_broken(dev->domain);
 		return;
 	}
 
@@ -171,6 +172,46 @@ static void cla_dev_reinit(struct cla_dev *dev)
 	cla_reg_write(dev, CLA_REG_LRESP, 0);
 }
 
+static int cla_dev_worker_init(struct cla_dev *dev, int cpu)
+{
+	struct kthread_worker *worker;
+
+	worker = kthread_run_worker_on_cpu(cpu, 0, "cla-dev-worker/%u");
+	if (IS_ERR(worker))
+		return PTR_ERR(worker);
+
+	mutex_lock(&dev->lock);
+	WARN_ON(dev->worker);
+	dev->worker = worker;
+	mutex_unlock(&dev->lock);
+
+	return 0;
+}
+
+static void cla_dev_worker_destroy(struct cla_dev *dev)
+{
+	struct kthread_worker *worker;
+
+	/*
+	 * Mark the worker as NULL, which prevents any new work from being
+	 * queued to it. Then destroy it, which will flush any pending work.
+	 * worker_sem guarantees lifetime of worker when flushing work in other
+	 * paths. We must reinit the work so that work->worker is not dangling
+	 * after releasing worker_sem.
+	 */
+	mutex_lock(&dev->lock);
+	worker = dev->worker;
+	dev->worker = NULL;
+	mutex_unlock(&dev->lock);
+
+	if (worker) {
+		down_write(&dev->worker_sem);
+		kthread_destroy_worker(worker);
+		kthread_init_work(&dev->call.switch_ctx, cla_dev_switch_ctx);
+		up_write(&dev->worker_sem);
+	}
+}
+
 static int cla_dev_setup(unsigned int cpu)
 {
 	int i;
@@ -227,6 +268,10 @@ static int cla_dev_setup(unsigned int cpu)
 			 dev->accelerators);
 	}
 
+	ret = cla_dev_worker_init(dev, cpu);
+	if (ret)
+		goto err;
+
 	return 0;
 err:
 	cla_dev_reinit(dev);
@@ -245,6 +290,7 @@ static int cla_dev_teardown(unsigned int cpu)
 	if (!dev)
 		return 0;
 
+	cla_dev_worker_destroy(dev);
 	cla_dev_reinit(dev);
 
 	return 0;
@@ -289,6 +335,8 @@ static struct cla_dev *cla_dev_alloc(struct device *parent, int cpu,
 	dev->dev = parent;
 
 	mutex_init(&dev->lock);
+	init_rwsem(&dev->worker_sem);
+	kthread_init_work(&dev->call.switch_ctx, cla_dev_switch_ctx);
 
 	/* Attempt to find device domain, or allocate a new one */
 	dev->domain = cla_dev_domain_get(dev);
diff --git a/drivers/misc/arm-cla/cla-sched.c b/drivers/misc/arm-cla/cla-sched.c
new file mode 100644
index 000000000000..18b54cc386b7
--- /dev/null
+++ b/drivers/misc/arm-cla/cla-sched.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arm CLA driver - domain scheduling
+ *
+ * Copyright 2026 Arm Limited.
+ */
+
+#include <linux/rhashtable.h>
+#include <linux/mmu_context.h>
+
+#include "arm-cla.h"
+
+static const struct rhashtable_params ctxs_rht_params = {
+	.head_offset = offsetof(struct cla_ctx, node),
+	.key_offset = offsetof(struct cla_ctx, key),
+	.key_len = sizeof(((struct cla_ctx *)0)->key),
+	.automatic_shrinking = true,
+};
+
+static int __cla_domain_switch_ctx(struct cla_domain *domain,
+				   struct cla_ctx *prev_ctx,
+				   struct cla_ctx *next_ctx)
+{
+	int ret = 0;
+	unsigned int i;
+	struct cla_dev *dev;
+	struct cla_call_on_cpu *call;
+
+	if (!prev_ctx && !next_ctx)
+		return 0;
+
+	for (i = 0; i < domain->nr_devs; i++) {
+		dev = domain->devs[i];
+		call = &dev->call;
+
+		call->sched.prev_ctx = prev_ctx;
+		call->sched.next_ctx = next_ctx;
+		call->sched.ctx_id = i;
+		call->ret = 0;
+
+		mutex_lock(&dev->lock);
+		if (dev->worker && !dev->broken)
+			kthread_queue_work(dev->worker, &call->switch_ctx);
+		mutex_unlock(&dev->lock);
+	}
+
+	for (i = 0; i < domain->nr_devs; i++) {
+		dev = domain->devs[i];
+		call = &dev->call;
+
+		down_read(&dev->worker_sem);
+		kthread_flush_work(&call->switch_ctx);
+		up_read(&dev->worker_sem);
+
+		/*
+		 * kthread worker and kthread_flush_work() both take the worker
+		 * lock to respectively write and read the current_work,
+		 * providing the desired memory ordering for ret.
+		 */
+		if (call->ret)
+			ret = call->ret;
+	}
+
+	return ret;
+}
+
+static int cla_domain_switch_ctx(struct cla_domain *domain,
+				 struct cla_ctx *prev_ctx,
+				 struct cla_ctx *next_ctx)
+{
+	int ret;
+
+	/* Remove prev_ctx from all devices in the domain */
+	ret = __cla_domain_switch_ctx(domain, prev_ctx, NULL);
+	if (ret) {
+		mmgrab(prev_ctx->key.mm);
+		goto err_kill_domain;
+	}
+
+	if (prev_ctx)
+		arm64_mm_context_put(prev_ctx->key.mm);
+	if (next_ctx) {
+		next_ctx->asid = arm64_mm_context_get(next_ctx->key.mm);
+		if (next_ctx->asid == 0) {
+			pr_err("cla: out of pinned ASIDs\n");
+			ret = -ENOSPC;
+			goto err_kill_domain;
+		}
+	}
+
+	/* Install next_ctx into all devices in the domain */
+	ret = __cla_domain_switch_ctx(domain, NULL, next_ctx);
+	if (ret) {
+		mmgrab(next_ctx->key.mm);
+		goto err_kill_domain;
+	}
+	return 0;
+
+err_kill_domain:
+	/* Hardware failure, the domain is dead */
+	cla_domain_set_broken(domain);
+	return ret;
+}
+
+/*
+ * This should only be called within the context of the device's worker, and
+ * so is bound to the cla's local cpu. The worker ensures serialization of
+ * invocations for the same cla. cla_dev_switch_ctx() may be running
+ * concurrently on other cpus for other clas in the same domain.
+ */
+static int __cla_dev_switch_ctx(struct cla_dev *dev)
+{
+	struct cla_ctx *prev_ctx, *next_ctx;
+	unsigned long ctx_id;
+	int ret;
+
+	if (WARN_ON(smp_processor_id() != dev->cpu))
+		return -EINVAL;
+
+	prev_ctx = dev->call.sched.prev_ctx;
+	next_ctx = dev->call.sched.next_ctx;
+	ctx_id = dev->call.sched.ctx_id;
+
+	/* Save state for outgoing ctx. */
+	if (prev_ctx) {
+		/*
+		 * Since we're not holding the domain lock during this check, we
+		 * may be saving a dying context, but it's only an optimisation.
+		 */
+		bool do_save = !cla_ctx_is_dying(prev_ctx);
+
+		ret = cla_regs_switch_out(dev, prev_ctx->regs[ctx_id], do_save);
+		if (ret) {
+			cla_err(dev, "failed to remove regs: %d\n", ret);
+			return ret;
+		}
+
+		ret = cla_mtc_uninstall(dev);
+		if (ret) {
+			cla_err(dev, "failed to remove mm: %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* Restore state for incoming ctx. */
+	if (next_ctx) {
+		ret = cla_mtc_install(dev, next_ctx->key.mm->pgd, next_ctx->asid);
+		if (ret) {
+			cla_err(dev, "failed to setup mm: %d\n", ret);
+			return ret;
+		}
+
+		ret = cla_regs_switch_in(dev, next_ctx->regs[ctx_id]);
+		if (ret) {
+			cla_err(dev, "failed to setup regs: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+void cla_dev_switch_ctx(struct kthread_work *work)
+{
+	struct cla_call_on_cpu *call =
+		container_of(work, struct cla_call_on_cpu, switch_ctx);
+	struct cla_dev *dev = container_of(call, struct cla_dev, call);
+
+	call->ret = __cla_dev_switch_ctx(dev);
+	if (call->ret) {
+		mutex_lock(&dev->lock);
+		dev->broken = true;
+		mutex_unlock(&dev->lock);
+	}
+}
+
+static inline struct cla_ctx *cla_domain_get_next_ctx(struct cla_domain *domain)
+{
+	return list_first_entry_or_null(&domain->queued_ctxs, struct cla_ctx,
+					queue_node);
+}
+
+static inline struct cla_ctx *cla_domain_get_prev_ctx(struct cla_domain *domain,
+						      struct cla_ctx *next_ctx)
+{
+	if (domain->assigned_ctx && (next_ctx || cla_ctx_is_dying(domain->assigned_ctx)))
+		return domain->assigned_ctx;
+	return NULL;
+}
+
+static void cla_vma_zap_domain(struct vm_area_struct *vma, struct cla_domain *domain)
+{
+	unsigned long vma_start = vma->vm_pgoff;
+	unsigned long vma_end = vma_start + vma_pages(vma);
+	unsigned long domain_start = domain->pg_offset;
+	unsigned long domain_end = domain_start + domain->nr_devs;
+	unsigned long start = max(vma_start, domain_start);
+	unsigned long end = min(vma_end, domain_end);
+	unsigned long addr;
+	unsigned long size;
+
+	if (start >= end)
+		return;
+
+	addr = vma->vm_start + ((start - vma_start) << PAGE_SHIFT);
+	size = (end - start) << PAGE_SHIFT;
+	zap_special_vma_range(vma, addr, size);
+}
+
+static void cla_domain_zap(struct cla_domain *domain, struct cla_ctx *ctx)
+{
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+
+	/*
+	 * If the context is dying it has already been unmapped, no need to zap
+	 * it here.
+	 */
+	if (!ctx || cla_ctx_is_dying(ctx))
+		return;
+
+	/*
+	 * Iterate over vmas in prev_ctx's mm, looking for vmas that map
+	 * prev_ctx's file. Zap any portions of those vmas that map the domain.
+	 */
+	mmap_read_lock(ctx->key.mm);
+	vma_iter_init(&vmi, ctx->key.mm, 0);
+	for_each_vma(vmi, vma) {
+		if (vma->vm_file != ctx->key.file)
+			continue;
+
+		cla_vma_zap_domain(vma, domain);
+	}
+	mmap_read_unlock(ctx->key.mm);
+}
+
+static void cla_domain_reassign(struct kthread_work *work)
+{
+	struct cla_ctx invalid_ctx;
+	struct cla_domain *domain;
+	struct cla_ctx *prev_ctx;
+	struct cla_ctx *next_ctx;
+	int ret;
+
+	domain = container_of(work, struct cla_domain, reassign.work);
+
+	mutex_lock(&domain->lock);
+	if (domain->broken)
+		goto out_unlock;
+
+	/* Figure out prev_ctx and next_ctx. NULL indicates don't [un]assign. */
+	next_ctx = cla_domain_get_next_ctx(domain);
+	prev_ctx = cla_domain_get_prev_ctx(domain, next_ctx);
+
+	if (!prev_ctx && !next_ctx)
+		goto out_unlock;
+
+	/*
+	 * We need to grab mmap_lock, but can't do so while holding the domain
+	 * lock (since cla_vma_fault() grabs the domain lock while holding
+	 * mmap_lock). We are the only thread that modifies assigned_ctx, but
+	 * the queue may change and contexts may be killed by cla_ctx_unmap().
+	 *
+	 * No user is allowed to access CLA while we are reassigning. Disable
+	 * assigned_ctx before zapping so cla_vma_fault() won't re-map the
+	 * domain during reassignment. A NULL assigned_ctx causes
+	 * cla_vma_fault() to immediately schedule a reassignment; use a
+	 * reserved context to make it wait.
+	 */
+	WRITE_ONCE(domain->assigned_ctx, &invalid_ctx);
+	mutex_unlock(&domain->lock);
+
+	/* Prevent prev_ctx from accessing any device in the domain. */
+	cla_domain_zap(domain, prev_ctx);
+
+	/* Do per-device reassignment work and wait for it to complete. */
+	ret = cla_domain_switch_ctx(domain, prev_ctx, next_ctx);
+	if (ret)
+		next_ctx = NULL;
+
+	mutex_lock(&domain->lock);
+	WRITE_ONCE(domain->assigned_ctx, next_ctx);
+
+	/*
+	 * Remove next_ctx from the queue and wake up all waiters so that the
+	 * fault handler can map the domain into the newly assigned process.
+	 * assigned_ctx must have been updated prior to waking the waiters.
+	 *
+	 * If next_ctx was killed while we were assigning it, insert a
+	 * deassignment before the upcoming reclaim.
+	 */
+	if (next_ctx) {
+		if (cla_ctx_is_dying(next_ctx)) {
+			cla_domain_schedule_reassignment(domain, 0);
+			cla_domain_schedule_reclaim(domain);
+			goto out_unlock;
+		}
+		list_del_init(&next_ctx->queue_node);
+		wake_up_all(&next_ctx->waitq);
+	}
+
+	/* If there are more queued ctxs, schedule the next reassignment. */
+	if (!list_empty(&domain->queued_ctxs))
+		cla_domain_schedule_reassignment(domain, CLA_SLICE_MS);
+
+out_unlock:
+	mutex_unlock(&domain->lock);
+}
+
+static void cla_domain_reclaim(struct kthread_work *work)
+{
+	struct cla_domain *domain;
+	struct cla_ctx *ctx, *next;
+
+	domain = container_of(work, struct cla_domain, reclaim.work);
+
+	mutex_lock(&domain->lock);
+	list_for_each_entry_safe(ctx, next, &domain->dying_ctxs, queue_node) {
+		list_del_init(&ctx->queue_node);
+		WARN_ON(domain->assigned_ctx == ctx);
+		cla_ctx_put(ctx);
+	}
+	mutex_unlock(&domain->lock);
+}
+
+/**
+ * cla_domain_sched_init - Initialize scheduling for a CLA domain
+ * @domain: CLA domain
+ *
+ * Initialize domain context table, scheduling queues, worker, and work items.
+ *
+ * Return: 0 on success, or an error
+ */
+int cla_domain_sched_init(struct cla_domain *domain)
+{
+	int ret;
+
+	INIT_LIST_HEAD(&domain->queued_ctxs);
+	INIT_LIST_HEAD(&domain->dying_ctxs);
+	WRITE_ONCE(domain->assigned_ctx, NULL);
+
+	ret = rhashtable_init(&domain->ctxs, &ctxs_rht_params);
+	if (ret)
+		return ret;
+
+	domain->worker = kthread_run_worker(0, "cla-domain-worker");
+	if (IS_ERR(domain->worker)) {
+		rhashtable_destroy(&domain->ctxs);
+		return PTR_ERR(domain->worker);
+	}
+	kthread_init_delayed_work(&domain->reassign, cla_domain_reassign);
+	kthread_init_delayed_work(&domain->reclaim, cla_domain_reclaim);
+
+	return 0;
+}
+
+/**
+ * cla_domain_sched_exit - Tear down scheduling for a CLA domain
+ * @domain: CLA domain
+ *
+ * Cancel pending reassignment work, flush reclaim work, destroy the domain
+ * worker, and destroy the context table.
+ */
+void cla_domain_sched_exit(struct cla_domain *domain)
+{
+	WARN_ON(!list_empty(&domain->queued_ctxs));
+	WARN_ON(READ_ONCE(domain->assigned_ctx));
+
+	kthread_cancel_delayed_work_sync(&domain->reassign);
+	/* Since reclaim is always queued with 0 delay, it gets flushed here. */
+	kthread_destroy_worker(domain->worker);
+	rhashtable_destroy(&domain->ctxs);
+}
+
+/**
+ * cla_domain_set_broken - Mark a CLA domain as broken
+ * @domain: CLA domain
+ *
+ * Prevent further reassignment work and wake contexts waiting for assignment.
+ */
+void cla_domain_set_broken(struct cla_domain *domain)
+{
+	struct cla_ctx *ctx;
+
+	mutex_lock(&domain->lock);
+	WRITE_ONCE(domain->broken, true);
+	/* Notify any waiter that their context isn't getting reassigned */
+	list_for_each_entry(ctx, &domain->queued_ctxs, queue_node)
+		wake_up_all(&ctx->waitq);
+	mutex_unlock(&domain->lock);
+}
+
+/**
+ * cla_domain_lookup_ctx - Look up a context in a CLA domain
+ * @domain: CLA domain
+ * @mm: process address space
+ * @file: CLA device file
+ *
+ * The caller must hold the domain lock.
+ *
+ * Return: the matching context, or %NULL if no context was found
+ */
+struct cla_ctx *cla_domain_lookup_ctx(struct cla_domain *domain,
+				      struct mm_struct *mm, struct file *file)
+{
+	struct cla_ctx_key key = {
+		.mm = mm,
+		.file = file,
+	};
+
+	lockdep_assert_held(&domain->lock);
+	return rhashtable_lookup_fast(&domain->ctxs, &key, ctxs_rht_params);
+}
+
+/**
+ * cla_domain_insert_ctx - Insert a context into a CLA domain
+ * @domain: CLA domain
+ * @ctx: context to insert
+ *
+ * The caller must hold the domain lock.
+ *
+ * Return: 0 on success, or an error
+ */
+int cla_domain_insert_ctx(struct cla_domain *domain, struct cla_ctx *ctx)
+{
+	lockdep_assert_held(&domain->lock);
+	return rhashtable_insert_fast(&domain->ctxs, &ctx->node, ctxs_rht_params);
+}
+
+/**
+ * cla_domain_remove_ctx - Remove a context from a CLA domain
+ * @domain: CLA domain
+ * @ctx: context to remove
+ *
+ * The caller must hold the domain lock.
+ */
+void cla_domain_remove_ctx(struct cla_domain *domain, struct cla_ctx *ctx)
+{
+	lockdep_assert_held(&domain->lock);
+	rhashtable_remove_fast(&domain->ctxs, &ctx->node, ctxs_rht_params);
+}
+
+/**
+ * cla_domain_schedule_reassignment - Schedule domain reassignment
+ * @domain: CLA domain
+ * @ms: delay in milliseconds
+ *
+ * The caller must hold the domain lock. Nop if the domain is broken.
+ */
+void cla_domain_schedule_reassignment(struct cla_domain *domain, unsigned long ms)
+{
+	lockdep_assert_held(&domain->lock);
+	if (!domain->broken)
+		kthread_mod_delayed_work(domain->worker, &domain->reassign,
+					 msecs_to_jiffies(ms));
+}
+
+/**
+ * cla_domain_schedule_reclaim - Schedule reclaim of dying contexts
+ * @domain: CLA domain
+ *
+ * The caller must hold the domain lock. Reclaim is queued without delay after
+ * any work already pending on the domain worker.
+ */
+void cla_domain_schedule_reclaim(struct cla_domain *domain)
+{
+	lockdep_assert_held(&domain->lock);
+	/*
+	 * Reclaim is always queued with 0 delay. It is a delayed work only so
+	 * we can easily move the work to the back of the queue (after
+	 * reassign). Doing so is tricky with non-delayed work.
+	 */
+	kthread_mod_delayed_work(domain->worker, &domain->reclaim, 0);
+}
diff --git a/drivers/misc/arm-cla/cla-topology.c b/drivers/misc/arm-cla/cla-topology.c
index 402c228e197c..ca416b610cb1 100644
--- a/drivers/misc/arm-cla/cla-topology.c
+++ b/drivers/misc/arm-cla/cla-topology.c
@@ -37,6 +37,8 @@ static struct cla_domain *cla_domain_alloc(struct cla_dev *dev, unsigned int id)
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&domain->lock);
+
 	domain->id = id;
 	ret = xa_insert(&cla_domains, id, domain, GFP_KERNEL);
 	if (ret < 0)
@@ -50,8 +52,14 @@ static struct cla_domain *cla_domain_alloc(struct cla_dev *dev, unsigned int id)
 	}
 	domain->devs[0] = dev;
 
+	ret = cla_domain_sched_init(domain);
+	if (ret)
+		goto err_free_devs;
+
 	return domain;
 
+err_free_devs:
+	kfree(domain->devs);
 err_free_id:
 	xa_erase(&cla_domains, domain->id);
 err_free_domain:
@@ -155,6 +163,7 @@ int __init cla_domains_finalise(void)
 
 static void cla_domain_free(struct cla_domain *domain)
 {
+	cla_domain_sched_exit(domain);
 	kfree(domain->devs);
 	xa_erase(&cla_domains, domain->id);
 	kfree(domain);
-- 
2.43.0

