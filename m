Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BC3C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE50010E4DB;
	Thu,  2 Jul 2026 14:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bgf/HTvR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5378F10E4DA;
 Thu,  2 Jul 2026 14:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtXTrkpssiSCpEVT8epM+0vgALn06j9hfHPa1dI1E4wNFjUZzoxdEhHI03N76N01Jywn8SgWYQKZeRLywjIVI8m1d++sAtoj8n5iqBMZeZBlQQDoP3QFw19dO7PwHULLCi7rdBJEHAUpgosvSoeiEnusMnxm6+ta8XgpMay9LggFuhJuaffk48BgoC7ejs2/TactIVdrL1rL90bhBm4GuyYjM7hr4CKEBDcWqtF5i/Ftvf8KK/ThfK35zs4rzTPdOjpvgT7NGdAPSK73AaUpjuNDkds83B95aajRcMl+1QqPMgWv6FjPFO+EFZSGAgvjPyLTV2SevkIDxw111KtQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNH0czc2mym+MXavfKb8MvRmq0iNPf604sTxfHNLIJg=;
 b=zMEq53jVxwL58/ng3Rsc39GOX7o6p4hu5ddj56bqJ3vAHixOR0P43NLF+zyjQwbTZ62R7L1mXIs+Xj0K81sAaBtPPHZ7zhiWnSU+P/xfHcZ6v6DKk43Ua0H3jP2nsiUNaQEoWriBI2ik7ZIkHdNrvoXVEhsR/19vhOyj8kkoaGkZrBFUc5JBJmY/NxBNZIB/7mrjXbYHfXGVz0rhgKezUsYNL6SGjvZ1lkyGdBcUB5QciqF4lBbstVJxCfO1CdnTSnvpo+XY87s7+3EwtkAuCezMmLcH42QnYnmYbS2nWvIH0+aQCmyKf2nwUF31wqeVm0yLejixxdUiO3TKfbdSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNH0czc2mym+MXavfKb8MvRmq0iNPf604sTxfHNLIJg=;
 b=bgf/HTvR2Wv6Km7XLWKPOLczH1CtOUnB9FZFsm4xkC0e7o+zfmxEMU+Id52aL/RMpr7jUycEjG5pXpRxQWInQ3WVhUwwrjXMednTR38z3soaYLlfNA+/n+Rq8KyRBCWdkUUi24YNOHlOQ6RVjFp4XM4Pc80SuhO6VBYMANiIRMw=
