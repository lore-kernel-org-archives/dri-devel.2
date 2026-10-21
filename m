Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF8606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DxzEduj8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6479D10E2E6;
	Wed, 21 Oct 2026 02:59:42 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EEAA10E2E6;
 Wed, 21 Oct 2026 02:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkKD9iYB94DEm5FGJtSLYXXZAy8WKYFEWESIr/WGlS68e48JltqTfRPn2ARHT+yur/tGg+aId/dUY4DP7YVNoV41ss1w++diee35QsQxtC6U9ld9lYzA+BkHtXDqE0njzjECD7u3kdMEHOdFN6ygFGMlsFI4+h8yUa0y+dEVh7QCLDMm+nD0VjvPsvXr1PHyI9kilqt9Hn9HdYxvRQz5AdMRECUXM54hCti/Un0YjuxrOf4vgNV7U3YX6QIdCqAM8SRTU+G31o2+ivucexohWTcwQ4EX1avFO4hsngIrNlkr5F+L1HSvxHkQsmcR/JVdwkYHOHyUc8WD8c1Fx/LPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsW8u8exu7g8SDTqfYhajKzc/w7icRrAiLyf54Ooa2M=;
 b=tXVvZIRQRUuEm/h9662bGAdHLbvfR1gqhBZDgK0FEQCjdMV+bkzePW7eFpzZTbDuRfYwcrdpjiwf0hi+wTR8U+59IcDToTpLuW91O4BOVeTH4STwkSv/prg5RSLa3ByEPnu15A28Adh+ntAz0LZykSbNSaHt8h9LpbqvW2kvC3yfXDE7U2acQE9t+2vVek32pYmjxe+gsJKIRdJ6fdcIj0sa9EIITqy0VQk5MsYVhrx7w0pUxhnjdBryJk/qMjXlpEZpwlBocyF2XZS/GnbbkEZrOtsuAmmsJxjGq+CgsD6motOnxICQx+8aSA0hthiY0/4fEjP3cwLfpzQdfFYZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsW8u8exu7g8SDTqfYhajKzc/w7icRrAiLyf54Ooa2M=;
 b=DxzEduj8EMHjX5C92BYJHhDElQ26VrjFntxmdCo5LhkJm3jIfqnIjPwLuN1BLvnOCsY8iA+fpGkb6majejWHb4kOlnAPnYecQoyPAxYMBCsIz9dvVYiyOvrG9KDYcfmbyWpwETgYgTbkX/yoc/6oRq8XFYBf/aRAhl06jQhd9JM=
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:59:30 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::a5) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 02:59:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 02:59:29 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:59:23 -0500
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
Subject: [PATCH v10 00/22] drm/amdgpu: AMDGPU SVM support based on DRM (Phase
 1: single GPU, XNACK on)
