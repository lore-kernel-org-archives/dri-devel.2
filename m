Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560CD606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDa3G2Fy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB0410F323;
	Mon,  9 Nov 2026 13:57:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE71410F2E4;
 Mon,  9 Nov 2026 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232620; x=1825768620;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k1XNQeFkU9mejSxymtoSFi50WMG0RlzoFd7ouzxZOFc=;
 b=kDa3G2FypoimGKVqfVLc4fPJ0GgEQYgChCu507D7aKJy9fdgU7xAMsTD
 Ajej9B5htjW0eBsvtjIKFUqIhmiDNKFTgPkDiXq6Fi9IC/OLGlR+PYMSf
 lSfrdibNMwvfphbliVuZ9HZlNrkFtqfb+P6mfIXaAour9IBE+7XMxcFAf
 lWDHGduqkmS7k4YTHVNITTV3GvhNQ+KF0+feVLweJyW0KSfbvN34B+4YY
 aPd9u7bMz1m34MVPXixtjCSofK/pNMQ61BIGI782GE/xrntC69+1fWR72
 TPOooVicMgElJjmfHFbs8rAocCi8YXUgxaqhl30xFkf4HR9SgqZrUkblX Q==;
X-CSE-ConnectionGUID: uttoBPMKTuWL7ic4S1G84w==
X-CSE-MsgGUID: tVNdv0I/Tn+J8aRhYAKJpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850825"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850825"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:59 -0800
X-CSE-ConnectionGUID: h2yoevj3RN6ijGfnqXp9QQ==
X-CSE-MsgGUID: ZXusBc5HTWeYTwnR3mGKjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202750"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:54 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Christoph Manszewski <christoph.manszewski@intel.com>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 10/20] drm/xe: Introduce ADD_DEBUG_DATA and REMOVE_DEBUG_DATA
 vm bind ops
Date: Mon,  9 Nov 2026 15:55:35 +0200
Message-ID: <20261109135549.4128280-11-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christoph Manszewski <christoph.manszewski@intel.com>

Make it possible to add and remove per vm debug data, which can be used
to annotate vm ranges (using pseudopaths) or to associate them with
a file which can carry arbitrary debug data (e.g. binary instruction to
code line mapping). The debug data is kept separate from the vmas. Each
address can be associated with only one debug data entry i.e. debug data
entries cannot overlap. Each entry is atomic, so the creation address
and range have to be passed in order to remove it.

For debug data manipulation only the 'op' and 'extensions' fields from
'struct drm_xe_vm_bind_op' are used. All required parameters are passed
through 'struct drm_xe_vm_bind_op_ext_debug_data' and a valid instance
should be present in the extension chain pointed to by the 'extensions'
field.

Debug data will be accessible through the eudebug event interface,
introduced in the following patch. An alternative way to access debug data
using debugfs, without relying on eudebug, will be proposed as a follow-up
to the eudebug series.

v2: enforce empty path on unmap (Joonas, Mika)
v3: - fix overflow, deny zero ranges, null str for empty check (Sashiko)
    - fix TOCTOUs and list handling issues (Sashiko)
v4: - check full path for zero, overflow check (Sashiko)
    - don't unwind failed extensions, use op commit (Sashiko)
    - restore removes by relink, remove fallible alloc (Sashiko)

Signed-off-by: Christoph Manszewski <christoph.manszewski@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 drivers/gpu/drm/xe/Makefile              |   1 +
 drivers/gpu/drm/xe/xe_debug_data.c       | 388 +++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_debug_data.h       |  22 ++
 drivers/gpu/drm/xe/xe_debug_data_types.h |  26 ++
 drivers/gpu/drm/xe/xe_vm.c               | 226 ++++++++++++-
 drivers/gpu/drm/xe/xe_vm_types.h         |  31 ++
 include/uapi/drm/xe_drm.h                |  88 ++++-
 7 files changed, 777 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_debug_data.c
 create mode 100644 drivers/gpu/drm/xe/xe_debug_data.h
 create mode 100644 drivers/gpu/drm/xe/xe_debug_data_types.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index d42620e10c26..aee129a48040 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -36,6 +36,7 @@ xe-y += xe_bb.o \
 	xe_bo.o \
 	xe_bo_evict.o \
 	xe_cpu_bind.o \
+	xe_debug_data.o \
 	xe_dep_scheduler.o \
 	xe_devcoredump.o \
 	xe_device.o \
