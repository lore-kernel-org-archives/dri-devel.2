Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1612CCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 23:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6740910F0C8;
	Wed, 13 May 2026 23:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TsEMNJiR";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D87410E273;
 Wed, 13 May 2026 23:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WquS3LUx8imcEK12L0nKMr7FkvnzZIOt7Br+8RiCRyR2Hff51JE2GpWXOGKNW3gQPRZik3eL1Aczplp8E1l8nCoYOkrDbIW+3fENzC99rY0fVk84BCccxkqf8UzIAw6zMEh42faoL7NCbW+ZH9TMR2qJuJdqxl5ppOb8dVGVCT97SZzMqnz6BXRx8PbIuK1jZTK33/UNoJEYK26px/GrogxSMjiGqL/p/xV1gSTRGJr4mKlbTpq9SEBQY+sJ7AXfChJqq1aYRHKw13Q7E/yIPiliMFhTWeBqgg278r03tGUYeHeTSRR70rf8GZsnHpQ7n7sSOJSW8MyP4RtXwySRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbPnc1Fnh6wW/mPeWNw1Ns1ix7EEK5TufsRRhmepQls=;
 b=zCEcvSIC4DkgSzOZa4cY4YuAVb2jCg854mU/4IfXE5jEAq9J0SnGIpVCAz0tDu6mxYce4ClfyNbojAnHdKvz6zjAoNyHfngmBavMXOEFxXht5SAy80w27cK3GzKiVsosyvSiiPeZVgYFrcbyXmKA/eBCbHUrd2WQhLS7mfPh/5Wf63948MKtzC+Q1DgL/dOKkiuvTnCELLnS14Dl+akv4iTCD/ZrYY0OPYG/z2pdlSpjYlKMo5VmvV6U4Idwrk1AQz9vh2nZFp4tpfgmGdf7nlK9moY8FkP7CyIJwv+x8eVOWJlccM8BytNLzuz/CF6AgX2Aq2S7TVp/rD4wTPuQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbPnc1Fnh6wW/mPeWNw1Ns1ix7EEK5TufsRRhmepQls=;
 b=TsEMNJiRCcyHPnaiv+qwrgvw4HKdqFwauqM/9QNbRHrh6Kxyr2WUhl3+r51g8CAgEe09SAcEEgCUQyffmvFTFWTpzqTTBPFexij3quZh9THUbtJ8O0ni4Bj9rPk1uWRBQp3paQiAO+Pw3XoCfkgOrsIIn/SBaL9jzcnM8ExouCw=
