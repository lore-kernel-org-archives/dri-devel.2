Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FF606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xSp4ypPi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD9210E140;
	Thu, 19 Nov 2026 19:39:05 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A597110E140;
 Thu, 19 Nov 2026 19:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZoua+TffUhOm9dmmKcAySwdYgKV1zWICtoenLjDQ8kvoJRFM0ON7AA2RxvuIPJ5KdqWsGndoBnH1tXcbaCvnLMG2KOBYWp7HUpKvsEOir4LpwnjMdZAVuA1RRDLFIuCs9GPwD4KQ4jHC2Eji5kKR2hMXqIAwSek9Xc/9IkOQj9MHFaScVYdYkZ1beOGA++iexGl13DeUeflomQis9LkZiZLEjFQaYkaKG+OXdpn59NBjxeIscMDTGo51ro3IqjTQe7++X3WRHlD4X4ul/i5/gAxaeaq+kojT4SvoxUIn1Kt1xXBkN1WWf4VrjOIjrYc47Org2Dl5MsDRara2dNHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pFEW/SdWCHMsvPci+cfI515JckE3eyhdoR65VjUTEo=;
 b=brDtV2IPKjymcaAbOVzqkjJhYkccar0JvQRVv0me0meDjAcNlQh/pOqaPcnnl4ePpjDWFhXKY5TM5LUujRYDmUAXn2c3zzgx80Vmw749D4EsOX5vA6cASfvlMoWz4i5sH+Og9JOeiohIvpHu4YWRar0RQkvDruGLEfh8k9ROZ59VQNl74dJIYAj4S7wsxxlIvQ56wX4zKnQ00l6Ovb+aLb3ZiE9Fb9U0n6bPhq/DpD3/fRb6saewyF4ha10+VjHSH097Ljr9HlYDKv8faSmkIwAP16qDHM83oShVRPXVNkIabZd+xpKUzs8GJKziGCo73UPXWkUOR1Ur2BxHtz/hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pFEW/SdWCHMsvPci+cfI515JckE3eyhdoR65VjUTEo=;
 b=xSp4ypPiwv8Fn6IXQbFuyToG6yIPj2Zs7B7mbtHQFbNc2JoXHvjSJX2moe4L1b7+txM7JknCsGQ8BgktvDGdmHxIo4hbF80QwfUlQyP+2I+tm52nGwYGKgmzsXBWFm9BlSWLEYvzt5VlNFLAEZCdp1EfUXIHpQaLtCtuzU6CXh8=
