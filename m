Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EE5CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5867D10EB49;
	Tue, 19 May 2026 08:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zXVSoLT7";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2514A10EB3E;
 Tue, 19 May 2026 08:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCR3kgheoY9vi9Er97zWqNNvh/R2HczQYZyIHWc2dISEXPOBfZ2UT3oROBJ8szQUhTCF12+fwUO1I+KqXkpYOia+k9a2rc3MyE31ftofYg8hvKc7Z5StleMlIbKtUyEs5owQOS+S3tBtdajtu1HL5lh2x5DSaXejLPtZ9+SB5RB9WFig4L87h4jh3CdD7GTRXTgIWzHDL40jJMbmqUEPvK09JvL9whGPLV7hZTgpg2PO5EYlAk6NcWduD2vp9+uIk9/c+WG5tQJlqtVw+6wzgd/tpPNUiYDC8TGYXLa06AsO4hxgeRKJlnkVE8UcjrpexYzLCAY5A5zH4ewU/WWrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJBxZLFlc8u4EeCDB9ebasib/6OJziakD+L41rW7Wjo=;
 b=MkId72vGj/P8KQfDCKEJMZ0EC2fhOLIw8qYs/qG7hzp22lZcq9nX31bqU7ig0UBilMhiDaPgUskuwnxdQVBwGwsuyV4coG6bA7vptcrOU8uQlTATCahmJT5FTOthbLLcAUG213qf2zG6e0itEVkU7GRf9XZD/IRCjstXJQyG2IXxjc1u5WY5H8houb1Bghr14xxPZxEr3axA07jb2n4ohCc6sHCHWUV5AcEPwBAqBoofTdxtZY+nKloRrsQ/bnmlVerooRKCdkBmRkMVzeY+yvzF1G9Y008BACyoMc/35dySwolDzzvDdM/6IWXwvObPqBOm71LC4BPkHw+p82hXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJBxZLFlc8u4EeCDB9ebasib/6OJziakD+L41rW7Wjo=;
 b=zXVSoLT7byf/vI/nZTQOae3r47IQZXTiYl24JpEJJY3Wu9hE/PipDfC4I0QP5QDkaDs0ao+vNrR+zdI5a/TAfqcix0B80JqcepkmfWfiKIf4nFm/qjbx5F5eOu3Eg15bNUPCg72mYYv6G6odt4cibY7J0bfOHNv7Sx65NBympEM=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 08:31:43 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5d) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Tue, 19
 May 2026 08:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:31:43 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 03:31:38 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V6 00/12] drm/amdgpu: SVM implementation based on drm_gpusvm
Date: Tue, 19 May 2026 16:30:45 +0800
Message-ID: <20260519083057.3108087-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f2f17e-98b8-488b-42b0-08deb5810ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|3023799003|56012099003|18002099003|11063799005|921020|13003099007;
X-Microsoft-Antispam-Message-Info: fCQDdyGcjRfZ2P/S48EPT1W4/lQqwELm6UAV9Fu4K1pJ6WW6x0vtv1MbCTzxo5AFgJ4HrNVrubMtyxWBu1N7oSy2GooTIjYyaFPCUa2UR4TdTi2iPfN80uHqxoLzXvutP6KbXqS0/l0XFskFZ9ZfqCFvUAK53FxNq/gXD/lxLdIs1xSt2XXd38ZcLDf7+gm6QuJIgSTW7ZzHRIdFKTPUmexJtk0gpi+GUrRl8k4jd8VxhNf00NnR/tAthaIVARSJAA3QZTHMhBfYNk5JuclKMzJftsdMSdHF0knA8o59dsXyZ3a8EpPFEyFNZxVSISgYlHXJUQ+9yPltFvebpHT9zABZM8LDxO43q6tmHovQaNF0eWBLJAJ/iHer+FhJsRCB7Dm5K4BmmQuejQobHkhfaC4+FITIBM3uqft31oQ47WlIBwaDcLHr8U6lqOAUQFQ0NcTaQUspZ/G1LqeyQRO/oQin9E8w5TO0vui66927AqtoUHPU0bK5QW85ZRm59zRsFvuNlimtJ7TGdjSODhSjdDVfVciftgYWxmv+ubb/f2zNyMWgTnwe5lLR/96luoYSb0nNlWZxJfmLvdpspyF/j1R6HlXdJ1tVdPs0TeywTrbpwi1Byuugoiw6yxcS9Q8heOfC4sL/2FtxVaDLSaqfAwm2vF0r1h1xcYxLlzP6EsHhfdjvBcysrgBoyZBR69jRmjwi559IoW5XVEnDMSD1Hdo1LoUWlQknYFh4RsV6y2mV2fXwSS8o7o15Ot4n+xneThXJVk7qr2AXdQdzsoemCs44Y4u8SuakbKsvM0+pgq4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(3023799003)(56012099003)(18002099003)(11063799005)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5r5pN/kurBCUHbFAvsJL7ssckWqSSKYO9TQX4uWFePQgXRtaOQQYkYQpsUT8RuE5qJhDit6QxqRPydd8N/T2ngljKAxRj/IyFmxOdOQ0JrFnccdAzj2nnG02jodjZoHz8ounMZZViMnRVAf7rEV6/FaHHYzrgGIjP57qOr2+hb/Q/UHsIulTYZGWqkWqKBCqAipGYqIU4y06wjHEeUk0pQPC/qnbfxMHAnm+qAp9hDhNKrqXn6Nfb90zmiL2HRQSlWu9e/aCfl3ifi+LoUqgBOH7Hf9bPY3haE9nTvjywTNY1N238VL5mpgb77Ep6g0H1EGXTezBwj/Vz9DsDYgpwP5Y+XLGX3+0vZwZLDCboIFFdbnOPfM4bVeK1rIdtsNfZwch1p874T3Mvbpad0tXfvO0yDY+XgnoJOuOSqvq1hmJe0DvHR+FmoRfQpvluR3c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:31:43.6170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f2f17e-98b8-488b-42b0-08deb5810ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539
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

V6 of the SVM patch series for amdgpu based on the drm_gpusvm framework.
This revision reworks the GPU PTE flag computation to be per DMA segment
and protocol aware, and adds more helpers for notifier and GC.

This patch series implements SVM support with the following design:
  1. Attributes separated from physical page management.
  2. GPU fault driven mapping (XNACK on).
  3. MMU notifier invalidation.
  4. Garbage collector workqueue.

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
        coalesced DMA segments programmed under notifier lock.
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

 drivers/gpu/drm/amd/amdgpu/Kconfig            |  11 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 702 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 199 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 986 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 174 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 382 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 749 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 166 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 include/uapi/drm/amdgpu_drm.h                 | 106 ++
 14 files changed, 3552 insertions(+), 1 deletion(-)
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

