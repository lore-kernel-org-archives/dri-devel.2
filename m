Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368F7D58B0D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048CE10E2C3;
	Mon, 16 Mar 2026 04:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UdOLt9PY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28CB10E2B9;
 Mon, 16 Mar 2026 04:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635583; x=1805171583;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=r5aGY7amymEhnNtlkLAF7BZO6HgZuka7L4LXNyffT/Q=;
 b=UdOLt9PY6fwuS4lfS75METDarvtWtkisgbx7UO6vyHuKtp7N1wnFwDuE
 j2Ray5JcLfGgVZYwP7YU2w+sO/XsL8zvCdQCmvIZwujWYdX9JWl6K1w5E
 ogVu4eWtech4pxCnWtiq+9aX2MKtobPUKIlVWFAKBbYxOTQ+SX5QQ8I3A
 Dx6lrBHZ4n8B8bJr7eLNY3XyLW99lcOAhdO/3oOHheZygQf20/LBPxfvy
 kYxM78jbAkEIy2VqxMPAQEqJEwRmQHmylSlJXrMVld4VYhrHpiUDcpbh0
 kvCdzS0JlHcYdAXPfcC+TmSB8+uAmxdsEAdWmOa6gdFspOTGIB6NhV5mJ w==;
X-CSE-ConnectionGUID: I+kAe4IRSkePUpR4SiGwAw==
X-CSE-MsgGUID: zKv6YWn5Q3qnRTBL8sNLxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683477"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683477"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:02 -0700
X-CSE-ConnectionGUID: ULkjfYXLSg2JYOaSqp1mfQ==
X-CSE-MsgGUID: H58jkOwaRI2LYei0jjqBKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022160"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 00/12] Introduce DRM dep queue 
Date: Sun, 15 Mar 2026 21:32:43 -0700
Message-Id: <20260316043255.226352-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

Diverging requirements between GPU drivers using firmware scheduling
and those using hardware scheduling have shown that drm_gpu_scheduler is
no longer sufficient for firmware-scheduled GPU drivers. The technical
debt, lack of memory-safety guarantees, absence of clear object-lifetime
rules, and numerous driver-specific hacks have rendered
drm_gpu_scheduler unmaintainable. It is time for a fresh design for
firmware-scheduled GPU drivers—one that addresses all of the
aforementioned shortcomings.

Key changes from DRM scheduler:
	- Unification of drm_gpu_scheduler, drm_sched_entity into
	  drm_dep_queue
	- Reference counting
	- Clear object-lifetime ownership
	- Privatisation of drm dep fence
	- Drop scheduled fence from drm dep fence
	- Submit workqueue bypass path (optional)
	- IRQ removal of jobs (i.e., bypass worker to drop ref to job)
	  (optional)
	- Asynchronous teardown
	- Extensive lockdep annotations and asserts
	- Extensive kernel doc

Xe has been fully converted to drm dep and extensively tested with and
without verbose kernel debug Kconfig options. Everything seems to be
working locally. All permutations of drm_dep_queue_flags tested.

Compile tested only conversions - Panthor and AMDXDNA.

Other candidates to convert are: Nouveau, PVR, and AMDGPU VM queue.

Forward looking - this design seems suitable for Rust bindings and use
by Nova, Tyr given the clean object-lifetime rules and reference
counting.

The Xe team is aligned on moving forward with this; hopefully the rest
of the community embraces it.

In addition to DRM dep, workqueues have been updated with interfaces to
enforce reclaim safety with DRM dep, and Xe is utilizing these interfaces.
This part could be split out into a separate series.

I'm also fairly certain that a sane HW queue component could be built on
top of DRM dep as well, replacing DRM sched for all drivers they choose. 

Matt

