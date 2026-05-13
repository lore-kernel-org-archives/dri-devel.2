Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B31CD4F39
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96EC510EDB1;
	Wed, 13 May 2026 09:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D6j+IGTi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB12810EDAA;
 Wed, 13 May 2026 09:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I292RSAngMH8hVSpuLlsL2W7Ko5DNVIRvVzqr81fwrSoCOyCxfMISBzXl8SHsP46ibYdfavf0Zwe9xojK2+uStE6n6Tzme1WQJdNLL1fnkkHhONpbNca8jjdpiHNBKd45Ovukm+nUKbFknDzmZ7xmJiovpV/QshuvPEpyC18rGrL1pLkdODPPFa/cZiDLzYUgukIFI3nM7kZX44o1xJFQI0LWHQS0OzWZ3c349PTwfzuT6lymuUFfT4CVnNBSz/npHC/BtfnZHZtAfCwVu/ccepHEJCNa5Z/pig8aWprXpDOF1/8GLeVJM8iwACurJ46OkwVaIQWk7W4siqBhVLQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya1DEZn/0TaHwZ+v2tLaTs8FcS9FfQrp4Ss0Nm/+91E=;
 b=K6at8NeenN4C3BKuWqvpXoD+qCjZ0RRbvK1jlqJJBJxWt30jXUtuk8YlTEuBdHeyHbRR/SwkcUZ9lUUbHRaPnUN9HB4WJo7OO1hF9ViHYVFz5/BupF/UDievx9sn9AQsKqdhqwva5bd5xUG0DQo+QA/rNLeYrpmuSPWQ/UZykHDTz6/qVutAHqFGokJeP6qQ0ePHGdISjvrnbrTrG7fsElxeLNVUJXqIuPr0hrDQ6HAumnGoQwKQXYFC27QFcoIyvz18UK7DE3jasiQVwlFveXBg3qG1t0kKrYxHmQ2WQVqX3PeKF3HhKg2TwVB6g67t/CTp99Cul54TniotSrsjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya1DEZn/0TaHwZ+v2tLaTs8FcS9FfQrp4Ss0Nm/+91E=;
 b=D6j+IGTiWueoC/ztBraSJkJFdvck2ZL70Sm0ooZXSvT1LN9FizAffb6QluDdiRFeWEVVRk45ipGRDCJzB6DpGuHiVy1udiiJsbqww2RVaJfYXYw5Qd4NF7K/8Z7ceI7ZuNxHv5XqyPSUVKcCPdOou6v1wyAwLnNZLQt/DCYCrms=
Received: from SA1PR04CA0008.namprd04.prod.outlook.com (2603:10b6:806:2ce::13)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:57:48 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::99) by SA1PR04CA0008.outlook.office365.com
 (2603:10b6:806:2ce::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 09:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:57:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:57:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 02:57:37 -0700
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:57:34 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v4 0/6] drm/amdgpu: SVM VRAM migration via drm_pagemap
 (XNACK-on)
