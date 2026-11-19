Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9098606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3eDPv/So
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E303F10E5F5;
	Thu, 19 Nov 2026 19:58:28 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7041110E3AF;
 Thu, 19 Nov 2026 19:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVDosphh6MDOyhipKLGoBpEB9rlO3sG7xBGMk5/qbF8FlnuGqDll/NL4NtKDfFF3qwSABM3ZjtlAyIjBMH1ZyIA5t0bFgIPbAbeEwuYG+EmBsLW02X4f/xWuJlimcPrP0DEAWkDv2wCs2lTqAQqKNHIY0GigMZQIzRSRPxg1174pwXMRT25Q9I5vo/N3JCram2EqQ1MQtZZ1X9ltRKd52obND1Ub6SAOvUPAE/qNfkPuyRwrY3PygrgQ9hNYYv9os8+E3qLc4x0AyF/rnLam5Is+YvcKScJ+aHV81NOtIfLtZahutB0f2EPLnIpn8Xt+MOEMg3AbMe7coo8Jz/jMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4Lt0LhHQZNz6MNaIVwN/Ioa18QYtxPhcjTJCsJ0UcM=;
 b=zWwyLNC4F6AgJZoSfR3eNj6FfxqISV0DWo3a5MAuZyuYwQYT+LpPdJU9FmyhRxU+G3jjB1X57cQiUkSkBBMBwNZxXn/OD3sVMN44Qu7zvuc6PlUCGHgKOSBv3SNt/FTkCY9RbvMub673p5BUmNDLUthtyL4w6ixTW7GFZg/vrRqT1CKZaHLVeSkWH+oS0BY92vlI1y6lN85W22/dfTl7beLae1lG3LmsBMN31bz0LLr/QzmcHoBATs3qweTB9qqKbDPAoJL2xEUuXwptNrbryi4x/sAvCJUid4HfH/iGXyoyMrEY4AoQquVJjbfl8GpfZoQ7+2dUwRMGxhkkT3vMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4Lt0LhHQZNz6MNaIVwN/Ioa18QYtxPhcjTJCsJ0UcM=;
 b=3eDPv/SorSyeXIBeyByx73Yp0rN853scQnExWvfiPJ2x/PV5lFYwzIlyM0l0es/+4P47R0KyWhwDWF4mJfzi8xKWIxJx3J+0hK46jyrM/0r4KO6Gr6d+mK086W8NabaaGwX7PMMmDajgmTWkjBaGeXHiE+Y5VCcXNBJusuItEfE=
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 19:58:13 +0000
Received: from IA0PEPF00000043.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::a6) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 19:58:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000043.mail.protection.outlook.com (10.167.249.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:58:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:58:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:58:10 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:58:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.5
Date: Thu, 19 Nov 2026 14:57:56 -0500
Message-ID: <20261119195757.218051-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000043:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 530be72b-3d7b-4cd5-c23a-08df4677712f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|18002099003|3023799007|5023799004|11063799006|261022113327099003|261026140227099003|261022075727099003|56012099006|261022105027099003|261028144727099003|261026121527099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: LUDxfttFSeRIIVUXMUGXHPFnw8c1rRPiL1ET06TfVq/NInkwCXFW8Rnm2SFwu0v/bffTC89SV3SBRcVVh+r1b0TLHiI2hdqKZG+7Nhs+a2USMm+/Dr4vcC+iw8nxKoQYfJOKkkoUP6UcILeqtVsiWQR2lymy49FQcSV62uPhDSJXYyLxuBE8x0Kzgl/FGHGmMTlJKyE/W7BxFKCIQ01YVWbwrvxJ4x44nbHNVqgeR8y8Cfkr/O1J4aUg+VeZ72B5MHO2qVWDgHM4ez4Hjm3l0hJmTRw0Ya0dw5SxPC2JxmMIaslTuRmpk1APMIR18/Za8bcwV8DoR58vlHqtq1CkObaTv5Fs8vbojaDlSBpLhWB+mWRUZ6UX4BbKzLKhFVfW7Hz8G+4VV7xczOpjtIwjBWqP3JafIjMfoE5YTlj6dERYdFhj6wngSsVl4jSBRRzYXn1JfHxUmv2lWXNNih7vwUpcCIPtpERAgwQp+zGC/7F/AHgpJefTH5J6/wZIObj3yIEWJvY1FlNhniu+wyP22BkB6+ZaOyG02K5VLO4uNGTIgPOXLsKEvpFvFNUC4G9QG8/433JVm2KtnvmxCYWwgIV7PKSyPwdOY1hFSzUdLQYHBB5QL/zMZkU/YE8IH+boAV8r7Zwc2fITiDcha5P9iOo42zF80nxnkb8ypGoP0dY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(18002099003)(3023799007)(5023799004)(11063799006)(261022113327099003)(261026140227099003)(261022075727099003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YYg6O9LimQ4/NRQRxY/0BOaEnKbyAoiOd08ucQDYALngf6tEH8wklSHQ2vzgWKagvxWvLnmJrrZ3tmlT9mfbW2r08YkueR1b8WrChnmOeobV63RyUc4OyE4v27VsUnicg7F2/Dasp5T0m8QHgnv1CLEJfooS4vn03/9fLwgd4ohj0yOjEL/SXYM9fPCX/VT/jHqcFiosFwl6CXSEJKjDoCAxT9fLEW1Ebj1s6hHSPETqn2Kp4/Xpk+F+4OQK7pk42sk6tpQ+VpoNaJ54QUMF2/MGIST1kWq9TUl5JKopjjfuySQmONg+2dRPtc3g2+w4trE1KZOhRhE1W+48L6lrCN96y+eWhinRq570ouV5Fq+D7dmgSAc8PbpvnT6jdYBzToEfdxLncbioilrYZxYlywTnx6iUMfjfdx+9qF0arE/kubMN9/gp4AZMaQeRT4Lb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:58:12.3416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530be72b-3d7b-4cd5-c23a-08df4677712f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000043.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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

More new stuff for 7.5.

The following changes since commit 601c30449c80926947d4820d50cec974687d1d11:

  Merge tag 'drm-misc-next-2026-11-13' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next (2026-11-14 11:59:11 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.5-2026-11-19

for you to fetch changes up to 83558fcf83cc911e09962ea17c883add596766c0:

  drm/amd/display: Restore PSR-SU guard in power module (2026-11-17 13:10:20 -0500)

----------------------------------------------------------------
amd-drm-next-7.5-2026-11-19:

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
- Backlight fixes
- Display warning fixes
- PSR fixes
- Reset fixes
- PSP 15 updates
- SPM fixes
- Kerneldoc fixes
- Use drm_gem_ttm_dumb_map_offset()
- Used named initializers for pci ids
- DC Core2 updates
- DC watermarks refactor
- DC clkmgr updates
- PCON fixes
- DCN 6 updates
- DCN 4.2 updates
- Display KUNIT fixes
- DMUB updates
- SR-IOV updates
- Drop non-DC display code

amdkfd:
- SVM fixes
- Init ordering fix

radeon:
- Bounds checks in vbios parsing
- ATPX lifetime fix
- drm_pciids.h cleanup
- Used named initializers for pci ids

----------------------------------------------------------------
Abdulla Bubshait (1):
      drm/amd/display: Abort DPMS ON when enabling the link fails

Adrian Betschart (1):
      drm/amd/display: Apply the HDMI RGB range default only to HDMI signals

Alex Deucher (12):
      Revert "drm/amdgpu: re-enable SPM updates in the the IB path"
      drm/amdgpu: fix audio parameter documentation
      drm/amdgpu: drop non-DC DCE10 support
      drm/amdgpu: drop non-DC DCE8 support
      drm/amdgpu: drop non-DC DCE6 support
      drm/amdgpu: remove legacy non-DC display support code
      Revert "drm/amdgpu: reemit RLC SPM register in ring reemit"
      drm/amdgpu/gfx7,8: program the RLC SPM in RLC resume
      drm/amdgpu/gfx9.4.3: program the RLC SPM in RLC resume
      drm/amdgpu: bring back the ring parameter for update_spm_vmid()
      drm/amdgpu: remove atombios i2c support
      drm/amdgpu: warn when driver is built without SI/DCE display support

Alex Hung (2):
      drm/amd/display: Fix elapsed time indentation
      drm/amd/display: Fix KUnit tiled EDID size

Allen Pan (1):
      drm/amd/display: Update DCN42B stutter latency to match DCN42

Alvin Lee (4):
      drm/amd/display: Update indicate pstate enable sequence
      drm/amd/display: Update DP HPO to use correct APG instance
      drm/amd/display: Updating missing assignments for DCN6
      drm/amd/display: Don't shrink zero-area recout in full viewport visual confirm

Amber Lin (1):
      drm/amdgpu: Correct hung queue number for reset

Andrey Misiurov (1):
      drm/radeon: Bound GPIO I2C table entry count from VBIOS

Aric Cyr (1):
      drm/amd/display: Ensure exit IPS before checking flip status

Aryan Sinha (1):
      drm/amdgpu: fix kernel-doc in amdgpu_ualink.c

Ashwin Santhosh (2):
      drm/amd/display: Skip visual confirm color programming when FW owns it
      drm/amd/display: Account for split pipe overlap in alt channel copy size

Austin Zheng (5):
      drm/amd/display: Fix Stage Optimizer Parameter Naming
      drm/amd/display: Read DCN6 SOP constraints from the idle row
      drm/amd/display: Use soc_bb hostvm fraction instead of hardcoded value
      drm/amd/display: Flip dml2_core_utils_get_segment_horizontal_contiguous() Inputs
      drm/amd/display: Add effective_number_of_dpp parameter

Ayush (1):
      drm/amdgpu: fix kernel-doc in amdgpu_gfx.h

Benjamin Cheng (2):
      drm/amdgpu: wait for tlb flush before freeing BO
      drm/amdgpu/gem: use dma_resv_add_fence directly

Ce Sun (1):
      drm/amdgpu: skip uniras block ECC query in GPU reset path

Charlene Liu (6):
      drm/amd/display: Extend the IOMMU mismatch workaround to DCN42B
      drm/amd/display: update dcn42b based on dcn42
      drm/amd/display: enable DF C-state vote on DCN42B
      drm/amd/display: Increase the DCN42 DDR5 stutter latency
      drm/amd/display: Keep panel power across link-loss retrain
      drm/amd/display: Keep patched HDMI panels on FRL across detect

Christian König (1):
      drm/amdgpu: fix cleared PDE/PTE flag generation

Colin Ian King (2):
      drm/amd/display: remove extra trailing semicolon from a couple of statements
      drm/amdgpu: make the read-only const array fw_err_code_msg static

Cooper Morgan (2):
      drm/amd/display: Saturate refresh rates in v1/v2 FreeSync infopackets
      drm/amd/display: Use FreeSync v3 infopacket for sinks above 255 Hz

Davey Hughes (2):
      drm/amd/display: Keep FreeSync flip timing across plane resets
      drm/amd/display: Test FreeSync flip timing across plane resets

Dejan Andjelkovic (2):
      drm/amdgpu: enable IP discovery via PSP mailbox
      drm/amdgpu: add support for FB carveout disablement

Dillon Varone (3):
      drm/amd/display: Relax stutter constraints for DRR streams
      drm/amd/display: cleanup tiling and address formats
      drm/amd/display: Enable DRR stutter constraint relaxation on DCN42

Egor Perevoshchikov (1):
      drm/amd/display: Restore PSR-SU guard in power module

Erhan Bilgili (1):
      drm/amdgpu: Fix UserQ slot availability checks

Eric Bernstein (1):
      drm/amd/display: Skip UPSP programming when UPSP regs are absent

Fangzhi Zuo (4):
      drm/amd/display: Correct the forced YCbCr420 comment
      drm/amd/display: Move HDMI FRL Polling Outside dc_lock
      drm/amd/display: Stop HDMI FRL status polling on fini
      drm/amd/display: Enable SST PCON FRL DSC passthrough

Gabriel Abarca (2):
      drm/amd/display: Increase state if dcfclk deep sleep needed exceeds dcfclk
      drm/amd/display: Update DCN6 Calcs

George Zhang (1):
      drm/amd/display: Don't let HPD IRQ handler take dc_lock in reset

Hugo Sales (7):
      drm/amd/display: Take every stream out of self-refresh before a modeset
      drm/amd/display: Add the AUX backlight minimum once on the custom curve
      drm/amd/display: Drop the unused min argument of convert_custom_brightness()
      drm/amd/display: Add a KUnit test for the custom curve minimum
      drm/amd/display: Interpolate between backlight LUT entries
      drm/amd/display: Interpolate when reading PWM back as a percentage
      drm/amd/display: Hold the VRR vblank reference only on active CRTCs

Ilya Bakoulin (1):
      drm/amd/display: Fix FFE test automation link rate change

Ivan Lipski (4):
      drm/amd/display: Initialize DMUB LSDMA ring buffer
      drm/amd/display: Enable HDCP on DCN6
      drm/amd/display: Use expanded DMUB-provided SoC BB and IP caps
      drm/amd/display: Limit VRAM aperture retrieval to DCN6

Jackie Liu (1):
      drm/amd/display: Fix logger leak on perf trace allocation failure

James Lin (1):
      drm/amd/display: commit validated target when minimal transition cannot be built

Jeff Johnson (1):
      drm/amd/display: use include guards instead of #pragma once in Core 2 headers

Jesse Zhang (5):
      drm/amdkfd: don't check the HMM range when getting its pages failed
      drm/amdgpu/gfx11: enable the GFX pipe reset with new enough CP firmware
      drm/amdkfd: keep the DMA addresses of a range intact if splitting fails
      drm/amdgpu/gfx12: enable the GFX pipe reset with new enough CP firmware
      drm/amdgpu: don't take a per VM kernel BO for a page table

Jiaming Fan (4):
      drm/radeon: only unregister the ATPX handler if we registered it
      drm/amdgpu: only unregister the ATPX handler if we registered it
      drm/amdgpu: undo module init in reverse order in module exit
      drm/amdgpu: unwind module init on failure

Jing Zhou (1):
      drm/amd/display: Seed boot clocks to avoid lowering pre-OS display clocks

Joshua Horne (1):
      drm/amd/pm: send smu8 sclk level indices, not the level mask

Karen Chen (1):
      drm/amd/display: fix hubbub read state logging

Kent Russell (3):
      drm/amdgpu: Run shader cleaner on all XCCs on faults
      drm/amdgpu: Fix fault shader cleaner on MI3
      drm/amdgpu: Fix fault cleaner race condition

Lijo Lazar (1):
      drm/amdgpu: Fetch TOS version in PSP v15.0.8

Mario Limonciello (2):
      drm/amd: Select the firmware signing scheme the PSP reports
      drm/amd/display: Route connector DDC over AUX for native DP sinks

Nevenko Stupar (1):
      drm/amd/display: Update default VCO frequency

Ovidiu Bunea (1):
      drm/amd/display: Only force P-State on first plane if TTU is below WM

Paul Menzel (1):
      drm/amd/display: Don't warn about vendor infoframe for non-infoframe sinks

Piotr Maziarz (3):
      drm/amd/display: Resolve clk_mgr DPP DTO targets when the sequence is built
      drm/amd/display: Resolve clk_mgr DTBCLK DTO targets when the sequence is built
      drm/amd/display: Resolve the DCN401 DENTIST divider when the sequence is built

Prike Liang (1):
      drm/amdgpu: keep reading the vblank counter in IRQ context during reset

Qiang Han (1):
      drm/amdkfd: wait for the queue quiesce in concurrent SVM evictions

Rafal Ostrowski (4):
      drm/amd/display: Remove duplicate block sequence leftovers
      drm/amd/display: HWSS Refactor - Watermarks
      drm/amd/display: Fix DSC teardown gating in post-unlock BLS sequence
      drm/amd/display: Make DPP_PG_CONTROL and HUBP_PG_CONTROL BLS compliant

Ray Wu (2):
      drm/amd/display: Allow DC_PSR_MASK to enable PSR without DMUB PSR cap
      drm/amd/display: Enable Replay timing sync by default

Sreeja Golui (2):
      drm/amd/display: Include Ramless Idle in stutter relaxation
      drm/amd/display: detect static screen state and propagate

Sridevi Arvindekar (1):
      drm/amd/display: Bypass chroma upsampling without the DPP cap

Suresh Guttula (1):
      drm/amdgpu: bypass IMU ucode loading for GC 11 APU

Taimur Hassan (4):
      drm/amd/display: [FW Promotion] Release 0.1.83.0
      drm/amd/display: Promote DC to 3.2.406
      drm/amd/display: [FW Promotion] Release 0.1.84.0
      drm/amd/display: Promote DC to 3.2.407

Thomas Lamprecht (1):
      drm/amd/display: Don't warn about links without an HPD GPIO

Tony Cheng (13):
      drm/amd/display: Dispatch commit_state_hw through dc2_funcs
      drm/amd/display: Add leaf BLS entries for a virtual commit
      drm/amd/display: Build the dcn401 virtual commit natively
      drm/amd/display: Build the dcn401 seamless update in DC2
      drm/amd/display: Read accelerated mode through a query builder
      drm/amd/display: Build the kept-plane surface update in DC2
      drm/amd/display: Skip first-enable steps on a kept plane
      drm/amd/display: Program the kept-plane scaler in DC2
      drm/amd/display: Add and remove two MPO planes in DC2
      drm/amd/display: Add DC2 state facts and split the builders
      drm/amd/display: Program DC2 commit stereo once
      drm/amd/display: Get OPP heads and DPP pipes by stream in dc_resource
      drm/amd/display: Program ODM 2:1 and 3:1 on one stream in DC2

Uwe Kleine-König (The Capable Hub) (3):
      drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
      drm/radeon: Consistently define pci_device_ids using named initializers
      drm/radeon: Fold <drm/drm_pciids.h> into its only consumer

Wang Jiang (1):
      drm/amdgpu/gfx_v9_0: Add gfxoff quirk for Lenovo Picasso 318F

Wayne Lin (1):
      drm/amd/display: Expect VRAM|GTT for the DMUB framebuffer

Weijie Yuan (1):
      drm/amd/display: Use a plain comment for panel polarity declarations

Wenjing Liu (2):
      drm/amd/display: Read DRAM channel width from SMU init table
      drm/amd/display: Report QoS latency bounds and request

Will Aitken (1):
      drm/amdgpu: Abort guest trn during ras reset

William WOJCIECHOWSKI (1):
      drm/amdgpu: enable fence interrupts before KFD init

saad (1):
      drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for dumb_map_offset

 drivers/gpu/drm/amd/amdgpu/Makefile                |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c           |  106 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |  418 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h       |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     | 2063 -----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.h     |   41 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  670 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h        |   13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   66 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c       |  262 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h            |    3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c            |  176 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h            |    4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   49 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |   90 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  100 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   40 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |   64 +-
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c         |  885 -----
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.h         |   60 -
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |  770 -----
 drivers/gpu/drm/amd/amdgpu/atombios_dp.h           |   42 -
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     | 2126 ------------
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.h     |   78 -
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c          |  176 -
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.h          |   33 -
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   18 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             | 3595 --------------------
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.h             |   33 -
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              | 3502 -------------------
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.h              |   32 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              | 3536 -------------------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.h              |   35 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   40 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   25 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   24 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |   98 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |   29 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |   17 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |    8 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    7 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |   30 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |   47 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h             |    1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c           |   11 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |    2 +
 drivers/gpu/drm/amd/amdgpu/si.c                    |    9 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   15 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |    2 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    7 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   67 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  162 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |    3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   51 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |    3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |   17 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |    2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |   19 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |    3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |    3 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   70 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   99 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   45 +-
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |  214 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   27 +
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |    6 +
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   35 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  188 +
 drivers/gpu/drm/amd/display/dc/Makefile            |    3 +
 .../drm/amd/display/dc/bls_builder/bls_builder.h   |    6 +-
 .../display/dc/bls_builder/bls_builder_internal.h  |    2 +
 .../dc/bls_builder/bls_builder_private_types.h     |  137 +
 .../dc/bls_builder/dcn401_builder_internal.h       |  110 +
 .../display/dc/bls_builder/dcn401_init_builder.c   |   36 +
 .../dc/bls_builder/dcn401_non_seamless_builder.c   |  501 +++
 .../dc/bls_builder/dcn401_seamless_builder.c       | 2235 ++++++++++++
 .../drm/amd/display/dc/bls_executor/bls_executor.c | 1076 ++++++
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |   83 +
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |  170 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h |   15 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |   31 +-
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |   25 +-
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h |    1 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h  |    3 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |  157 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h   |   14 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  117 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  317 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   48 +-
 .../drm/amd/display/dc/core/dc_resource_helper.c   |    7 +-
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c    |  341 +-
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h    |    6 +-
 .../gpu/drm/amd/display/dc/core2/dc_core2_init.c   |    2 +-
 .../gpu/drm/amd/display/dc/core2/dc_core2_init.h   |    5 +-
 .../amd/display/dc/core2/dc_core2_legacy_init.c    |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    4 +-
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.c  |   25 +
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.h  |   14 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |    1 +
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h     |    1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   16 +-
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |    8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    3 +
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |    5 +-
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |    5 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |    4 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |    4 +-
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |    1 +
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |    2 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |    2 +
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |   75 +-
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c     |   30 +-
 .../dml2_core_dcn6_funcs_mode_programming.c        |   34 +-
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.c  |   23 +-
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |    3 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.c   |    4 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |   20 +-
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h   |    4 +-
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h   |    8 +-
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c     |   19 +-
 .../dml21/src/inc/dml2_internal_shared_types.h     |    4 +-
 .../dml21_wrapper/dml21_translation_helper.c       |   17 +-
 .../display/dc/dml2_wrapper/dml2_mall_phantom.c    |    1 -
 .../drm/amd/display/dc/dml2_wrapper/dml2_wrapper.h |    1 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |    2 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c  |    4 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c |    3 +-
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h |    1 +
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |    8 +-
 .../amd/display/dc/hubbub/dcn201/dcn201_hubbub.c   |    3 +-
 .../drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c |    3 +-
 .../drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.h |    1 +
 .../drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c |    5 +-
 .../drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h |    1 +
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |    5 +-
 .../drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c |   23 +-
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |    7 +-
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h |    1 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |   12 +-
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.h   |    3 +-
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |   20 +-
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |    3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c |   52 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   61 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h    |    9 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   48 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h    |    9 +-
 .../drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.c  |   15 +-
 .../drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.h  |    6 +-
 .../drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c  |   11 +-
 .../drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h  |    6 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |    8 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h    |    3 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |   15 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h  |    3 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    7 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h    |    3 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  180 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    2 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |    2 +
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |    9 +
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h    |    1 +
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |    2 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |  422 ++-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |   14 +-
 .../gpu/drm/amd/display/dc/inc/dc_core_interface.h |   17 +-
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |   38 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |   22 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |   21 +-
 .../drm/amd/display/dc/inc/soc_and_ip_translator.h |    4 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   26 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |    2 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |    8 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |   30 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |    2 +
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |    5 +-
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |   30 +-
 .../dcn401/dcn401_soc_and_ip_translator.c          |    4 +-
 .../dcn42/dcn42_soc_and_ip_translator.c            |    4 +-
 .../dcn42b/dcn42b_soc_and_ip_translator.c          |    4 +-
 .../dcn60/dcn60_soc_and_ip_translator.c            |   96 +-
 .../drm/amd/display/dc/state_facts/state_facts.c   |  294 ++
 .../drm/amd/display/dc/state_facts/state_facts.h   |  132 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  213 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   12 +-
 .../gpu/drm/amd/display/modules/power/power_abm.c  |   62 +-
 .../gpu/drm/amd/display/modules/power/power_psr.c  |    9 +-
 .../drm/amd/display/modules/power/power_replay.c   |    2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |   14 +-
 drivers/gpu/drm/radeon/radeon_atombios.c           |   22 +-
 drivers/gpu/drm/radeon/radeon_atpx_handler.c       |   13 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |  702 +++-
 include/drm/drm_pciids.h                           |  702 ----
 227 files changed, 9365 insertions(+), 20810 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_crtc.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_dp.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_dp.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_encoders.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_i2c.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v10_0.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v6_0.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h
 delete mode 100644 include/drm/drm_pciids.h
