Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D956EC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E1A10F0F9;
	Thu, 17 Sep 2026 20:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LqT8iiQi";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5D310F0F9;
 Thu, 17 Sep 2026 20:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNVrrtmn1J/g1AM8ErRzagWF3hhGmfnLLYp+XQt99MKI9/mLItcTPT/ZnkSWutCF0g3gNLSJykvm64vgeQWz4PhHdzvdEi59xOd9Q/sOgIhk3Ej5cqf01l6yfpNJZmVSr3rjPjNMSXHc5zcTrqeyD7AG9UBjXKIFAD2KOnoQOtJuA2pVi3aeLWxpVNLcvVkb+bHShcT47Xot985aPXgQB5KT314P92i3T0Gswh9F+/OMSW5G05KSiB0TOQRBzqePsYDFgVQUe7uw6RUReHNhkWL+UpNgyuZvLYyjYdxTD9EUMH+zOQoGa6WNFP2NxzVis1y8d2lMoxTlkvRKohCuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I43le97U6xpl0FF5kDi7iK9McZhqUmf5l60MDAmvw2s=;
 b=EV0ZH4QdxPTXKYjn50+UBSsMT1iXo/n462Efhs7h+jWF899uMqJ4XijXqzVIcRv4SZh5kZpueWCmykMGVEVOzEA4OhoBKul4yD3FrBY2EaN5HWaC2olJc/WABGovQx/Oviar5dI6zfHW6l15MbnHgu5Kn+2XtDD/mQ8NDQWfdRzgLTHSzmnHSLhOg0AydZ6l7qwfU+pXf16MWz5WosuTA0g9NbzqGQlAp04eD0UpaPdlvllkx7vwSu9Wf7D4xsnBov6wsCKGEJE+h4o3DoBgXWBzrwcExlRP5CTUCix07ETiAXNQLC/Xta4KsFHWEi+RPDkXiGN/iTwJWb7L4/dAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I43le97U6xpl0FF5kDi7iK9McZhqUmf5l60MDAmvw2s=;
 b=LqT8iiQivvbxjL+8yNXrfFqHVgZK6IO2IR7zd0lMhERrQAosGlsjnSFvdG06sQyOca2wKXvYo+Ji0fjJTOB487C/wxVb4U3eK2whaY8loAGWJ6p0sepcHWZwCD/CT/8hg3nZEeg9TJiFfvJhRqBkmFNHsIGIJotMJANmpx/E+Qs=
