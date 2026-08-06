Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2096C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8BC710E3B6;
	Thu,  6 Aug 2026 21:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4g1njvJ4";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F12910E39F;
 Thu,  6 Aug 2026 21:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASE8aD642Pu3nrAPBNnShYngtE+YUqd++kWw1TQTYKefBdjdhtBwqt9qxQa0rD9ZjyC8i7zLDJ+D476+eU/LzfSRa6/0altGu6B2QO6DlR+r8rUp9Z8gvF4P4SCVgdXnNSZMdSfexp7hJur30iW9O68Kb21Nq9eEmBEmY4y5Ac9j4kT1k8Yir9/eQu0HTf/h23IBhtgF3d7tmbOL7uJVkDcsz71DKEtzxVko/UH2jLxh8XejOTMg8tQgyOVM/4387wp704uruCDITp08YAiNGB9Z2B0wKK9l9TSg+90mRvDNzDLKNWfOAA1GspYmAydt//nY56THPwSYIolqEe5vXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk8GrTcyRc1yjJFgrPzsFiy6bmXdBNEjueOZoNo72Sw=;
 b=vGWv6WTXiAGJfCqjwpUNPz35Xh8xamLCZHsVv9pvG+XuGiN/C3vgDsf5CNL7xBG7LVw0TT+FICJpMsQ8p5IUMlNte5J7sKeUJv0aTRjq2Zer1JYGY5Wi8FEaT9S3srBotucLuAEMNlDHSsLT6Sksgv/bnxIu7lEbNqusCXBW70KyM+Hv9zzubpUgw2I1kkKU40MiEJwMf/4pSHxSdz7F49HBCjHkMwSK1Uqzbi3XMzChYPy07Go0LFSz175VE7Y5WZ8xmcGOsF0vcLR8QWC1qpEG6NMN7guUywTwYzemLEJFA2PVsORwiAPFyxUlJZBgi0jbIcZXbu1skhFo5xLyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk8GrTcyRc1yjJFgrPzsFiy6bmXdBNEjueOZoNo72Sw=;
 b=4g1njvJ42/xhPotzjVnv/JH75O8jITBiLoGhw/lGOf8owZ+vrifY2qn4qJ671Is/FNsL/UUcjme0fAEoRnjd1dTqqt0qKwNSRSdoA8hCYmOWNbNHGwD4Xm4nsrdBd4XQZbjQK/CITM74hOMiQmZ0yjp9lN8kq4CbU9yFvNU0mUI=
