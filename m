Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DFDCA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD1810E15D;
	Thu,  8 Oct 2026 21:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XAomnoyy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485B510E15D;
 Thu,  8 Oct 2026 21:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkUvJWILB2iwmJ3tvLYB8K+0EpYfTwZ4nEiYXD4wmqKjWbZhB0gprZQXPRNdWVWooTVkmc/ZycuB7Xg+gUMfPFY3CYyTNMPjXmKSzNzou5D5Qjt56z/q6wJc3b8BfR/LUW67lCl1P/8T7eziShPO+1FWi+AxAIGnPULqhHYxRgJLXq9ci0XiCx474NU4JqTA4qOVxO8AvAzkK65q4V2zxNT3IpSiSWH7J1K9GyPTgCAhnZHXxK21H6bO9AQBMQ/TME+YMEecG2pdcpgpiPZkk00WWf4KG0haZwFMvHPJTkzCM/2NdXTe2WbCi6h1ODYwFNduI5E/r5lScgSAxoqglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5AHxnVt6/E980bNxXkDIZYfjaWOV+3V3faTbP5uAZI=;
 b=GXjt0wfnktCWr6q08JP7FvTwbzsEUNDL1EjCkZbeva4assuopE1NFVB7G9rGtvsMUhF5lYrbQSO0ZluMHAf+ABtkO2IicX/+AWabUKaDwewjp6cbtJSwP9YD8bG4Zopa6rOUdWd1KGB6W6CQ6IJFe8w863EtXfKM4nwKLoefC2CTXtY8ICi2Yryw3Ay+mbfHrXqB4cs/GHDpUlRf2L0/k0EJ9wq3uYtl+yqU8Vlcz36N5RTax+VaPLZidva10NVVRaa3vk8dIBdlZUB/Troxix/JsJEHc4Szlb0c4G/Vn2/p3eIGcdLgyTW49yFeM9l9SueB1XCrDvKNWmGrvcPmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5AHxnVt6/E980bNxXkDIZYfjaWOV+3V3faTbP5uAZI=;
 b=XAomnoyyZ9dj5jxH2QTH5JQfqg7vfEMm32lHhXUIvBarOiWKKB8jFcuCO7QO/tuyCB4yaiJwUmoiM1eh9DL10OJdsAeXuDJ+H2xWZOY1j3VM9l+6CoRFEJu8TdbbP+1MGwvXmLCaTEst3VAjaeRbtioCWqy0fj6/KFXDHres1kQ=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 8 Oct
 2026 21:23:39 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:39f:cafe::56) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 21:23:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Thu, 8 Oct 2026 21:23:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 16:23:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 16:23:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 16:23:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.4