diff --git a/drivers/gpu/drm/xe/xe_debug_data.c b/drivers/gpu/drm/xe/xe_debug_data.c
new file mode 100644
index 000000000000..f01b28ff496d
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_debug_data.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#include "xe_debug_data.h"
+#include "xe_debug_data_types.h"
+#include "xe_vm.h"
+
+const char *xe_debug_data_pseudo_path_to_string(u64 pseudopath)
+{
+	switch (pseudopath) {
+	case DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_MODULE_AREA:
+		return "[module_area]";
+	case DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_SBA_AREA:
+		return "[sba_area]";
+	case DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_SIP_AREA:
+		return "[sip_area]";
+	default:
+		return "[unknown]";
+	}
+}
+
+static const char *
+debug_data_path_str(u64 flags, u64 pseudopath, const char *pathname)
+{
+	return (flags & DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO) ?
+		xe_debug_data_pseudo_path_to_string(pseudopath) : pathname;
+}
+
+static bool
+debug_data_overlaps(const struct drm_xe_vm_bind_op_ext_debug_data *a,
+		    const struct xe_debug_data *b)
+{
+	u64 a_end, b_end;
+
+	/*
+	 * Ranges that wrap u64 are rejected by debug_data_ext_validate()
+	 * before we get here, so neither side should ever overflow. Be
+	 * defensive anyway and report overlap, which makes callers reject
+	 * the bind rather than act on a bogus range.
+	 */
+	if (check_add_overflow(a->addr, a->range, &a_end) ||
+	    check_add_overflow(b->addr, b->range, &b_end))
+		return true;
+
+	return a->addr < b_end && b->addr < a_end;
+}
+
+static bool
+debug_data_matches(const struct drm_xe_vm_bind_op_ext_debug_data *a,
+		   const struct xe_debug_data *b)
+{
+	return a->addr == b->addr && a->range == b->range;
+}
+
+static bool
+debug_data_is_empty(const struct drm_xe_vm_bind_op_ext_debug_data *ext)
+{
+	return !ext->flags && !ext->offset && !ext->reserved &&
+		mem_is_zero(ext->pathname, sizeof(ext->pathname));
+}
+
+/*
+ * Validate a debug data extension copied from userspace.
+ *
+ * This is the single source of truth for what the extension is allowed
+ * to contain. It is called from the check phase and again from the
+ * commit phase (on a freshly-copied snapshot) so that the kernel never
+ * trusts the result of an earlier copy_from_user(): see Sashiko's TOCTOU
+ * comment on v1.
+ */
+static int
+debug_data_ext_validate(struct xe_device *xe, u32 operation,
+			const struct drm_xe_vm_bind_op_ext_debug_data *ext)
+{
+	u64 end;
+
+	if (XE_IOCTL_DBG(xe, operation != DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA &&
+			 operation != DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, ext->reserved))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, check_add_overflow(ext->addr, ext->range, &end)))
+		return -EINVAL;
+
+	/* Remove takes only addr+range; everything else must be zero. */
+	if (operation == DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA) {
+		if (XE_IOCTL_DBG(xe, !debug_data_is_empty(ext)))
+			return -EINVAL;
+		if (XE_IOCTL_DBG(xe, !ext->range))
+			return -EINVAL;
+		return 0;
+	}
+
+	/* Add. */
+	if (XE_IOCTL_DBG(xe, !ext->range))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, ext->flags & ~DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO))
+		return -EINVAL;
+
+	if (ext->flags & DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO) {
+		if (XE_IOCTL_DBG(xe, ext->offset))
+			return -EINVAL;
+		if (XE_IOCTL_DBG(xe,
+				 ext->pseudopath < DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_MODULE_AREA ||
+				 ext->pseudopath > DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_SIP_AREA))
+			return -EINVAL;
+		if (XE_IOCTL_DBG(xe, !mem_is_zero(ext->pathname + sizeof(ext->pseudopath),
+						  sizeof(ext->pathname) -
+						  sizeof(ext->pseudopath))))
+			return -EINVAL;
+	} else {
+		if (XE_IOCTL_DBG(xe, !ext->pathname[0]))
+			return -EINVAL;
+		if (XE_IOCTL_DBG(xe, strnlen(ext->pathname, sizeof(ext->pathname)) >=
+				 sizeof(ext->pathname)))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+int xe_debug_data_check_extension(struct xe_vm *vm, u32 operation, u64 extension)
+{
+	const void __user * const address = u64_to_user_ptr(extension);
+	struct drm_xe_vm_bind_op_ext_debug_data *ext;
+	int ret;
+
+	ext = kzalloc_obj(*ext, GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	if (copy_from_user(ext, address, sizeof(*ext))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = debug_data_ext_validate(vm->xe, operation, ext);
+	/*
+	 * Intentionally no list walk here: any check we make against
+	 * vm->debug_data.list outside the commit critical section can be
+	 * invalidated before commit runs (concurrent ioctls). The commit
+	 * phase re-validates and re-checks under the list lock; this
+	 * function exists only for early rejection of syntactically
+	 * malformed input.
+	 */
+out:
+	kfree(ext);
+	return ret;
+}
+
+static int xe_debug_data_add(struct xe_vm *vm, struct xe_vma_op *vma_op,
+			     struct drm_xe_vm_bind_op_ext_debug_data *ext)
+{
+	const bool pseudo = ext->flags & DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO;
+	/* validate() has checked that the path is NUL terminated */
+	const size_t path_len = pseudo ? 0 : strlen(ext->pathname);
+	struct xe_debug_data *dd, *iter;
+	int ret = 0;
+
+	vm_dbg(&vm->xe->drm,
+	       "ADD_DEBUG_DATA: addr=0x%016llx, range=0x%016llx, offset=0x%08llx, flags=0x%016llx, path=%s\n",
+	       ext->addr, ext->range, ext->offset, ext->flags,
+	       debug_data_path_str(ext->flags, ext->pseudopath, ext->pathname));
+
+	/* The pathname would otherwise make every entry a kmalloc-8k one */
+	dd = kzalloc_flex(*dd, pathname, path_len + 1, GFP_KERNEL_ACCOUNT);
+	if (!dd)
+		return -ENOMEM;
+
+	dd->addr = ext->addr;
+	dd->range = ext->range;
+	dd->flags = ext->flags;
+	dd->offset = ext->offset;
+
+	if (pseudo)
+		dd->pseudopath = ext->pseudopath;
+	else
+		memcpy(dd->pathname, ext->pathname, path_len);
+
+	/*
+	 * Overlap-check-and-insert atomically under the list lock.
+	 * Doing the check in a separate critical section would race
+	 * with concurrent adds on the same vm.
+	 */
+	mutex_lock(&vm->debug_data.lock);
+	list_for_each_entry(iter, &vm->debug_data.list, link) {
+		if (debug_data_matches(ext, iter)) {
+			ret = -EEXIST;
+			goto err_unlock;
+		}
+		if (debug_data_overlaps(ext, iter)) {
+			ret = -EINVAL;
+			goto err_unlock;
+		}
+	}
+	list_add_tail(&dd->link, &vm->debug_data.list);
+	mutex_unlock(&vm->debug_data.lock);
+
+	/*
+	 * Borrowed reference for the unwind path and for the bind event.
+	 * The list owns it from here, so this must not be freed through
+	 * the op.
+	 */
+	vma_op->modify_debug_data.added = dd;
+
+	vma_op->flags |= XE_VMA_OP_COMMITTED;
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&vm->debug_data.lock);
+	kfree(dd);
+	return ret;
+}
+
+static int xe_debug_data_remove(struct xe_vm *vm, struct xe_vma_op *vma_op,
+				struct drm_xe_vm_bind_op_ext_debug_data *ext)
+{
+	struct xe_debug_data *dd, *found = NULL;
+
+	vm_dbg(&vm->xe->drm,
+	       "REMOVE_DEBUG_DATA: addr=0x%016llx, range=0x%016llx\n",
+	       ext->addr, ext->range);
+
+	mutex_lock(&vm->debug_data.lock);
+	list_for_each_entry(dd, &vm->debug_data.list, link) {
+		if (debug_data_matches(ext, dd)) {
+			list_del(&dd->link);
+			found = dd;
+			break;
+		}
+	}
+	mutex_unlock(&vm->debug_data.lock);
+
+	if (!found) {
+		drm_dbg(&vm->xe->drm,
+			"Debug data to remove not found: addr=0x%llx range=0x%llx\n",
+			ext->addr, ext->range);
+		return -ENOENT;
+	}
+
+	vma_op->modify_debug_data.removed = found;
+	vma_op->flags |= XE_VMA_OP_COMMITTED;
+
+	return 0;
+}
+
+int xe_debug_data_process_extension(struct xe_vm *vm, struct drm_gpuva_ops *ops,
+				    u32 operation, u64 extension)
+{
+	const void __user * const address = u64_to_user_ptr(extension);
+	struct drm_xe_vm_bind_op_ext_debug_data *ext;
+	struct xe_vma_op *vma_op;
+	struct drm_gpuva_op *op;
+	int ret;
+
+	ext = kzalloc_obj(*ext, GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	if (copy_from_user(ext, address, sizeof(*ext))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	/*
+	 * Re-validate the freshly-copied extension. The check phase
+	 * cannot be trusted: userspace may have mutated the backing
+	 * memory between check and commit (TOCTOU). All decisions below
+	 * are made against this kernel-local copy.
+	 */
+	ret = debug_data_ext_validate(vm->xe, operation, ext);
+	if (ret)
+		goto out;
+
+	op = drm_gpuva_first_op(ops);
+	if (XE_WARN_ON(op != drm_gpuva_last_op(ops))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vma_op = gpuva_op_to_vma_op(op);
+
+	if (vma_op->subop == XE_VMA_SUBOP_ADD_DEBUG_DATA)
+		ret = xe_debug_data_add(vm, vma_op, ext);
+	else if (vma_op->subop == XE_VMA_SUBOP_REMOVE_DEBUG_DATA)
+		ret = xe_debug_data_remove(vm, vma_op, ext);
+	else
+		ret = -EINVAL;
+
+out:
+	kfree(ext);
+	return ret;
+}
+
+static int xe_debug_data_op_unwind_add(struct xe_vm *vm, struct xe_vma_op *vma_op)
+{
+	const struct xe_debug_data *op_data = vma_op->modify_debug_data.added;
+	struct xe_debug_data *dd, *found = NULL;
+
+	if (!op_data)
+		return 0;
+
+	vm_dbg(&vm->xe->drm,
+	       "Reverting debug data add: addr=0x%016llx, range=0x%016llx, offset=0x%08llx, flags=0x%016llx, path=%s\n",
+	       op_data->addr, op_data->range, op_data->offset, op_data->flags,
+	       debug_data_path_str(op_data->flags, op_data->pseudopath, op_data->pathname));
+
+	mutex_lock(&vm->debug_data.lock);
+	list_for_each_entry(dd, &vm->debug_data.list, link) {
+		if (dd->addr == op_data->addr && dd->range == op_data->range) {
+			list_del(&dd->link);
+			found = dd;
+			break;
+		}
+	}
+	mutex_unlock(&vm->debug_data.lock);
+
+	if (!found) {
+		/*
+		 * Internal invariant: we are unwinding an add that
+		 * previously succeeded, so the entry must be on the
+		 * list unless somebody else removed it behind our
+		 * back. There is no such "somebody else" in the
+		 * current locking design.
+		 */
+		drm_warn(&vm->xe->drm,
+			 "unwind add: entry missing addr=0x%llx range=0x%llx\n",
+			 op_data->addr, op_data->range);
+		return -ENOENT;
+	}
+
+	kfree(found);
+	vma_op->modify_debug_data.added = NULL;
+
+	return 0;
+}
+
+static int xe_debug_data_op_unwind_remove(struct xe_vm *vm, struct xe_vma_op *vma_op)
+{
+	struct xe_debug_data *dd = vma_op->modify_debug_data.removed;
+
+	if (!dd)
+		return 0;
+
+	vm_dbg(&vm->xe->drm,
+	       "Reverting debug data remove: addr=0x%016llx, range=0x%016llx, offset=0x%08llx, flags=0x%016llx, path=%s\n",
+	       dd->addr, dd->range, dd->offset, dd->flags,
+	       debug_data_path_str(dd->flags, dd->pseudopath, dd->pathname));
+
+	mutex_lock(&vm->debug_data.lock);
+	list_add_tail(&dd->link, &vm->debug_data.list);
+	mutex_unlock(&vm->debug_data.lock);
+
+	vma_op->modify_debug_data.removed = NULL;
+
+	return 0;
+}
+
+int xe_debug_data_op_unwind(struct xe_vm *vm, struct xe_vma_op *vma_op)
+{
+	switch (vma_op->subop) {
+	case XE_VMA_SUBOP_ADD_DEBUG_DATA:
+		return xe_debug_data_op_unwind_add(vm, vma_op);
+	case XE_VMA_SUBOP_REMOVE_DEBUG_DATA:
+		return xe_debug_data_op_unwind_remove(vm, vma_op);
+	default:
+		drm_err(&vm->xe->drm, "Invalid debug data subop %d\n", vma_op->subop);
+		return -EINVAL;
+	}
+}
+
+void xe_debug_data_destroy(struct xe_vm *vm)
+{
+	struct xe_debug_data *dd, *tmp;
+
+	mutex_lock(&vm->debug_data.lock);
+	list_for_each_entry_safe(dd, tmp, &vm->debug_data.list, link) {
+		list_del(&dd->link);
+		kfree(dd);
+	}
+	mutex_unlock(&vm->debug_data.lock);
+}
diff --git a/drivers/gpu/drm/xe/xe_debug_data.h b/drivers/gpu/drm/xe/xe_debug_data.h
new file mode 100644
index 000000000000..0c0089a427a0
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_debug_data.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#ifndef _XE_DEBUG_DATA_H_
+#define _XE_DEBUG_DATA_H_
+
+#include <linux/types.h>
+
+struct drm_gpuva_ops;
+struct xe_vm;
+struct xe_vma_op;
+
+const char *xe_debug_data_pseudo_path_to_string(u64 pseudopath);
+int xe_debug_data_check_extension(struct xe_vm *vm, u32 operation, u64 extension);
+int xe_debug_data_process_extension(struct xe_vm *vm, struct drm_gpuva_ops *ops, u32 operation,
+				    u64 extension);
+int xe_debug_data_op_unwind(struct xe_vm *vm, struct xe_vma_op *vma_op);
+void xe_debug_data_destroy(struct xe_vm *vm);
+
+#endif /* _XE_DEBUG_DATA_H_ */
diff --git a/drivers/gpu/drm/xe/xe_debug_data_types.h b/drivers/gpu/drm/xe/xe_debug_data_types.h
new file mode 100644
index 000000000000..b495510b41d6
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_debug_data_types.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _XE_DEBUG_DATA_TYPES_H_
+#define _XE_DEBUG_DATA_TYPES_H_
+
+#include <linux/list.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+struct xe_debug_data {
+	struct list_head link;
+	u64 addr;
+	u64 range;
+	u64 flags;
+	u64 offset;
+	union {
+		u64 pseudopath;
+		/* NUL terminated, allocated to the length of the path */
+		DECLARE_FLEX_ARRAY(char, pathname);
+	};
+};
+
+#endif /* _XE_DEBUG_DATA_TYPES_H_ */
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index b9b851adc9bf..138ccdf87eb2 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -26,6 +26,7 @@
 #include "xe_assert.h"
 #include "xe_bo.h"
 #include "xe_cpu_bind.h"
+#include "xe_debug_data.h"
 #include "xe_device.h"
 #include "xe_drm_client.h"
 #include "xe_eudebug.h"
@@ -1457,10 +1458,29 @@ static struct drm_gpuva_op *xe_vm_op_alloc(void)
 	return &op->base;
 }
 
+static void xe_vm_op_free(struct drm_gpuva_op *__op)
+{
+	struct xe_vma_op *op = gpuva_op_to_vma_op(__op);
+
+	/*
+	 * Only REMOVE_DEBUG_DATA ops carry a detached list object here.
+	 * modify_debug_data overlaps map/unmap/prefetch in the union, so
+	 * it must not be touched for any other op type. NULL-safe: set
+	 * only on a committed remove that was not unwound.
+	 */
+	if (__op->op == DRM_GPUVA_OP_DRIVER &&
+	    (op->subop == XE_VMA_SUBOP_ADD_DEBUG_DATA ||
+	     op->subop == XE_VMA_SUBOP_REMOVE_DEBUG_DATA))
+		kfree(op->modify_debug_data.removed);
+
+	kfree(op);
+}
+
 static void xe_vm_free(struct drm_gpuvm *gpuvm);
 
 static const struct drm_gpuvm_ops gpuvm_ops = {
 	.op_alloc = xe_vm_op_alloc,
+	.op_free = xe_vm_op_free,
 	.vm_bo_validate = xe_gpuvm_validate,
 	.vm_free = xe_vm_free,
 };
@@ -1780,6 +1800,9 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 	xe_vm_init_prove_locking(xe, vm);
 	xe_range_fence_tree_init(&vm->rftree);
 
+	INIT_LIST_HEAD(&vm->debug_data.list);
+	mutex_init(&vm->debug_data.lock);
+
 	vm->pt_ops = &xelp_pt_ops;
 
 	/*
@@ -1920,6 +1943,7 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 		xe_svm_close(vm);
 	xe_svm_fini(vm);
 err_no_resv:
+	mutex_destroy(&vm->debug_data.lock);
 	mutex_destroy(&vm->snap_mutex);
 	xe_range_fence_tree_fini(&vm->rftree);
 	ttm_lru_bulk_move_fini(&xe->ttm, &vm->lru_bulk_move);
@@ -2077,6 +2101,8 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 
 	xe_range_fence_tree_fini(&vm->rftree);
 
+	xe_debug_data_destroy(vm);
+
 	xe_vm_put(vm);
 }
 
@@ -2094,6 +2120,7 @@ static void vm_destroy_work_func(struct work_struct *w)
 	if (xe_vm_in_preempt_fence_mode(vm))
 		flush_work(&vm->preempt.rebind_work);
 
+	mutex_destroy(&vm->debug_data.lock);
 	mutex_destroy(&vm->snap_mutex);
 
 	if (vm->flags & XE_VM_FLAG_LR_MODE)
@@ -2418,6 +2445,7 @@ static void prep_vma_destroy(struct xe_vm *vm, struct xe_vma *vma,
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG_VM)
 static void print_op(struct xe_device *xe, struct drm_gpuva_op *op)
 {
+	struct xe_vma_op *vma_op;
 	struct xe_vma *vma;
 
 	switch (op->op) {
@@ -2452,6 +2480,12 @@ static void print_op(struct xe_device *xe, struct drm_gpuva_op *op)
 		vm_dbg(&xe->drm, "PREFETCH: addr=0x%016llx, range=0x%016llx",
 		       (ULL)xe_vma_start(vma), (ULL)xe_vma_size(vma));
 		break;
+	case DRM_GPUVA_OP_DRIVER:
+		vma_op = gpuva_op_to_vma_op(op);
+		if (vma_op->subop != XE_VMA_SUBOP_ADD_DEBUG_DATA &&
+		    vma_op->subop != XE_VMA_SUBOP_REMOVE_DEBUG_DATA)
+			drm_warn(&xe->drm, "Unexpected vma sub op: %d", vma_op->subop);
+		break;
 	default:
 		drm_warn(&xe->drm, "NOT POSSIBLE\n");
 	}
@@ -2502,6 +2536,7 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
 	struct drm_gpuva_ops *ops;
 	struct drm_gpuva_op *__op;
 	struct drm_gpuvm_bo *vm_bo;
+	struct xe_vma_op *vma_op;
 	u64 range_start = addr;
 	u64 range_end = addr + range;
 	int err;
@@ -2558,6 +2593,24 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
 		drm_gpuvm_bo_put(vm_bo);
 		xe_bo_unlock(bo);
 		break;
+	case DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA:
+	case DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA:
+		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
+		if (!ops)
+			return ERR_PTR(-ENOMEM);
+
+		INIT_LIST_HEAD(&ops->list);
+		vma_op = kzalloc_obj(*vma_op, GFP_KERNEL);
+		if (!vma_op) {
+			kfree(ops);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		vma_op->base.op = DRM_GPUVA_OP_DRIVER;
+		vma_op->subop = operation == DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA ?
+			XE_VMA_SUBOP_ADD_DEBUG_DATA : XE_VMA_SUBOP_REMOVE_DEBUG_DATA;
+		list_add_tail(&vma_op->base.entry, &ops->list);
+		break;
 	default:
 		drm_warn(&vm->xe->drm, "NOT POSSIBLE\n");
 		ops = ERR_PTR(-EINVAL);
@@ -2869,6 +2922,11 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
 	case DRM_GPUVA_OP_PREFETCH:
 		op->flags |= XE_VMA_OP_COMMITTED;
 		break;
+	case DRM_GPUVA_OP_DRIVER:
+		if (op->subop != XE_VMA_SUBOP_ADD_DEBUG_DATA &&
+		    op->subop != XE_VMA_SUBOP_REMOVE_DEBUG_DATA)
+			drm_warn(&vm->xe->drm, "Unexpected vma sub op: %d", op->subop);
+		break;
 	default:
 		drm_warn(&vm->xe->drm, "NOT POSSIBLE\n");
 	}
@@ -3071,6 +3129,11 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 				xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask, 1);
 
 			break;
+		case DRM_GPUVA_OP_DRIVER:
+			if (op->subop != XE_VMA_SUBOP_ADD_DEBUG_DATA &&
+			    op->subop != XE_VMA_SUBOP_REMOVE_DEBUG_DATA)
+				drm_warn(&vm->xe->drm, "Unexpected vma sub op: %d", op->subop);
+			break;
 		default:
 			drm_warn(&vm->xe->drm, "NOT POSSIBLE\n");
 		}
@@ -3150,6 +3213,13 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
 	case DRM_GPUVA_OP_PREFETCH:
 		/* Nothing to do */
 		break;
+	case DRM_GPUVA_OP_DRIVER:
+		if (op->subop != XE_VMA_SUBOP_ADD_DEBUG_DATA &&
+		    op->subop != XE_VMA_SUBOP_REMOVE_DEBUG_DATA)
+			drm_warn(&vm->xe->drm, "Unexpected vma sub op: %d", op->subop);
+		else if (post_commit)
+			xe_debug_data_op_unwind(vm, op);
+		break;
 	default:
 		drm_warn(&vm->xe->drm, "NOT POSSIBLE\n");
 	}
@@ -3505,6 +3575,11 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 		}
 		break;
 	}
