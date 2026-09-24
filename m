Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BEEC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCDA10E43E;
	Thu, 24 Sep 2026 17:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tgIO+j2c";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013031.outbound.protection.outlook.com
 [40.93.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C0C10E43E;
 Thu, 24 Sep 2026 17:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaUVlfUeWKkuBZBFuzQ+0dV5NezqUd00K4yOJia+HnE4o3US6KTFesd+y2O4CN3wQOKMsusddo7IQ82zl6Q+LvC1YlIVJ6rz+879vWrKjUal/kYtQKHvYraB1dF3VN9/etT+L+FnLlTcLUH4cPWf7mcusl/M1p6hKvW+gL9Bns13u/gRK0tcoWjAaowdASHSsXF1cg+bfWitcPIBMiWa46HESJZ+g6hUinYJILxpIzJMJ/5cV/sUzqRwflGrVkpg4cf3WLs/Hk25rrT/KZ7XHObUjCB5BSEbOePY9zI7NcmP0VSuSn+Fqa/fzGIGEwI5VVqROb6bZsWaM96Syl/Mmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO6ZJZD97wRRjjJDXcLP4MsWUv782mSZ1ve1qOP2Dis=;
 b=dllT1W8bTWcWJESBeNQyEoJTYjUg2qGDJ+9V8yd/8pUyZkpQGF1/28F4d5lnQZyuwP6rfiLsjWzrBL6ODh53WF37Ylz35QCxHHBrFcLukTzOhDkFGCz8qqdjQ5p3oWbU6J66VcboCTZYa2mU4NMA54tvBhCOaLxwVqX5ps5em6j5o/x9E+veG2MTf3BzqSqOTGgGRrVYUpj5y+zKCA5Ru0EOmU/i4VgMpwfC4E7Jzx2XMTeJwEmc/3VMyrOUUi483YBOKVqMK5LYjBYKoTK0CvEwEgV8aWhjhRLDBWIE64GapSoZD3YQfEaFmURgC3Qb1b+xZ72RKpBXx3m8+pFh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO6ZJZD97wRRjjJDXcLP4MsWUv782mSZ1ve1qOP2Dis=;
 b=tgIO+j2c15BckCxpbk5tnW5coB5Af9ZblXGRZY7BIWc10mjnZ2j+V2caPoDNlVpWNOmMFe6rp2HKmhWLZtGgajwuwksu5MEMzvGpqriL9CKBNM490rLAA4XNRF+fL7i2QLlIGErEZ0cfu8nioabWjqNIgPEQbhYDdckb2zSnjVc=
Received: from BN9PR03CA0510.namprd03.prod.outlook.com (2603:10b6:408:130::35)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:43:52 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::4b) by BN9PR03CA0510.outlook.office365.com
 (2603:10b6:408:130::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 17:43:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:43:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:43:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:43:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:43:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.4
Date: Thu, 24 Sep 2026 13:43:38 -0400
Message-ID: <20260924174339.635232-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: b391f584-212c-42fe-9547-08df1a636607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|10086099003|18092099006|18002099003|13003099007|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0DnHNVuPicAzYiM9STXXX+F+NuAaf+JX+LhXFjZqWJWyWaEjGYtJ+9GhLYgn0FhbLjLfZHerT7c1WVRu68affZymBdRio2seOlqjYewuQ9GEn2PdmQa6NxleNLhW9d12WkX8IRpqTDWd/vOvWzerqyh9KV44/DHqracFrAeqM5+D4NbITUJsBNg2qM0oCLvRbGFQ83RkoSrDeztqdMuYYwiu9OWSXTgOWExgBfk23F33ho86vfzIbQx6gSIi8bWqWC18bWKxtcJBGk6Yk36xHWNW3MapWu+gLAY8hymqVlW1xct2EfDp/jFAqfYr10XyZVU6wcHo1ghv8jHX4SKObrtyUoMVMjDy7ZFsmSU7VXwolKW0YQrTAKnlC233GKWhZbvJ8sjXZrnDKz+9nSGZVvUMpm/y8fa5IfGk5vxzGaEG1aWcf0SY6ZCF/VTocSGJTUOaon+SQ24Isw7L0Ebbl31WgxhrgxKSsPZCCpsfis2cUOSsVcvqqMYf5o5vGyNmF0ixPVHWzmYIFonSwwU6FlOqASCKxb7Xgqtrqq+jVY+q3nvAVxCRkMAnsoB4ER/7xYbpT5F2AtocCIIPp6YVDbJoDnuLZgu2L/hZ8LeHHTHtLd/6V0HWJz9AqGJtGpSuvAzTq3zzqwnx0uGj0RZoGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(10086099003)(18092099006)(18002099003)(13003099007)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kim0wxyPJpjCg+JugqoWHCu/RZtWl7PlBpuHi8frpz464qzNbAaImTe7R2B0Wg3VKRMCSUIVfzu/6t5VxZc6GtuqbXCoad5Fmq+Y1m2/ovWy9386OQ+cUn3yYcXhY0aIXz0+lidnsfa/0e9V5viet/hcYeZQE0iKePM1vR6RC1TdnaTzQ9Ec+VQ1SvgBViKTpwEzjspKG8CcY7cOtTvsbBJjqW6vurKQBPh2DrZM9SfrBAYBzzJk0RSQnP9Fj2HW6dwPDhtDYZVtzdYyVliAHQfr4MHlJZ0HyfEvMnhpaKA1p7x6eoBEYMgY7FioIT0q21MzFataZdaIHJSxW3vAUCN1bpWdDe+wqpYln8LZDf2bUcydQ/vorR4ok7qONP71HJd1jAZ1M0B+hJql5L/Gn2slx1fS/x9tA/fgnivbJEliLeZK/HisfWzSg/6QNlCF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:43:52.5330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b391f584-212c-42fe-9547-08df1a636607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
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

More new stuff for 7.4.  All of the stack frame warnings reported by Mark
should be resolved.

The following changes since commit b0a3a811634aa7422f8a92196db47a06a70bda16:

  Backmerge tag 'v7.3-rc4' into drm-next (2026-09-22 18:35:06 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.4-2026-09-24

for you to fetch changes up to 76b9706e7fa1a6e374703170128b1be2f590cda7:

  drm/amd/display: Bump frame warning limit for all builds of dml (2026-09-23 22:34:54 -0400)

----------------------------------------------------------------
amd-drm-next-7.4-2026-09-24:

amdgpu:
- Display ref count fix
- Userq fixes
- VCN 4, 5 reset fixes
- Fixes for various error paths
- Stack frame size fixes for various combinations of compilers and configs
- GC 12.1 fixes
- RAS updates
- SR-IOV udpates
- MES fixes
- UALink updates
- ABM updates
- DCN 6 updates
- Rework display instance handling
- KUnit test updates
- Documentation fixes
- DCN 4.2 updates
- Freesync updates
- Cursor refactor
- amdgpu_vm_eviction_(try)lock cleanup

amdkfd:
- Possible UAF fix
- GC 12.1 trap fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amd/display: Bump frame warning limit for all builds of dml

Alex Hung (34):
      drm/amd/display: Select KUnit helpers
      drm/amd/display: Fold blending tests into two cases
      drm/amd/display: Fold universal overlay format test
      drm/amd/display: Fold plane modifier list tests
      drm/amd/display: Fold modifier append tests
      drm/amd/display: Fold GFX9 tiling info tests
      drm/amd/display: Fold GFX6-8 tiling and modifier tests
      drm/amd/display: Fold DCC validation tests
      drm/amd/display: Fold DCC block mode tests
      drm/amd/display: Fold plane scaling and cursor tests
      drm/amd/display: Fold plane state check tests
      drm/amd/display: Fix amdgpu_dm's kernel-doc warnings
      drm/amd/display: Test EDID helper paths
      drm/amd/display: Test AUX transfer paths
      drm/amd/display: Test MST topology start
      drm/amd/display: Test unassigned OTG CRTC lookup
      drm/amd/display: Test VRR pageflip completion
      drm/amd/display: Test HPD RX offload work branches
      drm/amd/display: Test HDMI HPD debounce re-detect
      drm/amd/display: Test HPD handler HDCP and detect
      drm/amd/display: Test HPD RX downstream handling
      drm/amd/display: Drop redundant amdgpu_dm_irq tests
      drm/amd/display: Fix KUnit connector warnings
      drm/amd/display: Fix KUnit CRTC warnings
      drm/amd/display: Fix KUnit cursor warning
      drm/amd/display: Fix KUnit VRR warnings
      drm/amd/display: Fix KUnit helper warnings
      drm/amd/display: Fix KUnit IRQ warnings
      drm/amd/display: Fix KUnit MST warnings
      drm/amd/display: Fix KUnit DM warnings
      drm/amd/display: Fix KUnit writeback warnings
      drm/amd/display: Fix KUnit checkpatch warnings
      drm/amd/display: Fix LSDMA divide by zero
      drm/amd/display: Relax DML frame limit with UBSAN

Alvin Lee (3):
      drm/amd/display: Enable double buffering for DSCCLK updates
      drm/amd/display: Wait response should be based on fw_based_mclk_switch
      drm/amd/display: Re-enable P-State message to SMU

Asad Kamal (1):
      drm/amdkfd: fix use-after-free and multi-container gap in kfd_dev_mapping

Austin Zheng (1):
      drm/amd/display: Add Back Unified CalculateFlipSchedule

Candice Li (1):
      drm/amd/ras: enable UniRAS for psp v15_0_8

Christian König (1):
      drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock uses

Dillon Varone (1):
      drm/amd/display: Add more diagnostic logs for DMU

Dominik Kaszewski (1):
      drm/amd/display: Fix compound literal stackframe limit

Fangzhi Zuo (1):
      drm/amd/display: Restore FreeSync VCP code check for HDMI/PCON sinks

Huang, Leon (1):
      drm/amd/display: Forward periodic ABM keep-alive scenario to DMU

Ivan Lipski (4):
      drm/amd/display: Expose 3 overlay planes on DCN6
      drm/amd/display: Remove DCN6 DCFCLK num assert
      drm/amd/display: Resync cursor cache after offload abort on DCN60
      drm/amd/display: Bump frame warning limit for clang builds of dml

Jay Cornwall (1):
      drm/amdkfd: Preserve v1 in gfx12.1 trap workaround

Jesse Zhang (1):
      drm/amdgpu/mes12: clear event log on resume to avoid MES page fault

Karl Mehltretter (1):
      drm/amdgpu: Initialize UALink handle uniqueness state

Lijo Lazar (5):
      drm/amdgpu: Move GC v12.1 spm vmid init to hw init
      drm/amd/pm: Fix SMUv14/15 power context allocation
      drm/amd/pm: Drop redundant power_context_size
      drm/amd/pm: Create NPM sysfs files from capability
      drm/amd/pm: Add NPM status sensor

Matthew Stewart (1):
      drm/amd/display: Fix DCN42B plane alpha

Mukul Joshi (1):
      drm/amd: set CP_HQD_PQ_CONTROL.SCOPE for PM4 and KCQs on GFX 12.1

Nicholas Kazlauskas (1):
      drm/amd/display: Fix missing gaps for link lock with inbox0

Philip Yang (1):
      drm/amdgpu: Resync UALink ring wptr after reboot

Piotr Maziarz (5):
      drm/amd/display: Refactor DPP_PROGRAM_UPSP to drop pipe_ctx
      drm/amd/display: Remove phantom SW state ops from block sequence
      drm/amd/display: fix cursor refactor fallout and sync UT headers
      drm/amd/display: clamp cursor hotspot at the register write
      drm/amd/display: Rename build_cursor_position to dcn10_build_cursor_pos_update_params

Prike Liang (1):
      drm/amdgpu: move userq fence wait out of signalling section

Rafal Ostrowski (2):
      drm/amd/display: Drop pipe_ctx from hwss block sequence operations
      drm/amd/display: refactor hwss SET_CURSOR_POSITION block sequence

Srinivasan Shanmugam (2):
      drm/amdgpu: Fix NULL dereference in amdgpu_ualink_info_set_accel_state
      drm/amd/display: Fix null deref of link_enc in dce110_enable_tmds_link_output

Sunil Khatri (6):
      drm/amdgpu/userq: fix double jiffies conversion in hang detect timeout
      drm/amdgpu/vcn5.0.1: fix video_timeout unit mismatch in jpeg reset wait
      drm/amdgpu/vcn4.0.3: fix video_timeout unit mismatch in jpeg reset wait
      drm/amdgpu/mes12: add more debug info on MES packet failure
      drm/amdgpu/mes11: add more debug info on MES packet failure
      drm/amdgpu/mes12.1: add more debug info on MES packet failure

Taimur Hassan (2):
      drm/amd/display: [FW Promotion] Release 0.1.76.0
      drm/amd/display: Promote DC to 3.2.399

Tony Cheng (9):
      drm/amd/display: add SPDX-License-Identifier
      drm/amd/display: Add inst field to struct hubbub
      drm/amd/display: Add inst field to struct clk_mgr
      drm/amd/display: Add inst field to struct abm
      drm/amd/display: Add inst field to struct dmub_psr
      drm/amd/display: Add inst field to struct dmub_replay
      drm/amd/display: Add inst field to struct pg_cntl
      drm/amd/display: Add inst field to encoder structs
      drm/amd/display: Add inst field to clock_source and dio

Tony Qi (1):
      drm/amd/display: Revert "request DMUB HW cursor offload"

Victor Lu (1):
      drm/amdgpu: Check for PCIe atomic ops support when reading pf2vf data

Wentao Liang (5):
      drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
      drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()
      drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()
      drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
      drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()

YiPeng Chai (7):
      drm/amd/pm: Add GetRmaStatus message
      drm/amd/ras: retrieve ras error info via common interface and message for mp1_v13_0
      drm/amd/ras: add pmfw-managed eeprom support for mp1_v13_0
      drm/amd/ras: support aca debug mode for mp1 v13_0
      drm/amd/ras: add MP1 RAS feature status query
      drm/amd/ras: use common mp1 ras interface for v13
      drm/amd/ras: remove obsolete ras mp1 v13 manager code

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |  349 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h    |    9 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   15 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   15 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   29 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |    3 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     | 1250 ++++++------
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm |   23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   71 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |    2 +-
 drivers/gpu/drm/amd/display/Kconfig                |    3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   14 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |    6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |    9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |    1 +
 .../drm/amd/display/amdgpu_dm/tests/.kunitconfig   |    1 -
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   53 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   50 +-
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |    4 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   22 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  250 +++
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   | 1054 ++++++----
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |    9 +
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c | 2032 ++++++--------------
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |    2 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   41 +
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |    4 +
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    1 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |    7 +-
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |    3 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h  |    3 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |    4 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c       |   36 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    4 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  301 +--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   23 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |  134 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    3 +
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c    |   16 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    2 +
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h |    4 +
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c |    4 +
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h |    4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |    2 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    5 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |    1 +
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |   10 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h      |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |    3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h   |    1 +
 .../drm/amd/display/dc/dcn301/dcn301_panel_cntl.c  |    1 +
 .../drm/amd/display/dc/dcn31/dcn31_panel_cntl.c    |    1 +
 .../gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c   |    1 +
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |    2 +
 .../display/dc/dio/dcn10/dcn10_stream_encoder.c    |    2 +
 .../amd/display/dc/dio/dcn20/dcn20_link_encoder.c  |    2 +
 .../display/dc/dio/dcn20/dcn20_stream_encoder.c    |    2 +
 .../display/dc/dio/dcn30/dcn30_dio_link_encoder.c  |    2 +
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c        |    2 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c        |    2 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.c  |    2 +
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c      |    2 +
 .../display/dc/dio/dcn32/dcn32_dio_link_encoder.c  |    2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c        |    2 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c        |    2 +
 .../display/dc/dio/dcn35/dcn35_dio_link_encoder.c  |    2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c        |    2 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c        |    2 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c      |    1 +
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.c  |    2 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c        |    2 +
 .../display/dc/dio/dcn60/dcn60_dio_link_encoder.c  |    2 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c        |    2 +
 .../display/dc/dio/virtual/virtual_link_encoder.c  |    3 +
 .../dc/dio/virtual/virtual_stream_encoder.c        |    1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |    4 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |    4 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h  |    2 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |  164 +-
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |    3 +
 .../alternate_pstate_shared_lib.c                  |   22 +-
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c     |    2 -
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h |    2 +
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |   19 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |    1 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c    |    2 +
 .../dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c  |    2 +
 .../dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c    |    2 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c    |    2 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c |    2 +
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |    2 +
 .../amd/display/dc/hubbub/dcn201/dcn201_hubbub.c   |    2 +
 .../drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c |    2 +
 .../drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c |    2 +
 .../amd/display/dc/hubbub/dcn301/dcn301_hubbub.c   |    2 +
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |    1 +
 .../drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c |    2 +
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |    2 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |    2 +
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |    2 +
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |    2 +
 .../gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c |    1 +
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |  105 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |    2 +
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c |    1 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   10 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   20 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h    |    7 +-
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   14 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h    |    3 +-
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn201/dcn201_init.c   |    1 +
 .../gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c |    1 +
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn301/dcn301_init.c   |    1 +
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |    1 +
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |   11 +
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |    1 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   71 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    7 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |    1 +
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |    6 +-
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |    1 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |   75 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |    3 +
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h  |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h        |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    2 +
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h    |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |    2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |    2 +-
 .../drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c    |    1 +
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |    1 +
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |    6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   58 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   53 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |   84 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  |   94 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h  |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  |   94 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h  |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c  |   94 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h  |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c |   98 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  |   98 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h  |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c  |   98 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h  |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   54 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   17 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   23 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   56 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |    1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   11 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |    8 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h  |    1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |    1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |    2 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |    6 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   23 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |    2 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |    1 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |    8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |    8 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |    5 +
 drivers/gpu/drm/amd/ras/core/ras.h                 |   11 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1.c             |   13 +
 drivers/gpu/drm/amd/ras/core/ras_mp1.h             |   41 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c       |  165 +-
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile           |    1 -
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    6 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c   |   34 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c |  161 --
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h |   30 -
 202 files changed, 4409 insertions(+), 3761 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
 delete mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h
