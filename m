Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C29606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GE+AG/zh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E26310E379;
	Mon, 16 Nov 2026 06:28:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E991410E2ED;
 Mon, 16 Nov 2026 06:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794810496; x=1826346496;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BDTi+UKoCd1erxY4Qm4Yp9kN6O4JtZvdx6Gg6lYAF9s=;
 b=GE+AG/zhZ1nHgUrxjaTMIGuOdoWEwqrFfSNgC6Nv9/0z7cdx/NpgV7OK
 z3anHVzk7ZTep3KYwyGWdxPxV7BqmkSYZtTpC2+pl0WWGv4r0niR8a7SQ
 MR+PWB+OBbzA3u5TZSZQF0Zk6M4E/Zllq1eqpMebTAO8il21RZgZqfW5k
 dj7/sZ9ZiOOUGkDAIPlLy/w8y65ruQ6KIpFQ2RvAYTRwPQJ9Sra+uUur2
 GOYNdDO741ReGysNVr310E05saCwhHffusdN2kOQbU/Fo8Cq3Bon+unjc
 GxGdO5GsR5+Yu762VmFxGbXvBsJ+gWrhbol1KscbBuga7y5woLAnj0TI4 Q==;
X-CSE-ConnectionGUID: H5TzJfVWQ+G1QiLNPM2sew==
X-CSE-MsgGUID: +PltkyvYSfKyGOlGPeTF1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3575724"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3575724"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 22:28:16 -0800
X-CSE-ConnectionGUID: knpeAh6USpKkOgTS9VOeLw==
X-CSE-MsgGUID: NsluOjfJS4iwOVQFaiqGeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9344687"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 22:28:14 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 sanjay.kumar.yadav@intel.com, tejas.upadhyay@intel.com,
 daniel.charles@intel.com
Subject: [PATCH v3 0/3] drm/xe: Fix VM teardown and migration queue recovery
Date: Mon, 16 Nov 2026 11:58:01 +0530
Message-ID: <20261116062804.1242511-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Exec queue destruction is asynchronous, and user queues can outlive
the VM handle. Closing the VM before those queues finish cleanup can
remove mappings that are still in use.

This series marks the VM as closing to reject new work, then keeps
its mappings until the tracked queues are freed. It also holds a
device reference across final VM destruction.

File close keeps the existing synchronous scheduling-disable wait.
There is no additional wait for the queue count to reach zero.
If tracked queues remain, VM close is deferred until their cleanup
completes.

User bind jobs are allowed to drain during file close and queue
destroy. The VM-owned bind queue is not counted and remains alive
until xe_vm_close() has waited for pending BOOKKEEP fences.

This series is based on the FD close cleanup changes in [1].

[1] https://patchwork.freedesktop.org/series/175996/

Changes in v2:
- Reduce the series to four patches following review.
- Run deferred VM close and final VM destruction on the
  module-lifetime destroy workqueue.
- Use a shared queue-wait budget during file close and defer teardown
  when queues remain.

Changes in v3:
- Rebase on the "FD close cleanup for XE" series and reduce this series
  to three patches.
- Move the module-lifetime workqueue change into patch 1 to avoid
  self-deadlock when the worker drops the last device reference.
- Check VM state before acknowledging cached faults and hold vm->lock
  through successful reply submission.
- Preserve the original fault details for errors detected before
  acknowledgment and report failed prefetches.
- Reject exec requests on closing VMs before userptr pinning,
  out-sync signaling and rebind.
- Use zero wait on file close and document that internal bind queue
  cleanup can also defer VM teardown.
- Let user bind jobs drain in the exec queue destroy ioctl.
- Count user bind queues under vm->lock before VM close can proceed.
- Track whether a user bind queue owns a close count and balance it
  during final queue destruction.
- Make xe_vm_kill_bind_queues() static and remove the unused wait header.

Arvind Yadav (3):
  drm/xe: Hold a device reference across deferred VM destruction
  drm/xe: Mark VMs as closing before queue cleanup
  drm/xe: Defer VM teardown until exec queue cleanup completes

 drivers/gpu/drm/xe/xe_device.c           |  26 ++-
 drivers/gpu/drm/xe/xe_exec.c             |   9 ++
 drivers/gpu/drm/xe/xe_exec_queue.c       |  39 ++++-
 drivers/gpu/drm/xe/xe_exec_queue_types.h |  11 ++
 drivers/gpu/drm/xe/xe_pagefault.c        |  87 +++++++++--
 drivers/gpu/drm/xe/xe_svm.c              |   3 +-
 drivers/gpu/drm/xe/xe_vm.c               | 191 ++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_vm.h               |  13 +-
 drivers/gpu/drm/xe/xe_vm_types.h         |  17 ++
 drivers/gpu/drm/xe/xe_wait_user_fence.c  |   5 +
 10 files changed, 355 insertions(+), 46 deletions(-)

-- 
2.43.0