+	case DRM_GPUVA_OP_DRIVER:
+		if (op->subop != XE_VMA_SUBOP_ADD_DEBUG_DATA &&
+		    op->subop != XE_VMA_SUBOP_REMOVE_DEBUG_DATA)
+			drm_warn(&vm->xe->drm, "Unexpected vma sub op: %d", op->subop);
+		break;
 	default:
 		drm_warn(&vm->xe->drm, "NOT POSSIBLE\n");
 	}
@@ -3704,6 +3779,11 @@ static void op_add_ufence(struct xe_vm *vm, struct xe_vma_op *op,
 	case DRM_GPUVA_OP_PREFETCH:
 		vma_add_ufence(gpuva_to_vma(op->base.prefetch.va), ufence);
 		break;
+	case DRM_GPUVA_OP_DRIVER:
+		if (op->subop != XE_VMA_SUBOP_ADD_DEBUG_DATA &&
+		    op->subop != XE_VMA_SUBOP_REMOVE_DEBUG_DATA)
+			drm_warn(&vm->xe->drm, "Unexpected vma sub op: %d", op->subop);
+		break;
 	default:
 		drm_warn(&vm->xe->drm, "NOT POSSIBLE\n");
 	}
@@ -3791,6 +3871,89 @@ ALLOW_ERROR_INJECTION(vm_bind_ioctl_ops_execute, ERRNO);
 #define XE_64K_PAGE_MASK 0xffffull
 #define ALL_DRM_XE_SYNCS_FLAGS (DRM_XE_SYNCS_FLAG_WAIT_FOR_OP)
 
