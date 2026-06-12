Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0038CCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC6010F357;
	Fri, 12 Jun 2026 09:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vQOE2hLF";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF99E10F396;
 Fri, 12 Jun 2026 09:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggy9afsCAm6mRQB52Dw3In95FXEfiINp+rKW3QNolm4/8MFdeR1TX1Ylnotj8U5Nq9GLhjWeza32a0Y5d2eDbC7RwrlTyv3Mz/E0/nX1swdwUHo4MiFXj/0TeLo8tHm2Hlqxck70oZPyDf3aiEj+Eg+gJzh30Q63Vnikd3I/xpEQF9QqmkrY1FYozIHNiB31es7V1E3b0zalXMkmmF92k2kpgI5eLrKNXIa1Dw38emCoszWLIllvUhP4UjHgxtyk+2Civ6t0ECZpvnW9rxsXtYYECayKate7IC896piFp373tDnHjnugtfop8N9GP9KsxgajRcSEhY4pxc7woC993g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxL9GCB5IvdRgiVpU9mkjQ/8bBYdSadWHB7ofjzx00c=;
 b=svLO1AalK24dz0Wb9JgYllUxxvJzpuufreadB5catIRC6PRe0AmNQG81SupDb8S8ym55KHzUfLbp4sL2QVhlWPvWrI4PAoDj3YOLvQvDJKBYqBU8rBSLqxbivoQiJC7VVl6U9csDiM6gqsayjvG/M9LSuqzfQBFxY67+eGvkESg//U/JdjmMEA+/W2M/4BPuulsMzE8hkpZESVWI3StOrL3UuDIRT3y133B05dnHz/V7j+kTibKHtWpoVIPxQNOr9fNp0l15jI2E4r/RI19R2Yqv8l0DPG0uuCRhozuzGrYyHR5M1eYsUWvvh62Heq+aNgIrIXzjvtGrxnxXykAaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxL9GCB5IvdRgiVpU9mkjQ/8bBYdSadWHB7ofjzx00c=;
 b=vQOE2hLFzIXq7hpIpOfZBJTB2ip6cxTRccZ/Zz+9O0ZT2RRq44rtMnUkizUMunmcX946B3ysJqe5ALHcgLDOX7biW8yH9JA/MdEZye3DPUFaPico/PqRFkq7h8GwdM7HuDWJg3Q7pKYnpE4NevIF4NjxReiV9BVnbbXUDQvomnE=
Received: from CY8PR11CA0028.namprd11.prod.outlook.com (2603:10b6:930:4a::14)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 09:10:03 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:930:4a:cafe::9f) by CY8PR11CA0028.outlook.office365.com
 (2603:10b6:930:4a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 09:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:10:02 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:09:58 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v8 00/18] drm/amdgpu: AMDGPU SVM support based on DRM (Phase
 1: single GPU, XNACK on)
