Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BD606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SbGQAch9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E27310EBB9;
	Thu, 12 Nov 2026 21:19:26 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D4010EBB9;
 Thu, 12 Nov 2026 21:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jgy1DMeZrXjLbIgdHolRFZfsLP6qf6rH2uJv2Xhmd1cI/L8e4BWhloeuGjAReuHqirrwc1t8pp3qq4p451gjqYKXSHrgnLAXfPhUTK6iJFvz357qGRi/H3DNYAM/b0VTubZEWz6Jrdw7zIRPJ8fQL3JATmh3Y9y1hzfc3UKd9erQ0FB9HUutwhGI9+yO6sI4irBARXgpZHBLUD+sDFok2+MFRMTHEulHt1trOkRxLniJW2oCmro2x6CaaxioHOUQCt48luuABSCR2qYjLz/vTYUgjyBmk0MXp8GZT/dETwCOZqwmaBOuiT2UV0ItZhi+RW1vKfKPZ6cB0HerUgOfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOG0/X+GOu1tcBmhGxb8bSKuqprNNchuAeGS0bMF3I8=;
 b=a3BuHrkiN4s3P2+9TJhwLRPMINYn4fhJT8bUyZE3IHhrXafTF7NGscxQw0jfqzmeJQf4baGUaDia5vYORsjDP0vFw9J5bFg1WeyDcad2ah1MWEX9eNZy7eZwdofbqpMiZPQrPsnTiNtw15d1oh7Sxz7mH7Ts+MKONZVYrNeF9FMehP4HCcjjw3Dnsspw1hutHmHVwUXgJY3B/+5BV5pLJtLcjY/HzudGbFlDdPYXmYYIN2FFI0iJt8RWg+eznd4Z1RnuOlFsI5eCqLBnzxed8eNsvRCU8Pn0ZLRVU7Am+ijyyR62dd+RwRJF334N5BsmVVbI9ZJIDRLQbM7iSKvPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOG0/X+GOu1tcBmhGxb8bSKuqprNNchuAeGS0bMF3I8=;
 b=SbGQAch90mbRiu9Dho274KAHtHcoQVvRJi/hIGCuwWhkWM2lAr7jvgM1FVB4Bkt6lEvyywe97rq/w9xIO73SU35PT3iNaWWklznxlMosYb6u6zuqsHvK7W8zKYvuiySxgJtMhr+cV/S1QOO3tSD4vpx11R3YZU74QcKehbqkzJE=
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 21:18:36 +0000
Received: from BY1PEPF00026958.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::6) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 21:18:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF00026958.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 21:17:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 14:15:12 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 14:15:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, drm, radeon, UAPI drm-next-7.5
Date: Thu, 12 Nov 2026 15:14:59 -0500
Message-ID: <20261112201500.1747747-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026958:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b68328-6e22-4c92-a107-08df410266a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18092099006|18002099003|6133799003|10086099003|261009223327099003|261009221727099003|261009220027099003|261009221227099003|261009223027099003|3023799007|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: uBlUFRcNVKYzfN51If/bFrN3G/EjJuvR33r9wrKkKFQc14hX4XzjNwUU1BCcsTV+F5O33EWIjbXEL6rfvZFhYzjDX9DDstXrB8+fF8FEdCVW7YbObuvp5moO+ZHZruM6uk5emLEz9nNZU6Ag0J1OAhmfnwEwWOISPgi+DtBzWmYCUSk1nO6RnHYdar6OhgXv2xBa1eP294/Edn0kKwbIJFLHSYgQsge2IDX/2LTrKzmkfSu2+wRz3d6vsHdwawvNVuFNoYihZ0nyXcisvC6inxtqAcAAl4Ok49tsCSyHNId0252peNGYegCcHD+S4ZkwyV7aYPo4trPQVCiZKLufziDIfxW3/YzkLeIflusC7W7uxCvQWb3d0kIMCQgcPDMsqMztfxfhDOqo3F2KCmmwFd3ShHQqJsK3O4jvZHfoXq1gZ3yV4AbjP4eP2tgJsCbKRk9gO8RsA+Jl7Q6Fs4x3knz2xrZJfvGzKLUPcBXmMrg+vTDm0OU4UZH6YTbrioan2rvPWKCliKYIk9eLLA7W4jCB3BKqF4oIucLWFUdUlyUrGiAKzCvxcOnBVXbjJLOgePWWlVsfhcbXu4UstgVD1LzdVKZquQeBTX3IiVcVV9L1hMyQ/grBRMS96IoNJZ1VM1kI+qUsj9x4ctIoxmmGrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18092099006)(18002099003)(6133799003)(10086099003)(261009223327099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5PS+bc4gcIHkM4aWeK4VY1JXJFHmaJgRA1AjVqqX+zFDReuTijxmIm/ykf6U8gfwpu187UwZkcjnVDheGBVIdZQrymw1rOCVwHg96Ku7VZhTY74OQJmY3h9soKYaCPvJgfEhJ3BDqyS/qqoUUWxivOSom6fvHY4nPsCnreGw3oTAA8V4SVjSlypuK+G1biba3i+ZSbD/s12QquGXaYKh0nAvhH4qSFS1VAKvVZkAE6/ZEsSZ/LU6Flo5l5tc6OYvFP0TOC8KnXrAPBcfqWZCDcoZRInThp5rqAFGP/fdT2W/hlOo8uFg3drXYI23l54grZoiU/VdPMWXGwroUBf/ly9c2cqg4B+2Z2PMOeFMYfzscWSiPfXY0u3ReWXkPKFqYBCx7j4eCbkzBKObAGyMAYUA8VG41V2KhS36Pz+tKFtE1XqzCS6VpZmqISjRvCfg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 21:17:47.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b68328-6e22-4c92-a107-08df410266a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026958.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Simona,

New stuff for 7.5.

The following changes since commit a24121023a434cb9b2b4db964d3fbbb4547d5e4c:

  drm/radeon: retry UVD v1 init on failure after resume (2026-10-27 15:10:50 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.5-2026-11-12

for you to fetch changes up to a6836fcbb5b22968019256025321d655b78bc49c:

  drm/amd/display: Add support for more PSP footer sizes (2026-11-09 17:40:50 -0500)

----------------------------------------------------------------
amd-drm-next-7.5-2026-11-12:

amdgpu:
- DCN 6 DML2 fix
- VCE fixes
- GC 11.0.2 fix
- SMU 15 fix
- Error handling fixes
- Partition fix
- IMU firmware clean up fix
- TLB fence handling fix
- Enable JPEG type4 packet support
- UALink updates
- RAS updates
- GC fixes
- UserQ updates
- GEM_OP fix
- CS IB parsing fixes
- SMU 15.0.8 updates
- GPU reset fixes
- vcn/uvd/vce/jpeg idle work handler cleanup
- GPUVM fixes
- NBIO updates
- DC CRC fixes
- MES debug extension support
- SR-IOV updates
- HDMI 2.x fixes
- DSC fixes
- DC pstate fixes
- DC replay fixes
- DC FAMS updates
- More display KUNIT tests
- SPM rework
- GC 12.1 updates
- VRR/freesync fixes
- HDR fixes
- eDP/LVDS fixes
- Remove fence ops->release()
- Debugfs fixes
- Backlight fixes
- SMU 7 cleanup
- Non-DC audio fix
- Documentation fixes
- DC PSP footer size fix

amdkfd:
- SVM fixes
- CRIU fixes
- Fix WPTR BO eviction fence handling
- Trap handler fixes
- dma-buf handling fixes
- CRAT cleanup
- Add support for discontiguous and CPU-less NUMA topologies
- Handle perfmon clocking when profiler is active
- Profiler locking fixes

drm:
- EDID parsing support for HDMI 2.2 FRL rates from the SCDS

radeon:
- ATRM bounds checking
- R6xx UVD fix

UAPI:
- Update KFD profiler version number to note perfmon clocking fix
  Proposed userspace: https://github.com/ROCm/rocm-systems/pull/14521

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu: drop async_gfx_ring parameter
      drm/amdgpu: re-enable SPM updates in the the IB path
      drm/amdgpu: reemit RLC SPM register in ring reemit

Alex Hung (5):
      drm/amd/display: Avoid closing unowned DDC pins
      drm/amd/display: Add more backlight Kunit tests
      drm/amd/display: Add more color KUnit tests
      drm/amd/display: Add more CRC KUnit tests
      drm/amd/display: Add more connector KUnit tests

Allen Li (1):
      drm/amd/display: Allow bypassing link_off_frame_count check for replay debug mode

Alvin Lee (4):
      drm/amd/display: Add visual confirm full viewport debug option
      drm/amd/display: Indicate wait_resp based on FAMS even in disable path
      drm/amd/display: Enable immediate restore for FAMS on DCN6
      drm/amd/display: Update alt shared lib to use dynamic state

Amadeusz Sławiński (2):
      drm/amdgpu: Prevent debugfs nullptr dereference
      drm/amd/display: Prevent debugfs nullptr dereference

Amber Lin (3):
      drm/amdgpu: Add xcp to reset_mes_compute function
      drm/amdgpu: Add debug messages for MES queue reset
      drm/amdgpu: No need of multiple hung_queue_db_array

Andrei Krautsou (1):
      drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2

Apurv Mishra (2):
      drm/amdkfd: Don't reuse a VRAM page that is still referenced
      drm/amdkfd: Force perfmon clock on for profiler PMC requests

Arnaud Bonnet (1):
      drm/amdgpu: add missing parameter documentation in amdgpu_ttm_map_buffer

Asad Kamal (5):
      drm/amd/pm: Report SMU 15.0.8 XGMI bandwidth
      drm/amd/pm: Add a metrics revision attribute ID
      drm/amd/pm: Add a metrics revision for SMU 15.0.8
      drm/amdgpu: Add 13.0.12 & 13.0.15 to TOS reload check
      drm/amd/pm: time SMU metrics caches with ktime

Austin Zheng (2):
      drm/amd/display: Update Rounding For VM stage groups
      drm/amd/display: Parameterize FCLK/PPT/Temp Read P-State Optimizer

Bas Nieuwenhuizen (1):
      drm/amdgpu: Check cs flags.

Benjamin Cheng (4):
      drm/amdgpu/jpeg_v1_0: allow type4 commands
      drm/amdgpu/jpeg_v2_0: set only IB_RD_VMID to 0
      drm/amdgpu/jpeg_v4_0_3: set only IB_RD_VMID to 0
      drm/amdgpu/jpeg: allow type 4 commands

Benjamin Welton (1):
      drm/amdkfd: fix double lock acquisition in set_perfcount

Calvin Owens (1):
      Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"

Ce Sun (1):
      drm/amdgpu: skip RAS error count reset in debug mode

Chandana G B (1):
      drm/amdgpu: add the new optc_underflow_enable

Chenglei Xie (2):
      drm/amdgpu: initialize VF2PF work before it can be cancelled
      drm/amdgpu: abort SPM VF init when the HBM aperture is missing

Christian König (1):
      drm/amdgpu: fix TLB invalidation fence handling v4

Dariusz Marcinkiewicz (1):
      drm/amdgpu: check amdgpu_vm_ready() in dma-buf move notify

David Francis (3):
      drm/amdkfd: Don't check for vm ready on svm unmap
      drm/amdkfd: Acquire buffers in CRIU queue restore (again)
      drm/amdkfd: Acquire cwsr buffer during CRIU resume

David Rosca (4):
      drm/amdgpu: Use feedback buffer for VCE destroy message
      drm/amdgpu: Allow multiple VCE create commands with same handle
      drm/amdgpu: Fix VCE buffer size check for DPB and input surface
      drm/amdgpu: Allow VCE SEI command in IB

Dhruv B (2):
      drm/amdkfd: Remove unused code in CRAT initialization
      drm/amdkfd: Add support for discontiguous and CPU-less NUMA topologies

Dominik Kaszewski (1):
      drm/amd/display: Clarify endianness error

Ellen Pan (1):
      drm/amd/amdgpu: Fix NULL RAS context deref on VF unrecoverable error

Erhan Bilgili (2):
      drm/amdgpu: Fix duplicate dependency fence releases
      drm/amdgpu: Report MES ring wait timeouts.

Fangzhi Zuo (4):
      drm/edid: Parse HDMI 2.2 FRL rates from the SCDS
      drm/amd/display: Accept HDMI 2.2 FRL rates from the sink EDID
      drm/amd/display: Fix unadvertised mode detection
      drm/amd/display: Add debugfs override for HDMI VRR

Felix Kuehling (1):
      drm/amdgpu: Change default mtype_local for GFX12.1

George Shen (1):
      drm/amd/display: Skip dsc sequence for stream if dpms off

Hugo Sales (3):
      drm/amd/display: Fall back to the native mode, not the first, on eDP/LVDS
      drm/amd/display: Add KUnit tests for the eDP/LVDS native mode fallback
      drm/amdgpu: Clamp the ATIF backlight curve to its 99 points

Ilya Bakoulin (2):
      drm/amd/display: Adjust DSC slice calc. policy
      drm/amd/display: Expand DSCCLK support check

Ilya Shidlovskiy (3):
      drm/amd/display: dcn32: rebuild WM range table when memclk states change
      drm/amd/pm: smu13.0.0: refresh the UCLK DPM table after an OD_MCLK change
      drm/amd: let DC re-read UCLK DPM levels after an OD_MCLK change

Ingyu Jang (1):
      drm/amd/pm: remove dead code in smu7_patch_dependency_tables_with_leakage()

Ivan Lipski (3):
      drm/amd/display: Use DCN6 driver_if for PPCLK_e enum
      drm/amd/display: Configure alternate-channel apertures
      drm/amd/display: Fix __udivdi3 link error in DCN6 DML2

Jay Cornwall (1):
      drm/amdkfd: Scope VOP3PX trap workaround to revision 0

Jesse Zhang (25):
      drm/amdgpu/gfx12: flush the scratch register write in the ring test
      drm/amdgpu/gfx6: flush the scratch register write in the ring and IB tests
      drm/amdgpu: sign extend the addresses GEM_OP(GET_MAPPING_INFO) returns
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
      drm/amdgpu: keep the CS user fence BO in GTT
      drm/amdkfd: use the queue's process info for the WPTR BO eviction fence
      drm/amdgpu/gfx7: flush the scratch register write in the ring and IB tests
      drm/amdgpu/gfx8: flush the scratch register write in the ring test
      drm/amdgpu/gfx9: flush the scratch register write in the ring test
      drm/amdgpu/gfx10: flush the scratch register write in the ring test
      drm/amdgpu/gfx11: flush the scratch register write in the ring test
      drm/amdgpu/userq: validate the moved individual BOs on restore
      drm/amdgpu/mes: wake the GPU before toggling mes_dbgext from debugfs
      drm/amdgpu/gfx12: disallow GFXOFF while updating the SPM VMID
      drm/amdgpu/gfx11: program the SPM VMID once the RLC runs
      drm/amdgpu/gfx12: program the SPM VMID once the RLC runs
      drm/amdgpu: drop the dma-buf reference when a KFD import fails
      drm/amdgpu: unlock the VM and BO when attaching a KFD BO fails
      drm/amdgpu: rewrite all PTEs of the BOs after a VM reset
      drm/amdgpu: don't walk the CS chunks when allocating them failed
      drm/amdgpu: don't drop the gang dependency fence twice
      drm/amdgpu/mes: initialize the dbgext work before it can be cancelled
      drm/amdkfd: skip GPUs without a VM when checkpointing the BO mappings
      drm/amdgpu: fix the error handling of amdgpu_vm_init_entities()
      drm/amdgpu: release the IMU firmware with the other GFX microcode

Jiahao Li (1):
      drm/amd/amdgpu: Use RSMU index and data pair in nbio_v6_3_2 get_pcie_index/data_offset()

John Harrison (2):
      drm/amd/display: Fix some memory lifetime issues in KUnit tests
      drm/amd/display: Fix use-after-free in dm_test_hpd_rx_offload_work_msg_rdy

Kanala Ramalingeswara Reddy (2):
      drm/amdgpu:smu: Update stapm_power_limit values in gpu_metrics for SMU14
      drm/amdgpu: use supported SMU clock messages on SMU 15.0.0

Kent Russell (1):
      drm/amdgpu: Ensure that harvest information gets set

Kevin Wang (2):
      drm/amd/pm: unwind init failures for SWSMU
      drm/amd/pm: populate unique ID for smu 13.0.7

Kylie C (1):
      drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on seamless boot

Leo Liu (1):
      drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg

Lijo Lazar (2):
      drm/amdgpu: Add missing firmware declarations
      drm/amdgpu: Allow cancelling a requested NPS mode

Mario Limonciello (1):
      drm/amd/pm: track BACO state in the SMU v11 ArmD3 sequence

Matthew Schwartz (1):
      drm/amd/display: Keep the nominal vtotal while VRR is inactive

Meenakshikumar Somasundaram (1):
      drm/amd/display: Support replay frame update interval

Melissa Wen (1):
      drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR

Mikhail Gavrilov (1):
      drm/amd/display: set allow_freesync before validating a new stream

Milan Milicevic (2):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih
      drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL

Misha Nasledov (1):
      drm/amd/display: Drop clock requirements on DCN32 when no displays are active

Mukul Joshi (1):
      drm/amdgpu: only tear down an active UALink accelerator

Ovidiu Bunea (1):
      drm/amd/display: Add support for more PSP footer sizes

Perry Yuan (4):
      drm/amdgpu: validate the size in GEM_USERPTR ioctl
      drm/amdkfd: preempt the HWS runlist once in set_perfcount
      drm/amdgpu: add a debug flag to disable the userptr size limit
      drm/amdkfd: check CRIU SVM priv data bounds before allocating

Philip Yang (1):
      drm/amdgpu: UALink add debugfs selftest

Philipp Stanner (1):
      drm/amdgpu: amdgpu_fence: remove ops->release()

Prike Liang (9):
      drm/amdgpu/mes: skip unmap queue notification during GPU reset
      drm/amdgpu/uvd: don't allocate or lock BOs in the direct IB test
      drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues
      drm/amdgpu/gmc11: don't access the fault registers during GPU reset
      drm/amdgpu: finish GPU recovery callbacks before restarting schedulers
      drm/amdgpu: stop the schedulers before preparing the GPU reset
      drm/amdgpu: save VKMS modeset state from the system PM path only
      drm/amdgpu/vce: don't allocate a scheduler fence in the direct IB test
      drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle work

Rafal Ostrowski (1):
      drm/amd/display: Decouple FAMS2 config update from dc/dc_state and add BLS opcode

Roman Demidov (1):
      drm/amd/display: Fix NULL deref in dcn401_update_clocks_update_dtb_dto

Roman Li (1):
      drm/amd/display: Reset DET of HUBPs without a plane before outstanding updates

Sunil Khatri (3):
      drm/amdgpu/userq: use BIT(x) instead of 1 << x
      drm/amdgpu/userq: add an blank line after declaration
      drm/amdgpu/userq: remove extra blank lines

Taimur Hassan (2):
      drm/amd/display: [FW Promotion] Release 0.1.82.0
      drm/amd/display: Promote DC to 3.2.405

Ted Bullock (1):
      drm/radeon: UVD GTT corruption and RV6xx coverage

Timur Kristóf (1):
      drm/amdgpu/vce1: Fix checking whether VCE1 is idle

Tobias Klauser (1):
      drm/amd/ras: omit redundant memset of already-zeroed buffers

Tony Cheng (1):
      drm/amd/display: Remove DCN401 RDPCS PHY state reads

Tristan Madani (1):
      drm/radeon: validate ATRM return buffer type and length

Wayne Lin (2):
      drm/amdgpu: add DCN36 OPTC RSMU underflow registers
      drm/amd/display: add missing CRC engine 1 registers

Yongqiang Sun (4):
      drm/amdgpu: wire mes_dbgext on mes12.1
      drm/amdgpu: setup MES DBGEXT per requested pipe
      drm/amdgpu: add per-XCC mes_dbgext state
      drm/amdgpu: restore MES12.1 mes_dbgext per XCC after XCC reset

renpanpan (1):
      drm/amdgpu: Only enable HDMI audio if display supports it

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 346 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 117 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |  35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  49 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            | 126 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |  31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c          |  49 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h          |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            | 279 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         | 229 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h         |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  88 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  65 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c   |  22 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |   5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 147 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             | 213 ++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  50 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  51 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |  14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |  13 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  13 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               |  13 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c             |  12 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |  38 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |  28 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |  27 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |  28 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |  38 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |  27 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |  27 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |  28 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |  28 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |  27 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             | 132 +++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |  15 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |  23 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |  41 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |   5 +
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |   2 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |  31 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  15 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  13 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  17 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  15 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |  15 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |  15 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |  15 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |  16 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     | 695 ++++++++++++++++++++-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm |  43 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  73 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  69 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  12 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 157 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  20 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  20 +
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  47 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  26 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  20 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  33 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  13 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 134 +++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  50 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  74 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  29 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   6 +
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  79 ++-
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |  18 +
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 344 +++++++++-
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   | 124 ++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  30 +
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   9 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   8 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   7 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |   8 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |   3 +
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |  37 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  27 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  69 ++
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  47 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       | 113 ++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |  27 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   3 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h   |   1 -
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |  16 +-
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c        |  22 +-
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h        |   8 -
 .../inc/bounding_boxes/utm_qos_model_dchub_v2.h    |  32 +-
 .../inc/bounding_boxes/utm_qos_model_dchub_v3.h    |   2 +-
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |   2 +-
 .../dml2_core/dml2_core_dcn5_funcs_mode_support.c  |  24 +-
 .../dml2_core_dcn6_funcs_mode_programming.c        |   1 +
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.c  |  19 +-
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c  |  25 +-
 .../alternate_pstate_shared_lib.c                  |   2 +-
 .../alternate_pstate_shared_lib.h                  |   1 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c     |   1 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c     |   1 +
 .../dml21/src/inc/dml2_internal_shared_types.h     |   4 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  24 +-
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c   |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |   1 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  64 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |   4 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |   2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |   2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |   2 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |  20 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |   2 -
 .../display/dc/link/protocols/link_dp_capability.c |   6 +-
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |   7 +
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h |  18 +
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h |  22 +-
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.h   |  18 +
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h |  11 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h |  11 -
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.h   |  12 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |   2 +
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h |   2 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |  15 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.h |   6 +
 .../display/dc/resource/dcn401/dcn401_resource.c   |  10 +-
 .../display/dc/resource/dcn401/dcn401_resource.h   |   6 +
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   2 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  31 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  41 +-
 .../drm/amd/display/include/link_service_types.h   |   2 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   6 +-
 .../amd/include/asic_reg/dcn/dcn_3_6_0_offset.h    |   8 +
 .../amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h   |  36 ++
 .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h |   2 -
 drivers/gpu/drm/amd/include/atomfirmware.h         |   3 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   3 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   7 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 117 +---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  60 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  47 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  20 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  30 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  20 +
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |   2 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  19 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |  28 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   5 +-
 drivers/gpu/drm/amd/ras/core/eeprom.c              |   1 -
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |   2 -
 drivers/gpu/drm/drm_edid.c                         |  12 +
 drivers/gpu/drm/radeon/radeon_bios.c               |   9 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |   9 +-
 include/uapi/linux/kfd_ioctl.h                     |  11 +-
 212 files changed, 5175 insertions(+), 1486 deletions(-)
