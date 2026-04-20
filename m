Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D1AF588C3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9604B10E5BB;
	Mon, 20 Apr 2026 13:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QCV3+bSD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0752D10E5BB;
 Mon, 20 Apr 2026 13:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLgCTMJwt5+DWO9n9nWG8bUFEO0PKq9YWifVFTgiwYxnIm4M3g4uq/G4ObZWxp2RNOP5Z8qAUc6DDOBOdel2TD7exitDNmqhGURdBokrQsnKag32tWF7oPnyvMIXJGuASa3cQzQQevjiegNBUrIt9MhdTRSAMXRAyLt1HGmUlqNMFO/m+hYuwDzVvOz1mJqDwKXaUMmwxR4Lub43nZVuFDIxpRmbqYNuJ/DQ1TcV/GIIcvWA62nfLQPUJxLHrTzQIfg+qDwrGEWyW5Jwqkzm5948+MkUxOFuLPVSbUW2Iy/CR0i7p3+ZWcAzwRDAfJ2V93iwqj4Z31ySIN9HmqUGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmwgzMVw8TrSrFnTvKQaApTJQNbG7YrtRDpjf8KlZHs=;
 b=o6vmol7GinBhRQGosRwcQ+CzowTOdtZt+ILZ16q3Q2ecyoW9xpValPX7uFT1Z3NRcLikrMQY4WEmMSA8bGB9h8wwzBcoCa/WaEnGKLy8Nbjl6SFfclfsn12BejEvYolqe41L/fLJJwXlGZS7dTcZKP+Ls0k4Udxvuar/YiiiCF+MgkOcBReCLH+soQ7fjN8IGotkL73+Xo2Z5DrQS/3tjUqS6SrCQlVsHUm+rUeShOZUkjVFBQ9fGqtTYIlLyh302KD7AQzBJ1R3QkLC0Oa6Yl1JU0t1zXiTJ2h6Mv+o0at5qbDk5l2kJwtrTxhAB2GcXh2pW2PViHDJteJc+550/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmwgzMVw8TrSrFnTvKQaApTJQNbG7YrtRDpjf8KlZHs=;
 b=QCV3+bSDk9sXrvoIhFcsiF95wuTqeVJSjAEYrSYG8LrNtFir0GwPNuEiVJNDaNTfXtLGR98C75eqqYdEs1qfpKB5USOL/1EGIVywfHg8gtehVyNfQ29ZPOyCAOizWOEKmyzM5rL8+4zBDiwNwQdwT/v/h2DfoF37+fkaAWU6vnU=
Received: from CH0PR03CA0323.namprd03.prod.outlook.com (2603:10b6:610:118::6)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 20 Apr
 2026 13:13:36 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::c3) by CH0PR03CA0323.outlook.office365.com
 (2603:10b6:610:118::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:13:35 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:13:31 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V3 00/12] drm/amdgpu: SVM implementation based on drm_gpusvm
Date: Mon, 20 Apr 2026 21:12:55 +0800
Message-ID: <20260420131307.1816671-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 812d6b01-d5d0-408d-a044-08de9edea113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|921020|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kl36nd30NFf5uMYf5mOBJbWU1hoasg/AMNcO3fN2L8wU1sb1VzyxX4g5gamTVeG/mn7XBl4TzSaY3jX60rhZ1QaTHsOAZ8eVDJF2w9WJbAys5ZW6Z5f+Sc4Puf+okUZnBiKbs92hM2ZbmqjMKapd5gamYpOGNd+IYsFWA0WoIjO3ovWD0pO2cMaso6vZTRFsiKpbYx8sLfv0Rcj7I0f5qX1zf4UevAiYYNed7OgQBVPYUQIPT+/TArUkb1Thsyt0iGtg9J1v2IGI9xokHQGYP+bk4HXVBeGRzlbSx+TsgzE4cFdgXS7XGMFSP8w+q59Bo+JG+XvZ08Dm6xCQUDCqxniNmG1NMkXvl89QTlmMD5f5Be6QHEqykM/q+S7azM1cJDGR69LNGSzn545Xtzci8ReUoDMEh6HSXgSq0rA1gdSx8+EuEhBX4nc5ca7OfQRQlYW53COAiYlnWdf1uKn71QW+bfYmQiG5pSm+cIvfo+BpgREAUwUzmcP9gN03t7ugzRrg/rgD/Xr1+a35xlhZkSRbMlIPXx/1tBaPvtx0oePOj33lgfPqzZKWv1IuM87m4I1/Og2Wcnxuggm8fHZE6/ZEmM+3c3Ekx7ezgD61VSHhXDNfaA4Mk1dyymlcGClamWEEsOB+RmsgEGyazczH9VgMmgp3EWzWRetyKmOkZ6Wp+MUlgpEQQlCFPNn9+m6zKJ0hOxjva76N3INoxyytsc/q3DYFyBj5Ex/GApFxPKvblj09IGTVPSsXW5Q0ab0umaxBGDhjCAnT68HUzbnqDPl7ihky36YBLLyvR5fETK+b2oofyK7f/IotidZAV8a8Jb5RaVWnDbI0X1shbIr+vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j4bVi/nUvbFxsUbJvmw3FyAXp7ApazBIeVHYdiY5cbSN71IFpqaN8mAbBTPFO2rW5M4xNI0EvrGsqTokZ2eQlfontbfRxO32c/vcXaFyfR98nswWLPr++bDzv82ji7kLNoEqr65qcBX70kW0YmUPoNu/hUNDWcbLqyguKbBex15z3N5kmfnyBK1zIcjWsFGMarKxMHYBgj/b1KY4HDuADbfNnDQWPJCJ4gwy4si1eqOv1xycRcaGv7bRHnFYn5JwbnJtbR2twsLvyJiWOMgvv/c+2tXXdI6W6iZOcTjJS7IpC83LpvxvMnpWDVnUE+A0VwWsM203ARyt1jBw28+ULZzsOd0Pl4es6VDO3gfDB02I/7P4aG3nC77CNrvRUw62S+mxupcJ+78RkmgXVSIDbuO+LWmr2gOYGiRCjZ2QtYSb6f8ugKJslmYGy3I96IR2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:13:35.5207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812d6b01-d5d0-408d-a044-08de9edea113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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

V3 of the SVM patch series for amdgpu based on the drm_gpusvm framework. 
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

Changes since V2:
  - Add version tittle in commit message.
  - Fix some content mistaken.

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
  drm/amdgpu: define SVM UAPI for GPU shared virtual memory
  drm/amdgpu: introduce SVM core header and VM integration
  drm/amdgpu: define SVM attribute subsystem types
  drm/amdgpu: implement SVM attribute tree and helper functions
  drm/amdgpu: implement SVM attribute set, get, and clear
  drm/amdgpu: define SVM range types and work queue interface
  drm/amdgpu: implement SVM range GPU mapping core
  drm/amdgpu: implement SVM range notifier and GC helpers
  drm/amdgpu: implement SVM attribute change and invalidation callback
  drm/amdgpu: implement SVM initialization and lifecycle
  drm/amdgpu: add SVM ioctl, garbage collector, and fault handler
  drm/amdgpu: integrate SVM into build system and VM fault path

 drivers/gpu/drm/amd/amdgpu/Kconfig            |  11 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 467 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 162 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 952 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 144 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 368 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 863 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 148 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 include/uapi/drm/amdgpu_drm.h                 |  39 +
 14 files changed, 3231 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h

-- 
2.34.1

