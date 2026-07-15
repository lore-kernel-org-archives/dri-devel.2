Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617B0C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 22:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D9210E245;
	Wed, 15 Jul 2026 22:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yD1f7B3d";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F65410E229;
 Wed, 15 Jul 2026 22:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPOI0P81WLvthGvUEJFI79dPCyHWE6p8jHYZtVKBaN2OLfT6ublWaleKmAFLzenlD3LGByFVvorGcf3QKNjpGrt+nPHxxQTU9LiJ9oyMKYCp6fBaAf+d7htrq86/XIrBVnJ/dUMGJ3BnS9omEJxnilngbJq8YNLtycKbY+k1sOrKMFd0nnPOlNqiMuoqWrB5BOYic+jEeA89NMk+thAbFpuVNxaaWscruJRjdEnvguiuZza9OkO9cXC1zMRUyTYF1Sefp+zbqI6ysMSQ27GWRVfUFuyfYhEOlwuhig9mBQ0KjA8YbJxAS7yrsgJY1yF6lJbApVT46TKRXrlVKYZN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGvjk/VLComexPRB46P9dDqzIndz0k8e31ay39RANRc=;
 b=rJzeKUftSAiAw7umPNdDilGTyqnxsb+WPINLQ8PL7j8geXDrJJVBL23cLtcm+QQULKXg7gnqSD4uyNqj3z3YedXT8DKJapAXqhmwhcFNJtS/lb2S2YKKw8FvpweKRHUjkcGgHEyR11c6kk3XRfsi86DPjJweAZs9bqUCPiEn8Ci+CRVH5NkputMvvb46QItVUltA7hnQB34iliTPCPAxZqKHuhTaVvL9AWMPm9IDtgBdd5I09y3p2Wfrw9g/jM0MjkfArcuqXbDwvvpsUMijnZy33udKjYPa2B7nH8r+eorE7/Ixfsy0sxs2/DJy05ReZTpS7lrbDuHsJra8h52DTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGvjk/VLComexPRB46P9dDqzIndz0k8e31ay39RANRc=;
 b=yD1f7B3dw17yF8vQ+VYtkRRcFxddsAv62QrvTJ2NlB0CKbjh1dI1LycirGqFjTLQK4J6qKFhSk0SQPOVCHHQ3QBiq2bU6x23hHjY+YAetHPq/cxreNAl1zrg3uDSQWxxvk7klEhfR77DWJXxITrxy05rFrLZiL7smQZT4xZDkfs=
