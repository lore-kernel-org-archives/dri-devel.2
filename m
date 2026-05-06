Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6769CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E3110EE1C;
	Wed,  6 May 2026 16:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ev9jUpw";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CCF10EE26;
 Wed,  6 May 2026 16:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yToLP8ia/CELXUi6nQOhaGGdqpy6UI65Arp3BRbpIaWIM2UJVd5HlH/LD7df1ACQine0WfJN/2I6uAuZRtJ7ruCzJGVqAjGl7eWG9RJxy3qs/3QAlvaeG2yDI1+hVRXEBVoPauoYA12fTh1lXy0CADAkKd2xaQkjFCUJNeVKZ2yG+0jhsB1wxfNo3RU+/xHOfgIOy9ssyJroL15T7g/iieIOG5snSi6YsE1o/XjET0fA0VPurvKoHIkGcXgxZD0Nj7dVN8cO7wobu8+OHmyV05rCm8neALg6CKEPpyzoPhJnAePTOkWmQ2NeQPRqYl7lspVXFVkQHc82jKs8bQkMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5ajGmhJtqH8Pjh8GiaJl4bvJI2Zrgt0yUT62GFoe84=;
 b=Vsdpg/UDCvLcVKtSx5JmotIND+fK5TbpthVb6jFMDCK4bi79/gjgyrnEWEccEZ3oBvSeOQ4ufRLSufxB1XjAb4Eq10RwXAeiLndKIPwJrmcGcf4Ij6ruxQz1SpyvJJFEqltMrYlx42aLsBoovdBCWlbmzWfvEcQrnYIIXwDPOzN7dcyQYZgGfnjoY8j3SM2i9v2CoYcCRKmRbD27I9DL+8Gs3ilKtWydz8gmtowj8RMRdhPNbqKcRBKD2pKQ6uXsearlkV6CmHYI+6VoElEjRukLIk/onCsnan6Le0TavHXmRNOYOJFDt1z+HRNtsBx6EOQ16f9Aq57ZAmEjARB3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5ajGmhJtqH8Pjh8GiaJl4bvJI2Zrgt0yUT62GFoe84=;
 b=1ev9jUpwiQ2qUIzkr7Lj6Ze4HOc0oiy3jqltdni1V7JbK1kEjBCodbeU/h9TM4di5K4Bq54q49BfbtYkTG5+PCIiWX5qgKX9Zr/n/weCBRgw8Hx2tv+ZIjfQog3mDQ8vCebUApGIN4CZm5K5LbY9NHqip5e4pv3dQdjlipA8gFw=
