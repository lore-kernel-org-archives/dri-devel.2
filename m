Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE463C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 03:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC83610E15B;
	Tue, 30 Jun 2026 03:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RG/NKNqz";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CD010E155;
 Tue, 30 Jun 2026 03:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvY1c3FCKn8ktF6JSgZg0Pk3385Z/8045KVIZg/sb1fQF1JF6yuZJqBK743mo3YRtsjf0/sAC/ynxMM5mjdx7m8jF4sU58UfPKZiWjKR70xMvpGNT1zo0dNTdyulyUJhRGxh6TDFMajznfmDA/CkLy8+UtqFCDu8U1jSXcGjQ0YopFQdI04kDY4BxVHhViBuAiVNXwYFAwG+yfDxFh5E6MaUfh84aU1pKwVI6iuRZHKXn5P2oB0KAtqhpGeuf5FBapZzSR9fpx0BXMpA8BBMvYumqc1EDjFZ7faqDBUxh8qkpVu3TQ3uzEMQGUY0WdpkgLDx+xneXbVU3ZYzTfWc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcVDMDekZWzHwGAjq2yILnAhbXWJb8Ju1D9FFYiIjNA=;
 b=dO/alIptTIJzu2q27u3FEQDGH4jWGzNTeqG0HYHS2MOS2YnkMx6diMpSQ+5qzlWOrF3fZf3whFSTwY9/Bfgd9znT1/TEQplzCvtqXKXqbZt7atufx18I0XqxaJckFTIk4fx5vQVODoknEwUkoXMzXuoVmglv3MWzt5FmKAJAP4/Yipit6qxWv4c3Cp2hfQMHSE/+p7aX+NCabNX/zwcubJmXgLhTvEiuuPlSNUPMXqFIwpP7tlem8nqZ8Y5FIKfA4zqKR9NgrbgxLn5HQs+De4TRecDUF8Um5yVaAaRsPmTczPKChCLRBBCQbjcaH+33ud4/3/Yvv3fV79S+sfDfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcVDMDekZWzHwGAjq2yILnAhbXWJb8Ju1D9FFYiIjNA=;
 b=RG/NKNqz/Q7dMibxLTkxuXW1AAEaKhuKw4BTuTV4xNt1WNm6VO+e+Ey+yR60nNAXhKWtimXZfcdT48rfAJm7aCPsM7LdWRY1+b6jFUHSeEKdY9vTZysWcNb1W1ca3X846DTWZrntSRa0ho86A7VNg0VSZel/eLql2GzT+FIEVV0=
Received: from MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25) by
 DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 03:32:00 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::40) by MN2PR01CA0056.outlook.office365.com
 (2603:10b6:208:23f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 03:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 03:32:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 22:31:57 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 20:31:45 -0700
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v8 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Date: Tue, 30 Jun 2026 11:31:27 +0800
Message-ID: <20260630033132.361144-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629022921.17533-1-honghuan@amd.com>
References: <20260629022921.17533-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7c9316-bcd5-4353-1d46-08ded658255b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22122799003|3023799007|13003099007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wwXuFZqUIRDvCBFHGQQ7CbOMPTt6ZhuGG68XGIk23nFOAXCpB9zDJg+3PeKnXSSL8biWcyrNvJfMz65BZX42/FuO7ZZHQNnFx3vg0ZRsiMIdtRv5wPbfBrURvlQOrDqFsLrHUFbJot0Yie3lZ7U1UvAYuyIEq4eTf8+8UOPHzV1ZZwX4toqFhv2TUgIPCps14TEWj1ZDsPTsOqoFyv+557oXzwjBnKZw6kQ64r7raFKncORvmIyGXuFnuPVUp0ZOEi6LK1rK4LP3OuqU+ma0oALcciTKVf2YUm5k4lnuhml14Rb6X3g/uFA+mKJlhIslQVqCO1T4IpekxctjdM0OJLjO6yWTqHrCfsu158aMZrkWdVY9ZeIgsN1ypxURfOmUlS0wRcZYA5QhjhPsEIA/BnIzwRGgnpyu/wKS9nSTOcDQPVT9/dHZyRmDyf50J827whRf2AOTHmt6IgTbe3ZF0r5IGBqN91/1Iqko7fhG0rkmpa14DgPIl0XsM/detYmN0CNMC8OfHo4Z1EObtsemyCk4xQmN++urwu/5F2wb7GYQdZePdRVJWkd12S/4tOl3NbXowUXthvxEUTIkJZPoQ2cdOJKkXPzIzZYqZ1iTsssDHWo9RrN0NPVUdOcB74bTKxJuKLEqIRYnnavRnBS4hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22122799003)(3023799007)(13003099007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cw1n6flnA8UM26eGf3FVQdkv7ScBL21B35Esay29YKV2q0ujd1Ykizz+dYryut51SbdTeiNWL1t/buI84Xg27m5GTKPClhbvoDZk+QOGiCRqsuSw4jdqaK78EykfymsrYhFRaf3WhZM6xkemEBtq0+YcPPGx7XuhoptabPqXL48jD4kamfS3+2hGd27qKSHXszAJwEhrCgop45uwxYxZEiZ3EBOYMjNLp2uG55jtvjfcHondJjxOQ2u8vxXeOwkq1J5rBlmacL9xgFQIwdzmpXrhnSWspvw3uPxXb9Kal3XaXA998+38q3bPl+WROp3+p10qlVCo87SYdOecm3fHe/CQI4db5JhbGFeIiGluK/2NRZyChHv0wgBQFPoZNB2nM89ZPJIb+PnqzwHcSVBWsaBfZlITtH4HzQTLR6H98pcc0mp1HR0IDyvR9lgUvwdM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 03:32:00.4954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7c9316-bcd5-4353-1d46-08ded658255b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
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

