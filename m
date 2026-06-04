Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2FBCD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E719113E97;
	Thu,  4 Jun 2026 09:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nlmhCvSg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A0C2112734;
 Thu,  4 Jun 2026 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566626; x=1812102626;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aAPx22Ny3wz3OgUpip50T1pHgH3WI6BxcUfQ2dk5TMg=;
 b=nlmhCvSgAHkN22gV6NCDxht3u26tvksOi78q+GJTu7hE1EwcN4UMQCiP
 mgfTcTRakHOzU3G5PsiQTtACPfyhO1XNVkxERDRIlYv6xozmc3VtKkNCL
 VqaRz83l1XSpFuc1FaZbzE/mZtVzbCPEgBTCB6rGKSfQlsiDVSVGqSu3k
 ccp9dRRSgmWOKfSKUs0MEg5MJk8f7Ux+oaK9Kpe8LRIqTbfu0LUq3qTMq
 x+y4jj81c5Ul4nKZQLPndpQu19ohgQ533gtaFNfMkYkQExsr+10DlbWvr
 1OgcxbwXmiqkjOY1jwEGAbY8T1700Yfcd7hrG9Z5v3ud1tyNkJmDMrBk4 Q==;
X-CSE-ConnectionGUID: pZ5HkrzXQTyUsM+e8tzc0g==
X-CSE-MsgGUID: kj9FN4S4TKu/mw5hKAkMvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810509"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="98810509"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:26 -0700
X-CSE-ConnectionGUID: mOATsgRBQc2t122NJgL/XA==
X-CSE-MsgGUID: y1Rrn1XqQIGHQ8tb8C/mZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="282602320"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:23 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [RFC v3 0/7] drm/xe/svm: Add MMU notifier-based madvise autoreset on
 munmap
Date: Thu,  4 Jun 2026 15:20:05 +0530
Message-ID: <20260604095012.367231-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
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

This series implements automatic reset of MADVISE-managed GPU memory
attributes when userspace unmaps memory. Non-default attributes are
reset when CPU mappings are removed, preventing them from persisting
across later mmap() operations.

MMU interval notifiers detect munmap on CPU-only VMAs (not yet
GPU-faulted) and queue a worker to reset attributes. GPU-touched
VMAs continue using the existing SVM path.

Key aspects:
 - cpu_autoreset_active tracks CPU-only vs GPU-touched state.
 - MMU notifier callbacks do not allocate. work_struct is embedded in
   xe_madvise_notifier and initialized at ioctl time.
 - Unmap events are coalesced in the callback and processed by a worker.
 - teardown_rwsem serializes VM teardown against notifier callbacks.
 - maple_tree tracks notifier ranges and supports deduplication.
 - MMU notifier registration is performed outside vm->lock.

Patch organization:
 1. Track cpu_autoreset_active in xe_vma.
 2. Preserve state across GPUVA operations.
 3. Clear state on first GPU fault.
 4. Add MMU notifier and worker infrastructure.
 5. Disable madvise notifier after GPU touch.
 6. Wire notifiers into VM lifecycle.
 7. Fix partial unmap attribute reset.

Changes in v2:
 - Move runtime state to xe_vma bool cpu_autoreset_active. (Matt)
 - Embed work_struct in xe_madvise_notifier. (Thomas)
 - Coalesce overlapping munmap events.
 - Replace closing state with teardown_rwsem. (Matt)
 - Use maple_tree for notifier tracking. (Matt)
 - Register notifiers outside vm->lock.
 - Add xe_vma_effective_create_flags() and fix REMAP split handling.
 - Move GPU-touch handling to the successful pagefault path. (Matt)
 - Use plain bool active in notifier. (Matt)
 - Add lockdep assertions for vm->lock.

Changes in v3:
 - Add kernel-doc and lockdep_assert_held to
   xe_vma_has_cpu_autoreset_active(). (Matt)
 - Guard cpu_autoreset_active assignment to CPU_ADDR_MIRROR VMAs only. (Matt)
 - Drop lockdep_assert_held_write from xe_svm_handle_pagefault. (Matt)
 - Rework GPU-touch handling after page faults. (Matt)
 - Rework notifier lifetime handling and teardown.
 - Keep exact-match notifier deactivation for split VMA handling.
 - Move notifier_ranges allocation before VMA mutation.
 - Keep a VM-owned notifier list for teardown.
 - Coalesce pending unmap ranges and reset only CPU holes in the worker.
 - Clear MADV_AUTORESET on notifier registration failure.
 - Coalesce partial_unmap range via min/max instead of blind overwrite. (Matt)
 - Restore range_debug() in xe_svm_garbage_collector_add_range(). (Matt)
 - Update partial_unmap under garbage_collector.lock.
 - Continue processing queued ranges on non-fatal set_default_attr failures.
 - Annotate lockless notifier->active access with READ_ONCE/WRITE_ONCE.

Arvind Yadav (6):
  drm/xe/vm: Track CPU_AUTORESET state in xe_vma
  drm/xe/vm: Preserve cpu_autoreset_active across GPUVA operations
  drm/xe/svm: Clear CPU_AUTORESET_ACTIVE on first GPU fault
  drm/xe/vm: Add madvise autoreset notifier worker
  drm/xe/vm: Disable madvise notifier on GPU touch
  drm/xe/vm: Wire MADVISE_AUTORESET notifiers into VM lifecycle

Himal Prasad Ghimiray (1):
  drm/xe/svm: Correct memory attribute reset for partial unmap

 drivers/gpu/drm/xe/xe_pagefault.c  |  13 +-
 drivers/gpu/drm/xe/xe_svm.c        | 102 ++++-
 drivers/gpu/drm/xe/xe_svm.h        |  10 +
 drivers/gpu/drm/xe/xe_vm.c         |  58 ++-
 drivers/gpu/drm/xe/xe_vm.h         |  28 ++
 drivers/gpu/drm/xe/xe_vm_madvise.c | 651 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_vm_madvise.h |   9 +
 drivers/gpu/drm/xe/xe_vm_types.h   |  82 ++++
 8 files changed, 928 insertions(+), 25 deletions(-)

-- 
2.43.0