Received: from BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 19:38:52 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::a4) by BL1PR13CA0197.outlook.office365.com
 (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.6 via Frontend Transport; Thu, 19
 Nov 2026 19:38:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:38:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:38:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:38:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:38:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-fixes-7.4
Date: Thu, 19 Nov 2026 14:38:42 -0500
Message-ID: <20261119193843.217794-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 67616eeb-d1db-4d50-14c0-08df4674bd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|13003099007|56012099006|11063799006|261026140227099003|261026121527099003|261022105027099003|10067099003|261022075727099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: ngec//+wyl4SZjJOm+lK/pRd66cXRjYO6vXL84AUnzcdaago0Qy0UFmoVR8PKQzylD8xCQbCPU/QPDY5/8T3rGYCL5QOyZV978Bfa7PSkkcHvC91kw0ULYhlzCb5yElSVNXeocpHZn7+fUo5LFwMa+Q0yjUZE/srAmtnWZomKEiETbXfIygbOORGBpIqJ9LRDOu/xVCD+GBNPVWeowPQuaR19hCs9Gl9dADoDtzGjoqChoIBkMs1/rzed1rm1DrFBmY25joZCXl6pIECGWMlVI8uVFLNJd4+oSb+V/bREjNdVbBRHb/eOX+Ch6Xh8Q5NXBesibvOSP8wWXGOpsYFApWrf9b4uKkLX7jF4MGk1rG1st7bbKGT3GfpmUdQZUw9FkJcVznipWgR0P3iqVg6c0J/ufkubILhq50J/golfWLd/jITOBWjZUo4pHmSSa+BUYQeW/N4YsA97lw0t4WwndfqHoaXCnJamLhGlQcXsmUNqC1MClpdJNjuW72D0eNSKCFm34dj0J6JFJ89B3O3KLf5AH0S156wK+82fq1vZMMjOdzHvIOEZIYuOfH+eC2sJs6iM/g+REJg/zfb8yu8MBWxTqvgSKBlnBnzhc0VAcO81QplUH4pubcrEDddC9FSWmzWIFZ3k7tqxXhL9F3b6Smys4kG4Pih9cPyP9MrBpM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(13003099007)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZMQLzfa0s2UBaFwR4yJDvi2Ukc2kNEoqJUuCPA15U2gvsHokOzAoM3Hk1PQSMuHIRe0Mh6h3J3p7F6ULmhD10GBRxErrcs5v6nlGWVrtizfo7YdIzhJ4VFM7wSIhBxKM4iEod3/H7Rh/i5fCAG+09zVoNcBc3KUUyl64A/tXIn1zXARXHJy7STIelEle8af3f48hMZuvXcaOCDBhL0TE8pRhDvDqPdVCwLWjdZlmWW4RA6cLdj7zKLpHN0djcd/5I533p/LwN6Q8/sZFlT88z4w4ZSrT+k5FpZpHrOBLjZ8mE5EsbLalUlD+s7vOgU2FNRXkkIoLDR1bcK/Y0bNMSxyziwCLUVHCso1I7nQaFkjJjyo+O3bQN0yJq3iG2yhAsmef5hn5GkXmF1J5dVwAFBYF7VWLpfPgY3y7lD1zT+/FQBGbXlxM0ik0DMXYTBT6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:38:51.9431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67616eeb-d1db-4d50-14c0-08df4674bd88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Simona,

Fixes for 7.4.

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.4-2026-11-19

for you to fetch changes up to b99cc7665fc83c0418a5f0d4af59ea120de84e38:

  drm/amdgpu: bypass IMU ucode loading for GC 11 APU (2026-11-18 12:19:24 -0500)

----------------------------------------------------------------
amd-drm-fixes-7.4-2026-11-19:

amdgpu:
- GPUVM fixes
- SMU 8 fix
- PCO quirk
- ATPX lifetime fix
- Unwinding fix for module loading failure
- UserQ fix
- HDMI fixes
- DML2 fix
- DC DRAM config fixes
- DCN 4.2 fixes
- DC pre-OS clock handling fixes
- DPMS fix
- Cleaner shader fixes for multi-XCC parts
- Vblank fix for GPU resets
- Properly handle firmware with different trust athorities
- Freesync/VRR fixes
- Backlight fix
- Display warning fixes
- PSR fixes

amdkfd:
- SVM fixes

radeon:
- Bounds checks in vbios parsing
- ATPX lifetime fix

----------------------------------------------------------------
Abdulla Bubshait (1):
      drm/amd/display: Abort DPMS ON when enabling the link fails

Adrian Betschart (1):
      drm/amd/display: Apply the HDMI RGB range default only to HDMI signals

Allen Pan (1):
      drm/amd/display: Update DCN42B stutter latency to match DCN42

Andrey Misiurov (1):
      drm/radeon: Bound GPIO I2C table entry count from VBIOS

Austin Zheng (1):
      drm/amd/display: Flip dml2_core_utils_get_segment_horizontal_contiguous() Inputs

Benjamin Cheng (2):
      drm/amdgpu: wait for tlb flush before freeing BO
      drm/amdgpu/gem: use dma_resv_add_fence directly

Christian König (1):
      drm/amdgpu: fix cleared PDE/PTE flag generation

Cooper Morgan (2):
      drm/amd/display: Saturate refresh rates in v1/v2 FreeSync infopackets
      drm/amd/display: Use FreeSync v3 infopacket for sinks above 255 Hz

Davey Hughes (1):
      drm/amd/display: Keep FreeSync flip timing across plane resets

Egor Perevoshchikov (1):
      drm/amd/display: Restore PSR-SU guard in power module

Erhan Bilgili (1):
      drm/amdgpu: Fix UserQ slot availability checks

Fangzhi Zuo (2):
      drm/amd/display: Move HDMI FRL Polling Outside dc_lock
      drm/amd/display: Stop HDMI FRL status polling on fini

Hugo Sales (3):
      drm/amd/display: Take every stream out of self-refresh before a modeset
      drm/amd/display: Add the AUX backlight minimum once on the custom curve
      drm/amd/display: Hold the VRR vblank reference only on active CRTCs

Jackie Liu (1):
      drm/amd/display: Fix logger leak on perf trace allocation failure

Jesse Zhang (2):
      drm/amdkfd: don't check the HMM range when getting its pages failed
      drm/amdkfd: keep the DMA addresses of a range intact if splitting fails

Jiaming Fan (3):
      drm/radeon: only unregister the ATPX handler if we registered it
      drm/amdgpu: only unregister the ATPX handler if we registered it
      drm/amdgpu: unwind module init on failure

Jing Zhou (1):
      drm/amd/display: Seed boot clocks to avoid lowering pre-OS display clocks

Joshua Horne (1):
      drm/amd/pm: send smu8 sclk level indices, not the level mask

Kent Russell (3):
      drm/amdgpu: Run shader cleaner on all XCCs on faults
      drm/amdgpu: Fix fault shader cleaner on MI3
      drm/amdgpu: Fix fault cleaner race condition

Mario Limonciello (1):
      drm/amd: Select the firmware signing scheme the PSP reports

Ovidiu Bunea (1):
      drm/amd/display: Add support for more PSP footer sizes

Paul Menzel (1):
      drm/amd/display: Don't warn about vendor infoframe for non-infoframe sinks

Prike Liang (1):
      drm/amdgpu: keep reading the vblank counter in IRQ context during reset

Qiang Han (1):
      drm/amdkfd: wait for the queue quiesce in concurrent SVM evictions

Suresh Guttula (1):
      drm/amdgpu: bypass IMU ucode loading for GC 11 APU

Thomas Lamprecht (1):
      drm/amd/display: Don't warn about links without an HPD GPIO

Wang Jiang (1):
      drm/amdgpu/gfx_v9_0: Add gfxoff quirk for Lenovo Picasso 318F

Wenjing Liu (1):
      drm/amd/display: Read DRAM channel width from SMU init table

 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  29 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  20 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |  35 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |  64 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  16 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |  98 +++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  16 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h            |   3 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |  17 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   8 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |  47 +++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h             |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |   2 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   7 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  67 +++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 154 ++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  19 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |   2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |   2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  19 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  14 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  90 ++++++---
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      | 214 +++++++++++++++++++++
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |   3 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |   4 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h  |   3 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  18 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   5 +-
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |   5 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |   4 +-
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |   8 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   2 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  41 ++--
 .../drm/amd/display/modules/freesync/freesync.c    |  12 +-
 .../gpu/drm/amd/display/modules/power/power_psr.c  |   9 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |  14 +-
 drivers/gpu/drm/radeon/radeon_atombios.c           |  22 ++-
 drivers/gpu/drm/radeon/radeon_atpx_handler.c       |  13 +-
 53 files changed, 1002 insertions(+), 192 deletions(-)
