Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D30CD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE2C11A536;
	Fri,  5 Jun 2026 07:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mzt38GcW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7C611A535;
 Fri,  5 Jun 2026 07:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD/7yKADGWqf4IU5+gPiZrbtil78YDQJDxbGDcLAUWhzA4FgmTDf1gp8ZqCjUmhQq79/WY7/+hezJNj2yI3zIFesQE4K6M4Nw/l4ifd6Tu4IZKKzUEJvvCSDmwR0mhTIYIvLsmNMPVO8RlhDv+iKYIQ0mpw6tshwH5M+bxVOeKy2WzyKeW7GCrdyytX5alUYn8GsCeaNcoAqz0eEm0cFQbt1Kr46Sr0kW6WPGbKwO2XNQuNsOMy2plGeF7WRhsYh5I6RPBF0wUliemfZSIUrgSwAhpHbc8cbZftweROQTAN3StkyTHxrtYe0dcTOqJzSKI78KIABNgqmXTLONXIcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4NKtszrzwb4hVFEEREFxBYSkV/zQHLLRQ/NdrjWHQI=;
 b=sLCmZyxTYIDHiVQNp4NpGVQ+kp2JoDkieop1KA2uYC6T4hNkaK2759hZ/EqiUhUlVDYuluuUVqvRaJmHQc+yeU/Xa+5Oo1/idfa/1ynkx7IDqfJcq5m7kZ5dX/7NUXd3/2Rlhxlyyo+Fu+L2mL4iNtOPMnqVJxeqr6aUd4Eve87DI6nZjgtpYQwNJdD5kVyvs74EdSEqc5D6N8SoUWwNZV8efPIywtwpZV9lKMuuC1OrSWApjX6nfhl+cy69Bv8vVPAUi+zbYypEnTL4ZR1hOAF3Ry4YG/H2CC2gkfJcQOLCNfclZutmG2oey9Ah6eq3WQA5e0O2EGs3SUv/9+CI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4NKtszrzwb4hVFEEREFxBYSkV/zQHLLRQ/NdrjWHQI=;
 b=mzt38GcWKOizh49vgrZxmj9BRG2gltiT+mbqTLmf1g6LnrsBh3cR3Wo9R/peWAlz1sStDKOJ5+u3qJZm4MZVRvdfhFC+6WLTFSUR4cHZ7fHMtFHqrbKKILNjNJhgxljlb1P0ETtgCj6zvv5TC+ZYRRK0TfCDCrUoYV3zFB/ORxQ=
Received: from PH8P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::35)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:53:45 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::30) by PH8P221CA0008.outlook.office365.com
 (2603:10b6:510:2d8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:53:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:53:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:53:43 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:53:40 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 0/8] drm/amdgpu: SVM VRAM migration via drm_pagemap
 (unified XNACK on/off)
Date: Fri, 5 Jun 2026 15:53:32 +0800
Message-ID: <20260605075340.20199-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d36356-9c5b-4bf7-d046-08dec2d7916b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|921020|13003099007|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZcNwn2m4aoW7BBoQPuHcMfJK6o9Pk/CIxa2DO2qqiumf0UDyJ8sOGNahWD3ONoGD8UFgkB210+bJ5eMsbDf+uV9wjjRDPdjSBSsKHU+UcInebrUhq1aneCNSd/uf8TvozRBsHAsaVE2/SxN8NCSxsvpd5Ou/fYZmn0fil/8awkK38psYOk5d+yD8GG07BhOBn6IQ5sPaf3rj7Hrm3ZJDEkz8jtQaCKv2qeOJ5kt0QaK+PNUqWl0gQJL4D9/kK/YTkYlSeGY9IzkqvXSiyj0V0lnSGHTeM7rlrR/ekrBYyDIb8ZK5rGw71TnvTZlehI/9xvorEtLzIGekcGxFgLkv9W1N81V3JoXoELs5AajhqRTu13Gh4sq/06wzHrsqdMuRsoVJrf7ZWaRQSbP27FYrKWaKEwxC2uLAuAW5Cxeb0/S87hhlbf4bK7QmeOQJpxPFVFJXl7tCh1oo9KZV2jUKILYLJvHlwpgev+r5WT3sWUy0NdDsERe2VefFIWHZ4eu2fY1980EsP8BwIg/q15wtAipmPgGwrXYs05qlapXq89Ur0vAffLXpdnpS6z/0Vx2JGpyWchGpY4e1INk7CbH7DVtKGvM46biavsKpqkxT1vPmDCChcvspttG+Dr5BV1BMm/6bRq1zZup4lV6T3bz0Y0eQTNdiR4cgHow9LCEvOt1pxeBMFt8vN3OJ+fW4fDVDN+uubta8uRV40MlTrnu2RfRUsjQs7HEa6vS6vu8sJ4zqvch9j15E4eMjN2Rhbg1tYS9Sr55muEch9H5Xr04wLD6+dthAQI+8BEYsiFn2O/s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(921020)(13003099007)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5A65MMD05esRg3F82oSLVqPHP13S00fDJWCFYR219wnW0gu3o5UVJddBHTEfbSq2J1/ILGrwCXtl+PT4WobWrC9bfVY5yX9A3w8ajJITIy9Q8QnuN+KemchKKtKOZtQ5yl1+vNoqw4pXboYWd/R6C/0ON7xM4gdGBZjJxh0j1Dg6HXxu/RQikFZB9XsNxvCnf0F6UM7JmdLEkKZVTUlejYiFEaZcbFzZafv2NFgpyyE9qARIezjRDmWiVjoKeyrlcQ1IJYvB99Kf0AdWJb9yIn5VPMIIE6serSySaS7Q/dELV0Uw8BGmCHYwhJS9AF6x7Yef+mjEw+8Qyf2S1vEZvGXdksqk0U5RoLXXu33xHHNY0Y2zIYpggW0eX3KNuJW0pHqoO7VJGowIEdg6nyjDGV7zJoVmp9cLRDjQEhLQGZeNwBpwFh/6ryKhfGx78iPN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:53:44.5835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d36356-9c5b-4bf7-d046-08dec2d7916b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
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

