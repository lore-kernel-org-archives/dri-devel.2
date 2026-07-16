Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB4C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5905C10F36E;
	Thu, 16 Jul 2026 15:30:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VGj1zHpZ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00C510F354;
 Thu, 16 Jul 2026 15:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhKYp9+f9WqTOqbKxvXquaFPE3UXLdxYCasVbKc4kuOOntYOPa3chNG6f2AhGyp4lqSHu1tB6SQlU7z9OvmK/txYPy6ZeQCAYWt6YFsMDuKm5Z97TYZ3yWO48C6jlKj6k9/ZDwgZyw1dsLr+gPpuDp276Kli/i2PmlkGpo2ib1eze6kfvhLEaDztMJO5yisalX/R6sg0n6vmz5WrhLiIOdDteoGUPNT6gsbOF/h9XAZvG97gCb8BuF/4PIKAspkdZgbtjvKSZJKtRy/6J2CKwh/ZZUeTzG58SAdKtMImFp2XBj3fzzaJtejntwVDkz4MxQt2zMrkgLU3hYX0o6cH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxeP5CO0HC+vWl4X/SfL5/wzwLCwq2cgPg3AW/SdRDo=;
 b=m6yWW3kjZwmlvRBJvJqblQOUxqT7g4lqj24n5+WnOCCafWKKJMH0on62KcEkV2lfWhEQJBxRwMUXJJXSO/O61Gj0uLWQCAVOUSyctaT+J2azcI8MvPJBrKPdhct51YM3MOwTxzSkDsNpjD6NFXykPlTWNvowy5Xjac34aRcN1fKP4GOWJSh+ItaS00G+wS5u1etd1+zDhYV7rKGQ3EQ7R8i7RwAXOINek+sGJ7d6CKB/GN3S5bKj/m04KfqL+9D2a6L4oHgtXYNvps6y+J7mPwmyF8al3mbOfDpD7sM48B3JNeN4FOA7sevsci+OyS0xcAC7mJCALLuccyhexaiQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxeP5CO0HC+vWl4X/SfL5/wzwLCwq2cgPg3AW/SdRDo=;
 b=VGj1zHpZbm/jXN0dTgAuwq6/HY2vrskMu9VuzHeU1SbjbGczkQ4z8gy0e6cVG2e2Me7Gm8lhB9xDVHbZdlS2bz3APunAm5hobuO2ruNbT7r+NhZvVdiRo7v8DXwt7SQK2gYPJxZlrU3zJw3IbXxnf1eDBq0ztdH7JRjsiUzvmW4=
