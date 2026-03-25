Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC0E109C04A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835A110E7DF;
	Wed, 25 Mar 2026 17:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BKtA3SiN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA9D10E7D6;
 Wed, 25 Mar 2026 17:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2kjiPlOzzK9bHzOxND+gegjTfu1P3FxaU/mPpD5NPp0DlQlD6WubSupn/VMFa1iwdGiPeZd0B0zpN6nuQ0ibI/vmtsceiSxCU+5wqFLr1rV0sLJg5BsvKWnNR2lGJVGS2f4hE6T9eXh/P040vipe0YC+f5Ea2ubjNYBbYbX3W47ZeCpwg9h9zTgY6HtS7BExKl841RWoFng3cxdZGZhB2VoOkvJ4+t+zMQ0UYVBcCqNORL7k/zhVC1xI7QfjJyIUM3ODWnT/45/RDl0G8yBaxoj5dju2uxXsBBpyHvyIUr00MOKm39H1hK/5D5bEtU1S35Sz9TrqWK1QQU9980jUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6Sd08Fn/sHh4+Lgv2g8BEk+3ZwOPa/J8YrVWgNl18o=;
 b=AHzyRb8FBj1mzUgwbFQj6GaPohWY0+m3hbaYRWxmGsBKrfhKDi+vApdpx7W+1EYnElF2TifyXMtz31Yt7EiRMSCJRn6k3QEfXIWSoYijDkHOC1uz1lqcrJgg46/i5buoQio/k/oFIRERWiy3zCSq9p97YfoqWQQPFslzMZAM8Q6QVpRpMMC5PrgobnuaDLap/SPDUJ/bxoNDydnXnFLsZdb/hHrGO9ALxAxFcdJquV75Tdbs1ZpTJMxUhC7oDPTGnDmis/HYElOaq0zLSkbKR7mFvWSHU2RQ2EdXRfZRbkNfbFAVNyB6FDT00yzGx6LRQT+otPWbZ/yrn8Kik7plIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6Sd08Fn/sHh4+Lgv2g8BEk+3ZwOPa/J8YrVWgNl18o=;
 b=BKtA3SiNVvSn46uSYevhcl1tcBKff6J74NRiDrE2MHxGZ+UkX2Ex9LjIpQerG3FQ4U3kCdZqocyvVBm/DdinbEzhnqUB9bOmgKJEAr9VwgZsbHfmRUVgFOmW9gBK6emkjLTnzKeZ7fdWdr7l68gZhHmQVeCbK0Fw+ax/JmRrsTg=
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.7; Wed, 25 Mar 2026 17:50:27 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::11) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 17:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 17:50:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 12:50:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 12:50:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 12:50:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.1
Date: Wed, 25 Mar 2026 13:50:11 -0400
Message-ID: <20260325175012.4185721-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c1bfcb-9936-4377-ea37-08de8a96ff4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Oh5PU+EJlKxjybWQcJgejtWHrnzpcWsTFQaMHPO+51NFyN6P6dUJLgcW9ctOqGjrvBE8w7VhDnD2OmSks/uJ3YWP3jUwoyDpIn6zDuyiqL/YvOyw2JCcNjfACcxRFguKAw3cwrqw7SLp9Y7LbZmv7agALMh0UPKcZIWyvHZ59W6CZbUzsLBdeo9qu7u55pqEp4aBX/Xr3iUZbTBXXg2wq3SpZNGHin5EqI9c9Zf5oo5qc7BCLZ2wtlnOMWUg8m4NJese5MtM/dU3e7JNL+ffecjNKFUpaJ0UMOWqcEGE1HOiGjiPYZbrtMZXvGkUs5pQeQ2PTA0BKq5OTmd6NAiyePMDua58H79pArZujMcfjxPDzn/G7Xd4fRVuKzPnhufa/d2/dDC5CiIEx+GZEZQ0ulBIUE4ZH0k8Rj5Npi6XtpY52IP03FQBSz8oidv5WB5sQEug5g3DZWjoV28BanDEAla6Ker7iSfzPPLhtlzzCJN6Eu8wBrsDXRd+QMr3lzOf+6IvMSqoOqp1yiIglBVwIi0dTu0dK0B+qRcLOnQUbMY4va73OO0MrOPOl6SNm9E560lg5czxHnxNw5cU2gDyo42jeZjLEGOUG76w+F8yBMUr6lbM+IndohfVJZjXjizHm1iTCRbWx5hgyjboKKD0XZFQPuUXsWNwjYmm7RYoX5sdgSCzlOD4+7HLQ/PMEsJD06tujnfM6cHwy0fhGa0qJncQDehXIuLRQP7S284UACo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xj4x1TSk/a1slag9ul5IhYu7paJ/CAqu0y3vISKkJRF177BA5/mvYsbSXmPmJbx9tRZXBtNEh3beNao/eQCHVDZK89eJ+KsmkTPocmzW9d2nsf55en5yUq9jB829v7fmPNMG3XZcZiJYJD/e/7IPhAux6momdX87TDjL5gi8dhYO4IpVbQ665XOSds8v70bygUFTvQ/GUuTnwK+Fs+YkH3uz36gG82IKel7PnDGybrXlgLYPdftPNZEX+bIuA9fQ5wy4GTEALcfdXXjcFNBo8Li6QA+6bOSsjgncOfS1nEA1+YzMtIK11Hj7H42NKje2a1pplD+TejYvJUr/e5zgKl4RdheenMSQ1vKjEIJAxrmyDm3JJP+vps0dDgcrkgxG1KuO3GCzAZbE7+6EiTSj3knA0B4E86gfRFd19mcctQKQo2yVEO30SJ2AZ1bqC15b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 17:50:26.5640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c1bfcb-9936-4377-ea37-08de8a96ff4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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

