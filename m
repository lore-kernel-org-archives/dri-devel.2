Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E15CD6E60
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 01:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EA4112538;
	Thu,  4 Jun 2026 01:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VCoKGy4c";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0B0112538;
 Thu,  4 Jun 2026 01:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeuQVF1BUEfbh8WghKLpN6szLwYInfrrfUcDIdO9PdLBTjGCEj5hgaKrXB77eWhN7ZC1VjEBX1pL/RSrRSf7evhtLLMnf8gKeVT4vWpSTUnoS1A4mtFKYcY6RzoUEHNAR/cy37E2ZzwvLe+JyqdmyjKRHtwxoWAsmIh9wkIMwut7dclbI3nDbzCZfdWV1mGHzYhyYukWrvyu4iN3NZGs9MhhtAfzFblsNjOLXYWLx0iuj4+aYXc3cqGry3jJNiJG8mCPq1f2ysvf5nWL7Wql4CpYTknghSUWUpFpt0EeZP+vIMuZCtoHMn3eqlI7UmCW5iec38eGuYUwlac8cMxq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/DOdLrwRd49aKYdwEx5IR/Q8zt+dQhEZ48bLpuHLCE=;
 b=EukwfE8XeDX01dVA5yq4gQpAGXLmMA4o2BnJiF6H1bpL8I250hSzhnHZecnH18Gg4jEXIWybn39d15x8MGpjC62JX+4UGhJ7R4qK77I7hPmqQV8JIqa/N9U/5KxmpNdGT03URswev0WixbCP9nd6zLdpObK901OO7zB516ST4/wtpirpWHUwFICMz6JXzCy+hB72ovH4JcqR4T5hBmaKaLuKe/h3c2cPU1W9kp9Hv2C9+0df9t8RcB5VY+WFJ4+HIhcjACa6vJnHgLqhGQLHvhaMptxzbbA0Zcgh8kmWuYVM6nA/H3y9cwhrYnsQ7Kw+jRLFz0v5U0iIYR+ULxE2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/DOdLrwRd49aKYdwEx5IR/Q8zt+dQhEZ48bLpuHLCE=;
 b=VCoKGy4cPKiErli70lciVVoZ6779P1prJeTAXuJm9gIILvLRWDoODPyp/cDlW2sUxMKVa0rLC5T9DVWqOI6uiDMloHB91IXPClmbqyoNKT7iZKuMVux/vnUwDNqOWAjDi4+WcNcXYKKF4GUJK2PbUhObXWH2ZRerNr0mHiSPOhk=