Received: from SA1PR04CA0010.namprd04.prod.outlook.com (2603:10b6:806:2ce::16)
 by BN7PPF915F74166.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 16:47:43 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::78) by SA1PR04CA0010.outlook.office365.com
 (2603:10b6:806:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Wed,
 6 May 2026 16:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 16:47:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 11:47:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 11:47:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 11:47:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.2
Date: Wed, 6 May 2026 12:47:26 -0400
Message-ID: <20260506164726.1733646-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: f3220d20-d1dc-4a81-5c38-08deab8f2f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|13003099007|18002099003|18092099006|56012099003;
X-Microsoft-Antispam-Message-Info: zfm7G9gSi7w4L2g1sWUPeFnuvryDna3smnJy4edYKts3P01otw8pWi3gnpMKun5nkXEy8KucpBEvv+ybfaPpt1QTfP6nCpJE/b7OUEXuykjj3VS7RvDpZ2z/W23WTRk7n1esyj08cU6s7i6sIhvvgaMCNqYp+qU7f7YAZKPHwSwmA613qdmq0+zVvecD9+FIL74m0to/mdN1e3jGcjpB/qMTLcVGXLq5a0fC5FLUBK2sqsYK9GCYZ4kntOY8cydufOJH8FRcYZypHtsDwHq9a7Wt2APsqCL+CuCcc6t4W2zko9VLEXeQ6vOVnfh2ELy0DS6ga005BC0Jss2z2QanbZ0zYtDFEffc0vvPx5ea+1RnIGOcf0a5OI+/+xgLfhDWN5Rld84OY+gTWyvDbsDDT7O41V6//TkTYsd8iyixsCAsiUE9YDJRTvPpamqloAkdcoIft14EXOpCAoV5nqLH+3FJMRncnO1cnHZnJM1LN/6vVvFZLRfW4gfomLaGi5VxK5taHP9P5Ei0AEDqavnezmev/ZXV78HVaelqI0Ugsf1H8fPU5CzGWYbrAztPZ/ASFzojEHaFjqA1YyDICS/AGzm8wOwO/NQahnrdgWuD1bEzS67Mdp8uZ/ZGzgwvrsoyOVXiul1exss1qZUGyLyUrJ/uH9wpy+ONyaLZwmS6defQsdd4zl/QZ3bEWFyOPQJo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(18002099003)(18092099006)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rWfCAu96k4RhaqBA8LwZoE9Zt4FIumXyHxDg/sAnWMg12e4HDK7qlVEgwJOalQxl31vCZ4oZbPBFDXRFgLQJN3y5E0vipOmGuR45PBEoPPt1bVu80gZ8DfZHqSsRMCpkNsX80SkDg97mR6vMM/+bHCSDvva/JEY4z3LyCdxh9CYSOVp2EpvohbBKJv/Yts3A3yD74HtJ22XqnsYOwpN8x2PLDUe+QJKaZXf7u5lyKZG8QiZib/8TFgS2khXher9xXcEi65o5MkPVTQtDCRkLua+YMhyh8i8EgVQyuZ4Xoxc5fm3FBwUmA6NKYPLV930ZsfuUkR/6EGhBrZrV/AosOls1FyYGSdgx3P0TD6s6SdgZc5B6qvF2AuH7K0epF5t3+zxwBACFL3l3VyH7YS3F1BBjon878oIt1E2J4Y8/Q0CEvJs7LkFBZfh2i8U6tqzJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:47:39.7558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3220d20-d1dc-4a81-5c38-08deab8f2f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166
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

New stuff for 7.2.

The following changes since commit dd88d42d9ca0dd7a4ed327dd33f6ead76cedf726:

  drm/amdgpu: drop userq fence driver refs out of fence process() (2026-04-17 15:41:12 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.2-2026-05-06

for you to fetch changes up to 0d831487b5be0ae59cac865a0aa87b0acc3dc717:

  drm/amdgpu: nuke amdgpu_userq_fence_slab v2 (2026-05-05 09:56:53 -0400)

----------------------------------------------------------------
amd-drm-next-7.2-2026-05-06:

amdgpu:
- GFX9 fixes
- Hawaii SMU fixes
- SDMA4 fix
- GART fixes
- Userq fixes
- Finish support for using multiple SDMA queues for TTM operations
- SWSMU updates
- Misc cleanups and fixes
- GC 12.1 updates
- RAS updates
- SMU 15.0.8 updates
- DCN 4.2 updates
- DC type conversion fixes
- Enable DC power module
- Replay/PSR updates
- SMU 13.x updates
- Compute queue quantum MQD updates
- ASPM fix
- GPUVM fixes
- DCE 6 fixes
- Align VKMS with common implementation
- RDNA 4 fix
- DC analog support fixes
- UVD 3 fixes
- TCC harvesting fixes for SI
- GC 11 APU module reload fix
- NBIO 6.3.2 support
- IH 7.1 updates
- DC cursor fixes
- VCN user fence fixes
- JPEG user fence fixes
- DC support for connectors without DDC
- Prefer ROM BAR for default VGA device
- DC bandwidth fixes

amdkfd:
- GPUVM TLB flush fix
- Hotplug fix
- Boundary check fixes
- Misc cleanups and fixes
- SVM fixes
- CRIU fixes

radeon:
- Hawaii SMU fixes
- Misc cleanups and fixes

----------------------------------------------------------------
Alex Deucher (12):
      drm/amdgpu/gfx7: align mqd settings with KFD
      drm/amdgpu/gfx8: align mqd settings with KFD
      drm/amdgpu/gfx9: align mqd settings with KFD
      drm/amdgpu/gfx10: align mqd settings with KFD
      drm/amdgpu/gfx11: align mqd settings with KFD
      drm/amdgpu/gfx12: align mqd settings with KFD
      drm/amdgpu/gfx9.4.3: align mqd settings with KFD
      drm/amdgpu/gfx12.1: align mqd settings with KFD
      drm/amd/display: properly handle family setting for early GC 11.5.4
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon
      drm/radeon: add missing revision check for CI

Alex Hung (1):
      drm/amd/display: Remove unused state param from enable_link_analog

Alex Sierra (2):
      drm/amdgpu/gfx12_1: Increase reserved memory size to 150M
      drm/amdkfd: fix redundant MQD iterations in GFX v12.1

Allen Li (2):
      drm/amd/display: Unset Replay desync error verification by default
      drm/amd/display: Add Replay/PSR active check in link loss status check

Alvin Lee (1):
      drm/amd/display: Update tmz field for LSDMA

Alysa Liu (2):
      drm/amdkfd: Add upper bound check for num_of_nodes
      drm/amdkfd: validate SVM ioctl nattr against buffer size

Amber Lin (10):
      drm/amdgpu: Fix gfx_hqd_mask in mes 12.1
      drm/amdgpu: Fixup boost mes detect hang array size
      drm/amdgpu: Fixup detect and reset
      drm/amdgpu: Create hqd info structure
      drm/amdgpu: Update mes 12.1's suspend/resume
      drm/amdgpu: Missing multi-XCC support in MES
      drm/amdgpu: Enable suspend/resume gang in mes 12.1
      drm/amdkfd: Add detect+reset hangs to GC 12.1
      drm/amdkfd: Reset queue/pipe in MES
      drm/amdkfd: Queue reset support in KFD topology

Andrew Lichmanov (1):
      drm/amd/display: Remove SYMCLK F and G values from link encoder and MANUAL_FLOW_CONTROL from optc

Arjan van de Ven (1):
      drm/amdgpu: fix zero-size GDS range init on RDNA4

Asad Kamal (4):
      drm/amd/pm: Align PPTable fill with non-Q10 static metrics
      drm/amd/pm: Add partition metrics support
      drm/amd/pm: Add mem temp to gpu metrics for smu_v15_0_8
      drm/amd/pm: Relax manual min/max clock check

Benjamin Cheng (2):
      drm/amdgpu/vcn3: Avoid overflow on msg bound check
      drm/amdgpu/vcn4: Avoid overflow on msg bound check

Bhuvanachandra Pinninti (1):
      drm/amd/display: Implement block sequencing infrastructure for modular hardware operations.

Bing Ma (2):
      drm/amdgpu: Add gc v12_1_1 ip headers v3
      drm/amdgpu: Add gc v12_1_0 ip headers v6

Charlene Liu (3):
      drm/amd/display: fix hubp tmz field define mismatch
      drm/amd/display: fix dual cursor shows on extend desktop
      drm/amd/display: remove watermark range notify

Chen Ni (1):
      drm/amd/display: Remove duplicate include of dce/dmub_hw_lock_mgr.h

Christian König (3):
      drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG
      drm/amdgpu: rework userq fence signal processing
      drm/amdgpu: nuke amdgpu_userq_fence_slab v2

Dillon Varone (2):
      drm/amd/display: Add minimum vfp requirement
      drm/amd/display: Fix Color Manager (3DLUT, Shaper, Blend)

Dominik Kaszewski (1):
      drm/amd/display: Fix DPMS using partially updated pipe context

Eric Huang (1):
      drm/amdkfd: remove obsolete codes for kfd_mmap

Feifei Xu (1):
      drm/amdgpu: Place psp pri_fw bo to VRAM on A+A

Felix Kuehling (1):
      drm/amdkfd: Make all TLB-flushes heavy-weight

Gabriel Almeida (2):
      drm/amdgpu: move program_aspm to amdgpu_nbio
      drm/amdgpu: move read_indexed_register to amdgpu_reg_access

Gaghik Khachatrian (11):
      drm/amd/display: Fix implicit narrowing conversion warnings
      drm/amd/display: Fix narrowing boundaries and eDP parser assignment
      drm/amd/display: Fix dml2_0 narrowing boundaries
      drm/amd/display: Update MCIF_ADDR macro to address IGT DWB regression
      drm/amd/display: Fix implicit conversion warning
      drm/amd/display: Fix narrowing boundaries in dml
      drm/amd/display: Fix type mismatches in DML and normalize loop bounds
      drm/amd/display: Do DML float narrowing explicit
      drm/amd/display: Fix type mismatches in DC and DMUB modules
      drm/amd/display: Fix type mismatches using guards and explicit casts
      drm/amd/display: fix buffer overruns warnings

Harish Kasiviswanathan (4):
      drm/amdgpu: In GFX12.1 CU is same as WGP
      drm/amdgpu: Set chicken bit for gfx_v12.1 xnack
      drm/amdgpu: Set default xnack mode for gfx_v12.1 A0/B0
      drm/amdkfd: Limit per-process xnack support for GFX12.1

Hawking Zhang (4):
      drm/amdgpu: Add nbio v6_3_2 ip headers v4
      drm/amdgpu: Add nbio v6_3_2 support
      drm/amdgpu: Switch to gfx_v12_1_get_xccs_per_xcp
      drm/amdgpu: Add node_id-to-die-name decoding for ih v7_1

Hongyan Xu (1):
      drm/amdgpu: avoid double drm_exec_fini() in userq validate

Ian Chen (1):
      drm/amd/display: Skip HDR metadata update when Smart Power OLED enabled

Ilya Bakoulin (1):
      drm/amd/display: Fix double free

Ivan Lipski (1):
      drm/amd/display: Remove Mall, SubVP and MCLK from DCN42

Jing Zhou (1):
      drm/amd/display: fix root clock disabled when DSC power gate disabled for DCN314

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

Kent Russell (1):
      drm/amdgpu: Only send RMA CPER when threshold is exceeded

Le Ma (1):
      drm/amdgpu: make driver manages local vram allocations for for gmc v12.1 A+A

Leo Chen (3):
      drm/amd/display: Enable driver power gating
      drm/amd/display: Enable HUBP/OPTC/DPP power gating
      drm/amd/display: Disable hpo power gate

Leo Li (2):
      drm/amd/display: Undo accidental fix revert in amdgpu_dm_ism.c
      drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs

Leonardo Cesar (1):
      drm/amdgpu: deduplicate ring preempt ib function

Lijo Lazar (8):
      drm/amd/pm: Enable thermal alert on SMUv15.0.8
      drm/amd/pm: Add thermal alert logging to smu15.0.8
      drm/amd/pm: Check SMUv13.0.6/12 metrics integrity
      drm/amd/pm: Update emit clock logic
      drm/amd/pm: Add fine grained flag to SMU v13.0.6
      drm/amdgpu: Prefer ROM BAR for default VGA device
      drm/amdgpu: Add helper to set gart size
      drm/amdgpu: Use helper to set gart size

Likun Gao (6):
      drm/amdgpu: update cp cmd pkt for gfx v12_1 v2
      drm/amdgpu: support rlc_1 fw load for gc 12_1
      drm/amdgpu: support toc_1 fw load for mp0 v15_0_8
      drm/amdgpu: add doorbell range function for nbio v6_3_2
      drm/amdgpu: support nbio v6_3_2
      drm/amdgpu: update cp cmd pkt for gfx v12_1

Mario Limonciello (1):
      drm/amd: Adjust ASPM support quirk to cover more Intel hosts

Mario Limonciello (AMD) (1):
      amdkfd: Only ignore -ENOENT for KFD init failuires

Michal Simek (1):
      drm/amdgpu/jpeg: Fix sprintf buffer overflow warning in jpeg_v2_5

Ovidiu Bunea (1):
      drm/amd/display: Find link encoder for flexible DIG mapping cases

Philip Yang (3):
      drm/amdgpu: Move amdgpu_device_check_iommu_direct_map() earlier
      drm/amdgpu: Move VM PTE MTYPE override to per-PTE granularity
      drm/amdgpu: zero-initialize GART table on allocation

Pierre-Eric Pelloux-Prayer (9):
      drm/amdgpu: pass all the sdma scheds to amdgpu_mman
      drm/amdgpu: only use working sdma schedulers for ttm
      drm/amdgpu: create multiple clear/move ttm entities
      drm/amdgpu: give ttm entities access to all the sdma scheds
      drm/amdgpu: get rid of amdgpu_ttm_clear_buffer
      drm/amdgpu: rename amdgpu_fill_buffer as amdgpu_ttm_clear_buffer
      drm/amdgpu: split amdgpu_ttm_set_buffer_funcs_status in 2 funcs
      drm/amdgpu: use DRM_SCHED_PRIORITY_KERNEL for all ttm entities
      drm/amdgpu: fix root reservation in amdgpu_vm_handle_fault

Prike Liang (1):
      drm/amdgpu: clean up the userq unmap error handler

Rafal Ostrowski (2):
      drm/amd/display: Align HWSS fast commit path with legacy path
      drm/amd/display: Unify fast update classification paths

Randy Dunlap (4):
      drm/amd/display: dmub_cmd.h: correct typos and spellos
      drm/amd/display: dmub_cmd.h: correct all kernel-doc prototype warnings
      drm/amd/display: dmub_cmd.h: add missing kernel-doc for enums
      drm/amdgpu: amdgpu{_reset}.h: fix all kernel-doc warnings

Ray Wu (3):
      drm/amd/display: Introduce power module on Linux
      drm/amd/display: Add power module on Linux
      drm/amd/display: Rename backlight_properties to pwr_backlight_properties

Roman Li (4):
      drm/amd/display: Add allow_clock_gating to dcn42 dccg
      drm/amd/display: bypass post csc for additional color spaces in dcn42
      drm/amd/display: Remove unused dml2_project
      drm/amd/display: Restore analog connector support

Samson Tam (1):
      drm/amd/display: Add README.md file to DML2_0 repository

Shaoyun Liu (2):
      drm/amd/amdgpu : Distribute inv_tlbs on individual XCC
      drm/amdgpu: Move get mes version info to the end of set_hw_resource

Shiwu Zhang (2):
      Revert "drm/amdgpu: Init mcm_addr look up table"
      drm/amdgpu: use the ASP command for partition switch

Shubhankar Milind Sardeshpande (1):
      drm/amdgpu: Avoid reset in AMDGPU unload path for APUs with GFX V11 and higher.

Siwei He (1):
      drm/amdgpu: OR init_pte_flags into invalid leaf PTE updates

Srinivasan Shanmugam (3):
      drm/amd/display: Fix divide by zero in calc_psr_num_static_frames
      drm/amd/display: Fix unsigned underflow in SubVP vblank schedulability check v2
      drm/amdkfd: Validate CRIU-restored IDs before idr_alloc

Sunil Khatri (1):
      drm/amdgpu/userq: fix access to stale wptr mapping

Taimur Hassan (4):
      drm/amd/display: Promote DC to 3.2.379
      drm/amd/display: [FW Promotion] Release 0.1.57.0
      drm/amd/display: Promote DC to 3.2.380
      drm/amd/display: Promote DC to 3.2.381

Thomas Zimmermann (1):
      drm/amdgpu: Replace VKMS vblank timer with common implementation

Thorsten Blum (1):
      drm/radeon: replace nested min calls with min3

Timur Kristóf (11):
      drm/amd/display: Disable 10-bit truncation and dithering on DCE 6.x
      drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not overlap with VRAM
      drm/amdgpu/uvd3.1: Don't validate the firmware when already validated
      Documentation/gpu: Add TCC, update TCP in amdgpu glossary
      drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)
      drm/amd/display: Allow embedded connectors without DDC
      drm/amd/display: Allow DCE link encoder without AUX registers
      drm/amd/display: Allow constructing DCE6 link encoder without DDC
      drm/amd/display: Allow constructing DCE8 link encoder without DDC
      drm/amd/display: Read EDID from VBIOS embedded panel info
      drm/amd/display: Use EDID from VBIOS embedded panel info

Wenjing Liu (2):
      drm/amd/display: add memory bandwidth override debug interface
      drm/amd/display: add max bandwidth budget to QoS interface

Werner Kasselman (2):
      drm/amdgpu: fix integer overflow in amdgpu_gem_align_pitch()
      drm/radeon: fix integer overflow in radeon_align_pitch()

Xiang Liu (1):
      drm/amdgpu: Rename CPER Fatal severity macro

Xiaogang Chen (1):
      drm/amdkfd: Check if there are kfd porcesses using adev by kfd_processes_count

Yang Wang (2):
      drm/amd/pm: remove trailing semicolon from AMDGPU_PM_POLICY_ATTR macro
      drm/amd/pm: fix missing fine-grained dpm table flag on aldebaran

Yinjie Yao (19):
      drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v2.5 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v3.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.3 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.5 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.1 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.2 enc ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.3 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.1 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.2 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.3.0 ring

YuanShang (1):
      drm/amdkfd: check if vm ready in svm map and unmap to gpu

Yuho Choi (1):
      drm/radeon: fix memory leak in radeon_ring_restore() on lock failure

Yury Norov (1):
      drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n

Zheng, Austin (1):
      drm/amd/display: Clean Up Legacy DML Content

 Documentation/gpu/amdgpu/amdgpu-glossary.rst       |     9 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    51 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h            |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    57 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |    82 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |     4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c           |    10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c     |    18 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h     |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h          |    69 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   333 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |    22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |    28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |     3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   123 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |    16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |    11 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |     5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |    69 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    67 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   110 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h         |   415 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    66 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |     7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |     6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    24 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |     5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |    11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |    13 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |    28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |    30 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    34 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    75 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c               |    40 +-
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c             |    12 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |    97 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   147 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c           |   369 +
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h           |    31 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |    31 +-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    21 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |    12 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |    11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |    16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |    16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |    12 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    12 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |    30 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    30 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |    21 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |    33 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |    10 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |     2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |     2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |     7 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |     5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |     1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |     1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |     1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |     1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    46 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    33 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   157 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     4 +-
 .../amd/amdkfd/kfd_device_queue_manager_v12_1.c    |    19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |     5 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |     6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    22 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    76 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    12 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   368 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    10 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    36 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    74 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |     5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    60 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    44 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |    36 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |   242 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |    13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   143 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h   |    28 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    27 +
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |     2 +-
 .../gpu/drm/amd/display/dc/basics/custom_float.c   |     2 +-
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c  |     6 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    79 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    21 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |    12 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |     4 +-
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |    12 +-
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c |     2 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |    11 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |    42 +-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |    56 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |    43 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |    55 +-
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |    69 +-
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |    68 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |    58 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |    64 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |   127 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    59 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |    48 +-
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c   |     1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   993 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  1102 +-
 .../gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c  |    11 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   139 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |     4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    40 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |     8 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    99 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |     3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   148 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |     9 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c       |     6 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |    16 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    42 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    54 +-
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c |     4 +-
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c   |    20 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |     2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |     4 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    24 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |     2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c    |    16 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c       |     2 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |     7 +-
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.c    |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |    12 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c  |    16 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |    12 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |    23 +-
 .../amd/display/dc/dce80/dce80_timing_generator.c  |     2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |    16 +-
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |    22 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c   |     2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |     8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c  |     4 +-
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |    11 +-
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c        |     6 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c      |     2 +-
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.h  |     2 -
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c        |     4 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calc_auto.c   |  1854 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calc_math.c   |     6 +-
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |   294 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |   153 +-
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |   328 +-
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |   326 +-
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  |   164 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |   164 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |   332 +-
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |    80 +-
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |    90 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |   411 +-
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  |    82 +-
 .../gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c |    25 +-
 .../gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c |    18 +-
 .../gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c |    18 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   |    41 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |   475 +-
 .../display/dc/dml/dcn31/display_rq_dlg_calc_31.c  |    76 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |    13 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |   487 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c        |    80 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   403 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |   195 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |   326 +-
 .../display/dc/dml/dcn32/display_rq_dlg_calc_32.c  |   138 +-
 .../gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c |    95 +-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |    27 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |    27 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |     8 +-
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |    32 +-
 .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   |    18 +-
 .../gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c   |    82 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/README.md    |    31 +
 .../drm/amd/display/dc/dml2_0/display_mode_core.c  |    14 +-
 .../drm/amd/display/dc/dml2_0/display_mode_util.c  |    20 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |    15 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |     2 +-
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |     1 -
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |     1 -
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |     1 -
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c  |     2 +-
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |     1 -
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |     3 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c       |     1 -
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h |     9 -
 .../drm/amd/display/dc/dml2_0/dml2_mall_phantom.c  |   105 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_policy.c    |     6 +-
 .../display/dc/dml2_0/dml2_translation_helper.c    |     4 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |    40 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |     2 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c  |     2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |    13 +-
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |     2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |     2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |    15 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |    13 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |    19 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |     3 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c   |    33 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |     3 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |     2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c   |     2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c      |     2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h      |     9 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c       |     2 +-
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c     |     2 +-
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c |    16 +-
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |    28 +-
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h |     3 +
 .../drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c |    12 +-
 .../drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c |    12 +-
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |    12 +-
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |     7 +-
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |     5 +-
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |     6 +-
 .../gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c |     4 +-
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |     4 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |   201 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |    23 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |    78 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |    10 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   165 +-
 .../drm/amd/display/dc/hwss/dce120/dce120_hwseq.c  |    12 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |    67 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |    47 +-
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c    |    10 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    31 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |    12 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |    94 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    36 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |    81 +-
 .../drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c  |     2 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   450 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   521 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |     9 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |   393 +-
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h      |     2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    10 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    22 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    37 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |    79 +-
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |     1 +
 .../drm/amd/display/dc/inc/soc_and_ip_translator.h |    19 +-
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |     2 +-
 .../amd/display/dc/link/accessories/link_dp_cts.c  |    37 +-
 .../amd/display/dc/link/hwss/link_hwss_hpo_dp.c    |     4 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |    10 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |    26 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |    12 +-
 .../gpu/drm/amd/display/dc/link/link_validation.c  |     4 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |     5 +-
 .../display/dc/link/protocols/link_dp_capability.c |     6 +-
 .../amd/display/dc/link/protocols/link_dp_dpia.c   |     2 +-
 .../display/dc/link/protocols/link_dp_dpia_bw.c    |    12 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |    59 +-
 .../dc/link/protocols/link_dp_panel_replay.c       |    27 +-
 .../display/dc/link/protocols/link_dp_training.c   |     4 +-
 .../dc/link/protocols/link_dp_training_8b_10b.c    |    10 +-
 .../dc/link/protocols/link_edp_panel_control.c     |    41 +-
 .../amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c |     4 +-
 .../amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c |     4 +-
 .../gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   |     2 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |   177 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |    25 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   |   388 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h   |    49 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c |     2 +-
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |     4 +-
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |     1 -
 .../drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c    |     6 +-
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |     4 +-
 .../display/dc/resource/dce110/dce110_resource.c   |     4 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |     3 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |     3 +-
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |     4 +-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |    24 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |     2 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |    14 +-
 .../display/dc/resource/dcn301/dcn301_resource.c   |     8 +-
 .../display/dc/resource/dcn302/dcn302_resource.c   |     4 +-
 .../display/dc/resource/dcn303/dcn303_resource.c   |     4 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |     4 +-
 .../display/dc/resource/dcn314/dcn314_resource.c   |     4 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |     4 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |     4 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |    20 +-
 .../dc/resource/dcn32/dcn32_resource_helpers.c     |     2 +-
 .../display/dc/resource/dcn321/dcn321_resource.c   |     4 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |     4 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |     4 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |     4 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |     4 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |    58 +-
 .../dcn401/dcn401_soc_and_ip_translator.c          |    42 +-
 .../dcn42/dcn42_soc_and_ip_translator.c            |    20 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   264 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  |     2 +-
 .../amd/display/include/grph_object_ctrl_defs.h    |     4 +
 .../drm/amd/display/modules/color/color_gamma.c    |    12 +-
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |   415 +
 .../amd/display/modules/info_packet/info_packet.c  |     2 +-
 drivers/gpu/drm/amd/display/modules/power/Makefile |     2 +-
 drivers/gpu/drm/amd/display/modules/power/power.c  |  3024 ++
 .../drm/amd/display/modules/power/power_helpers.c  |    16 +-
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c    |     6 +-
 drivers/gpu/drm/amd/include/amd_cper.h             |     2 +-
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h |   110 +
 .../amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h    |   455 +
 .../drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h |   149 +
 .../amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h    |   377 +
 .../amd/include/asic_reg/nbio/nbio_6_3_2_offset.h  | 13149 +++++
 .../amd/include/asic_reg/nbio/nbio_6_3_2_sh_mask.h | 49475 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |     6 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c    |    13 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |     1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |     9 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |   219 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |    34 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |     2 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |     9 +-
 drivers/gpu/drm/radeon/cik.c                       |     2 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |    13 +-
 drivers/gpu/drm/radeon/radeon_ring.c               |     4 +-
 drivers/gpu/drm/radeon/si.c                        |     2 +-
 include/drm/drm_fb_helper.h                        |     6 +
 376 files changed, 79068 insertions(+), 8071 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/README.md
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_power.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power.c
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_3_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_3_2_sh_mask.h