Date: Thu, 8 Oct 2026 17:23:10 -0400
Message-ID: <20261008212310.2508510-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 823192c3-3cfb-40cd-008e-08df25826b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|56012099006|260925021311599003|260925022911599003|260925021911599003|13003099007|6133799003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: OgVy449n5kIJL2eRsNkWKmCDuTO2mfkLMe0mnYunjQCe5dcnsbRLcCipu6RkbWaf84i/JK071Tjg4kp+RdVZI3mPU/+VB/27/6RLMYhDCCf6yihytAIRmPblKRE7sYg59kQKzroY0Zw0tCM4cmpcen5SUWnf75dZV0bCRD3h95XgWPELrniQLhAFh79vc/ZGHeGMu8jbrRR3W7aQoZulyiy7sz9asl9/jC2ECOgvEjMobGluMSwd1m5g7X0zIHlSve4oTefmimfvE6uaZ1QDb3acNHyCsyOJeOTLHdfRbx701WN/yOGopoo/NX1KPwK702VzyLp0rz393+8xQeRFbLt2KMuak44d1DLYOes2tIRDyB2JDqZfI7HE0WEO6ih+9XVwKaWItFoF/Zbx5sTcG7J3+C3Hj/FQdQ5n7uxoMu6CYil02yexzU6cl40quW1vU8Oj+Ad89zg0TJHsEwdomvn6SHta9yxnZJ9aW/HL+cXbc7YODpbrlwEWC7pqRrAUqSimwGrQ+bq26Qa7wFu66yWw053lFJ+p4st5v6tGWaKXJAkIoc8ThhDTRiRZLA3/GOgoqA3BOHgFL25CGkkHW7TRuvsr0qi22qSqueOk+pmCApr+l2hH6bbfvUSjXcfYjaDapRhLJiYjmdj4q6ukPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(13003099007)(6133799003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XMRjPcpdTl5EAjix8hU1+qPBiXBroIi03yvC7y5p3uV+moKzvwOBOsZRSlk9ze3ylaYykqflLVUpAD++P7zE/jtcvXnFPsFjPhOWNJ1ij3k1i5v6h63iuRMZCCkBRW6HAbbRlFmBar7tjhrTJ5WXHXxQqNCiioBO32235PD83iG2F446XJ0TpL4Tl5vmsekerU4U9KpDpRc4LXIRtNHONFgzbbLZ3aA/BqZ/BGRU+qW+Jh2FAgaMVlWV214RHQkQimdHiPxzJPXUSo5SOoJsy1hQxd2dShZuArbYHPayzUpbtXaNYLmcSrrvDFGU6O7msdIDGDdJ6rK9iN0xyibg7oZqdHQXIVO5V+Y9dBrbAQliqjuQUBfGFQrjBCiBF1pG0ARpmYbPYsTDcQlL64YnwUDTobx92vMzm1ag/5nkHhywRCRGGi5bGpW/D0YYKXfb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 21:23:39.0008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823192c3-3cfb-40cd-008e-08df25826b9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

A few last odds and ends for 7.4.  Mostly bug fixes.

The following changes since commit 41505ac433cc4c5179deee8860d197b04f6d1c1d:

  Revert "drm/amd/display: Attach blend mode property for alpha planes" (2026-10-02 11:59:18 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.4-2026-10-08

for you to fetch changes up to c54e4d10507722398dc90cf3c532e50b86cf425a:

  drm/amdgpu: make Mac FB workaround generic (2026-10-07 12:16:21 -0400)

----------------------------------------------------------------
amd-drm-next-7.4-2026-10-08:

amdgpu:
- Fix direct scanout alpha on some DRM_FORMATs
- UserQ fixes
- Fix for PSR with tearing flips
- GPU reset vblank fix
- Debugfs register interface fix
- Fix mode patching
- Expand Mac reserved memory workaround
- GC 12.1 fixes
- Clean up MES/HWS vmid mask handling
- Make runtime pm more fine grained
- A+A SPM fixes
- SR-IOV fixes
- 3D LUT fixes
- HDMI fixes
- DCN 4.2 fixes
- HDMI VRR fixes
- DC tracing fixes
- UALink fixes

amdkfd:
- SDMA doorbell fix
- Fix dma-buf reference leak in error path

----------------------------------------------------------------
Adrian Betschart (1):
      drm/amd/display: Don't replace a sink mode that shares the native totals

Alex Deucher (1):
      drm/amdgpu: make Mac FB workaround generic

Allen Li (1):
      drm/amd/display: Skip link off frame count for general UI

Alvin Lee (3):
      drm/amd/display: Set cursor_offload for all pipes for a given stream
      drm/amd/display: Assign alt wa bit in fams2 cmd
      drm/amd/display: Add debug option to override low power SR latencies

Aric Cyr (1):
      drm/amd/display: only reprogram DRR when v_total values change

Ashwin Santhosh (1):
      drm/amd/display: Promote DC to 3.2.401

David Carlier (1):
      drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink import

Dillon Varone (1):
      drm/amd/display: Add dcn42b project id

Haojie Li (1):
      drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info

Harry Wentland (2):
      drm/amd/display: enable shaper when programming 3DLUT
      drm/amd/display: log MCM shaper and 3D LUT mode in the DTN log

Ilya Bakoulin (1):
      drm/amd/display: Add HDMI RR and SCDC skips

Ivan Lipski (1):
      drm/amd/display: Send HDMI VRR metadata in VTEM info packet slot

Jesse Zhang (2):
      drm/amdgpu/userq: only accept doorbell BOs as queue doorbell
      drm/amdgpu/userq: return the memdup_user() error for the user MQD

Joshua Aberback (1):
      drm/amd/display: Revert "avoid to write signal specific for tmds"

Leo Li (2):
      drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs
      drm/amd/display: disable self-refresh on tearing flips

Martin Tsai (1):
      drm/amd/display: allow skipping link bandwidth clear

Mattia Tadini (1):
      drm/amd/display: only clear the hotplug sources the ASIC has

Melissa Wen (8):
      drm/amd/display: assign missing trace entry in amdgpu_dm_dc_clocks_state
      drm/amd/display: remove duplicated prev_p_state_change_support assignment
      drm/amd/display: fix vready offset assignment in dcn_optc_lock_unlock_state
      drm/amd/display: declare amdgpu_dm_atomic_state_template as an event class
      drm/amd/display: use right type for amdgpu_dc_performance event entries
      drm/amd/display: remove redundant cast on amdgpu_dc_reg_template printk
      drm/amd/display: copy function name into dcn_fpu trace event
      drm/amd/display: copy function name into dcn_optc_lock_unlock_state trace event

Mikhail Gavrilov (1):
      drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks

Mukul Joshi (2):
      drm/amdgpu: Add SOC_V1_0_DIE_REV_AID() helper
      drm/amdgpu: Use MTYPE_UC for ext-coherent local memory on AID A0 non-SPX

Pierre-Eric Pelloux-Prayer (5):
      drm/amdgpu: rework runtime pm management for cs
      drm/amdgpu: push down runtime pm handling in amdgpu_gem_create_ioctl
      drm/amdgpu: handle runtime pm in amdgpu_gem_userptr_ioctl
      drm/amdgpu: prevent suspend in fault handler
      drm/amdgpu: get rid of amdgpu_drm_ioctl

Rafal Ostrowski (2):
      drm/amd/display: Refactor DMUB fast lock sequencing
      drm/amd/display: Prepare DSC configuration before BLS execution

Relja Vojvodic (1):
      drm/amd/display: Update link training no timeout behaviour on HDMI

Saleel Kudchadker (1):
      drm/amdkfd: align SDMA doorbell base for shader doorbell writes

Sridevi Arvindekar (1):
      drm/amd/display: Handle virtual link encoder

Sunil Khatri (5):
      drm/amdgpu: move vmid_mask_gfxhub/vmid_mask_mmhub to vm_manager
      drm/amdgpu: fix the indentation of fault_info member
      drm/amdgpu: rename amdgpu_vmid_mgr to amdgpu_kq_vmid_mgr
      drm/amdgpu: add amdgpu_vmid_uq_mask_init() helper
      drm/amdgpu: exclude npa_vmid from the userq vmids too

Vitaly Prosyak (1):
      drm/amdgpu: serialize vblank counter reads against GPU reset

YuBiao Wang (2):
      drm/amdgpu: fix the unit of the SR-IOV IP discovery size check
      drm/amdgpu/gfx12: read xccs-per-xcp from RLC_IMU_AID_CONFIG for VFI

Zhigang Luo (6):
      drm/amdgpu: add SRAT lookup for GPU-local memory
      drm/amdgpu: add helper for VRAM in system physical memory
      drm/amdgpu: fetch the A+A VF VBIOS from the SRAT HBM range
      drm/amdgpu: take the A+A VF GMC aperture from SRAT
      drm/amdgpu: mark A+A VF VRAM mappings as system memory
      drm/amdkfd: mark A+A VF VRAM PTEs as system memory

 drivers/gpu/drm/amd/amdgpu/Makefile                |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           | 136 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h           |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  55 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  77 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h            |   6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |  36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c          |  45 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |  52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  13 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |  60 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |  17 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   9 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |   5 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h              |   2 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  32 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   7 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  28 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  21 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  26 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  22 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |  99 ++--
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  42 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 101 ++--
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  | 522 ++++++++++++++-------
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |   5 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  36 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   2 +
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |  12 +-
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |   1 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c   |   1 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |   1 +
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |   1 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |   1 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |   1 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c       |   1 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c  |   1 +
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |  48 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h   |  13 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c   |   1 +
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |  34 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h |   5 +-
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c   |  41 +-
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |   3 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  17 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  11 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |  14 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |  32 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h    |   2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |   2 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  99 ++--
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h    |  12 +-
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |   2 +
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |   2 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  67 +--
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |   2 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |   2 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |  16 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |   2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |   2 +-
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |  11 +-
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |   2 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h | 108 ++---
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  17 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |  17 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.h   |   1 -
 .../display/dc/link/protocols/link_dp_training.c   |  20 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |  12 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |  18 +-
 .../dcn60/dcn60_soc_and_ip_translator.c            |  39 +-
 .../drm/amd/display/include/link_service_types.h   |   1 +
 .../drm/amd/display/modules/power/power_replay.c   |   6 +-
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h |   2 +
 .../amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h    |   4 +
 104 files changed, 1555 insertions(+), 856 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
