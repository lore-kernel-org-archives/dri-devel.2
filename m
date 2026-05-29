Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F09CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8592210F8E4;
	Fri, 29 May 2026 05:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZuaMsX2c";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368F110F8E3;
 Fri, 29 May 2026 05:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlv+i67rIjx/B+9yy19ZsuV0I2cjrZTrnHGOXM+ysL9kZdjGww43NTJU2Klqh4tZOZ101vCPMvo/N9EefbWvW7d3QUJ0I/RtwgR6j690M4DuDptNx5uSeYgrgSxkgkng9fXqeSZB17V4aNv/p3NukKazbiGIqaGGOCODkcQPe4DekLK+jaimYgpu+0vJjAU7FqsJ2E11I5E1wjOVVjYtwtwAsk2RgBfIqtmtm21iow22mAGzjwfuV3R4s/7duIrAcXbP0DshUgtpg2Umq11U72gPgPYDu1uzVS9QKPbsJXEAKf6b8ADjt0tGQtVzybED6scJOJMD+UH8ee2cZuMbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF2bgIFE3m5Oa2GkinHgc/awPVtklZQtc+mdU8mjUNw=;
 b=hovPkSlQztsVTf3j/IytK+Ccql1SNRy4GszzxFFstxP6BhZENNgeuA/26Pd/j1lTB4lvZKzB7N1+GgGV9/iu8L2t/cAFWhuJ6eo9O+yiJVvCXY0pTX0+8Y/U8JuM973s8X7ErobUXihCuhl7XoEAfViXBkDXn0avOzBF1URjJHJ3Vlpvv74Fhza5T3y4mZWrwK82KLHX41Fk3eJszfp531z/0R53Qkkou7NT0LpCH16nFjp94TfrEyFn5y0OG+cFs9nzD7ch58T+6TYOt7/wQrkYg/5GIuWFaNnMj2p1vVa9VlOWShnQvvGwWOBFpKhjFfAxboMzXwhruwbOfbPngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF2bgIFE3m5Oa2GkinHgc/awPVtklZQtc+mdU8mjUNw=;
 b=ZuaMsX2camcARgNlCEyT0SUDql0TmkO83HLmRnEC4fTSw3y2hKkfN3u9dGQB0wCcgmUP22DOfVXDYQyj9wV8iechnPm0MQ64oPuRY0+DCTe994tfz9FxCldoix8h3ZmmhYM4KudAOHzhUXuJYvhQoVrbLL94E0tjbsb8/dv7s+M=
Received: from MW4PR04CA0376.namprd04.prod.outlook.com (2603:10b6:303:81::21)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 05:48:23 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::15) by MW4PR04CA0376.outlook.office365.com
 (2603:10b6:303:81::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:48:23 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:48:17 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 00/12] drm/amdgpu: SVM implementation based on drm_gpusvm
Date: Fri, 29 May 2026 13:47:52 +0800
Message-ID: <20260529054804.596214-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: d670335c-18a3-413c-be1d-08debd45e576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|3023799007|6133799003|921020|11063799006|13003099007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: bkF8PLEMYXefOyMT8bd124qYkNb4etJcKr3SS06k4NCyuatSwBFs+Jwo2YeoMGYbiR/U9vsydGxFE02zSaB/GxRcXX0BE1P1zmdVhMj7YfRgPFIEOEmZKwQ8jVO8L4sdIoMxu/+kknXDAU+6Q4TYvaXcNSkadpm/t3XPbrOECKnPPlxW7ksbuDTFoyYlYLe1gNmpUdoafiumpibIwpTUoAv2w4Xi5YnyNVnO02er2zsj+a6hxuA4dXWa0wp/g9s/gjVbv9G8ocXSPO0Z5oLq9s9MMXMgH+dKwJ7HXibYWZnMxH4d8gHwCIJNxDqOsfM2ZjbxBUAMMq0KiKhGRoNP2wI1yyQeiA8HHgKqncbT6i1ArjBjRE66PFOhQmdINOdMGnlw4nbQeJQp9ziOBprmiTzUpqFUUbPCUn0x50ybWoQOz2j2ahN5H4MnoROyy8xrgDvnqtGVXhfTjIkjBgaFgZ/zUz2jCQuw/WAKvGn1HE+N8R3vJkKlflrhV3hutRPXqaRmEs9lyGM1uPU4B5UWEf+39+laeEoeqVUAJyvvJ1cm8rJVthbKDT+BQC6IG24DG0Kro7l7x1iUM7sRtJ8sfhwz0fbh5B9KVMpVtmehK8FwJDIu2Qk8N7F5dFv3yXGKt6e0XsGkOJWTmilvJ7Zi+yGqugUJZZN1JcFzgzorUmtiwMSdJCGxavhI5tqwHyKwN2Ks0/wXijSNKQo99ISNvTyg0U7xu2ZQKZM1HovkbeWCHExHeldlvetXINz3uK4e0i7rNlithITccAaKvWdFDV4Q8854vJKzWyeMMRVN9yQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(3023799007)(6133799003)(921020)(11063799006)(13003099007)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cnLuZgZLTFf2zP4GqSmuqI0UQKWZIbQPhgKCDvAjqH6I5jGKZSLOSOWZJrKe7fMjzl3Z/HHjHSW+EQ3deFG/YcTdNIKA4tsxAS+Db/QeZ0Fm59gIy3/xKnjvf5plWu7fdHUClD+4M3blGYcW/VV2koEG005nG7Efb5/Ve8+H4sv72DAq4ici5VtXlNF8yA0LzTbjQHaDVv5Kt6YwI2pqbPqQvROSRk0esn97E0Jj9IK+weWOisNAtScyI+SReC1CuozRdRr4p2Bya+F30v9IyX4Gw0YcaLnSTI0soKXaVcPlBKgTvXmftfWDWRLgB0UbBjHvhzeJzU+QBZS34j6ExPJgY6cadOdukWxSaMFTfaTftPgV8ssAhHUqtH3uAx3oScYgKk0lIW5R6mDx5iHTj35qxjRy0NbxxEKmsTzs8ITXPvX6KPTKntL1PQyfaerV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:48:23.2054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d670335c-18a3-413c-be1d-08debd45e576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
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

