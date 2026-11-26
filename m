Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D1606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0XTF0OYy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A3DC11248B;
	Thu, 26 Nov 2026 14:24:37 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE8511247D;
 Thu, 26 Nov 2026 14:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2ggE7BHNXeCsFG7CpdlNh5NJi0/gUR2w7x6IQ5FezsDoHbxR8d2v85sXXOzeNlm/lVH8hIHU0NyTAsmEnz+GYt15SsLcxVX2hikSKMHQp/kQj4nLxy3ldJbpgKAIm0yFkzAk/N/OQm9uZ4GUY/yU7mkutH+pknV7RULIYMaw7NZMKzSGq6Ua1Z5uPwufaW/PUUQUefTgBC8XqvPM59nzQkk/Zuh+ph2WyqR79l15RcBC5NARgbGXMLjK0Q1NC7rZyUwJpEx4bQJ8z5Gc2BZ5S24vG7JjfBzAEq8UvHWfOGZYVGq+MbfGn+W9PeDgoMr/9c23GTUMJYgbGumEeB6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8b6H3aJDW4YijR20fs2YJFNt93mFmAGEiagMPaur20=;
 b=jYu3MJEvwhrIPAyVs++06mBzG0hdXv2+q7ttyUkcvqBer0loOPznG/P6aFqbAWDoXXFiD8TyMpYi9uJlYdTyY0ku17ySIWe2ke8ZqABX2yFi3aeGo1Vz9W4zUNc2D6+UUtFviMIqUnX0I0TSSJYVY73EWh9UBumpvpEIlNc33ZtAzMumXqPfdEWvS3X0zVmN/aKl1l8fZzqb7rKuNhKScYBUvwvPB9fYAr/DW2gh01KnuDamTRrUexk6fBDGWnfrkiPI2EEBja8eDxWfwgr31TMhJ9lZJyW19E/HE/J7/yRpTv+Yys8Xax5f1Ot9Qtk0O8Uwv8jdli5iqg1rFuupGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8b6H3aJDW4YijR20fs2YJFNt93mFmAGEiagMPaur20=;
 b=0XTF0OYy6YaQeCEmRkuwnOEgv+VcERnyQUrLF3Wv+1d3nTXtwoTWAqTK+gplkRw0vlNX7o7mZjjkG+Uli0bai/S73QSCpmDUOSVXComC/NwLJwm6fkdfuoG5wgklik4obQVAa6bVQguO2P3aKAyf+omt/0mWfRRuXF/DIS7L9dE=
