Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92894C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FE010E063;
	Wed, 29 Jul 2026 18:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HZAJXEYX";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE67A10E058;
 Wed, 29 Jul 2026 18:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpxYcpG9g2Ed6lfwmoErYk+NpophzYvSDN9VUq64CS1mRDlyAHB+hosOc5vhXJpYKU5kqlB0IP4J5SIu8H0J3z0H5LmHiJEgydf7gFSpy7sAu/a/Xvbvt8QFm9QmZSTtXqsIhtrFwkVUBAOZcsJntmYGzFkMTYeJ7MlmYr/0xhTsthkg9Fnk6UyGYLTUKPRt722yE/Jo1N7caa4iXSx9NNVFQ7shntuWlsoDygWEQP3T50YCTFZtCHDxJsPp8XFhiGrXO2km5nqqIJMJuWGqyQoq1P9OCrAI6jLlTv9Wy9IGTLk9UMMktV8wp8KSxmId0V5sHupNQG+dgfNyeBMhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbzQ+i/OyA1WDkyEULV72u6L9+lZdWhQ++rwURjv50w=;
 b=YzSWfc6VyeofVqX7zRVn49+hOVFVpf+SyzOINLAbjGIOvBFSnRhc1zdEA4ND6Mn91T7h4tswZl0J4SZEQJyEaGpBtyTUS47DSiqVc8ken1O7sfb4PjYfn8UlpCK/AA5ib0YXCV78jI5IzcQR0yTHUxmD1HaQnez8OoGvFGaThYzMkBjX4uNIq7FL6x0RheVUOA+4Zhz2BI4vxE1MelHHSDnL5CCkf/0vposx/0yVVp3FZdYFYzebTD/F4crvp3wwmCeqYc09iYRD2RlXgqSAb4aT7rUrHtIsvcDdo740ribNqk0dtTrcB7dpu3QnfRdJkUTqGwAwP4xMqJpN4IxbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbzQ+i/OyA1WDkyEULV72u6L9+lZdWhQ++rwURjv50w=;
 b=HZAJXEYXZ9xtNlkFN1noSosnf8HQ9WJkFnITW4K6hUSyxbBaxgTflUvCxA+2AlSetOxR6Qs0GaB2jymH5BPZfFjT1L54AgxuiXRDvl0qMTjM8PtTsBr0FuCWS4SVX9Ir5BSfEBZcQDGjAPwZvwzJ1S1n1pctMzMGDQPwt94f/4Y=
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 18:22:22 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::7e) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 18:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 18:22:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 13:22:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 13:22:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.2
Date: Wed, 29 Jul 2026 14:22:09 -0400
Message-ID: <20260729182209.4072227-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: bb56d863-6c59-44e7-8474-08deed9e5472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: X5IGiIOQP7mBTkR0gYYnhc8pEIQiQbHY3g9HaL/JjJR4/7wr7PHFZwY1o5rp3ExhsH9/3WTOjmVoMUZKxjgpFXzHKQEltcWVFr44hcZHKKuOvD9yZwnxA/ruJEq7SUITEBiSL08v3hDxnFviTQgHJjkuNMCtloR5VLC9uMigqeCBVwXIcuUA1C2FPLXEbZ0kP2fJXQkquRSbngNC11SCKvH2ymc4f0UbbIsQdrQg27GDxeXfjep8h4eI7oCFRlVD/Fd4xMlwu1Aau0x0jht3W0MaXDJ+wBf/FW8wXyRNiaw9+u0vvn0q3z86YK/UCzjzEvHUpx1emAXS1IzRWUJSO6mXQN1zgHVA0HcRBIk8OUEfSu2iv5J5VfDmUPvEH4mle4l1m90NBpDmspju1Lujb7PjlDQHmu6natzyKc3Idc+Zy0UeYlugYXfwQDcS2e7y4XbPsJ0cVTvfTMHPkehxzLpxIKgLFSr+hulODKNkqIDkKpfdtvD8Z1Zu7yOOkDAUj0g9YsoAiq/mMm2mWFmQHjp5cKuU5HL7tWr58JYxyhZw+hZ2pTuncSvWNZUKSJBPMB8lRkGPGZXWGSYp+YKiMk7SOcY1tOo80+bWzKWfUxG10Z9lMmDdvlxW2J/RQa3yKe7Nq1F/Tbxgsoqu/64YPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VkMukNj02EnDbb9w9GlQbhGSuZoBzyFouKhR1CvyA0BXq3RAk4MLRO9BKOLKUfj7D/tHXmSAYSksMO+KQi4bQNezWyxKGL7EWfPIU8HcjQ0ohuaWZWzN6z+iwnri4wkxr8doKoN3/ybpuZkOckiIrPiYLw5Z/zH2ZjGAq+AW4w5T4Wsunhd1fbVF3SzaIX+0yMRaN7Ngk05LoOa/1QKWJzBcw3Ax2TJQRnJshCKMj7QQ3k828cWOkeem0108UF/qZsv855sLOxRaZx9Aziwwoi0WIee3h9yOc2QhiN2m/DnhJ9Ntr+ViPJEvcB+jBCTo9k2FEewUGTyywqF8yYYDffIDOvZczN2kcx+KNclA8+dpi2LsU77JOmim9gESpRKxw2XkC2VI9lPl2/4f2OcnhsVU6uTdUBVNrWK64jb94bqMeYInk4SHdHiQHLwqpNZ4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 18:22:21.0163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb56d863-6c59-44e7-8474-08deed9e5472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-07-29