V7 of the SVM patch series for amdgpu based on the drm_gpusvm framework.
This revision rebases to the latest amdgpu driver, fixes read-only VMA
handling in GPU mapping, simplifies attribute change trigger logic for
XNACK on mode, and adapts the VM fault path to the latest amdgpu_vm code.

This patch series implements SVM support with the following design:
  1. Attributes separated from physical page management.
  2. GPU fault driven mapping (XNACK on).
  3. MMU notifier invalidation.
  4. Garbage collector workqueue.

Changes since V6:
  - Handle -EPERM from drm_gpusvm_range_find_or_insert() by retrying
    with read_only=true to respect RO VMA permissions.
  - Reset read_only flag per iteration in the mapping loop.
  - Simplify attr change trigger dispatch: remove XNACK off paths,
    only PREFETCH drives mapping in XNACK on mode.
  - Change Kconfig default from y to n.
  - Adapt VM fault dispatch to latest amdgpu_vm.c with exclusive
    SVM/KFD path selection.
  - Fix coding style: line length, block comment alignment, spacing.
  - Remove inline comments from ATTR_BIT defines.
  - Use max_t/min_t for mixed-type granularity alignment in fault
    handler.

Changes since V5:
  - Get PTE flags per DMA segment, stop caching on svm_range.
  - attr_pte_flags() now takes enum drm_interconnect_protocol.
  - Add AMDGPU_INTERCONNECT_VRAM / _P2P tags in amdgpu_svm.h.
  - Rework zap_ptes to take explicit page range.
  - Add amdgpu_svm_range_evict(): devmem-aware wrapper around
    drm_gpusvm_range_evict.
  - get_pages(): fall back to evict on -EOPNOTSUPP.
  - Simplify cover letter design content.

Changes since V4:
  - Preserve attributes when unmap, GC only removes GPU ranges.
  - struct amdgpu_vm now holds a pointer to struct amdgpu_svm.
  - UAPI: Remove AMDGPU_SVM_ATTR_GPU_ALWAYS_MAPPED.
  - UAPI: Add AMDGPU_SVM_OP_RESET_ATTR to reset attributes to defaults.
  - Add amdgpu_svm_lock()/unlock()/assert_locked() inline wrappers.
  - Add amdgpu_svm_attr_check_vm_bo() for SVM/BO overlap detection.
  - Refactor attr change model.
  - Remove ATTR_ONLY/RANGE_SPLIT triggers.

Changes since V3:
  - UAPI: Merge ACCESS/ACCESS_IN_PLACE/NO_ACCESS into a single
    AMDGPU_SVM_ATTR_ACCESS attribute with enum amdgpu_ioctl_svm_access
    (INACCESSIBLE/IN_PLACE/ALLOW_MIGRATE).
  - UAPI: Replaced SET_FLAGS/CLR_FLAGS with per-flag boolean attribute
    types: HOST_ACCESS, COHERENT, EXT_COHERENT, HIVE_LOCAL, GPU_RO,
    GPU_EXEC, GPU_READ_MOSTLY, GPU_ALWAYS_MAPPED.
  - UAPI: Replaced all #define constants with C enums.
  - Add UAPI documentation with kerneldoc comments in amdgpu_drm.h.
  - Moved flag bits from UAPI AMDGPU_SVM_FLAG_* to internal
    AMDGPU_SVM_ATTR_BIT_* bitmap. Added attr_flag_type_to_bit() helper.
  - Removed AMDGPU_SVM_VALID_FLAG_MASK and flags_or.
  - Condensed commit messages and cover letter content.