Received: from BN9PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:fb::27)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:30:29 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::2b) by BN9PR03CA0052.outlook.office365.com
 (2603:10b6:408:fb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 15:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Thu, 16 Jul 2026 15:30:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 10:30:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 10:30:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.2
Date: Thu, 16 Jul 2026 11:30:19 -0400
Message-ID: <20260716153020.3171253-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd568eb-8b71-4a86-86ed-08dee34f2a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|13003099007|6133799003|56012099006|11063799006|10067099003|18002099003|18092099006|3023799007;
X-Microsoft-Antispam-Message-Info: zhmnGctNouLEBoWpY08Z2H+74TWrUjuN/Hi7P4aoTGNZgpxomFP6OkhS7NSQNW+DbUQQg5ztfsDb9nqXKbbv4HdGTkIQjG8ZUjDO2vnnQaEj2V92ORSpeZ6UfQK23eI/Ukv3l7cpaq7SgTLI1/DsXKbOOBzy/dK8eV4xN5P8cpoZxK00c6J5s2hRD25aIrC3/qNgrHlGujTi/4KPbovcKuXT3FKDP1M4J4Up42xQpFLKRIMdDey+ZLqWDWpcOCNlQAQskTRF0Py/XKdb38wRwNy9l4loKIyuDgqVTXy2IoBeDvNTyRvGXX4pb57z6ovZt8sVP3t4kIhxv1FYI0qdYHaI5XqnS8KwAIqXUvzMlWtafuhOw/snaszRfAMKYO4+VMz16mwCpY5CaswSLEylt/uZsDMCtEmwCTZIT/1AsM/hhRhmkBPgXNhmWG0UJbou5/DEL9hHdOGLoHLkv1U/Cg5p47TxwjS7Dr060tSYUiJvzT0mOL379QAZcB6TguV8R7w6HfVGGUNhQdOVe3i3/hsaSPYCvKrYlLIwjxZp4Zo77vRztaaNG6aomvvo6EIKzGiG/4W1r1rSYlQox7A/OSLgDOwh3lPccYL0qMdGOx9+a2kbdkbE/0cI4F0aNEle
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(18092099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nc/adqvC/+k4HIsI9spUqSg/qyRlsBF/RwYG8rA1ejhC6+fEho/FzYTV4EEEIQ5uAvWiRlil4y8c/CyXJZfmMDneYqBg5Oa7oSMuCje+Y3KqAJfz0eQ8GQKKh+vM4i4eFoo2T2QA/ggk5PLnh3loGYdefQfRgMApgxszzmtOn8sV1AYc77Re3/f/yS4x/kHW8aKYSGVOVYn2fHNW13C5SL2kr4jMuVr0kfPxtxZuTi9Zr8QcObxjQ/F3LeTqNrCBPFXkiiNHAq/CWcPwxg+1o6NRIm0qQFcZAstfQj2TipHbdUuW2uBChyHvN0+W6I14h1uKz7zKktJgKcuXbDfLYDdFDv8PbXbrU+OriecoLxbJgWKm1qpHJGSgCfEAeh0L+KsfiOaI9EiUZA4QgmWwW2JbusPry1JeXvDqiFahJz0yB2NWShdhIavRzdYL9J6q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:30:28.1825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd568eb-8b71-4a86-86ed-08dee34f2a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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

Hi Dave, Simona,

Fixes for 7.2.

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-07-16

for you to fetch changes up to c9ab9622f5b2799fe624a4a134e60112149271dd:

  Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs" (2026-07-15 09:55:55 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-07-16:

amdgpu:
- DCN 4.2 fixes
- NUTMEG fixes
- 8K panel fix
- Backlight fixes
- UserQ fix
- Fix bo->pin leaking in amdgpu_bo_create_reserved()
- VFCT fixes
- devcoredump fixes
- Display fixes
- SMU7 DPM fix
- AC/DC fixes for SMU7 and SI
- Queue reset fix
- PCIe DPM fix
- XHCI/GPU resume ordering fix
- Pageflip timeout fix

amdkfd:
- Fix potential overflow in CWSR size calculation
- DQM error clean up fixes

----------------------------------------------------------------
Alessandro Rinaldi (1):
      drm/amd/display: Force PWM backlight on Lenovo Legion 5 15ARH05

Alex Deucher (1):
      drm/amdgpu: always emit the job vm fence

Andriy Korud (1):
      drm/amd/display: dce100: skip non-DP stream encoders for DP MST

Dmytro Laktyushkin (2):
      drm/amd/display: fix dcn42 det allocation order
      drm/amd/display: fix dcn42b det allocation order

Fangzhi Zuo (1):
      drm/amd/display: Fix 8K Mode Not Parsed by EDID

Guangshuo Li (1):
      drm/amdkfd: free MQD managers on DQM init failures

Jesse Zhang (1):
      drm/amdgpu/userq: fix indefinite fence wait during GPU reset

Leo Li (3):
      drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock
      drm/amd/display: check GRPH_FLIP status before sending event
      Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"

Mario Limonciello (5):
      drm/amd/display: Fix backlight max_brightness to match exported range
      drm/amdgpu: Fix VFCT bus number matching with soft filter
      drm/amdgpu: Release VFCT ACPI table reference
      drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen Pinnacle Ridge
      drm/amd: Create a device link between APU display and XHCI devices

Matthew Stewart (1):
      drm/amd/display: Fix DCN42B null registers & register masks

Pengpeng Hou (1):
      drm/amd/display: wire DCN42B mcache programming callback

Roman Li (1):
      drm/amdgpu/discovery: Fix device family for DCN42

Timur Kristóf (10):
      drm/amd/display: Fix preferred link rate for NUTMEG
      drm/amd/display: Add dp_skip_rbr flag for NUTMEG
      drm/amdgpu: Print vmid, pasid and more task info in devcoredump
      drm/amdgpu: Reserve space for IB contents in devcoredumps
      drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)
      drm/amd/display: Set native cursor mode for disabled CRTCs
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initialized
      drm/amd/pm/si: Fix AC/DC switch notification
      drm/amd/pm/smu7: Fix AC/DC switch notification
      drm/amdgpu/ttm: Consider concurrent VM flushes for buffer entities

WenTao Liang (1):
      drm/amd/display: set new_stream to NULL after release

Yongqiang Sun (1):
      drm/amdkfd: fix 32-bit overflow in CWSR total size calculation

Zhu Lingshan (1):
      drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

yanglinlin (1):
      drm/amd/display: fix __udivdi3 link error

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  62 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  10 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  23 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 551 +++++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  70 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  20 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  45 ++
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  11 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   2 +-
 .../display/dc/link/protocols/link_dp_capability.c |   6 +-
 .../display/dc/resource/dce100/dce100_resource.c   |   7 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   1 +
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |  23 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.h   | 116 +----
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  17 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |   7 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  16 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  12 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  12 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  45 ++
 drivers/gpu/drm/drm_panel_backlight_quirks.c       |   9 +
 include/drm/drm_utils.h                            |   1 +
 31 files changed, 720 insertions(+), 431 deletions(-)
