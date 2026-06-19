Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A3CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 15:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FC310E0A4;
	Fri, 19 Jun 2026 15:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hgJiQGQm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A53F10E0A4;
 Fri, 19 Jun 2026 15:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s23cPwwc5PKaXKlu/OY2cpUiY26aMKBvpb2fTEq00MNkurKMLVc50TKzQCBgZziPRrN9EvQ8pJIsp95xFbGXC62iL81oIMz0BGbt6+PA95rty/bYf8uzv0NrHq+Skv8wF48vJ5GrSHjLBlSMxn4chDA2cY8SqHtP1p1BH3O9CMUzZlZzSRGfNi8D/FbkEGAxATcNQXL0abGIYvptQCs5uw5AqteskUidXHUnLHNn+kTdco2kmSV9FI3WObyoDp12W7i9Zajj1dcRSkaxyecQc+K/FV7sKJ5fgigmPPQW/ZwmAQEGmckJuPMUL5KemqW44k4M8qYvilebkI9p/lEn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tGYgw6qxACq5N6Ws3sm2hz8Vo4g7sYvyJ2gv5Hgl4Q=;
 b=LjHEyV/S4hIQxLfCmOH1271+KOOJhMcOX0WDeKWxJ5n4f9ucVGWWh3zXmf8dHHkNNstW3NKWUzeKG9nrz9fzL0DRv/W+WJW3Eh0p4RgnmLruudqfHJlGDfbWd34RIWDTU5wX1Op+pDIKoEpsCyieQk8EqFoNRBaMNB2gKuDaATZnYU6FQjvGRtfZRSKOt/b3L+QF8JHjIEijj38Q6jK/Ad5lhtJm/KAdKc+0GYr2JESpmUL/nYr4EYSUmfomk2AzABOTIu4XdO3EG6Vh0jlTlQJysLdJ6FbUmMMEHNxcflwwxIe2HGl8SZ8lzxXA5M/slw6op4ewyNSoTGjI7IwDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tGYgw6qxACq5N6Ws3sm2hz8Vo4g7sYvyJ2gv5Hgl4Q=;
 b=hgJiQGQmTtu7UERL5vP002MSGV443GO0I6AebHOnPZYr6IPuu8/xf9xN885ljcCFe1f3fbs6s0WeGEb7YdEdPRPYU6m+g/NvNC2neWau0mYXUIv+pYdbKfDtOEvr0KTxJPN43CUA6cR9HO7LKp8K6xxtcGSy9Ujbo+d2SrsmzcA=
