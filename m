Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD80CC44500
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA2F10EB9B;
	Tue, 30 Jun 2026 08:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I1Ua5HVX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013043.outbound.protection.outlook.com
 [40.93.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D60610E196;
 Tue, 30 Jun 2026 08:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArTjptDjzQQ4Ocps8CnlXSGbK7f44QR3lH3RZuxvaILvspUBz8CwvxYfQRzNbSI2Rfuwlc+jz0ehiGpuxMF3fsqdcPkAmRRZ671gLQQPxjaCtybs47dgawxe62t/Eo3A5ObPAXJLS8yhJb4DvDUjwlsztpDoC3Y3PJbwz5JzVuUS8hpMXLgb1mMuJxK6QZwY0AFgM1XhFyPaaEwR1pVpFIQiOxwVUFyn1/gEhXqE+7HHcSlW+ZWvXsAaRcpHD4/zcCyxYS/3PcY/7jX/rv9jS9IK6k9ZWz0GQXloAw1s33Fg/5JImUTxfkIDBBcNjNdW6sWCmKS1IWl/iL5pwoNtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5zOzsLwvUrTCpicJig8nAe9Jn+FmlJx6nnf87RK7VU=;
 b=wr/MNlLjOnLsAoPs0914NxmdArgNnAtt0SQ9ZljUKnq12zyciCZubJz7eAD9vmn8mT3HWZEr6n1hDfKqF/QkX4XVb6Sgfcjfv8CXrSZcouFAmcjeHiQCdfjfpxzndvB1tpJ5HGDCrVkyGV6ySB2PPlvCRh7cwhujhJZNOBAzvzeTY+xQvJdsUu5ajLPTTub8VS2n028a+GnxaHMK1SXAcWAavvzvjjevv2Qty0cPgcuRCb36yhTM9RD5p3n7p5bKKO89fbBvMrWkjzWsDbaUldTAGtppRca/00MLywmeR9kxA1vIULkAcvzp640R68EKKi9bAAPGePjyL6vq10SyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5zOzsLwvUrTCpicJig8nAe9Jn+FmlJx6nnf87RK7VU=;
 b=I1Ua5HVXvtxzciFyRhqYLSy/w/wWSymlOdQEvZM1sF2XLBksCZPrZKZpOkl/W3247jYKDHotsFyiqp4ZMvBcRxBgeET/BgEaQY1wdOv6y+t0gPE/q/bLiYth1i+HkYdQvYD9VNabPhT309Z81ZIrfpAHwfoAuPIuZ8K0ubWho4g=
Received: from DM6PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:333::31)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 08:33:55 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::a4) by DM6PR03CA0098.outlook.office365.com
 (2603:10b6:5:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 08:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 08:33:55 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 03:33:19 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v9 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Date: Tue, 30 Jun 2026 16:33:02 +0800
Message-ID: <20260630083307.381909-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: f1eda699-f089-43a6-5986-08ded68252a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|22122799003|23010399003|36860700016|1800799024|82310400026|13003099007|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: wHHHIdMNfp1ya4jBhlEDZ0Dg//vOXl6d4WfXbnLtZ5f0yZij+xtaOLoVkMXxShkDhx1bOt6M/e9hexJkcKMbHZmCRweMBR6mRhyezkqkq1ZAMW6fK9hVVLQ1NOERinXKwngpgdMT+uBjiT1ASzgkqYdR58jJ4aWwKqre3AbUrdg02DtcGdNo16dCWUQurSAlLJXdw+OTIRR/8XKWBbVjUmysRVYxCbm4e0nYbjgaxtT3nPYoDrBlyBX64pi7cP70LxE0woFlz3TSzT7zRoLbEZ97jNGrFb/wEu+OnsaYlCBp9zuM/bV2+0aaark5T+afe57P2zb5OtXcOMtGaVO+2W8OQDovM+nlL7EEtuN6GKewEIS50Luc410D3fk8r7W68xKfVcR7TnxLY5a27PbXJCQX1w4WErfzAzbWKBaqsnRz3FwrQZfqAMGMYpdAF/Ef+KzYJJj9qTy/K1ehHK6ErcN5CzCjJIQzFuX4apqjtHCATd3SkIva+vdZH3uvmo7FsIbA2VUFhy29h4jICNAXdSzHl/WvRaP0iLhMR58BHRsMFjolRkwSKOcvbXgWuGmcAUOlqVQvLJuAhp7VshuI+eTi7ihn+xBrjmLZJOTcElYJFgyKZ5HuAqrPY897CHMIDDmCfvL/xLiDb2yQnf84PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(22122799003)(23010399003)(36860700016)(1800799024)(82310400026)(13003099007)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4e77Iz4mf9IGUPu5yOwyryXirqjUv1zIjVPvHcjhaS0IXsOX6fw1aREsXf8WhHQ9j+oGHMJYHshxT2/Ci6O2EtsogEXGBw+GNbZDZaP8FUmVPwk9rprB0k+siYwnlMYlbCnDNZRbeyJ82yKm74feyah9wHdP11Om+HRTLfukFzbGO6jYQmQhNgWj0vfl6sFgZ+qD75uwyrL9qD0nAAPr63DI4wjqY9qPO09oVarjFOt349hpnckqIMd1KwxU81F/x2uGvJpZIUwkTpRSPHCbRIMN3xj7VD8xiPE/S4op6r923ue905J/OOGLdTvGWC2Qc4LhLTuQUH5uJMKLfXU/lJINaD06sAMJ88utVzA4UCywWQjFNxnF+O+dgDJJe0RHQUwIzqVJO5wBcJp/Cl9kUPFmmNmQHK4aB24mbctQXduhg9HGzA1RDTr1fxi4fYrS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 08:33:55.2767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eda699-f089-43a6-5986-08ded68252a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

The intent of this series is to make drm_gpusvm more flexible and give
drivers more freedom over how they assemble the MM related and device
side operations. It implements the direction Matt suggested in [1]:
Mirror MR in gitlab: [4]

  - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
  - Embed a struct drm_device in struct drm_gpusvm_pages and drive all
    DMA through it.
  - Drop struct drm_device from struct drm_gpusvm.
  - Have the driver's range structure embed one or more struct
    drm_gpusvm_pages in addition to struct drm_gpusvm_range.
  - Drop the range-based helpers (drm_gpusvm_range_pages_valid,
    drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages) and update
    drivers to use the drm_gpusvm_pages helpers instead.

In essence the series does only two abstractions, plus the xe
adaptation that follows from them:

  - range vs pages: split drm_gpusvm_range (MM / VA range state) from
    drm_gpusvm_pages (device physical related), so the two sides can
    have independent lifetimes and ownership.
  - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
    the device side down onto drm_gpusvm_pages, which is where DMA
    actually happens.
  - xe is updated to fit the modifications, no functional change
    intended.

V9:
  - patch 3: fix the build with CONFIG_DRM_XE_GPUSVM disabled: move
    pages out of the nested base struct in the stub xe_svm_range and
    route has_dma_mapping through range->pages. No functional change.

V8:
  - patch 4: add reviewed-by for Matt's review.

V7:
  - patch 1: split MM state flags: the AI review found a KCSAN / memory
    model cleanliness issue. Address it for consistency with
    drm_gpusvm_pages_flags, set the range flags with WRITE_ONCE() on
    __flags and read them with READ_ONCE().

V6:
  - The AI review flagged a potential DMA free issue: the DMA unmap
    step was moved into the range_free callback, but on the invalidate
    path a range can be removed from the MMU interval tree while its DMA
    mappings are still live, so a concurrent unmap event can miss it.
  - patch 3: have xe_svm_range embed one drm_gpusvm_pages: explicitly
    call drm_gpusvm_unmap_pages() before drm_gpusvm_range_remove() in the
    garbage collector, so a range is never off the tree while still DMA
    mapped, and document this caller contract in drm_gpusvm_range_remove()
    kernel-doc.
  - patch 4: move struct drm_gpusvm_pages out: document the
    unmap before remove contract in the garbage collector example and
    note that range_free()'s drm_gpusvm_free_pages() as a final fallback.
  - patch 1: split MM state flags: return -EACCES directly.
  - Fold in the pre existing IOVA/DMA unmap fixes the AI review found
    previously sent separately: the uninitialized dma_addr[0].dir on
    the get_pages() error path, the whole reservation IOVA free for
    mixed ranges, and the device mapping leak on the get_pages() error
    path. [6]

V5:
  - add reviewed-by in patches 1, 2, 3, 5 for Matt's review.

V4:
  - drm_gpusvm_init_pages(): memset() the pages to zero before recording
    the owning drm_device.
  - DOC: overview: recommend a zeroing allocator: kcalloc() for the
    N:1 pages array.
  - Rebased onto the latest drm-xe.
  - The AI review of this series flagged two preexisting issues in the
    IOVA unmap path that are not introduced by this series; they are
    fixed in a separate series [5].

V3:
  - Fix a kernel-doc/Sphinx warning from the kernel test robot: use
    ".. code-block:: c" for the drm_gpusvm_pages example in DOC: overview.
  - drm_gpusvm_range_set_unmapped(): use WRITE_ONCE() on the whole
    pages[i].flags.__flags word to pair with the lockless READ_ONCE()
    readers and avoid a data race.
  - xe_userptr_setup(): call drm_gpusvm_init_pages() before
    mmu_interval_notifier_insert() to avoid exposing uninitialized
    pages.drm to invalidation callbacks.
  - Fix per commit build of the set_unmapped() pages.

V2:
  - Followed in Matt's v0 review fixups [2]:
     - keep unmapped flag in pages structures.
     - add pages_count to drm_gpusvm_range_set_unmapped() to set the pages
       unmapped flag, so the framework can check unmapped status in
       drm_gpusvm_get_pages().
  - Add drm_gpusvm_init_pages to init the drm_device and sequence number.
  - Remove drm_device from drm_gpusvm_get_pages() parameters.
  - Reworked the DOC: overview and usage examples to describe the new
    model: struct drm_gpusvm_pages, the 1:1 / N:1 driver layouts, and
    examples that operate on a driver embedded pages object by the
    drm_gpusvm_pages helpers and etc.
  - remove WARN_ON_ONCE in __drm_gpusvm_unmap_pages.
  - Dropped RFC.

Follow-up (not in this series):

  - modify drm_gpusvm_get_pages() to support one time hmm range fault
    and multi drm device dma mapping.
  - Add no dma device support for drm_gpusvm_get_pages().

tests:
AMDGPU:
  based on amdgpu adaptation patch in [3], but still SVM:DRM = 1:1,
  1:n is on going needs many modifications and testings.

  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 99% passed.
                    gfx906 (MI60): 99% passed.
INTEL XE:
  CI tests passed in rev5 tests.[7]

links:
[1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
[2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
[3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
[4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360
[5] https://lore.kernel.org/all/20260627033325.3795298-1-honglei1.huang@amd.com/
[6] https://lore.kernel.org/all/20260628061757.4093701-1-honglei1.huang@amd.com/
[7] https://patchwork.freedesktop.org/series/169384/#rev5

Honglei Huang (5):
  drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
  drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
  drm/xe: have xe_svm_range embed one drm_gpusvm_pages
  drm/gpusvm: move struct drm_gpusvm_pages out of struct
    drm_gpusvm_range
  drm/gpusvm: let the drm_gpusvm core context purely MM level

 drivers/gpu/drm/drm_gpusvm.c    | 243 +++++++++++++++++++-------------
 drivers/gpu/drm/xe/xe_pt.c      |   2 +-
 drivers/gpu/drm/xe/xe_svm.c     |  49 +++++--
 drivers/gpu/drm/xe/xe_svm.h     |  14 +-
 drivers/gpu/drm/xe/xe_userptr.c |   5 +-
 include/drm/drm_gpusvm.h        |  67 ++++++---
 6 files changed, 238 insertions(+), 142 deletions(-)

-- 
2.34.1

