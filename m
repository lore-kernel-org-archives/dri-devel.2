Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5B9C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8B910F1B0;
	Thu, 27 Aug 2026 20:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AiOfdoOU";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB6F10F1B0;
 Thu, 27 Aug 2026 20:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHkyLb/T9tJytujJsAJ5mDRS+Xl57nI6FMBaL4CoDt+E3TXJJOaMc0tBlhHRBuujQnskiqXZE1z3BayddNlqnfCbdSo7/O0rBmTJIjzts4MsC+HPmWfHiJ+DGoeYsvZv6dH04CntZh5lyk4hRUUVpUb9Bzvz5GoB46GVTiaWzcnsPGrb7zBtIBauFWIyj+zvJavWIMRf+0nUUYcURxamS7zf7eR509VKk7ed0dFOMg05nBGa0+ofiG5xQc6dwGBcLDj0n/6A/MJT+2LbasE9km4z69wQxVb981Ag/kARHceDV7kIf4jywGoesaMFI281XMsb3gsd5z6qh5/hj5mRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESgm0Y+2dzv383T55NRgReWhgA74tdUq+zkNSDQGtis=;
 b=WeBsuXO4LOTYKLHb+uwQjkcS3V/jyE1HbHatavEMDzDQhvtr4ZK4Hj2xNI6iwy4/cnljj513W5xAcChfkd0UZMqDGBt58Z/lz+iZTdTGFwAxIRoLUhNq18KiTy2bFJrli4ePp3EhNiIN55s3n46mdeeKDer7jbfDi/nICPf9mcH4CcbGx59+ap9B5S1xDO1QBYICxY1B8t6oztZTkJ4m/iQw27rsFqKr+BtKzIoBu/tPQqfOMTNPrFv14j10K1J5oujT31KXLlmtKUjWTUgHA3zI5yCY9dQCVzDsbHU22oj2vW2w/pNMW2XpSA2nzVm0RBSsfKlPgcKSopCfjJROcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESgm0Y+2dzv383T55NRgReWhgA74tdUq+zkNSDQGtis=;
 b=AiOfdoOUgz32d1eOn23Vohzc8pphwIHU/VIIGTx/269jqBA32xkdz4UAMM84byfjZ8Ml2asWev9H2+aPh0TfcFzuAHAc4a77re4qKH6GlkPps+97ZR8iVTR2urx7MAyRFn7ODVin8tdHMoB6RIGvi8hx6LNKH5NVteGwX7CNjt0=
