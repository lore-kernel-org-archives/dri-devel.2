Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF420606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p7nXr+49
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210E110E4E5;
	Thu, 26 Nov 2026 14:08:22 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBC3310E010;
 Thu, 26 Nov 2026 14:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZcw52bSiHm71V3jA4Cil5/TgmcEqVuAbAr9Vj4hWhYl8Be/RFpPv3pQh0fszKilfYdnQXGagt9nFwq+jiph9//TcxNSoafXDqJMrhOV+vjPzjK3F4ekyC2IGlLXZf5zBJcBMhu/PYlmIlG7wm8Bt1FkLoOPg3e5KroysF2zuRGOI993QaqRLqq904/IkksnL9Vk8LTisKDBTOWO5HMKYvYUxUJM+hyGcQcOyKBUuGPucf5A17hqDc5qo2SV3OzFhCbcdNTTmQ/VafSY4ap9f/liA4f22HPR3Vy855sx8tTyB5vD5R9oww9npGiMZMK184pT14v55QRePemKrpRgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiyWEgBXRyhdmhwAogiWuw2fuWgwreSj1l4amQDa7T8=;
 b=KuaR3m7roJ+0hnLw2bXMdh10Fkfzedp9XAPN6fn68MJcCyD4Tlarw74s0QtYHsN1gM8uJCYfwgCHKTgbtvz3vMXzBNZoztOhCqUQiy0tAB6vTQb+GuOBvca2qFFrY7PLMTCEdhBilewAJeFgD3Ws2b3zwy37qXSr7jiG0ztWWz7O+9O8zDjONS5NqoFg6GPITplJQNfsXzhhWPrImjL6s3Ambr1mfBBrkfC0eu2NIuTOzu1tNzLrohl/+MrFutcveiV83TxKWMLYWcxCjsOs307dbPiC+iGEtoIou/viwGO1XX2BzFg1plr5F/Av3vmLUGSsruNTrJws7/YbejElFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiyWEgBXRyhdmhwAogiWuw2fuWgwreSj1l4amQDa7T8=;
 b=p7nXr+49kPXFL4t9Ya2ZpVtyY3pCBMvJaCvosKepH1KOr1PDdJdCTJJXMPLFEBqBxXV9okymyqRw6Dt/TYpQbb37ItJF6KmHVmvnbvlZMBLD+15SgtGRPz3Ft5eUx4HKBbbxhZHJUNmN0NuSNmVbWIiPrMVNATKi1vlAQd2enbQ=