+#define MAX_USER_EXTENSIONS	16
+
+typedef int (*xe_vm_bind_user_extension_check_fn)(struct xe_vm *vm, u32 operation, u64 extension);
+
+typedef int (*xe_vm_bind_user_extension_process_fn)(struct xe_vm *vm, struct drm_gpuva_ops *ops,
+						    u32 operation, u64 extension);
+
+static const xe_vm_bind_user_extension_check_fn vm_bind_extension_check_funcs[] = {
+	[DRM_XE_VM_BIND_OP_EXTENSION_DEBUG_DATA] = xe_debug_data_check_extension,
+};
+
+static const xe_vm_bind_user_extension_process_fn vm_bind_extension_process_funcs[] = {
+	[DRM_XE_VM_BIND_OP_EXTENSION_DEBUG_DATA] = xe_debug_data_process_extension,
+};
+
+static int __vm_bind_op_user_extensions(struct xe_vm *vm, struct drm_gpuva_ops *ops,
+					u32 operation, u64 extensions)
+{
+	struct xe_device *xe = vm->xe;
+	struct drm_xe_user_extension ext;
+	int debug_data_count = 0;
+	int ext_count = 0;
+	int err;
+	u32 idx;
+
+	while (extensions) {
+		u64 __user *address = u64_to_user_ptr(extensions);
+
+		if (XE_IOCTL_DBG(xe, ++ext_count >= MAX_USER_EXTENSIONS))
+			return -E2BIG;
+
+		err = copy_from_user(&ext, address, sizeof(ext));
+		if (XE_IOCTL_DBG(xe, err))
+			return -EFAULT;
+
+		if (XE_IOCTL_DBG(xe, operation != DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA &&
+				 operation != DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA &&
+				 ext.name == DRM_XE_VM_BIND_OP_EXTENSION_DEBUG_DATA) ||
+		    XE_IOCTL_DBG(xe, ext.name == DRM_XE_VM_BIND_OP_EXTENSION_DEBUG_DATA &&
+				 ++debug_data_count > 1))
+			return -EINVAL;
+
+		if (XE_IOCTL_DBG(xe, ext.pad) ||
+		    XE_IOCTL_DBG(xe, ext.name > DRM_XE_VM_BIND_OP_EXTENSION_DEBUG_DATA))
+			return -EINVAL;
+
+		if (!ops) {
+			idx = array_index_nospec(ext.name,
+						 ARRAY_SIZE(vm_bind_extension_check_funcs));
+			err = vm_bind_extension_check_funcs[idx](vm, operation, extensions);
+		} else {
+			idx = array_index_nospec(ext.name,
+						 ARRAY_SIZE(vm_bind_extension_process_funcs));
+			err = vm_bind_extension_process_funcs[idx](vm, ops, operation,
+								   extensions);
+		}
+
+		if (XE_IOCTL_DBG(xe, err))
+			return err;
+
+		extensions = ext.next_extension;
+	}
+
+	/* A debug data op is described by its extension, so it must have one */
+	if (XE_IOCTL_DBG(xe, (operation == DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA ||
+			      operation == DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA) &&
+			 !debug_data_count))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vm_bind_ioctl_check_user_extensions(struct xe_vm *vm, u32 operation, u64 extensions)
+{
+	return __vm_bind_op_user_extensions(vm, NULL, operation, extensions);
+}
+
+static int vm_bind_ioctl_process_user_extensions(struct xe_vm *vm, struct drm_gpuva_ops *ops,
+						 u32 operation, u64 extensions)
+{
+	return __vm_bind_op_user_extensions(vm, ops, operation, extensions);
+}
+
 static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				    struct drm_xe_vm_bind *args,
 				    struct drm_xe_vm_bind_op **bind_ops)