Date: Wed, 21 Oct 2026 10:58:39 +0800
Message-ID: <20261021025915.2433837-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: b749a225-6627-4c48-231e-08df2f1f5374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|921020|56012099006|261009221227099003|11063799006|261009223027099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: bU6bI4FbFYDAui/op3GQ9oCj14x8AHqHi6AHvTDDecXukhXyl0+5EQpTS5Y1VTRlWjOFJbiMZP314b4DgZmWQA3p9Njc4cakpIAsnfznKAyuUvfHiyTKtFlfu7DLEmwuUVPg/ArmTJ7IB4r6xBTp31/hBzwXIMIXQeZcU51oPgWfSTDeZfuzCaqnBW+78I7Jmsarkl145hYBPNAzqE0AIVDmJk6VIkaAwKXaPn+31bmgNFFnEj0iny5YI9XICStmeLFc6gpx50Q+hYe8eYrNg67XHxk+V4OS7+zYB7zLOp3elzRmM9j/q/woyM4djwxE/QHue6qz9nCIgKqxAnaXyWGisqnrS0/mG8IFWVSDhSlWKKq2o2E1aQ7b2/OyYVePh1AXZBnNpQCaolxBreJgnHMI0qcqMlZJLD8SACTr92ZFgh2E9XlpEe5i44yZa54jy4ftyU1LiP2wNEA9xy8SVwnWHrD8HJj24E8m+qE2mp5mDOsmmYA+znsqDfkuULkbDdKxn4/wSQWj3/TpYem34zq74+X8hPb3Zs8BpRJWFWP6GA0LB6xZBceEp+L44rbctl0n8StAqQn4sT0pOxooDItSpmVoxD7OrChhCIgQYwea3APNKcWFxe6uqPS3ZwktrIDgXmzyiERw3fiHzZ02/wTyVdEmUxfJTttWmGrs3hCXzWuW8asYPr8tVLl3eTjQA6jAj4DubAcbwCsZe+tsKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(921020)(56012099006)(261009221227099003)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6VjrJnPZBQuzRVlcmkd2foKe7QcIiIlXHVBc3DGIbAk/ug2jUJBq0x4DZ20KpSjSBXu3WoN51Ekpo4vt1gTAA/ARoVsUtBuz0fjhPqtcrVtqoDrewSv+Vnecf1iV07idLsubsf4vcRSZqYLaC4agtwEmoi1rlEG6MPYaI4rdk6G1f6Jdxb6vABUDEmNy/PqZfQo07o+EcZo9uK/vFuvU8WCvORKPq87hgFghUAciVawveatumPkEP8q2JhLDwMNaNjWK4wnxYa+YaFH5bqKVOiyjsLqvnhn/noDrAmnMDn/MuNUE95WsySGxCrgN8efKyNrdKIOQTJ2YHKq3zotnL5YstLT4RPb/AFIDUnl892EhRAcVx8B/QDh6BXO7GNwFASmWV2rcMdSOY6PRdX5XzxKkT8Ggh6E3Twi8lRulo44GAmhDbGilbVAMEuDPuDuB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:59:29.9252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b749a225-6627-4c48-231e-08df2f1f5374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian, Philip, Alex, Felix, and all,

These series introduce a new Shared Virtual Memory (SVM) implementation for
amdgpu that is built directly on top of the common DRM GPUSVM / drm_pagemap
core (drivers/gpu/drm/drm_gpusvm.c, drm_pagemap.c) rather than on the
existing KFD-private SVM code in amdkfd/kfd_svm.c.

The goal is to provide HMM-based unified memory through the same shared
infrastructure that the Xe driver already uses, so that amdgpu and xe
converge on one well-reviewed SVM/page-migration core instead of
maintaining a separate amdgpu-specific stack.

Dependencies
============

This series is rebased on top of Christian's amdgpu VM rework series and
depends on it. The SVM locking work in patches 13-15 builds directly on the
eviction-lock critical section and the amdgpu_vm_update_range() split
introduced there, so this series does not apply or build without it:

  https://lore.kernel.org/amd-gfx/20260928151041.1857-1-christian.koenig@amd.com/

Phased plan
===========

This work is being upstreamed in phases to keep each submission reviewable:

  * Phase 1 (this series): single GPU, XNACK on (retry faults).
     - v9 https://lore.kernel.org/amd-gfx/20260804075417.1234567-1-ray.huang@amd.com/

  * Phase 2 (in progress): single GPU, XNACK off (no-retry / eager mapping).
     - https://lore.kernel.org/amd-gfx/20260529054928.596825-1-honglei1.huang@amd.com/
     - https://lore.kernel.org/amd-gfx/20260605075340.20199-1-Junhua.Shen@amd.com/

  * Phase 3 (in progress): multiple GPUs (XGMI mapping, P2P device-to-device migration).
     - https://lore.kernel.org/amd-gfx/20260603065620.2555316-1-honglei1.huang@amd.com

Accordingly, this first submission targets the simplest useful configuration:

 * Single GPU with local VRAM migration: transparent RAM <-> VRAM page
   migration on one GPU via SDMA, with TTM-based eviction for overcommit.
 * XNACK on (retry faults): GPU page faults are retried after the driver
   lazily populates PTEs on demand. The XNACK-off/eager-mapping path is
   deferred to Phase 2.
 * Compute VMs only (amdgpu_vm_make_compute()), matching the KFD SVM
   use case.

Everything is gated behind a new, default-n Kconfig option
(CONFIG_DRM_AMDGPU_SVM) and is therefore opt-in and isolated from existing
users until the feature matures.

