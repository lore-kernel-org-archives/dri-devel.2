Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDEDC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D1510E939;
	Tue,  4 Aug 2026 09:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pdrf1Vmp";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624E310E0F4;
 Tue,  4 Aug 2026 09:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0iD7Hvr7GyCxigqCFd9ioImWrz+yOpI1f1lReb5PWRUbXPs7J0wUmiq5kS84SSzWFtBAIBFbqE1gh8YOPT9OKmXQ9XwoKPPiZ0hq+ivHaDHLlg0H/W2CB0MTBRNUARlAZiDIBpob70nO965cA1vnEASmi5KhQ1Y3IalXrpQs6JZ3x/PERtSjfb7pIeweTj/E7rfBqTgq6mrLSV0Ae3Eqd4mZYq5MMm4hkoedi0Tt9jVO4jLDPbc05HdAKUrVLcWDPi31a0kYEzlUiJrPz3fp9RfUTFpfK/HNiUjNof3IU7ICxfLS8E+iBMvEhdaIrgM+F5NTxtXgdW6pEHZvaWLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qck6uuM3MM6atdqtgiIdQ0szYsWnWXwqSW1IKqasbsM=;
 b=LddQlOqXYcBIs3E8VzytnfAOAx6jiG0hgWduZO+6jbLyCGhK6/Jd30vJ1BBldCKPkfqIFjyaRtIj87L0JatDrxmgHIBx25+TLfDJRVO3OJvUIG1BSW76vtZmebPFFDMVPpvbzhI/FNyeRqpU4f7wZzSI+dFhBQHJ0e+Jly1G2YcLMuj4i9LP14ydE5N6EmaP/4/o4zkqXrW1oMnrbxSFSPFYB9IJTS2wgY31wloc2TADWKZOPaI36AQr/8HuPxBQxeIZ/JYzIoeQDV/L7z5jCGSk8JP5UGyq5sde22lbcnv7IXmeENpKgHOcPfm4YQLp11qBsAVwmjudWI9ameLtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qck6uuM3MM6atdqtgiIdQ0szYsWnWXwqSW1IKqasbsM=;
 b=pdrf1Vmp/JgDQIrstqIleu891J4xZVbRcVj7JMKhjsQyx8NPD/SNHvrTVbnP+G8jj3/HZYVqALzNIEGzZaJV8ldU8VsdVmkG0nmbLN6x8DSzC7ui1QGxBS9zpmHChfhPJR/u2wZv8w0HPWhYs3HD21k/FotfjG0EXfyiz9myYf0=
Received: from PH3PEPF0000409F.namprd05.prod.outlook.com (2603:10b6:518:1::4f)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:43:04 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH3PEPF0000409F.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 09:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:03 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:42:58 -0500
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
Subject: [PATCH v9 00/18] drm/amdgpu: AMDGPU SVM support based on DRM (Phase
 1: single GPU, XNACK on)
Date: Tue, 4 Aug 2026 17:42:26 +0800
Message-ID: <20260804094246.1719318-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 9804e841-5a4c-43b6-3118-08def20cc7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|13003099007|921020|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: m/doR84VwVwJZfR3BixRMnlq7R4BPZlj4yLMsInk3DDVGXAkxEuB2tTT/h6+4fO1zwGCAr7ml357AMNAPHwhxACXyalzpyoF/pkerQ5dy2fVUG4fTNdgd4cS4H7Z4A+0Ij3DlbAj8M5ZFnVcg+Vu5Ye1E7Q93x5JiJ1/sVNBtXWxBghbikgNxpPYyCx2sNErf+7G29NEOSYcsnHuD00pLOgX/O4OMjevxE0V+bGmXkvG84Dz/kgM2SJp292nWccZfyqIokOCyc1ffhPoZE2/TKH2qf4tSASIMOpAauQYtBnqZaa1xtEhIh9At18+9yWnhOCuJfP+j58CpRXr2f2eDqyrB98fHL4RF/iJn9K8bqXQwYH1WW5u4NX4O5BArCDlleMD8yt/BNZj9epgYCZNyNodUbCZd2x7dj9c0w2yMWTeNg5rdWkRS38jyox6Ckf3f9NSs2P8b1XiApErwRhsw1y+P31Lfce57I9Y2/zVyytMfM60RDPLi0o5/GuMartG2VAWcS/noMSI2mXY+re9U0N5/aK99W1KpOaivvIlwcxh40hXVGFj2+IUGeeCpdPesmi+MMhhwfHG7Pw8J3xzY+HC72nKTRzJ+2ih4j2NhBrtM9Z6gBIpFUCNTwRPa5THyxUu6YpVxTFJahMNr7JDVfYAiQhNN2FANyls7czm/a0gMUhXVS2zVDn548kqJfswQ51ExZRnefq6Q2UvDB9Wd3mmajmrPIDH5Q5rHxl5994XUrSef39VgeswKKtsrSMr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(13003099007)(921020)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rdAEMMMWyOZhZAx3VDMcQAGFse0ro1/LQtAy+mvdrmJULojASpO3TtfeBPUHF+uqBRcO249VBKU8I8o6M6bvNwxn4flX7YXGhdfAMNvi/L+Mfrwi8DxpRn5Yu5d0GG56j1/kilvKRarsKol067L06MSlFhHX6w0rsK59Ww4OKsygHXsX2zn938yz6dkqTX2T0U2Erkm9CpxZlutgZlGxTzSI74D+Gk83xOBLgkXfSk8tQ3KMepZ3U13AnHzbjkmkLROuXm5uPqscx2pOfXoGZJfn6B17XJ9WKk4FTcuPWJeYvFEyUHleRHkIob/dZxrnRtpqSkaDqZOyMS79vacgHYyXV9zm98TcIu747Z6nfAPIMmuc8ZZ/xS0s2JJ2CtPqKJ1Uv9dALgv6mlWEhqrRThdB4/mMJXGrS76QX+nWhUSplEoPzxJN5LFOVOjECdBO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:03.9612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9804e841-5a4c-43b6-3118-08def20cc7e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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
     - v8 https://lore.kernel.org/amd-gfx/20260612090928.29682-1-ray.huang@amd.com/

  * Phase 2 (in progress): single GPU, XNACK off (no-retry / eager mapping).
     - https://lore.kernel.org/amd-gfx/20260529054928.596825-1-honglei1.huang@amd.com/
     - https://lore.kernel.org/amd-gfx/20260605075340.20199-1-Junhua.Shen@amd.com/

  * Phase 3 (in progress): multiple GPUs (XGMI mapping, P2P device-to-device migration).
     - https://lore.kernel.org/amd-gfx/20260603065620.2555316-1-honglei1.huang@amd.com