for you to fetch changes up to 114b42507b6a23d9d24e24e4ef165233332c64d4:

  drm/amd/display: use proper context for logging (2026-07-28 20:01:24 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-07-29:

amdgpu:
- VCN 5.3 fix
- UserQ fixes
- GEM close optimization
- HDMI AV mute fix
- UML build fixes
- GFXOFF residency metrics fixes
- SMU 15 fixes
- debug_vm fix
- PSP 15 fixes
- NBIO 7.11.5 fix
- pptable use after free fix
- gpu metrics fetch fix
- DC viewport fix
- DML2.1 fix
- i2c retimer spam fix
- UMD profile pstate fix
- Power metrics format cleanup
- GTT size fix on APUs
- DC context logging fix

amdkfd:
- Various bounds checking fixes
- Mutex locking fix

----------------------------------------------------------------
Alan Swanson (1):
      drm/amd/display: Silence link_dpms I2C retimer failures

Alex Deucher (1):
      drm/amd/display: check if dml21_add_phantom_plane() is successful

Alex Hung (2):
      drm/amdgpu: Fix __rcu fence pointer accesses
      drm/amdgpu: Pack nested ucode_info struct

Bob Zhou (1):
      drm/amdgpu: skip clearing empty freed VM list on GEM close

Candice Li (1):
      drm/amdgpu: restore UMD profile pstate after runtime resume

David Francis (1):
      drm/amdkfd: Handle invalid event type in CRIU event restore

Fares Soliman (1):
      drm/amdgpu: Update message IDs to PMFW to correctly gather GFXOFF residency logs

Gang Ba (1):
      drm/amdkfd: Fix missing authorization check in KFD_IOC_DBG_TRAP_DISABLE

George Zhang (1):
      drm/amd/display: Fix divide-by-zero in calculate_mcache_setting on zero viewport

Harkirat Gill (1):
      drm/amdgpu: cap GTT size to physical RAM on APUs

Jiri Slaby (SUSE) (1):
      drm/amd/display: use proper context for logging

Kanala Ramalingeswara Reddy (2):
      drm/amdgpu: Update driver if header for SMU V15.0.5
      drm/amdgpu: enable mode2 reset for SMU IP v15.0.5

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini

Ray Wu (2):
      drm/amd/display: Increase HDMI AV mute wait from 2 to 3 frames
      drm/amd/display: Add AV mute wait frames to dce110_set_avmute

Shubhankar Milind Sardeshpande (2):
      drm/amdgpu: Enable support for PSP 15_0_5
      drm/amdgpu: Fix NBIO 7.11.5 offsets

Sunil Khatri (1):
      drm/amdgpu: dont pin wptr bo instead use eviction fence

Suresh Guttula (1):
      drm/amdgpu : update mmhub eco sec lvl for vcn5_3

Vladimir Marioukhine (1):
      drm/amdkfd: fix QID bit leak in pqm_create_queue()

William Palacek (3):
      drm/amdkfd: Add bounds check for CRAT subtype length
      drm/amdkfd: fix uint32_t overflow in EOP ring buffer size alignment
      drm/amdkfd: hold event_mutex while checkpointing CRIU events

Yang Wang (3):
      drm/amd/pm: fix pptable use-after-free
      drm/amd/pm: fix torn gpu metrics reads
      drm/amd/pm: use milliwatts for GPU power sensors

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  30 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  15 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  32 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  19 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |  24 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  17 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           | 146 +++++++-------
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |  93 +++++++--
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |  26 +++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   9 +
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  23 ++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |   2 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  20 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |  15 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |  31 ++-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  21 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |  16 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  16 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   6 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  26 ++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  29 +--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   6 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |   4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |   2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |   5 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |   5 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   2 +-
 .../pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h |  38 ++++
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |   2 +-
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   8 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   7 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  59 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   | 223 ++++++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |   3 +-
 63 files changed, 825 insertions(+), 261 deletions(-)
