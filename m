Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA806CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238E610E2F4;
	Fri,  8 May 2026 07:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JqjQBGy9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6329F10E2F9;
 Fri,  8 May 2026 07:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6+U5uOissHqry0F3W6fu0MCtMH8y+7ksw/D/xwZ8n4bHhvdpXs5XkY5r5UEIn7GFV36x28q56rcbixd+bPzn5svIb3p6pVGkc7It01scvxh+Wl/hqQW162sxlyKru0rDWGlan97uCsfzlBm8rlipo4tzDv2UQ/ISQzsGkHtlxV4LejM++RmO+s+YysaivvvipwKr0/g+WDgidhc3lDsAdrohsfI3CZb55oFou6LPCPWSIa1d9aUjgN8Hwi9EBSfu1O6QmQXyhl/EZl8x6j2FOtSpmC5Xm4TPCWGKQKgJP1jV4gZthTeBCxGd/mN54MHrsLrC34Bq3yN5E7PzGGGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3cKVfZ40dVWKVU9RlpteS7Mwv8K4Lrs+XMkV2vWyQs=;
 b=tH5zFwVhaNB2Ima2NIDs0S6hqQMTfgCaNGujJ5fUdF/iiHAi0telMrYX80eURf347y95YCHRke2dYOTZv5EpOoXNCsRrhim/ACcbbd/ONaZP0GcvhgEGzoekqHp8Ea96LTRBSATg/p5MGUSgzwclK75f8sv3l2j9wW/E3FY+ScB85K9iEJlbEDf+WoTriuvhJ7wkV33vapIYXzmlaGkRlG0M1eVHHXpipFojwbjlF5Zh256fh1LvbXSmT5PMQlx0MBCELZFDvloIKkoOJPH0XYdj2V67ntGae+G7/Y7RDtrKNUwLl7K1K3lpHauv9e08EnoNSdTtGQZOy8tokfeLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3cKVfZ40dVWKVU9RlpteS7Mwv8K4Lrs+XMkV2vWyQs=;
 b=JqjQBGy9H9BAy+H6kxeL4weSZ5FHObUMFiu7eDHlUXEOCjZMWe5/b2iTz363rJbtRFkXyBK3Ebji9LNkaQIE8SwGILrw22bGbxf1MuQOH3K2+g7huQ54xdDzO7t547ZqPvM57EhJZFQgw64Vkl0vt/1b5tAqj54++j2e456U/Ik=
Received: from BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 07:51:47 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::85) by BL1PR13CA0193.outlook.office365.com
 (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.10 via Frontend Transport; Fri, 8
 May 2026 07:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:51:47 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:51:42 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 00/12] drm/amdgpu: SVM implementation based on drm_gpusvm
Date: Fri, 8 May 2026 15:51:17 +0800
Message-ID: <20260508075129.1161157-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ed64d3-0e8c-47da-6a5b-08deacd6a7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|13003099007|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: X0fxA+XHFFIuvDfsHltlp32IYIgswpogU51IDvEygaFVANIKmq/dkxFTZjzd2ImmJ5RNszvGlUQG3mCLXqImWdEOAj5VJSzUYgp452IeKWgK7Q/qafSqDjhAdIqku+MV2eLRZ/NIWt0Q7qtagEr9PkVlzCtmAV1/bUXuKOYlPvrvMkaAJkfVpFmmjxPlTBLjqOozjJq7JLDF/Yo7yos/gy0wSYZ8tRrT4ACoofi9GKC4Qnxtq4ZYmH/pwLuGUyCGJpjkCAE2CdMIXdrLF4ju/TZFNZZrYYiEfTDMiaa7WRuNlIHO4AQkzcvBkx/Zf7uiu+9YjGvxEu6UdFyPMQ8ApjCcyIeZio/0fh3FNkSGJsGt2vkNbZShHkRlP42C2V30+yR1ZeoHrf0L7PfEVaZpV9pwef3BmJ7S+V2cT+ESSIj3dXZbCCae8NnzpRk+AoAQ55kbyoAt/TEbYfiPN3gOylddeb9lQ5XMevh8Z9hgk6eiLS+DCd88BKIYe1LJ4wFGIevH2eQDuhGbjoFZF8qHz8n8v8OEPeVunPB6W0QPxg+yr/Nt3PCrYXhISUJotsb94PBcIUPOrIrmkHYJlWz/66CmUjUqFGygoWRLGShdpmNs/ADngY1oN+jdGhMg9TXAvrfdHvHihav48t+ItI7HKFqhsU8IkFMQMu3br+1XhMtJjffn3utAALI86milZTIBD2+DzlHaEsjkO4Rl46zCivxeJrD3NChFy7IJRXAywbwipBKG8kog9oTs6FC+blS8XwtMTKPuOZkAKvbXCQi7/5is9O4btM//ndvN/X3hb2M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(13003099007)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9vCknP7hFWhyez5KFJFCVMxzkFthHhNqgK62/GUAA7ye5Q4QrFM5fnTuvXxUTZXkkzCah4BRUYx21Mv52ji5LJfYQ/8+sqf+oON3mSsU2Ic1LbI5T2ruMMpWpCtjmXVozxsjWSH0ADd6IiyNQhg2HC5Vk2DTPhkFJm3KIk5T24yhiyTbyye4B9RSqnJdP6ahWoGKeK5+IDz0rcQYqeBx+7r6W4hHi3/zIrlhT6LVfN81KwHX8Fe9N6VlBHCc0YIm2uBTFsWL1nhc5hZLzz39iG+oszqrakrmXpPM/p6aGaY4ZSCSjZ4x+X67xFGD3nCdN/TQcVfHPR8g+VbtGeqKvnGj7i9495XB/nMXrX9mq4dXB912MdDCijH+3iCcYn6dnOwVjWuc+oF6qVwfwFmI9JQQWJxGht6t9bkG4Ib3ia8gf86cQqudlN78uAsHCJE+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:51:47.1300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ed64d3-0e8c-47da-6a5b-08deacd6a7d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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