UAPI
====

A new render-node ioctl, DRM_IOCTL_AMDGPU_GEM_SVM, lets userspace describe SVM
attributes over a CPU virtual-address interval (patch 1):

  - operations: SET_ATTR / GET_ATTR / RESET_ATTR
  - access modes: INACCESSIBLE / IN_PLACE / ALLOW_MIGRATE
  - location hints: SYSMEM / UNDEFINED / LOCAL / HIVE (preferred_loc,
    prefetch_loc). The location is a fixed enum rather than a device file
    descriptor on purpose: a descriptor has no stable meaning across a
    checkpoint/restore cycle.
  - per-range flags: HOST_ACCESS, COHERENT, EXT_COHERENT, GPU_RO, GPU_EXEC,
    GPU_READ_MOSTLY, plus a granularity hint

GET_ATTR additionally returns, in @size, the length of the contiguous range
starting at @start_addr over which the queried attributes are constant, so
user space (e.g. CRIU) can walk the whole address space without knowing the
range boundaries in advance.

Attributes are stored in a per-VM interval tree; the GPU page tables are
populated lazily on demand by retry faults, or eagerly on a prefetch request.

User Space Work
===============

  - libdrm exposes the new SVM ioctl:
    https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/485

  - ROCm runtime adaptation for the new amdgpu DRM SVM API:
    https://github.com/ROCm/rocm-systems/pull/8318

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

Locking (patches 13-15):
Following the v9 review, amdgpu_vm's eviction lock is now a selectable
read/write semaphore (struct rw_semaphore *eviction_lock) instead of a
private mutex. On an SVM VM it is pointed at the drm_gpusvm notifier lock,
so page-table updates, MMU-notifier invalidation and TTM eviction all
serialize on one lock rather than on separate, unordered ones. Updates made
with the root PD reserved take the read side; updates without it, and
eviction, take the write side. Because page-table allocation can enter
reclaim - and reclaim re-enters the MMU notifier that wants the same lock -
the lock is dropped around amdgpu_vm_pt_create() and the range sequence
number is rechecked on reacquire, returning -EAGAIN if it moved. Plain
graphics VMs keep their own default lock and are unaffected.

Invalidation / GC:
MMU-notifier callbacks zap the affected PTEs (batched, single heavyweight TLB
flush) and, for unmap events, queue the range to a high-priority GC workqueue
that removes it via drm_gpusvm_range_remove() outside notifier context.

VRAM migration (patches 16-22):
A drm_pagemap is registered over the GPU's VRAM as a ZONE_DEVICE region at
device-init / reset-restore time. struct amdgpu_bo_svm (a new BO subtype)
backs migrated ranges, with SDMA-based copy_to_devmem / copy_to_ram callbacks
using a GART window. TTM eviction of SVM BOs synchronously migrates pages back
to system memory, which keeps VRAM overcommit working. The fault and prefetch
paths call amdgpu_svm_range_migrate_to_vram() before mapping when migration is
requested, with a single -EBUSY retry that evicts conflicting pages first.

Patch 16 ("drm/pagemap: fix page undercount for compound src entries") is a
prerequisite fix in the shared drm_pagemap core, found while enabling THP
migration on amdgpu. It is independent of this series and can be applied on
its own.

Test Results
============

Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on:
 - KFD test: 95%+ passed.
 - ROCR test: all passed.
 - HIP catch test: gfx943 (MI300X): 99% passed. gfx906 (MI60): 99% passed.

These numbers come from running the existing KFD and ROCR test suites over
the new DRM SVM path, which is enabled by:

  https://github.com/ROCm/rocm-systems/pull/13719

IGT test suites covering amdgpu DRM SVM directly will follow.

Changes from Old Version
========================

In previous V8 version, we had consolidated all implementations for the
single-GPU XNACK-on mode. This approach followed Christian's suggestion to
make the code review process more straightforward.

Previously, the XNACK-on implementation was split into two parts:

 - Basic V7
   https://lore.kernel.org/amd-gfx/20260529054804.596214-1-honglei1.huang@amd.com/
 - Migration V5
   https://lore.kernel.org/amd-gfx/20260605075340.20199-1-Junhua.Shen@amd.com/