More stuff for 7.1.

The following changes since commit b3970e97490abfb040305f14327d75e7568f31c4:

  Merge tag 'amd-drm-next-7.1-2026-03-19' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2026-03-21 02:22:03 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-2026-03-25

for you to fetch changes up to 68178644c35fca972ed970dc84933281b4913bff:

  drm/amd/display: add a no_hpd link_encoder_funcs variant (2026-03-24 13:35:28 -0400)

----------------------------------------------------------------
amd-drm-next-7.1-2026-03-25:

amdgpu:
- DSC fix
- Module parameter parsing fix
- PASID reuse fix
- drm_edid leak fix
- SMU 13.x fixes
- SMU 14.x fix
- Fence fix in amdgpu_amdkfd_submit_ib()
- LVDS fixes
- GPU page fault fix for non-4K pages
- Misc cleanups
- UserQ fixes
- SMU 15.0.8 support
- RAS updates
- Devcoredump fixes
- GFX queue priority fixes
- DPIA fixes
- DCN 4.2 updates
- Add debugfs interface for pcie64 registers
- SMU 15.x fixes
- VCN reset fixes
- Documentation fixes

amdkfd:
- Ordering fix in kfd_ioctl_create_process()

----------------------------------------------------------------
Adriano Vero (1):
      drm/amd/display: clean up typecasts and constants in dcn4_calcs

Alex Deucher (6):
      drm/amdgpu/pm: drop SMU driver if version not matched messages
      drm/amdgpu/gfx10: look at the right prop for gfx queue priority
      drm/amdgpu/gfx11: look at the right prop for gfx queue priority
      drm/amd/display: check if ext_caps is valid in BL setup
      drm/amd/display: Fix DCE LVDS handling
      drm/amd/display: add a no_hpd link_encoder_funcs variant

Alex Hung (1):
      drm/amd/display: Fix drm_edid leak in amdgpu_dm

Alexander Chechik (1):
      drm/amd/display: Fix DCN42 memory clock table using MemClk instead of UClk

Asad Kamal (18):
      drm/amd/pm: Skip redundant UCLK restore in smu_v13_0_6
      drm/amd/pm: Return -EOPNOTSUPP for unsupported OD_MCLK on smu_v13_0_6
      drm/amd/pm: Add OD_FCLK interface
      drm/amd/pm: Add custom fclk setting support
      drm/amd/pm: Add mode2 support for smu_v15_0_8
      drm/amd/pm: Update dpm table structs for smu_v15_0
      drm/amd/pm: Add default dpm table support for smu 15.0.8
      drm/amd/pm: Add get_pm_metrics support for smu 15.0.8
      drm/amd/pm: Add emit clock support
      drm/amd/pm: add populate_umd_state_clk support
      drm/amd/pm: Add od_edit_dpm_table support
      drm/amd/pm: Add get_thermal_temperature_range support
      drm/amd/pm: Add ppt1 support
      drm/amd/pm: Add read sensor support
      drm/amd/pm: Add gpuboard temperature metrics support
      drm/amd/pm: Add baseboard temperature metrics support
      drm/amd/pm: Add NPM support for smu_v15_0_8
      drm/amd/pm: Enable user specified gfx clock ranges

