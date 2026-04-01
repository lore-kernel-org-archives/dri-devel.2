Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A1510FCAC9
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 18:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DDC10E55D;
	Wed,  1 Apr 2026 18:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iuk8Aadm";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DE210E55D;
 Wed,  1 Apr 2026 18:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weJVMbCJyLDmcmbDOK7cdG6G8+r2QOFZpRMDOH+fX3YdL8M0u2x+5COlgOXsCxU3rQ2A+e0mHwyGNJ9miPx0SRrxZGZg3azq1T4+xoyGP6aYOrD03tj1/IDomFVjNG8GQvp5TdRlDMGVZvA3Rj1/2Xv+szK+z/3Cjypki4/vAM17yiK69PLbBfsJIWRnynBPKlIFHJYI0HN8tWfQS4pDq9Rj2iI9JSrrWajnMHxTc/mc0EITTLn7jAHDtyYTca6k+xeArKQs6byExiztTNlpsaR6ED4qWP4D0VyyJ5ozNEKA9xQwh8SeM6LrsxkC/sRxHN0IA1TwOFIkOOi4bFxaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgjLo21m5svCRUamn0D8ohIx2AN6+uYRarSRY9O9fzk=;
 b=Mid1Uf2g58Rix2pPuvQbcsGkJKo9ZH3Q3bncSflRHgEWgxBpv/dTP8EBGQk0ljhOM5uKjeDyiDqCymD8X6zqJu1S4iJ9nLN/BizHUXcpsr1blMINplKoFecCwnh/3x3XpxRLQiSBCJOh7TzmnyRNNMCS8y2TY7im5ESYmbsNgfFq+f6DcfAQHCH/+yM1KYsQk3LjzS2eEMoeWYoI2fDi04vnVMWAQnr7Kzg2DL6j7V1obJ1/ZWkKicOiPDpYEJvtClbDmD0l202M7gTwjPIL0IypX+xBd+OHTa3t6/5sHEs8hxbF6K3WaE5jqlZqp6CwpWj1xWs7Tc6oWmy+QEpG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgjLo21m5svCRUamn0D8ohIx2AN6+uYRarSRY9O9fzk=;
 b=iuk8AadmIHraQGG5ZHIEBwrgPkZFlQzV+qvk79GMiEYAt6XsAdjtKbcW1rZpz0dyGrqiNmA+Gy9mRCWKJEfKRqLF7iB46HwgsH8kxlh69VeOfS4TKkvVCCgPfuZsD6EzeZ5xae86q1Sgp74zTf1Z7S8PiDpUTqhD8xvaR0zRDq4=
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 18:45:09 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::20) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Wed,
 1 Apr 2026 18:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:45:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 1 Apr
 2026 13:45:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Apr
 2026 13:45:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 13:45:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.1
