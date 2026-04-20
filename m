Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBE9F36C58
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442FF10E526;
	Mon, 20 Apr 2026 12:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z9asQmzF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000B910E518;
 Mon, 20 Apr 2026 12:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgYUjuB0QEov7Oj0zAouO2OBMkRYNwJrloyWZ+zwi7mQXeyk1If6yAwQmMc7ip5Eqvu256onuHksbN+PtTnsehXXos2E0AMbItb6nfEzAfMuB5VrbcdeNDRAIh/8bEZk85HcHlJlxrRRn10BTYYwBXAMnU38Ezjn3VG+7r6JdldsFcPTPECUOrAk4ClQMVF4WxzTk6rROIa2AOorAyK/BpcRgv4WQU8vpaZakAglZPeGKI1KHpxQaQU+6TgYhBY3u28GyNyZ7Gsbs95cLmzWS8BUmyhvJqDt40pfXChv94JPtTFB3rRwvtUxnEbsCGmOUQ/btd603P+wWNs6Hm2jMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7T5T1LrY+7RA76KMgLI7TvTe664JOVIPrEwUs+aO1Y=;
 b=ealowahZEMK04xCUobU8KE4Qs47jWAkFThfbcBg6qJfo6tNt1SDAEWFm9UIVyQtcD/G+lcr5wqN7uzoiwJOTnJMwlXEjIbiMblGtgj4P65orPKk4BMJtSQgsrgxlgukYOB59f1+sjEbdJ6YZRbW8ckIVvdgGm2xRZAA5mWDmpKnDvikPdxE3/gplJr9sevmDPHxqRFwLNVxco9BNjC6wtIuixYf1dCW+Zvh0GsNIGl+chYev9BErG2Nojvjo1+VStYUA4Rq5Ha569FuNtDyAWU5lKt243O3nntndrnCFrqynMV9TgMQwVLvc4rtKDHiY3CiEThpTsUXS/9ydEiCh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7T5T1LrY+7RA76KMgLI7TvTe664JOVIPrEwUs+aO1Y=;
 b=Z9asQmzFa+KgXtNN9Odo1kufzip1B0b1tuwL8PUSJ/2ZadzS/hxJt61hm0uM/nbj0eYoiWzP2jsSbqBcYVqAYds0ct3urJYWBV2sgXLyB6zfkWF0+DgS0myRnyDfy++gUe0OFsMFoS1aJxGoHaW0z4WOMM99Q1skpus9t6m8a6g=
Received: from BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:08:03 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::3d) by BYAPR04CA0034.outlook.office365.com
 (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:02 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:07:56 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V2 00/12] drm/amdgpu: SVM implementation based on drm_gpusvm
Date: Mon, 20 Apr 2026 20:07:27 +0800
Message-ID: <20260420120739.1811731-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: db8ec217-3e4c-4711-6c75-08de9ed578bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ph81+lRVWS9jMkDWGR7202d3OXra75/eIjmbTE5WkuRuIUjA3PQqjKaEpy+FpbYXfNDaCYmGMtfdiaMnG5tE7Tt0puf1POsdEag9b2uUVlWgbRiGhCLmrMDj4GOeqOVvz1GHo/iwTsj+0UMdLTOXI3rluDyIDkaPIqa2BXRSR4kMSxrix9+6oks2GRpU6qRRSlGQ9gbeimidFweKMjXv+XwMXqxdGQ95B2C9pJrojExO0RMUfdAaNuGgN/Q/Rn8MFRB6En4N/2+3N70WO7U5U+AstJgbf9ufEfVuI1fahoO2pr5oM3VMG/Sso84Uk+rc9dVZXHgZ3CY3XNrVOV4tv8lFlOcrdpHVHxSqw97yD43xL9YVk19/G0X5AZy9+S0qUHkwHl/NSEO8IYwVYfcbXcS9IfakeW93/A2ejaeEfVEDEd7/ig7sM3cSwlP4KHCohcpKNf9oQmRe+PT+VsAe0PLTwgyU2K+ySdchRRTNusSYJthmCA8jSoq44Oi/2m3zQ2s9+7mzmwH5Q3TnlUlkRviXDnW5CgfPFDNLyzw5Rw8Pz9PitGgg09MLL4BG4jdgspvhzfYqdhii8Y76pDvZCsdkOiiP+qjRQP5Mym+5bGxVM8EzbWkalNtb4RR/cTRvSMrYp/dkFlvBJ3/pV6KDQF/mY8hJ4mJfVYs8bsaSYSpjbc1eb/SgvRRNoFI80VD7XHNlvwtSdKrHdjRENsGGrep1ocLu1mhzb9hmmbTxZmURUkN8XDlGR3vF5phMkgE0yx0tKdThiep6JU/oxU39F6G3P2NgQje0vA00TypeScE3+MoEHqU4l9n0+nT7kA7n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(921020)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SITcxPSBGrN93IgW6qilak84V8KyevoNRmy4j/I1TyS67z2YSanq3TvfB1S4qgALWpTFUQmV4DvlGr8HyTl8LlppA4LOQl2stCQKrOEGnX1EdW5eNQ/nJUV/A5L93PE9jWv+kfRQL63s/r7CUMQPCwJKGanLezLtLcVNKq2DsksLbOaSVomBkFWrZIriZPxfrdAw6Ep0I2pnPXvDxIAz5O4jHEM/Qsi/O96RtwT/B+cAxforFx+e1rNQJkgUCMZhCNoTaeVwKTsAakgsIFTDcHDYCDzb/3mW6c68eaycDS+KYpAvsL8NW/XhYhlUEH17JGlhUBam2wmY6V0G2eOv3OUQpOJuHmkL+PuawDFY6gsbaXr4KdPj1oMyR7DezOX8SPPFUFAPNQbFC6x9z6kyZ8G0UUEJ26ktmAYDYRCVXIrQQeR6LJvhuhpu3DF6hzzf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:02.3305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db8ec217-3e4c-4711-6c75-08de9ed578bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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