Received: from PH7P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::31)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 20:36:19 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::30) by PH7P223CA0026.outlook.office365.com
 (2603:10b6:510:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:36:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 15:36:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 15:36:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.3
Date: Thu, 27 Aug 2026 16:36:09 -0400
Message-ID: <20260827203610.3249084-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: ee596605-418f-4b13-221e-08df047ad927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: KNS/8Y2zkVNQlea8pI3besz/h4JAor+2WtExKWRAYw1MEC6sZ6WAHyRgMbQ/xIuieF6Y1r0rORkUOeYSvJGove7RXOGjYA2q1zze161iCamI9safWKtnRswPo2VSwt7IqrzBqs9+Hxdt0lRn3V/z28YEvdlZOXP73kQMwMQQqHOGqPqGiz+3WnzeUulpf2HriS3aY5yFeiN75vIVOUrEgbgc0jY2FlXuALOwKyT/0bFHtczDO8t1A5GJHWUG5YbMqC131F/NblimbR5s9rXWfcoi82NqFAgUOMiP0KNV9PmxwIKt2qoMRtkEj6GYrRGEUxm+YP/LV2tDksOPeRI1fTJRJZyP5cupcI+GvNCuDDaaYf9oGNw56s+5+UtcoCMX0vHzQCcd6l9bRVdm11IUrVyHDPoEdYhaS0WY9c1sLpj60aQuf9KN6ar6yxFT5arrKjL8g/URk1/DS7YP+wWWfDpxOzawE9jn74BT/UN3maK45Drh+Zv8ZHU13Ws7UIx94VphGJYf/1xnbgYCVGFsArLhLpZ99zqZTG1RJJUEW2T3cXUBKLPGb2DyTLcZTDTX5vQ9MA2JcRbHIfbIbvdMydNI03Kwbgpb764f2m9Hgl9l9ydcOmT0N02p+G8sYAFEBQbkkBQK2IM1c/sUTZNFig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hws77JC1fEa5+WXh4CVsG5R/TtSeTzPLJdX6Qk704A104uGPCap4VfiasVNlVFNRNpQ0ccuUTkhbW/7Sp22AeFJfj0f7PtQie1XD4xTIssjlJdhSQ8sM9xweIw+PVCisof0gM8KGfzMFzZ51GSeUQbANCA+HOwI7VoDkEZHBI0znzFEA+q+XKr89hDmBWSogxEiV3EIlsiOeAvwWMnvcCnAnj9mR33Ie6BOg7FnhlHSZOB1SOATQBcy+wviLNjsY4GfigUqC9mRhLA1UIG66Ed8dJPA152AqQP15Cerp3vZ0IhX3lCJmkn0VjKoaGsgcJwXoNIiMXU7//nii+8J98WTixfmB3T9rKD8hJjMJAejYPPtlS9RFjb/FLJ80SPyIcfpnu2H6CG5iJK+PdM2IMMG+QKAB8PmLxqjyJK6fhYP2+Tl3ol2RMnKBMM+uI2MC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:36:18.4933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee596605-418f-4b13-221e-08df047ad927
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
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

The following changes since commit 1ff8d3e3165fd077faa4259fd232bdddcd30249f:

  Merge tag 'drm-xe-next-fixes-2026-08-20' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2026-08-24 11:40:23 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-08-27

for you to fetch changes up to 92a9eebd2a1f892fe482154d83f9f1626bc73d3b:

  drm/amd/display: fix dc_lock leak on GPU reset error paths (2026-08-25 18:24:30 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-08-27:

amdgpu:
- MES fixes
- Userq fixes
- UVD fix
- VCE 3 fix
- Enforce isolation fix
- HPD fix for VGA/LVDS
- DML fix
- DCN 6 fixes
- DC gpu reset fix

amdkfd:
- CU occupancy for GFX 11
- CU occupancy for GFX 12/12.1
- Queue bounds checking fix
- SVM fixes
- CRIU bounds checking fix

----------------------------------------------------------------
Bob Zhou (1):
      drm/amdgpu: avoid force-completing uninitialized UVD rings

David Belanger (3):
      drm/kfd: Add CU occupancy support to GFX11
      drm/kfd: Add CU occupancy support to GFX12
      drm/kfd: Add CU occupancy support to GFX12.1

David Rosca (1):
      drm/amdgpu: Fix VCE 3 ring align_mask

Jesse Zhang (1):
      drm/amdgpu/userq: lock and validate wptr BOs before reading their GPU offset on restore

Linkai Gong (1):
      drm/amd/display: fix dc_lock leak on GPU reset error paths

Prike Liang (2):
      drm/amdgpu/mes: fix the inconsistent indenting for mes_userq_map()
      drm/amdgpu/userq: fix lock missing for userq fence error set

Srinivasan Shanmugam (2):
      drm/amd/display: Fix wrong bytes-per-pixel value for dml2_422_packed_10
      drm/amd/display: Fix redundant GPUVMEnable checks in dcn6 flip schedule

Sunday Clement (1):
      drm/amdkfd: Reject zero-sized AQL queue allocations after size halving

Timur Kristóf (2):
      drm/amd/display: Fix HPD consideration for VGA/LVDS connectors on DCE
      drm/amd/display: Log details when failing to register HPD IRQ

Vladimir Marioukhine (1):
      drm/amdkfd: guard against NULL restore_mqd in CRIU queue restore

Xiang Liu (1):
      drm/amdgpu: clamp the isolation index for rings outside a partition

Xiaogang Chen (2):
      drm/amdkfd: Fix error path at svm_migrate_copy_to_ram
      drm/amdkfd: Fix the case that vm range is hole at svm_migrate_copy_to_vram

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c | 148 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c | 150 ++++++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   | 150 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  24 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  20 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   3 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  10 ++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  56 +++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   8 +-
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |   4 +-
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c     |  15 +--
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |   2 +-
 19 files changed, 569 insertions(+), 50 deletions(-)