Received: from BL0PR01CA0030.prod.exchangelabs.com (2603:10b6:208:71::43) by
 MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:35:36 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::3f) by BL0PR01CA0030.outlook.office365.com
 (2603:10b6:208:71::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 01:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 01:35:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 20:35:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 20:35:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.2
Date: Wed, 3 Jun 2026 21:35:25 -0400
Message-ID: <20260604013527.2373534-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: fc860a9c-17bb-4002-1b50-08dec1d993a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|13003099007|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: em2qdhXjqUmOo+kKQOczNAlj43nSxUvFcRzkfSPsshjl2+LupfJ+AzL5VJzXx+N1JL+KipY3l9RsmfCynGncv1gU+JkpqsQlrJ1dAkb6Fq5QGYLGEw+fvsG6rb+0a8NFKHbkdPaThUwZtRP0fuR6Yp9SYip2DNo/jqm3hZnZdO9/51OzbCkKo4oZNO9nCPSGhyIT/wKXie5LmMDsMur4OQDiZRM4uKSqZMhbttP509PGKj5os1Btq6R5PP0ewHToVUilL49j+oYm91icxmIkWY2WC9ViYPuEYH6lLThQmikY3MCjgVwJpJJ7kqhnxeFfjk9RnniGsbDUK9DNY3paTCMVjOjcw3RjBUboYDMlB5BMtDus0Jk8qr3dJSdINniWvcQ1PzHUOoBdvk0Wl5l2nPrP0Lct+po/ZhN8mW9fcsN8ukDWk500PyP9LBGLpYXeL7cpKwtuFPQQPD4zyc0kDahmFDZlvLf4HwUBVBKAU2DOKpc7o9sZ4fsOLnJ1UeqhmwLHSfoU1jd92GaQKBYGrAhL1J6HY5p6hwdl8A3HIZKUF2hSNI4DwIb6gVrRoA+8nEa4+03K8beNBZwdjI95oSipCSl0WTByTVIvckYd2fFX+ZmF6DNhO2mSf/7KuiJ4lSr0VplABUYYRGI/nfL+G7jgEExTVXKpTCmQrPci6/L5aY7sgeJW+4yH51DoT64N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(13003099007)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZZwW2FdZEtL6F02hTgz0WAYe+iSzCi3H53+TSNO5FXifL3EXKN7NeF8CgdfNcR/Rs8d4NhbCau/bg4jUSys8INsK/SBCyELFJhlUkKgBrkx1apwhh4FH6sznh9c4ne8a0NyQ27moYFHIj+QZqtdalsP1A0ApMEmlMTdlTDWq2M2lrImjdlexvWg8eSjLW+bQxfPatYHkKrxLAv/5Of9jckzcvJqhZCGsTscOrH3f2zDIw0xR2i7QwKtVwd9wMXJ4SGWEVVRgB/DKArxs98alRtS6QvaUoi2IPPRcuORUgq34Lb4+ifaFNC6R6AKm7iNZgG4Bs3YljFjYL3p4WDVSrA3QjE+zlDES1VxsW3691PYMMBSJRdcxiDEzl6iew1Xr8VtZPGJjTr+CdUZJjE5XTZetFztOmF4n5HPV4/GgPGC9PZF2AkU8/YId212F4D74
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:35:36.1944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc860a9c-17bb-4002-1b50-08dec1d993a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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

Last big update for 7.2.

The following changes since commit 470d1ae31d29f90b8998c5c08ee0b267a05fe378:

  drm/amd/display: Add a default case for dc_status_to_str (2026-05-28 16:21:42 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.2-2026-06-03

for you to fetch changes up to 3ea273267fd29cbf6d83ee72329f59eb5042605b:

  drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set_soft_freq_limited_range (2026-06-03 14:02:35 -0400)

----------------------------------------------------------------
amd-drm-next-7.2-2026-06-03:

amdgpu:
- BT.2020 fix for DCE
- DC bounds checking fixes
- SDMA 7.1 fix
- UserQ fixes
- SI fix
- SMU 13 fixes
- SMU 14 fixes
- GC 12.1 fix
- Userptr fix
- GC 10.1 fix
- GART fix for non-4K pages
- DCN 4.x fixes
- DCN 4.2 updates
- More DC KUnit tests
- PSR cleanup
- Support for connectors without DDC pins
- Initial DCN 4.2.1 support
- Initial HDMI 2.1 FRL support
- Misc bounds check fixes
- RAS fixes
- GC 11.5.6 support
- SDMA 6.4.0 support
- NBIO 7.11.5 support
- IH 6.4.0 support
- HDP 6.4.0 support
- MMHUB 3.4.2 support
- SMU 15.0.5 support
- ATHUB 3.4.2 support
- VPE 2.2 support
- Devcoredump fixes
- _PR3 fix

amdkfd:
- UAF race fix
- Fix a potential NULL pointer dereference
- GC 11 buffer overflow fix for SDMA
- Profiler locking order fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/sdma7.1: fix support for disable_kq

Alex Hung (13):
      drm/amd/display: Enable gcov coverage for amdgpu_dm KUnit builds
      drm/amd/display: Add KUnit tests for color LUT functions
      drm/amd/display: Extract transfer function helpers
      drm/amd/display: Add more color KUnit tests
      drm/amd/display: Refactor amdgpu_dm_initialize_default_pipeline
      drm/amd/display: Fix gamma 2.2 colorop TF direction in tests
      drm/amd/display: Add KUnit tests for amdgpu_dm_colorop
      drm/amd/display: Add more KUnit tests for amdgpu_dm_ism
      drm/amd/display: Extract dm_ism_dispatch_next_event
      drm/amd/display: Add KUnit tests for dm_ism_dispatch_next_event
      drm/amd/display: Add KUnit tests for amdgpu_dm_psr_set_event
      drm/amd/display: Export symbols for KUnit test modules
      drm/amd/display: Clean up PSR helper functions

Alysa Liu (1):
      drm/amdkfd: fix UAF race in destroy_queue_cpsch

Andrew Martin (1):
      drm/amdkfd: Fix buffer overflow in SDMA queue checkpoint/restore on GFX11

Asad Kamal (1):
      drm/amd/pm: bound pp_dpm_set_pp_table() memcpy

Aurabindo Pillai (1):
      drm/amd/display: widen FRL debug knobs to unsigned int

Caden Chien (2):
      drm/amdgpu/nbio: enable doorbell range init for vpe on v7.11.5
      drm/amdgpu/vpe: add vpe v2.2.0 support

Candice Li (7):
      drm/amd/pm: return -EINVAL on invalid CCLK OD core index
      drm/amdgpu/pm: fix SmartShift bias sysfs store PM refcount on parse error
      drm/amd/ras: validate RAS EEPROM tbl_size before record count
      drm/amdgpu: validate RAS EEPROM tbl_size before record count
      drm/amdgpu: NUL-terminate securedisplay debugfs input from userspace
      drm/amd/pm: use kcalloc in phm table copy helpers
      drm/amd/amdxcp: use kasprintf for XCP platform device names

Charlene Liu (1):
      drm/amd/display: Add DC_VALIDATE_MODE_AND_PROGRAMMING condition check for force odm2:1

Chenglei Xie (1):
      drm/amdgpu: grow VF RAS bad page table with bounded dynamic alloc

Christian König (1):
      drm/amdgpu: fix waiting for all submissions for userptrs

Chuntao Tso (1):
      drm/amd/display: Enable frame skipping in 0x37B

Dmytro Laktyushkin (2):
      drm/amd/display: Enable dcn42 pstate pmo
      drm/amd/display: Add DCN42 PMO init_for_pstate_support

Donet Tom (1):
      drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K page size systems

Fangzhi Zuo (2):
      drm/amd/display: add HDMI 2.1 Compliance Support
      drm/amd/display: Disable FRL and add module param to enable it

Feifei Xu (2):
      drm/amdgpu: Add size guard before copy discovery binary
      drm/amdgpu: fix shift-out-bounds warning of number_instance

Gabe Teeger (1):
      drm/amd/display: Handle aux_inst for connectors without DDC pin

Harish Kasiviswanathan (2):
      drm/amdgpu: Use asic specific pte_addr_mask
      drm/amdgpu: drm/amdgpu: Set correct DMA mask for gfx12.1

Harry Wentland (19):
      drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()
      drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Bound VBIOS record-chain walk loops
      drm/amd/display: Add HDMI FRL definitions to includes
      drm/amd/display: Add DML changes to support HDMI FRL
      drm/amd/display: add HDMI 2.1 FRL base support to DML 2.0
      drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL
      drm/amd/display: Add FRL support to clk_mgr, dsc, hdcp
      drm/amd/display: Tie FRL programming together in HWSS
      drm/amd/display: Add DC resource support for FRL
      drm/amd/display: Add DC link support for FRL
      drm/amd/display: Add support for FRL to DC core
      drm/amd/display: Update HDCP and info_packet modules for FRL
      drm/amd/display: Tie FRL support into amdgpu_dm
      drm/amd/display: add HDMI 2.1 DSC over FRL support

Ilya Bakoulin (1):
      drm/amd/display: Avoid DPMS-on for phantom stream

Ivan Lipski (1):
      drm/amd/display: Rename hdmi_frl_borrow_mode

Leorize (1):
      drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs

Mario Limonciello (2):
      drm/amd: Fix amdgpu_device_find_parent()
      drm/amdgpu: Adjust _PR3 detection

Matthew Stewart (8):
      drm/amd/display: Add no_native_i2c codepath
      drm/amd: Add register header files for DCN42B
      drm/amd/display: Add DCN42B DC resource files
      drm/amd/display: Add dcn42b_soc_bb to DML2
      drm/amd/display: Add DCN42B code to DC
      drm/amd/display: Add DCN42B DMUB support
      drm/amd/display: Enable DCN 4.2.1 in amdgpu_dm
      drm/amd/display: Enable DM for DCN 4.2.1

Muhammad Bilal (1):
      drm/amdkfd: fix NULL dereference in get_queue_ids()

Nicholas Kazlauskas (1):
      drm/amd/display: Enable DCN42 PMO policy

Ovidiu Bunea (3):
      drm/amd/display: Update get_pixel_clk_frequency() for DCN4x DCCG DP DTO
      drm/amd/display: Change default driver setting for "Force ODM2:1 for eDP" policy
      drm/amd/display: Fix DP_PIXEL_FORMAT fields & update clk_src for DCN4x

Pratik Vishwakarma (7):
      drm/amdgpu: Add support for GC IP version 11.5.6
      drm/amdgpu: add support for SDMA IP version 6.4.0
      drm/amdgpu: add support for NBIO IP version 7.11.5
      drm/amdgpu: add support for IH IP version 6.4.0
      drm/amdgpu: add support for HDP IP version 6.4.0
      drm/amdgpu: add support for MMHUB IP version 3.4.2
      drm/amdgpu: Add support for SMU 15.0.5

Prike Liang (3):
      drm/amdgpu: reserve TTM move fences slot for rearming eviction fences
      drm/amdgpu: unmap userq for evicting user queue
      drm/amdgpu: improve the userq seq BO free bit lookup

Priya Hosur (1):
      drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set_soft_freq_limited_range

Samson Tam (1):
      drm/amd/display: Check for sharpening case when calculating max vtaps for scaler

Shiwu Zhang (2):
      drm/amdgpu: fix buffer overflow during vBIOS update
      drm/amdgpu: fix duplicated buffer allocation for concurrent

Shubhankar Milind Sardeshpande (1):
      drm/admgpu: Add support for ATHUB 3.4.2

Srinivasan Shanmugam (2):
      drm/amd/display: Fix kdoc parameter names for DSC padding helper
      drm/amd/display: Add missing kdoc for ALLM parameters

Stanley.Yang (4):
      drm/amd/ras: Return RAS TA injection result to userspace
      drm/amd/ras: snapshot remote cmd header to fix double-fetch
      drm/amd/ras: Remove redundant error log
      drm/amdgpu: harden FRU PIA parsing with bounded helpers

Sunil Khatri (2):
      drm/amdgpu/userq: remove the vital queue unmap logging
      drm/amdgpu/userq: move wptr_obj cleanup in mqd_destroy

Taimur Hassan (2):
      ddrm/amd/display: [FW Promotion] Release 0.1.61.0
      drm/amd/display: Promote DC to 3.2.384

Timur Kristóf (3):
      drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on all SI
      drm/amdgpu: Use gmc->noretry instead of amdgpu_noretry directly
      drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as needed

Tvrtko Ursulin (1):
      amd/amdkfd: Fix profiler lock init order

Vitaly Prosyak (4):
      drm/amdgpu: fix KASAN slab-out-of-bounds in amdgpu_coredump ring dump
      drm/amd/pm: Add empty string validation to sysfs store functions
      drm/amd/pm: Reject negative values in thermal_throttling_logging
      drm/amdgpu: set noretry=1 as default for GFX 10.1.x (Navi10/12/14)

Wenjing Liu (1):
      drm/amd/display: Add DRAM table fields to clk_mgr_internal

Xiang Liu (2):
      drm/amd/ras: make UNIRAS CPER debugfs header legacy-compatible
      drm/amd/ras: chunk UNIRAS CPER debugfs reads

Yang Wang (4):
      drm/amd/pm: apply SMU 13.0.10 workaround during MP1 unload
      drm/amd/pm: fix smu13 power limit default/cap calculation
      drm/amd/pm: mark metrics.energy_accumulator is invalid for smu 14.0.2
      drm/amd/pm: zero unused SMU argument registers

Yunxiang Li (2):
      drm/amdgpu: set sub_block_index for mca ras sub-blocks
      drm/amdgpu/ras: add ras_suspend callback and use it for cp_ecc_error_irq

 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    74 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     |    95 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |    26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    98 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c  |    33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   111 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |     1 +
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c            |     3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |    12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |     2 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c        |    12 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c          |    12 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          |    14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c           |    12 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c         |    12 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |     4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |    16 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |     5 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |     2 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c            |     3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |   154 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |     5 +
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |     9 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |    49 +-
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c        |     9 +-
 drivers/gpu/drm/amd/display/Kconfig                |     2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |     3 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   192 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |    69 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |    29 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |    22 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |     5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    33 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |     2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    74 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |    85 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |     7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    79 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |    21 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |     4 +-
 .../drm/amd/display/amdgpu_dm/tests/.kunitconfig   |     8 +
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   568 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   102 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   302 +
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |    46 +-
 drivers/gpu/drm/amd/display/dc/basics/vector.c     |     4 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    15 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   169 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.h   |     5 +
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |     6 +
 .../amd/display/dc/bios/command_table_helper2.c    |     1 +
 .../dc/bios/dce112/command_table_helper2_dce112.c  |     3 +
 .../dc/bios/dce112/command_table_helper_dce112.c   |     3 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |    10 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    15 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |     3 +
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |     3 +
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |     3 +
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |     3 +
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |    12 +
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |    14 +
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    18 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |   483 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h |    48 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    36 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |     4 +
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |    49 +
 .../gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c  |     3 +
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |    45 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   295 +
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    35 +
 drivers/gpu/drm/amd/display/dc/dc.h                |   139 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |     4 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |     7 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |     8 +
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c       |     4 +-
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h     |   164 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |     2 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |     8 +
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |     1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    24 +
 .../gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c |    40 +
 .../gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.h |     8 +
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c |    88 +
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h |    13 +
 .../drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c   |    25 +
 .../gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c |    68 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |   321 +
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c   |    73 +
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h   |     4 +
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    33 +
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |     8 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |   181 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |     4 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   113 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |    26 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |    10 +-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |    10 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h   |    13 +
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |     3 +-
 .../amd/display/dc/dio/dcn20/dcn20_link_encoder.h  |     1 +
 .../display/dc/dio/dcn30/dcn30_dio_link_encoder.c  |   250 +
 .../display/dc/dio/dcn30/dcn30_dio_link_encoder.h  |    17 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c        |    18 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.c  |   114 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.h  |     8 +
 .../display/dc/dio/dcn32/dcn32_dio_link_encoder.c  |   214 +
 .../display/dc/dio/dcn32/dcn32_dio_link_encoder.h  |    16 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c        |    20 +
 .../display/dc/dio/dcn35/dcn35_dio_link_encoder.c  |    21 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c        |   220 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h        |    16 +
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.c  |    21 +
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.h  |    95 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c        |    64 +-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.h        |     6 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h         |     1 +
 drivers/gpu/drm/amd/display/dc/dm_services_types.h |     1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |     3 +
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |     5 +
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |   127 +
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h   |    22 +
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |   280 +-
 .../gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c |     1 +
 .../gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c |     1 +
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |   243 +
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |   241 +
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |    10 +
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h   |     2 +
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |    16 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |   127 +-
 .../drm/amd/display/dc/dml/display_mode_enums.h    |     1 +
 .../gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c  |   790 +
 .../gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h  |   173 +
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |     2 +
 .../drm/amd/display/dc/dml2_0/display_mode_core.c  |   104 +-
 .../drm/amd/display/dc/dml2_0/display_mode_util.c  |     3 +
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |     9 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |   227 +
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |     1 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |     1 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |    29 +-
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |     3 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c  |   223 +-
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h  |     2 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |    30 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h       |    46 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |    16 +
 .../dml2_standalone_libraries/lib_frl_cap_check.c  |   396 +
 .../dml2_standalone_libraries/lib_frl_cap_check.h  |    90 +
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c  |    30 +-
 .../display/dc/dml2_0/dml2_translation_helper.c    |     4 +
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |     2 +
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h   |     1 +
 .../drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c    |   413 +
 .../drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h    |   109 +
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c |     8 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |   704 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |     5 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |     8 +
 .../amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c |   313 +
 .../amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h |    11 +
 .../display/dc/gpio/dcn42b/hw_translate_dcn42b.c   |   192 +
 .../display/dc/gpio/dcn42b/hw_translate_dcn42b.h   |    13 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     4 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     4 +
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c     |     1 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile        |    10 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c      |   286 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h      |   146 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c    |  1043 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h    |   436 +
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h     |    47 +
 .../dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c  |   907 +
 .../dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h  |   335 +
 .../dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c    |   207 +
 .../dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h    |    59 +
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h |   198 +
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |    19 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile       |     8 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   103 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |    41 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |    19 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    49 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h    |    13 +
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |     1 +
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |    13 +-
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |     1 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |     3 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |     1 +
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    13 +-
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |     3 +
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |    42 +
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h    |     2 +
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |     2 +
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |     2 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |    40 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |     1 +
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |    38 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |     2 +
 .../drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c  |   238 +
 .../drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h  |    15 +
 .../drm/amd/display/dc/hwss/dcn42b/dcn42b_init.c   |    20 +
 .../drm/amd/display/dc/hwss/dcn42b/dcn42b_init.h   |    14 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |    34 +
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |     3 +
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h  |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |     2 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    21 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |    44 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |    10 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |     1 +
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |   176 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |   231 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |     5 +
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |    15 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |     9 +
 drivers/gpu/drm/amd/display/dc/link/Makefile       |     2 +
 .../amd/display/dc/link/accessories/link_dp_cts.c  |     2 +
 .../amd/display/dc/link/hwss/link_hwss_hpo_frl.c   |   113 +
 .../amd/display/dc/link/hwss/link_hwss_hpo_frl.h   |    34 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   111 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   223 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.h    |     1 +
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |   130 +-
 .../gpu/drm/amd/display/dc/link/link_validation.c  |   298 +
 .../gpu/drm/amd/display/dc/link/link_validation.h  |    13 +
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |   150 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.h   |     4 +
 .../display/dc/link/protocols/link_dp_capability.c |     6 +
 .../dc/link/protocols/link_edp_panel_control.c     |     7 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |  1187 +
 .../amd/display/dc/link/protocols/link_hdmi_frl.h  |    53 +
 .../drm/amd/display/dc/link/protocols/link_hpd.c   |     1 +
 .../gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c   |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h |     5 +-
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c |     8 +-
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h |     8 +-
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |     2 +
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.c   |     2 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |   179 +
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h    |    86 +
 drivers/gpu/drm/amd/display/dc/resource/Makefile   |     7 +
 .../display/dc/resource/dce112/dce112_resource.c   |     3 +
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |   126 +
 .../display/dc/resource/dcn301/dcn301_resource.c   |     1 +
 .../display/dc/resource/dcn302/dcn302_resource.c   |   109 +
 .../display/dc/resource/dcn303/dcn303_resource.c   |   109 +
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |   127 +
 .../display/dc/resource/dcn314/dcn314_resource.c   |   127 +
 .../display/dc/resource/dcn315/dcn315_resource.c   |   128 +
 .../display/dc/resource/dcn316/dcn316_resource.c   |   126 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |   131 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.h |    79 +-
 .../display/dc/resource/dcn321/dcn321_resource.c   |   132 +
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |   121 +
 .../display/dc/resource/dcn351/dcn351_resource.c   |   121 +
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |   121 +
 .../display/dc/resource/dcn401/dcn401_resource.c   |   125 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   138 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.h |     3 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |  2404 +
 .../display/dc/resource/dcn42b/dcn42b_resource.h   |   672 +
 .../dcn42/dcn42_soc_and_ip_translator.c            |     6 +-
 .../soc_and_ip_translator/soc_and_ip_translator.c  |     1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |     1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   611 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |     1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c |    34 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h |    13 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |     4 +
 drivers/gpu/drm/amd/display/include/audio_types.h  |     1 +
 .../drm/amd/display/include/bios_parser_types.h    |    15 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     3 +
 drivers/gpu/drm/amd/display/include/dal_types.h    |     1 +
 drivers/gpu/drm/amd/display/include/logger_types.h |     2 +
 drivers/gpu/drm/amd/display/include/signal_types.h |    12 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |     2 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |     6 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |     3 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |     2 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.h    |     2 +
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |     3 +
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |     1 +
 .../drm/amd/display/modules/inc/mod_info_packet.h  |     2 +-
 .../amd/display/modules/info_packet/info_packet.c  |   136 +-
 drivers/gpu/drm/amd/display/modules/power/power.c  |     9 +-
 .../gpu/drm/amd/display/modules/power/power_abm.c  |    16 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |     4 +
 .../amd/include/asic_reg/clk/clk_15_0_5_offset.h   |    42 +
 .../amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h  |    45 +
 .../amd/include/asic_reg/dcn/dcn_4_2_1_offset.h    | 16305 +++++
 .../amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h   | 60623 +++++++++++++++++++
 .../amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h  |   109 +
 .../amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h |   413 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |    32 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |     3 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c    |    10 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |     1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |     1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |    42 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |    32 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |     3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |     1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |     8 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |     7 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |    33 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c       |    26 +-
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c          |    21 +-
 350 files changed, 101794 insertions(+), 826 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h
