Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F0BCCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DEA10EE39;
	Wed, 29 Apr 2026 04:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mzU0qNNV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B4C10EB7D;
 Wed, 29 Apr 2026 04:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXhgQAwtY00mqI0T1HkpnS69jDRfZ3iSWsitZh+Plm8MiEXsNSbgzGKVmthO2FRn7L9c1qOR96kAzRv1yLL7kgjqN0PMAA7Gp74SuXNjV/V0MKsrjO7ZysyYsc9+1iausVi5Q8l1A/i+Pc0dhSrXK/It7LpVypQtzgXZumPEDDyyvgSRtJNX7R9WH3ANjCrQuuCVgZBFVgMdEQpTQSIycC9Y74fY4mGVJCbvBobD4O3FwMfRRRIdnidGV2BbsvhJbJG6OcLtiZO+TvQnknEPiXF0i3FmnXJuUCQVId2W85HwB9U6/L7wYUO1WoMq/jvyYleSDscfn4txBUCjR0deFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jyrqM6BYdq4/tGGCsEYs7I3KoZT/7i4eaLyhesxBGQ=;
 b=Rt7l15hKMGPzOqNmTIUEYEZXt9h+tw+L/M5GuPd8fhgNGuxm3xYUHi4v2D3Wh5DxhmPzRidD/8JM2Dzho6yXQS8+k0/0uvlbvW6Qi7J9mbDCTgox5lWkp0gVlAVYJoEycfbD/eBjd0LnMqdSOkcgX5ikXTTkIGqKVqE7N2jZYTSJsGgIP3AQ6gBAYKNL0Ypoq25F4OmXJOsOZYrYQylef3JUTYzhPuRtUwSQPwDp3wYxNvNBl3UVizWbFqE98j0gESVij/ivmpkiiZWqKPia/cHGkVZaxmgOGjsoCFP0nkQkrOQzzQSqk7e6yuuXrBxegN+DsVW/4agOXBhw1CA8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jyrqM6BYdq4/tGGCsEYs7I3KoZT/7i4eaLyhesxBGQ=;
 b=mzU0qNNVPDYGKdUqKxXIoGxAFySsq5XbZTguv0FNHmTUogYYN3i3omq8pVv70Gl+XwaZ5TSjSx8naWSvvpJkij2d4MxOnmhttXyB0Y9LqMrnA0fHmVTqlp1depClJKEddHnO8Q7I5xXIV2YmsCKM9R3BNUMJq8zne+Wvg+HWMN8=
Received: from SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 04:10:40 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::ee) by SN7PR04CA0165.outlook.office365.com
 (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 04:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:35 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:06:46 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 00/12] drm/amdgpu: SVM implementation based on drm_gpusvm
Date: Wed, 29 Apr 2026 12:06:16 +0800
Message-ID: <20260429040628.853079-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: f452c8ed-87db-4d16-a2cc-08dea5a5465f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|13003099007|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: uQ/nQ3tCE/uJiYTKzf+Tsd9gjzi8RET6Sk2BdvdhK6Rn3F9RRP4Zot5Aeo/F8GG8kMwz8v9fQEBs4yHObw2U4bGATEA0KSxpSomutNTmtn8N2TtYJO2misU6sUYkv+na7d/re+ZVkF4jcoCx9B+aceYnEau6ETw4ZUp7fYhMai2e6lwQEXTT1x51F6I3dJyorwCNPXv6BF2NxXlkRRopC1bCWFVzndT2ZC966IwLkpxcUb0O6pvc8qShoeRCoOnH4RmweW66wIgU8ZH9kRMnagNOMwAi/4ZD63P81xpAGjUmJetKAPk3Vhx9RsdvlEibypWtJoIDwrYguMmoQT6eHKdEBl1OeQNt2zy9gfFOkPFBj4MU4GFl7EA7SfqdTh8ox12w/YlgQ0VuelrqkdE4kSuYUIPpwFCopTRpy8gm1fq6jCrooQ6aOv0a2vsnpFl3oc2dqFrBMMS15lbxBGs4wYoWLst2O7iLE9jd1sNotpX/YU6mOi2L7+r6sKMo/GvCdfk54gorvMrSnsaH/JgGlLL94ekDypi+bZnZdOVGH2Tx/TJKIv7VUggJQqKNAzgNsWeefu6WXgWjA6Lt8tGWB1XpVp2FNJLjY4NCu/aisx3oohPiL8sTUGNFGj5P+BC8tVAMy9zqbizt650erapbncojWxf5YATJp84557doVPxwor4nJZhHBo+CdCPpoL2U/gEAYgk4LMIMxuqyp1It6IkC0KmDszEMzsDAFFDTjiwkvrAJ91xr0vplN0V/uH8vCb+zsiuysbe1yDwpEULvZbDCM7NFaL6R/ALBiXuAKOQMj4gEzMyKrtkOuh4F/lcBWwzm9+XZ4pTDvvG+XIdlgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jwAWsHxdKsRsNTIyCrLqgJOWonwj2uYZyyoW75g6ufKnCVSTUQ0WZxQTwMugfd67aGHfXuRikSW0vKLKogxlPeayZ/1IpMoF5jyjbyWB7JxBjDDYU363b0+XmxUQVqqlpl7fcB4fGPbssa4Hnvh1hkgQIcap8709Gw8vYt0jjZM/V3tR0rorD5X0Phfks/1zf4Q9CcXfZuanc24sHewnVN1qIvDY9WWXdWeDg1sJ8fm/a467RgWoVdoc9k72U1ssAVOdg7TQYDQQ8lFWLgjUqCIIgMgw7RCzQ2ZYSgGHoSxjt+mTspO+RuRpRs+EhT3WfDF+821/VxY4Zb/+lxEGR7oDOPvb3cjAuJjuJb/q8puAdXwHnF6vqv0XAevzjpTGMcK9cBs9WVyhKStslDh8pdyGQizxxEVDSQKkd32qVd0YYILnPFIfqKq3+Yr4kGjg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:40.1435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f452c8ed-87db-4d16-a2cc-08dea5a5465f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

