Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073FEC44501
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F7E10EC2B;
	Tue, 30 Jun 2026 10:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QDVMH20J";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E915010EC05;
 Tue, 30 Jun 2026 10:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnTTgr/0LxEK7Fu5adr18i27No7jXUc517UA02YpTcoxNU7uglK2iI+Dlk+3XlwHLkxRSADCf6f8mIhHpKPsF3QnIqxeo56bJ1j+AQn6YyHo8s7gljYsmRs5qxp9Pm5c8WugV0Qs0R+nSbPwHe9eF4ucM2KO6kZ0VYlSZKsGiA7iHYtDIaCXlgLDKHcLLpcwSC7X3L4V4Assn8HDDoy50IUIgxc48rOOumfDZ5SfZTnkX1Q2p2nlMsFEVJqXr4K8yC4zLZidcTUqTAekT0QjcoEadjxPl4VbHC05wzGqOprNoA3mBl3AvA2g+iAmUHlCIAlmPmU84zLsZjj4KhNUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix4G4Eze2w3NSCUo9nvm8aW1Xys3krem4aVai8+Hib4=;
 b=iSAAo0XBwXxiiWh0DTfydE/CfuaW9+DBZG1DqNtmSRRQeD2stOA9SklNKM8HVSXwTqZdadIpsR3YkABBbsxCrObLrJ4jae/b3SQldezzBxfdP69GbhVZ9HDn08+jCoEGHPVtch+IdlRTOmnlqA64wwYhh6om9zlUcfP3YK8eUXiGAcYzsDyZxkqY6BJ82QlKO5LXBA1GRzLvbfdf6m0WMUnRprk4PLz1ytNCeGUWUR9bmfL30gKhm4DTGWntyZchOxbUupY5SEAvFl+UfCl/+zCVdlk4hxRsUYnEtWT4IRD+6FzA8SZzewELoVOoBwM3sSWzbdCg04CRbgWeEWrjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix4G4Eze2w3NSCUo9nvm8aW1Xys3krem4aVai8+Hib4=;
 b=QDVMH20Ja36T2mhZSsJP5hZ6IhB1/8CLpWLQg6z3gZ9qADellgvc8dtKq8h/Cre2bqaG1VOaO1ZPivvWkt08sezGH2UdrIGSbq7MFU+jMcz7Q0Vh80BG3NI0SX+5TOSoTTSYFvjaOrRPbh9FVOFhIor5YjkkB0gxEX1NcH9lzxU=
Received: from BN9PR03CA0068.namprd03.prod.outlook.com (2603:10b6:408:fc::13)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:21:45 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::89) by BN9PR03CA0068.outlook.office365.com
 (2603:10b6:408:fc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 10:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 10:21:45 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 05:21:40 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v10 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Date: Tue, 30 Jun 2026 18:21:22 +0800
Message-ID: <20260630102127.392396-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: d09320ce-0759-4efb-5626-08ded69162dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|22122799003|1800799024|13003099007|3023799007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 3T2Trf3mQpnKpP+Am+NVWmaQTNwtE67fZZckS8bYbIEnCqTrJEV96G1zkGPnlGO5EBYYlIBPzXwEyjHeiGNWR4d/KCoWp9UaWPh/aR6zSSP7G0huRNe5qWgh3GuV6I71JHe7iUxyEBPgfo1hMgNhclt5clfvfYNfC06Kqn/OShM2bBnvYLPaEk6fhgSB18oNCNWWdPG29UBaQPmizXqW73ijIP2KXOrY17IX+VVoi+ksxS7GQ3Vd4u3MzJlTEKln8tWhcGPD6Xt3BmEUjeykZC40DeOar6OyTH0dIlt3PxJD5vtMVT7JYs20k3j7l4mSo7Xvvn7X6dB+uQ166nmp9iGpz4qiQjov0wr2aAaHkca6DIoqkHD9/XLD+tqfOKZ4vSVsAnuUOVqo1RbokwPp568zScL/k64h6bmVODcX/dRVnp0l/d9vixeSAARWMZ+tcE+asfTknI8DED6xXJ5unRxwgl0OQjlvXBe3tcCzSLw17mRXVrWVrLnHKNDp+rT5LLRrxcyvWUyxGoLvEZN3xymD9Y4LjqkTee+kXspsdTuEmzchKmaygk/j6eqcrj/Cv3lK9NPBLUm4yPiMppvuq3nB+4CjGjXUrsW1+VP7QN2O6jiwv3aEgGK7D4NR/RvD0w+FryonoXN26B7ALCt1rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(22122799003)(1800799024)(13003099007)(3023799007)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1jQKutq+y54Tf9yPbcPqG97LG+qj/9+ZVc6NR5nBsVUGtIIPCWgyp7ijDl+/Kdw29cRhjs+7pmwVleNwLSbZvbf5dYO0vyDvgDFQw6FByHlTCc5Er+MVHwdqkpIyxLzxNA/c1f/FIlILKgMkTRWa0/fjvkI4pB3yAK2zzlb0fPJ1JKSBrP8d7xJiBmsxJQL7dSTg+rRFwCwn8xhIe229iD2zmlE/7CoOPI3d5aoVfa9xWXT1osYQPNbP86/sv/qobvKHRQTsFbEFUpuL+ZXIKIPs4ahx4TCefi1Z6SZbDgc3gDbF3VQYZmDbaA6PBaKjHXAy8Ef5bCy3/pfQbj9VceHA+RR2uLx+LUZQrOR8qIONQL2ZiQigObzYUZkpqkspzT+SXUjtORJd+c7cWS96jTpjjLdjHgvRVO0Y2R/HVPON2iY3MLdffGv1xSonoeBX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:21:45.0040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09320ce-0759-4efb-5626-08ded69162dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
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

V10:
  Fix two issues found by the AI review:
  - patch 1: fix a KCSAN data race in xe_svm_alloc_vram(): read
    range->base.flags.__flags with READ_ONCE() and assert on a local
    copy, pairing with the WRITE_ONCE() in
    drm_gpusvm_range_set_unmapped().
  - patch 3: remove the DMA unmap in xe_svm_fini(): since
    drm_gpusvm_range_remove() no longer unmaps synchronously, explicitly
    drm_gpusvm_unmap_pages() all remaining ranges before
    drm_gpusvm_fini().

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
 drivers/gpu/drm/xe/xe_svm.c     |  66 +++++++--
 drivers/gpu/drm/xe/xe_svm.h     |  14 +-
 drivers/gpu/drm/xe/xe_userptr.c |   5 +-
 include/drm/drm_gpusvm.h        |  67 ++++++---
 6 files changed, 255 insertions(+), 142 deletions(-)

-- 
2.34.1