Accordingly, this first submission targets the simplest useful configuration:

 * Single GPU with local VRAM migration: transparent RAM <-> VRAM page
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

Changes from V8 to V9:
 - This series has been rebased on top of the amdgpu vm fix.
   - https://lore.kernel.org/amd-gfx/20260529114031.3714-1-christian.koenig@amd.com/
 - amdgpu_svm.h: dropped the AMDGPU_SVM_KMEM_CACHE_* macros; SVM ranges use
   plain kzalloc()/kfree().
 - amdgpu_svm.h: dropped the flush_tlb callback; amdgpu_svm_flush_tlb() is
   called directly.
 - amdgpu_svm_attr.h: added kerneldoc for the interval tree and list.
 - amdgpu_svm_attr.c: dropped the attr slab cache; uses kzalloc()/kfree().
 - amdgpu_svm_attr.c: squashed the types header into its implementation patch
 - amdgpu_svm_attr.c: renamed the local "flags" to "unsupported_vm_flags".
 - amdgpu_svm_attr.c: dropped amdgpu_svm_attr_validate_range_vma() from the
   fault path; hmm_range_fault() covers it. A lighter sync check is kept
   only at the set/get attr ioctl entry for fix regression.
 - amdgpu_svm_range.h: AMDGPU_SVM_RANGE_DEBUG removed, replaced by a tracepoint.
 - amdgpu_svm_range.h: dropped the UNMAP_WORK macro.
 - amdgpu_svm_range.c: the fast range valid check is now lock free.
 - amdgpu_svm_range.c: zap_ptes always drains the fence regardless of the
   update return value.
 - per IP PTE flags: moved the switch out of the SVM core
   into gmc_v9_0.c/gmc_v12_0.c behind a new gmc_funcs->get_svm_pte_flags()
   callback.
 - eviction_lock: drm_gpusvm framwork's limitation blocks using the
   eviction_lock kept as is.
 - SVM/BO overlap: dropped the scan-based amdgpu_svm_attr_check_vm_bo() helper.
 - Added drm_pagemap refcount-based deferred destroy for amdgpu_pagemap:
   the ZONE_DEVICE mapping is torn down from a destroy worker
   (amdgpu_pagemap_destroy_work) once the drm_pagemap refcount reaches zero,
   using drm_dev_enter()/exit() to guard against device teardown
 - Added pre_migrate_fence handling in the SDMA copy callbacks: wait for
   outstanding async VRAM operations (DMA_RESV_USAGE_KERNEL) to complete
   before the copy reads or overwrites VRAM, fixing a data race during
   migration
 - In TTM eviction, return -EBUSY directly when mmget_not_zero() fails
   (owning process is exiting), before entering drm_pagemap_evict_to_ram():
   this lets the TTM eviction LRU walk skip that victim and continue
   instead of fatally failing the allocation, while keeping drm_pagemap's
   dead-mm -EFAULT path unreachable.

Thanks,
Ray/Honglei/Junhua

Honglei Huang (12):
  drm/amdgpu: add SVM ioctl UAPI definitions
  drm/amdgpu: add SVM core header and VM integration
  drm/amdgpu: implement SVM attribute tree and helper functions
  drm/amdgpu: implement SVM attribute set/get/clear operations
  drm/amdgpu: add SVM range types and work queue interface
  drm/amdgpu/gmc: add get_svm_pte_flags callback
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c   | 948 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h   | 107 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 826 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 205 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 948 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 202 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 459 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 818 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 191 ++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 120 +++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |  30 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  69 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 119 +++
 include/uapi/drm/amdgpu_drm.h                 | 106 ++
 27 files changed, 5329 insertions(+), 3 deletions(-)
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