Changes since V2:
  - Add version tittle in commit message.
  - Fix some content mistaken.

Changes since V1:
  - Added GPU fault handler (amdgpu_svm_handle_fault) with PASID-based
    SVM lookup: GC -> find_or_insert -> get_pages -> GPU map.
  - Removed restore worker queue; GPU fault recreates ranges on demand.
    GC simplified to discard-only, no rebuild/restore logic.
  - Reworked MMU notifier to two-phase model: event_begin() zaps PTEs
    and flushes TLB, event_end() unmaps DMA and queues UNMAP to GC.
    Removed begin_restore/end_restore and NOTIFIER flag dispatch.
  - Added invalidate_interval() for attribute boundary realignment
    when sub-region attribute changes cross existing GPU ranges.
  - On MMU_NOTIFY_UNMAP, discard all affected ranges entirely;
    attribute layer preserves valid attrs, fault recreates on demand.
  - Added unregistered address attribute derivation from VMA properties
    for ROCm compatibility (kfd/rocr/hip tests).
  - Dropped XNACK off support; returns -EOPNOTSUPP when disabled.
    Removed kgd2kfd_quiesce_mm()/resume_mm() dependency.
  - Added TRIGGER_RANGE_SPLIT, TRIGGER_PREFETCH change triggers.
  - Added helpers: find_locked, get_bounds_locked, set_default.

TODO:
  - Add multi GPU support.
  - Add XNACK off mode.

Related work:
  - SVM migration and prefetch support is being developed in:
    https://lore.kernel.org/amd-gfx/20260427100522.7014-1-Junhua.Shen@amd.com/
  - ROCm UMD interface adaptation for the new drm SVM API is being developed in:
    https://github.com/ROCm/rocm-systems/pull/4364


Test results:
  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 96% passed.
                    gfx906 (MI60): 99% passed.

Patch overview:
  01/12 UAPI: DRM_AMDGPU_GEM_SVM ioctl with SET/GET/RESET_ATTR ops,
        access modes, location values and attribute types.
  02/12 Core header: amdgpu_svm wrapping drm_gpusvm with attr_tree,
        GC, locks and VM integration hooks.
  03/12 Attribute types: attrs, attr_range, attr_tree, internal flag
        bitmap, change triggers and inline helpers.
  04/12 Attribute tree ops: interval tree lookup/insert/remove,
        find_locked, get_bounds_locked, set_default.
  05/12 Attribute set/get/clear/reset: validate, apply with head/tail
        splitting, BO overlap check, change propagation.
  06/12 Range types: amdgpu_svm_range extending drm_gpusvm_range with
        gpu_mapped state, pending ops and interconnect tags.
  07/12 Range GPU mapping: per-segment, protocol-aware PTE flags;
        zap_ptes on explicit page window; get_pages evict fallback;
        coalesced DMA segments programmed under notifier lock;
        -EPERM retry with read_only for RO VMA enforcement.
  08/12 Notifier and GC helpers: two-phase events, range removal,
        GC enqueue/dequeue, invalidate_interval with devmem eviction
        to preserve VRAM data on boundary crossing.
  09/12 Notifier invalidate callback: dispatch with TLB flush
        batching and checkpoint timestamp.
  10/12 Initialization and lifecycle: kmem_cache, drm_gpusvm_init,
        XNACK detection, GC init, PASID lookup, TLB flush and
        init/close/fini.
  11/12 Ioctl entry and fault handler: op dispatcher, GC worker and
        fault path (attrs + read_only, BO overlap narrowing,
        unregistered attr derivation, retry logic).
  12/12 Build integration: Kconfig, Makefile, ioctl registration and
        amdgpu_vm fault dispatch.

Honglei Huang (12):
  drm/amdgpu: add SVM ioctl UAPI definitions
  drm/amdgpu: add SVM core header and VM integration
  drm/amdgpu: add SVM attribute subsystem types
  drm/amdgpu: implement SVM attribute tree and helper functions
  drm/amdgpu: implement SVM attribute set/get/clear operations
  drm/amdgpu: add SVM range types and work queue interface
  drm/amdgpu: implement SVM range GPU mapping core
  drm/amdgpu: implement SVM range notifier and GC helpers
  drm/amdgpu: add SVM notifier invalidate callback and checkpoint
  drm/amdgpu: implement SVM initialization and lifecycle
  drm/amdgpu: add SVM ioctl entry and fault handler module
  drm/amdgpu: integrate SVM into build system and VM fault path

 drivers/gpu/drm/amd/amdgpu/Kconfig            |  10 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 682 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 199 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 988 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 174 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 386 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 774 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 166 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 include/uapi/drm/amdgpu_drm.h                 | 107 ++
 14 files changed, 3565 insertions(+), 2 deletions(-)
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