Received: from MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:08:09 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::14) by MW4PR04CA0235.outlook.office365.com
 (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 14:08:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 14:08:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 08:08:09 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 08:08:08 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 08:08:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon, PCI drm-fixes-7.4
Date: Thu, 26 Nov 2026 09:07:59 -0500
Message-ID: <20261126140800.1490796-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d581cba-932e-488d-2aa0-08df4bc6b356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|3023799007|13003099007|56012099006|11063799006|261028144727099003|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261021135927099003|261021123027099003|261022105027099003|261026140227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2AaRi196UNvlWLzFR5zlEGwEI2CSkku+NbpYoxmKadiTCQHTB89jEHBRV9ekopTfKr33nig2Y54JM8+Z9SVYE1AnYZO++lpS3xQRBpUJoBEKx2nIhbVvzajI2smiAXjwEm1kpX//jXck16xQWBwlEi91n+qyqESwJmse76gtokQlKtrWAH3RSapPAE3o/P7+DpGBsX1gv/7t6iShyX/ESqsuTAtZl76QuCGFmOpuvdE6ZcLIMXAw5OVt6Q06vS2VIywaeyPnboNhJY92QARVjRceKw4eKUZBLSKS18tXJZN/nxNyuozELoV87fyctz/TMNoxFRV0lq5UJatcjaK1HPKKMMFJGXBFsb6C9jLa+HMNrdptK0LP8j/PXiN++JAf83QIrgtgP/3mG5mPBNDe2wfnErrNUb9uyKWFOXIx7JwPosLEr6LHrAl2Su50EWIj5SzrxMswLguhqoEWwA7RWyHJDcg/WTd5jcVHA/HGXls45S3pm3n6/cs0BvVbVMyfa+az5HRSc86VwPd4dMjp3lwh4IPqKLpH/Bt4eSBQSROuXNPWnFOq0HEV4BWUXISmhf5CHSKXQauvzEkmBNkenzSbczvbPqAv0w/Gb6fMOwS6/Hnfk6fA4Y/qGuGZqJo9vyF1TBqEzJtBn9GBHOSlEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(3023799007)(13003099007)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021135927099003)(261021123027099003)(261022105027099003)(261026140227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n2lPqHaELmLdaveGQMI2DroAUaoLUKyR1f+RuGoqQsW7Gx038Hzy00z3DHK2nIFtgNPf1LBWSnEDf3DfD1XwHI2b5VJjvY0cyVswzpAY+2+B9jfwPNHXZRQVBuNXvVSqAq2e8tMvxZqILFGWLzN2P9aOrA6feI2HdDYLlnMkIPnrkEb4t8A1aS0jemRfGI/wvt9urpd+4jiIZkLdj3nvWoDTST7QJX6X4bsvi+qKsma+ZaIrJHLe7S1WV2Fsc5N2vsew+Q1xRn3kxxUjr+ClD2SHiqwUrFaXb8cRbVXIq96fSIZ9Uwt2egZ1vnbRDJ2n0GFUmb9v/oAQH90ZoIH6ljq0GqHIsuBNk15BCyUM0zet+euddY61PKhudAyQXl+LHraQ5JLJKvjIU9JP0PT3+jq2eiMxKVTJnYtuY94HQMG4Ly3vt0RByrgC8ngAx7TW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:08:09.3348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d581cba-932e-488d-2aa0-08df4bc6b356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Simona,

Fixes for 7.4.

The following changes since commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f:

  Linux 7.4-rc4 (2026-11-22 14:57:40 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.4-2026-11-26

for you to fetch changes up to 8a37614bcd382da36337a271b8945d0dc0cdb111:

  drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU restore (2026-11-25 09:56:31 -0500)

----------------------------------------------------------------
amd-drm-fixes-7.4-2026-11-26:

amdgpu:
- GPUVM fixes
- Reset fixes
- MES fix
- Multi-entity fix
- GC 11 APU fix
- GC 12.1 fix
- Error path cleanup fixes
- TB fix
- Fix handling of ACPI tables when PCI bus numbers change
- Display OTG fix
- eDP fix
- Replay fix
- DSC fix
- Fix display handling for RGBA8888
- VPE fix
- Fence accounting fixes

amdkfd:
- CWSR fixes
- SVM fixes
- Error path cleanup fixes
- Fence accounting fix
- Debugger fix
- CRIU fix

radeon:
- Fix handling of ACPI tables when PCI bus numbers change

PCI:
- Cache firmware secondary bus number

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdkfd: move TBA/TMA back to system memory
      drm/amdgpu: add helper for determining removable devices (USB4, TB)

Aveline Noir (1):
      drm/amdkfd: preserve the byte address when removing retry faults

Benjamin Cheng (3):
      drm/amdkfd: reserve TTM move fences
      drm/amdgpu/gem: reserve fences on the VM root PD
      drm/amdgpu/vm: reserve TTM_NUM_MOVE_FENCES in amdgpu_vm_lock_pd

Caden Chien (1):
      drm/amdgpu/vpe: align with reg read permission

Christoph Berliner (1):
      drm/amdgpu/gfx9: deactivate all compute HQDs before MODE2 on APUs

David Francis (1):
      drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU restore

Felix Kuehling (1):
      drm/amdkfd: Fix context ID cleanup after failures

Harry VanZyllDeJong (1):
      drm/amd/display: Honor the Replay stream regeneration wait event

Harry Wentland (2):
      drm/amd/display: Add RGBA8888 surface pixel format support
      drm/amd/display: Fix DCE crossbar for RGBA8888 surface format

Hongyan Xu (1):
      drm/amdkfd: fix use-after-free in create_process() error path

Ian Rogers (2):
      drm/amdgpu: initialize r in amdgpu_vm_bo_update()
      drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()

Jesse Zhang (1):
      drm/amdkfd: return the memory violation data to the debugger

Kent Russell (1):
      drm/amdgpu: Disable XNACK retry on GFX12.1

Mario Limonciello (3):
      PCI: Cache bridge firmware secondary bus number
      drm/amdgpu: Match VFCT using initial PCI bus number
      drm/radeon: Match VFCT using initial PCI bus number

Michael Strauss (1):
      drm/amd/display: Clear OTG_AUTO_FORCE_VSYNC_MODE on OTG disable

Nicholas Kazlauskas (1):
      drm/amd/display: Skip DSC padding borrow estimate for zero padding

Perry Yuan (2):
      drm/amdkfd: test copy_from_user() directly in kfd_criu_restore_svm()
      drm/amdkfd: fix units when unmapping a PROT_NONE VMA from GPUs

Pierre-Eric Pelloux-Prayer (2):
      drm/amdgpu: use a single clear entity on some chips
      drm/amdgpu: fix NULL deref in error path

Prike Liang (1):
      drm/amdgpu/mes: keep the RS64 context slot bitmaps across MES re-init

Priya Hosur (1):
      drm/amd/pm: restore the forced performance level after a reset

Ruijing Dong (1):
      drm/amdgpu: keep the commit padding when re-emitting submissions

Suresh Guttula (1):
      drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: clear the entire mapping when partially unmapping

Xiaogang Chen (2):
      drm/amdkfd: Fix a race issue at svm_migrate_copy_to_ram() error path
      drm/amdkfd: Swap order of svm_range_dma_unmap_dev and migrate_vma_finalize

Zhikai Zhai (1):
      drm/amd/display: Power up eDP when detect link

chong li (1):
      drm/amdgpu: post the ASIC after the reset done at init time

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           | 44 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 31 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 10 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           | 25 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 19 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             | 17 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 98 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             | 14 +++-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |  3 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c              |  3 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c              |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             |  4 +-
 .../amd/amdkfd/kfd_device_queue_manager_v12_1.c    | 18 +---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           | 21 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 58 +++++++++++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               | 16 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c  |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  4 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |  2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 42 +++++++---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h |  6 ++
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |  1 +
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |  1 +
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |  3 +
 .../gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c   |  3 +
 .../gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c |  3 +
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |  3 +
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c |  3 +
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |  3 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c   |  3 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |  3 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c |  1 +
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |  1 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |  1 +
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |  4 +
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |  4 +
 .../gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c |  4 +
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |  4 +
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c |  4 +
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c    |  1 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  1 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   | 15 ++--
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |  4 +
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |  4 +
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |  4 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |  4 +
 .../drm/amd/display/modules/power/power_replay.c   |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 21 ++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 39 ++-------
 drivers/gpu/drm/radeon/radeon_bios.c               | 42 ++++------
 drivers/pci/probe.c                                |  1 +
 include/linux/pci.h                                |  2 +
 66 files changed, 464 insertions(+), 224 deletions(-)