Date: Fri, 12 Jun 2026 17:09:02 +0800
Message-ID: <20260612090928.29682-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0578e25d-8ee9-42a7-c083-08dec8626318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|921020|13003099007|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BVMGV5/ASqA3pOXcg16k9RH4Pboej1xgcaw8XzJ1OtNMHZ80j8xNGxy6Syzib8TubbvRuowddD8HRLFhtdsjpG8FLTKrk+fC53c3G1G6VD4p+X3DgxdCoIHnM6E5AeXYrfzq2plVBsA83pNuwWAH36U2Ui26I92qhX2i+4m3aKT1/2kiz7LXY10CXYuv1ZlNBPE4TbCuFWHsLuVlCskkPs2tOh19wf5cQTz9qDNeW3sqyAEwiK1epre+MPt33m1rXzkpcjl2/tGbU5saI9O05SSn7/IoyGLplgkJ+Ao3R7tDyRdcedwBKm9mzWDzCVVRTi5cpYZ+S99aKZ4O1eIlRB0Cl+M8+e3g0pUNC+rAXMJPqC9tQ1HGXzfYWowpbRItIjGciw4z4hInHMusql1OdvECgsYlfZ+g5R0wsAFUJbUuB2Lqubm9sJlRtONVhLAsf3eMYhlbhFpnYrKEwVOcMNrowNfY6nfcHBa8mftOFQjhOBzU5teidpMfsQzErOP+XHQsSe2yy8uY8gVMkB7R/TP5x+LrGMTUuGNgagf2PyQnFOQ2TiqvgMRe9NAuPDzWqQHUJ7/wpgiF+Llr9QvxxdDvS1qVLaLjXfIANwRtgxOKjE65aMfDyZvLsNlMTe2eIBHnLV0Id9fnlFs6tIS/uHQ36/HkPWRoL8jD6ktlTiQCqfy7Kw/lgjzDCusDX83BzZ1+J5aamnMKfjzsi4TPLXXSV+6CQ8HnGT4tNUpit6OWCowIk5j8MK8nsg4eWoyLi56AAUrw5KyiNsD6/GfGHSwburmRDsb9bhvanqIvwaE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(921020)(13003099007)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fJYOECD/xPCPaq5GQYW6v6t6p7ZJwf+2SrG8Dx2wbclX5uJSbogUmZpzipabVlClNSi8oPiel8B5U22SmeoKxfgv0o1WaETiNTa0ec5nklzFW6pz3XtxKXf3KiU6cH3FfKtod1vcjXWBve5vWPUfYgVnji1qtqsQ4tjzR10qhBWo5YBdViKHZK3tvidyVUw1PtqJ5Q0TxTvYmZC7D6DJuc8bICbmGo697vAYaUBp/h5WdxG1+Zs8GeRFa56GiP9siMurqva5BVfjNmoDCLx/OiSnZZSDZJJ5Raz71PRHa99tlYxwD6RIfGvaj+UIjs6xE0ujHqmL9RwUMaBp8XQ0s32xr7jii7B/kJP31lGHIr+hOxrAiOlDb4zaPxHcFf8Dw5Ubo9fGqQ8vhz6nIznKHOjiK1gCRUlMxXl3/i40R7bQNiokfcNqnlfP+J6GpHUB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:10:02.7735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0578e25d-8ee9-42a7-c083-08dec8626318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

Hi Christian, Philip, Alex, Felix, and all,

These series introduce a new Shared Virtual Memory (SVM) implementation for
amdgpu that is built directly on top of the common DRM GPUSVM / drm_pagemap
core (drivers/gpu/drm/drm_gpusvm.c, drm_pagemap.c) rather than on the
existing KFD-private SVM code in amdkfd/kfd_svm.c.

The goal is to provide HMM-based unified memory through the same shared
infrastructure that the Xe driver already uses, so that amdgpu and xe
converge on one well-reviewed SVM/page-migration core instead of
maintaining a separate amdgpu-specific stack.

Phased plan
===========

This work is being upstreamed in phases to keep each submission reviewable:

  * Phase 1 (this series): single GPU, XNACK on (retry faults).

  * Phase 2 (in progress): single GPU, XNACK off (no-retry / eager mapping).
     - https://lore.kernel.org/amd-gfx/20260529054928.596825-1-honglei1.huang@amd.com/
     - https://lore.kernel.org/amd-gfx/20260605075340.20199-1-Junhua.Shen@amd.com/

  * Phase 3 (in progress): multiple GPUs (XGMI mapping, P2P device-to-device migration).
     - https://lore.kernel.org/amd-gfx/20260603065620.2555316-1-honglei1.huang@amd.com

Accordingly, this first submission targets the simplest useful configuration:

 * Single GPU with local VRAM migration: transparent RAM <-> VRAM page
   migration on one GPU via SDMA, with TTM-based eviction for overcommit.
 * XNACK on (retry faults): GPU page faults are retried after the driver
   lazily populates PTEs on demand. The XNACK-off/eager-mapping path is
   deferred to Phase 2.
 * Compute VMs only (amdgpu_vm_make_compute()), matching the KFD SVM
   use case.

Everything is gated behind a new, default-n Kconfig option
(CONFIG_DRM_AMDGPU_SVM) and is therefore opt-in and isolated from existing
users until the feature matures.

UAPI
====

A new render-node ioctl, DRM_IOCTL_AMDGPU_GEM_SVM, lets userspace describe SVM
attributes over a CPU virtual-address interval (patch 1):

  - operations: SET_ATTR / GET_ATTR / RESET_ATTR
  - access modes: INACCESSIBLE / IN_PLACE / ALLOW_MIGRATE
  - location hints: SYSMEM / UNDEFINED (preferred_loc, prefetch_loc)
  - per-range flags: HOST_ACCESS, COHERENT, EXT_COHERENT, HIVE_LOCAL,
    GPU_RO, GPU_EXEC, GPU_READ_MOSTLY, plus a granularity hint

Attributes are stored in a per-VM interval tree; the GPU page tables are
populated lazily on demand by retry faults, or eagerly on a prefetch request.

