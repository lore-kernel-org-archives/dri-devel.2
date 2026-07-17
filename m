Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4C5C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7990010F4FD;
	Fri, 17 Jul 2026 10:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rTbxGfMD";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 759D910F4FD
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:48:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E217916A3;
 Fri, 17 Jul 2026 03:48:31 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com
 [10.2.198.107])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504B73F7D8;
 Fri, 17 Jul 2026 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784285316; bh=wqXkAtcd1JkcLZE+TF60/UvHHNNYyFX6YQhnrddF4eA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rTbxGfMDL/rlkadUaC3iwvE7T5tcrxAET84ATpQlHdqxJQ4fYxk3qdUMTLXbvVOw7
 I78h5jxDf3H6V7trXu6GBCd/Aj5coetUxV9K9cyIdOkr9cKw0Fz3/ucJYvX2ZKsyof
 QL4We9oSHBl0epIPno/MH3B7vSMk/UMGHbsqVIM0=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: [RFC PATCH v1 8/8] misc/arm-cla: Add userspace interface
Date: Fri, 17 Jul 2026 11:47:52 +0100
Message-ID: <20260717104759.123203-9-ryan.roberts@arm.com>
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

Expose CLA devices through a character device so userspace can enumerate
the available hardware and map accelerator register frames.

Define version 1 of the CLA UAPI with a GET_PARAM ioctl. Report device
topology, CPU affinity, domain membership, mmap offsets, architecture
version and attached accelerator masks, together with the IIDR, DEVARCH
and REVIDR of each accelerator.

CLA registers can only be read from the CPU local to the device, while
enumeration may occur on any CPU. Validate the supported CLA
architecture version during device setup and cache the CLA and
accelerator identification registers for later ioctl queries.

Support shared read-write mmap of one or more CLA register pages. Create
a context for every domain covered by the mapping and resolve faults
only while that context owns the domain. Queue unassigned contexts with
the domain scheduler, drop mmap_lock while waiting for assignment and
retry the fault after the context is woken.

Co-developed-by: Jean-Philippe Brucker <jpb@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 drivers/misc/arm-cla/Makefile       |   3 +-
 drivers/misc/arm-cla/arm-cla-regs.h |   2 +
 drivers/misc/arm-cla/arm-cla.h      |  13 ++
 drivers/misc/arm-cla/cla-init.c     |  26 +++
 drivers/misc/arm-cla/cla-user.c     | 351 ++++++++++++++++++++++++++++
 include/uapi/linux/arm-cla.h        | 207 ++++++++++++++++
 6 files changed, 601 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/arm-cla/cla-user.c
 create mode 100644 include/uapi/linux/arm-cla.h

diff --git a/drivers/misc/arm-cla/Makefile b/drivers/misc/arm-cla/Makefile
index a92c3594e5c9..f848c608e8f1 100644
--- a/drivers/misc/arm-cla/Makefile
+++ b/drivers/misc/arm-cla/Makefile
@@ -7,6 +7,7 @@ arm-cla-y := \
 	cla-ops.o \
 	cla-regs.o \
 	cla-sched.o \
-	cla-topology.o
+	cla-topology.o \
+	cla-user.o
 
 obj-$(CONFIG_ARM_CLA) += arm-cla.o
diff --git a/drivers/misc/arm-cla/arm-cla-regs.h b/drivers/misc/arm-cla/arm-cla-regs.h
index fcd187ecb777..338b9e78b465 100644
--- a/drivers/misc/arm-cla/arm-cla-regs.h
+++ b/drivers/misc/arm-cla/arm-cla-regs.h
@@ -63,6 +63,8 @@
 					 CLA_STATUS_EXCEPT | \
 					 CLA_STATUS_SRMODE)
 
+#define CLA_AAIDR_1_0			(1ULL << 8)
+
 /* Standard accelerator registers */
 #define CLA_REG_IIDR			0x0000
 #define CLA_REG_DEVARCH			0x0001