@@ -3842,6 +4005,7 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 			DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR;
 		bool is_decompress = flags & DRM_XE_VM_BIND_FLAG_DECOMPRESS;
 		u16 pat_index = (*bind_ops)[i].pat_index;
+		u64 extensions = (*bind_ops)[i].extensions;
 		u16 coh_mode;
 		bool comp_en;
 
@@ -3872,7 +4036,7 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 			goto free_bind_ops;
 		}
 
-		if (XE_IOCTL_DBG(xe, op > DRM_XE_VM_BIND_OP_PREFETCH) ||
+		if (XE_IOCTL_DBG(xe, op > DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA) ||
 		    XE_IOCTL_DBG(xe, flags & ~SUPPORTED_FLAGS) ||
 		    XE_IOCTL_DBG(xe, obj && (is_null || is_cpu_addr_mirror)) ||
 		    XE_IOCTL_DBG(xe, obj_offset && (is_null ||
@@ -3924,7 +4088,9 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 		    XE_IOCTL_DBG(xe, addr & ~PAGE_MASK) ||
 		    XE_IOCTL_DBG(xe, range & ~PAGE_MASK) ||
 		    XE_IOCTL_DBG(xe, !range &&
-				 op != DRM_XE_VM_BIND_OP_UNMAP_ALL)) {
+				 op != DRM_XE_VM_BIND_OP_UNMAP_ALL &&
+				 op != DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA &&
+				 op != DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA)) {
 			err = -EINVAL;
 			goto free_bind_ops;
 		}
@@ -3935,6 +4101,25 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 			err = -EOPNOTSUPP;
 			goto free_bind_ops;
 		}
+
+		/*
+		 * A debug data op is described entirely by its extension.
+		 * Require the rest of the op to be zero, so that it can be
+		 * given a meaning later without breaking callers.
+		 */
+		if (XE_IOCTL_DBG(xe, (op == DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA ||
+				      op == DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA) &&
+				 (obj || obj_offset || addr || range || flags ||
+				  (*bind_ops)[i].pad || (*bind_ops)[i].pad2 ||
+				  !mem_is_zero((*bind_ops)[i].reserved,
+					       sizeof((*bind_ops)[i].reserved))))) {
+			err = -EINVAL;
+			goto free_bind_ops;
+		}
+
+		err = vm_bind_ioctl_check_user_extensions(vm, op, extensions);
+		if (err)
+			goto free_bind_ops;
 	}
 
 	return 0;