Date: Wed, 1 Apr 2026 14:44:56 -0400
Message-ID: <20260401184456.3576660-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e80036-f65f-489f-4021-08de901ecc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yDzVrQsOCuMyLO7nATi4y9l9quAD5r8KDgL6252I/2Ps2nO2mXucPXwFL/CeAcpbKDaCj5SkeVldvy6xLJX6bSgpg+6TCx8XwjT629mAURyksc9LoBdPXHGOfwKUR3gkQJPoL79h+v1xCESUnsQyCgAUJKOsHybZ6CBy25n5+0e4iA7nM8vp4SPcadgZZHG77MBIAIk4PfPXXTw9CMn01B4FxHCFZZrfyJJ4y0wKirCsrmRPixaox99/7tgMN1BQDPA8M19gJJUUh3v028H06k/Sh1aXNxeCEA4pxJUvoqdJfDzVx9m6kAp3/pUZ7e+/j+EH9QPgEUVVfy1zYk2m3ht3gkb9hZcF4Xl/3rBXowKhyqBr6o4VxJqDbGpwZS/bgl/n5PA5VytZnoJqEmCXzmlWhbo9C6X48duwbtXjBJS3lcINLmNgoPbL7W0zbOMNf7+adWJy4fsQ7xmEIcJ391A6NJMtP4aZ0WjihsigU21tJaqbe/Kp8KV/f1qQcmtWYkBbD57GwxMIN+cw3ULX4Pt6tSeUb9dW+76Z2RDlBK7zijTlZRXkxucPngIfeRDo5WCB6KNTYqAul6fsjVJZpKMhZ3faplNfnRJQ61K4S3PooqTvV+5JMjPcI5fLRUJhy8QzAggQXgJe34IkXZIPKJ4QhEq2SPxjU4cPwHBVktd5NJfLqvVON1W/pVR0GeXHTFLQuEDSLdew/cGNuWhmlG1/o9N/vGwj2hNOAEZ565A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TTir6vBAoZqEXsc0ZkM7FCF5RG64g9lQabqRw7n7RhNr3YDTTemy8iNmaX9lDtXS1EavhnOPLiUpH1iL8zOGJJzvpd0PZazSrHhtehHmYENR+nGhKDBsi5TDtHUsODJQijf2/sKk74aVq4aYnzBuuVBMzTxLVl3azPy53xQmgTDUeXLiIprLjTat29VeG75sURUpWAjty1jgZgEfjgpc78PabiC4++pxktZtqC2LMQUcFitnVlLN/zXw3+NKZvpGT3Dj7i1NBipfZuOT+vh1C8x70ax6EpX6G38lOTPi6fsd+dYYmFlGeXu8s/b6GNen9Zvv37mjRpX4xu35vGgnLrY5GIiY9sNhqTk2+qZqqxUPkrVb/1vsZ2z/xGGMNfo6MVS5srh/UMBZv3853CPhl/DyOEVj2aiXBy0gJsS6Qm0kz5dW23J48kcSxG77ccLl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:45:08.4657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e80036-f65f-489f-4021-08de901ecc62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

The following changes since commit a51973c5dff8a0f01cc7d1b2007306ea0004fa16:

  Merge tag 'drm-xe-next-2026-03-26-1' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2026-03-30 06:04:59 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-2026-04-01

for you to fetch changes up to 8b3e8fa6d7bdab292447a43f70532db437d5d4f5:

  drm/amdgpu/uvd4.2: Don't initialize UVD 4.2 when DPM is disabled (2026-03-30 16:49:12 -0400)

----------------------------------------------------------------
amd-drm-next-7.1-2026-04-01:

amdgpu:
- UserQ fixes
- PASID handling fix
- S4 fix for smu11 chips
- devcoredump fixes
- RAS fixes
- Misc small fixes
- DCN 4.2 updates
- DVI fixes
- DML fixes
- DC pipe validation fixes
- eDP DSC seamless boot
- DC FP rework
- swsmu cleanups
- GC 11.5.4 updates
- Add DC idle state manager
- Add support for using multiple engines for buffer fills and clears
- Misc SMU7 fixes

amdkfd:
- Non-4K page fixes
- Logging cleanups
- sysfs fixes

----------------------------------------------------------------
Asad Kamal (1):
      drm/amd/pm: Use str_enabled_disabled in amdgpu_pm sysfs

Charlene Liu (1):
      drm/amd/display: correct unknown plane state patch

Clay King (2):
      drm/amd/display: Fix silence signed/unsigned mismatch warnings in dml
      drm/amd/display: Fixed silence signed/unsigned mismatch warnings

Dillon Varone (3):
      drm/amd/display: using cm structure for lut3d related info
      Revert "drm/amd/display: Add 3DLUT DMA broadcast support"
      Revert "drm/amd/display: Refactor DC update checks"

Donet Tom (4):
      drm/amdkfd: Align expected_queue_size to PAGE_SIZE
      drm/amd: Fix MQD and control stack alignment for non-4K
      drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB
      drm/amdkfd: Fix queue preemption/eviction failures by aligning control stack size to GPU page size

Eric Huang (1):
      drm/amdkfd: fix kernel crash on releasing NULL sysfs entry

Gabe Teeger (3):
      drm/amd/display: Remove check for DC_DMCUB_ENABLE on DCN42
      drm/amd/display: Fix bounds checking in dml2_0 clock table array
      drm/amd/display: eliminate clock manager code duplication