Charlene Liu (8):
      drm/amd/display: dcn42 don't round up disclk and dppclk
      drm/amd/display: System Hang When System enters to S0i3 w/ iGPU
      drm/amd/display: Add Extra SMU Log for dtbclk
      drm/amd/display: remove disable_sutter touch pstate debug code
      drm/amd/display: pg cntl update based on previous asic.
      drm/amd/display: export get_power_profile interface for later use
      drm/amd/display: remove dc_clock_limit for apu
      drm/amd/display: add dccg FGCG mask init

Chen Ni (1):
      drm/amdgpu/userq: convert comma to semicolon

Christian König (3):
      drm/amdgpu: make amdgpu_user_wait_ioctl more resilent v2
      drm/amdgpu: annotate eviction fence signaling path
      drm/amdgpu: fix some more bug in amdgpu_gem_va_ioctl

ChunTao Tso (1):
      drm/amd/display: Agument live + capture with CVT case.

Colin Ian King (1):
      drm/amdgpu/mes12_1: emove extra ; from declaration statement

Dillon Varone (2):
      drm/amd/display: Refactor DC update checks
      drm/amd/display: Add 3DLUT DMA broadcast support

Dmytro Laktyushkin (1):
      drm/amd/display: move dcn42 bw_params init

Donet Tom (1):
      drm/amdgpu: Handle GPU page faults correctly on non-4K page systems

Eric Huang (1):
      drm/amdgpu: prevent immediate PASID reuse case

Gaghik Khachatrian (2):
      drm/amd/display: Fix Silence warnings
      drm/amd/display: Fix Signed/Unsigned Int Usage Compiler Warning

Hawking Zhang (5):
      drm/amd/pm: Add smu v15_0_8 driver interface header
      drm/amd/pm: Add smu v15_0_8 message header
      drm/amd/pm: Add smu v15_0_8 pmfw header
      drm/amd/pm: Add initial support for smu v15_0_8
      drm/amdgpu: Add smu v15_0_8 ip block

Hou Wenlong (1):
      drm/amd/display: Rename enum 'pixel_format' to 'dc_pixel_format'

Ivan Lipski (2):
      drm/amd/display: Move DPM clk read to clk_mgr_construct in DCN42
      drm/amd/display: Move DPM clk read to clk_mgr_construct in DCN42

Jesse Zhang (1):
      drm/amdgpu/vcn4.0.3: gate per-queue reset by PSP SOS program version

Jesse.Zhang (3):
      drm/amdgpu: replace WARN with DRM_ERROR for invalid sched priority
      drm/amdgpu: use DISCOVERY_TMR_SIZE in ACPI TMR fallback
      drm/amd/pm: Enable VCN reset for pgm=4 with appropriate FW version

Joshua Aberback (1):
      drm/amd/display: Restore full update for tiling change to linear

Kexin Sun (2):
      drm/amd/display: update outdated comments for renamed vblank_control_worker()
      drm/amdgpu: update outdated comment for renamed amdgpu_fence_driver_init()

Lijo Lazar (1):
      drm/amdgpu: Use stack variable to fetch nps info

Matthew Stewart (1):
      drm/amd/display: Hardcode dtbclk value in bw_params

Meenakshikumar Somasundaram (1):
      drm/amd/display: Update dpia supported configuration

Nicholas Kazlauskas (3):
      drm/amd/display: Add MRQ programming for DCN42
      drm/amd/display: Split arbiter programming for DCN42
      drm/amd/display: Revert inbox0 lock for cursor due to deadlock

Prike Liang (1):
      drm/amdgpu: fix syncobj leak for amdgpu_gem_va_ioctl()

Relja Vojvodic (1):
      drm/amd/display: Rework YCbCr422 DSC policy