V5 of the SVM patch series for amdgpu based on the drm_gpusvm framework.
This revision addresses meeting feedback: keep attributes when unmap,
integrate the amdgpu svm into amdgpu vm structure, drop GPU_ALWAYS_MAPPED,
add RESET_ATTR operation, add lock wrappers.

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
    from drm_gpusvm. Attributes are preserved across unmap
    and persist until explicitly reset by userspace via
    RESET_ATTR. No rebuild or restore logic, GPU fault
    handles recreation.

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
                    gfx906 (MI60):99% passed.

Patch overview:

  01/12 UAPI: DRM_AMDGPU_GEM_SVM ioctl, enum-based SVM operations
        (SET_ATTR/GET_ATTR/RESET_ATTR), access modes, location values,
        attribute types with kerneldoc in amdgpu_drm.h.

  02/12 Core header: amdgpu_svm wrapping drm_gpusvm with refcount,
        attr_tree, GC struct, locks, VM integration hooks, and
        lock/unlock/assert_locked inline helpers.

  03/12 Attribute types: amdgpu_svm_attrs, attr_range (interval tree
        node), attr_tree, internal ATTR_BIT flag bitmap, change
        triggers, inline helpers (attr_start/end/has_access).

  04/12 Attribute tree ops: interval tree lookup, insert, remove,
        find_locked, get_bounds_locked, set_default, and lifecycle.

  05/12 Attribute set/get/clear/reset: validate UAPI attributes,
        apply to tree with head/tail splitting, BO overlap check,
        change propagation via apply_attr_change, and query.

  06/12 Range types: amdgpu_svm_range extending drm_gpusvm_range
        with gpu_mapped state, pending ops, work queue linkage,
        and op_ctx for batch processing.

  07/12 Range GPU mapping: PTE flags computation, GPU page table
        update, range mapping loop, map_attrs public API.

  08/12 Notifier and GC helpers: two-phase notifier events, range
        removal, GC enqueue/add, dequeue helpers, invalidate_interval.

  09/12 Notifier invalidate callback: drm_gpusvm_ops.invalidate
        dispatch with TLB flush batching, checkpoint timestamp.

  10/12 Initialization and lifecycle: kmem_cache, drm_gpusvm_init
        with chunk sizes (2M/64K/4K), XNACK detection, GC init,
        PASID lookup, TLB flush, attr_change_trigger computation,
        centralized apply_attr_change, and init/close/fini lifecycle.

  11/12 Ioctl entry and fault handler: ioctl dispatcher
        (op_set_attr/op_get_attr/op_reset_attr), GC worker, and
        amdgpu_svm_fault.c with full fault path including BO overlap
        narrowing, unregistered attribute derivation, and retry logic.

  12/12 Build integration: Kconfig (CONFIG_DRM_AMDGPU_SVM), Makefile
        rules, ioctl registration, and amdgpu_vm fault dispatch.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 585 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 183 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 986 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 174 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 386 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 787 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 148 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 include/uapi/drm/amdgpu_drm.h                 | 106 ++
 14 files changed, 3443 insertions(+), 1 deletion(-)
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