User Space Work
===============

  - ROCm UMD interface adaptation for the new drm SVM API is being
    developed in:
    https://github.com/ROCm/rocm-systems/pull/4364

Design Overview
===============

The implementation is split into clearly layered modules:

  amdgpu_svm.c            Core context (struct amdgpu_svm embeds
                          struct drm_gpusvm), kref lifecycle, PASID lookup,
                          drm_gpusvm_ops, the GEM_SVM ioctl entry point, and
                          the GC workqueue.
  amdgpu_svm_attr.c       The attribute interval tree: validation, gap/overlap
                          split-merge, SET/GET/RESET, and change-trigger
                          classification that decides whether an attribute
                          change needs PTE invalidation or a remap.
  amdgpu_svm_range.c      Per-range GPU mapping: PTE-flag computation per GC IP
                          version, DMA-segment coalescing, MMU-notifier
                          begin/end handling, PTE zapping, and the garbage
                          collector.
  amdgpu_svm_fault.c      The retry-fault entry point amdgpu_svm_handle_fault()
                          and the fault_map_range() pipeline.
  amdgpu_migrate.c        drm_pagemap / ZONE_DEVICE VRAM migration backend.
  amdgpu_svm_range_migrate.c  Per-range RAM<->VRAM migration helpers.

Fault path (XNACK on):
amdgpu_vm_handle_fault() routes a compute-VM retry fault to
amdgpu_svm_handle_fault() when the VM has an SVM context. After PASID lookup
and a checkpoint-timestamp filter that drops stale retry faults left over from
a recent unmap, it looks up (or synthesizes a default) attribute range and runs
fault_map_range(): garbage-collect -> VMA permission check -> find/insert range
-> short-circuit if recently validated or already valid -> drm_gpusvm get_pages
(HMM) -> program GPU PTEs under the notifier lock with a notifier-sequence
re-check.

Invalidation / GC:
MMU-notifier callbacks zap the affected PTEs (batched, single heavyweight TLB
flush) and, for unmap events, queue the range to a high-priority GC workqueue
that removes it via drm_gpusvm_range_remove() outside notifier context.

VRAM migration (patches 13-18):
A drm_pagemap is registered over the GPU's VRAM as a ZONE_DEVICE region at
device-init / reset-restore time. struct amdgpu_bo_svm (a new BO subtype)
backs migrated ranges, with SDMA-based copy_to_devmem / copy_to_ram callbacks
using a GART window. TTM eviction of SVM BOs synchronously migrates pages back
to system memory, which keeps VRAM overcommit working. The fault and prefetch
paths call amdgpu_svm_range_migrate_to_vram() before mapping when migration is
requested, with a single -EBUSY retry that evicts conflicting pages first.

Test Results
============

Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on:
 - KFD test: 95%+ passed.
 - ROCR test: all passed.
 - HIP catch test: gfx943 (MI300X): 99% passed. gfx906 (MI60): 99% passed.

Changes from Old Version
========================

In this V8 version, we have consolidated all implementations for the
single-GPU XNACK-on mode. This approach follows Christian's suggestion to
make the code review process more straightforward.

Previously, the XNACK-on implementation was split into two parts:

 - Basic V7
   https://lore.kernel.org/amd-gfx/20260529054804.596214-1-honglei1.huang@amd.com/
 - Migration V5
   https://lore.kernel.org/amd-gfx/20260605075340.20199-1-Junhua.Shen@amd.com/

Above two parts are no longer needed to be reviewed separately, please
focus on this series.

Thanks,
Ray/Honglei/Junhua

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

Junhua Shen (6):
  drm/amdgpu: add VRAM migration infrastructure for drm_pagemap
  drm/amdgpu: implement drm_pagemap SDMA migration callbacks
  drm/amdgpu: implement synchronous TTM eviction for SVM BOs
  drm/amdgpu: hook up ZONE_DEVICE registration in device init and reset
  drm/amdgpu: add SVM range migration helpers for drm_pagemap
  drm/amdgpu: integrate VRAM migration into SVM fault and prefetch paths

 drivers/gpu/drm/amd/amdgpu/Kconfig            |  10 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |  11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c   | 848 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h   | 102 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 724 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 197 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 972 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 171 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 418 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 809 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 167 +++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 120 +++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 include/uapi/drm/amdgpu_drm.h                 | 106 ++
 23 files changed, 4791 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

-- 
2.53.0