Roman Li (4):
      drm/amd/display: Add get_default_tiling_info for dcn42
      drm/amd/display: Add missing dcn42 hubbub function pointers
      drm/amd/display: Clamp min DS DCFCLK value to DCN limit
      drm/amd/display: Update underflow detection for DCN42

Ruijing Dong (1):
      drm/amdgpu: fix strsep() corrupting lockup_timeout on multi-GPU (v3)

Srinivasan Shanmugam (9):
      drm/amd/ras: Remove redundant NULL check in pending bad-bank list iteration
      drm/amdgpu: Avoid NULL dereference in discovery topology coredump path v3
      drm/amd/ras: Add NULL checks for ras_core sys_fn callbacks
      drm/amd/ras: Add input pointer validation in ras core helpers
      drm/amdgpu: Skip discovery dump when topology is unavailable
      drm/amd/display: Add clk_mgr NULL checks in dcn32_initialize_min_clocks()
      drm/amd/display: Fix NULL pointer assumptions in dcn42_init_hw()
      drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib
      drm/amdkfd: Fix NULL pointer check order in kfd_ioctl_create_process

Stanley.Yang (1):
      drm/amdgpu: Add amdgpu_regs_pcie64 debugfs node

Sunil Khatri (3):
      drm/amdgpu/userq: cleanup amdgpu_userq_get/put where not needed
      drm/amdgpu/userq: dont use goto to jump when at end of function
      drm/amdgpu/userq: schedule_delayed_work should be after fence signalled

Taimur Hassan (1):
      drm/amd/display: Promote DC to 3.2.375

Wayne Lin (1):
      drm/amd/display: Remove unnecessary completion flag for secure display

Yang Wang (7):
      drm/amd/pm: Setup driver pptable for smu 15.0.8
      drm/amd/pm: add get_gpu_metrics support for 15.0.8
      drm/amd/pm: add get_unique_id support for smu 15.0.8
      drm/amd/pm: add set{get}_power_limit support for smu 15.0.8
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu v13
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu v14
      drm/amd/pm: add dedicated dram addr msg for smu v15

Yussuf Khalil (1):
      drm/amd/display: Do not skip unrelated mode changes in DSC validation

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  112 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   81 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |   45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |   52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |   19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   24 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    7 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |    1 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    4 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |  263 +--
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  500 ++---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   30 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   25 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |    1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    6 +-
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    8 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |    1 +
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   64 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |   32 +-
 .../amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c  |    2 +-
 .../display/dc/dml2_0/dml2_translation_helper.c    |    6 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c  |    4 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |   13 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |    2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c   |    2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |    2 +-
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |   63 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |   35 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |    6 +
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |   17 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  108 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    3 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   27 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |    2 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   10 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |    3 +-
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |    9 +-
 .../display/dc/resource/dce100/dce100_resource.c   |    6 +-
 .../display/dc/resource/dce110/dce110_resource.c   |    5 +-
 .../display/dc/resource/dce112/dce112_resource.c   |    5 +-
 .../display/dc/resource/dce120/dce120_resource.c   |    5 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |   14 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |    6 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |    2 +
 .../display/dc/resource/dcn315/dcn315_resource.c   |    2 +
 .../display/dc/resource/dcn401/dcn401_resource.c   |    2 +-
 .../display/dc/resource/dcn401/dcn401_resource.h   |    1 +
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |    5 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.h |    3 +
 .../dcn42/dcn42_soc_and_ip_translator.c            |    8 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |    1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  |    7 +-
 .../drm/amd/display/modules/color/color_gamma.c    |    2 +
 .../drm/amd/display/modules/freesync/freesync.c    |    6 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |    1 +
 .../amd/include/asic_reg/dcn/dcn_4_2_0_offset.h    |    6 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   67 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   18 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |    8 +
 .../pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h |  295 +++
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h    |  427 ++++
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h   |  100 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |   19 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |   55 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |    1 -
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |    1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |    2 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   33 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  104 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   33 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |    1 -
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   33 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile        |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |  160 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   | 2270 ++++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |  313 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   14 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |    1 +
 drivers/gpu/drm/amd/ras/rascore/ras_core.c         |   22 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c          |    2 +-
 104 files changed, 4866 insertions(+), 944 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