Received: from SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 20:38:48 +0000
Received: from BY1PEPF00026965.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::4f) by SJ0PR13CA0130.outlook.office365.com
 (2603:10b6:a03:2c6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 20:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF00026965.mail.protection.outlook.com (10.167.244.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 20:38:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 15:38:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 15:38:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 15:38:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.4
Date: Thu, 17 Sep 2026 16:38:41 -0400
Message-ID: <20260917203841.3881294-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026965:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c507d8f-38c8-4444-1c30-08df14fbad50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|11063799006|6133799003|56012099006|10086099003|18092099006|10067099003|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: fHtQTmLzozcOAZ970FEa5gvbUS4UcKJeOv4KT5zzg8WWX4Fhep3UZSEt581+GvdK37+P++VO4s2c53rtGEhQ3gIoFpuCErOxWH4wFACsMi/ZCh/AZ6Yb/nfXtLfPRP+VABoWNeVKTIgGM9VlpTJ4+xLGmVuDhMiRSgGF+L5oi7BX6g75Ba1wyrqRxUg6rz+sDHufcVZDAfmKeIUYO5iqEESOvRdNEdscA8s6SAFqDZzVo1tsUO/xGONReUqKVGMfvmLn7I+kMTLBQ4E1WPIXoLYhX7qP3ZK6es8nCAQ9q/v2u0lQnT4Qf1L3bRfvWeWIJVA4QPD63X6m/cV/KH3YiA0O9N67uEqxGIm1K4zI0OeKwPTxhveetIXIKgJUO9gb5H3Cot6PGR0NHFmLohCkeFQcIi2BNxuJuOwjL22K9rfakaxKv6E0+Lo2YDjs/bSXAMZZspmjmxekS8yrc5pF0srEuS5YhqQOh7aMfoTrvQlPCHlL1fyMMadAX0FKuWUIfDX+G4C2Vy13m39u5K2fZB+GjiAZKeKlTduunU7nJX6Utiv4BrKG0N5LeJKQ/ql/5CaXLhbNtMu/lhnVOZviXAJGycJ5VPdKPUlw/xsKkPYEA7edcZwKiIxOgywolLGcu9ifdOEdonekurZH2jHeuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(11063799006)(6133799003)(56012099006)(10086099003)(18092099006)(10067099003)(3023799007)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j0tEEphRF0Td968Sre40TWPjPO8Vup9I3yhlWvcDFiwQnCusI4feC0j8752Poe8NH9AM+wtiwlioqrT5EsS9VLO1U0JVotKM79G0zXEWVHrC8iauQV6GqNAepzxWDfHpoxk4+/LG6KgCXm7hKU4Dqfkl2l77cViTqYYABttyL/wnTuhOXvfkF7sg/SzxzIcsDnQMb8H9c4xM+lraGOH1YQAPshor9aKO7srFR7O5cHbwi69u5YhYMSYvFASgXty0tutitRjTUHYzOwVMGPs+c/ervUdHd4lDouTpFFout879lJzQMPJz+m6cFo6PKnEyxAXrWgihr0cDEJQLH8F79xwUihDgmuz8VfX8mMpp4wBPBOYDRwZwK6BfVJebFje9VpcRwdGzVVQ1swLTkcD+Yqj8+N8NvfORViQ83MFht7lXjeTVwQFrwsL+q37uBqVo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:38:48.6303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c507d8f-38c8-4444-1c30-08df14fbad50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026965.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
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

New stuff for 7.4.

The following changes since commit 2446a767ffacee0d247db932621cd4b165ad721a:

  Merge tag 'amd-drm-next-7.4-2026-09-10' of https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next (2026-09-17 19:00:55 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.4-2026-09-17

for you to fetch changes up to cf48bd0a46279f4607956cb17c71bda96ee802e3:

  drm/amdgpu: Use memset32 for SDMA padding (2026-09-17 11:38:29 -0400)

----------------------------------------------------------------
amd-drm-next-7.4-2026-09-17:

amdgpu:
- SMU 14.x fix
- DC IRQ fix
- Runtime PM fix for P2P
- RAS fix
- PCIe reporting fix
- DCN 6 fix
- Device removal fix
- DC MALL fix
- Display KUNIT test fixes
- More display KUNIT tests
- GC 12.1 cleanup
- DC RMCM refactor
- Display forces RGB fix
- DP MST fixes
- USB4 fixes
- Plane update fixes
- DMUB updates
- ISM fixes
- DCN 4.2 updates
- HDMI FRL updates
- Add new trace events
- SDMA soft reset updates
- Update git trees in MAINTAINERS
- UALink fixes
- UserQ fixes
- SDMA clean ups
- Misc spelling fixes
- Documentation fixes
- ATOM range checks

amdkfd:
- GC 12.x fixes
- Boundary checks
- Mapping clear fix
- GC 10 CU occupancy support
- GC 12.1 fixes
- XNACK fix
- Partition fix

radeon:
- eDP fix for DCE3.2 iMacs

----------------------------------------------------------------
Alex Deucher (2):
      drm/amd/display: fix merge fallout in KUNIT tests
      MAINTAINERS: update git tree for radeon, amdgpu, amdkfd

Alex Hung (25):
      drm/amd/display: Test sink stream creation
      drm/amd/display: Test connector init helper
      drm/amd/display: Test HDMI connector init
      drm/amd/display: Test FreeSync caps update
      drm/amd/display: Test connector init
      drm/amd/display: Test forced atomic commit
      drm/amd/display: Test DCC reject for multi-plane format
      drm/amd/display: Test modifier list growth failure
      drm/amd/display: Test pre-GFX9 plane buffer attributes
      drm/amd/display: Test accepted plane atomic check
      drm/amd/display: Test cursor update without DC stream
      drm/amd/display: Test panic flush DCC teardown
      drm/amd/display: Test optional plane property creation
      drm/amd/display: Build MST DSC helpers for KUnit
      drm/amd/display: Test oversized AUX transfer
      drm/amd/display: Test MST connector creation
      drm/amd/display: Test link bandwidth readback
      drm/amd/display: Test cascaded Panamera check
      drm/amd/display: Test DSC caps validation
      drm/amd/display: Test MST port mode support
      drm/amd/display: Test FRL bandwidth lookup
      drm/amd/display: Test DSC precompute helpers
      drm/amd/display: Test DSC recompute check
      drm/amd/display: Test DSC config computation
      drm/amd/display: Test per-link DSC configs

Alvin Lee (5):
      drm/amd/display: Update LLS and UPSP programming paths
      drm/amd/display: Add debug option to force optional UCLK support
      drm/amd/display: Enable back alt-ch
      drm/amd/display: Program DCC as part of address update
      drm/amd/display: Return success status from check_mode_supported

Chengjun Yao (1):
      drm/amdgpu: fix rmmio iounmap skipped on device removal

Chenyu Chen (1):
      drm/amd/display: Use unsigned types for FRL cap check params and HPO read_state

Dan Carpenter (1):
      drm/amd/pm: delete a stray tab

David Belanger (2):
      drm/kfd: Add CU occupancy support to GFX10 and GFX10.3
      drm/amdkfd: Disable gfxoff for CU occupancy

David Francis (3):
      drm/amdgpu: Add trace events for pid register/deregister
      drm/amdkfd: Avoid integer underflow with ffs in EOP ring size calc
      drm/amdkfd: Avoid integer underflow in EOP ring size calculation.

Dillon Varone (1):
      drm/amd/display: Cleanup DMUB command submission interfaces

Dmitriy Chumachenko (1):
      drm/amdgpu: check ras and obj before dereference

Dominik Kaszewski (1):
      drm/amd/display: Add lock-free memory pool

Fangzhi Zuo (2):
      drm/amd/display: Force DSC to 8bpp for MST DP tunneling over USB4
      drm/amd/display: Force DSC to 8bpp for SST DP tunneling over USB4

Francis Marlou Pacaro (1):
      drm/amd/display: fix MALL hysteresis timer underflow at high refresh rates

Gabe Teeger (4):
      drm/amd/display: Enable power gating on dcn42b
      drm/amd/display: Bound DSC power gating loop by num_dsc
      drm/amd/display: Remove MALL capabilities from DCN42B
      drm/amd/display: Remove MALL capabilities from DCN42B bounding box

Gang Ba (1):
      drm/amdkfd: Fix TCP XNACK scoreboard reset race

Hari Mishal (2):
      drm/amd/pm: bound SCLK FCW range entries to the table size
      drm/amdgpu/atom: bound the VBIOS date, part number, version and build getters

Horatio Zhang (1):
      drm/amdgpu: retire the legacy MES design for GFX 12.1

Ilya Bakoulin (1):
      drm/amd/display: Fix HDMI FRL audio enable

Ivan Lipski (1):
      drm/amd/display: Honor forced RGB pixel encoding

James Lin (6):
      drm/amd/display: Rename lock_and_validation_needed to needs_dc_state_realloc
      drm/amd/display: Attach only plane updates that actually changed
      drm/amd/display: Request DMUB HW cursor offload
      drm/amd/display: Send stream_update to DC only when it changed
      drm/amd/display: Drop dead update_type param from update_planes_and_stream_adapter
      drm/amd/display: Cast DP DTO pixel clock math to avoid overflow and narrowing

Kevin Wang (1):
      drm/amd/pm: report energy accumulator for smu 14.0.3

Leo Chen (1):
      drm/amd/display: Cap DML2.1 vmin ODM combine at 2:1 for eDP

Leo Li (1):
      drm/amd/display: Atomize IRQ register read/modify/write ops

Lijo Lazar (2):
      drm/amdgpu: Fix kfd device lock during partition
      drm/amdgpu: remove unused kfd lock wrappers

Mario Limonciello (4):
      drm/radeon: restore eDP panel power sequencer on Apple DCE3.2 iMacs
      drm/amdgpu: Fix GPU PCIe link capability reporting
      drm/amdgpu: Skip KFD mapping clear before initialization
      drm/amdgpu: Reuse cached PCIe link device

Mike Lothian (1):
      drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments

Mukul Joshi (2):
      drm/amdgpu: Fix missed connection cleanup on HELLO reset for UALink
      drm/amdkfd: set CP_HQD_PQ_CONTROL.SCOPE to SYSTEM for GFX 12.1

Omokefe Emmanuel Onanaroghene (1):
      drm/amd/display: fix kernel-doc warnings for amdgpu_display_manager

Ovidiu Bunea (2):
      drm/amd/display: Remove SDPIF_PORT_CONTROL programming for DCN31/35/42
      drm/amd/display: Add condition to skip MALL calculations if there is no MALL

Rafal Ostrowski (2):
      drm/amd/display: Refactor RMCM into a separate module
      drm/amd/display: Unify fast update classification paths

Ray Wu (1):
      drm/amd/display: Flush ISM work before releasing the stream

Ruslan Vagner (1):
      drm/amd: fix comment typos in amdgpu and radeon

Srinivasan Shanmugam (2):
      drm/amd/display: Fix NULL dereference in dcn50/dcn60 init_hw
      drm/amd/display: Fix redundant NULL check on dc->clk_mgr in dcn42_prepare_bandwidth

Taimur Hassan (1):
      drm/amd/display: Promote DC to 3.2.398

Timur Kristóf (9):
      drm/amdgpu/sdma: Remove unimplemented soft_reset() for SDMA and SI DMA
      drm/amdgpu/sdma: Remove superfluous rlc_resume and rlc_stop functions
      drm/amdgpu/sdma: Fix executing duplicate commands after recovery on SDMA v4.4.2
      drm/amdgpu/sdma: Remove unnecessary guilty tracking of SDMA queues
      drm/amdgpu: Add amdgpu_ring_clear_ring_and_ptrs()
      drm/amdgpu/sdma: Clear SDMA rings after reset before starting them
      drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
      drm/amdgpu/sdma: Always handle kernel queues in amdgpu_sdma_reset_engine()
      drm/amdgpu/sdma: Use common SDMA legacy queue reset on SDMA v4.4.2

Tom Chung (1):
      drm/amd/display: Add inbox0 HW lock helpers for DCN35

Tomasz Siemek (2):
      drm/amd/display: Decouple cursor offload hwss executors from pipe context
      drm/amd/display: Decouple HUBP_UPDATE_PLANE_ADDR from pipe_ctx

Tony Cheng (3):
      drm/amd/display: Add instance field to struct mpc
      drm/amd/display: Add instance field to struct dccg
      drm/amd/display: Add SPDX license identifier to dcn30_dpp_cm.c

Tvrtko Ursulin (6):
      drm/amdgpu: Add SDMA ring init helper
      drm/amdgpu: Add amdgpu_sdma_types.h header
      drm/amdgpu: Convert SDMA instance and index to direct lookup
      drm/amdgpu: Cache the SDMA CSA address
      drm/amdgpu: Extend logical to device instance lookup to all devices
      drm/amdgpu: Use memset32 for SDMA padding

Vitaly Prosyak (2):
      drm/amdgpu: reserve eviction-fence slot at WPTR caller
      drm/amdgpu: reserve root PD fence slots for userq eviction-fence rearm

Vladimir Marioukhine (1):
      drm/amdkfd: implement restore_mqd callbacks for GFX12/12.1

Wang, Sung-huai (1):
      drm/amd/display: Add is_odm_enabled callback to skip init_odm on active ODM pipes

Wei-Guang Li (1):
      drm/amd/display: Add Replay cumulative residency query

Wenjing Liu (2):
      drm/amd/display: Add urgent assertion counter probe
      drm/amd/display: Fix peak bandwidth measurement sequence

Xiang Liu (1):
      drm/amd/ras: apply the MCA debug mode on every RAS resume

Yi-Ling Chen (1):
      drm/amd/display: Add option for certain panels to disable FEC

 MAINTAINERS                                        |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c   |    3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |  148 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h |    3 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  106 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |   43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c             |   67 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h             |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   47 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |  169 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |  168 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h     |  163 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   33 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   26 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |    7 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |   42 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |   29 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |   33 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  475 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |   83 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           |    1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |    1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |    1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |    9 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |    1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |    1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |    1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |    1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |    3 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |  247 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |   55 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   63 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   71 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |  197 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   89 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |   82 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |   59 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |   58 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |   34 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    7 -
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    6 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |   11 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   11 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   72 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |    6 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   23 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |   61 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |   71 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |    5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    2 +
 drivers/gpu/drm/amd/display/Makefile               |    1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  113 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   42 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   20 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |    1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   64 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |   28 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   21 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   61 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |   19 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   33 +
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 1733 +++++++++++++----
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   16 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |    8 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   34 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   83 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     | 2041 +++++++++++++++++++-
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |  357 +++-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |    7 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |    3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  254 +--
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  246 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  147 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |    2 -
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  124 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   48 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   50 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |   12 +-
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c    |  277 +++
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h    |  107 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   14 +-
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c |    1 +
 .../drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c   |    1 +
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c |    1 +
 .../gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c |    2 +
 .../drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c   |    1 +
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c |    1 +
 .../drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c   |    1 +
 .../gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c |    1 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |    1 +
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c   |    1 +
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    1 +
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c |    1 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    6 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |   25 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h   |    2 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c  |    2 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |    2 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |    4 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |   11 +-
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c    |    2 +-
 .../dml21_wrapper/dml21_translation_helper.c       |    1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |    2 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c   |   20 +-
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h   |    3 +-
 .../dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c    |    6 +-
 .../dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c    |    9 +-
 .../dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c    |    9 +-
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |    5 -
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |    7 +-
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |   13 +-
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |   44 +-
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |    4 +-
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h |    3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |    5 +-
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h |    3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c |    5 +-
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |    5 +-
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h |    3 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |    9 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |    3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |    6 +-
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c |   28 +-
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h |    3 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  108 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h    |    2 +
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   40 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h    |    2 +
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c  |   27 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h  |    2 +
 .../drm/amd/display/dc/hwss/dcn201/dcn201_init.c   |    1 +
 .../gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |   13 +-
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn301/dcn301_init.c   |    1 +
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |    1 +
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |   43 +-
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  117 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h    |   14 +-
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |    1 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   39 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    5 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |    1 +
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |  285 ++-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |   17 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |    6 +-
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |   16 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |  199 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h    |    5 +-
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |    8 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |   70 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |    4 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |   65 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h       |  140 ++
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |    2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |   18 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |    1 +
 .../dc/link/protocols/link_edp_panel_control.c     |   22 +
 .../dc/link/protocols/link_edp_panel_control.h     |    2 +
 .../gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   |    1 +
 .../gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   |    1 +
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |    1 +
 .../gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c   |    1 +
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |    1 +
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   |  680 +------
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h   |  714 +------
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c   |   41 +-
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h   |  238 ---
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |   10 +
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h |    1 +
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |    1 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |    1 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c |    1 +
 drivers/gpu/drm/amd/display/dc/os_types.h          |    1 +
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |    4 +
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   56 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |  123 +-
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |   20 +-
 drivers/gpu/drm/amd/display/dc/rmcm/Makefile       |   44 +
 .../gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c |  867 +++++++++
 .../gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h |  717 +++++++
 .../gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c |  251 +++
 .../gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.h |   35 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |    7 +-
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |    3 +
 .../drm/amd/display/modules/power/power_replay.c   |   13 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |    1 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    |    3 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |    1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |    1 +
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |    3 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    5 +-
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h          |    7 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |   36 +
 drivers/gpu/drm/radeon/radeon_fence.c              |    4 +-
 248 files changed, 9549 insertions(+), 4965 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.h