diff --git a/drivers/misc/arm-cla/arm-cla.h b/drivers/misc/arm-cla/arm-cla.h
index 041d4a8d7e91..3dd783d0b1cc 100644
--- a/drivers/misc/arm-cla/arm-cla.h
+++ b/drivers/misc/arm-cla/arm-cla.h
@@ -45,6 +45,12 @@ struct cla_call_on_cpu {
 	struct kthread_work switch_ctx;
 };
 
+struct cla_accel_desc {
+	u64 iidr;
+	u64 devarch;
+	u64 revidr;
+};
+
 /**
  * struct cla_dev - CLA device
  *
@@ -57,6 +63,8 @@ struct cla_call_on_cpu {
  * @pg_offset:		Mmap offset of this device.
  * @iassizes:		Combined regstate of all accels.
  * @domain:		The domain this CLA belongs to.
+ * @aidr:		CLA Architecture ID.
+ * @accel_descs:	Accelerator ID registers.
  *
  * Mutable, only accessed under @lock:
  * @lock:		Protects the following members.
@@ -74,6 +82,8 @@ struct cla_dev {
 	unsigned long pg_offset;
 	unsigned long iassizes;
 	struct cla_domain *domain;
+	u64 aidr;
+	struct cla_accel_desc accel_descs[CLA_NUM_ACC];
 
 	struct mutex lock;
 	bool broken;
@@ -280,4 +290,7 @@ int cla_mtc_clear(struct cla_dev *dev);
 int cla_mtc_install(struct cla_dev *dev, pgd_t *pgd, unsigned long asid);
 int cla_mtc_uninstall(struct cla_dev *dev);
 
+int cla_user_init(void);
+void cla_user_exit(void);
+
 #endif /* _ARM_CLA_H_ */
diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-init.c
index 5335c55568ad..090efc6cc9b4 100644
--- a/drivers/misc/arm-cla/cla-init.c
+++ b/drivers/misc/arm-cla/cla-init.c
@@ -80,6 +80,7 @@ static int cla_reset_pmu(struct cla_dev *dev, unsigned int accid)
  */
 static int cla_dev_setup_accel(struct cla_dev *dev, unsigned int accid)
 {
+	struct cla_accel_desc *desc = &dev->accel_descs[accid];
 	u64 status;
 	u64 iassize;
 	u64 acap;
@@ -122,6 +123,20 @@ static int cla_dev_setup_accel(struct cla_dev *dev, unsigned int accid)
 		return 1;
 	}
 
+	/*
+	 * Cache some standard accelerator registers that user space may query
+	 * via ioctl from a remote CPU.
+	 */
+	ret = cla_op_regread(dev, accid, CLA_REG_IIDR, 1, &desc->iidr);
+	if (ret)
+		return ret;
+	ret = cla_op_regread(dev, accid, CLA_REG_DEVARCH, 1, &desc->devarch);
+	if (ret)
+		return ret;
+	ret = cla_op_regread(dev, accid, CLA_REG_REVIDR, 1, &desc->revidr);
+	if (ret)
+		return ret;
+
 	ret = cla_op_regread(dev, accid, CLA_REG_IASSIZE, 1, &iassize);
 	if (ret)
 		return ret;
@@ -234,6 +249,10 @@ static int cla_dev_setup(unsigned int cpu)
 	if (WARN_ON(smp_processor_id() != cpu || dev->cpu != cpu))
 		return -EINVAL;
 
+	dev->aidr = cla_reg_read(dev, CLA_REG_CLAAIDR);
+	if (dev->aidr != CLA_AAIDR_1_0)
+		return -EPROTONOSUPPORT;
+
 	/* Clear DATA and LRESP_DATANZ */
 	for (i = 0; i < CLA_NUM_DATA_REGS; i++)
 		cla_reg_write(dev, CLA_REG_DATA(i), 0);
@@ -453,8 +472,14 @@ static int __init cla_module_init(void)
 	}
 	cla_cpuhp_state = ret;
 
+	ret = cla_user_init();
+	if (ret)
+		goto err_cpuhp_remove;
+
 	return 0;
 
+err_cpuhp_remove:
+	cpuhp_remove_state(cla_cpuhp_state);
 err_driver_unregister:
 	platform_driver_unregister(&cla_driver);
 err_domains_free:
@@ -464,6 +489,7 @@ static int __init cla_module_init(void)
 
 static void __exit cla_module_exit(void)
 {
+	cla_user_exit();
 	cpuhp_remove_state(cla_cpuhp_state);
 	platform_driver_unregister(&cla_driver);
 	cla_domains_free();
diff --git a/drivers/misc/arm-cla/cla-user.c b/drivers/misc/arm-cla/cla-user.c
new file mode 100644
index 000000000000..415328a653b7
--- /dev/null
+++ b/drivers/misc/arm-cla/cla-user.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arm CLA driver - userspace interface
+ *
+ * Copyright 2026 Arm Limited.
+ */
+
+#include <linux/cdev.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "arm-cla.h"
+#include <uapi/linux/arm-cla.h>
+
+static struct class *cla_class;
+static dev_t cla_devt;
+
+#define dev_nospec(idx) array_index_nospec(idx, cla_nr_devs)
+#define accel_nospec(idx) array_index_nospec(idx, CLA_NUM_ACC)
+
+#define cla_for_each_mapped_domain(_vma, _domain)			\
+	for (unsigned long __pg = (_vma)->vm_pgoff;			\
+	     __pg < (_vma)->vm_pgoff + vma_pages(_vma) &&		\
+	     ((_domain) = cla_lut_pg[dev_nospec(__pg)]->domain);	\
+	     __pg = (_domain)->pg_offset + (_domain)->nr_devs)
+
+static long cla_ioctl_validate_param(struct arm_cla_param *param)
+{
+	int accel_id;
+	int dev_id;
+
+	switch (param->param) {
+	case ARM_CLA_PARAM_UABI_VERSION:
+	case ARM_CLA_PARAM_DEV_NR:
+		if (param->index != 0)
+			return -EINVAL;
+		break;
+	case ARM_CLA_PARAM_DEV_CPU_ID:
+	case ARM_CLA_PARAM_DEV_DOMAIN_ID:
+	case ARM_CLA_PARAM_DEV_PGOFF:
+	case ARM_CLA_PARAM_DEV_AIDR:
+	case ARM_CLA_PARAM_DEV_ACCELS:
+		if (param->index >= cla_nr_devs)
+			return -EINVAL;
+		break;
+	case ARM_CLA_PARAM_ACCEL_IIDR:
+	case ARM_CLA_PARAM_ACCEL_DEVARCH:
+	case ARM_CLA_PARAM_ACCEL_REVIDR:
+		dev_id = ARM_CLA_PARAM_INDEX_DEV(param->index);
+		accel_id = ARM_CLA_PARAM_INDEX_ACCEL(param->index);
+		if (dev_id >= cla_nr_devs || accel_id >= CLA_NUM_ACC)
+			return -EINVAL;
+		dev_id = dev_nospec(dev_id);
+		if ((cla_lut_pg[dev_id]->accelerators & BIT(accel_id)) == 0)
+			return -ENODEV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static long cla_ioctl_get_param(unsigned long arg)
+{
+	struct arm_cla_param __user *uparam = (void __user *)arg;
+	struct arm_cla_param param;
+	int accel_id;
+	int dev_id;
+	int ret;
+
+	if (copy_from_user(&param, uparam, sizeof(param)))
+		return -EFAULT;
+
+	ret = cla_ioctl_validate_param(&param);
+	if (ret)
+		return ret;
+
+	dev_id = dev_nospec(ARM_CLA_PARAM_INDEX_DEV(param.index));
+	accel_id = accel_nospec(ARM_CLA_PARAM_INDEX_ACCEL(param.index));
+
+	switch (param.param) {
+	case ARM_CLA_PARAM_UABI_VERSION:
+		param.value = ARM_CLA_UABI_VERSION;
+		break;
+	case ARM_CLA_PARAM_DEV_NR:
+		param.value = cla_nr_devs;
+		break;
+	case ARM_CLA_PARAM_DEV_CPU_ID:
+		param.value = cla_lut_pg[dev_id]->cpu;
+		break;
+	case ARM_CLA_PARAM_DEV_DOMAIN_ID:
+		param.value = cla_lut_pg[dev_id]->domain->id;
+		break;
+	case ARM_CLA_PARAM_DEV_PGOFF:
+		param.value = cla_lut_pg[dev_id]->pg_offset;
+		break;
+	case ARM_CLA_PARAM_DEV_AIDR:
+		param.value = cla_lut_pg[dev_id]->aidr;
+		break;
+	case ARM_CLA_PARAM_DEV_ACCELS:
+		param.value = cla_lut_pg[dev_id]->accelerators;
+		break;
+	case ARM_CLA_PARAM_ACCEL_IIDR:
+		param.value = cla_lut_pg[dev_id]->accel_descs[accel_id].iidr;
+		break;
+	case ARM_CLA_PARAM_ACCEL_DEVARCH:
+		param.value = cla_lut_pg[dev_id]->accel_descs[accel_id].devarch;
+		break;
+	case ARM_CLA_PARAM_ACCEL_REVIDR:
+		param.value = cla_lut_pg[dev_id]->accel_descs[accel_id].revidr;
+		break;
+	}
+
+	if (copy_to_user(uparam, &param, sizeof(param)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void cla_vma_open(struct vm_area_struct *vma)
+{
+	/*
+	 * A vma previously created with cla_file_mmap() has been duplicated
+	 * within the same mm (most likely due to mremap). While this could also
+	 * be called for duplication into a new mm (via fork), we set
+	 * VM_DONTCOPY on the original mmap, so this will never happen. So the
+	 * contexts covered by this new vma already exist.
+	 */
+	struct cla_domain *domain;
+
+	cla_for_each_mapped_domain(vma, domain)
+		cla_ctx_map(domain, vma->vm_mm, vma->vm_file);
+}
+
+static void cla_vma_close(struct vm_area_struct *vma)
+{
+	struct cla_domain *domain;
+
+	/* On munmap() or exit_mmap(), kill the context. */
+	cla_for_each_mapped_domain(vma, domain)
+		cla_ctx_unmap(domain, vma->vm_mm, vma->vm_file);
+}
+
+static vm_fault_t cla_vma_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct cla_domain *domain;
+	struct cla_dev *dev;
+	struct cla_ctx *ctx;
+	unsigned long pg;
+
+	/*
+	 * Reassignment needs mmap_lock, so we cannot wait while holding it.
+	 * Luckily, this flag is only missing in some exotic cases which do not
+	 * apply for this VM_IO | VM_PFNMAP vma. i.e. GUP without
+	 * FOLL_UNLOCKABLE or FOLL_NOWAIT or fixup_user_fault(unlocked=NULL),
+	 * used by futex fault-in path.
+	 */
+	if (WARN_ON(!(vmf->flags & FAULT_FLAG_ALLOW_RETRY)))
+		return VM_FAULT_SIGBUS;
+
+	pg = vma->vm_pgoff + ((vmf->address - vma->vm_start) >> PAGE_SHIFT);
+	dev = cla_lut_pg[pg];
+	domain = dev->domain;
+
+	mutex_lock(&domain->lock);
+	ctx = cla_domain_lookup_ctx(domain, vma->vm_mm, vma->vm_file);
+	if (WARN_ON(!ctx) || cla_ctx_is_dying(ctx) || domain->broken) {
+		mutex_unlock(&domain->lock);
+		return domain->broken ? VM_FAULT_SIGBUS : VM_FAULT_SIGSEGV;
+	}
+
+	/* If our ctx is the assigned one, map the device into memory. */
+	if (domain->assigned_ctx == ctx) {
+		vm_fault_t ret;
+
+		ret = vmf_insert_pfn(vma, vmf->address, dev->pfn);
+		mutex_unlock(&domain->lock);
+		return ret;
+	}
+
+	/* Enqueue if not already, starting current assignee's time slice. */
+	if (list_empty(&ctx->queue_node)) {
+		bool was_empty = list_empty(&domain->queued_ctxs);
+		unsigned long delay;
+
+		list_add_tail(&ctx->queue_node, &domain->queued_ctxs);
+		if (was_empty) {
+			delay = domain->assigned_ctx ? CLA_SLICE_MS : 0;
+			cla_domain_schedule_reassignment(domain, delay);
+		}
+	}
+
+	mutex_unlock(&domain->lock);
+
+	/* If waiting is not permitted, return indicating we need to retry. */
+	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
+		return VM_FAULT_RETRY;
+
+	/*
+	 * Drop the fault lock prior to sleeping and return VM_FAULT_RETRY when
+	 * we wake up to rerun the fault. We must get the ctx while sleeping to
+	 * prevent it from being freed while we are asleep on the contained wait
+	 * queue.
+	 */
+	cla_ctx_get(ctx);
+	release_fault_lock(vmf);
+	wait_event_interruptible(ctx->waitq,
+				 READ_ONCE(domain->assigned_ctx) == ctx ||
+				 cla_ctx_is_dying(ctx) ||
+				 READ_ONCE(domain->broken));
+	cla_ctx_put(ctx);
+	return VM_FAULT_RETRY;
+}
+
+static int cla_vma_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	/*
+	 * Forbid splitting cla mappings to prevent refcount leaks.
+	 * cla_file_mmap()/cla_vma_open() track a context per domain mapped by
+	 * the vma. If there were fewer domains mapped by the vma at
+	 * cla_vma_close() then contexts would get leaked.
+	 */
+	return -EINVAL;
+}
+
+static const struct vm_operations_struct cla_vma_ops = {
+	.open = cla_vma_open,
+	.close = cla_vma_close,
+	.fault = cla_vma_fault,
+	.may_split = cla_vma_may_split,
+};
+
+static int cla_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long nr_pages = vma_pages(vma);
+	struct cla_domain *rollback;
+	struct cla_domain *domain;
+	struct cla_ctx *ctx;
+
+	/* Ensure the requested mapping is within range. */
+	if (!nr_pages)
+		return -EINVAL;
+	if (vma->vm_pgoff >= cla_nr_devs)
+		return -EINVAL;
+	if (nr_pages > cla_nr_devs - vma->vm_pgoff)
+		return -EINVAL;
+
+	/* Only allow shared RW mappings. Nothing else makes sense for CLA. */
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_READ))
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_WRITE))
+		return -EINVAL;
+	if (vma->vm_flags & VM_EXEC)
+		return -EINVAL;
+
+	/*
+	 * Iterate over each domain covered by the vma and get-or-alloc its
+	 * context. If any fails, we need to rollback with a put.
+	 */
+	cla_for_each_mapped_domain(vma, domain) {
+		ctx = cla_ctx_map(domain, vma->vm_mm, vma->vm_file);
+		if (IS_ERR(ctx)) {
+			cla_for_each_mapped_domain(vma, rollback) {
+				if (rollback == domain)
+					return PTR_ERR(ctx);
+				cla_ctx_unmap(rollback, vma->vm_mm,
+					      vma->vm_file);
+			}
+		}
+	}
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP | VM_DONTEXPAND |
+			  VM_IO | VM_PFNMAP, VM_MAYEXEC);
+	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
+	vma->vm_ops = &cla_vma_ops;
+
+	return 0;
+}
+
+static long cla_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	switch (cmd) {
+	case ARM_CLA_IOCTL_GET_PARAM:
+		return cla_ioctl_get_param(arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations cla_fops = {
+	.owner = THIS_MODULE,
+	.mmap = cla_file_mmap,
+	.unlocked_ioctl = cla_file_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = cla_file_ioctl,
+#endif
+};
+
+static char *cla_devnode(const struct device *dev, umode_t *mode)
+{
+	if (mode)
+		*mode = 0666;
+	return NULL;
+}
+
+int __init cla_user_init(void)
+{
+	int ret;
+
+	cla_class = class_create("arm-cla");
+	if (IS_ERR(cla_class))
+		return PTR_ERR(cla_class);
+	cla_class->devnode = cla_devnode;
+
+	ret = register_chrdev(0, KBUILD_MODNAME, &cla_fops);
+	if (ret < 0)
+		goto err_class_destroy;
+
+	cla_devt = MKDEV(ret, 0);
+
+	if (IS_ERR(device_create(cla_class, NULL, cla_devt, NULL, "cla"))) {
+		ret = -ENODEV;
+		goto err_unregister_chrdev;
+	}
+
+	return 0;
+
+err_unregister_chrdev:
+	unregister_chrdev(MAJOR(cla_devt), KBUILD_MODNAME);
+err_class_destroy:
+	class_destroy(cla_class);
+	return ret;
+}
+
+void __exit cla_user_exit(void)
+{
+	device_destroy(cla_class, cla_devt);
+	unregister_chrdev(MAJOR(cla_devt), KBUILD_MODNAME);
+	class_destroy(cla_class);
+}
diff --git a/include/uapi/linux/arm-cla.h b/include/uapi/linux/arm-cla.h
new file mode 100644
index 000000000000..6357fdb9df8a
--- /dev/null
+++ b/include/uapi/linux/arm-cla.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * UAPI definitions for the CLA character device.
+ */
+
+#ifndef _UAPI_LINUX_CLA_H
+#define _UAPI_LINUX_CLA_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define ARM_CLA_UABI_VERSION	1
+#define ARM_CLA_IOC_MAGIC	'C'
+
+/**
+ * define ARM_CLA_IOCTL_GET_PARAM - Get the value of a parameter.
+ *
+ * ioctl command whose argument is a pointer to &struct arm_cla_param.
+ * &arm_cla_param->param and &arm_cla_param->index are input parameters.
+ * &arm_cla_param->value is an output parameter.
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - Unrecognised param or param does not support GET
+ * * Return code as defined for param
+ */
+#define ARM_CLA_IOCTL_GET_PARAM	\
+	_IOWR(ARM_CLA_IOC_MAGIC, 0x00, struct arm_cla_param)
+
+/**
+ * define ARM_CLA_PARAM_UABI_VERSION - CLA driver UABI version (RO).
+ *
+ * &arm_cla_param->index must be 0.
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - index not 0
+ */
+#define ARM_CLA_PARAM_UABI_VERSION	0
+
+/**
+ * define ARM_CLA_PARAM_DEV_NR - Number of attached CLA devices (RO).
+ *
+ * &arm_cla_param->index must be 0.
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - index not 0
+ */
+#define ARM_CLA_PARAM_DEV_NR		1
+
+/**
+ * define ARM_CLA_PARAM_DEV_CPU_ID - CPU to which the CLA is attached (RO).
+ *
+ * &arm_cla_param->index is the dev_id in range (0, DEV_NR - 1).
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - dev_id (index) not in range
+ */
+#define ARM_CLA_PARAM_DEV_CPU_ID	2
+
+/**
+ * define ARM_CLA_PARAM_DEV_DOMAIN_ID - Domain to which the CLA belongs (RO).
+ *
+ * &arm_cla_param->index is the dev_id in range (0, DEV_NR - 1).
+ *
+ * A CLA domain contains a set of CLA devices whose accelerators can communicate
+ * with each other. All CLA devices within a CLA domain are atomically assigned
+ * to a single context at a time.
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - dev_id (index) not in range
+ */
+#define ARM_CLA_PARAM_DEV_DOMAIN_ID	3
+
+/**
+ * define ARM_CLA_PARAM_DEV_PGOFF - CLA's ``mmap()`` page offset (RO).
+ *
+ * &arm_cla_param->index is the dev_id in range (0, DEV_NR - 1).
+ *
+ * The page offset at which the selected CLA device's register page is exposed
+ * through ``mmap()``.
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - dev_id (index) not in range
+ */
+#define ARM_CLA_PARAM_DEV_PGOFF		4
+
+/**
+ * define ARM_CLA_PARAM_DEV_AIDR - CLA Architecture Identification Register
+ * (RO).
+ *
+ * &arm_cla_param->index is the dev_id in range (0, DEV_NR - 1).
+ *
+ * The CLA Architecture Identification Register is used to obtain version
+ * information of the CLA Programming model.
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - dev_id (index) not in range
+ */
+#define ARM_CLA_PARAM_DEV_AIDR		5
+
+/**
+ * define ARM_CLA_PARAM_DEV_ACCELS - Mask of CLA's attached accelerators (RO).
+ *
+ * &arm_cla_param->index is the dev_id in range (0, DEV_NR - 1).
+ *
+ * A bitmask describing which accelerator slots are attached on the selected CLA
+ * device. A CLA may have up to 8 attached accelerators, each with an accel_id
+ * in the range (0, 7), each with a corresponding bit in the bitmask.
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - dev_id (index) not in range
+ */
+#define ARM_CLA_PARAM_DEV_ACCELS	6
+
+/**
+ * define ARM_CLA_PARAM_ACCEL_IIDR - Accelerator IIDR register (RO).
+ *
+ * &arm_cla_param->index is ARM_CLA_PARAM_ACCEL_INDEX(accel_id, dev_id).
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - dev_id not in range
+ * * %-EINVAL - accel_id not in range
+ * * %-ENODEV - accel_id not attached to CLA
+ */
+#define ARM_CLA_PARAM_ACCEL_IIDR	7
+
+/**
+ * define ARM_CLA_PARAM_ACCEL_DEVARCH - Accelerator DEVARCH register (RO).
+ *
+ * &arm_cla_param->index is ARM_CLA_PARAM_ACCEL_INDEX(accel_id, dev_id).
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - dev_id not in range
+ * * %-EINVAL - accel_id not in range
+ * * %-ENODEV - accel_id not attached to CLA
+ */
+#define ARM_CLA_PARAM_ACCEL_DEVARCH	8
+
+/**
+ * define ARM_CLA_PARAM_ACCEL_REVIDR - Accelerator REVIDR register (RO).
+ *
+ * &arm_cla_param->index is ARM_CLA_PARAM_ACCEL_INDEX(accel_id, dev_id).
+ *
+ * Return:
+ * * %0 - OK
+ * * %-EINVAL - dev_id not in range
+ * * %-EINVAL - accel_id not in range
+ * * %-ENODEV - accel_id not attached to CLA
+ */
+#define ARM_CLA_PARAM_ACCEL_REVIDR	9
+
+/**
+ * ARM_CLA_PARAM_ACCEL_INDEX() - encode index for specific accelerator.
+ * @accel_id:	accelerator id in the range (0, 7).
+ * @dev_id:	CLA device id in the range (0, DEV_NR - 1).
+ *
+ * Return: encoded index for use in &arm_cla_param->index.
+ */
+#define ARM_CLA_PARAM_ACCEL_INDEX(accel_id, dev_id) \
+	(((accel_id) << 24) | (dev_id))
+
+/**
+ * ARM_CLA_PARAM_INDEX_ACCEL() - extract accel_id from index.
+ * @index:	Encoded index as returned by ARM_CLA_PARAM_ACCEL_INDEX()
+ *
+ * Return: extracted accel_id.
+ */
+#define ARM_CLA_PARAM_INDEX_ACCEL(index) (((index) >> 24) & 0xff)
+
+/**
+ * ARM_CLA_PARAM_INDEX_DEV() - extract dev_id from index.
+ * @index:	Encoded index as returned by ARM_CLA_PARAM_ACCEL_INDEX()
+ *
+ * Return: extracted dev_id.
+ */
+#define ARM_CLA_PARAM_INDEX_DEV(index) ((index) & 0xffffff)
+
+/**
+ * struct arm_cla_param - Get/Set CLA parameters.
+ */
+struct arm_cla_param {
+	/**
+	 * @param: Param selector - One of the ARM_CLA_PARAM_* values.
+	 */
+	__u64 param;
+
+	/**
+	 * @index: Index for params that have multiple instances.
+	 */
+	__u64 index;
+
+	/**
+	 * @value: Param value.
+	 */
+	__u64 value;
+};
+
+#endif /* _UAPI_LINUX_CLA_H */
-- 
2.43.0

