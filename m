Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EA9CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C806E10E1EA;
	Wed, 20 May 2026 18:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pvdaGl/1";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0537010E15D;
 Wed, 20 May 2026 18:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWk2ztf7clUsSIfbpx41/N1GH7f+TG9CdZ3n1DEpKL2z/lF/BDtKkTFylU/TdeIARcJOSzwPIc5ZICRYDPjXO2821S9cnsikrhQ78QJdRdHmYdO/X+DDW54rih5epGCAobCCjDM+MD1GxVfZ2IR8jOyh52dRYAbUqtjQ1ewsyudo/jjYMCNvoYN6mWX1Egrzo8+tZzmZ9J9dwSC+SCfeidkoXF/Pd7wugT+O4pvX/pNIC9umSahvoDx/2tjgyo928BspcwgGyYa5fMC0xlKlRQ8w7FR07YyWTCoGAwNjF4YOoA4gm3KeyIk1gFkgqk7gQP0CnGshDTZFgdpq4Yh83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rx7Nz9G+rqzV7e8zl246Gm6FW/5mE/ovFXc0SDhRug=;
 b=BcX9//S/gMEdHdCd89/7oxDGDFHYCsCuFUGK1aoJ3c8rRugKOGNA71gvjSjjGQwDTNL731gpNmbeNqOEu44Iy0dsLbyMWXTGjr5zfUYoNDbvJMDl9ve4HH0LdoNvNVkc2+Uh6ePJVn2Lf+3OR/ByC2HDoqbM+td4NLBrxBG8RomvN3WZm01J68aNsAHfgHADWtKRGxRqqEUMwikJaO/A/2CDn+j0gUOumKXAx+tvWIKldt9PUV37mPpucPQ0prMfXLm97Zhu7QWo6UOpk8yQhSz6zdistVKh+jby+qwcyf6xC7DHRv+DNPEnJhltTfAMcpPMOmuDzJ1gxtNALgkqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rx7Nz9G+rqzV7e8zl246Gm6FW/5mE/ovFXc0SDhRug=;
 b=pvdaGl/1AgnF2AJQb5ZXwIKlQ05Qy1N9cnutrPmnbwjY1VQGuO2yh61AU4W7w/+6k+LDv2vka0LVuxH2GHD/oiS+qS8ZkKvE8u2D/VY0klGej4Fl3wv6m/D2+CVSOmvKU8nai4DT65akqNGcrpaOKuoLToZ6jSMpyUsmfWnynDw=