V4 of the SVM patch series for amdgpu based on the drm_gpusvm framework. 
This revision focuses on UAPI redesign based on review feedback from V3.

This patch series implements SVM support with the following design:

  1. Attributes separated from physical page management:

    - Attribute layer (amdgpu_svm_attr_tree): a driver-side interval
      tree storing per-range SVM attributes. Managed through SET_ATTR
      ioctl and preserved across range lifecycle events.

    - Physical page layer (drm_gpusvm ranges): managed by the
      drm_gpusvm framework, representing HMM-backed DMA mappings
      and GPU page table entries.

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
                    gfx906 (MI60):99% passed.

Patch overview:

  01/12 UAPI: DRM_AMDGPU_GEM_SVM ioctl, enum-based SVM operations,
        access modes, location values, attribute types with kerneldoc
        in amdgpu_drm.h.

  02/12 Core header: amdgpu_svm wrapping drm_gpusvm with refcount,
        attr_tree, GC struct, locks, and VM integration hooks.

  03/12 Attribute types: amdgpu_svm_attrs, attr_range (interval tree
        node), attr_tree, internal ATTR_BIT flag bitmap, change triggers.

  04/12 Attribute tree ops: interval tree lookup, insert, remove,
        find_locked, get_bounds_locked, set_default, and lifecycle.

  05/12 Attribute set/get/clear: validate UAPI attributes including
        new boolean flag types, apply to tree with head/tail splitting,
        attr_flag_type_to_bit mapping, change propagation, and query.

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

  11/12 Ioctl entry and fault handler: ioctl dispatcher
        (op_set_attr/op_get_attr), GC worker, and amdgpu_svm_fault.c
        with full fault path including unregistered attribute
        derivation and retry logic.

  12/12 Build integration: Kconfig (CONFIG_DRM_AMDGPU_SVM), Makefile
        rules, ioctl registration, and amdgpu_vm fault dispatch.

Honglei Huang (12):
  drm/amdgpu: define SVM UAPI for GPU shared virtual memory
  drm/amdgpu: introduce SVM core header and VM integration
  drm/amdgpu: define SVM attribute subsystem types
  drm/amdgpu: implement SVM attribute tree and helper functions
  drm/amdgpu: implement SVM attribute set/get/clear operations
  drm/amdgpu: define SVM range types and work queue interface
  drm/amdgpu: implement SVM range GPU mapping core
  drm/amdgpu: implement SVM range notifier and GC helpers
  drm/amdgpu: implement SVM attribute change and invalidation
  drm/amdgpu: implement SVM initialization and lifecycle
  drm/amdgpu: add SVM ioctl entry and fault handler module
  drm/amdgpu: integrate SVM into build system and VM fault path

 drivers/gpu/drm/amd/amdgpu/Kconfig            |  11 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 467 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 162 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 994 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 144 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 368 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 861 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 146 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 include/uapi/drm/amdgpu_drm.h                 | 106 ++
 14 files changed, 3336 insertions(+), 1 deletion(-)
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

