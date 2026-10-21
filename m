Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FF606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ifngP9rJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B8410E34D;
	Wed, 21 Oct 2026 17:35:33 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A239B10E151;
 Wed, 21 Oct 2026 17:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcwI5I+1DA72QGNTlW92vRyOR1RvK/N8j/tOabijx2dyyrmMsa+F9Oiwdeidq+3UtB732JDQUTxvuDP/+We1NCa2GNGKgv6qc+Hc00rWIKpDMKlgpRxC+5Jmxl5SNzTMMTXM2tC/qsskuyX8cQkIMqr0j3gdDynMJDV0zeiOnLJLmchi8UsozcQ4MUlJYkL22kgcNselpNyQe9XhEhn092w6ePI6iAaU1WtZefw0LARg4Ki0R5R2gZ66JGf6ELn4FqmOTzW0OU6xqATAc16w5BwexgxkxlwCxYZAEe6E/dE74X/Dm7rCRIDSs2ZnvcapnkvJAZXRxmLiKldudUcBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z488Sh4A9SYm4YB1mGXF7lVFgAWJkcmy8f6Z5SmIDs=;
 b=w3TNIF3KbHUpIo5/FOnJ7biEKOvq7bW45dsjdsWMaEJx6i1i5wkBSlgUZDevy/IPELLsm718BG4gyOZL9h68dJgGum0sQtGNH4+SdQAzndCPvEbYOvmvYvHP8aDel+wglqYDyM718TAWuYZ6HE39eG7nfkclc93wIR8tfxXyKTHklXH0+DQOL7vAV2oPu4ZIyoqB28tABnh/mg2G3BvFR+qLh2wnPGEz4EOUWeMKOsWJfj8mBCIc1mMtg/yZbAkgohmRwOLbzheVm1Is0U9G1JUlSWlfrb0PPph+rlAW39HqaTR3CqmS1682dLy7CvJcyTGdVz63vOlEur1cI5uIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z488Sh4A9SYm4YB1mGXF7lVFgAWJkcmy8f6Z5SmIDs=;
 b=ifngP9rJA6La9PCBRcIq8JdijQrRiPqZPS3wckr5NmkwI6yTeUtIzChiHPcSQkc0RVR2RMeqEB76J2WO7hjoqFD4bE5pe3CeSGGjdTxxeYjFG/sOo1inT45qJPDZ1NwHFRgAsCgKirR0IOwjOdUpfqlKJvz7wafQkMfUUF06dAE=
