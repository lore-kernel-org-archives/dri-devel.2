Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DA3C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56CE10E467;
	Wed, 12 Aug 2026 21:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tOIVqLrw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACDC10E45B;
 Wed, 12 Aug 2026 21:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6itMgVlqCAab9ePUHwhUhzTKhQzjK8HpH94QWzXwLGH0Yhrv3+IN6lJeb7uFTcVd77Pm4Xse4mCdz7nxc+Ub/MlX0Ua7EIDimnYqpYVDC56EAY3e3xt4YnXD+aqSNZKDYTnOFW9Fp5BWoi2ps6maLMZROvRPkdfeUez17GWbi4juBdKdg8FcdajqAFcBw5IRYvlDFvxFPPP1p3E5Lh/X87AFpfwlZMbBM/6eSKaYcSU7+Oqxkb3q/nkFVnH3qAxPgyg1Q+y1vOuKdes2gFHFJki0SvJHFVvPWsYu9zhNgXXKd5tTCCfH59+rkASWZyi0NZhpPDMKKNONU1IL75C7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3sMW7lrjwl+eu4mPNAvwMgYTc9ldeHGxFxYt3FcXMc=;
 b=ZAFx/PSPM2wfItTts5jrvb3soYSZgTCi/OQ2zvQCNEUQNtKo8kso5RtUX6KCJBLXZ61o3M5OOaa+tovRGU+Kmnp5gWHurS0DCs8H4WP/rR30GhmJJPOPmKB8Hgv9+FsgwUjAsMp/1lNYeo5vw00KyvPw47b6JDbhuoOwgpWZpPDq59yhEDCZfVwfYAZbmBIcTtpfT18gpHhije8XCJ/pGwmeR3VBvR/X5OJSorF4/MoJQLjChSBpWYJwkgZSk56pbma+XQEeXDifVRWpzZUiti8hBRst0kLVJCIbZL9qDDSbw3+ydKoXjFAR44EtzIpiPjfzcpOB3QlNSp3bZMis4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3sMW7lrjwl+eu4mPNAvwMgYTc9ldeHGxFxYt3FcXMc=;
 b=tOIVqLrwl6H6IAthQCVc5NNlYlrp9R1ECLWCGcvMOsYIvQLTxAZONYHh9goAdqen/riQ0IfWLqoeNnMZCDKhj+WHEHJUOdg7sd/g6/XhezKpWYIzuwjex4sztqpintrz51ne+3HLd3tC1xs/zkVJKUhCpOJBMgVtQaSspqQGjwM=
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 21:47:27 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::60) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 21:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 12 Aug 2026 21:47:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:47:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:47:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 16:47:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.3
Date: Wed, 12 Aug 2026 17:47:16 -0400
Message-ID: <20260812214716.2156632-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdaf5e9-f49b-4b36-453b-08def8bb4d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|56012099006|3023799007|18002099003|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info: B4ALGhOLgigtty37AR7055XlN2d387cIVEyGrPADSOPL98Lv3EgEHwZbAibSsDRMyVkDdcTMKkGuOup6KvB3dg0PdgQhIpCWRGR+njyHe1f8my7H+L4wM5SSwRTg2CCtc/P9kd4glOc76K2kifWSgfGo8X1NFyUubx/4jJGP99bTZDpro9vtfku5i4Uz7V80epiN4Xbm/KJ+XlX786IXg+UALHBmjBSMN+7jEHYu8o0pODWZK6YdtUZyDp1vRqkudy5wa6NSfXxQELlA+y2KkqUbo0GAGx77pSaSYbDpqH3qOW7/7uUJLGy5PzvG+UHKXxY5Itl2gaL1dtenrDch8SbaDgGhQ1lu4gqJ27Fw1ZOfKGdIFL/+E3r72mnu/bqSyWR0qfPaZd9SHJbTr4VkJLIXHq/FJ9eOx/rGDAyrE7L8WhL4BDOoIE39sSzlk74FUHF0EiveSk1yu17tySVnFAfELAw0Ol6FMSntYjE4YBbu4D0elAhoVTIyr2cgG06OPYw1KiGYNVaZP538mdbPD7v5QxWBO6Mk+VJCGqrAYL89opUAL9bxE4PIssZaIjtM8V20zRcb/diR7d+EiG7LOOEW1p+F7jEueFo7n/Jg9w7GQHcvkvI3zozbwfkFyhDaI9hmJflYo5CzFKEqI3ff3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(3023799007)(18002099003)(13003099007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rGjGm7R4BWxeWpzVaFzSpDEC9zoP/iQkq+dPvZFvtodsh4/CuppPKa45oST5MzpO5l2857hoMRDbdoZRvFwZ9O4xY4i4sdC01hQXCH49SBzRpprnnV4ZQrzpPzaFDV0DmuXrLMr+Hi/1D+N6LH7K2DMTHw+qsioVlCVBObWyYBoJ9YIB3sSx1zqXask2FyJtPiudwHiyZafHMHOgnFuwN6eTgE0HgYpAgVxP3RwG/aHawKhD5G8EjTJyY7winChwVBa7952knpY79EYTDapPJCcOp9X0N8xhlQMmpBUfqhEiNn81/l05sruGqlDCnF4U6Qq/geJ2aTcEH5XP1gl8IxrpgivGOQa/jjT7ew79RssMsuDgxRUdkZrsJ935LTqb2HBhQ2s77kM1L7ih93mtVFCuCciGCuF3F7pmCgkcYb3Jh2dfvhKFptz8YbkIR/sk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:47:26.8577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdaf5e9-f49b-4b36-453b-08def8bb4d17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

Fixes for 7.3.

The following changes since commit 29daacacf4cd84e6917f09de6a99fb170071c14c:

  Merge tag 'drm-rust-next-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next (2026-08-10 14:48:11 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-08-12

for you to fetch changes up to 0d710af8e4abdd1fa500bddbab7c0ee47fc98143:

  drm/amd/display: make DC_RUN_WITH_PREEMPTION_ENABLED misuse a build error (2026-08-12 09:45:03 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-08-12:

amdgpu:
- Bounds checking fix in CS IOCTL
- Bounds checking fix in GEM IOCTL
- Display fixes
- GPUVM fix
- ASPM fix
- UVD bounds checking fixes
- VCE 3 fix
- BT.2020 fixes
- NBIF 6.3.1 fix
- IP discovery fix
- SMU metrics reporting fixes
- SMU 15 fixes
- Misc fixes
- MES 11 fix
- Frame size fix for some versions of clang
- Userq fixes
- GTT recovery fix

amdkfd:
- Hibernation fix
- Kernel-doc warning fixes

radeon:
- Runtime pm fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: fix missing check in vm_flush()
      drm/amdgpu: handle GDS and SPM without a VM fence

Candice Li (1):
      drm/amdgpu: validate GEM_CREATE domain combinations

Dan Carpenter (1):
      drm/amd/pm: silence uninitialized variable warnings

David Rosca (6):
      drm/amdgpu: Reject UVD message with dimensions above 4096
      drm/amdgpu: Fix UVD dpb min size calculation for H264
      drm/amdgpu: Fix UVD decode image min size calculation
      drm/amdgpu: Fix UVD min buffer sizes
      drm/amdgpu: Implement insert_end for VCE 3
      drm/amdgpu: Reject UVD message with invalid number of h265 refs

Guangshuo Li (1):
      drm/radeon: fix autosuspend cleanup during teardown

Ivan Lipski (1):
      drm/amd/display: Relax frame size limit for dcn5/6 DML core funcs files

Jesse Zhang (1):
      drm/amdgpu: keep PRT mappings off the vm_bo state lists

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Lijo Lazar (3):
      drm/amd/pm: Simplify SoC power printing in debugfs
      drm/amd/pm: Keep sub-watt precision in Q10 socket power
      drm/amd/pm: Keep sub-degree precision in Q10 temperatures

Mikhail Gavrilov (1):
      drm/amd/display: make DC_RUN_WITH_PREEMPTION_ENABLED misuse a build error

Nathan Lucas (2):
      drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
      drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: don't disable ttm buffer funcs on reset

Prike Liang (1):
      drm/amdgpu/mes11: disable MES RS64 process/gang context loading

Randy Dunlap (1):
      drm/amdkfd: kfd_ioctl.h: fix most kernel-doc warnings

Samuel Pitoiset (1):
      drm/amd/display: Fix NULL pointer dereference in amdgpu_dm_crtc_set_vblank()

Shikang Fan (1):
      drm/amdkfd: preserve VRAM MQD across hibernation via unpin/repin

Shubhankar Milind Sardeshpande (1):
      drm/amdgpu: Enable GFXOFF functionality for SMU IP v15.0.5

Yang Wang (2):
      drm/amdgpu: check ASPM on the dGPU host link
      drm/amdgpu: fix nbif 6.3.1 l1 low power not functional

Yifan Zhang (1):
      drm/amdgpu: skip BOs being torn down during GTT recovery

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  52 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  21 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |  23 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  16 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  85 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  57 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |  42 ++---
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  21 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |  26 ++-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 106 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |   8 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  40 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h     |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  31 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   7 +-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |   7 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |   8 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  27 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |   7 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |  12 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  12 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   1 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  25 +--
 drivers/gpu/drm/radeon/radeon_kms.c                |   1 +
 include/uapi/linux/kfd_ioctl.h                     | 180 ++++++++++-----------
 34 files changed, 584 insertions(+), 275 deletions(-)