This series adds VRAM migration support to amdgpu's SVM (Shared Virtual
Memory) implementation, using the drm_pagemap framework for ZONE_DEVICE
page management and SDMA for data migration.

This v5 is the unified version supporting both XNACK-on (GPU fault-driven)
and XNACK-off (ioctl-driven / restore-based) migration paths, built on top
of the drm_gpusvm-based amdgpu SVM core [1] and xnack-off restore
infrastructure [2]. Previous v1/v2/v3 were XNACK-off only; v4 was XNACK-on
only; this v5 merges both paths into a single unified series.

The implementation follows the Xe driver's approach for TTM eviction,
using synchronous bo_move to migrate device-private pages back to system
RAM when TTM needs to evict SVM BOs.

Key design points:
- GPU VRAM registered as ZONE_DEVICE via devm_memremap_pages(),
  wrapped in struct amdgpu_pagemap with drm_pagemap state
- SDMA-based data transfer through GART aperture window for both
  copy_to_devmem and copy_to_ram callbacks
- amdgpu_bo_svm: lightweight BO subtype with drm_pagemap_devmem for
  ZONE_DEVICE page ownership tracking
- Synchronous TTM eviction via drm_pagemap_evict_to_ram() in bo_move,
  following the Xe pattern (no eviction fences needed)
- Migration policy driven by SVM range attributes (preferred location,
  prefetch hints) for both XNACK-on fault path and XNACK-off restore path
- XNACK-off integration: migration triggered in restore worker and
  attr-change boundary realign paths

Limitations:
- Single GPU only; multi-GPU migration is not addressed
- No VRAM-to-VRAM (peer GPU) migration

Open issue:
- Unnecessary TTM system memory allocation during eviction: when TTM
  evicts an SVM BO, it allocates a destination system memory resource
  (TTM_PL_SYSTEM) before calling bo_move, then frees it afterwards.
  This allocation is unnecessary because the actual data migration is
  done via drm_pagemap_evict_to_ram() → migrate_device_* which
  migrates device-private pages directly to regular system pages,
  bypassing the TTM-allocated resource entirely. The current TTM
  framework does not support num_placement=0 to skip this redundant
  allocation; this needs further discussion.

Dependencies:

This series applies on top of:
[1] amdgpu drm_gpusvm SVM core (xnack-on):
    https://lore.kernel.org/amd-gfx/20260529054928.596825-1-honglei1.huang@amd.com/
[2] amdgpu drm_gpusvm SVM xnack-off restore:
    https://lore.kernel.org/amd-gfx/20260529054928.596825-1-honglei1.huang@amd.com/

Changes since v4:
- Unified XNACK-on and XNACK-off migration into a single series
  (v4 was XNACK-on only)
- Added patch 6/8: refactor SVM attr devmem_possible and prefer_vram
  API for cleaner integration with both paths
