Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D57FC43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D3110E5BC;
	Sun, 28 Jun 2026 11:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="49+8KVKz";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4465010E0C2;
 Sun, 28 Jun 2026 11:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr0VO2HRLtcwfNoDvu+kKtTBAOATXvcoBOyAxM98v3H5dBZ+iHwUg+CVgBRghfuGQ8yxJ6/jry+v7N+xlw8SuZ9Fqkj4o7pYcff2leD48wk/7gK6cb73dPkX7hzyeY7kXXXKq3b34Aeda4XC9Oq/i9DlsUlpaFH9UZmj/n4MRnvs8z89IegeGOJ2Uo3WQKyH3o//ejctXp6BNhHUQmwsnrc1B6MsLxXXVVg6F3bElpcTAHUSkykJyoW1X3/NfB8EXlThtD7PyX9PdMZNyI3/AQ9P6GjQE+0T2kAQE0Lsx2T2KO6N2yEpilYFE2chUee0b4/heGgzzmVOZreByx35Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37fJBfIZwY4YnnHhm3Nus45J0KY2uQzR73St+CdgmVc=;
 b=itX0BvLpuP5f8NLcnviM4BUri9lUra8r893lB6usiW2l6cCI0lQh7LFZVROpzAkZNLo6NU01+ZKFmKNvqbUb5o589GtacftUTKE+hOLcNsGCnCXsQ3DL0hAKGtjpMhA3CyC0Q67lVGO7gumEY7arAifByjCLK0eMeoPsZYIqQVHuZxQ0fREPcgv/8884tqgXwy0QsJIwHo9bJ5cTXQ8x1wLWa/m+jV9fDBzSy4G8M/a6+jU6FArczx1SAGYrwymgmgnmbLurgH3l4invwPs2XUoE9FlcL0YqNzEAI0KRrinT/6OfJsP5bq+Mo8sJTzZMkn0QNN3BzVa0MP795N81CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37fJBfIZwY4YnnHhm3Nus45J0KY2uQzR73St+CdgmVc=;
 b=49+8KVKzILITtbSvaxlqcLNCiPUPnOmQFVP/xJVjglqy0i52lNiB/TyOkPTfzRp6LhS63vx52zv1TX+WhDmmDJfoBioSMvY0j3RGoSwmoZYa/5yoOFUQe3FPA8DsufsP+ROKaabvXvUh6ZEorb+yPd/v8YPMPXtmgcBt+5FI0ck=
Received: from BLAPR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:335::10)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 11:15:18 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:335:cafe::4b) by BLAPR05CA0029.outlook.office365.com
 (2603:10b6:208:335::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Sun, 28
 Jun 2026 11:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 11:15:17 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 06:15:13 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v7 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Date: Sun, 28 Jun 2026 19:14:50 +0800
Message-ID: <20260628111455.9831-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbbcf1d-f5b0-4c29-2c07-08ded50688c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22122799003|23010399003|3023799007|18002099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: hGekub28J0OootGyDGO58+tmFhGPhXtwtzTG8FhUQHTdHMhQJBfZDG5tUe18wBmagMY/6WBsYaHRzHSQQ9ChoBzz7fvFSo8jgDNe/gBoHVspE8802S80dUdRiCWLlIlHC0TaWpQ4mTx9nJ1Cf1YxRMSSYYG+EkMJ/8/JquQZI9s7XwAHrpWqwFpwiB8vtQiJF96hgyyTWCtR7ZmEqY8W+QlFl9BXNs5nk/vbgCRU0FtK0ZjZmICcxfrBbO7rctExKA40ku+A5sMFiIrRYAsybkr5uQ057+6xT8+xjLY+PWr2PB8RWQ4s3eRfxitO7frjXQp0OtPumDvZi/ZWckjf66g2jP+xLOTQJTQ+AWdO3XAjknMMPdNobUYMzm58NjdOEfQOSISs0b8fBjy/HbuxAygvexoU/PmARMvYyJJs1wy0EuP2WtEipunzsez5m56Cgm19KvcU+TYsXddRvd5Ifer2LMRpTki5mbtvCVOf1gpf6poNjgJFI10ezt5fN4DBBtxWPFSjlwRdPvbJjusEpBIrRGPVyjscMhETVntmzj4WGOfc1mnC+Bx5iU0oJ0HOQr5OqvGAdWAPfPO59ZgAj5E9wohUwTduqRR437wIMF1ylODrsnrzGnN7uPXhjEqnZP4osMvxAGMR20MDQepQ0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22122799003)(23010399003)(3023799007)(18002099003)(11063799006)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4CFiiaZ6Nxl03vmOn9RkSqGu30Vl1ZjBnPUsvDrJV/t1V7tpevd9YPzqNKLVjg0BVfxpoeHoNOVtPxW7EHOyYrwlAe7h/BbFG/vS1zB0+77iQuf0FfXp1uoeDuPyNVP94qzpK8Lo9AGYlZl/4M+fPs8UhN+h5f7YOubdzzUOZv3fEWmx+YOfvFS0JsU0aLtCNrs+uTv/dgxC0LdJEgpx3SsLD4tE/m3N6iKRM2eqvTuwZwayOczogBGdNvrXDvk1LyWQbP8F++npsdD4VYW3KJ/oElPNRweynSSjIuQyG0yKQhvXIRvh9VlaJ1xQ1hUZ/7ft2yUfJtMer06+4xWNcNOhBYxK+QYKaQgsUHmFoTaj1PV2h7O38T1C8qvzLQkwXu1+lH6wa6namARJrSRfXiBHY8rQEL47lzVgyU2ut/pLlcDi32MmuwXuOtDUL2lj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 11:15:17.3617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbbcf1d-f5b0-4c29-2c07-08ded50688c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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
  Waiting for the xe driver git lab CI result: [4]

links:
[1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
[2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
[3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
[4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360
[5] https://lore.kernel.org/all/20260627033325.3795298-1-honglei1.huang@amd.com/
[6] https://lore.kernel.org/all/20260628061757.4093701-1-honglei1.huang@amd.com/

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
 drivers/gpu/drm/xe/xe_svm.h     |   8 +-
 drivers/gpu/drm/xe/xe_userptr.c |   5 +-
 include/drm/drm_gpusvm.h        |  67 ++++++---
 6 files changed, 235 insertions(+), 139 deletions(-)

-- 
2.34.1