Received: from PH7PR13CA0024.namprd13.prod.outlook.com (2603:10b6:510:174::10)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 18:32:07 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::4c) by PH7PR13CA0024.outlook.office365.com
 (2603:10b6:510:174::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 18:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 18:32:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 13:32:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 11:32:06 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 13:32:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.2
Date: Wed, 20 May 2026 14:32:00 -0400
Message-ID: <20260520183200.28877-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 78114284-371d-4e77-4e51-08deb69e18ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|13003099007|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: ZHZLFmSNAUurRVmiTqYXxatIa+UOg8mPiSCigMWjXprJRi12VbWovqNDfXcGosQErO6m5/JV6jsqrS8nBnEUEpchmP6nbq/9HP1bb/N83uPziTyQFBGZqnj+n4KCQ366466SxhEWjT46y0RnU4o8cuO69mByO09c2qU2hl8jlzKkte5QEH/AkONMxLO5iouKQw3Xt5rvycM0gFZvlBwuMF9SbS40IlYazX7MCfTWNcc4+DJ4GBF3mOdLQh87PvsNMEfBhNw+6ear2O9yyI5vPy5Tkjj4lb5c7J+ydxc/bXgET+sFIQKqitAFP59TyoaZBseJVpfKmY3zc346dO93TqwVcnIcJR2OkcD2/n4S9BfKsf08PFJk+wtRGhKAgaJNzC9oos07sPww+0ROFH1pmPYaMqVXWAntbGwlOz86hpt5rxcpqFEDx4EUcskIBsX5lGi7J5gTe6mDOuEzwVxGCjmK6C+TNA6dWrkdNTpoqiO/6/2bDrXznQRLYRoNIY6JTwi+edAr7hjOZo33e6rSwuN9LbTF+QIPwpK9ET5lj7sVbkplZH8x2Bt1PfGfIyYsgCo8VWx84sPOTdyNJHn9Sd5CWvV2mDSFy1uz7sU3yOWZi6/3jtXeDuWbBcQqqlkAKddqH5oG7P8kE+Y2QGsWKD4mRF5GiC43uGWjOGyIk0bVTO/MHfdJaBhkx33FiS4E
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(13003099007)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GTI6KOUi3u4+/GBe1SUSsnCzx6aAPWtcR45uZAgz12AFebsPOZlGIS+vAwObG3qmKlrnwEEO3PJqnG2chC7DiYCYW1Hgz/W8dgQuOIXB0/PgHMxX17iCp60f+0WPnZGQ5ggkryP1F8VCLyUldZky/IFbK9tsT1moCj0zZ/hQEnpB4h1/84nGfARXicVyFQx/TmBUI23rJBqC/PfJhxTTLi0Vh2dOSnPdmAuUa3L5zVmAZiCSkE3pILyuGT5UHfgxuXQDJ1jpKcLEkqn45fCKQ14LUjNrMG9KmXP0u2dB064fVbjAc3rZnFp45xayWG9mQbalgbqqrG6v14hDmoB9cpefMVdyuMEWuvnnYgurdjQIIdLv2SAhNdscBL8hgLbnGADD7K2/HWuz+uKKfMYzMOWC3yjpHU1CAciUbFYvL1ztDA32TO7uKVlmkSN8pbCo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 18:32:07.1992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78114284-371d-4e77-4e51-08deb69e18ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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

Updates for 7.2.

The following changes since commit 1f863fe67343e2f45fc0af75ac94c3705bdf6537:

  Merge tag 'drm-intel-next-2026-05-14' of https://gitlab.freedesktop.org/drm/i915/kernel into drm-next (2026-05-15 15:37:16 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.2-2026-05-20

for you to fetch changes up to 4cdbba5a16aaf16513b69cc332b1d6f971a44b52:

  drm/amdgpu: restructure VM state machine v4 (2026-05-19 11:54:32 -0400)

----------------------------------------------------------------
amd-drm-next-7.2-2026-05-20:

amdgpu:
- Userq fixes
- VPE fix
- SMU 15 fix
- Misc fixes
- VCE fixes
- DC bios parsing fixes
- DC aux fix
- Mode1 reset fix
- RAS fixes
- SR-IOV fixes
- Runtime PM clean up
- DCN 4.2 updates
- eDP fixes
- PSR power module update
- ISM fixes
- DP MST fixes
- Replay power module update
- Auxless ALPM support
- ACP memory leaks in error paths fixed
- Restructure VM state machine

amdkfd:
- Misc fixes
- MES 12.1 SDMA updates

radeon:
- CS parser fix

----------------------------------------------------------------
Alan Liu (1):
      drm/amdgpu/vpe: Force collaborate sync after TRAP

Amber Lin (2):
      drm/amdgpu: Support MES suspend_all_sdma_gangs
      drm/amdkfd: Enable SDMA queue reset on gfx v12.1

Amir Shetaia (1):
      drm/amdgpu: reject non-user addresses early in GEM_USERPTR ioctl

Aric Cyr (2):
      drm/amd/display: Fix assertion due to disable/enable CM blocks
      drm/amd/display: Enable additional wait for pipe pending checks

Candice Li (4):
      drm/amd/ras: bound CPER record fetch buffer size
      drm/amdgpu: cap ATOM command table nesting depth
      drm/amdgpu: Bound GPIO I2C table entry count from VBIOS
      drm/amdgpu: validate and share PSP fw_pri_buf copies via psp_copy_fw

Ce Sun (3):
      drm/amdgpu: avoid integer overflow in VA range check
      drm/amdgpu: Fix memory leak of i2s_pdata in ACP initialization
      drm/amd/ras: Add more IP versions for uniras

Charlene Liu (1):
      drm/amd/display: Allow power up when PG disallowed in driver

Chenglei Xie (1):
      drm/amdgpu: fix OOB risk parsing virt RAS batch trace replies on the VF

Christian König (3):
      drm/amdgpu: rework userq reset work handling
      drm/amdgpu: fix handling in amdgpu_userq_create
      drm/amdgpu: restructure VM state machine v4

Cruise Hung (1):
      drm/amd/display: Exclude the MST overhead from BW deallocation

David Francis (2):
      drm/amdkfd: Check bounds on allocate_doorbell
      drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id

Gangliang Xie (3):
      drm/amdgpu: add first record offset check
      drm/amd/ras: add first record offset check
      drm/amd/ras: return error when converting records to nps pages fails

Harry Wentland (4):
      drm/amdgpu: Remove UML build exclusion from Kconfig
      drm/amd/display: Fix integer overflow in bios_get_image()
      drm/amd/display: Validate GPIO pin LUT table size before iterating
      drm/amd/display: Validate payload length and link_index in dc_process_dmub_aux_transfer_async

James Lin (2):
      drm/amd/display: Add some missing code for dcn42
      Revert "drm/amd/display: dmub_cmd.h: add missing kernel-doc for enums"

Leon Huang (1):
      drm/amd/display: Add Auxless-ALPM support in VESA Panel Replay

Lijo Lazar (1):
      drm/amdgpu: Fix discovery offset check under VF

Lohita Mudimela (2):
      drm/amd/display: Refactor PSR functionality into dedicated power_psr module
      drm/amd/display: Refactor Replay functionality into dedicated power_replay module

Mario Limonciello (1):
      drm/amd: Reduce code duplication in runtime PM

Ray Wu (2):
      drm/amd/display: Fix ISM dc_lock deadlock during suspend
      drm/amd/display: Use lockdep_assert_held() for dc_lock check

Sunday Clement (1):
      drm/amdkfd: Fix OOB memory exposure in get_wave_state()

Sung-huai Wang (1):
      drm/amd/display: Fix eDP receiver ready status check in T7 sequence

Sunil Khatri (7):
      drm/amdgpu/userq: use drm_exec in amdgpu_userq_fence_read_wptr
      drm/amdgpu/userq: pin mqd and fw object bo to avoid eviction
      drm/amdgpu/userq: cancel reset work while tear down in progress
      drm/amdgpu/userq: update the vm task info during signal ioctl
      drm/amdgpu: remove va cursors for all mappings
      drm/amdgpu: use atomic operation to achieve lockless serialization
      drm/amdgpu: userq_va_mapped should remain true once done

Taimur Hassan (1):
      drm/amd/display: Promote DC to 3.2.383

Timur Kristóf (9):
      drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on Tahiti (v2)
      drm/amdgpu/vce1: Check that the GPU address is < 128 MiB
      drm/amdgpu/vce1: Remove superfluous address check
      drm/amdgpu/vce1: Check if VRAM address is lower than GART.
      drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
      drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
      drm/amdgpu/vce1: Stop using amdgpu_vce_resume
      drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
      drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets

Vitaliy Triang3l Kuzmin (1):
      drm/radeon/evergreen_cs: Add missing NULL prefix check in surface check

Wei-Guang Li (1):
      drm/amd/display: Add debug option for replay ESD recovery

Wenxian Wang (1):
      drm/amd/display: Add ADDR3 swizzle modes

Xiang Liu (3):
      drm/amd/ras: Fix UMC error address allocation leak
      drm/amd/ras: reset CPER ring on corrupt entry size
      drm/amd/ras: Fix SMU EEPROM record field decoding

Yang Wang (1):
      drm/amd/pm: fix memleak of dpm_policies on smu v15

YiPeng Chai (7):
      drm/amd/ras: use mutex to prevent concurrent access conflicts
      drm/amd/ras: add error handling for seqno operations
      drm/amd/ras: remove unused code
      drm/amd/ras: fix memory leak on ras sw_init failure
      drm/amd/ras: add length check for ras command output buffer
      drm/amd/ras: copy ras log data instead of referencing pointers
      drm/amdgpu: check and drop invalid bad page records

Yifan Zhang (1):
      drm/amdgpu: unmap all user mappings of framebuffer and doorbell before mode1 reset

chong li (1):
      drm/amdgpu: Add guest driver CUID support

 drivers/gpu/drm/amd/amdgpu/Kconfig                 |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   76 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   50 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   27 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  277 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |   55 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  536 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   69 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |    4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |    2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |   11 +
 drivers/gpu/drm/amd/amdgpu/atom.h                  |    3 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |    1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |   14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c           |   14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c             |   14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |    8 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |   64 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |    9 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   22 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    9 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   25 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   60 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |    1 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    9 +
 .../drm/amd/display/dc/bios/bios_parser_helper.c   |    9 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |    2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    6 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    4 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |    3 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |    1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |    1 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |    2 +
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |    8 +-
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c |    2 +
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c |    2 +
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |    2 +
 .../drm/amd/display/dc/hwss/dcn301/dcn301_init.c   |    2 +
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |    2 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |    2 +
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |    2 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |    2 +
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h       |    1 -
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   41 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |   14 +-
 .../dc/link/protocols/link_dp_panel_replay.c       |   13 +
 .../dc/link/protocols/link_edp_panel_control.c     |    4 +-
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |    1 -
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c |    2 -
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |   43 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   10 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.h |    7 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  156 +--
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |   23 -
 drivers/gpu/drm/amd/display/modules/power/Makefile |    4 +-
 drivers/gpu/drm/amd/display/modules/power/power.c  | 1343 +-------------------
 .../gpu/drm/amd/display/modules/power/power_abm.c  |   98 --
 .../drm/amd/display/modules/power/power_helpers.c  |  250 ----
 .../drm/amd/display/modules/power/power_helpers.h  |  121 ++
 .../gpu/drm/amd/display/modules/power/power_psr.c  |  665 ++++++++++
 .../drm/amd/display/modules/power/power_replay.c   |  911 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |    2 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |    8 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |   26 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |   55 +-
 drivers/gpu/drm/amd/ras/rascore/ras.h              |    1 -
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c          |  108 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h          |   12 +-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c         |    6 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cper.c         |   20 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cper.h         |    2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c       |    7 +
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c    |    8 +-
 drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c     |   23 +-
 drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h     |    2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c          |    5 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |    6 +-
 107 files changed, 2975 insertions(+), 2716 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_replay.c
