Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7CBCA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37A110E4B7;
	Fri,  2 Oct 2026 17:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZaHa60a";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B3010E0AE;
 Fri,  2 Oct 2026 17:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfAVPjJGz6hlmilWLPrLObwzKkLrSBYnPQPcmNP9dvrWKD9krIy0/9SEfLB3Pc402L/weJIuwKxRKVRTSn3Icjz0iJR/iHhvD10RmwHFSWvjV66XbVObmzA/pR8h2w8wBPzzdGmYUN8pUM5gvVT1OkdxiA968WgJaz+ZvwsTnL7dlHoeJ+WO1vMFdqR1b/rkJejgRqsjPim3QB28QNxa+wKBYWefsuFlbsZD3AqEG3eFf4To8U7XAVpE4Bb3mVBqk2Kbv5pO75qwHwMw8/10Z7cZ7XKGqdNGkAOd5vaQ7ch1MOWtvgIMK+8PBC/6BRoYnv1ns6cNvecCaBR70KaDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XAF+CgtfrhWYerxmgcDIxbzLTGpufS3lBH5/dcBAp4=;
 b=qHAokNNjhKj44LYoAaw0INNCsVybJvo7VFVW3giUryGWVsDZHjCCFwEF+i9t3qNixGo49qY5+KRliSZFZlYhLnNTVCz3qESGFLiZBR6DNDEdluL7PbqFIBPNdT9IjT9aE9n5kBaZTUn+LyhJ7mOZKoMvoChrR+VT0bCUwS0+6UXfUgIPDrLMDaR1rUL20tbOw1gf1A8fRAaugYmaGJ2oPhbp3x6P/Co4rkMSPnfH7qKYrUt6eplcwsBKunmQh/2x9HWozSUUKopfExSj9UWy8i78c8k3R1m6p28bnxoqxYaIw/vFna54Oz6LF4TYsMC74psKKY2zQ22nBEdsmu6TiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XAF+CgtfrhWYerxmgcDIxbzLTGpufS3lBH5/dcBAp4=;
 b=OZaHa60aDjbRS7k104EHQ3sEfFwHS2W/INCtv6rdKjDqPdzkmk8aYzXDGK7rHVnmnu1D60wn/p5xvuRzQJKsnM2L8cU+x6kdXxdV+fIDIZDKS1+OWulgLMymb0PwDAl0C4lTCGQ7cjp0RX2rxAPBYJ02l3XvsX0D0aYlzSsnh0Q=