From: Honglei Huang <honghuan@amd.com>

V2 of the SVM patch series for amdgpu based on the drm_gpusvm framework. 
This revision incorporates feedback from V1, adds XNACK on GPU fault handling,
improves code organization, and removes the XNACK off (no GPU fault) implementation
to focus on the fault driven model that aligns with drm_gpusvm's design. 
The implementation references extensively from xe_svm.

This patch series implements SVM support with the following design:

  1. Attributes separated from physical page management:

    - Attribute layer (amdgpu_svm_attr_tree): a driver-side interval
      tree storing per-range SVM attributes. Managed through SET_ATTR
      ioctl and preserved across range lifecycle events.

    - Physical page layer (drm_gpusvm ranges): managed by the
      drm_gpusvm framework, representing HMM-backed DMA mappings
      and GPU page table entries.

    This separation ensures attributes survive when GPU ranges are
    destroyed (partial munmap, attribute split, GC). The fault
    handler recreates GPU ranges from the attribute tree on demand.

  2. GPU fault driven mapping (XNACK on):

    The core mapping path is driven by GPU page faults instead of ioctls.
    amdgpu_svm_handle_fault() looks up SVM by PASID, runs GC,
    resolves attributes, then maps via find_or_insert -> get_pages
    -> GPU PTE update. For unregistered addresses, default
    attributes are derived from VMA properties automatically.

  3. MMU notifier invalidation:

    Two-phase callback: event_begin() zaps GPU PTEs and flushes
    TLB, event_end() unmaps DMA pages. UNMAP events queue ranges
    to GC for deferred cleanup. Non-UNMAP events (eviction) rely
    on GPU fault to remap.

  4. Garbage collector:

    GC workqueue processes unmapped ranges: removes them
    from drm_gpusvm and clears corresponding attributes. No
    rebuild or restore logic, GPU fault handles recreation.

Changes since V1:
  - Added GPU fault handler: amdgpu_svm_handle_fault with PASID-based
    SVM lookup, following the standard flow: garbage collector ->
    find or insert range -> check valid -> migrate (TODO) / get_pages
    -> GPU bind/map.

  - Removed the restore worker queue entirely. V1 had separate GC
    and restore workers: restore workers were responsible for 
    synchronously restore in queue stop/start cause no GPU fault support.
    With XNACK on fault driven model, synchronous restore is unnecessary,
    the GPU fault handler recreates ranges on demand. The GC worker in 
    V2 is simplified to only discard ranges and clear their attributes, 
    with no rebuild or restore logic. AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED
    support is removed as no restore worker.

  - Reworked MMU notifier callback (amdgpu_svm_range_invalidate):
    V1 had a monolithic dispatcher with flag combinations and
    queue ops (CLEAR_PTE/QUEUE_INTERVAL, UNMAP/RESTORE) plus
    begin_restore() to quiesce KFD queues. V2 uses a two-phase
    model: event_begin() zaps GPU PTEs and flushes TLB,
    event_end() unmaps DMA pages and queues UNMAP ranges to GC.
    Non-UNMAP events (eviction) just zap PTEs and let GPU fault
    remap. Removed begin_restore/end_restore callbacks,
    has_always_mapped_range() check, and NOTIFIER flag dispatch.
    Added checkpoint timestamp capture on UNMAP for fault dedup.

  - Added amdgpu_svm_range_invalidate_interval(): when userspace
    sets new attributes on a sub region of an existing attribute
    range, the attribute tree splits the old range and the new
    sub region gets different attributes. However, existing
    drm_gpusvm ranges may across the new attribute boundary
    (e.g., a 2M GPU range covers both the old and new attribute
    regions). This function walks all gpusvm ranges in the
    affected interval, zaps GPU PTEs and flushes TLB. Ranges
    that cross the new boundary and old boundary are removed 
    entirely so the GPU fault handler can recreate them with 
    boundaries aligned to the updated attribute layout.

  - On MMU_NOTIFY_UNMAP events, discard all affected gpusvm ranges
    entirely without synchronous rebuild in v1. The unmap may destroy
    more ranges than strictly necessary (e.g., a partial munmap
    hits a 2M range that extends beyond the unmapped region), but
    the attribute layer preserves the still valid attributes for
    the remaining address space. When the GPU next accesses those
    addresses, the fault handler automatically recreates the
    ranges with correct boundaries from the surviving attributes.
    This avoids the synchronous rebuild logic that V1 required 
    (unmap -> rebuild in GC/restore worker).

  - Add attribute creation for unregistered addresses:
    amdgpu_svm_range_get_unregistered_attrs() derives default
    SVM attributes from VMA properties and GPU IP capabilities
    when the faulting address has no user attributes registered.
    this feature is needed to pass ROCm user mode runtime tests:
    kfd/rocr/hip. ROCm supports no registered virtual address access
    with default SVM attributes before, so amdgpu svm needs to support.

  - Explicitly returns -EOPNOTSUPP in amdgpu_svm_init when XNACK
    is disabled. V1 attempted mixed XNACK on/off support with
    complex KFD queue quiesce/resume callbacks and ioctl driven
    mapping paths, which added substantial complexity. V2 drops
    these implementations to focus on the fault driven model.

  - Removed kgd2kfd_quiesce_mm()/resume_mm() dependency that V1
    used for XNACK off queue control. For XNACK on, the GPU fault 
    handler is the enterance for SVM range mapping, so no quiesce/resume
    is needed for this version. 

  - Added new change triggers: TRIGGER_RANGE_SPLIT, TRIGGER_PREFETCH.
    for sub attr set and prefetch trigger support.

  - Added helper functions: find_locked, get_bounds_locked,
    set_default for GPU fault handling.

  - Design questions section removed.