@@ -3969,6 +4154,19 @@ static int vm_bind_ioctl_signal_fences(struct xe_vm *vm,
 	return err;
 }
 
+static bool vm_bind_ops_have_debug_data(const struct drm_xe_vm_bind_op *bind_ops,
+					u32 num_binds)
+{
+	u32 i;
+
+	for (i = 0; i < num_binds; i++)
+		if (bind_ops[i].op == DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA ||
+		    bind_ops[i].op == DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA)
+			return true;
+
+	return false;
+}
+
 static void xe_vma_ops_init(struct xe_vma_ops *vops, struct xe_vm *vm,
 			    struct xe_exec_queue *q,
 			    struct xe_sync_entry *syncs, u32 num_syncs)
@@ -4198,6 +4396,22 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		goto free_syncs;
 	}
 
+	/*
+	 * Debug data ops take effect as the ioctl processes them, so they
+	 * cannot wait for in-fences. A bind of only debug data ops also
+	 * ends in vm_bind_ioctl_signal_fences(), which would reject the
+	 * in-fences only after the debug data change can no longer be
+	 * unwound.
+	 */
+	if (num_syncs && vm_bind_ops_have_debug_data(bind_ops, args->num_binds)) {
+		for (i = 0; i < num_syncs; i++) {
+			if (XE_IOCTL_DBG(xe, syncs[i].fence)) {
+				err = -EOPNOTSUPP;
+				goto free_syncs;
+			}
+		}
+	}
+
 	if (!args->num_binds) {
 		err = -ENODATA;
 		goto free_syncs;
@@ -4214,11 +4428,17 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		u64 obj_offset = bind_ops[i].obj_offset;
 		u32 prefetch_region = bind_ops[i].prefetch_mem_region_instance;
 		u16 pat_index = bind_ops[i].pat_index;
+		u64 extensions = bind_ops[i].extensions;
 
 		ops[i] = vm_bind_ioctl_ops_create(vm, &vops, bos[i], obj_offset,
 						  addr, range, op, flags,
 						  prefetch_region, pat_index);
-		if (IS_ERR(ops[i])) {
+
+		if (!IS_ERR(ops[i]) && extensions) {
+			err = vm_bind_ioctl_process_user_extensions(vm, ops[i], op, extensions);
+			if (err)
+				goto unwind_ops;
+		} else if (IS_ERR(ops[i])) {
 			err = PTR_ERR(ops[i]);
 			ops[i] = NULL;
 			goto unwind_ops;
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index fb9305124679..361e26ee2b46 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -15,6 +15,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/scatterlist.h>
 
+#include "xe_debug_data_types.h"
 #include "xe_device_types.h"
 #include "xe_pt_types.h"
 #include "xe_range_fence.h"
@@ -423,6 +424,15 @@ struct xe_vm {
 	bool batch_invalidate_tlb;
 	/** @xef: Xe file handle for tracking this VM's drm client */
 	struct xe_file *xef;
+
+	/** @debug_data: track debug_data mapped to vm */
+	struct {
+		/** @list: list of debug data items for this vm */
+		struct list_head list;
+
+		/** @lock: guards access to the debug data list */
+		struct mutex lock;
+	} debug_data;
 };
 
 /** struct xe_vma_op_map - VMA map operation */
@@ -496,6 +506,21 @@ struct xe_vma_op_prefetch_range {
 	struct drm_pagemap *dpagemap;
 };
 
+/** struct xe_vma_op_modify_debug_data - debug data altering operation */
+struct xe_vma_op_modify_debug_data {
+	/**
+	 * @added: entry published on vm->debug_data.list, owned by the
+	 * list and only borrowed here. Cleared once unwind frees it.
+	 */
+	struct xe_debug_data *added;
+
+	/**
+	 * @removed: detached from the list. Relinked if the ioctl is unwound,
+	 * freed with the op otherwise.
+	 */
+	struct xe_debug_data *removed;
+};
+
 /** enum xe_vma_op_flags - flags for VMA operation */
 enum xe_vma_op_flags {
 	/** @XE_VMA_OP_COMMITTED: VMA operation committed */
@@ -512,6 +537,10 @@ enum xe_vma_subop {
 	XE_VMA_SUBOP_MAP_RANGE,
 	/** @XE_VMA_SUBOP_UNMAP_RANGE: Unmap range */
 	XE_VMA_SUBOP_UNMAP_RANGE,
+	/** @XE_VMA_SUBOP_ADD_DEBUG_DATA: Add debug data to vm */
+	XE_VMA_SUBOP_ADD_DEBUG_DATA,
+	/** @XE_VMA_SUBOP_REMOVE_DEBUG_DATA: Remove debug data from vm */
+	XE_VMA_SUBOP_REMOVE_DEBUG_DATA,
 };
 
 /** struct xe_vma_op - VMA operation */
@@ -540,6 +569,8 @@ struct xe_vma_op {
 		struct xe_vma_op_unmap_range unmap_range;
 		/** @prefetch_range: VMA prefetch range operation specific data */
 		struct xe_vma_op_prefetch_range prefetch_range;
+		/** @modify_debug_data: debug_data operation specific data */
+		struct xe_vma_op_modify_debug_data modify_debug_data;
 	};
 };
 
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 759e76b7ac52..750141aa734d 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -6,6 +6,8 @@
 #ifndef _UAPI_XE_DRM_H_
 #define _UAPI_XE_DRM_H_
 
+#include <linux/limits.h>
+
 #include "drm.h"
 
 #if defined(__cplusplus)
@@ -1021,6 +1023,73 @@ struct drm_xe_vm_destroy {
 	__u64 reserved[2];
 };
 
+/**
+ * struct drm_xe_vm_bind_op_ext_debug_data - debug data extension struct for
+ * :c:type:`drm_xe_vm_bind_op`
+ *
+ * The GPU VM can be annotated by issuing a bind operation with the
+ * :c:member:`drm_xe_vm_bind_op.op` set to %DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA or
+ * %DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA. Each such operation has to provide a
+ * :c:type:`drm_xe_vm_bind_op_ext_debug_data` extension, which describes the
+ * debug data to add or remove.
+ *
+ * This extension can either point to a file that contains relevant debug data
+ * or annotate the VM range with a pseudopath by setting the
+ * %DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO flag and providing one of the supported
+ * pseudopath values:
+ *
+ *  - %DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_MODULE_AREA
+ *  - %DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_SBA_AREA
+ *  - %DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_SIP_AREA
+ *
+ * Debug data operations take effect as the ioctl processes them, they are not
+ * ordered against earlier work on the bind exec queue. A
+ * &DRM_IOCTL_XE_VM_BIND carrying a debug data operation therefore does not
+ * support in-fences: any &struct drm_xe_sync without %DRM_XE_SYNC_FLAG_SIGNAL
+ * fails the ioctl with -EOPNOTSUPP.
+ */
+struct drm_xe_vm_bind_op_ext_debug_data {
+	/** @base: Base user extension */
+	struct drm_xe_user_extension base;
+
+	/** @addr: Address of the debug data mapping */
+	__u64 addr;
+
+	/** @range: Range of the debug data mapping */
+	__u64 range;
+
+#define DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO (1 << 0)
+	/** @flags: Debug data flags */
+	__u64 flags;
+
+	/**
+	 * @offset: Offset into the debug data file, MBZ when
+	 * %DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO is set
+	 */
+	__u64 offset;
+
+	/** @reserved: Reserved */
+	__u64 reserved;
+
+	union {
+#define DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_MODULE_AREA	0x1
+#define DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_SBA_AREA	0x2
+#define DRM_XE_VM_BIND_DEBUG_DATA_PSEUDO_SIP_AREA	0x3
+		/**
+		 * @pseudopath: Pseudopath used when
+		 * %DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO is set, the rest
+		 * of the union MBZ then
+		 */
+		__u64 pseudopath;
+
+		/**
+		 * @pathname: Path to the debug data file, NUL terminated and
+		 * not empty
+		 */
+		char pathname[PATH_MAX];
+	};
+};
+
 /**
  * struct drm_xe_vm_bind_op - run bind operations
  *
@@ -1030,6 +1099,8 @@ struct drm_xe_vm_destroy {
  *  - %DRM_XE_VM_BIND_OP_MAP_USERPTR
  *  - %DRM_XE_VM_BIND_OP_UNMAP_ALL
  *  - %DRM_XE_VM_BIND_OP_PREFETCH
+ *  - %DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA
+ *  - %DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA
  *
  * and the @flags can be:
  *  - %DRM_XE_VM_BIND_FLAG_READONLY - Setup the page tables as read-only
@@ -1081,7 +1152,14 @@ struct drm_xe_vm_destroy {
  *    the memory region advised by madvise.
  */
 struct drm_xe_vm_bind_op {
-	/** @extensions: Pointer to the first extension struct, if any */
+#define DRM_XE_VM_BIND_OP_EXTENSION_DEBUG_DATA	0
+	/**
+	 * @extensions: Pointer to the first extension struct, if any. The
+	 * only extension is %DRM_XE_VM_BIND_OP_EXTENSION_DEBUG_DATA, which is
+	 * required by, and only valid for, %DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA
+	 * and %DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA. Any other extension, or
+	 * an extension on another operation, is rejected.
+	 */
 	__u64 extensions;
 
 	/**
@@ -1135,7 +1213,11 @@ struct drm_xe_vm_bind_op {
 	 * attributes likely do not apply.  Simply leaving as zero is one
 	 * option (still a valid pat_index). Same applies to
 	 * DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR bindings as for such mapping
-	 * there is no actual memory being mapped.
+	 * there is no actual memory being mapped, and to the
+	 * %DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA and
+	 * %DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA operations, which annotate a
+	 * range rather than map anything: the value is ignored for them, so
+	 * zero is fine.
 	 */
 	__u16 pat_index;
 
@@ -1174,6 +1256,8 @@ struct drm_xe_vm_bind_op {
 #define DRM_XE_VM_BIND_OP_MAP_USERPTR	0x2
 #define DRM_XE_VM_BIND_OP_UNMAP_ALL	0x3
 #define DRM_XE_VM_BIND_OP_PREFETCH	0x4
+#define DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA	0x5
+#define DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA	0x6
 	/** @op: Bind operation to perform */
 	__u32 op;
 
-- 
2.53.0