Date: Wed, 13 May 2026 17:57:28 +0800
Message-ID: <20260513095734.69598-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b21202b-3aad-4c77-12fe-08deb0d616a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|921020|13003099007|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: jjTt/EQvaWjXQHi2hVb70IrMdK3NsBiDsnQLbPcnfDrk+LbZCSITzoLrzfS6fBYzygmLcxZYr0EkQtZDqUAK2pivq+8tThGR2ksuNFzqsSHke0UWA1OjU7MDHFsUEgMBN59jFzB+QL8qfFO5Wdgy//7Xb51BOsKOp66DJUu5YXq1JrE2FXvCeIbQhMhhBLUi+jmjqjFdF4YDlvm0RJkfcNQLRVUq6MDPZ5Vo+klIkPi/ADFBRvTxqJUgRA549SI26JPVn9XLOc/YyiTDP5vXUjbJrnMhDj6Y4l2HyKAXG3KQ+TEzuwsi8vCQ2R5IB1qJnzTkewEWmtPsPgPygsPHfidN+grAhTjVPGKSRnNms1X6hZkmrv5hXYzY/rxHLg6TJwr7cE1Y0VBa3TOKEFfTnASflPkJkCziG3PqkvUDty0uDa1fPhvz4WJbSWeBlwXaA6wrLBY22zdJzj/0jkX5OcLu7o08lKD0fzBYBbAXlb9t552kY9UBZ5Vrhosn2VNRD/PC2JRowJVXBMQpaXNnQkPW93PyvPxrLsvOb4edJmM2RHbgnMz7TfbPXUCeXZfSNphzSXyPCV/FbewW3QpF9Kuavzq+68nd4Ny/KGxtHPGet4KmdsalQwy4GgoaZwtDsZaFjjkIXUK9lCCXsOq+yEgYPl3OGtJzpoNYok5CpYQqNGI6shptGqxatoCcc3JN3lFdxDNbYETzh0TqA3THj+o1j0NxBxkx3LmH4jJOUgcpdJePvYktsn1qYbGA1hARePWQRaIFoZAu5+9oLw2XEbW8AYpNtqor4BLxBgFnuqY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(921020)(13003099007)(18002099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DnjZTLUlXbngKVFcFWHUMf6u1fs0+GWfxB32ezIeXzNpdxAHL9HPtQVy26+5sBJE9muBwOAEWttKrIR8iEQC3FJ99lRxflNGCxSrsTGg51CWK8uCaApxwkAXTqm5fb6SgqLu4/LOlEJkXgdqU8z2FhOh2c/u4e2Ya7fbb5UT+76EpbSplrFAqyCfayTexbsQYnqcFDBn+MZO+7LcejBExNr0ivJXja+YhR2ilOwFnsoHd+Il6ak3P+qRSDsVq4kJHZT3gdfyLxKFyxzHBnuYn9nlOHGTZUDV91ibX8IrXdYD6G7RdhqDU/SGflTYAilkmGEgDFdLOYahqAxXUNAt6J7yeOwd2YYT4JbiRFDT7MIAZMmq6IkKXTYHmR3tOUaICSwnDRYKZB8GwBL3vz25E4ddoAxX7z2v6fUNbsWq8i/6fVkwj36N3XGSffOFzUfE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:57:48.1900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b21202b-3aad-4c77-12fe-08deb0d616a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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

This is the XNACK-on (GPU fault-driven) version of the migration
series, built on top of the drm_gpusvm-based amdgpu SVM core [1].
Previous v1/v2/v3 were XNACK-off (ioctl-driven) based on an earlier
SVM core; this v4 is a rewrite targeting the XNACK-on path.

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
  prefetch hints) and GPU fault path

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

This series applies on top of the amdgpu drm_gpusvm SVM core [1].

[1] https://lore.kernel.org/amd-gfx/20260508075129.1161157-1-honglei1.huang@amd.com/

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

Test results:
  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.

Patch overview:
  1/6  Core VRAM migration infrastructure (ZONE_DEVICE registration,
       amdgpu_pagemap, amdgpu_bo_svm subtype, drm_pagemap_ops)
  2/6  SDMA migration callbacks (copy_to_devmem, copy_to_ram,
       populate_devmem_pfn via GART aperture window)
  3/6  Synchronous TTM eviction for SVM BOs (amdgpu_svm_bo_evict
       in bo_move path, amdgpu_bo_is_amdgpu_bo check)
  4/6  SVM range migration helpers (range-level migrate_to_vram /
       migrate_to_sysmem decision layer)
  5/6  Hook up ZONE_DEVICE registration in device init and GPU reset
  6/6  Wire up VRAM migration into SVM range map and GPU fault paths

Junhua Shen (6):
  drm/amdgpu: add VRAM migration infrastructure for drm_pagemap
  drm/amdgpu: implement drm_pagemap SDMA migration callbacks
  drm/amdgpu: implement synchronous TTM eviction for SVM BOs
  drm/amdgpu: add SVM range migration helpers for drm_pagemap
  drm/amdgpu: hook up ZONE_DEVICE registration in device init and reset
  drm/amdgpu: integrate VRAM migration into SVM range map and fault
    paths

 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c   | 831 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h   | 110 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  21 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 122 +++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  47 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  20 +
 13 files changed, 1181 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

-- 
2.34.1