Received: from MW4PR04CA0293.namprd04.prod.outlook.com (2603:10b6:303:89::28)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 21:31:29 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::99) by MW4PR04CA0293.outlook.office365.com
 (2603:10b6:303:89::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 21:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 21:31:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 16:31:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 16:31:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 16:31:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.3
Date: Thu, 6 Aug 2026 17:31:05 -0400
Message-ID: <20260806213106.994528-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 188a79de-b5f4-45c6-6cf8-08def40213c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|13003099007|3023799007|6133799003|56012099006|10086099003|10067099003|18092099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: NxktIWJ6zGrzyDjYWDRn8++iKr8c6mrxi13/Ua5kYFLK+jzXGiMCmJnpsB+KY2kFlAi72I+sS09VMyhrkgQ/pDP+wNz44U9W9MrMJ24C8hYkvSGN0DW+2UXBGUr7lR6Te8PXuRvqT7weON4s37+gMrI4LIY8ycHM3chH5PEDV60BPcuAE1OUznQmiQ1qEVH5RmoA7/EaORfNxj9tedOqX7tY+QsvCxPd48EfcnUG7M4D2+93MH5t1wUwzltog4+dI6vf+bDzfO2/s3uKc4hYxeUbS+yQhMPYUsjDRBL2gWApI39fvwYm4RW7uRzPw4AhARCXzI/RlSChUcCUUNp44kDAhHdSMEjcBzeSzzai38ZJsqH/forKJIFRi4pQlZy0MpnY3iF5jPItRLRdpmOMt9VYMUujx9X5RxWS7bk0E3vcjyjhkP4m3DuXV/8ZE1/aFFX7+gKKLtKr49mRDpgT9EfymtxeMW8T5yrZxNF3aGDiIZllLbO4Pbj6tj+dekWCSkp9/J+DJ4dIId9YIyBFtPVeYSgaB2BYnRUyUcCGISdb+LlpOTS91s6oo43apO2qWkJExWKJj9Iu82E6ukORrGTczdp/pGYBdOi09XjjoG0KFF0hjTXcdY5FMOv9d5QTtNvyHMjIcBh94TFgkhcYDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(13003099007)(3023799007)(6133799003)(56012099006)(10086099003)(10067099003)(18092099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RG4WzwdfN9aWM/sGrRNv1H0rPDyzHRf0VVRyyRxyZNNf8jOVgY3Vr0PLX5cnElD9pjPM+115dxKvkyYSoXyDOZ2zbuYYpT8CT8q9OwNkM7y1zRPHYpNzLzXAOcn+6S52pKpkNBKjVmph4LOsVlOPsep5KQiXquN1eRmR9SqlGz0e4qaZ+1QdZxIwdJVMJEI3TBXXEzEntzD/niuSuLhmt3EL+CD5oQDkgKjQEIjq/utNeMGBinzJKDGak8iPZHg6yMcVgqqnfvgvPSBbMy6ie2e6CY8wgUAT4dzQQHAWvsmXm+ZJ1fzcuuTQrltqUPpkl5kasf/Lg041tMGhTvde/zN0Ge9Fp1Zqk3mMel/SAjNy+ZI2rhG77qd11H14lrIeOWjSWchTkwcOSJzArdllpX1Zc26XLYbES5seApsLW3hWNiR5ZYg7X/+hNtn0gv1q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 21:31:29.0913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188a79de-b5f4-45c6-6cf8-08def40213c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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

One last update for 7.3.

The following changes since commit 9243cf4777fc780157602603caa52c285908f26a:

  drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12 (2026-07-29 17:56:28 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-08-06

for you to fetch changes up to daaeec235e46b45a0dbd4facfb275cc43022028d:

  drm/amdgpu: Fix typo in comment (2026-08-06 13:47:02 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-08-06:

amdgpu:
- JPEG queue reset fixes
- GC 12 fix
- GMC 12.1 fixes
- Lockdep false positive fix
- Userq fixes
- Bounds checking fixes
- Devcoredump fixes
- DCN 2.0.1 fix
- Aperture mapping fix
- DC avmute fix
- DC self refresh fix
- RAS updates
- SMU 15 updates
- SMU PPT updates
- SMU 14 fixes
- Initial DCN 6.0.0 support
- GC 6 soft reset rework
- Display bounds checking fixes
- FRL fixes
- VRR fixes
- More display KUnit tests
- Refactor DC stream validation
- DCN 3.5.1 fixes
- DCN 3.2 fixes
- DC CRC fixes
- MES 12.0 fixes

amdkfd:
- SVM fixes
- MES updates

radeon:
- Performance regression fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/gmc12.1: implement tlb inv semaphore
      drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush

Alex Hung (2):
      drm/amd/display: Fix wb_info leak and NULL deref in writeback
      drm/amd/display: Fix more KUnit connector use-after-free bugs

Alvin Lee (1):
      drm/amd/display: Update BW bounding box unconditionally for DCN6

Asad Kamal (2):
      Revert "drm/amdgpu: fix aperture mapping leak"
      drm/amdgpu: fix aperture iounmap skipped on device removal

Aurabindo Pillai (3):
      drm/amd: Add DCN6 register headers
      drm/amd/display: Add new sources for DCN6
      drm/amd/display: Enable DCN6 sources compilation

Bhawanpreet Lakha (12):
      drm/amd/display: Add KUnit tests for more crtc functions
      drm/amd/display: Add vblank handling tests for crtc
      drm/amd/display: Add idle worker tests for crtc
      drm/amd/display: Add active plane count tests for crtc
      drm/amd/display: Add KUnit test for crtc vblank event completion
      drm/amd/display: Add KUnit tests for crtc set_vupdate_irq
      drm/amd/display: Add KUnit tests for crtc set_static_screen_optimze
      drm/amd/display: Add KUnit tests for crtc set_vblank
      drm/amd/display: Cover crtc set_vblank workqueue branch
      drm/amd/display: Cover crtc vblank IPS self-refresh restore
      drm/amd/display: Cover crtc vblank restore replay-supported path
      drm/amd/display: Cover crtc destroy_state stream release

Candice Li (2):
      drm/amdgpu: fix userq VA validation for sub-page buffers
      drm/amdgpu: reject oversized IBs with per-ring packet limits

Charlene Liu (1):
      drm/amd/display: Ensure dtbclk is enabled

David Weber (1):
      drm/amd/display: allow self-refresh exit while entry is blocked

Fangzhi Zuo (1):
      drm/amd/display: Gate HDMI FRL status polling on active FRL link rate

Harry VanZyllDeJong (1):
      drm/amd/display: Update VRR info packet to support 12-bit refresh rates

Harry Wentland (2):
      drm/amd/display: Resize MST HDCP per-connector arrays to 32
      drm/amd/display: Bounds-check connector->index in dm_dp_mst_get_modes

Hawking Zhang (1):
      drm/amdgpu: remove obsolete gmc ras helpers

Iswara Nagulendran (1):
      drm/amd/display: Fix ABM over VABC

Ivan Lipski (2):
      drm/amd/display: Refactor stream validation
      drm/amd/display: Unify force_yuv debugfs into force_yuv_pixel_format

Jesse Zhang (10):
      drm/amdgpu: fix JPEG v5.0.0 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v4.0.5 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v5.3.0 queue reset failure in DPG mode
      drm/amdgpu: track faulted gfx user-queue slots
      drm/amdgpu/gfx11: add priv-fault user-queue recovery worker
      drm/amdgpu/gfx12: add priv-fault user-queue recovery worker
      drm/amdgpu: recover user queues in the shared priv-fault helper
      drm/amdgpu/userq: mark a queue unmapped after a per-queue reset
      drm/amdgpu/userq: serialize queue map against GPU reset
      drm/amdgpu/mes12: fix dropped dispatches under queue oversubscription

Karthi Kandasamy (1):
      drm/amd/display: Fix seamless mode switch not triggering for HDR to SDR transition

Kenji Takahashi (1):
      drm/amdgpu: Fix typo in comment

Lijo Lazar (3):
      drm/amdgpu: Prefer default discovery offset
      drm/amdgpu: Use virtual alloc during coredump
      drm/amdgpu: Allocate coredump ring buffers per ring

Matthew Stewart (1):
      drm/amd/display: Add missing DCN42B register defines

Philip Yang (2):
      drm/amdkfd: Add helper svm_range_update_checkpoint_timestamp
      drm/amdkfd: Unmap svm range from GPU set to no-access

Prike Liang (4):
      drm/amdgpu/mes: refactor the amdgpu_mes_alloc/free_proc|gang()
      drm/amdgpu/mes: tear down the rs64mem bitmap in sw_fini
      drm/amdkfd: enable rs64mem for kfd queue
      drm/amdgpu/mes11: enable MES process/gang load from MES local mem

Priya Hosur (4):
      drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting via VCLK level index
      drm/amd/pm: add IP_VERSION(11,5,1) to vclk/dclk DPM sysfs whitelists
      drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in DPM frequency queries
      drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM level marking

Qiang Yu (1):
      drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12

Rafal Ostrowski (1):
      drm/amd/display: Migrate color manager HW and fix MCM blend LUT issues

Ray Wu (1):
      drm/amd/display: Check for tg ops in dce110_set_avmute

Relja Vojvodic (2):
      drm/amd/display: switch max FFE level cap based on FRL link rate
      drm/amd/display: Add FFE level defaults

Roman Li (1):
      drm/amd/display: Remove duplicate in tests/Makefile

Shubhankar Milind Sardeshpande (2):
      drm/amd/pm/smu15: add metrics table header for SMU v15.0.0
      drm/amd/pm/smu15: switch SMU v15.0.0 to DRAM-based accumulator metrics

Sung-huai Wang (1):
      drm/amd/display: Increase fclk change latency on dcn351

Taimur Hassan (2):
      drm/amd/display: Add missing DMUB CACP and PR definitions
      drm/amd/display: Promote DC to 3.2.392

Tao Zhou (3):
      drm/amd/ras: move some umc v12 specific functions to ras_umc.c
      drm/amd/ras: add get_die_id for uniras umc v12
      drm/amd/ras: Handle the lack of mca address case for uniras

Timur Kristóf (12):
      drm/amdgpu/gfx6: Fixup emit_cntxcntl()
      drm/amdgpu/gfx6: Fixup emitting SWITCH_BUFFER packets
      drm/amdgpu/gfx6: Use PFP on the compute queues too
      drm/amdgpu/gfx6: Initialize compute rings before CP start
      drm/amdgpu/gfx6: Clean up rings during reset
      drm/amdgpu/gfx6: Execute CLEAR_STATE when initializing compute rings
      drm/amdgpu/gfx6: Adjust how harvested TCCs are set up
      drm/amdgpu/gfx6: Use COND_EXEC
      drm/amdgpu/gfx6: Add IP block soft reset implementation
      drm/amdgpu/gfx6: Enable IP block soft reset as a GPU recovery method
      drm/amd/display: Set native cursor mode for disabled CRTCs again
      drm/amd/display: Fix crash in hwss_set_output_transfer_func()

Travis K. Bangs (1):
      drm/amd: Disable DP audio spread spectrum for Cyan Skillfish

Vitaly Prosyak (1):
      drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init

Wang Jiang (1):
      drm/radeon: restore hardware polling in fence_is_signaled to fix performance regression

Wayne Lin (3):
      drm/amd/display: Add missing OTG_CRC1_SELECT mask for DCN3.2
      drm/amd/display: Fix CRC engine 1 enable/disable on DCN3.1.2+
      drm/amd/display: Configure all CRC engines in pipe CRC source path

Xiang Liu (1):
      drm/amd/ras: track debug mode for query mode

Yang Wang (5):
      drm/amd/pm: derive stable PPT limits from PPTable
      drm/amd/pm: refactor PPT limits by controller and power source
      drm/amd/pm: account for OD percentage in effective PPT limits
      drm/amd/pm: refactor user PPT policy save and restore
      drm/amd/pm: restore user PPT limits after GPU reset

YiPeng Chai (2):
      drm/amd/ras: rename rascore directory to core
      drm/amd/ras: rename core ras_* files and update include guards

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |    54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    10 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        |    21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |    32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |    36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |     3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |    39 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    45 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   374 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |     4 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |     4 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |     4 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |    48 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |     5 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |    21 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |    21 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |    21 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |    37 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |    10 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |     3 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |     5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |     5 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |     7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   191 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |     7 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    36 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |     2 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h    |     2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   321 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |     8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    13 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    31 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |     9 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |     9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    57 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |    10 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |     1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |    10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |    10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |     6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |     3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |     9 +-
 .../gpu/drm/amd/display/amdgpu_dm/tests/Makefile   |     1 -
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   163 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  1436 +
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |    29 +
 .../amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h |     3 +
 .../amd/display/dc/bios/command_table_helper2.c    |     1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |     9 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    15 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |    28 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h  |   389 +
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |  1673 +
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h   |   150 +
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c       |   369 +
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h       |    35 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    76 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   431 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    47 +
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |    12 +
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    27 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    41 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |    44 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |    23 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |     2 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    53 +-
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |    32 +-
 drivers/gpu/drm/amd/display/dc/dc_state_priv.h     |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |     5 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    13 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile       |     8 +
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h |    10 +
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c |   187 +
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h |   182 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    28 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |     9 +
 drivers/gpu/drm/amd/display/dc/dio/Makefile        |     8 +
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.h  |    16 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c        |    15 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h        |    10 +
 .../display/dc/dio/dcn60/dcn60_dio_link_encoder.c  |   373 +
 .../display/dc/dio/dcn60/dcn60_dio_link_encoder.h  |    43 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c        |   538 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.h        |   181 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |     8 +
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |     4 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |    25 +
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |    57 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |   129 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn5_soc_bb.h  |    36 +
 .../dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h  |   229 +
 .../inc/bounding_boxes/utm_qos_model_dchub_v1.h    |   109 +
 .../inc/bounding_boxes/utm_qos_model_dchub_v2.h    |   122 +
 .../inc/bounding_boxes/utm_qos_model_dchub_v3.h    |    53 +
 .../dml21/inc/bounding_boxes/utm_qos_model_types.h |    51 +
 .../amd/display/dc/dml2_0/dml21/inc/dml_dmub_cmd.h |   502 +
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |    10 +
 .../dml2_0/dml21/inc/dml_top_soc_parameter_types.h |     2 +
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |    45 +
 .../dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c   |   152 +
 .../dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.h   |     9 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c   |    38 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_factory.h   |     9 +
 .../dml2_core/dml2_core_calcs_dsc_shared_types.h   |    32 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |     1 +
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |  5893 ++
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.h     |   426 +
 .../dml2_core/dml2_core_dcn5_calcs_display_pipe.c  |  1029 +
 .../dml2_core/dml2_core_dcn5_calcs_display_pipe.h  |   151 +
 .../dml2_core/dml2_core_dcn5_calcs_dsc_latency.c   |   501 +
 .../dml2_core/dml2_core_dcn5_calcs_dsc_latency.h   |    23 +
 .../dml2_core/dml2_core_dcn5_funcs_initialize.c    |    78 +
 .../dml2_core/dml2_core_dcn5_funcs_initialize.h    |    12 +
 .../dml2_core_dcn5_funcs_mode_programming.c        |  1791 +
 .../dml2_core_dcn5_funcs_mode_programming.h        |    11 +
 .../dml2_core/dml2_core_dcn5_funcs_mode_support.c  |  2957 +
 .../dml2_core/dml2_core_dcn5_funcs_mode_support.h  |    11 +
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs.c     |    11 +
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs.h     |     8 +
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c     |  1951 +
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.h     |   101 +
 .../dml2_core/dml2_core_dcn6_funcs_initialize.c    |   165 +
 .../dml2_core/dml2_core_dcn6_funcs_initialize.h    |    12 +
 .../dml2_core_dcn6_funcs_mode_programming.c        |  1389 +
 .../dml2_core_dcn6_funcs_mode_programming.h        |    11 +
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.c  |  4277 ++
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.h  |    11 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |    25 +
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |   160 +
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |     1 -
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c |   449 +
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.h |    19 +
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |    12 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |     5 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |    57 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.c   |   522 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h   |    21 +
 .../src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.c  |  2228 +
 .../src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.h  |    97 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c   |   506 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h   |    22 +
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c  |  1789 +
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.h  |    17 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |    34 +
 .../alternate_pstate_shared_lib.c                  |  1078 +
 .../alternate_pstate_shared_lib.h                  |   109 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c       |     7 +
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c    |   394 +
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.h    |     9 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c     |   144 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.h     |    11 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c     |   405 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.h     |    12 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c  |    29 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.h  |    11 +
 .../dml21/src/inc/dml2_internal_shared_types.h     |   485 +
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h   |     8 +
 drivers/gpu/drm/amd/display/dc/dpp/Makefile        |    17 +
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h |    41 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |    26 +-
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |     7 +-
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.h   |     6 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c   |   391 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h   |    86 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |   346 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h   |   525 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c  |   315 +
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |     7 +
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c   |   447 +
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h   |   248 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |    10 +
 .../amd/display/dc/gpio/dcn60/hw_factory_dcn60.c   |   228 +
 .../amd/display/dc/gpio/dcn60/hw_factory_dcn60.h   |    11 +
 .../amd/display/dc/gpio/dcn60/hw_translate_dcn60.c |   168 +
 .../amd/display/dc/gpio/dcn60/hw_translate_dcn60.h |    13 +
 drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h     |    15 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |   302 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.h       |    28 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     4 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     4 +
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c     |     9 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile        |     8 +
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h     |    47 -
 .../dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.c      |   114 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.h      |    18 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c    |   358 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.h    |    32 +
 drivers/gpu/drm/amd/display/dc/hubbub/Makefile     |     8 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h |   108 +
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |  1816 +
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h |   207 +
 drivers/gpu/drm/amd/display/dc/hubp/Makefile       |    16 +
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h |    29 +
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |   201 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |    23 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |    78 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |    10 +-
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c |   532 +
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h |    48 +
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c |   472 +
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h |   272 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile       |    16 +
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h    |     9 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |    26 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |     3 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |     3 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |     3 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |    21 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |     5 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |     8 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   483 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |     7 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |     1 -
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   488 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |     6 -
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |     2 -
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |   759 +
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.h    |    32 +
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |  1164 +
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h    |    32 +
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |   181 +
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.h |    12 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |    19 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |     5 -
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |     1 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |    22 +
 .../drm/amd/display/dc/inc/hw/cursor_reg_cache.h   |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |     7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    35 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |    81 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |     1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |     2 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |     9 +
 .../amd/display/dc/irq/dcn60/irq_service_dcn60.c   |   417 +
 .../amd/display/dc/irq/dcn60/irq_service_dcn60.h   |    12 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |    29 +
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |     5 +
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |     8 +
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |    23 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile        |     8 +
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |   177 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |    25 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   |   405 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h   |    55 +-
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c   |   330 +
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h   |   472 +
 drivers/gpu/drm/amd/display/dc/opp/Makefile        |     8 +
 .../gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.c   |    25 +
 .../gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.h   |    64 +
 drivers/gpu/drm/amd/display/dc/optc/Makefile       |     9 +
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c |    36 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h |     3 +-
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h |     4 +
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.h   |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h |     2 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |    26 +-
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.h   |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c |     9 +-
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |     4 +
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c |   107 +
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h |   178 +
 drivers/gpu/drm/amd/display/dc/resource/Makefile   |    10 +
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |     1 +
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |     1 +
 .../display/dc/resource/dcn201/dcn201_resource.c   |     1 +
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |     1 +
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |     2 +
 .../display/dc/resource/dcn301/dcn301_resource.c   |     1 +
 .../display/dc/resource/dcn302/dcn302_resource.c   |     2 +
 .../display/dc/resource/dcn303/dcn303_resource.c   |     2 +
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |     1 +
 .../display/dc/resource/dcn314/dcn314_resource.c   |     2 +
 .../display/dc/resource/dcn315/dcn315_resource.c   |     6 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |     5 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |     2 +
 .../display/dc/resource/dcn321/dcn321_resource.c   |     2 +
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |     2 +
 .../display/dc/resource/dcn351/dcn351_resource.c   |     2 +
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |     2 +
 .../display/dc/resource/dcn401/dcn401_resource.c   |    34 +-
 .../display/dc/resource/dcn401/dcn401_resource.h   |     4 +
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |     3 +
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |    20 +-
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |  2377 +
 .../amd/display/dc/resource/dcn60/dcn60_resource.h |   676 +
 .../amd/display/dc/soc_and_ip_translator/Makefile  |     3 +
 .../dcn60/dcn60_soc_and_ip_translator.c            |   117 +
 .../dcn60/dcn60_soc_and_ip_translator.h            |    16 +
 .../soc_and_ip_translator/soc_and_ip_translator.c  |     4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |     5 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   229 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |     1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c  |   732 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h  |   303 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |    52 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |    18 +
 drivers/gpu/drm/amd/display/include/dal_types.h    |     1 +
 .../drm/amd/display/modules/freesync/freesync.c    |     8 +-
 .../gpu/drm/amd/display/modules/power/power_abm.c  |   215 +-
 .../drm/amd/display/modules/power/power_helpers.h  |     9 +
 .../gpu/drm/amd/display/modules/power/power_psr.c  |     7 +
 .../drm/amd/display/modules/power/power_replay.c   |     7 +
 .../amd/include/asic_reg/dcn/dcn_6_0_0_offset.h    | 15799 +++++
 .../amd/include/asic_reg/dcn/dcn_6_0_0_sh_mask.h   | 58556 +++++++++++++++++++
 .../amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h  |    47 +
 .../amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h |    55 +
 .../drm/amd/include/asic_reg/gca/gfx_6_0_sh_mask.h |    32 +-
 .../include/asic_reg/mmhub/mmhub_5_0_1_offset.h    |    17 +
 .../include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h   |    17 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |     2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |     8 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   222 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |    63 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h |   230 +
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h   |     5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |     3 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |    15 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |    11 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |    11 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |    11 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |    65 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |    88 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   116 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |    23 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |   118 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |    89 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |    23 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   123 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   124 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   123 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |    23 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |   105 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   123 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |    23 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   312 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h   |    13 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |   122 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h        |     3 +-
 drivers/gpu/drm/amd/ras/Makefile                   |     4 +-
 drivers/gpu/drm/amd/ras/{rascore => core}/Makefile |    16 +-
 .../drm/amd/ras/{rascore/ras_aca.c => core/aca.c}  |     4 +-
 .../drm/amd/ras/{rascore/ras_aca.h => core/aca.h}  |     4 +-
 .../{rascore/ras_aca_v1_0.c => core/aca_v1_0.c}    |     6 +-
 .../{rascore/ras_aca_v1_0.h => core/aca_v1_0.h}    |     4 +-
 .../drm/amd/ras/{rascore/ras_cmd.c => core/cmd.c}  |     2 +-
 .../drm/amd/ras/{rascore/ras_cmd.h => core/cmd.h}  |     8 +-
 .../amd/ras/{rascore/ras_core.c => core/core.c}    |     2 +-
 .../ras_core_status.h => core/core_status.h}       |     4 +-
 .../ras/{rascore/ras_eeprom.c => core/eeprom.c}    |     2 +-
 .../ras/{rascore/ras_eeprom.h => core/eeprom.h}    |     4 +-
 .../{rascore/ras_eeprom_fw.c => core/eeprom_fw.c}  |     0
 .../{rascore/ras_eeprom_fw.h => core/eeprom_fw.h}  |     4 +-
 .../{rascore/ras_log_ring.c => core/log_ring.c}    |     4 +-
 .../{rascore/ras_log_ring.h => core/log_ring.h}    |     6 +-
 drivers/gpu/drm/amd/ras/{rascore => core}/ras.h    |    12 +-
 .../gpu/drm/amd/ras/{rascore => core}/ras_cper.c   |     4 +-
 .../gpu/drm/amd/ras/{rascore => core}/ras_cper.h   |     0
 .../gpu/drm/amd/ras/{rascore => core}/ras_gfx.c    |     2 +-
 .../gpu/drm/amd/ras/{rascore => core}/ras_gfx.h    |     0
 .../drm/amd/ras/{rascore => core}/ras_gfx_v9_0.c   |     2 +-
 .../drm/amd/ras/{rascore => core}/ras_gfx_v9_0.h   |     0
 .../gpu/drm/amd/ras/{rascore => core}/ras_mp1.c    |     0
 .../gpu/drm/amd/ras/{rascore => core}/ras_mp1.h    |     0
 .../drm/amd/ras/{rascore => core}/ras_mp1_v13_0.c  |     2 +-
 .../drm/amd/ras/{rascore => core}/ras_mp1_v13_0.h  |     0
 .../gpu/drm/amd/ras/{rascore => core}/ras_nbio.c   |     0
 .../gpu/drm/amd/ras/{rascore => core}/ras_nbio.h   |     0
 .../drm/amd/ras/{rascore => core}/ras_nbio_v7_9.c  |     0
 .../drm/amd/ras/{rascore => core}/ras_nbio_v7_9.h  |     0
 .../drm/amd/ras/{rascore => core}/ras_process.c    |     0
 .../drm/amd/ras/{rascore => core}/ras_process.h    |     0
 .../gpu/drm/amd/ras/{rascore => core}/ras_psp.c    |     2 +-
 .../gpu/drm/amd/ras/{rascore => core}/ras_psp.h    |     2 +-
 .../drm/amd/ras/{rascore => core}/ras_psp_v13_0.c  |     0
 .../drm/amd/ras/{rascore => core}/ras_psp_v13_0.h  |     0
 .../gpu/drm/amd/ras/{rascore => core}/ras_umc.c    |   183 +-
 .../gpu/drm/amd/ras/{rascore => core}/ras_umc.h    |    24 +-
 .../drm/amd/ras/{rascore => core}/ras_umc_v12_0.c  |   151 +-
 .../drm/amd/ras/{rascore => core}/ras_umc_v12_0.h  |     3 -
 .../amd/ras/{rascore/ras_ta_if.h => core/ta_if.h}  |     4 +-
 .../drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c    |     2 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    17 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h   |     2 +
 drivers/gpu/drm/radeon/radeon_fence.c              |     7 +
 399 files changed, 132000 insertions(+), 3167 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn5_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v1.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_dmub_cmd.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_calcs_dsc_shared_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_initialize.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_initialize.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_factory_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_factory_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_translate_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_translate_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn60/irq_service_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn60/irq_service_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h
 rename drivers/gpu/drm/amd/ras/{rascore => core}/Makefile (86%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_aca.c => core/aca.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_aca.h => core/aca.h} (98%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_aca_v1_0.c => core/aca_v1_0.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_aca_v1_0.h => core/aca_v1_0.h} (98%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_cmd.c => core/cmd.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_cmd.h => core/cmd.h} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_core.c => core/core.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_core_status.h => core/core_status.h} (96%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_eeprom.c => core/eeprom.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_eeprom.h => core/eeprom.h} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_eeprom_fw.c => core/eeprom_fw.c} (100%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_eeprom_fw.h => core/eeprom_fw.h} (98%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_log_ring.c => core/log_ring.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_log_ring.h => core/log_ring.h} (97%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras.h (98%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_cper.c (99%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_cper.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx.c (98%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx_v9_0.c (99%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx_v9_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1_v13_0.c (99%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1_v13_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio_v7_9.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio_v7_9.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_process.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_process.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp.c (99%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp.h (99%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp_v13_0.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp_v13_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc.c (81%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc.h (90%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc_v12_0.c (83%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc_v12_0.h (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_ta_if.h => core/ta_if.h} (99%)
