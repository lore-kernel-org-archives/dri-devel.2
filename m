Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E440C43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29EB10F75E;
	Sat, 27 Jun 2026 03:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5sxTgfO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D14E10F75D;
 Sat, 27 Jun 2026 03:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3rp2DxcFl2dlks+7BT/rzodIZCQBWIU5ormsiirhsJ8hEecqH4f9SQ+eAeKqupkzVFesHEt4M0NG5J8txvPf2YCA75huXlRpv/f2tTzWfrT43jZwX5Prax0S0JP6n5nsA6zBJLlI+Ulk5UTOG9P8GF8/lDUObXAOZAU6VZKoXn5wIEI0La99S3Y1IDqeeKupF3Otd3JPrd90ZOLbi/DYa8bUx4uikg365nuvolzcAldRDmnHfD3eoVjmJ7qv9+rxt5uRaS0AOtorrZwIEa0sHV0LKSrmws5B/mzFEhlQHvBtnJt6lhdhyXCFSPZXUvTvQRGkZIz7+yaVdtkh22FRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUdysxkGJppHqIPY9r0PjQZyyTgxtFk85dpAc1HPw3Y=;
 b=vpWNIR76rxN45EZKqQXSb3+qTT1+utGHMrHMLCg+X2SWbdl+4kgui0aE0HgXFVn+caz9IV2c4qj+0HyQMqJmSOsdB/YwXBLBAZ4D/mxpyXEqSoJegJQYfTiSxEEi14zFBqB6gtnf6aIBDP4Ob2WV/1XfXAQQtwxAkat7BQTUWIH40HKD6wl/jKlmET9m9wdbu+KmIDw0Qthm7k8x7kVV12tDrI/stWftFt13IeuAocXXl+HVOKGKgVEZJhOSx7bBNoGIQ1KVtcHgz703bG0sNJv2m8u300L09PElhYtlVhihCa6wCeboLpECAkHiAX3U5MThVRFe8uLjNTnRjaS1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUdysxkGJppHqIPY9r0PjQZyyTgxtFk85dpAc1HPw3Y=;
 b=T5sxTgfOReBZI7Useo+9XNpRHTnFQ3my829BvjK0ulMdke8AjNFPD7SkIMGUvmwiSRZf5jDWMHAdvJdG95URqHxd16uynUf55SPmVnBiX36c4Ep5zwOGF1I2Clf/QEvZ1W3nOuez2aEvv3A1lU5XZrCLI5TPx5Q3kl9+c/8/n40=
Received: from BYAPR21CA0023.namprd21.prod.outlook.com (2603:10b6:a03:114::33)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sat, 27 Jun
 2026 03:43:20 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::ae) by BYAPR21CA0023.outlook.office365.com
 (2603:10b6:a03:114::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.7 via Frontend Transport; Sat, 27
 Jun 2026 03:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 03:43:19 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 22:43:15 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v4 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Date: Sat, 27 Jun 2026 11:42:58 +0800
Message-ID: <20260627034303.3795627-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 269b2577-69d8-41a5-324d-08ded3fe3b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|22122799003|1800799024|82310400026|23010399003|376014|36860700016|18002099003|11063799006|56012099006|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: uKxyS/QBOFNCddaugMls6CnBVhux6Fnaea8c780B4TtIq2M4u9shcb2ejQgm9HftQV2PVzts2BoeNHIfKeXibh3FeG2qVhMIhCyk662sRDlhKDKA18nYZ+NAUKkFDzQMbanba5ZesJNtYhmZIfLCfRVci04T+M0d7HPww/p6UF8kyXG2SYA6hhD/fzLFZHNMnerqXE5ZLlg/SuvUAYUPnHPt1PDgSG7aEkJ7iZgumj1TM+iEPsuXyKLfN2Qx4lCQxpS/xxcEuuZtlevARIo/JIKxiQRS508JdpQyL5YeEt4DGtPeBXt+yWUtpLnsQAnok++0u41RjOkboIKWZ7ePHcITSCTqjz13yXXLcBK+6qpuJofeLq1UlMIHTYJCW88sZutPl2Wx2X1wMStYIzCOjbmacBj19Y9sSZnHyXYCpvYmgbua6ife5ge7Qi1KG8OMq+hGSzkH/GV+1E9FRowlU8QFxaQs4b4l4TtjYpS4zCqn3QyMPjn04lXEEGZo+bzPwJ8UMrmB7BKnH3ZZVtXgndzSl14plwHUJAYxlUYERTWsC7qCQ0stJ8aloN+r4VFDgRZY/XCKYEGex7tZmGwUaUHiIrMkCiD6ZcUdW1HqMVbPmbLFpLuxLlOlxPf+wWmXFRMSbHAzxnmQoPdUxF1DsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(22122799003)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(11063799006)(56012099006)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2CSQrW+kwMciwYNsOWixf8rJ2eX1sQgjBJZW06zRV0ZbMep3qkkP3AI7K9R8Xp/kNMtNTJyKwc1cin8g9kYBnz+T+u8qPiKrDM2pj+4FXh1tZA65CLvuSGalYy/kMuRRNwAyoCPrG51sv6B6GWln5vabL/ZjhZl/9JcF35rA5KJtj4e6bQCcCJBq9stpzRFllMKfx2OlfM1yAt041X/6du7n2WAnPin/ZRY1pUKwDvaFpBrt+vitM7q4ugQzuRl3vki5XB/eiNSnWjGK1ULnWGK1x/yPKNCE7KxVcCMXCeTSKvQ7sdV7JXrb83XXGHgVKW0qb0sJlazjPjxCfkhjA5mK7BlfPjy8Hb48+13GgsJsF+y/QgbUY/DanLrzUKWDT1FufweAA76sv3++Rul2bf6SrNmEwRetSPwQvKic7J/12a/YWfp436wRe+eESb/J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 03:43:19.7645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269b2577-69d8-41a5-324d-08ded3fe3b08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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

V4:
  - drm_gpusvm_init_pages(): memset() the pages to zero before recording
    the owning drm_device.
  - DOC: overview: recommend a zeroing allocator: kcalloc() for the
    N:1 pages array.
  - Rebased onto the latest drm-xe.
  - The AI review flagged two preexisting IOVA unmap issues not
    introduced by this series; fixed separately in [5].

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