TODO:
  - Add multi GPU support.
  - Add XNACK off mode.
  - Add migration or prefetch. This part work is ongoing in:
    https://lore.kernel.org/amd-gfx/20260410113146.146212-1-Junhua.Shen@amd.com/

Test results:
  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 96% passed.
                    gfx906 (MI60):99% passed.

Patch overview:

  01/12 UAPI: DRM_AMDGPU_GEM_SVM ioctl, SVM flags, SET_ATTR/GET_ATTR
        operations, attribute types in amdgpu_drm.h.

  02/12 Core header: amdgpu_svm wrapping drm_gpusvm with refcount,
        attr_tree, GC struct, locks, and VM integration hooks.

  03/12 Attribute types: amdgpu_svm_attrs, attr_range (interval tree
        node), attr_tree, access enum, flag masks, change triggers.

  04/12 Attribute tree ops: interval tree lookup, insert, remove,
        find_locked, get_bounds_locked, set_default, and lifecycle.

  05/12 Attribute set/get/clear: validate UAPI attributes, apply to
        tree with head/tail splitting, change propagation, and query.

  06/12 Range types: amdgpu_svm_range extending drm_gpusvm_range
        with gpu_mapped state, pending ops, work queue linkage,
        and op_ctx for batch processing.

  07/12 Range GPU mapping: PTE flags computation with read_only
        support, GPU page table update, range mapping loop.

  08/12 Notifier and GC helpers: two-phase notifier events, range
        removal, GC enqueue/add with dedicated workqueue.

  09/12 Attribute change and invalidation: apply attribute triggers
        to GPU ranges, invalidate_interval for boundary realignment,
        work queue dequeue helpers, checkpoint timestamp.

  10/12 Initialization and lifecycle: kmem_cache, drm_gpusvm_init
        with chunk sizes (2M/64K/4K), XNACK detection, GC init,
        PASID lookup, TLB flush, and init/close/fini lifecycle.

  11/12 Ioctl, GC, and fault handler: ioctl dispatcher, GC worker,
        and amdgpu_svm_fault.c/h with full fault path including
        unregistered attribute derivation and retry logic.

  12/12 Build integration: Kconfig (CONFIG_DRM_AMDGPU_SVM), Makefile
        rules, ioctl registration, and amdgpu_vm fault dispatch.

Honglei Huang (12):
  drm/amdgpu: add SVM UAPI definitions
  drm/amdgpu: add SVM data structures and header
  drm/amdgpu: add SVM attribute data structures
  drm/amdgpu: implement SVM attribute tree operations
  drm/amdgpu: implement SVM attribute set
  drm/amdgpu: add SVM range data structures
  drm/amdgpu: implement SVM range PTE flags and GPU mapping
  drm/amdgpu: implement SVM range notifier and invalidation
  drm/amdgpu: implement SVM range workers
  drm/amdgpu: implement SVM core initialization and fini
  drm/amdgpu: implement SVM ioctl and fault handler
  drm/amdgpu: wire up SVM build system and fault handler

 drivers/gpu/drm/amd/amdgpu/Kconfig            |   11 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |   13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  430 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |  147 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |  894 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  |  110 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 1196 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   76 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |    4 +
 include/uapi/drm/amdgpu_drm.h                 |   39 +
 12 files changed, 2958 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h


base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.34.1