Received: from CH0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:b0::18)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:24:25 +0000
Received: from DS2PEPF00007108.namprd05.prod.outlook.com
 (2603:10b6:610:b0:cafe::5e) by CH0PR03CA0013.outlook.office365.com
 (2603:10b6:610:b0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 26 Nov 2026 14:24:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00007108.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 14:24:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 08:23:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 08:23:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon, PCI drm-next-7.5
Date: Thu, 26 Nov 2026 09:23:42 -0500
Message-ID: <20261126142342.1491061-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00007108:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: a10f0f13-c759-4b41-7d5d-08df4bc8f8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|261022105027099003|10067099003|56012099006|261026121527099003|261026140227099003|261021135927099003|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|11063799006|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: phr9aUyJpqPIdTBxNfkGLoaQiSJ8ujjWY8ySMpyQWfKhljU299IYQMM20fN/mwOIy6ywOchQwJQsmJrRxQvFTOGTolkiH0bjfu1T66Vsqqkky2+6NJ2sCKqDEf/VTS+48U7NOuSWsblP5JyYE8y0ncH1XxRpfgnCb19FQThgcq4t+xG4JQnd3fVy9ygeCPS5bOpkQRr5GdXCxZliPCGT2nmiApaAsVoiZSJ+L2PuQ5v/AFZU1vBKm1U/10K80UL2ytiKISCTCvhDqduZwdqbQ159Qw0ngsVBjY0dE6dlfWZh4F8pqs2c0hHsR/+GPUV5sOaSQcoTos0XsQpe1ilbxZtKNhTZ1rc5tg1xqnfvcy7ONpdkFYJMu5a5Ng1CG2mAgmoBs6VCq/xWppYfzMvA2PFTfw8w1CxCQYzqL5K0nTPUa4y/nlQqa1uASJy1gCuBRvS6hG2IQj3ytmubYtkF8Zyu224eNidN9Imkin3ZaA0uVBZ4Jz+Lel3MDS7AnDIGSEAEvxe+ZTwjQ14jVxXStuGlQwzmd4S0q1As3R2fT30nbeGgi3DvygBqGCI4OJaDyaHr1k7w0T9b4CpTfLq3R3Yr35ZjTlUmpqdapfFbuGT2Ph44LC7kPaAvtFa+BOkawVSm4JMN+2b0UWVVsUVVkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(261022105027099003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261021135927099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(11063799006)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M2HIO7hS6BdT6bMTveXcZaCzfxsHqfzLYneYdQQcEWUm6GqqDa2C++q2zH4eNXppDasJQX83cMeB5pyhao730JjU4uxVFAaFn8CXm+JLf2uTwdjTWFtn++XLu1CMdyzx1B9sFO2FMYOL84Z2fLnntjEeCO6qfXbzIgs4f3AHIf42LgDL3szE3YnOTMRtl4D7ETcAd9YNDcYsdKewVvJpdV4QhVRy5/UbCX19ULtDzhXEmFXphZF/VJfyw1TrchE6GbVNoJP5bXsJixc5KNTadkXfzwQBO93zKnlRtzlMRtnqvlD8HjkCy9KwSIR50o0NAu/GnWvHZ8umEiTsy26E92jf/pXMLp0PkQ6Qy9VoTJYLDnpZbQ0b5O0ll8CKf+ivoelF20Y4+F93KWKl9y8XUzUZHORL7g4aH+G8KsgO/yc6TBkwUmDkEct9HP9Gn6uc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:24:24.9069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10f0f13-c759-4b41-7d5d-08df4bc8f8ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00007108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URG_BIZ,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Simona,

More stuff for 7.5.

The following changes since commit 83558fcf83cc911e09962ea17c883add596766c0:

  drm/amd/display: Restore PSR-SU guard in power module (2026-11-17 13:10:20 -0500)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.5-2026-11-26

for you to fetch changes up to a69db917063c539fa09325ea22f3ff7b0626b478:

  drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU restore (2026-11-25 09:06:05 -0500)

----------------------------------------------------------------
amd-drm-next-7.5-2026-11-26:

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
- Replay fixes
- DSC fix
- Fix display handling for RGBA8888
- VPE fix
- Fence accounting fixes
- Partition fix
- PSP 15.0.3 updates
- RAS updates
- MES updates
- Add HDP helper
- Initial GMC 13 support
- Initial SoC v2 support
- DC DPMS rework
- DP retrain refactor
- Initial SDMA 8 support
- Backlight rework
- Vblank fixes
- DCN 6 updates
- DCN 4 updates
- DC rework
- DC AUX fixes
- Documentation fixes
- Initial GC 13 support

amdkfd:
- CWSR fixes
- SVM fixes
- Error path cleanup fixes
- Fence accounting fix
- Debugger fixes
- CRIU fix
- GC 12.1 trap handler fix
- PMC fixes

radeon:
- Fix handling of ACPI tables when PCI bus numbers change

PCI:
- Cache firmware secondary bus number

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdkfd: move TBA/TMA back to system memory
      drm/amdgpu: add helper for determining removable devices (USB4, TB)

Alex Sierra (1):
      drm/amdgpu: reinitialize GFX compute across a partition switch

Allen Pan (1):
      drm/amd/display: Always apply 0ppm pixel clock adjustment

Apurv Mishra (1):
      drm/amdkfd: Don't require a VM for the profiler PMC lock

Aveline Noir (1):
      drm/amdkfd: preserve the byte address when removing retry faults

Benjamin Cheng (6):
      drm/amdkfd: reserve TTM move fences
      drm/amdgpu/gem: reserve fences on the VM root PD
      drm/amdgpu/vm: reserve TTM_NUM_MOVE_FENCES in amdgpu_vm_lock_pd
      drm/amdgpu/vm: stop using amdgpu_bo_fence
      drm/amdgpu/uvd: stop using amdgpu_bo_fence
      drm/amdgpu/object: get rid of amdgpu_bo_fence

Caden Chien (1):
      drm/amdgpu/vpe: align with reg read permission

Christoph Berliner (1):
      drm/amdgpu/gfx9: deactivate all compute HQDs before MODE2 on APUs

David Belanger (1):
      drm/amdkfd: Add max_cu_per_engine property

David Francis (1):
      drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU restore

Dominik Kowalski (3):
      drm/amd/display: Rename DPMS to DPMS_v1
      drm/amd/display: Add DPMS-v2 files
      drm/amd/display: Add DPMS-v2 types

Felix Kuehling (1):
      drm/amdkfd: Fix context ID cleanup after failures

Frank Min (8):
      drm/amdgpu: update mem rsv table
      drm/amdgpu: add helper function to get hdp base addr
      drm/amdgpu: use is_sos_alive func for sOS sol on soc v2.0
      drm/amdgpu: add v13_structs.h
      drm/amdgpu: Add sdma v8 ip block
      drm/amdgpu: update mes max sdma pipes
      drm/amdgpu: Add imu v13 ip block v2
      drm/amdgpu: Add gfx v13 ip block

Gangliang Xie (1):
      drm/amd/ras: add ras error query support

George Shen (1):
      drm/amd/display: Refactor DP retrain link HW sequence

George Zhang (3):
      drm/amd/display: Add otg versions of get_vblank_counter/scanoutpos
      drm/amd/display: Queue vblank control work to sleepable context
      drm/amd/display: Fix KUnit tests for vblank control rework

Harry VanZyllDeJong (1):
      drm/amd/display: Honor the Replay stream regeneration wait event

Harry Wentland (2):
      drm/amd/display: Add RGBA8888 surface pixel format support
      drm/amd/display: Fix DCE crossbar for RGBA8888 surface format

Hawking Zhang (7):
      drm/amdgpu: Add gc v13_0_1 ip headers v6
      drm/amdgpu: Add gfxhub v13_0 support
      drm/amdgpu: Add gmc v13_0 support
      drm/amdgpu/discovery: Add gmc v13_0 ip block
      drm/amdgpu: Add soc v2_0 support
      drm/amdgpu/discovery: Add soc v2_0 common ip block
      drm/amdgpu: Add gfx v13_0_1 irqsrc header

Hemalatha Pinnamreddy (1):
      drm/amd/display: Fix aux timeout callback across engines

Hongyan Xu (1):
      drm/amdkfd: fix use-after-free in create_process() error path

Ian Rogers (2):
      drm/amdgpu: initialize r in amdgpu_vm_bo_update()
      drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()

Ivan Lipski (2):
      drm/amd/display: Fix G7 P-state aperture addresses
      drm/amd/display: Set stream min/max refresh from VRR config

Jay Cornwall (1):
      drm/amdkfd: gfx12.1 trap handler LDS store ack workaround

Jesse Zhang (2):
      drm/amdkfd: don't keep the debugger pointer when DBG_TRAP_ENABLE fails
      drm/amdkfd: return the memory violation data to the debugger

Kent Russell (1):
      drm/amdgpu: Disable XNACK retry on GFX12.1

Kevin Wang (2):
      drm/amdgpu: add spirom dump support for asp 15.0.3
      drm/amdgpu: enable ifwi upload support on psp 15.0.3

Lang Yu (1):
      drm/amdkfd: Add a helper to handle IP version specific client id

Likun Gao (1):
      drm/amdgpu: add new sdma pkt header

Mario Limonciello (3):
      PCI: Cache bridge firmware secondary bus number
      drm/amdgpu: Match VFCT using initial PCI bus number
      drm/radeon: Match VFCT using initial PCI bus number

Michael Strauss (1):
      drm/amd/display: Clear OTG_AUTO_FORCE_VSYNC_MODE on OTG disable

Nicholas Kazlauskas (2):
      drm/amd/display: Skip DSC padding borrow estimate for zero padding
      drm/amd/display: Drop unused DC interfaces

Perry Yuan (2):
      drm/amdkfd: test copy_from_user() directly in kfd_criu_restore_svm()
      drm/amdkfd: fix units when unmapping a PROT_NONE VMA from GPUs

Pierre-Eric Pelloux-Prayer (2):
      drm/amdgpu: use a single clear entity on some chips
      drm/amdgpu: fix NULL deref in error path

Prike Liang (6):
      drm/amdgpu/mes: pass the process context slot to SET_SHADER_DEBUGGER
      drm/amdkfd: allocate the MES process context slot with its buffer
      drm/amdkfd: fix the MES gang context slot error paths
      drm/amdkfd: pass the gang context slot when resetting a hung MES queue
      drm/amdgpu/mes: keep the RS64 context slot bitmaps across MES re-init
      drm/amdgpu/mes11: enable MES RS64 process/gang context loading again

Priya Hosur (1):
      drm/amd/pm: restore the forced performance level after a reset

Ray Wu (5):
      drm/amd/display: Use panel luminance range for AUX backlight in power module
      drm/amd/display: Read PWM back linearly with the linear backlight curve
      drm/amd/display: Add API to set brightness percent
      drm/amd/display: Pass linear brightness percent to power module
      drm/amd/display: Disable Replay when link off frame count is below 2

Ruijing Dong (1):
      drm/amdgpu: keep the commit padding when re-emitting submissions

Samson Tam (1):
      drm/amd/display: add extra 0.25 line reserved for TSetup/TCalc inefficiency

Suresh Guttula (1):
      drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD

TAKANO Mitsuhiro (1):
      drm/amdgpu: Document parse_psp_v1_bin_descriptor

Taimur Hassan (2):
      drm/amd/display: [FW Promotion] Release 0.1.85.0
      drm/amd/display: Promote DC to 3.2.408

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: clear the entire mapping when partially unmapping

Tomasz Siemek (1):
      drm/amd/display: Add DC2 wrapped initialization for DCN401

Tong Liu01 (1):
      drm/amdgpu: use SMN C2PMSG registers for PSP ring control on VF

Tony Cheng (6):
      drm/amd/display: Let the DC2 commit replace or keep a stream
      drm/amd/display: Support two streams in the dcn401 DC2 builders
      drm/amd/display: Add a plane beside a kept plane in DC2 update
      drm/amd/display: Keep an unchanged stream in the DC2 commit
      drm/amd/display: Change the ODM and MPC layout in DC2 update
      drm/amd/display: Give the DC2 builders State pipe facts

Wenjing Liu (1):
      drm/amd/display: Add urgent request and assertion probes

Xiaogang Chen (2):
      drm/amdkfd: Fix a race issue at svm_migrate_copy_to_ram() error path
      drm/amdkfd: Swap order of svm_range_dma_unmap_dev and migrate_vma_finalize

Zhikai Zhai (1):
      drm/amd/display: Power up eDP when detect link

chong li (1):
      drm/amdgpu: post the ASIC after the reset done at init time

 drivers/gpu/drm/amd/amdgpu/Makefile                |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |    44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |    21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    25 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |     2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |     9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |    88 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h            |     3 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |     4 +-
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h      |   121 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |    71 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c             |  5804 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h             |    31 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    98 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.c          |   529 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.h          |    29 +
 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c             |   999 +
 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.h             |    30 +
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c              |    13 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c             |   288 +
 drivers/gpu/drm/amd/amdgpu/imu_v13_0.h             |    29 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |     8 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/nvd.h                   |     2 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c           |    57 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.c             |  1832 +
 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.h             |    30 +
 drivers/gpu/drm/amd/amdgpu/sdma_v8_0_0_pkt_open.h  |  3988 ++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/soc_v2_0.c              |   544 +
 drivers/gpu/drm/amd/amdgpu/soc_v2_0.h              |    30 +
 drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h            |   680 +
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |     3 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c              |     3 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c              |     4 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |   656 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm |    11 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    22 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             |    37 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h             |     4 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |     1 +
 .../amd/amdkfd/kfd_device_queue_manager_v12_1.c    |    18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c   |    14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |    21 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   147 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    58 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |     4 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |     1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   116 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    52 +
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   206 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |     8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   225 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |     2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |     3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_irq_params.h   |     2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |    20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |    23 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   592 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   219 +-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |     2 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   129 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |    78 +
 drivers/gpu/drm/amd/display/dc/Makefile            |     3 +
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c  |     2 +
 .../drm/amd/display/dc/bls_builder/bls_builder.c   |    19 +
 .../drm/amd/display/dc/bls_builder/bls_builder.h   |    86 +-
 .../display/dc/bls_builder/bls_builder_internal.h  |     3 +
 .../dc/bls_builder/bls_builder_private_types.h     |    28 +-
 .../dc/bls_builder/dcn401_builder_internal.h       |    87 +-
 .../display/dc/bls_builder/dcn401_init_builder.c   |   812 +-
 .../display/dc/bls_builder/dcn401_init_builder.h   |    16 -
 .../dc/bls_builder/dcn401_init_builder_legacy.c    |    77 +
 .../dc/bls_builder/dcn401_non_seamless_builder.c   |   243 +-
 .../display/dc/bls_builder/dcn401_query_builder.c  |    41 +
 .../dc/bls_builder/dcn401_seamless_builder.c       |  1091 +-
 .../drm/amd/display/dc/bls_executor/bls_executor.c |    79 +-
 .../drm/amd/display/dc/bls_executor/bls_executor.h |     2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |     6 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   267 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    48 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |    28 +
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    38 +
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c    |   142 +-
 .../gpu/drm/amd/display/dc/core2/dc_core2_init.c   |   298 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    60 +-
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.c  |     1 +
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.h  |     3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |     8 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h          |    61 +-
 drivers/gpu/drm/amd/display/dc/dc_state_priv.h     |    23 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |     6 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |    11 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |    18 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    25 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |    42 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h |     6 +
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |     1 +
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |     1 +
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c  |    13 +-
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |     3 +
 .../gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c   |     3 +
 .../gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c |     3 +
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |     3 +
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c |     3 +
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |     3 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c   |     3 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |     3 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c |     1 +
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |     1 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |     1 +
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |    80 +
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |     4 +
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |     4 +
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h |     3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c |     4 +
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |     4 +
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c |     4 +
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c |    35 +
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h |     1 +
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c    |     1 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |     1 +
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h    |     8 -
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |   243 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |    80 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    61 +
 .../gpu/drm/amd/display/dc/inc/dc_core_interface.h |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |     3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    12 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |     4 -
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |     6 +-
 drivers/gpu/drm/amd/display/dc/inc/link_tx.h       |    59 +
 drivers/gpu/drm/amd/display/dc/link/Makefile       |     9 +-
 .../amd/display/dc/link/accessories/link_dp_cts.c  |    43 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |    17 +-
 .../dc/link/{link_dpms.c => link_dpms_v1.c}        |     6 +-
 .../dc/link/{link_dpms.h => link_dpms_v1.h}        |    10 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c |    44 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.h |    38 +
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |    23 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |     8 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |     6 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |     8 +-
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |     4 +
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |     4 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |     4 +
 .../dc/pmfw_messenger/dcn401_pmfw_messenger.c      |   211 +
 .../amd/display/dc/pmfw_messenger/pmfw_messenger.c |    62 +
 .../amd/display/dc/pmfw_messenger/pmfw_messenger.h |   118 +
 .../drm/amd/display/dc/state_facts/state_facts.h   |     3 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |    48 +
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |     7 +
 .../gpu/drm/amd/display/modules/power/power_abm.c  |    83 +-
 .../drm/amd/display/modules/power/power_replay.c   |     1 +
 drivers/gpu/drm/amd/include/amd_shared.h           |     5 +
 .../drm/amd/include/asic_reg/gc/gc_13_0_1_offset.h | 16009 ++++++
 .../amd/include/asic_reg/gc/gc_13_0_1_sh_mask.h    | 54977 +++++++++++++++++++
 .../drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h |     6 +
 .../amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h    |     9 +
 drivers/gpu/drm/amd/include/discovery.h            |     5 +-
 .../amd/include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h   |    77 +
 drivers/gpu/drm/amd/include/v13_structs.h          |  2288 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |    21 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |     2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |    39 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c       |    67 +
 drivers/gpu/drm/radeon/radeon_bios.c               |    42 +-
 drivers/pci/probe.c                                |     1 +
 include/linux/pci.h                                |     2 +
 include/uapi/drm/amdgpu_drm.h                      |     1 +
 191 files changed, 94336 insertions(+), 2647 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0_0_pkt_open.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v2_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_query_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_tx.h
 rename drivers/gpu/drm/amd/display/dc/link/{link_dpms.c => link_dpms_v1.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/link/{link_dpms.h => link_dpms_v1.h} (92%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/dcn401_pmfw_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h
 create mode 100644 drivers/gpu/drm/amd/include/v13_structs.h