Gaghik Khachatrian (6):
      drm/amd/display: Fix Compiler Warning - unused func parameters
      drm/amd/display: Fix Silence Conversion Warnings in Dmub
      drm/amd/display: Fix Silence signed/unsighed mismatch warning in dc
      drm/amd/display: Fixed Silence complier warnings in dc
      drm/amd/display: Fix Compiler warnings in dmub
      drm/amd/display: Silence type conversion warnings in dml2

Gangliang Xie (2):
      drm/amdgpu: reset ras eeprom table when it is invalid
      drm/amdgpu: add support to query vram info from firmware

Harry Wentland (2):
      drm/amd/display: Merge pipes for validate
      drm/amd/display: Don't set 4to1MPC config dynamically

Jesse Zhang (2):
      drm/amdgpu: guard atom_context in devcoredump VBIOS dump
      drm/amdgpu: flush coredump work before HW teardown

Junrui Luo (2):
      drm/amdgpu: validate doorbell_offset in user queue creation
      drm/amdgpu/userq: fix memory leak in MQD creation error paths

Lang Yu (1):
      drm/amdkfd: Switch to dev_* printk stuff in kfd_int_process_v12_1.c

Lijo Lazar (4):
      drm/amd/pm: Unify version check in SMUv11
      drm/amd/pm: Unify version check in SMUv12
      drm/amdgpu: Fix wait after reset sequence in S4
      drm/amd/pm: Unify version check in SMUv14

Lincheng Ku (1):
      drm/amd/dc: Add link output control for DPIA

Mohit Bawa (1):
      drm/amd/display: enable eDP DSC seamless boot support

Nicholas Kazlauskas (1):
      drm/amd/display: Avoid turning off the PHY when OTG is running for DVI

Ovidiu Bunea (1):
      drm/amd/dc: Disable PSR & Replay CRTC disable by default

Pengpeng Hou (1):
      drm/amd/display: bios_parser: fix GPIO I2C line off-by-one

Pierre-Eric Pelloux-Prayer (5):
      drm/amdgpu: allocate clear entities dynamically
      drm/amdgpu: allocate move entities dynamically
      drm/amdgpu: round robin through clear_entities in amdgpu_fill_buffer
      drm/amdgpu: use TTM_NUM_MOVE_FENCES when reserving fences
      drm/amdgpu: use multiple entities in amdgpu_move_blit

Prike Liang (1):
      drm/amdgpu: fix the idr allocation flags

Rafal Ostrowski (3):
      drm/amd/display: Move FPU Guards From DML To DC - Part 1
      drm/amd/display: Move FPU Guards From DML To DC - Part 2
      drm/amd/display: Move FPU Guards From DML To DC - Part 3

Ray Wu (1):
      drm/amd/display: Add Idle state manager(ISM)

Relja Vojvodic (1):
      Revert "drm/amd/display: Rework YCbCr422 DSC policy"

Roman Li (2):
      drm/amd/display: Enable Replay support for dcn42
      drm/amd/display: Remove invalid DPSTREAMCLK mask usage

Srinivasan Shanmugam (5):
      drm/amd/display: Avoid NULL dereference in dc_dmub_srv error paths
      drm/amd/display: Add NULL check for integrated_info in clk_mgr_construct
      drm/amd/display: Add update_descriptor param info in 'update_planes_and_stream_state'
      drm/amd/display: Fix NULL pointer dereference in dcn401_init_hw()
      drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.5.4

Sunil Khatri (2):
      drm/amdgpu/userq: amdgpu_userq_vm_validate does not need userq mutex
      drm/amdgpu/userq: Fix the code alignment for readability

Taimur Hassan (2):
      drm/amd/display: [FW Promotion] Release 0.1.53.0
      drm/amd/display: Promote DC to 3.2.376

Timur Kristóf (9):
      drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is disabled
      drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
      drm/amd/pm/smu7: Fix SMU7 voltage dependency on display clock
      drm/amd/pm/smu7: Remove non-functional SMU7 voltage dependency on DAL
      drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
      drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
      drm/amd/pm/ci: Fill DW8 fields from SMC
      drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
      drm/amdgpu/uvd4.2: Don't initialize UVD 4.2 when DPM is disabled