Received: from DM6PR02CA0109.namprd02.prod.outlook.com (2603:10b6:5:1b4::11)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 2 Jul
 2026 14:15:25 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::75) by DM6PR02CA0109.outlook.office365.com
 (2603:10b6:5:1b4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 14:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 14:15:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 09:15:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 09:15:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.3
Date: Thu, 2 Jul 2026 10:15:15 -0400
Message-ID: <20260702141515.67919-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 7685afc9-4731-4049-53a2-08ded8445ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|6133799003|13003099007|11063799006|3023799007|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: hq/8Wof+9ardetFD+QJ9Qksob/DNYJsEAk+vJp7yXlZoKtZCOfyoYUg+b3DudBzGgydKM2fUZqYc5+fObjaddxUx7G3bqXUDkIVFZKmPH0AbYPH9NgdI19IINaC0Iy09Sw1qyYkUVVJT644cDGx9+K+ACnh2eckKeOYNLAtt4WNWDx5zzxluExQ3rN1sWjRJqRWB0OSyECJysl0stAn2udtiY5FeNqs/AuZkrfbqn0yMRonJ7Le0WPQxDWmlfR7MhcEctnyhdz8TU5DPP681LQKQcMlpbw+Hb1RCyk/shnR7lZUxwh3u+OBRh4KaicMDkk48hMdb0NkDmKtbR4hPxOaJRPShtkWvK9bQpFXZz2gRJnoGKvb8FfUhs51FVOtW36HZZMWHIe0/riWWqZ8AuKhaOodREUygSbMoWbQVz+IlRqRVOHDYVAPaJkl5ae8kSDf2JnJAKhmDXYCCCNJarSlIgFsRxBjfKEgAZRBBvgHGWmkbuviR7Xj5m37OpXXSsyXQh6xIJ8sxrsnPhNzsIal5h8ow989vVrBZ2geii1apa04xF/jCcfJYsTKMzjsNZb0r+A2ZDMTtGULM7KHUv2w5/Yh+Imkeswp3rsZlQCqhswToPye6J7zYOw65nHwi0D3+riijmR0v2oVyRG6bOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(6133799003)(13003099007)(11063799006)(3023799007)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VVtRjOqzHMsx7D3iJCZpoJcQmJl5fAo+dk/KVpsmdvsHBLPSfhLedf26Cl5Xx+IUTler7agiPZYl7S6CFWkY25ewVpTM/tPg5Wa1f6OA+xTP+H/7tX1IExF90A/E0Vp2K3WVlRXsBcXDY3cx05JcuQ7p+yhk+VpZdsf77ZzzQLXMbQTcPjgUS//Q4MK7aMJerlL5VMyrTOGqevCZr6StdT6H2eVXpp/558CrH6A+uPt62KKZYxF99IB8ZmOgsd8+nJ1XN5loUD8Kbh3SXO2Vyrj/LikS78ouaFV6Wwtl4zBx1pIhUaJPK0nwK8jpaG4SiufiFjLYtFZ/qbfDNuYxMp9vjLvBPZiJLCPd06h0NMyM7O0D6Me3ICmxAkwPMFmiGENd2I5btEkXVO/yq2hUdJV0G2fvq1CTzsTR25YV9ucGHoi36GvrQQ+goE9vnHhq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:15:25.6233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7685afc9-4731-4049-53a2-08ded8445ca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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

New stuff for 7.3.

The following changes since commit 52d4ab1ca790a668cc8f2c27017138b1c467168c:

  Merge tag 'drm-misc-next-fixes-2026-06-11' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next (2026-06-13 08:10:38 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-07-02

for you to fetch changes up to 50be7c9b5d5ea55fd40bb411cf324cec99ec7417:

  drm/amdgpu: Do not fiddle with the idle workers too much (2026-07-01 11:56:47 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-07-02:

amdgpu:
- Queue reset updates
- Initial compute pipe reset support
- Improved boundary checking for bios parsing
- Cleaned up sysfs input parsing
- devcoredump fixes
- RAS updates and rework
- VCN secure submission fixes
- 8K panel fix
- Add display KUnit tests
- Display CRC fixes
- UserQ updates
- Backlight fixes
- Parse panel type info from DisplayID
- Align IP discovery to pci device lifetime
- IOCTL boundary check fixes
- Convert amdgpu_vm_lock_by_pasid() to drm_exec
- Ctx fixes and cleanup
- SOC15 register macro cleanups
- Memory placement fixes for UVD
- Disable KQ support for MI3xx
- GFX9 mode2 reset fix
- BO list cleanup
- Soc24 aborted suspend fix
- Gfx8 soft reset rework
- Enable soft reset on gfx8
- Drop unnecessary BUG() and BUG_ON() in error paths
- Fix power reporting unit conversion
- Improve vbios command table bounds checking
- UVD bounds checking improvements
- VCN bounds checking improvements
- PSR and replay fixes
- DCN 4.2 updates
- Colorop updates
- DC GPIO rework
- ACP fixes
- Fix aperture mapping leak
- Ignore_damage_clips fix
- Fixes for non-4K pages
- JPEG idle check fixes
- Userptr fixes
- GPUVM fixes
- GC 11.7 updates
- SMU 13 fixes

amdkfd:
- Initial compute pipe reset support
- Allow applications to opt out of sigbus on fatal errors
- Fix doorbell/mmio BO cleanup
- Improved CRIU boundary checking
- MQD handling rework
- SMI fixes
- Reset event fixes
- CRIU fixes
- Sysfs teardown fixes
- IOCTL boundary check fixes
- SVM fixes
- Soft IH ring fixes
- Move TBA/TMA from system to device memory

radeon:
- Blit fix for large BOs
- r600 dpm cleanup fix

drm:
- Extract EDID base section header processing into helper
- Parse panel type from DisplayID 2.x Display Parameters

UAPI:
- KFD interface for applications to select sigbus behavior on fatal errors
  Proposed userspace: https://github.com/ROCm/rocm-systems/pull/6190

----------------------------------------------------------------
Alex Deucher (56):
      drm/amdgpu: don't reemit if there is nothing to reemit
      drm/amdgpu: track guilty fence for queue reset
      drm/amdgpu/fence: add helper to extract the guilty fence
      drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit() handle NULL fence
      drm/amdgpu/vcn: handle pipe reset more gracefully
      drm/amdgpu/sdma: handle pipe reset more gracefully
      drm/amdgpu/mes12: use proper grbm_select function
      drm/amdgpu/gfx11: only need to remap KCQs when reset via MMIO
      drm/amdgpu/gfx12: only need to remap KCQs when reset via MMIO
      drm/amdgpu/mes11: move pipe reset to mes use_mmio patch
      drm/amdgpu/mes12: move pipe reset to mes use_mmio patch
      drm/amdgpu/mes: add userq reset helper
      drm/amdgpu/mes: add a MMIO queue reset helper
      drm/amdgpu/userq: split the queue reset from adapter reset
      drm/amdgpu/userq: add per queue reset callback
      drm/amdgpu/userq: add mes userq reset callback
      drm/amdgpu/userq: switch to per queue reset
      drm/amdgpu/userq: drop detect_and_reset callback
      drm/amdkfd: rework MES queue reset sequence
      drm/amdgpu/gfx: add a helper for MQD restore
      drm/amdgpu/gfx11: use the new MQD helper for queue reset
      drm/amdgpu/gfx12: use the new MQD helper for queue reset
      drm/amdgpu/gfx11: unmap the queue via MES on reset for MMIO path
      drm/amdgpu/gfx12: unmap the queue via MES on reset for MMIO path
      drm/amdgpu: store whether to use MMIO or MES for reset
      drm/amdgpu: Use a common KGQ and KCQ reset helper for gfx11/12
      drm/amdkfd: split out mes queue reset sequence into standalone function
      drm/amdkfd: plumb a helper to reset a KFD user queue
      drm/amdgpu/userq: add MES userq reset helper
      drm/amdgpu/gfx: add a common helper to handle MES compute resets
      drm/amdgpu: use a single entry point for mes compute reset
      drm/amdgpu/mes11: enable compute MMIO pipe reset
      drm/amdgpu/mes12: enable compute MMIO pipe reset
      drm/amdgpu: remove spurious line in amdgpu_ring_find_guilty_fence()
      drm/amdgpu/jpeg: add flags for disabling KQs/UQs
      drm/amdgpu/jpeg4.0.3: add support for disabling kernel queues
      drm/amdgpu/jpeg5.0.1: add support for disabling kernel queues
      drm/amdgpu/vcn: add flags for disabling KQs/UQs
      drm/amdgpu/vcn4.0.3: add support for disabling kernel queues
      drm/amdgpu/vcn5.0.1: add support for disabling kernel queues
      drm/amdgpu/sdma4.4.2: add support for disabling kernel queues
      drm/amdgpu/gfx9.4.3: add support for disabling kernel queues
      drm/amdgpu/gmc9: make all vmids available to KFD if KQs are disabled
      drm/amdgpu/gfx8: drop unecessary BUG_ON()
      drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx9.4.3: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12.1: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma4.4.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma7.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma7.1: replace BUG_ON() with WARN_ON()

Alex Hung (42):
      drm/amd/display: Fix writeback format loop and variable init
      drm/amd/display: Add KUnit tests for writeback connector
      drm/amd/display: remove redundant code in amdgpu_dm_replay
      drm/amd/display: Enable warnings as errors for KUnit tests
      drm/amd/display: Remove dead code in dm_dp_mst_get_modes
      drm/amd/display: Add KUnit tests for amdgpu_dm_mst_types
      drm/amd/display: Fix incorrect logic in CRC source handling
      drm/amd/display: Extract DPRX CRC transition helpers for KUnit testing
      drm/amd/display: Extract HDCP testable helpers for KUnit
      drm/amd/display: Remove duplicate pp_rn_set_wm_ranges
      drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu
      drm/amd/display: Extract backlight code to amdgpu_dm_backlight
      drm/amd/display: Extract audio code to amdgpu_dm_audio
      drm/amd/display: Extract DMUB code to amdgpu_dm_dmub
      drm/amd/display: Move HPD and IRQ handler code to amdgpu_dm_irq
      drm/amd/display: Extract connector and encoder code to amdgpu_dm_connector
      drm/amd/display: Add KUnit tests for amdgpu_dm
      drm/amd/display: Add KUnit tests for amdgpu_dm_backlight
      drm/amd/display: Add KUnit tests for amdgpu_dm_audio
      drm/amd/display: Add KUnit tests for amdgpu_dm_dmub
      drm/amd/display: Add KUnit tests for amdgpu_dm_connector
      drm/amd/display: Add KUnit tests for amdgpu_dm_irq
      drm/amd/display: Add KUnit tests for amdgpu_dm_crtc
      drm/amd/display: Add KUnit tests for amdgpu_dm_services
      drm/amd/display: Add KUnit tests for amdgpu_dm_helpers
      drm/amd/display: Add KUnit tests for amdgpu_dm_quirks
      drm/amd/display: Add more KUnit tests for amdgpu_dm_pp_smu
      drm/amd/display: Add more KUnit tests for amdgpu_dm_mst_types
      drm/amd/display: Move backlight macros to backlight header
      drm/amd/display: Remove redundant IPS mode case for DCN 4.2
      drm/amd/display: Extract backlight helpers for KUnit tests
      drm/amd/display: Add more KUnit tests for amdgpu_dm_colorop
      drm/amd/display: Simplify boolean checks
      drm/amd/display: Simplify DMUB notify registration
      drm/amd/display: Fix KUnit test crash after global alpha change
      drm/amd/display: Add KUnit test for amdgpu_dm_wb
      drm/amd/display: Add KUnit tests for amdgpu_dm_replay
      drm/amd/display: Add KUnit tests for amdgpu_dm_psr
      drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu
      drm/amd/display: Add KUnit tests for mst_types
      drm/amd/display: Extract shared KUnit test helpers
      drm/amd/amdgpu: Fix stack frame size warnings in KUnit tests

Alvin Lee (1):
      drm/amd/display: Update LSDMA commands to explicitly handle DCC fields

Amber Lin (17):
      drm/amdgpu: Allocate enough space for hpd info on gfx11
      drm/amdgpu: Remove faulty queue before resume
      drm/amdgpu: Expand MES queue/pipe reset support
      drm/amdkfd: Pass known bad queue info to reset
      drm/amdkfd: Clean up suspend_all and resume_all mes
      drm/amdkfd: Fix reset event signal
      drm/amdkfd: Add gfx11 queue/pipe reset support to topology
      Revert "drm/amdkfd: Add gfx11 queue/pipe reset support to topology"
      drm/amdkfd: Add queue reset support on gfx11 dGPU
      drm/amdgpu: Add gfx12.0.1 adev to queue reset support
      drm/amdkfd: Add queue reset support to gfx12.0
      drm/amdkfd: Limit queue reset support on gfx9
      drm/amdkfd: Disable queue reset on gfx11 SR-IOV VF
      drm/amdgpu: Fix mes remove_hw_queue lock
      Revert "drm/amdkfd: Add queue reset support to gfx12.0"
      drm/amdkfd: Add gfx12.0 queue reset support to topology
      drm/amdgpu: Fix false error return to non-KCQ

Andrew Lichmanov (1):
      drm/amd/display: Disable mem gating for DCHVM on DCHVM init

Andrew Martin (1):
      drm/amdkfd: Fix SMI event PID reporting for containers

Antonio Quartulli (1):
      drm/amd/display: fix compressed buffer config routine waiting time

Arnd Bergmann (1):
      drm/amd/display: avoid large stack allocation in commit_planes_do_stream_update_sequence

Asad Kamal (12):
      drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
      drm/amd/pm: Validate OD DPM triples before mutating tables
      drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
      drm/amdgpu: validate XCP topology counts before division
      drm/amdgpu: guard zero divisors in soc_v1_0 partition code
      drm/amdgpu: fix aperture mapping leak
      drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop and OOB read
      drm/amdgpu/pm: add pp_entries_max() helper
      drm/amdgpu/pm/powerplay: clamp Tonga/Polaris PP sub-table ucNumEntries
      drm/amdgpu/pm/powerplay: clamp Vega10 PP sub-table ucNumEntries
      drm/amdgpu/pm/powerplay: bounds-check voltage index in SMU7 lookup
      drm/amdgpu/pm/powerplay: bounds-check voltage index in Vega10 lookup

Austin Zheng (4):
      drm/amd/display: Deprecate DMUB register offload functionality
      drm/amd/display: Allow Per-DPM De-rates Instead Of A Single Global Value
      drm/amd/display: Add Debug Option To Enable Per-DPM De-rate Usage
      drm/amd/display: Revert "Add Debug Option To Enable Per-DPM De-rate Usage"

Bhawanpreet Lakha (1):
      drm/amd/display: Add kunit tests for amdgpu_dm_plane

Bhuvanachandra Pinninti (2):
      drm/amd/display: Cleaned up headers
      drm/amd/display: Add block sequence support for bandwidth programming operations

Boyuan Zhang (5):
      drm/amdgpu: fix division by zero with invalid uvd dimensions
      drm/amdgpu/vcn4: avoid rereading IB param length
      drm/amdgpu/vce: fix integer overflow in image size
      drm/amdgpu/jpeg: fix jpeg_v5_0_1_is_idle detection
      drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection

Candice Li (2):
      drm/amd/ras: sleep on PMFW EEPROM busy in bad page count query
      drm/amd/pm: sleep on PMFW EEPROM busy in bad page count query

Ce Sun (45):
      drm/amdgpu/ras: Parse all deferred errors with UMC aca handle
      drm/amdgpu/ras: added RAS EEPROM device support check
      drm/amdgpu/ras: Add flag to make VBIOS read optional
      drm/amdgpu/ras: Add address sanity check for uniras
      drm/amdgpu/ras: Estimate RAS reservation when report capacity
      drm/amdgpu: fix resource leak on ACP reset timeout
      drm/amdgpu: invoke pm_genpd_remove() before freeing genpd
      drm/amd/ras: add set_debug_mode function for uniras
      drm/amdgpu: Retire legacy page retirement RAS code
      drm/amdgpu: Drop legacy ACA log RAS error data code
      drm/amdgpu: retire ACA support for jpeg v4.0.3
      drm/amdgpu: retire ACA support for vcn v5.0.1
      drm/amdgpu: retire ACA support for jpeg v5.0.1
      drm/amdgpu: retire ACA support for vcn v4.0.3
      drm/amdgpu: retire xgmi v6.4.0 ACA support
      drm/amdgpu: retire gfx v9.4.3 ACA support
      drm/amdgpu: retire sdma v4.4.2 ACA support
      drm/amdgpu: re-set ClearMcaOnRead CE/UE in late init for uniras
      drm/amdgpu: retire umc v12.0 ACA support
      drm/amdgpu: retire funcs for generating legacy cper record
      drm/amdgpu: retire pcs xgmi v6.4.0 legacy ras support
      drm/amd/pm: retire aca smu backend support for smu
      drm/amdgpu: retire mmhub v1.8 ACA support
      drm/amdgpu: retire legacy RAS reset/query operations for sdma v4_4_2
      drm/amd/pm: retire smu_13_0_6 mca dump support
      drm/amdgpu: retire legacy ACA support
      drm/amdgpu: retire MCA support
      drm/amdgpu: retire RAS error count query/reset for gfx_v9_4_3
      drm/amdgpu: retire legacy RAS reset/query operations for XGMI v6_4
      drm/amdgpu: retire legacy RAS reset/query operations for mmhub v1_8
      drm/amdgpu: add the macro definition of UMC_V12_0_PER_CHANNEL_OFFSET
      drm/amdgpu: retire legacy RAS reset/query operations for umc v12.0
      drm/amdgpu: remove interface for updating umc v12_0 ecc
      drm/amdgpu: Remove the legacy bad page retirement
      drm/amdgpu: remove legacy UMC v12_0 error address
      drm/amdgpu: remove operations related to legacy address
      drm/amdgpu: retire legacy PMFW eeprom RAS bad page handling
      drm/amdgpu: retire legacy PMFW bad page loading in page
      drm/amdgpu: retire legacy PMFW RAS eeprom write skip
      drm/amdgpu: retire legacy ras_eeprom_read_idx interface
      drm/amdgpu: retire legacy MCA IPID parse global interface
      drm/amd/pm: retire legacy pmfw eeprom feature check
      drm/amdgpu: retire legacy pmfw eeprom check
      drm/amdgpu: retire legacy pmfw eeprom init
      drm/amdgpu: retire legacy pmfw eeprom reset

Chandana G B (1):
      drm/amd/display: Fix intermittently CRC open failure during active rendering

Charlene Liu (2):
      drm/amd/display: fix max dispclk_khz/dppclk_khz double 1000
      drm/amd/display: remove dead code related to forcevrr

Chenyu Chen (4):
      Revert "drm/amd/display: Use handle_hpd_irq_helper for HPD RX"
      drm/edid: extract base section header processing into helper
      drm/edid: parse panel type from DisplayID 2.x Display Parameters
      drm/amd/display: use DisplayID panel type in dm_set_panel_type

Christian König (2):
      drm/amdgpu: move suballoc defines into own header
      drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx

ChunTao Tso (1):
      drm/amd/display: TEST_HARNESS FSN could be 0

David Francis (2):
      drm/amdkfd: Properly acquire queue buffers in CRIU restore
      drm/amdkfd: Use kvcalloc to allocate arrays

Donet Tom (1):
      drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K systems

Eric Huang (4):
      drm/amdkfd: add sdma queue counter for gfxv9.4.3
      drm/amdkfd: avoid PTL confused warning message
      drm/amdkfd: avoid race condition of mqd when reading sdma counter
      drm/amdkfd: add sanity check in svm_range_is_valid

Ethan Nelson-Moore (1):
      drm/amd/display: remove check for nonexistent CONFIG_HAVE_KGDB

Evgenii Burenchev (3):
      drm/amd/display: Fix dangling pointer in plane reset function
      drm/amd/display: Fix dangling pointer in CRTC reset function
      drm/amd/display: Fix dangling pointer in connector reset function

Fangzhi Zuo (1):
      drm/amd/display: Add Support for HDMI Compliance Automation

Gabe Teeger (3):
      drm/amd/display: Increase dcn42b uclk value
      drm/amd/display: Enable pstate for DCN4 non-emulation builds
      drm/amd/display: Enable PSR and Replay on DCN4 variant and fix AUX instance

Gangliang Xie (2):
      drm/amdgpu: add buf length check
      drm/amdgpu: add check for xcp id

Geoffrey McRae (3):
      drm/amdkfd: Fix NULL deref during sysfs teardown
      drm/amdgpu,amdkfd: correct setting MES queue type
      drm/amdkfd: use amdgpu ring types for MES queue

George Shen (1):
      drm/amd/display: Add flag to disable dynamic expansion for 12bpc

Gerhard Schwanzer (1):
      drm/amdkfd: Use exclusive bounds for SVM split alignment checks

Granthali Vinodkumar Dhandar (2):
      drm/amdgpu: add support for GC IP version 11.7.0
      drm/amdgpu: add support for GC IP version 11.7.1

Guilherme Ivo Bozi (9):
      drm/amd/display: add GPIO HW translation helpers
      drm/amd/display: convert dcn10 GPIO translation to lookup tables
      drm/amd/display: convert dcn20 GPIO translation to lookup tables
      drm/amd/display: convert dcn21 GPIO translation to lookup tables
      drm/amd/display: convert dcn30 GPIO translation to lookup tables
      drm/amd/display: convert dcn315 GPIO translation to lookup tables
      drm/amd/display: convert dcn32 GPIO translation to lookup tables
      drm/amd/display: convert dcn401 GPIO translation to lookup tables
      drm/amd/display: convert dcn42 GPIO translation to lookup tables

Harish Kasiviswanathan (1):
      drm/amdgpu: Fix kernel panic during driver load failure

Harry Wentland (5):
      drm/amd/display: drop redundant colorop type and TF checks
      drm/amd/display: split TF/LUT colorop state lookups into separate upfront phases
      drm/amd/display: clamp DMUB AUX reply length to payload buffer
      drm/amd/display: guard against overflow in HDCP message dump
      drm/amd/display: hold a vblank ref while writeback is pending

Honglei Huang (1):
      drm/amd/display: use kvzalloc to allocate struct dc

Ivan Lipski (2):
      drm/amd/display: Restore periodic detection for DCN35
      drm/amd/display: Reintroduce "Force validation link training on all ASICs"

Jakob Linke (1):
      drm/amdgpu/soc24: reset dGPU if suspend got aborted

James Lin (2):
      drm/amd/display: Add IN_FORMATS_ASYNC support for planes
      drm/amd/display: scale plane global alpha to 12 bits on DCN 4.2

James Zhu (2):
      drm/amdkfd: Add domain parameter to kernel BO mapping function
      drm/amdkfd: move TBA/TMA from system to device memory

Jeevana Muthyala (2):
      drm/amdgpu/vcn4.0: enable secure submission on unified ring
      drm/amdgpu/vcn4.0.5: enable secure submission on unified ring

Jesse Zhang (15):
      drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy queues on unified MES
      drm/amdgpu/mes_v12_1: use mes schedule pipe for legacy queues on unified MES
      drm/amdgpu/gfx11: Refactor compute pipe reset and add HQD cleanup
      drm/amdgpu/gfx12: Refactor compute pipe reset and add HQD cleanup
      drm/amdgpu/gfx: defer per-queue helper_end until after MES resume
      drm/amdkfd: fix SDMA queue counter read on non-gfx9.4.3 ASICs
      drm/amdgpu/mes12: drop queue state on RESET_QUEUES unmap
      drm/amdkfd: flush MES queue on reset-time queue removal
      drm/amdgpu/userq: add reset helper and identify guilty user queue
      drm/amdgpu/gfx11: handle error interrupts for userqs
      drm/amdgpu: defer KCQ remap until after MES resume in reset flow
      drm/amdgpu/gfx12: handle error interrupts for userqs
      drm/amdgpu/gfx11: fix EOP interrupt routing for KQ and userq
      drm/amdgpu/gfx12: fix EOP interrupt routing for KQ and userq
      Revert "drm/amdgpu: defer KCQ remap until after MES resume in reset flow"

Jiqian Chen (1):
      drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2

Karen Chen (1):
      drm/amd/display: Disable DPPCLK RCG to fix cursor disappearing

Ke Zhao (1):
      drm/amdgpu: Fix typo in comment

Kent Russell (3):
      drm/amdkfd: Move mqd_on_vram out of v9 mqd manager
      drm/amdkfd: Extend MQDs in HBM to gfx942
      drm/amdkfd: Extend MQDs in HBM to gfx944

Leo Chen (5):
      drm/amd/display: Update ONO PG Workaround for DCN42
      drm/amd/display: Remove unnecessary DSCCLK enable during DSC PG
      drm/amd/display: Enable HUBP/DPP power gate for DCN42
      drm/amd/display: Refactor Driver PG's skip PG logic
      drm/amd/display: revert "Enable HUBP/DPP power gate for DCN42"

Leorize (1):
      drm/amd/display: set MSA MISC1 bit 6 when using VSC SDP for DCE 11.x

Lijo Lazar (19):
      drm/amd/pm: Validate custom profile parameters
      drm/amdxcp: Add more checks to amdxcp
      drm/amdgpu: Fix kobject cleanup in xcp sysfs
      drm/amdgpu: Add checks to vbios fetch through ATRM
      drm/amd/pm: Add helper for parameter parsing
      drm/amd/pm: Add helper functions to fetch pptable
      drm/amd/pm: Use helper to get pptable in SMUv11
      drm/amd/pm: Use helper to get pptable in SMUv13
      drm/amd/pm: Use helper to get pptable in SMUv14
      drm/amd/pm: Use helper to get pptable in SMUv15
      drm/amdgpu: Validate ATIF buffer length before use
      drm/amdgpu: Validate ATPX buffer length before use
      drm/amdgpu: bounds check xcp ip block index
      drm/amd/pm: validate vega10 profile mode inputs
      drm/amdgpu: bounds check xcp_id in release_sched
      drm/amdgpu: Guard reads in pcie state readout
      drm/amdgpu: bounds check ATOM IIO table parsing
      drm/amdgpu: bounds check atom indirect io method
      drm/amdgpu: bounds check VBIOS name extraction

Lohita Mudimela (1):
      drm/amd/display: Integrate power_helpers.c functionality into power.c.

Mario Limonciello (6):
      drm/amd/display: Set default backlight without ACPI support
      drm/amdgpu: Export ip_discovery sysfs on probe failure
      drm/amdkfd: fix list_del corruption in kfd_criu_resume_svm
      drm/amdgpu: check amdgpu_vm_bo_find() result in GET_MAPPING_INFO
      drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
      drm/amdgpu: don't free standalone ip_discovery sysfs in sysfs_fini

Markus Elfring (2):
      drm/amd/display: Simplify data output in ips_status_show()
      drm/amd/display: Use seq_putc() in three functions

Matthew Jacob (1):
      drm/amdgpu: Support some Barco AMD based graphics adapters

Matthew Schwartz (1):
      drm/amd/display: Fix mem_type change detection for async flips

Matthew Stewart (4):
      drm/amd/display: Add dcn42b_soc_and_ip_translator
      drm/amd/display: Fix DCN42 null registers & register masks
      drm/amd/display: Rewrite dccg42_init
      drm/amd/display: Remove DCCG registers not needed in DCN42

Melissa Wen (5):
      drm/amd/display: use GAMCOR for degamma private props in subsampled format
      Revert "drm/amd/display: Remove unused cm3_helper_translate_curve_to_degamma_hw_format"
      drm/amd/display: use a separate helper to translate degamma curves
      drm/amd/display: support up to 256 samples per region in degamma/blend LUT
      drm/amd/display: use halving distribution for PQ/sRGB linearizing LUT

Michael Strauss (1):
      drm/amd/display: Add 12bpc Color Ramp Support

Mikhail Gavrilov (2):
      drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to drm_exec
      drm/amdgpu: fix recursive ww_mutex acquire in amdgpu_devcoredump_format

Natalie Vock (2):
      drm/amdgpu: Only set bo->moved when the BO was actually moved
      drm/amdgpu: Rename moved state to needs_update

Nicholas Kazlauskas (1):
      drm/amd/display: Add a new interface to set idle opts in clock manager

Ovidiu Bunea (1):
      drm/amd/display: Temp disable repeater FGCG as workaround

Pavel Ondračka (1):
      drm/radeon: fix r100_copy_blit for large BOs

Peichen Huang (1):
      drm/amd/display: correct encoder minimal creation

Perry Yuan (1):
      drm/amdgpu: flush pending RCU callbacks on module unload

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: add userq job and state transition trace events

Piotr Maziarz (1):
      drm/amd/display: Fix 4018 warning

Prike Liang (7):
      drm/amdgpu: allocate lockdep mutex on the heap to fix stack overflow
      drm/amdgpu: correct reservation fence slots for userq per-vm BOs eviction
      drm/amdgpu: set the userq xcp_id
      drm/amdgpu: add userq create and destroy tracepoints
      drm/amdgpu: add the doorbell index input for suspending userq
      drm/amdgpu/mes11: set doorbell offset for suspending userq
      drm/amdgpu/mes12: set doorbell offset for suspending userq

Qiang Yu (1):
      drm/amdgpu: initialize iter.start in amdgpu_devcoredump_format

Rafal Ostrowski (2):
      drm/amd/display: Introduce dc_plane_cm and migrate surface update color path
      drm/amd/display: Refactor surface_update_flags to flat struct with helpers

Relja Vojvodic (1):
      drm/amd/display: Update link bw

Robin Chen (1):
      drm/amd/display: Add PSR Active VTotal Control capability

Roman Li (1):
      drm/amd/display: Skip PHY SSC reduction on some 8K panels

Ruijing Dong (1):
      drm/amdgpu: enumerate UMSCH HW IP

Ruoyu Wang (1):
      drm/radeon: avoid double free in r600 DPM cleanup

Samuel Zhang (1):
      drm/amd: add AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU debug mask

Shaoyun Liu (1):
      drm/amd/amdgpu/include : update mes api header v11/v12

Shubhankar Milind Sardeshpande (1):
      drm/amd/pm: re-enable MC access after PrepareMp1ForUnload on SMU V15 APUs

Srinivasan Shanmugam (1):
      drm/amdgpu/powerplay: Align get_tonga_state_array() header with prototype

Stanley.Yang (1):
      drm/amdgpu/ras: Resum RAS IP hw init during nps dynamic switch

Sunil Khatri (1):
      drm/amdgpu: do not release the root bo after vm validate

Taimur Hassan (6):
      drm/amd/display: Promote DC to 3.2.385
      drm/amd/display: [FW Promotion] Release 0.1.63.0
      drm/amd/display: Promote DC to 3.2.386
      drm/amd/display: [FW Promotion] Release 0.1.64.0
      drm/amd/display: Promote DC to 3.2.387
      drm/amd/display: Promote DC to 3.2.388

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: initialize irq.lock spinlock earlier

Thomas Zimmermann (1):
      drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips

Timur Kristóf (23):
      drm/amd/display: Add detect reason to handle_hpd_irq_helper
      drm/amd/display: Use handle_hpd_irq_helper for HPD RX
      drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
      drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT
      drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
      drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU segment when it isn't at 0 (v2)
      amdgpu/ih6.1: Fix minor version
      drm/amdgpu: Use system unbound workqueue for soft IH ring
      drm/amdgpu: Clarify name of soft recovery to avoid confusion
      drm/amdgpu: Clean up defunct soft reset from ASIC reset code path
      drm/amdgpu: Delete GMC 8 soft reset
      drm/amdgpu: Delete soft reset code from legacy display driver
      drm/amdgpu: Delete check_soft_reset() from amd_ip_funcs
      drm/amdgpu: Delete pre/post_soft_reset() from amd_ip_funcs
      drm/amdgpu: Add IP block soft reset as a GPU recovery method
      drm/amdgpu/gfx8: Stop CP and RLC during reset
      drm/amdgpu/gfx8: Return error when testing all rings
      drm/amdgpu/gfx8: Support COND_EXEC on compute rings
      drm/amdgpu/gfx8: Adjust EDC GPR workaround
      drm/amdgpu/gfx8: Fixup IP block soft reset
      drm/amdgpu/gfx8: Enable IP block soft reset as a GPU recovery method
      drm/amdgpu: Simplify filtering rings during IP block soft reset
      drm/amdgpu: Fix typos in comments for IP block soft reset

Tvrtko Ursulin (16):
      drm/amdgpu: Fix context pstate override handling
      drm/amdgpu: Remove arbitrary number of contexts limitation
      drm/amdgpu: Consolidate ctx put
      drm/amdgpu: Remove live context error log and skip
      drm/amdgpu: Simplify amdgpu_ctx_get_stable_pstate()
      drm/amdgpu: Convert context manager to xarray
      drm/amdgpu: Clarify odd behaviour of AMDGPU_CTX_OP_GET_STABLE_PSTATE
      drm/amdgpu: Choose SOC15 RLC register read write functions at init time
      drm/amdgpu: Only calculate register offset once in SOC15 RLC
      drm/amdgpu: Drop support for variable struct drm_amdgpu_bo_list_entry size
      drm/amdgpu: Remove the bo list mutex
      drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
      drm/amdgpu: Remove output parameter in bo list handling
      drm/amdgpu: Remove unused amdgpu_device_ip_is_hw
      drm/amdgpu: Save some cycles on the job submission path
      drm/amdgpu: Do not fiddle with the idle workers too much

Uwe Kleine-König (The Capable Hub) (1):
      drm/amdgpu: Don't use UTS_RELEASE directly

Victor Skvortsov (1):
      drm/amdgpu: Disable ras_check_bad_page_status on VFs

WenTao Liang (1):
      drm/amd/display: detect_link_and_local_sink: DP alt mode timeout path leaks prev_sink reference

Wenjing Liu (4):
      drm/amd/display: Add utm_qos_model pointer to clk_bw_params
      drm/amd/display: Remove get_utm_qos_model from soc_and_ip_translator
      drm/amd/display: Remove unused project_id from DML2 core instance
      drm/amd/display: Replace repeated no-native-i2c checks with force_i2c_over_aux field

Werner Sembach (1):
      drm/amd/display: Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check

William Palacek (1):
      drm/amdkfd: use scnprintf/vscnprintf in kfd_smi_event_add

Xiang Liu (4):
      drm/amd/ras: Sync bad page count on EEPROM update
      drm/amdgpu: dump RAS EEPROM table via debugfs
      drm/amdgpu: protect XCP scheduler selection
      drm/amd/pm: Guard VBIOS AC timing table walk

Xiaogang Chen (4):
      drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioctl
      drm/amdkfd: check find_first_zero_bit before __set_bit on kfd->doorbell_bitmap
      drm/amdkfd: Use memdup_array_user to copy data from/to user space at kfd ioctls
      drm/amdkfd: Guard m->cp_hqd_eop_control setting by q->eop_ring_buffer_size

Yang Wang (11):
      drm/amd/pm: make pp_features read-only when scpm is enabled
      drm/amd/pm: fix amdgpu_pm_info power display units
      drm/amd/pm: Validate pp_table header before reading size
      drm/amd/pm: Use uploaded size for legacy custom PPTable
      drm/amd/pm: Validate Tonga PowerPlay state array bounds
      drm/amd/pm: Validate Vega hwmgr PowerPlay table bounds
      drm/amd/pm: Validate legacy hwmgr PP table offsets
      drm/amd/pm: Validate Vega10 PPTable subtable bounds
      drm/amd/pm: Validate Tonga PPTable subtable bounds
      drm/amd/pm: drop unused smu pptable callbacks
      drm/amd/pm: fix smu13 power limit range calculation

YiPeng Chai (2):
      drm/amdgpu: add bounds check to prevent array overflow
      drm/amd/ras: use IS_ERR() to check thread creation result

Yifan Zhang (1):
      drm/amdgpu: add ioctl to handle RAS poison error

Yongqiang Sun (5):
      drm/amdkfd: remove obsolete events page mmap support
      drm/amdkfd: remove dead kernel-allocated signal page code
      drm/amdkfd: drop struct kfd_signal_page wrapper
      drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to BO size
      drm/amdkfd: use node XCC count for v9 CRIU control stack restore

Yunxiang Li (2):
      drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free
      drm/amdgpu: skip already suspended IP blocks in ip_suspend_phase2

Zhu Lingshan (2):
      drm/amdgpu: implement per-process MES context
      drm/amdgpu: reject mapping a reserved doorbell to a new queue

geomcrae_amdeng (1):
      drm/amdgpu: clean up discovery and preempt sysfs entries on shutdown

 drivers/gpu/drm/amd/amdgpu/Makefile                |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c            |   985 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h            |   232 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |    68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    30 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c    |    63 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |   170 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h        |    22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |   116 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h           |     8 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    75 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   274 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |   221 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   194 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   322 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   294 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c             |   143 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h             |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        |   103 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |   486 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h            |   107 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |    70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |    23 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    40 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c    |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c         |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   862 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |    40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   368 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |     3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   188 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c            |    39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |    10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h             |    77 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |    28 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   150 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    66 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |   269 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |    26 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   169 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |    16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |    58 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |    17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    76 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   149 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |    42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   299 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |    63 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |    66 +-
 drivers/gpu/drm/amd/amdgpu/atom.h                  |     3 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |     7 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    66 -
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    57 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    57 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    15 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   412 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   320 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |    28 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   227 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    51 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  1108 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |     4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   125 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    19 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |     2 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |     2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |    90 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |    94 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |     3 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   147 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h         |     9 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   246 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   269 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |    27 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c            |   231 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |     6 -
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |     2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    62 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   200 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |    22 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |    22 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |    22 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |     7 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |     9 -
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    65 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    68 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |    39 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |    14 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |    40 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c             |   585 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h             |    28 -
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    45 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |    69 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |    12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |    60 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |    87 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |    90 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |     3 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |    22 -
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    80 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |     2 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    34 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   223 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     2 +
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |     8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   224 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h            |     4 -
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |    10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |    16 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |     3 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |    39 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    25 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   122 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |   103 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h        |    14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    11 +-
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c        |    18 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |     6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 12139 ++++---------------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    79 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |   323 +
 .../amdgpu_dm_audio.h}                             |    47 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   726 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |    75 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   179 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |     8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |     1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  3601 ++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   162 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   102 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |     6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    22 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |     6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    78 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |   943 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |    68 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   115 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |    12 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    77 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h  |    20 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  1548 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |    27 +
 .../display/amdgpu_dm/amdgpu_dm_kunit_helpers.h    |     1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   189 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |    25 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   138 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |    51 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   303 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h   |    61 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |    51 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |     5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |     2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |    10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |     7 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |    16 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |    13 +
 .../drm/amd/display/amdgpu_dm/tests/.kunitconfig   |     6 +
 .../gpu/drm/amd/display/amdgpu_dm/tests/Makefile   |    18 +
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   490 +
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  1242 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |    64 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   140 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  2158 ++++
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   122 +
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   523 +
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   582 +
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   297 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   634 +
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   909 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |    39 +-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   142 +
 .../amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h |    32 +
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |  1092 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |  1228 ++
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |  2454 ++++
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   518 +-
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   103 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   432 +-
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   313 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   949 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   392 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |     2 -
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |     2 -
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |     2 +
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    57 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h |     9 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   307 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   174 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    11 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |    44 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   238 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |    41 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |    43 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |     1 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   226 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    29 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    67 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    59 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |    63 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |     9 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    15 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.h    |     3 +-
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |     2 -
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |     2 -
 .../drm/amd/display/dc/dce112/dce112_compressor.c  |     8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |   184 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.c  |     4 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.h  |     2 +
 drivers/gpu/drm/amd/display/dc/dm_services.h       |     4 -
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |     2 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |     2 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |     2 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.c    |     8 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |    40 +-
 .../dml2_0/dml21/inc/dml_top_soc_parameter_types.h |    13 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |    41 +-
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |     2 -
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |     2 -
 .../dml21/src/inc/dml2_internal_shared_types.h     |     1 -
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |     5 -
 .../drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h |     4 +
 .../amd/display/dc/gpio/dce80/hw_translate_dce80.c |     5 +-
 .../amd/display/dc/gpio/dcn10/hw_translate_dcn10.c |   484 +-
 .../amd/display/dc/gpio/dcn20/hw_translate_dcn20.c |   432 +-
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.c |   417 +-
 .../amd/display/dc/gpio/dcn30/hw_translate_dcn30.c |   432 +-
 .../display/dc/gpio/dcn315/hw_translate_dcn315.c   |   418 +-
 .../amd/display/dc/gpio/dcn32/hw_translate_dcn32.c |   386 +-
 .../display/dc/gpio/dcn401/hw_translate_dcn401.c   |   392 +-
 .../amd/display/dc/gpio/dcn42/hw_translate_dcn42.c |   193 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |    86 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h |    21 +
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |     8 +-
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |     2 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |     2 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |     6 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |     8 +-
 .../drm/amd/display/dc/hwss/dce60/dce60_hwseq.c    |     8 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |    62 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |    76 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c  |     2 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    10 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    36 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |     3 -
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   341 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    12 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |     2 +
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   327 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |     5 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |    82 +
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |     2 +-
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |     1 +
 drivers/gpu/drm/amd/display/dc/inc/reg_helper.h    |    19 -
 .../drm/amd/display/dc/inc/soc_and_ip_translator.h |    14 -
 .../gpu/drm/amd/display/dc/link/link_detection.c   |     7 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |     7 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |    20 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.h   |     2 +
 .../display/dc/link/protocols/link_dp_capability.c |    14 +-
 .../dc/link/protocols/link_dp_panel_replay.c       |     3 +-
 .../dc/link/protocols/link_edp_panel_control.c     |     8 +-
 .../gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   |     4 -
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c   |    51 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c |     5 -
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |     5 -
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |     5 -
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |     5 -
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |     5 -
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |     5 -
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.c   |     5 -
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |   258 +-
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h    |    22 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |     1 -
 .../display/dc/resource/dcn302/dcn302_resource.c   |     1 -
 .../display/dc/resource/dcn303/dcn303_resource.c   |     1 -
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |     5 +-
 .../display/dc/resource/dcn314/dcn314_resource.c   |     4 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |     5 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |     5 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |     1 -
 .../display/dc/resource/dcn321/dcn321_resource.c   |     1 -
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |     6 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |     6 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |     6 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |     5 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |     6 +-
 .../amd/display/dc/soc_and_ip_translator/Makefile  |     3 +
 .../dcn42/dcn42_soc_and_ip_translator.c            |    18 +-
 .../dcn42/dcn42_soc_and_ip_translator.h            |     1 +
 .../dcn42b/dcn42b_soc_and_ip_translator.c          |    42 +
 .../dcn42b/dcn42b_soc_and_ip_translator.h          |    17 +
 .../soc_and_ip_translator/soc_and_ip_translator.c  |     5 +-
 drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h    |     4 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   289 +-
 .../drm/amd/display/include/ddc_service_types.h    |     1 +
 drivers/gpu/drm/amd/display/include/gpio_types.h   |    48 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |    30 +-
 drivers/gpu/drm/amd/display/modules/power/Makefile |     2 +-
 drivers/gpu/drm/amd/display/modules/power/power.c  |    12 +-
 .../gpu/drm/amd/display/modules/power/power_abm.c  |    14 +-
 .../drm/amd/display/modules/power/power_replay.c   |     9 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |     3 -
 .../amd/include/asic_reg/sdma/sdma_4_4_2_offset.h  |     4 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |     3 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |     7 +-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h      |     5 +-
 drivers/gpu/drm/amd/include/soc15_hw_ip.h          |     1 +
 drivers/gpu/drm/amd/include/v9_structs.h           |     4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   142 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |    21 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    |    38 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c  |    11 +-
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c |   755 +-
 .../drm/amd/pm/powerplay/hwmgr/processpptables.c   |   446 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |    58 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |    81 +-
 .../pm/powerplay/hwmgr/vega10_processpptables.c    |   761 +-
 .../pm/powerplay/hwmgr/vega12_processpptables.c    |     7 +
 .../pm/powerplay/hwmgr/vega20_processpptables.c    |     7 +
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |    17 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |    34 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |    37 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |     2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |     6 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |     4 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |     4 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |     8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |     8 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |     8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |    84 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |     1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |     1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |    94 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |    18 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |     8 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   653 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |    22 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |    85 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |     9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |    85 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |     7 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   140 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |    13 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |     3 -
 .../drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c    |     2 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    76 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h   |     2 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c |    14 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c   |    19 +
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h          |     3 +
 drivers/gpu/drm/amd/ras/rascore/ras.h              |     5 +
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c     |    13 +-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c         |    15 +
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c       |     3 +
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c    |     2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c          |    19 +-
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h          |     3 +
 drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c    |    13 +
 drivers/gpu/drm/amd/ras/rascore/ras_process.c      |     5 +-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c          |    32 +-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h          |     6 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h    |     2 +
 drivers/gpu/drm/drm_connector.c                    |     3 +-
 drivers/gpu/drm/drm_displayid_internal.h           |    24 +
 drivers/gpu/drm/drm_edid.c                         |    80 +-
 drivers/gpu/drm/radeon/r100.c                      |    13 +-
 drivers/gpu/drm/radeon/r600_dpm.c                  |    21 +-
 include/drm/drm_connector.h                        |     6 +
 include/uapi/drm/amdgpu_drm.h                      |    21 +
 include/uapi/drm/drm_mode.h                        |     1 +
 414 files changed, 36740 insertions(+), 24390 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
 rename drivers/gpu/drm/amd/display/{modules/power/power_helpers.c => amdgpu_dm/amdgpu_dm_audio.h} (50%)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.h