Matthew Brost (12):
  workqueue: Add interface to teach lockdep to warn on reclaim
    violations
  drm/dep: Add DRM dependency queue layer
  drm/xe: Use WQ_MEM_WARN_ON_RECLAIM on all workqueues in the reclaim
    path
  drm/xe: Issue GGTT invalidation under lock in ggtt_node_remove
  drm/xe: Return fence from xe_sched_job_arm and adjust job references
  drm/xe: Convert to DRM dep queue scheduler layer
  drm/xe: Make scheduler message lock IRQ-safe
  drm/xe: Rework exec queue object on top of DRM dep
  drm/xe: Enable IRQ job put in DRM dep
  drm/xe: Use DRM dep queue kill semantics
  accel/amdxdna: Convert to drm_dep scheduler layer
  drm/panthor: Convert to drm_dep scheduler layer

 drivers/accel/amdxdna/Kconfig                |    2 +-
 drivers/accel/amdxdna/aie2_ctx.c             |  144 +-
 drivers/accel/amdxdna/aie2_pci.h             |    4 +-
 drivers/accel/amdxdna/amdxdna_ctx.c          |    5 +-
 drivers/accel/amdxdna/amdxdna_ctx.h          |    4 +-
 drivers/gpu/drm/Kconfig                      |    4 +
 drivers/gpu/drm/Makefile                     |    1 +
 drivers/gpu/drm/dep/Makefile                 |    5 +
 drivers/gpu/drm/dep/drm_dep_fence.c          |  406 +++++
 drivers/gpu/drm/dep/drm_dep_fence.h          |   25 +
 drivers/gpu/drm/dep/drm_dep_job.c            |  675 +++++++
 drivers/gpu/drm/dep/drm_dep_job.h            |   13 +
 drivers/gpu/drm/dep/drm_dep_queue.c          | 1647 ++++++++++++++++++
 drivers/gpu/drm/dep/drm_dep_queue.h          |   31 +
 drivers/gpu/drm/panthor/Kconfig              |    2 +-
 drivers/gpu/drm/panthor/panthor_device.c     |    5 +-
 drivers/gpu/drm/panthor/panthor_device.h     |    2 +-
 drivers/gpu/drm/panthor/panthor_drv.c        |   35 +-
 drivers/gpu/drm/panthor/panthor_mmu.c        |  160 +-
 drivers/gpu/drm/panthor/panthor_mmu.h        |   14 +-
 drivers/gpu/drm/panthor/panthor_sched.c      |  242 ++-
 drivers/gpu/drm/panthor/panthor_sched.h      |   12 +-
 drivers/gpu/drm/xe/Kconfig                   |    2 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c        |   10 +-
 drivers/gpu/drm/xe/xe_dep_job_types.h        |    8 +-
 drivers/gpu/drm/xe/xe_dep_scheduler.c        |   81 +-
 drivers/gpu/drm/xe/xe_dep_scheduler.h        |    7 +-
 drivers/gpu/drm/xe/xe_device.c               |    3 +-
 drivers/gpu/drm/xe/xe_exec.c                 |   12 +-
 drivers/gpu/drm/xe/xe_exec_queue.c           |   96 +-
 drivers/gpu/drm/xe/xe_exec_queue.h           |    9 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h     |   10 +-
 drivers/gpu/drm/xe/xe_execlist.c             |   39 +-
 drivers/gpu/drm/xe/xe_execlist_types.h       |    4 -
 drivers/gpu/drm/xe/xe_ggtt.c                 |   12 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler.c        |   66 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler.h        |   67 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h  |    9 +-
 drivers/gpu/drm/xe/xe_gsc.c                  |    5 +-
 drivers/gpu/drm/xe/xe_gsc_submit.c           |    5 +-
 drivers/gpu/drm/xe/xe_gt.c                   |    8 +-
 drivers/gpu/drm/xe/xe_guc_ct.c               |    3 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h |   14 +-
 drivers/gpu/drm/xe/xe_guc_submit.c           |  360 ++--
 drivers/gpu/drm/xe/xe_migrate.c              |   27 +-
 drivers/gpu/drm/xe/xe_oa.c                   |    5 +-
 drivers/gpu/drm/xe/xe_pt.c                   |    2 +-
 drivers/gpu/drm/xe/xe_pxp_submit.c           |   10 +-
 drivers/gpu/drm/xe/xe_sched_job.c            |   59 +-
 drivers/gpu/drm/xe/xe_sched_job.h            |    9 +-
 drivers/gpu/drm/xe/xe_sched_job_types.h      |    8 +-
 drivers/gpu/drm/xe/xe_sync.c                 |    2 +-
 drivers/gpu/drm/xe/xe_tlb_inval.c            |    3 +-
 drivers/gpu/drm/xe/xe_tlb_inval_job.c        |   86 +-
 include/drm/drm_dep.h                        |  597 +++++++
 include/linux/workqueue.h                    |    3 +
 include/trace/events/amdxdna.h               |   12 +-
 kernel/workqueue.c                           |   41 +
 58 files changed, 4268 insertions(+), 864 deletions(-)
 create mode 100644 drivers/gpu/drm/dep/Makefile
 create mode 100644 drivers/gpu/drm/dep/drm_dep_fence.c
 create mode 100644 drivers/gpu/drm/dep/drm_dep_fence.h
 create mode 100644 drivers/gpu/drm/dep/drm_dep_job.c
 create mode 100644 drivers/gpu/drm/dep/drm_dep_job.h
 create mode 100644 drivers/gpu/drm/dep/drm_dep_queue.c
 create mode 100644 drivers/gpu/drm/dep/drm_dep_queue.h
 create mode 100644 include/drm/drm_dep.h

-- 
2.34.1

