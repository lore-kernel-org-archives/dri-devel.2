Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE457CD98D8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2909F10F529;
	Fri, 12 Jun 2026 13:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KOpV0D7I";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226D110F521;
 Fri, 12 Jun 2026 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781272462; x=1812808462;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kILQ85veuIrcULzo1G8jHYeL8gmTmoLkPT7LMDIHXQ0=;
 b=KOpV0D7IUx4+tCpANCtCMykhLyvIVAUfMmL1OOvwaaLK9vWuzDROrnKg
 hilhKzrZyEezYNVcsve/BHCVzlq+EYMwn4o8Lxt9uPMgeDCbcbyiYGC6P
 eTOYlJq9KpDqqASgA2xgd44Htpcc2tSxZnV0rjTvD8MrpI7boz48/jPWB
 c/jH5b1N0dbGyH9WyKh35DPfH6Q+eMTpa2pndW1KHCisuj9ldDfYIxrdb
 KYG6OcNcqvygg/20/0l1hdtcuAUADE+1qppVvdo9zLuitX8PlX7Of9ans
 UTuhUYVeFsPaRXCNZCwwQBMybljX+fHcv3bxOF5nIJC7CaweyxltdHY/S w==;
X-CSE-ConnectionGUID: qVitL+JmS2eIDFj0F6zPnA==
X-CSE-MsgGUID: VghXZSodRW2isuUXzBrjTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82163307"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82163307"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:22 -0700
X-CSE-ConnectionGUID: 3CyBZ6NlS2WgezIvRIyQvw==
X-CSE-MsgGUID: cle2O9uAQtGl90O/1adiGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="242446553"
Received: from slindbla-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.68])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:18 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 John Falkowski <john.falkowski@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Lahtinen Joonas <joonas.lahtinen@linux.intel.com>,
 David Howells <dhowells@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, LMKL <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] drm/xe: Add fault injection for rebind worker -ENOSPC
Date: Fri, 12 Jun 2026 15:53:38 +0200
Message-ID: <20260612135340.116100-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
References: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add fault injection support using the kernel fault injection
infrastructure to inject -ENOSPC early in the success path of
preempt_rebind_work_func(), before xe_svm_notifier_lock() is taken,
testing the error handling paths without interference from real
resource exhaustion.

Injection is restricted to restartable VMs. When triggered, the
worker deactivates the VM (rebind_deactivated).
Upcoming patches will then also post an error event to userspace.

Enable via debugfs:

  echo 1 > /sys/kernel/debug/dri/0/fail_rebind/times
  echo 100 > /sys/kernel/debug/dri/0/fail_rebind/probability

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c |  4 +++-
 drivers/gpu/drm/xe/xe_vm.c      | 32 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_vm.h      |  5 +++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 22b471303984..1a92c52ccd83 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -35,8 +35,8 @@
 #ifdef CONFIG_DRM_XE_DEBUG
 #include "xe_bo_evict.h"
 #include "xe_migrate.h"
-#include "xe_vm.h"
 #endif
+#include "xe_vm.h"
 
 DECLARE_FAULT_ATTR(gt_reset_failure);
 DECLARE_FAULT_ATTR(inject_csc_hw_error);
@@ -612,6 +612,8 @@ void xe_debugfs_register(struct xe_device *xe)
 
 	fault_create_debugfs_attr("fail_gt_reset", root, &gt_reset_failure);
 
+	xe_vm_debugfs_register(root);
+
 	if (IS_SRIOV_PF(xe))
 		xe_sriov_pf_debugfs_register(xe, root);
 	else if (IS_SRIOV_VF(xe))
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 86ed8f31a219..b69a2e5bd9c9 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -18,6 +18,9 @@
 #include <linux/kthread.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
 
 #include <generated/xe_wa_oob.h>
 
@@ -43,6 +46,17 @@
 #include "xe_vm_madvise.h"
 #include "xe_wa.h"
 
+#ifdef CONFIG_FAULT_INJECTION
+static DECLARE_FAULT_ATTR(rebind_enospc);
+
+static void xe_vm_register_fault_attrs(struct dentry *root)
+{
+	fault_create_debugfs_attr("fail_rebind", root, &rebind_enospc);
+}
+#else
+static inline void xe_vm_register_fault_attrs(struct dentry *root) {}
+#endif
+
 static struct drm_gem_object *xe_vm_obj(struct xe_vm *vm)
 {
 	return vm->gpuvm.r_obj;
@@ -529,6 +543,13 @@ static void preempt_rebind_work_func(struct work_struct *w)
 		goto out_unlock;
 	}
 
+#ifdef CONFIG_FAULT_INJECTION
+	if (xe_vm_is_restartable(vm) && should_fail(&rebind_enospc, 1)) {
+		err = -ENOSPC;
+		goto out_unlock;
+	}
+#endif
+
 #define retry_required(__tries, __vm) \
 	(IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT) ? \
 	(!(__tries)++ || __xe_vm_userptr_needs_repin(__vm)) : \
@@ -5042,3 +5063,14 @@ void xe_vm_remove_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q)
 	}
 	up_write(&vm->exec_queues.lock);
 }
+
+#ifdef CONFIG_DEBUG_FS
+/**
+ * xe_vm_debugfs_register() - Register xe_vm debugfs entries
+ * @root: debugfs root dentry for this device
+ */
+void xe_vm_debugfs_register(struct dentry *root)
+{
+	xe_vm_register_fault_attrs(root);
+}
+#endif
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 9ee44599cacd..0f9a38d97bf6 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -216,6 +216,11 @@ int xe_vm_restart_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file);
 void xe_vm_close_and_put(struct xe_vm *vm);
 
+#ifdef CONFIG_DEBUG_FS
+struct dentry;
+void xe_vm_debugfs_register(struct dentry *root);
+#endif
+
 static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
 {
 	return vm->flags & XE_VM_FLAG_FAULT_MODE;
-- 
2.54.0

