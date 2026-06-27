Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE22C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC96510F78F;
	Sat, 27 Jun 2026 03:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uiar3+Pf";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB9B10F789;
 Sat, 27 Jun 2026 03:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0iMqWHF/cDfhXYy8WwxyzuavaILkD3cz9hSnPtRWhn8iXdgnX0od1+RYgQHh22VBfz1vse875AOvK3bmSq/61tcK84Ggb+zwLNKQmaA66PbZ8EkXNOt6r6DkPPgdIj/qyAktFs4NZnmjpKa7Gd7vmB6ioAAlEcN1raDDyoD+2i4FJE0xtxOI/AhfXHhdE27GnSY6kn1j7R5DTi3SwTYAXVZUTtqS3Gk2ieMqSegbWVFNVawQYJUwBn3H7EiicKqja+6L5qAKXyXEhFqosJPyB0G8HtbKobpJIBHtQBqPHLrKzHeyhCNA13KiAn5sNG6a6/lXp2qzyUOI7Rj3mzGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WspAdc7A3wiqKg5dtHov+6LuP6A9tGhQ45WmYklCjmI=;
 b=yB30BzWNfJJ/nNdBaPrUb+L7JpH8lR+k7z97GAQOtxs6BCwnRNDNAlRgvRQMOTc5L1myVxp+yzChJEPMqaOGgi8D3EOQ0FX6Bb2a66nPqo8oo0GMyspke2Ky/zIp+pcLLTSj3wamTOpqmK/XgOYJQDmMi9CXQR93qdvvlJwSWhsxqo+o4+A7/FsqrGgEm1Pzs8BnQXsaPWjAz1oJvYINFoVsjndmjlpXMbqBXHi1pItRQHKnILrLYvvJhASEvWeK/jciptg/ZJLK7bV2nNFvhB2VDDxAbqxLueQ6Bm4EPdlxIOWDnCL5ICgGjK/Y8/BkUg9wHUR6DS/ZUzeFQuWMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WspAdc7A3wiqKg5dtHov+6LuP6A9tGhQ45WmYklCjmI=;
 b=uiar3+PfN1ST1gUUvgRZU0oGUtQL+vw5ndlSrtKC6YLvU3sMvmRVzIf/eqaWJkmONufshpnhUA7TAqn2p6TGLBIPeSfn1KMmQ96sZc7PwjzBL0tYZWa09DnFot5gmQayC2uRLZXZ36lm5Dw+vMxxcKaHEyNf1tciYadfbJRlgjE=
Received: from BL0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:91::32)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Sat, 27 Jun
 2026 03:54:58 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::ad) by BL0PR05CA0022.outlook.office365.com
 (2603:10b6:208:91::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Sat, 27
 Jun 2026 03:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 03:54:57 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 22:54:53 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v5 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Date: Sat, 27 Jun 2026 11:54:18 +0800
Message-ID: <20260627035418.3796481-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627035418.3796481-1-honglei1.huang@amd.com>
References: <20260627035418.3796481-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c13c837-e821-4b8f-079b-08ded3ffdac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|22122799003|36860700016|376014|23010399003|11063799006|13003099007|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: MGlNddFkfWoiLNML/lza2fT/6o74E/5Y8Ge5hheeivywIvH5VQIlA5SB8bTGouhAsMN/FMkeFapRc6HcBPawDcP82DbIuIJv8cBMB7bp5gS+lqHlVqqZzDkD95wDwt7bj+5g/Vb8/68LO9mYwv+1utWXGaR7XMA0hYXlMS3VNLVLo1SQrEfvUyli/GcwVGBdQq6sT/l2RV8KiVtwnVenv73/BlBhHxnkSP1yp/05m86P0IvmRGycE7f0it65IHKzDvtYfnG/X3b+WoGfCEn2aZuqwtdon8QwJHueFJ9qXE4+AcGKH5c/Yo/H4TvYngnSgrP2R6n/+Rm28ZpbJBrBnnkKF6LcjaM/d1eE0pmqE362mYAtHYXi6vwWVDNbxywrvV9RDELS5Rhtkd1rgaww4Ch8wF4O9pwf4+JQZqsO+wZOlT2fv5OmisVKkbsFa46ijSQcbIquhUd+6zyREpQUyIp7qXPByZDGjgku1qKTcs3HM0h2taivapBLzjnsscK0kYFio2PsncyRUoFopEaNu+OFeS3tOZm/jH8Rb3+w9YupnKxYHQY1fOFP8vjtA6gSe7iHgi3p68ZfJYe0GzpyYUYZm62lOvgG6DDxE53aSIPVuV3pXpELRu2h6q7oXeEiIoA7HmmNyFS71cPg3GClhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(22122799003)(36860700016)(376014)(23010399003)(11063799006)(13003099007)(18002099003)(22082099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IB7PAWf+3abmSM0BJ4TkaRcYO+yPrGa1Nig0jzlGvHxp98V5IQV9QaFBd+zrkUQa40GEmXEk4IrjWGD2AmVYLS6GqnVrbT5ULjGe7dLDeQ4RLjk4CaVKI0BJB6qMgOiQ3SrhU+kgc6x/E45OXyK85w1PkxixG3RGHoHbK7cCOF+6wVfn6zNwqEXhsbkK+l/FYG/KEprK9d2zDb5mnVw3SdERNha6dOQNeXHLWqCO2laxa7vDiBXCsnwqpSCr18V8wnsPhCk6DSPrOLaUY6jGnAfVF8dULlNKcVhA8bch6OD31oI/e16DhIHzDkIS5nHH2hjkHH75qZJs7hgomSmE6TvhM0wPegT1ZvLiPrsBk1mCKnGNlnrBNcawjWlLlmQzl16twOsGyrn3RijEUMTvuw5u4pMMI0r2q2zsSYnZv4Ty+4vbEMHV5M8LfJ2zJiXt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 03:54:57.3231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c13c837-e821-4b8f-079b-08ded3ffdac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
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

Honglei Huang (5):
  drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
  drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
  drm/xe: have xe_svm_range embed one drm_gpusvm_pages
  drm/gpusvm: move struct drm_gpusvm_pages out of struct
    drm_gpusvm_range
  drm/gpusvm: let the drm_gpusvm core context purely MM level

 drivers/gpu/drm/drm_gpusvm.c    | 230 ++++++++++++++++++--------------
 drivers/gpu/drm/xe/xe_pt.c      |   2 +-
 drivers/gpu/drm/xe/xe_svm.c     |  41 +++---
 drivers/gpu/drm/xe/xe_svm.h     |   8 +-
 drivers/gpu/drm/xe/xe_userptr.c |   5 +-
 include/drm/drm_gpusvm.h        |  67 +++++++---
 6 files changed, 213 insertions(+), 140 deletions(-)

-- 
2.34.1