- Added patch 8/8: integrate VRAM migration into XNACK-off SVM restore
  and attr-change boundary realign paths
- Split the integration patch into two: fault/prefetch path (7/8) and
  restore/realign path (8/8) for better reviewability
- Rebased on latest SVM core with xnack-off restore support

Changes since v3:
- Rebased on drm_gpusvm-based amdgpu SVM core [1], switching from
  XNACK-off ioctl-driven to XNACK-on GPU fault-driven migration
- Introduced amdgpu_bo_svm subtype with drm_pagemap_devmem embedding
  and two-layer reference counting (GEM refcount + TTM kref)
- Added synchronous TTM eviction via drm_pagemap_evict_to_ram() in
  amdgpu_bo_move(), following the Xe driver pattern
- Added amdgpu_bo_is_amdgpu_bo() check for SVM BOs in TTM path
- Cleaned up container_of macros to follow amdgpu conventions
  (to_amdgpu_bo_svm as #define, devmem_to_amdgpu_bo_svm as inline)

Changes since v2:
- Moved amdgpu_pagemap entirely to amdgpu side, eliminating all KFD
  modifications
- Split commits for better reviewability: separated infrastructure
  from SDMA callbacks, decision layer from integration
- Merged ZONE_DEVICE registration hook into the integration patch

Changes since v1:
- Dropped the eviction fence patch (was 4/6) after Christian König
  pointed out it violates the dma_fence contract
- Refactored migration integration: extracted migration logic into
  new files amdgpu_svm_range_migrate.{c,h}
- Introduced enum amdgpu_svm_migrate_mode (PREFERRED, TO_VRAM,
  TO_SYSMEM, NONE) to make migration intent explicit, replacing
  the _ex functions used in v1

Previous versions:
v1 (XNACK-off): https://lore.kernel.org/amd-gfx/20260410113146.146212-1-Junhua.Shen@amd.com/
v2 (XNACK-off): https://lore.kernel.org/amd-gfx/20260413103031.181953-1-Junhua.Shen@amd.com/
v3 (XNACK-off): https://lore.kernel.org/amd-gfx/20260427100522.7014-1-Junhua.Shen@amd.com/
v4 (XNACK-on):  https://lore.kernel.org/amd-gfx/20260513085725.163786-1-Junhua.Shen@amd.com/

Test results:
  Tested on gfx943 (MI300X) and gfx906 (MI60) with both XNACK on and off:
  - KFD test: 95%+ passed (both modes).
  - ROCR test: 98%+ passed (both modes).

Patch overview:
  1/8  Core VRAM migration infrastructure (ZONE_DEVICE registration,
       amdgpu_pagemap, amdgpu_bo_svm subtype, drm_pagemap_ops)
  2/8  SDMA migration callbacks (copy_to_devmem, copy_to_ram,
       populate_devmem_pfn via GART aperture window)
  3/8  Synchronous TTM eviction for SVM BOs (amdgpu_svm_bo_evict
       in bo_move path, amdgpu_bo_is_amdgpu_bo check)
  4/8  Hook up ZONE_DEVICE registration in device init and GPU reset
  5/8  SVM range migration helpers (range-level migrate_to_vram /
       migrate_to_sysmem decision layer)
  6/8  Refactor SVM attr devmem_possible and prefer_vram API for
       unified xnack-on/off usage
  7/8  Wire up VRAM migration into SVM fault and prefetch paths
       (XNACK-on)
  8/8  Wire up VRAM migration into SVM restore and attr-change
       realign paths (XNACK-off)

Junhua Shen (8):
  drm/amdgpu: add VRAM migration infrastructure for drm_pagemap
  drm/amdgpu: implement drm_pagemap SDMA migration callbacks
  drm/amdgpu: implement synchronous TTM eviction for SVM BOs
  drm/amdgpu: hook up ZONE_DEVICE registration in device init and reset
  drm/amdgpu: add SVM range migration helpers for drm_pagemap
  drm/amdgpu: refactor SVM attr devmem_possible and prefer_vram API
  drm/amdgpu: integrate VRAM migration into SVM fault and prefetch paths
  drm/amdgpu: integrate VRAM migration into SVM restore and realign paths

 drivers/gpu/drm/amd/amdgpu/Makefile                |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c        | 831 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h        | 102 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c            |  12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c      |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c      |  32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h      |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c  | 115 +++
 .../gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h  |  35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c        |  85 ++-
 18 files changed, 1244 insertions(+), 60 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

-- 
2.34.1