Received: from PH8P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::16)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 17:53:34 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::4) by PH8P223CA0026.outlook.office365.com
 (2603:10b6:510:2db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 17:53:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 17:53:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 12:53:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 12:53:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.4
Date: Fri, 2 Oct 2026 13:53:15 -0400
Message-ID: <20261002175316.1428352-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cce360-6c48-4334-3439-08df20ae127e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|3023799007|10067099003|13003099007|6133799003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: IjBo155tv7T8GIMT3u0DoZFIP5HZ8hJ/xHWjNbRBCY8Xkha7dAbO2fTU4iOl2joOm0n57D79cn+pFdczzLTYUDrkoIFf07diF2qIPluDL3IQzzJltsE8Qu8N6EgPKYNJgWiDaR37QAsEsphd2djNG6G2mtQU1xxLMmAfJdVF936ZQlZZTncJVQErt6FwC8p/20jUEn1KoBOi+faFg0ITATS0hxMmOvP4FYYVL5lxGYr5g/FuvgQeSSQqVCxouO0GXuCEdJ8ffU2Lwd3sUBZdjtUPhHEFqM8/LRloDg89Lib5NWNElz9AhNvabBy/qQy6+ANpdJW8edIZUtCRRpyD/HvA/9Dj1HT6xUYyTdLKlN4sIrTGZypM9TczKg5xJhpqwGGFh/vGCruSuSXZsQAVOTzV43LBPKWca1RRgdk6mmBOWpvDUCzcf11wNlLsE7vO8UxjYBFEqHW07gf7S1VhewzmZLm0rLsTbwRDE2zvig2YaE8wO7GWmsLixpNpK6qR4z1iAWd8d2DBZpP8CcAyPgwzqEm+iqx6DkxzGsJ+IHZANDUKwxquEEOcTigG+MTK0QJ8KQnBvCCVUlW8Kb40cK3udCAG8Bc8aSZNyaCbhz64QwpbRt+cqYv9fYNFIuv+22YjwgOCSDGpcPg8oQSYkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(3023799007)(10067099003)(13003099007)(6133799003)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mdge1T9+FgCuZlFokwdD3TsGJMm2WAj2kJ+mjDyTNK5HYImMGdzqOwEc5FgYFB0BK7+a19iHbdSd3wEBLwQA6LjDXqI6y9cCtzQM+YrbQ4Bwb667C+D4u6Nh1h5Fwq/aQiCU0kn+NBqCLFD9ztjJe3k9z6s560W9D1eKyy0NzKLewegUsOOTOXu6JlBBQEQcRKhuGqiXdNO5Xhi4LAoDzFqVjRhN98cdxMMxSL9+yEHeLeLT5kmO+/NI2XSioq6AnPk9sI6KXUDKcHwzJXCOUAhIjyIOTKucDIGmwSOcSD0QeXpW7GJliSgf3dUG0ce9GXqVFzGKEWIxXszf2WghgICTyIKzqu1wWg7hBvJ4NHSTzdKsgZCqD7xpdZ4KdqUyQuo34EbwhVpic2ZBBEGu/c7RHuiz5jEEGb9FRfMB5jwGsEWyyRZhDRffKjrOTWFl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 17:53:31.5290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cce360-6c48-4334-3439-08df20ae127e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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

More new stuff for 7.4.

The following changes since commit 2abe8e7e33973dda5dd24b89aa3ee52470a78265:

  Merge tag 'amd-drm-next-7.4-2026-09-24' of https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next (2026-09-26 08:13:22 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.4-2026-10-02

for you to fetch changes up to 41505ac433cc4c5179deee8860d197b04f6d1c1d:

  Revert "drm/amd/display: Attach blend mode property for alpha planes" (2026-10-02 11:59:18 -0400)

----------------------------------------------------------------
amd-drm-next-7.4-2026-10-02:

amdgpu:
- dc_state_create_copy() fix
- HDMI RGB limited range fix
- eDP ASSR fix
- DCE 6 fixes
- DCE 8.1 fix
- SI DPM fixes
- Reset updates
- Workaround for multiple SDMA entities with DCC
- PWM backlight fix
- GPUVM fixes
- Switcheroo fix
- Error handling leak fixes
- GC 6 unload FW leak fix
- SDMA 7.1 fix
- DML frame size limit fix
- RGB vs YCbCr 4:4:4 fix
- DP MST fix
- DC Power module fixes
- MacBookPro14,3 fix
- DCN 6 updates
- Retry fault handling updates
- Drop old soft reset code
- Documentation cleanups
- IP discovery updates
- OSSSYS 8.0.1 support
- LSDMA 8.0.1 support
- SMU 15 updates
- NBIF 7.10 support
- GC 12.1 updates
- SMUIO 15.0.3 support
- MP 15.0.3 support
- SR-IOV updates
- VPE 3.0 support
- RAS updates
- MMHUB 5.0 support
- HDMI updates
- UALink updates
- HUBBUB fixes
- MES fixes
- Userq fixes
- GPUVM eviction lock rework
- Runtime PM improvements

amdkfd:
- SVM fix
- Reset fixes

radeon:
- Sparc64 fix
- Add a connector table for the Sun XVR-300

----------------------------------------------------------------
Adrian Betschart (2):
      drm/amd/display: Default HDMI RGB output to limited range on CTA modes
      drm/amd/display: Try RGB before YCbCr 4:4:4 in stream validation

Albert Esteve (3):
      drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
      drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNIT
      drm/amd/display: drop INLINE_IFN_KUNIT

Alex Deucher (8):
      drm/amdgpu: Add mmhub v5_0_1 ip headers v3
      drm/amdgpu/gmc12: properly pass flush_type to gmc_v12_0_flush_vm_hub()
      drm/amdgpu: drop userq callback assignment for sdma 7.1
      drm/amdgpu/gmc12.1: properly pass flush_type to gmc_v12_1_flush_vm_hub()
      Revert "drm/amd/display: drop INLINE_IFN_KUNIT"
      Revert "drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNIT"
      Revert "drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT"
      Revert "drm/amd/display: Attach blend mode property for alpha planes"

Alex Sierra (1):
      drm/amdgpu: disable XNACK replay for all VMIDs on GC 12.1.0 A0

Alvin Lee (3):
      drm/amd/display: Disable gamcor light sleep before gamcor program
      drm/amd/display: Add temporary programming for port control in dc_init
      drm/amd/display: Don't round up cursor width to nearest 64

Andrew Martin (1):
      drm/amdkfd: Fix always mapped range mapping to all ACCESS GPUs

Arnd Bergmann (1):
      drm/amd/display: fix unused function warnings

Arthur Heymans (1):
      drm/amd/display: Preserve eDP mode on initial ASSR failure

Ashwin Santhosh (2):
      drm/amd/display: Program OPP formatter for plane-less ODM segments
      drm/amd/display: Promote DC to 3.2.400

Caden Chien (2):
      drm/amdgpu/vpe: add vpe v3.0.0 support
      drm/amdgpu/vpe: add vpe v3.0.1 support

Candice Li (1):
      drm/amd/ras: use PCRU0 C2PMSG for Uniras on psp v15_0_3

Ce Sun (2):
      drm/amdgpu/ras: allow ClearMcaOnRead during GPU recover resume
      drm/amdgpu : Update psp 13_0_15 ip block support for uniras

Charlene Liu (2):
      drm/amd/display: avoid to write signal specific for tmds
      drm/amd/display: Fix zero dlg_reg write to program_ext_vblank

Cheng, Tony (1):
      drm/amd/display: Keep public DC lifecycle APIs stable beside Core 2

Christian König (1):
      drm/amdgpu: rework eviction lock handling into critical section v3

Clay King (1):
      drm/amd/display: adjust floating point format for gamut remap when needed

David Yat Sin (1):
      drm/amdgpu: Flush the pasid on all XCCs in parallel

Dillon Varone (2):
      drm/amd/display: Add dcn60 revision specific clock overrides
      drm/amd/display: Fix VTG programming for dcn60

Dmytro Laktyushkin (1):
      drm/amd/display: Enable dcn42 pstate pmo

Dominik Kaszewski (1):
      drm/amd/display: Add missing message to static_assert

Ed Maste (1):
      drm/amd/amdgpu: Add newlines in drm_dbg format strings

Emily Deng (1):
      drm/amdgpu/psp: wait for TOS ready on all AIDs in v15_0_3 ring create

Eric Huang (2):
      drm/amdgpu: fix atomics on DF 5.0.2
      drm/amdgpu: specify cwsr_enable usage doc

Fangzhi Zuo (2):
      drm/amd/display: Serialize HDMI FRL status polling against link detect
      drm/amd/display: Skip HDMI FRL status polling while link is down

Francisco Beltrán Millalén (1):
      drm/amdgpu: reset VI ASIC on MacBookPro14,3

Frank Min (7):
      drm/amdgpu: add GDDR7 vram name
      drm/amdgpu: add debug info for psp ip key mgr ucode
      drm/amdgpu: update FIRMWARE ID for soc24
      drm/amdgpu: add hdp v8 ip block
      drm/amdgpu: Add support for PSP version 15.0.3
      drm/amdgpu: Add firmware type retrieval in PSP v15.0.3
      drm/amdgpu: add infrastructrure for handling mp5 firmware

Fudongwang (1):
      drm/amd/display: Change default SR z8 exit/enter value

Gang Ba (1):
      drm/amdkfd: Fix TCP XNACK scoreboard reset race on MI300

Gangliang Xie (6):
      drm/amdgpu: add ta loading in psp v15_0_3
      drm/amd/ras: add support for umc v13
      drm/amd/ras: add support for GC 13
      drm/amd/ras: add support for smu v15_0_3
      drm/amd/ras: add support for nbio v7_10_0
      drm/amd/ras: add support for psp v15_0_3

Guangshuo Li (2):
      drm/amdgpu: fix IP instance memory leak on kobject add failure
      drm/amdgpu: fix ACP MFD device leak on init failure

Hari Mishal (1):
      drm/amd/display: guard dc_sink dereferences in MST mode validation

Hawking Zhang (14):
      drm/amdgpu: Add soc v2_0 ih client id table
      drm/amdgpu: Add osssys v8_0_1 ip headers v3
      drm/amdgpu: Add ih v8_0 support
      drm/amdgpu/discovery: Add ih v8_0 ip block
      drm/amdgpu: Add nbif v7_10_0 ip headers v4
      drm/amdgpu: Add pcie v6_1_3 ip headers v4
      drm/amdgpu: Add nbif v7_10 support
      drm/amdgpu: Add smuio v15_0_3 ip headers v4
      drm/amdgpu: Add smuio v15_0_3 support
      drm/amdgpu: Add hdp v8_0_1 ip headers v3
      drm/amdgpu: Add lsdma v8_0_1 ip headers
      drm/amdgpu: Add mp v15_0_3 ip headers v4
      drm/amdgpu: Add vpe v3_0_0 ip headers v4
      drm/amdgpu: Add mmhub v5_0 support

Ilya Bakoulin (1):
      drm/amd/display: Fix HDMI2.2 LT timeout duration

Imre Kaloz (2):
      drm/radeon: Read the VRAM VBIOS signature with readb()
      drm/radeon: add a connector table for the Sun XVR-300

Ivan Lipski (1):
      drm/amd/display: Enable DMUB HW cursor offload

Jackson He (1):
      drm/amd/display: Remove unused copyright notice

Jesse Zhang (23):
      drm/amdgpu: support non-guilty job save on ring backup
      drm/amdgpu: fix empty fence backup and replay intervals
      drm/amdgpu/gfx: add a detect_hung_queue callback
      drm/amdgpu/gfx12: implement detect_hung_queue
      drm/amdgpu/gfx11: implement detect_hung_queue
      drm/amdgpu/gfx: export amdgpu_gfx_mqd_reset_restore
      drm/amdgpu/mes12: restore collateral gfx queues after pipe reset
      drm/amdgpu/mes11: restore collateral gfx queues after pipe reset
      drm/amdgpu/mes11: read the gfx user queue VMID for MMIO reset
      drm/amdgpu/mes12: read the gfx user queue VMID for MMIO reset
      drm/amdgpu/gfx12: set KMD_QUEUE for kernel gfx queues
      drm/amdgpu/gfx11: set KMD_QUEUE for kernel gfx queues
      drm/amdgpu: factor out the MES user queue reset body
      drm/amdgpu/gfx: add a shared gfx pipe reset helper
      drm/amdgpu/gfx: add a gfx ME pipe reset capability helper
      drm/amdgpu/gfx: preserve collateral rings during gfx pipe reset
      drm/amdgpu/userq: fix reading the WPTR at a non-zero BO offset
      drm/amdgpu/userq: preserve kernel rings during gfx pipe reset
      drm/amdgpu/mes11: gate gfx pipe reset on PER_PIPE
      drm/amdgpu/mes12: gate gfx pipe reset on PER_PIPE
      drm/amdgpu/gfx11: defer gfx pipe reset enablement
      drm/amdgpu/gfx12: defer gfx pipe reset enablement
      drm/amdgpu/userq: reject mappings without a backing BO

Jiangshan Yi (1):
      drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend

Lalit Shankar Chowdhury (1):
      drm/amdgpu: replace kcalloc() with kzalloc_objs()

Lijo Lazar (2):
      drm/amd/pm: Fix metrics formatting in SMUv15.0.8
      drm/amdgpu: Add package type mapping for EAM

Likun Gao (2):
      drm/amdgpu: Add gc_info_v1_4 table support
      drm/amdgpu: add support for lsdma v8

Lin Cao (6):
      drm/amdgpu: fix ip discovery table validation
      drm/amdgpu: add new MEC2 firmware loading framework
      drm/amdgpu: Add GFX FW list to PSP_15_0_3 under SRIOV
      drm/amdgpu: Add VPE FW list to PSP_15_0_3 under SRIOV
      drm/amdgpu: Allocate VPE cmdbuf from VRAM
      drm/amdgpu: skip vpe dpm enable if dpm_enabled flag is false

Lu Yao (2):
      drm/amd/display: Fix wrong plane index in dcn6 writeback latency loop
      drm/amdkfd: drop KFD_QUEUE_TYPE_DIQ note

Mukul Joshi (6):
      drm/amdgpu: Reject UALink handle ioctl on devices without UALink
      drm/amdgpu: Fix BO reference leak in UALink export error path
      drm/amdgpu: Fix race on ualink_handle_lo in UALink handle export
      drm/amdgpu: re-check connection state before sending NPA-REVOKE
      drm/amdgpu: Fix NPA BO memory accounting stats during import invalidation
      drm/amdgpu: place VRAM-capable dma-buf imports in the PREEMPT domain

Nicholas Kazlauskas (1):
      drm/amd/display: Update default clocks for DCN60 lite3 variant

Ovidiu Bunea (1):
      drm/amd/display: Add urgent watermark override for DCN42

Pierre-Eric Pelloux-Prayer (3):
      drm/amdgpu: use pm_runtime_resume_and_get amdgpu_gem_create_ioctl
      drm/amdgpu: implement workaround for sdma dcc corruption
      drm/amdgpu: use pm_runtime_resume_and_get for ctx ioctl

Piotr Maziarz (6):
      drm/amd/display: Flatten OPP_SET_DISP_PATTERN_GENERATOR parameters
      drm/amd/display: Remove OPP_SET_MPCC_DISCONNECT_PENDING
      drm/amd/display: Rename HUBBUB_FORCE_PSTATE_CHANGE_CONTROL wait field
      drm/amd/display: Drop disallow_self_refresh_applied output param
      drm/amd/display: Dispatch HUBBUB_SOFT_RESET through hubbub_funcs
      drm/amd/display: Remove dead self-refresh BLS steps

Prike Liang (1):
      drm/amd/display: fix dml-wrapper file discovery for out-of-tree builds

Ray Wu (2):
      drm/amd/display: map PWM brightness through custom backlight curve
      drm/amd/display: Attach blend mode property for alpha planes

Relja Vojvodic (1):
      drm/amd/display: Block DSC Padding on DP

Sasha Levin (1):
      drm/amd/display: Fix sanitizer check for the DML frame size limit

Shiwu Zhang (1):
      drm/amdgpu: enlarge the waiting time for psp cmd

Simon Polack (1):
      drm/amd/display: Fix stale replay_events after mod_power stream removal

Theo Andersen Carton (1):
      drm/amdgpu: skip the noirq suspend reset for a switcheroo-parked GPU

Timur Kristóf (11):
      drm/amdgpu/gmc: Use amdgpu_gmc_handle_retry_fault() for GMC v12.1
      drm/amd/display: Fix fast updates on DCE 6.x
      drm/amd/display: Fix fast updates on DCE 8.1
      drm/amd/display: Mark DCE 6.4 as not APU
      drm/amdgpu: Delete unimplemented DM soft_reset() code
      drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
      drm/amdgpu: Delete SI/CIK/VI IH soft_reset() code
      drm/amdgpu: Delete unimplemented IH soft_reset() code
      drm/amdgpu: Delete GMC v6-v7 soft_reset() code
      drm/amdgpu: Delete unimplemented GMC v9 soft_reset() code
      drm/amd/pm/si: Fix updating clock limits on AC/DC

Tony Cheng (1):
      drm/amd/display: Move struct dtbclk_dto_params to dc_hw_types.h

Wenjing Liu (3):
      drm/amd/display: Synchronize UTM overrides with SMU
      drm/amd/display: Consolidate bandwidth overrides
      drm/amd/display: Fix DCN60 UTM QoS override for invalid PMFW table

Willian Oliveira (1):
      drm/amdgpu/gfx6: fix firmware leak on teardown

Xiang Liu (1):
      drm/amdgpu: don't leak bo_va when gem_object_open fails

Yang Wang (3):
      drm/amdgpu: fix ASP 15.0.3 runtime DB offset
      drm/amdgpu: expose MP5 firmware version in sysfs
      drm/amdgpu: support MP5 in firmware info queries

YiPeng Chai (3):
      drm/amd/ras: add error log for unhandled gpu mce data
      drm/amd/ras: suppress warning for unsupported early init service
      drm/amd/ras: use __le32 pointer type to resolve the sparse warnings

Yongqiang Sun (3):
      drm/amdgpu: update MES v11/v12 API for mes_dbgext
      drm/amdgpu: add mes_dbgext core support
      drm/amdgpu: wire mes_dbgext on gfx11 and gfx12

YuBiao Wang (4):
      drm/amdgpu: add sriov microcode init for MP0 15.0.8
      drm/amdgpu: fix VFI XCC addressing for gmc v12_1 VM invalidation
      drm/amdgpu: skip PF-only programming on the VF
      drm/amdgpu: skip MGCG programming on a VF for gfx v12_1

YuanShang (1):
      drm/amdkfd: mark queues as reset after a full GPU reset

ZhenGuo Yin (1):
      drm/amdgpu: fall back to RCC_HW_DEBUG for VF frame buffer size

 drivers/gpu/drm/amd/amdgpu/Makefile                |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |    13 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c    |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h        |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    87 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |    20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    87 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   146 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    21 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   233 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   749 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    59 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    57 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |    36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |    81 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    38 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |     5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h    |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |    40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |    32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |    31 -
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |    31 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |     6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |    71 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    75 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |    38 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |     9 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |    11 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h            |     2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          |    24 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |    96 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |    85 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |    83 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |     7 -
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c              |   132 +
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h              |    31 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |    31 -
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               |     7 -
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |     7 -
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c               |     7 -
 drivers/gpu/drm/amd/amdgpu/ih_v8_0.c               |   781 +
 drivers/gpu/drm/amd/amdgpu/ih_v8_0.h               |    28 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c            |   138 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h            |    31 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |    52 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h         |     4 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   198 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   184 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c            |   603 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h            |    28 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |     7 -
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c            |   350 +
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h            |    32 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |     5 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c           |   836 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h           |    32 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |     2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |     9 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |    30 -
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c         |    84 +
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h         |    30 +
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |    17 -
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h              |    22 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |    32 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |     8 -
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |     8 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |     1 +
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c              |   351 +
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h              |    29 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |     3 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    36 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |    12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |     2 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    13 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |    90 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |    59 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |     6 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   155 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |    10 -
 drivers/gpu/drm/amd/display/dc/Makefile            |     3 +
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |   181 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    30 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   146 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |     2 +-
 .../gpu/drm/amd/display/dc/core2/CMakeLists.txt    |    10 +
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c    |    34 +
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h    |    19 +
 .../gpu/drm/amd/display/dc/core2/dc_core2_init.c   |    13 +
 .../gpu/drm/amd/display/dc/core2/dc_core2_init.h   |    10 +
 drivers/gpu/drm/amd/display/dc/dc.h                |     6 +-
 .../amd/display/dc/dc_api_dispatch/CMakeLists.txt  |     9 +
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.c  |    32 +
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.h  |    19 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |     9 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |     9 +
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c    |    10 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |     2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |     4 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |     2 +-
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c     |     2 +-
 .../gpu/drm/amd/display/dc/dml2_wrapper/Makefile   |     5 +-
 drivers/gpu/drm/amd/display/dc/dpp/Makefile        |     2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h   |    22 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |    10 +-
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |     2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h   |     3 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c    |   115 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |     1 +
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |    42 +-
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h |     7 +-
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |     9 +
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c |     5 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |    10 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |    10 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c  |     3 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |     4 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |     6 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |    50 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |     5 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |    51 +-
 .../gpu/drm/amd/display/dc/inc/dc_core_interface.h |    31 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |     9 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |     9 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |     4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |     3 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |     2 +
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |     8 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.h   |     1 +
 .../dc/link/protocols/link_edp_panel_control.c     |     4 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |    58 +-
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c   |     5 +-
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h   |     3 +-
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c |    83 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |    13 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |     2 +
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |     2 +
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |     2 +
 drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h |     1 -
 drivers/gpu/drm/amd/display/modules/power/power.c  |     2 +
 .../amd/include/asic_reg/hdp/hdp_8_0_1_offset.h    |   213 +
 .../amd/include/asic_reg/hdp/hdp_8_0_1_sh_mask.h   |   665 +
 .../include/asic_reg/lsdma/lsdma_8_0_1_offset.h    |   385 +
 .../include/asic_reg/lsdma/lsdma_8_0_1_sh_mask.h   |  1399 +
 .../include/asic_reg/mmhub/mmhub_5_0_1_offset.h    |  1494 +-
 .../include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h   |  7489 ++-
 .../drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h |  1105 +
 .../amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h    |  1646 +
 .../amd/include/asic_reg/nbif/nbif_7_10_0_offset.h | 15938 +++++
 .../include/asic_reg/nbif/nbif_7_10_0_sh_mask.h    | 60316 +++++++++++++++++++
 .../amd/include/asic_reg/oss/osssys_8_0_1_offset.h |   275 +
 .../include/asic_reg/oss/osssys_8_0_1_sh_mask.h    |   984 +
 .../amd/include/asic_reg/pcie/pcie_6_1_3_offset.h  |  1755 +
 .../amd/include/asic_reg/pcie/pcie_6_1_3_sh_mask.h | 10821 ++++
 .../include/asic_reg/smuio/smuio_15_0_3_offset.h   |    79 +
 .../include/asic_reg/smuio/smuio_15_0_3_sh_mask.h  |   164 +
 .../amd/include/asic_reg/vpe/vpe_3_0_0_offset.h    |   877 +
 .../amd/include/asic_reg/vpe/vpe_3_0_0_sh_mask.h   |  2661 +
 drivers/gpu/drm/amd/include/discovery.h            |    42 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |    18 +
 drivers/gpu/drm/amd/include/mes_v12_api_def.h      |    17 +
 drivers/gpu/drm/amd/include/soc_v2_0_ih_clientid.h |    51 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |     2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |    39 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |     5 +-
 drivers/gpu/drm/amd/ras/core/Makefile              |     2 +
 drivers/gpu/drm/amd/ras/core/eeprom.c              |     6 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c      |     1 +
 drivers/gpu/drm/amd/ras/core/ras_gfx.c             |     3 +
 drivers/gpu/drm/amd/ras/core/ras_mp1.c             |     2 +
 drivers/gpu/drm/amd/ras/core/ras_nbio.c            |     3 +
 drivers/gpu/drm/amd/ras/core/ras_psp.c             |     4 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.c     |   114 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.h     |    31 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c             |     4 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c       |   221 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h       |    70 +
 .../drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c    |     1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c   |    15 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    26 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c   |     6 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |     6 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |    51 +
 drivers/gpu/drm/radeon/radeon_mode.h               |     3 +-
 include/uapi/drm/amdgpu_drm.h                      |     2 +
 221 files changed, 116067 insertions(+), 1276 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_8_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_8_0_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_8_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_8_0_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_7_10_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_7_10_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_8_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_8_0_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pcie/pcie_6_1_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pcie/pcie_6_1_3_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_3_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_3_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/soc_v2_0_ih_clientid.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h