Received: from BY3PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:217::17)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 17:35:06 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::6d) by BY3PR04CA0012.outlook.office365.com
 (2603:10b6:a03:217::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 17:35:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 17:35:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 12:35:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 12:35:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-fixes-7.4
Date: Wed, 21 Oct 2026 13:34:50 -0400
Message-ID: <20261021173450.2959689-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2ed50a-acc1-4647-9d94-08df2f99a53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|13003099007|261021123027099003|261009223027099003|56012099006|11063799006|10067099003|18002099003|6133799003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info: aH7fB0Bv3WmQ1t2DPTElC7VVP3yloArXPvGDtjq6bmbR2bpAR4wFwSMRB6vtyTc3tHneWvnIPVo6wwTWRsXwAY6+/KobSqurhT4moW3nndxYBFPk5qt8XdTdRCXDzbGRznqCcD143u9eEegDzhcZHSLiy4dFtYSfzcw/ZTbRdGv0otVf0JZDvAT2wXdI2itd2+IPOwSNOSbq7dHTPCouEKVEX/8capTfY1umb7eM7P0QdNSu7eNpeN86r9wdzFpERmMrYLMGoF/IxCbz2HhLWQPAd5fw8doj/PYg5CmKxBgy09pCe59EglGXjMesV58DUlVLvrMIZ/Kr9JR6NJIqWgaE41a7L9tGO+mI6X0oPhe4KYL4NrFrQ0FxEhYcEX63SM6n7V8TmJ3WIc3Dut0iFN0/1PIfuJ8tsQJrzz+vDNlu5qFTXSjFBvR/bk8xleCdrLRtyWs0KbX6PXc6ua2e21gkXQ1kVU7OBFolx2L8tvEubPagUPKg0EYOmDCKZIh2qO64kyTwFhZrtRa94D3Rb39aoqE3s4H4PkL394gtnOLtZRpCWk/xj8MQU1x1hS1AFjlTeRiq0jkgZP7Ztl8Dsg8j3+rQF13rLABKDbc/G2E0Qfu3YKIZ2CubHi/fk35dXeDcJCv1aXnk7dbHVwmmVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(13003099007)(261021123027099003)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(261021121427099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uS5gNmjHcAZK5KiTJySjRpF4S0HxoRK9wvANdgEmqegxEcj4mIGu9+xSqCy8C8hPudlrWIyfRGHLsqLPzf1YpwJFzO/RrrRP/GIful1PH/bXWdlaMHOWGGrYKtuWdnDYhEGrkGPTxK309Z90iKLZkLnQC1IgSaN3ptQVyRQVd7T5bCRz5xDFp70wu9cMt5aTdP/OImKr77XMuqRRc8x3FPFsqf8xtEPFZVWd7OzgvUKABwVOb90Ln/i7846JaI9PIDzpJX5/j6plf2bUDOQQNg6YQ9rCX1ghh7idph8N7j0U0ySdX84CxQmcsCyOOvHi/bZln+e51OSV/NywqL9LSnaG4Vc8YlXidKMnYCID1QOrfItfRR1x/cmwQoadJeKwFbqsEleHKEo8fGYo1kanDw0XCBVHSRtdW4Q98Mti6l22UnajRjIRiigIy5KH1gpt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 17:35:05.7265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2ed50a-acc1-4647-9d94-08df2f99a53b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Simona,

Fixes for 7.4.

The following changes since commit a56b45995b1e6b9ee671485b1fe68b0c7f754a67:

  Merge tag 'drm-rust-next-2026-10-11' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next (2026-10-13 18:01:37 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-fixes-7.4-2026-10-21

for you to fetch changes up to 9131cc85d0dedd8ba4cae60dbe5985d081551f30:

  drm/amdkfd: correct vram_available calculation (2026-10-20 12:10:23 -0400)

----------------------------------------------------------------
amd-drm-next-fixes-7.4-2026-10-21:

amdgpu:
- UALink fixes
- Runtime PM fixes
- GPUVM fixes
- Mac fixes
- HDMI fixes
- DP MST fix
- Userptr fix
- SMU fixes
- DSC fix

amdkfd:
- SVM fixes
- Fix doorbell allocation race
- GC 12.1 fix
- GPU reset fix
- Buffer accounting fixes

----------------------------------------------------------------
Asad Kamal (5):
      drm/amd/pm: Update smu_v15_0_8 PMFW headers
      drm/amd/pm: Add set_npm_limit function
      drm/amd/pm: Add NPM metrics reads and SetNpmLimit
      drm/amd/pm: Add store npm limit function
      drm/amd/pm: Notify node unload during driver unload

Daniel Phillips (1):
      amdkfd: Fix memory availability double accounting of kfd pinned objects

Elena Sakhnovitch (1):
      drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950

Harish Kasiviswanathan (1):
      drm/amdkfd: fix NULL deref in SDMA HQD debugfs dump on GC 12.1

Henry Martin (1):
      drm/amdkfd: fix doorbell allocation race creating duplicate allocations

Horatio Zhang (1):
      drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM

Ilya Bakoulin (2):
      drm/amd/display: Fix HDMI FRL FFE compliance test
      drm/amd/display: Adjust HDMI FRL LT timeout

Jesse Zhang (4):
      drm/amdgpu: wake the GPU for INFO queries that access the hardware
      drm/amdgpu: fix the error path in amdgpu_vm_pt_alloc()
      drm/amdgpu: reject ANONONLY userptrs that span multiple VMAs
      drm/amdkfd: don't drop an SVM CWSR reference that was never taken

John Fisher (1):
      drm/amdgpu: wait for pending page table updates before switching a VM to CPU updates

Keita Morisaki (1):
      drm/amd/display: Fix swap in median3() for DSC rate control

Kenneth Feng (1):
      drm/amd/pm:restate all customized OD features on every table upload for smu 13.0.0/smu 14.0.2

Kevin Wang (1):
      drm/amd/pm: reapply umd profile state after recovery

Luigi Lauro (1):
      drm/amdgpu: require _PR3 for BOCO

Maciej Kucharek (3):
      drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
      drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0

Mario Limonciello (1):
      drm/amd/display: don't WARN when removing an unallocated MST payload

Philip Yang (3):
      drm/amdkfd: Fix svm_bo use after free in svm_range_clone
      drm/amdgpu: Reject UALink source-identification address mode
      drm/amdgpu: Enable remote TLB shootdown

William Palacek (1):
      drm/amdkfd: wait for a GPU reset before freeing a BO

Zhen Han (1):
      drm/amdkfd: correct vram_available calculation

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  19 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |  44 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  87 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  14 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  28 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  33 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |  21 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |  12 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  10 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  18 ++-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  10 ++
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  10 ++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  33 +++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |  23 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  23 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  15 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h     |   4 +-
 .../gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c   |   2 +-
 .../amd/display/dc/link/hwss/link_hwss_hpo_frl.c   |   3 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   2 +
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  | 129 +++++++++++++-----
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   3 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 103 ++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  33 ++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   2 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |  33 ++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 101 ++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   8 ++
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h    |  12 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h   |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |   1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  35 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  32 ++---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  38 +++---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   | 151 ++++++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |   4 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  26 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   2 +
 47 files changed, 950 insertions(+), 234 deletions(-)