Received: from CH2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:610:5b::38)
 by CHXPR12MB999221.namprd12.prod.outlook.com (2603:10b6:610:2fa::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 13 May
 2026 23:29:27 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::dc) by CH2PR07CA0064.outlook.office365.com
 (2603:10b6:610:5b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 23:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 23:29:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 18:29:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 18:29:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 18:29:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.2
Date: Wed, 13 May 2026 19:29:09 -0400
Message-ID: <20260513232911.41274-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CHXPR12MB999221:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a12bf21-970d-4eda-81d5-08deb1477981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|13003099007|11063799003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: l5ooOLFTRSVn91ZMMMBXh1/TRUXRIwzDli68o/woUJ3MyMmzNxWQ/aX6TnnDQiElxpDynjrCZkmyKzicaHA0rmAkDvkZNyoERLPAuXv8gkUlTLUnMZzdpBNqxuXGTwGUTnNE0+c4vxi9yfZSEBi2kVZBykFHmSRDhyMeaFYQx41BY/EV5Q8ZVANApByEHvG3+E7qcEPYT61gl1eQit9/YWMTfk4Dty53vQQx42QpkDd3GL/V0k2VyGZmrH5WLNr+FqdYfGg9CYYqcYpX4LmROrCWY2P724oo+7zrWenNec+6EwbfecE4VRyB/ZTGVSu74QGuKsYPo8+7CqHPwrffqXEXVxWA92PtuERUXi/gtgNb2rg7RSR/2CbJiOxtZub4MXz91tZn5x+6lIwgesxA0jZsgQRXz1NjHawzxZE0QuWBliq8GK7OPe6AXFgQyxpjtHR6K/kk9eF5RSQ66k0Ij8ON15yMcRfkDdgYNJtr+Cc+XMyY6dBr8BO2IHzXvOjqlS0d8zQGyzOavLUymk+ve6o94Vt5OCwfa2F/fQvECVSz/Ei1BGGkOUAuHIcze04EvDyxj4sxsecwH65AOFM7qg7/RIHOUaO82IdVKXFfRe2gFQHW447/3r0f1O0xElGHTtI1HXQG1AYvMPkMFa8zPgdgTOkG/HMsngTxd5y0j9O4mdiK5Ol5rL4/NSaSWw8J
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(13003099007)(11063799003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yfr0+p4MPlRFIGSEPCRBIZXQEqMFZ7JggBB7ob3AybKBo81kuOr7VsE/yctJyUWwMg5HLt4DvWiuVjAaYqAudNDSOhFKeoDihovwSfuzLM/en5XJSXtF7+fcP694+tEuHfEc6O6WW+uk7xqOsj7OA/UbMpFqR/A4FCL4brDmlbSvipK+RET3h4kBHcSULPFtYrIwR5DyF5zNFEDba28UhB3m9Aa/KzBgCB/sEaEuKtBtSplJhuvK2vq+ZijkeaZCmR1JxhkL/WpPLVpUUzcbsHT7d4aiefkh4YdCK4opiqifSRPFSNrkNiXwYXBMTto/i9z/BBR4RR0gsFlw1YkawyP3H7kXdnu8Ex7xvp4w1uO1g5FUIOW4/vX6rgWnUANN6bOwnkON2PomS+UxFKT0Yu4PihwoQ5ONQ6ZfRwXG38jy4lVNaoacAd47HTwnhhW9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 23:29:27.1973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a12bf21-970d-4eda-81d5-08deb1477981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999221
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

More new stuff for 7.2.

The following changes since commit f96538285cfdbb3acf5e3356e0bb88c38815790b:

  Merge tag 'drm-misc-next-2026-05-07' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next (2026-05-08 14:16:04 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.2-2026-05-13

for you to fetch changes up to d00df389371346d6ac5739d8692405d9d8b11041:

  drm/amd/pm: update dpm clock pm attributes for aldebaran (gc 9.4.2) (2026-05-11 16:16:04 -0400)

----------------------------------------------------------------
amd-drm-next-7.2-2026-05-13:

amdgpu:
- Userq fixes
- DCN 3.2 fix
- RAS fixes
- GC 12 fixes
- Add PTL support for profiler
- SMU multi-msg helpers
- OLED fix
- Misc cleanups
- DC aux transfer refactor
- Introduce dc_plane_cm and migrate surface update color path
- IPS fixes
- DCN 4.2 updates
- SR-IOV fixes
- Add FRL registers for HDMI 2.1
- NBIO 7.11.4 updates
- VPE 2.0 support
- Aldebaran SMU update

amdkfd:
- Add profiler API

UAPI:
- Add profiler IOCTL
  Userspace: https://github.com/ROCm/rocm-systems/commit/40abc95a6463a61bb318a67efd6d9cc3e5ee8839

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: plumb timedout fence through to force completion
      drm/amdgpu: simplify VCN reset helper

Benjamin Welton (1):
      amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel driver changes

Caden Chien (4):
      drm/amdgpu/nbio: remove doorbell entry5 for vcn on 7.11.4
      drm/amdgpu/nbio: add doorbell range init for vpe on 7.11.4
      drm/amdgpu/vpe: add new vpe v2.0.0 register offset and sh/mask
      drm/amdgpu/vpe: add vpe v2.0.0 support

Charlene Liu (2):
      drm/amd/display: only call pmfw if smu present flags true
      drm/amd/display: enable ODM 2:1 on single eDP based on pixel clock

Christian König (4):
      drm/amdgpu: remove deadlocks from amdgpu_userq_pre_reset
      drm/amdgpu: rework amdgpu_userq_signal_ioctl v3
      drm/amdgpu: remove almost all calls to amdgpu_userq_detect_and_reset_queues
      drm/amdgpu: fix userq hang detection and reset

ChunTao Tso (1):
      drm/amd/display: Fix refresh rate round up case

Clay King (1):
      drm/amd/display: Fix warnings

Gaghik Khachatrian (5):
      drm/amd/display: Fix signed/unsigned comparison mismatches
      drm/amd/display: Fix compiler warnings in dml2
      drm/amd/display: Fix multiple compiler warnings
      drm/amd/display: always-true lower-bound assert
      drm/amd/display: Fix enum decl warnings

Ivan Lipski (2):
      drm/amd/display: Add additional IPS entry/exit for PSR/Replay
      drm/amd/display: Enable IPS on DCN42

Jesse Zhang (1):
      drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP header on GFX12

Leo Chen (1):
      drm/amd/display: Revert "Enable HUBP/OPTC/DPP power gating"

Lohita Mudimela (1):
      drm/amd/display: Separate ABM functions into dedicated power_abm.c file

Matthew Stewart (1):
      drm/amd/display: Refactor dc_link_aux_transfer_raw

Mikhail Gavrilov (1):
      drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED

Ovidiu Bunea (1):
      drm/amd/display: Revert "Unify fast update classification paths"

Perry Yuan (21):
      drm/amdgpu: add new performance monitor PSP interfaces
      drm/amdgpu: add psp interfaces for peak tops limiter driver
      drm/amdgpu: add PTL enable/query gfx control support for GC 9.4.4
      drm/amdkfd: add kgd control interface for ptl
      Documentation/amdgpu: Add documentation for Peak Tops Limiter (PTL) sysfs interface
      drm/amdgpu: add sysfs for Peak Tops Limiter (PTL)
      drm/amdkfd: Add PTL control IOCTL Option and unify refcount logic
      drm/amdkfd: suspend scheduler during PTL re-enabling
      drm/amdgpu: Track PTL disable requests by source
      drm/amdgpu: add amdgpu.ptl module parameter for PTL control
      drm/amdgpu: add new data types F8 and Vector for PTL
      drm/amdgpu: Wait for GFX idle before PTL state transition
      drm/amdgpu: check PSP response status in psp_ptl_invoke
      drm/amdgpu: add SPI idle check for GC 9.4.4 in gfx_v9_4_3_is_idle()
      drm/amdgpu: Move KFD sched stop/start into PTL control path
      drm/amdgpu: create PTL sysfs after XGMI reset-on-init restore
      drm/amdkfd: fix unhalt_cpsch warning during module unload
      drm/amdgpu: only set PTL SYSFS disable bit when PTL is disabled
      drm/amdgpu/gfx9.4.3: skip PTL disable during GPU reset
      drm/amdgpu: fix ptl state isssue after GPU reset or suspend
      drm/amdkfd: bump KFD ioctl minor version to 1.23

Rafal Ostrowski (1):
      drm/amd/display: Introduce dc_plane_cm and migrate surface update color path

Ray Wu (1):
      drm/amd/display: Fix white screen on boot with OLED panel

Rodrigo Siqueira (9):
      drm/amd/display: Add FRL registers for DCN30
      drm/amd/display: Add required FRL registers for DCN31
      drm/amd/display: Add FRL registers for DCN321
      drm/amd/display: Introduce FRL registers for DCN32
      drm/amd/display: Add the necessary FRL registers for DCN314
      drm/amd/display: Add FRL register for DCN302
      drm/amd/display: Add FRL register for DCN303
      drm/amd/display: Add FRL registers for DCN315
      drm/amd/display: Add FRL registers for DCN316

Taimur Hassan (2):
      drm/amd/display: [FW Promotion] Release 0.1.59.0
      drm/amd/display: Promote DC to 3.2.382

Tom Chung (1):
      drm/amd/display: Fix CRC open failure during active rendering

Xiang Liu (1):
      drm/amd/ras: Fix CPER ring debugfs read overflow

Yang Wang (6):
      drm/amd/pm: add SMU multi-msgs helpers
      drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0
      drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_0
      drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_8
      drm/amdgpu: fix error return code in mes_v12_1_map_test_bo
      drm/amd/pm: update dpm clock pm attributes for aldebaran (gc 9.4.2)

chong li (1):
      drm/amdgpu: Sync the pf2vf structure between guest and host

 Documentation/gpu/amdgpu/index.rst                 |    1 +
 Documentation/gpu/amdgpu/ptl.rst                   |   94 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   14 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c    |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  401 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  131 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  243 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |   25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |   13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    7 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |   84 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |   58 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   17 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |  350 +++
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.h              |   29 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  208 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   20 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   28 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |    8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   11 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   15 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   15 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   22 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   77 +
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |    6 +-
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h    |    2 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |    8 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c       |    4 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h       |    2 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |    2 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    2 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h |    4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c     |    4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h     |    2 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |   11 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  260 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   12 -
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   18 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |    6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c |    4 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  105 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    7 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |   20 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |    4 +
 .../drm/amd/display/dc/dcn21/dcn21_link_encoder.c  |    2 +-
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |    1 +
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |    6 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |   36 +-
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |    4 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |  342 +--
 .../gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c |    2 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |  408 +--
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |   10 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |  400 +--
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   15 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |    8 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h        |    8 +-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |   10 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |   10 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |   12 +-
 .../drm/amd/display/dc/dml2_0/display_mode_core.c  |    6 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |   33 +
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |    2 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |    2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |    2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |    2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |    8 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c   |    8 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |   10 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |    4 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |    2 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   10 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    8 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |    2 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    2 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |    2 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h      |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |    4 +-
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    8 +-
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/reg_helper.h    |   72 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |    2 +-
 .../gpu/drm/amd/display/dc/link/link_detection.h   |    2 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |    7 +-
 .../dc/link/protocols/link_edp_panel_control.c     |    8 +-
 .../gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   |    2 +-
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |    6 +-
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c   |    2 +-
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h   |    2 +-
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |    2 +-
 .../display/dc/resource/dce100/dce100_resource.c   |   10 +-
 .../display/dc/resource/dce110/dce110_resource.c   |    8 +-
 .../display/dc/resource/dce112/dce112_resource.c   |    4 +-
 .../display/dc/resource/dce120/dce120_resource.c   |    6 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |    8 +-
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |   15 +-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |   60 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |   26 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |   63 +-
 .../display/dc/resource/dcn301/dcn301_resource.c   |   31 +-
 .../display/dc/resource/dcn302/dcn302_resource.c   |   22 +-
 .../display/dc/resource/dcn303/dcn303_resource.c   |   22 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |   30 +-
 .../display/dc/resource/dcn314/dcn314_resource.c   |   26 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |   37 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |   29 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |   33 +-
 .../dc/resource/dcn32/dcn32_resource_helpers.c     |    6 +-
 .../display/dc/resource/dcn321/dcn321_resource.c   |   22 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |   26 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |   26 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |   26 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |   32 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   50 +-
 .../display/dc/resource/dcn42/dcn42_resource_fpu.c |   22 +
 .../display/dc/resource/dcn42/dcn42_resource_fpu.h |    2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   32 +-
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |    6 +-
 .../drm/amd/display/modules/color/color_gamma.c    |   28 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |    2 +-
 .../drm/amd/display/modules/inc/mod_color_types.h  |   47 +
 .../drm/amd/display/modules/inc/mod_info_packet.h  |    9 +-
 .../display/modules/inc/mod_info_packet_types.h    |   37 +
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |   25 +
 drivers/gpu/drm/amd/display/modules/power/Makefile |    2 +-
 drivers/gpu/drm/amd/display/modules/power/power.c  | 1323 +-------
 .../gpu/drm/amd/display/modules/power/power_abm.c  | 2160 +++++++++++++
 .../drm/amd/display/modules/power/power_helpers.c  |  823 +----
 .../drm/amd/display/modules/power/power_helpers.h  |    1 +
 drivers/gpu/drm/amd/include/amdgpu_ptl.h           |   64 +
 .../amd/include/asic_reg/dcn/dcn_3_0_0_offset.h    |  129 +
 .../amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h   |  600 ++++
 .../amd/include/asic_reg/dcn/dcn_3_0_2_offset.h    |  112 +
 .../amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h   | 1907 ++++++++++++
 .../amd/include/asic_reg/dcn/dcn_3_0_3_offset.h    |  111 +
 .../amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h   |  941 ++++++
 .../amd/include/asic_reg/dcn/dcn_3_1_2_offset.h    |  109 +
 .../amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h   |  548 ++++
 .../amd/include/asic_reg/dcn/dcn_3_1_4_offset.h    |  108 +
 .../amd/include/asic_reg/dcn/dcn_3_1_4_sh_mask.h   |  544 ++++
 .../amd/include/asic_reg/dcn/dcn_3_1_5_offset.h    |  111 +
 .../amd/include/asic_reg/dcn/dcn_3_1_5_sh_mask.h   |  548 ++++
 .../amd/include/asic_reg/dcn/dcn_3_1_6_offset.h    |  111 +
 .../amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h   |  546 ++++
 .../amd/include/asic_reg/dcn/dcn_3_2_0_offset.h    |  109 +
 .../amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h   |  544 ++++
 .../amd/include/asic_reg/dcn/dcn_3_2_1_offset.h    |  124 +-
 .../amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h   |  548 ++++
 .../amd/include/asic_reg/vpe/vpe_2_0_0_offset.h    | 1041 +++++++
 .../amd/include/asic_reg/vpe/vpe_2_0_0_sh_mask.h   | 3162 ++++++++++++++++++++
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |    6 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   19 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   47 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   38 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |   14 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   96 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   22 +
 include/uapi/linux/kfd_ioctl.h                     |   38 +-
 193 files changed, 17912 insertions(+), 3668 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/ptl.rst
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_color_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_info_packet_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_abm.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ptl.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_sh_mask.h