Above two parts are no longer needed to be reviewed separately, please
focus on this series.

Changes from V9 to V10:
 - Rebased on top of Christian's amdgpu VM rework series (see Dependencies
   above), which this series now requires. The GEM_SVM ioctl number moved
   from 0x1B to 0x1C.
 - eviction_lock: the V9 limitation is resolved by three new patches
   (13-15). amdgpu_vm's eviction lock becomes a selectable rwsem aliased
   to the drm_gpusvm notifier lock on an SVM VM, so page table updates,
   MMU notifier invalidation and eviction serialize on one lock. It is
   dropped around amdgpu_vm_pt_create() to avoid the reclaim/notifier
   recursion, with an -EAGAIN recheck on reacquire.
 - Added "drm/pagemap: fix page undercount for compound src entries" as a
   prerequisite, and made the SDMA copy path folio aware, so THP-backed
   ranges migrate correctly.
 - UAPI: the location enum gained LOCAL/HIVE and UNDEFINED changed from
   0xffffffffU to 1, replacing the AMDGPU_SVM_ATTR_HIVE_LOCAL flag.
   GET_ATTR now returns in @size the length of the range over which the
   queried attributes are constant, so CRIU can walk the address space.
 - Review fixes: the GEM_SVM ioctl no longer creates the SVM context
   lazily, the missing root BO reservation around context create/destroy
   was added, the mapping publication moved inside the notifier lock, two
   range-queueing bugs were fixed, and several error paths now report
   failure (-EPERM on a write to a read-only range, -EFAULT on a missing
   VMA, unknown attribute values, TLB flush failures) instead of being
   silently ignored.
 - Cleanups: dropped the private log wrappers in favour of pr_debug() and
   pr_err_ratelimited(), partition-scoped TLB flushing, kzalloc_obj(), and
   removed the leftover clean-svm Makefile target.

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
   into gmc_v9_0.c/gmc_v12_0.c behind a new gmc_funcs->get_svm_pte_flags()
   callback.
 - eviction_lock: drm_gpusvm framwork's limitation blocks using the
   eviction_lock kept as is.
 - SVM/BO overlap: dropped the scan-based amdgpu_svm_attr_check_vm_bo() helper.
 - Added drm_pagemap refcount-based deferred destroy for amdgpu_pagemap:
   the ZONE_DEVICE mapping is torn down from a destroy worker
   (amdgpu_pagemap_destroy_work) once the drm_pagemap refcount reaches zero,
   using drm_dev_enter()/exit() to guard against device teardown
 - Added pre_migrate_fence handling in the SDMA copy callbacks: wait for
   outstanding async VRAM operations (DMA_RESV_USAGE_KERNEL) to complete

Thanks,
Ray/Honglei/Junhua

Honglei Huang (15):
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
  drm/amdgpu: make VM eviction lock read/write to match notifier lock
  drm/amdgpu: recheck range validity after page table allocation
  drm/amdgpu: use drm_gpusvm notifier lock for VM eviction

Junhua Shen (7):
  drm/pagemap: fix page undercount for compound src entries
  drm/amdgpu: add VRAM migration infrastructure for drm_pagemap
  drm/amdgpu: implement drm_pagemap SDMA migration callbacks
  drm/amdgpu: implement synchronous TTM eviction for SVM BOs
  drm/amdgpu: hook up ZONE_DEVICE registration in device init and reset
  drm/amdgpu: add SVM range migration helpers for drm_pagemap
  drm/amdgpu: integrate VRAM migration into SVM fault and prefetch paths

 drivers/gpu/drm/amd/amdgpu/Kconfig            |  10 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c   | 899 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h   | 107 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 858 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 196 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 977 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 202 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 476 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 812 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 191 ++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 120 +++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |  30 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 111 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  19 +-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |  32 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  69 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 119 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   7 +-
 drivers/gpu/drm/drm_pagemap.c                 |  60 +-
 include/uapi/drm/amdgpu_drm.h                 | 127 +++
 36 files changed, 5541 insertions(+), 85 deletions(-)
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