Wayne Lin (1):
      drm/amd/display: Should support p-state under dcn21

 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   | 459 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |  25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |  44 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  29 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 131 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  14 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  58 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  16 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |   5 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c |  28 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |   3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  41 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  92 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |   6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  | 598 +++++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  | 151 ++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  22 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |  63 +++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |   6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |  25 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h     |  17 +-
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c  |   8 +-
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c |   1 +
 drivers/gpu/drm/amd/display/dc/basics/vector.c     |   1 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   9 +
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   2 +
 .../dc/bios/dce110/command_table_helper_dce110.c   |   1 +
 .../dc/bios/dce112/command_table_helper2_dce112.c  |   1 +
 .../dc/bios/dce112/command_table_helper_dce112.c   |   1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |   5 +-
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |   2 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |   3 +-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |   3 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |   7 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |  10 +-
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |   6 +-
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |  10 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |  10 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |   4 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |   7 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |   3 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |  31 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 581 +++++++++++++-------
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   1 +
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |  77 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  13 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h                |  30 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |   1 -
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   1 +
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c |   2 +
 .../gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c |   1 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |   2 +
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c   |   8 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |   3 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  10 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c       |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c    |   3 +
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c       |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c       |   1 +
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |   1 +
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |  10 +
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |   1 +
 .../amd/display/dc/dce110/dce110_opp_regamma_v.c   |   2 +
 .../display/dc/dce110/dce110_timing_generator.c    |   9 +
 .../display/dc/dce110/dce110_timing_generator_v.c  |   9 +
 .../drm/amd/display/dc/dce110/dce110_transform_v.c |   6 +
 .../drm/amd/display/dc/dce112/dce112_compressor.c  |   1 +
 .../display/dc/dce120/dce120_timing_generator.c    |   7 +
 .../amd/display/dc/dce80/dce80_timing_generator.c  |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |   8 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c   |   2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c   |   4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c   |   1 +
 .../display/dc/dio/dcn10/dcn10_stream_encoder.c    |   2 +
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c      |   2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c        |   2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c        |   1 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c      |   3 +
 .../display/dc/dio/virtual/virtual_link_encoder.c  |  65 ++-
 .../dc/dio/virtual/virtual_stream_encoder.c        | 111 ++--
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |   1 +
 .../gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c   |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |   3 +-
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |   4 +
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |   5 +
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  |   5 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |   5 +
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |  19 +
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |   5 +
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |   2 +
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |  23 +
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  |   5 +
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |  24 +
 .../display/dc/dml/dcn31/display_rq_dlg_calc_31.c  |   8 +
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |   6 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |  24 +
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c        |   8 +
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |  23 +
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |   8 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |   7 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |   1 +
 .../amd/display/dc/dml/display_rq_dlg_helpers.c    |  14 +
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |  74 +--
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |  39 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |  15 +-
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.c    | 380 +------------
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.h    |  30 --
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.c    | 381 +++++++++++++
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.h    |  60 +++
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  20 +
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c   |   9 +-
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c  |   9 +-
 .../amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c  |  28 +-
 .../drm/amd/display/dc/dml2_0/dml2_mall_phantom.c  |   3 +-
 .../display/dc/dml2_0/dml2_translation_helper.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |   3 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c   |  23 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c   |   9 +-
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |   1 +
 .../gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c   |  11 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c    |   1 +
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |   1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |   1 +
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |   5 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  13 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |   2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c   |   2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |   7 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |   5 +
 .../gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c   |   1 +
 .../amd/display/dc/gpio/dcn42/hw_translate_dcn42.c |   1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |   1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c      |   1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |   1 +
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |   1 +
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |   1 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |   4 +
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |   2 +
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |   2 +
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |   2 +
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |   2 +
 .../gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c |   1 +
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |   3 +
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |   1 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  40 +-
 .../drm/amd/display/dc/hwss/dce120/dce120_hwseq.c  |   4 +
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  23 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  13 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |   5 +-
 .../drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c  |  11 +
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |   4 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |   1 +
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |   4 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |   6 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 134 +++--
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |   3 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |   2 +-
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |  12 +-
 .../amd/display/dc/irq/dce120/irq_service_dce120.c |   2 +-
 .../amd/display/dc/irq/dce80/irq_service_dce80.c   |  10 +-
 .../amd/display/dc/irq/dcn10/irq_service_dcn10.c   |   5 +-
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   |   5 +-
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   |   5 +-
 .../amd/display/dc/irq/dcn30/irq_service_dcn30.c   |   5 +-
 .../amd/display/dc/irq/dcn302/irq_service_dcn302.c |   7 +-
 .../amd/display/dc/irq/dcn303/irq_service_dcn303.c |   5 +-
 .../amd/display/dc/irq/dcn31/irq_service_dcn31.c   |   7 +-
 .../amd/display/dc/irq/dcn314/irq_service_dcn314.c |   7 +-
 .../amd/display/dc/irq/dcn315/irq_service_dcn315.c |   7 +-
 .../amd/display/dc/irq/dcn32/irq_service_dcn32.c   |   7 +-
 .../amd/display/dc/irq/dcn35/irq_service_dcn35.c   |   7 +-
 .../amd/display/dc/irq/dcn351/irq_service_dcn351.c |   7 +-
 .../amd/display/dc/irq/dcn36/irq_service_dcn36.c   |   7 +-
 .../amd/display/dc/irq/dcn401/irq_service_dcn401.c |   7 +-
 .../amd/display/dc/irq/dcn42/irq_service_dcn42.c   |   7 +-
 .../amd/display/dc/link/accessories/link_dp_cts.c  |   2 +
 .../drm/amd/display/dc/link/hwss/link_hwss_dpia.c  |  22 +-
 .../amd/display/dc/link/hwss/link_hwss_hpo_dp.c    |   6 +
 .../hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   1 +
 .../amd/display/dc/link/hwss/link_hwss_virtual.c   |   6 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |  12 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   3 +-
 .../gpu/drm/amd/display/dc/link/link_validation.c  |   1 +
 .../display/dc/link/protocols/link_dp_training.c   |   2 +
 .../dc/link/protocols/link_dp_training_128b_132b.c |   1 +
 .../dc/link/protocols/link_dp_training_dpia.c      |   6 +
 .../drm/amd/display/dc/link/protocols/link_dpcd.c  |   1 +
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |   6 +-
 .../gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c   |   1 +
 .../gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c   |   1 +
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c |   4 +
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |   2 +
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c |   1 +
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |   1 +
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |   1 +
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |   1 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |   1 +
 .../display/dc/resource/dce100/dce100_resource.c   |   9 +-
 .../display/dc/resource/dce110/dce110_resource.c   |   6 +
 .../display/dc/resource/dce112/dce112_resource.c   |   7 +-
 .../display/dc/resource/dce120/dce120_resource.c   |   3 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |   7 +-
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |   5 +-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |  24 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |  33 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.h |   3 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |   5 +-
 .../display/dc/resource/dcn301/dcn301_resource.c   |   3 +-
 .../display/dc/resource/dcn302/dcn302_resource.c   |   3 +-
 .../display/dc/resource/dcn303/dcn303_resource.c   |   3 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |  16 +-
 .../display/dc/resource/dcn314/dcn314_resource.c   |   6 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |  10 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |   9 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |   2 +-
 .../dc/resource/dcn32/dcn32_resource_helpers.c     |   1 +
 .../display/dc/resource/dcn321/dcn321_resource.c   |   2 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |  15 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.h |   1 +
 .../display/dc/resource/dcn351/dcn351_resource.c   |  15 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |   6 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |  32 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |  34 +-
 .../dcn42/dcn42_soc_and_ip_translator.c            |   1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |  20 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c  |   1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  |  23 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  |  17 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c  |  18 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c |  22 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  |  32 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h  | 136 ++++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c    |   4 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   8 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   5 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |  15 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 123 ++++-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h    |   1 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c    |  83 ---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h    |   2 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |   2 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c    |  15 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |  14 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h       |   2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |   7 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |   5 +-
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  21 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  25 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  75 ---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |  36 --
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  60 ---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   5 +-
 303 files changed, 4153 insertions(+), 1892 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
