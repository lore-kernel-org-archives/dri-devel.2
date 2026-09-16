Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E83BC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2835910E15A;
	Wed, 16 Sep 2026 09:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Fu6vB2BB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AF010E012;
 Wed, 16 Sep 2026 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789552428; x=1821088428;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Dwy9++SJOcmjUnrpk+4ySIGIXT32eeYLt5SPslpyuxc=;
 b=Fu6vB2BB5VCxBtHG6tjVN8NubK+SqWRH9v14oFSYs52kSA8IxklX9SVn
 2NPgO+umHEVgqKjWdNpLlVXdk67QYrT4JFhWYE3HKhywQDmmufRXLvdzq
 uMQMmeRUOmpnRpAZ55F7jELfesX43KN1zkkG0BkFTqpG+y19He8U2i8gd
 fn9uA2YNJoESdV8wObsCB0VPTUfQf/3HppCQVcxq0g+RqzGCwI8lEfj0d
 b8qXqV7h7D5kdUmw1RM0o/1M/kc4vFB3NQ9lZxB4Un+9GFgbIPwFHeRuN
 wsLlWn6r+JTeuK0zWo4NlVpCH3HcS8sjEXrSRipupGrVTz+38+NgPDBKV w==;
X-CSE-ConnectionGUID: EFGr92VsQPaQeHxD6VVclw==
X-CSE-MsgGUID: TfhmPdnmRmqQ9Z5yWjiVbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="429590"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="429590"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:48 -0700
X-CSE-ConnectionGUID: R12gTsBeRlCT3NiIDNH9+Q==
X-CSE-MsgGUID: w60tCIDxQNS6KOix0l3Dsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277415511"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:46 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH 0/5] drm/xe: Fix VM teardown and migration queue recovery
Date: Wed, 16 Sep 2026 15:23:32 +0530
Message-ID: <20260916095337.3104891-1-arvind.yadav@intel.com>
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

On BMG, terminating a process with Ctrl+C while GPU work is running under
VRAM pressure can cause an RCS page fault followed by a migration queue
timeout on BCS8 (guc_id 0). The driver resets the GT, but the pending
migration job can time out again and eventually wedge the device.

BCS8 is reserved for paging and runs migration and VM bind work.
The exact hardware link between the RCS fault and the BCS8 stall
is still under investigation. This series addresses the teardown
and recovery problems found while debugging this failure.

During file close, exec queue cleanup starts asynchronously, but the VM
mappings can be removed before that cleanup finishes. A missed wakeup in
the GuC disable-completion handler can also turn a completed operation
into a five-second timeout and an unnecessary GT reset.

The reset replay path rewinds the software ring tail to the oldest pending
job, but leaves the LRC head at its saved position. This leaves different
starting positions for replay.

The four patches address these paths:
1. Clear pending-disable state before waking waiters, so a completed disable
does not appear to time out.

2. Mark VMs as closing before queue cleanup. Reject new work and page faults
on closing VMs, while allowing existing SVM invalidation to drain mappings.

3. Keep VM mappings alive until queue cleanup completes. File close uses one
five-second queue-wait budget across all VMs, then defers any remaining teardown.
VM destroy defers without waiting. Device references protect deferred close and
final VM destruction on the module-lifetime destroy workqueue.

4. Set the software tail and LRC head and tail to the oldest pending job before
resubmitting jobs after a GT reset.

The five-second budget applies only to the new queue-cleanup wait.
Existing teardown waits are unchanged.

Arvind Yadav (5):
  drm/xe: Hold a device reference across deferred VM destruction
  drm/xe/guc: Wake disable waiters after clearing pending state
  drm/xe: Mark VMs as closing before queue cleanup
  drm/xe: Defer VM teardown until exec queue cleanup completes
  drm/xe/guc: Reset LRC ring pointers before replay

 drivers/gpu/drm/xe/xe_device.c     |  25 +++-
 drivers/gpu/drm/xe/xe_exec_queue.c |  22 +++-
 drivers/gpu/drm/xe/xe_guc_submit.c |  60 +++++----
 drivers/gpu/drm/xe/xe_module.c     |   6 +-
 drivers/gpu/drm/xe/xe_pagefault.c  |   2 +-
 drivers/gpu/drm/xe/xe_svm.c        |   3 +-
 drivers/gpu/drm/xe/xe_vm.c         | 205 +++++++++++++++++++++++++----
 drivers/gpu/drm/xe/xe_vm.h         |  14 +-
 drivers/gpu/drm/xe/xe_vm_types.h   |  16 +++
 9 files changed, 289 insertions(+), 64 deletions(-)

-- 
2.43.0