Received: from CH0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:610:b3::24)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 15:26:25 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::af) by CH0PR03CA0049.outlook.office365.com
 (2603:10b6:610:b3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 15:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 15:26:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 10:26:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 19 Jun 2026 10:26:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-fixes-7.2
Date: Fri, 19 Jun 2026 11:26:10 -0400
Message-ID: <20260619152610.776982-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0eec3e-4ed3-4164-7e03-08dece171f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|13003099007|18002099003|3023799007|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 7/vxLWyX63gqf1J5yGNKCSYQrHrxMJ/byUHh+P4lqVlHXAHu/fRBOew0xUu+e0ZzJBMEFSqYWSlQSze+YSn3MHCaKUfROj3+Ze0C5Sl5p74lJgh/AQGmSTODBsReEGbm3GIzLMpHmXh2JcgMhFmGDJSPNQHpU6apOPsejfztag0D2JXwAc6eyAi1iUib1aMho7l+UzkY6DIdz7V8/cJL8Z4FYawIrjwp4ioNfHlJoegy3g1ExqM9v/Fsu0F0c4eMTzuMLdMnmdKRIui8dYqvHh/oaZFZqHwkyClsF6x3U4KK8r999gdd9vTRc+pIZCDoAYguSzXvTX9SMtpyUZHEdELFwUH2yusWCekqZpM7ZULV3JpGuniecRPuChu+TL/gxXm91aZiiKrZcVwcCeo3HgowEqwvpSgp+jK/HF8OKtJeb29cMq//O0cFcTxzhv5MMUOERiMW5qWwfrYy2A9DgkKPSye6EaD7ixNbMvammhAnFJbhEQcIXDlEVnkZJokuJYUbxyiZDBD4bCWql1tyP81XiwETNLzTVWOlnob+s9OmuUQCmqgXa8dAoGluBukLfRhoi8xXxyd2n4i79ukQnIVn7dNxQr4CpmZ2sjC22zNmLNkhdkDX3i2GMdhJbgaFK1H9YrOyNcdsFkce7RywdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(13003099007)(18002099003)(3023799007)(5023799004)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A6DYSEDjeHhXgbqJBbkqxV4UvcvJvZMwu+hH3kQZsZllvWDoncqIIjR9tUrrWWg2OvoRTaDpgw3bF06BZInip3ywkM6iVBn1wpRjZ+ZPiuEhdKnoEDmkPwVrEk1/O04vJBm73CEdKNQLZzQzyg5MpyEhuBDlTjSCn7rJuSOA2+g0el7d6SB7iVtCAzfQ5TtNzK1+iCd9eNOyUMtEzxqvhyhAt9tVixVSM7a3bh7bZOWbCYcOmMv1Kkxr3C8/bT6kk64ikGzPCd43DMNbGY0md4PvodtIEW1Sw7TYyJa8aywBhGGTmbBRFKmvpOJ+2XuzCUlDUYhEGESMDETLqHY2EMeGHlCQprYsYgG8eIPnr1XAluvTxaTJ94seXERnJRcmwy1zvOaWuHHuKzIKaHPjKpMMKs3meYERiO7Sx/MYdPqcSaQ4V74kuDPJeguCfiQV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 15:26:23.6264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0eec3e-4ed3-4164-7e03-08dece171f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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

The following changes since commit 52d4ab1ca790a668cc8f2c27017138b1c467168c:

  Merge tag 'drm-misc-next-fixes-2026-06-11' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next (2026-06-13 08:10:38 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-06-19

for you to fetch changes up to ba2977dcce72127986fbad76c4c67f134e2f69ae:

  drm/amdgpu: Use system unbound workqueue for soft IH ring (2026-06-17 18:36:38 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-06-19:

amdgpu:
- devcoredump fixes
- SMU15 fix
- Various irq put/get imbalance cleanup fixes
- 8K panel fix
- DCN3.5 fix
- lockdep fix
- Cleaner shader sysfs IB overflow fix
- Async flip fixes
- GET_MAPPING_INFO fix
- CP_GFX_SHADOW fix
- Ctx pstate handling fix
- GTT bo move handling fixes
- Old UVD BO placement fixes
- GC9 mode2 reset fix
- IH6.1 version fix
- Soft IH ring fix

amdkfd:
- Fix doorbell/mmio double unpin on free
- CRIU fixes
- SMI event fixes
- Sysfs teardown fix
- Various boundary checking fixes
- Various error checking fixes
- SVM fix

radeon:
- r100_copy_blit fix for large BOs

----------------------------------------------------------------
Andrew Martin (1):
      drm/amdkfd: Fix SMI event PID reporting for containers

Asad Kamal (1):
      drm/amdgpu/gfx: fix cleaner shader IB buffer overflow

David Francis (1):
      drm/amdkfd: Properly acquire queue buffers in CRIU restore

Geoffrey McRae (1):
      drm/amdkfd: Fix NULL deref during sysfs teardown

Gerhard Schwanzer (1):
      drm/amdkfd: Use exclusive bounds for SVM split alignment checks

Ivan Lipski (1):
      drm/amd/display: Restore periodic detection for DCN35

James Lin (1):
      drm/amd/display: Add IN_FORMATS_ASYNC support for planes

Jiqian Chen (1):
      drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2

Mario Limonciello (3):
      drm/amdkfd: fix list_del corruption in kfd_criu_resume_svm
      drm/amdgpu: check amdgpu_vm_bo_find() result in GET_MAPPING_INFO
      drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1

Matthew Schwartz (1):
      drm/amd/display: Fix mem_type change detection for async flips

Mikhail Gavrilov (2):
      drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to drm_exec
      drm/amdgpu: fix recursive ww_mutex acquire in amdgpu_devcoredump_format

Pavel Ondračka (1):
      drm/radeon: fix r100_copy_blit for large BOs

Prike Liang (1):
      drm/amdgpu: allocate lockdep mutex on the heap to fix stack overflow

Qiang Yu (1):
      drm/amdgpu: initialize iter.start in amdgpu_devcoredump_format

Roman Li (1):
      drm/amd/display: Skip PHY SSC reduction on some 8K panels

Shubhankar Milind Sardeshpande (1):
      drm/amd/pm: re-enable MC access after PrepareMp1ForUnload on SMU V15 APUs

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: initialize irq.lock spinlock earlier

Timur Kristóf (6):
      drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
      drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT
      drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
      drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU segment when it isn't at 0 (v2)
      amdgpu/ih6.1: Fix minor version
      drm/amdgpu: Use system unbound workqueue for soft IH ring

Tvrtko Ursulin (1):
      drm/amdgpu: Fix context pstate override handling

Uwe Kleine-König (The Capable Hub) (1):
      drm/amdgpu: Don't use UTS_RELEASE directly

Xiaogang Chen (3):
      drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioctl
      drm/amdkfd: check find_first_zero_bit before __set_bit on kfd->doorbell_bitmap
      drm/amdkfd: Use memdup_array_user to copy data from/to user space at kfd ioctls

Yunxiang Li (2):
      drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free
      drm/amdgpu: skip already suspended IP blocks in ip_suspend_phase2

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  23 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  71 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   | 220 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |  30 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        | 103 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  18 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  50 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  91 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  39 ++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  56 ++----
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  46 +++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |  99 ++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h        |  14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  15 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   1 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |   2 -
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |   2 -
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |   2 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   7 +-
 drivers/gpu/drm/radeon/r100.c                      |  13 +-
 34 files changed, 618 insertions(+), 386 deletions(-)