Received: from MN0P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::28)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 22:27:53 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52b:cafe::87) by MN0P223CA0002.outlook.office365.com
 (2603:10b6:208:52b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 22:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 22:27:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 17:27:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 17:27:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 17:27:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.3
Date: Wed, 15 Jul 2026 18:27:31 -0400
Message-ID: <20260715222732.2719273-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ce238c-843e-4b12-eccc-08dee2c04f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|3023799007|18092099006|11063799006|56012099006|5023799004|18002099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: 1TcpH1xd6KDJn27W2RGKgosUSRlzOqtQUUVoKuS02OIYJnVNVQsshr120pErCmn5wESkQbB9GeiCG5sg1/xFhv63nYfLbbOfxKzgiKhTp+DfUTUXn+eBDS9vqBgIO9kXVABAFuaYk+km/tKbPesNEa78kqq8vJ+c3mtKqxFfkZQ+caBGjzFwn63VWVBQl9EzXrcGXTWxKemYIh+u89BZ65OFMONUTgw5F4O9DDCUDKmRO/JVy6OChHLqEMg4snyySffwYiP0lfhXlsiSJIZhELECNQ8O+IAsi1ouQF974pJkVB4Kn8rzqcXPc0OMS2IA4As6JrgFEBzpNFjLvrnU/kc8w9Pcb08CEYeCLArkXIUwavsWg2kmBc2e4x2UFDGJqNMxhzKSADfS7tFeEbRoXMQIFo1kOnjpxp7uQDQug+GSEkDaPI3JY7Yk2ocVP53tUfx+b3UjF8UQpG6F13qjDu2fsMdKHj5RGuTnK6gt61imCXd+56LdB6uibX569NZtYHTareUnStOz0lLrDx2m3wSEm5H8yo48YlRyrtJOlBqC6tYVQapXLkoUjxqFpnmIH7WwgxSuxEtrK8Y4anVTW0zZPu554RALYFNXLorXD/pj0jE7nOPUf645vQlFGQ3btXaNeWL2/rqzPFph+jFpjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(3023799007)(18092099006)(11063799006)(56012099006)(5023799004)(18002099003)(10067099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NEHhZcEE5BWROqyDUXuJfV7Z3iiUsixy+n05rIiMOdIpDB4Lb7+YPUiydTCnGwUds4D6KNGhK8x8deucM5pCoQF47Wb59OCNaPAhUlj6mB4ZM+Fr/NXvCHE1juebtZZSSElPFcb+KwpJMXgLA0h+kNx+YJ6Ejs+iBrOLHJytMALj8OEoxoycG+hnf64PDBNSD6XiipGJbMUBZ5pYi1PtvjTbFMku7JDbVN05mYM2y83rSo6I55AeK3i6cy0+BRgdw3wMbC55fM//0wM276rSRgtFEIXfmldtod8/z1k5dw/R12tbRb3f1MufTm5fEU4iDs60awX0yGSf989u805UoiSTHDXfEfv9zxszSDpvtMYSqvsoTwYwwjkXbeVG4cR1r990WE8gB0dvh/rA2GYxMjCYnXrFxicGQq382NI7O5GQt/4CfJnNYMlbUQseP7QA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 22:27:52.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ce238c-843e-4b12-eccc-08dee2c04f54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
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

Updates for 7.3.

The following changes since commit e3cdab67efa8b1981620c792a845da91f75aaa63:

  Merge tag 'amd-drm-next-7.3-2026-07-09' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2026-07-10 11:43:22 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-07-15

for you to fetch changes up to 5ab89b491f215f69b750130ead2ff6bbde6c0e2e:

  drm/amdgpu: add mes gang contex alloc/free helper (2026-07-15 09:15:43 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-07-15:

amdgpu:
- mmhub 4.2 update
- DCN4.2 updates
- DC CACP support
- DMUB updates
- PSR fixes
- Replay fixes
- Change system_unbound_wq with system_dfl_wq
- GC 12.1 ip dump support
- DCN4 fixes
- DCN4.2 updates
- DSC fixes
- More DC KUNIT tests
- JPEG cleanups
- NUTMEG fixes
- 8K fix
- Backlight fixes
- Cursor fixes
- UserQ fixes
- Fix bo->pin leak in amdgpu_bo_create_reserved()
- MES11 updates
- Loosen VFCT bios parsing to deal with pci=realloc messing around with the PCI buses
- DCN pageflip timeout fixes
- devcoredump fixes
- MCLK DPM fix for bonaire SKU
- DCE fix for DP MST when analog encoders are present
- SI AC/DC switch fix
- SMU7 AC/DC switch fix
- VM fence handling fix
- PCIe DPM fix
- SMU 13 updates
- SMU 15 updates
- Inline drm_simple_encoder_init()
- RAS updates
- HDA sound fix
- Handle dependency between GPU and XHCI devices

amdkfd:
- Bounds checking in CWSR size calculation
- DQM init failure fixes

radeon:
- Loosen VFCT bios parsing to deal with pci=realloc messing around with the PCI buses

----------------------------------------------------------------
Alessandro Rinaldi (1):
      drm/amd/display: Force PWM backlight on Lenovo Legion 5 15ARH05

Alex Deucher (7):
      drm/amdgpu: update mmhub 4.2.0 client list
      drm/amdgpu/gfx12.1: Add ip dump support
      drm/amdgpu/gfx9: fix IP dump alloc ordering
      drm/amdgpu/gfx10: fix IP dump alloc ordering
      drm/amdgpu/gfx11: fix IP dump alloc ordering
      drm/amdgpu/gfx12: fix IP dump alloc ordering
      drm/amdgpu: always emit the job vm fence

Alex Hung (32):
      drm/amd/display: Fix KUnit backlight tests for CACP
      drm/amd/display: Add KUnit tests for ism
      drm/amd/display: Test EDID and ACPI/VBIOS readers
      drm/amd/display: Test DPCD AUX and Synaptics helpers
      drm/amd/display: Test MST start/stop and panel settings
      drm/amd/display: Test I2C, stubs and MST early returns
      drm/amd/display: Test MCCS FreeSync VCP helpers
      drm/amd/display: Test MST payload and DSC enable helpers
      drm/amd/display: Test irq funcs/suspend/workqueue
      drm/amd/display: Test irq state setters and work
      drm/amd/display: Test HPD init/fini
      drm/amd/display: Test HPD interrupt handling
      drm/amd/display: Test dmub HPD callbacks and handlers
      drm/amd/display: Test high-IRQ and handler registration
      drm/amd/display: Test top-level IRQ handler and vmin/vmax worker
      drm/amd/display: Test format info and blending
      drm/amd/display: Test GFX9/GFX10 plane modifiers
      drm/amd/display: Test GFX11/GFX12 plane modifiers
      drm/amd/display: Test plane scaling info paths
      drm/amd/display: Test plane buffer attributes
      drm/amd/display: Test GFX9 DCC plane attributes
      drm/amd/display: Test GFX12 DCC plane attributes
      drm/amd/display: Test DCC and cursor edge cases
      drm/amd/display: Test helper_check_state rejects
      drm/amd/display: Test plane atomic check and hooks
      drm/amd/display: Add KUnit test for wb jobs
      drm/amd/display: Test MST coverage gaps
      drm/amd/display: Test backlight level programming path
      drm/amd/display: Test backlight level readback path
      drm/amd/display: Test backlight device registration
      drm/amd/display: Test panel power savings sysfs
      drm/amd/display: Test backlight ABM property attach

Anas Khan (1):
      drm/amd/display: remove duplicate link_dp_panel_replay.h include

Andre Luiz Batista Bueno (1):
      drm/amdgpu: deduplicate JPEG v5.0 interrupt routine

Andriy Korud (1):
      drm/amd/display: dce100: skip non-DP stream encoders for DP MST

Asad Kamal (4):
      drm/amd/pm: add jpeg/vcn busy to smu_v15_0_8 gpu metrics
      drm/amd/pm: update smu_v13_0_6 acc gpu metrics
      drm/amd/pm: Update smu_v15_0_8 gpu metrics
      drm/amd/pm: Fix pp_entries_max() bios check

Austin Zheng (1):
      drm/amd/display: Add Debug Option To Enable Per-DPM De-rate Usage

Bhawanpreet Lakha (9):
      drm/amd/display: Add more tests for HDCP
      drm/amd/display: More Kunit tests for audio
      drm/amd/display: Add color space and timing tests for connector
      drm/amd/display: Add subconnector property tests for connector
      drm/amd/display: Add FBC init tests for connector
      drm/amd/display: Add MST link detection tests for connector
      drm/amd/display: Add crtc matching and panel type tests for connector
      drm/amd/display: Add CACP caps tests for connector
      drm/amd/display: Add stream property tests for connector

Bhuvanachandra Pinninti (1):
      drm/amd/display: Fix dc_stream_remove_writeback dropping wrong writeback entries.

Ce Sun (2):
      drm/amdgpu: use IP version check in sysfs creation conditional logic
      drm/amdgpu: drop debug_enable_ras_aca debug mask flag

Charlene Liu (6):
      drm/amd/display: add null pointer access check
      drm/amd/display: ensure dtbclk clk_src selected before hdmistream_clk_en
      drm/amd/display: limit reuse dsc capable bootup timing
      drm/amd/display: enable hdmistreamclk_rcg by default for dcn42
      drm/amd/display: add DST_Y_DELTA_DRQ_LIMIT reg macro for later use
      drm/amd/display: add DST_Y_DELTA_DRQ_LIMIT hw programming

Chenyu Chen (3):
      drm/amd/display: Enable CACP on Linux
      drm/amd/display: Fix dead-code panel type detection from DID
      drm/amd/display: Add KUnit tests for CACP on Linux

Dillon Varone (1):
      drm/amd/display: Generalize DMUB memory flushes from host

Dmytro Laktyushkin (4):
      drm/amd/display: update memclk clock table read for dcn42
      drm/amd/display: remove unused dcn42 socbb values
      drm/amd/display: fix dcn42 det allocation order
      drm/amd/display: fix dcn42b det allocation order

Dominik Kaszewski (2):
      drm/amd/display: Remove sink usage from DPMS
      drm/amd/display: Fix indenting of dpms on

Dyllan Kobal (1):
      drm/amd/display: fix wrong register field in dccg35_set_hdmistreamclk_src_new

Fangzhi Zuo (3):
      drm/amd/display: Fix 8K Mode Not Parsed by EDID
      drm/amd/display: Allocate DCN32/1 dmub memory to GTT
      drm/amd/display: Skip Update HDCP Config In Transition State

Gabe Teeger (3):
      drm/amd/display: Enable PSR and Replay on DCN4 variant [Part 2]
      drm/amd/display: Enable IPS support for DCN4 Variant
      drm/amd/display: Enable zstate support and fix seamless boot

Geoffrey McRae (3):
      drm/amd/display: Fix DM I2C teardown race
      drm/amd/display: Fix DM IRQ teardown races
      drm/amd/display: Use unbound workqueues for deferred DM work

Gleb Markov (1):
      drm/amd/display: Remove unused-but-set variable hubp from

Guangshuo Li (2):
      drm/amd/display: move connector state dereference after NULL check
      drm/amdkfd: free MQD managers on DQM init failures

Iswara Nagulendran (1):
      drm/amd/display: Fix VABC Init and OLED Support

James Lin (4):
      drm/amd/display: program dither on all OPP heads under ODM combine
      drm/amd/display: Add MALL status readback support for DCN 4.0.1
      drm/amd/display: Re-evaluate cursor mode on plane position/size change
      drm/amd/display: don't re-evaluate cursor mode on cursor plane movement

Jesse Zhang (2):
      drm/amdgpu/userq: fix indefinite fence wait during GPU reset
      drm/amdgpu/mes11: set remove_queue_after_reset for reset unmap path

Karthi Kandasamy (1):
      drm/amd/display: Fix DMSS not triggering for HDR to SDR transition

Leo Chen (1):
      drm/amd/display: Enable HUBP/DPP Driver PG for DCN42

Leo Li (3):
      drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock
      drm/amd/display: check GRPH_FLIP status before sending event
      Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"

Marco Crivellari (1):
      drm/amdgpu: Change system_unbound_wq with system_dfl_wq

Mario Limonciello (10):
      drm/amd/display: Fix backlight max_brightness to match exported range
      drm/amdgpu: Fix VFCT bus number matching with soft filter
      drm/amdgpu: Release VFCT ACPI table reference
      drm/radeon: Modernize VFCT error handling
      drm/radeon: Fix VFCT bus number matching with soft filter
      drm/radeon: Validate VBIOS signature in VFCT path
      drm/amdgpu/display: Add amdgpu_display.c documentation
      drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen Pinnacle Ridge
      drm/amd: Move dynamic PCIe switching quirks to X86_MATCH_* macros
      drm/amd: Create a device link between APU display and XHCI devices

Matthew Stewart (3):
      drm/amd/display: Fix DCN42B null registers & register masks
      drm/amd/display: Add passive dongle handling in force_to_use_aux case
      drm/amd/display: Add DCN42B VID_CRC_CONTROL and HBLANK_CONTROL registers

Michał Mirosław (5):
      drm/amd/display/amdgpu_dm: show error names
      drm/amd/pm/smu7: make SMU message reports more readable
      drm/amd/pm/smu7: return error on message send failure
      drm/amd/amdgpu/cgs: Avoid redundant copying of firmware filename
      drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info

Nicholas Kazlauskas (1):
      drm/amd/display: Exit LS for ISHARP before coefficient write

Nicolás Antinori (1):
      drm/amdgpu: Inline drm_simple_encoder_init()

Nícolas F. R. A. Prado (1):
      drm/amd/display: Always notify the HDA driver on connector disconnect

Pengpeng Hou (1):
      drm/amd/display: wire DCN42B mcache programming callback

Prike Liang (5):
      drm/amdgpu: add RS64 local memory context array init/fini
      drm/amdgpu/mes: add MES process/gang context size and bitmap helper
      drm/amdgpu: add mes process context alloc/free
      drm/amdgpu/mes11: get MES process/gang contex size
      drm/amdgpu: add mes gang contex alloc/free helper

Randy Dunlap (1):
      drm/amdgpu: drop kernel-doc for deleted struct fields

Roman Li (1):
      drm/amdgpu/discovery: Fix device family for DCN42

Srinivasan Shanmugam (3):
      drm/amd/display: Check dc_link before applying DSC policy
      drm/amdkfd: Do not fail process debugfs setup on debugfs errors
      drm/amd/display: Run FP-disabled MST stub test only without DC FP

Stanley.Yang (1):
      drm/amdgpu/ras: only check bad page for address-based UMC injection

Taimur Hassan (1):
      drm/amd/display: Promote DC to 3.2.389

Timur Kristóf (11):
      drm/amd/display: Fix preferred link rate for NUTMEG
      drm/amd/display: Add dp_skip_rbr flag for NUTMEG
      drm/amdgpu: Print vmid, pasid and more task info in devcoredump
      drm/amdgpu: Reserve space for IB contents in devcoredumps
      drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)
      drm/amd/display: Set native cursor mode for disabled CRTCs
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initialized
      drm/amd/pm/si: Fix AC/DC switch notification
      drm/amdgpu: Fix IP block NULL check during soft reset
      drm/amd/pm/smu7: Fix AC/DC switch notification
      drm/amdgpu/ttm: Consider concurrent VM flushes for buffer entities

Tom Chung (1):
      drm/amd/display: Tear down dangling pipe on boot to fix s0i3

Venkat Rao Bagalkote (1):
      drm/amd/display: Shorten KUnit exported symbol names

WenTao Liang (1):
      drm/amd/display: set new_stream to NULL after release

Xiang Liu (1):
      drm/amd/ras: initialize CPER after XGMI reset on init

Yongqiang Sun (1):
      drm/amdkfd: fix 32-bit overflow in CWSR total size calculation

Zhu Lingshan (1):
      drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

Ziran Zhang (1):
      drm/amd/display: Remove redundant NULL check before kfree() in mod_power_create()

yanglinlin (1):
      drm/amd/display: fix __udivdi3 link error

 .../gpu/amdgpu/display/display-manager.rst         |    9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |   62 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |   54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |   19 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  200 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |    5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  277 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h           |    8 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |   63 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   87 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |   65 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           |    4 -
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    4 +
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |   23 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  337 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   11 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |   38 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h    |    4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   71 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   15 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   92 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   15 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   70 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |   16 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   76 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |    5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   90 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h  |   41 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  546 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |   57 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |    4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |    1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   57 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |   13 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |   18 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |    4 +
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |  118 +
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  734 +++-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 1655 +++++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |  240 ++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       | 3867 ++++++++++++++++++--
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   | 3199 +++++++++++++++-
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |  353 ++
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |  375 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c | 2078 ++++++++++-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   44 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |   16 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  214 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   21 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   10 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |    4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    8 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |   11 +-
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h |    5 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile        |    4 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   11 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |   73 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c |  213 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h |   20 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c  |    4 +-
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |   10 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |    6 -
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |   25 +-
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |    3 +-
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.h   |    4 +-
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |    3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h |    3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |   51 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |    5 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   12 +-
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c    |   40 +-
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h    |    2 +
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |   70 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |   15 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   23 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |    3 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   27 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  192 +-
 .../display/dc/link/protocols/link_dp_capability.c |    6 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |    1 -
 .../dc/link/protocols/link_edp_panel_control.c     |   13 +-
 .../display/dc/resource/dce100/dce100_resource.c   |    7 +-
 .../display/dc/resource/dcn401/dcn401_resource.h   |    3 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |    7 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.h |    1 +
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |   55 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.h   |  159 +-
 .../dcn401/dcn401_soc_and_ip_translator.c          |   16 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |    9 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   55 +-
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |   11 +
 drivers/gpu/drm/amd/display/modules/power/power.c  |   16 +-
 .../gpu/drm/amd/display/modules/power/power_abm.c  |  136 +-
 .../drm/amd/display/modules/power/power_helpers.h  |   10 +
 .../gpu/drm/amd/display/modules/power/power_psr.c  |    7 +
 .../drm/amd/display/modules/power/power_replay.c   |    7 +
 drivers/gpu/drm/amd/include/amd_shared.h           |    3 -
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |   47 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |   17 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |    7 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   16 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |   15 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c  |   25 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   12 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   11 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |   30 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |   45 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |    7 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |    2 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |   83 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    3 +-
 drivers/gpu/drm/drm_panel_backlight_quirks.c       |    9 +
 drivers/gpu/drm/radeon/radeon_bios.c               |   64 +-
 include/drm/drm_utils.h                            |    1 +
 142 files changed, 15830 insertions(+), 1576 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h
