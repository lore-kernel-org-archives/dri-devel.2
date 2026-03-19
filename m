Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8551088E5E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BA010E94C;
	Thu, 19 Mar 2026 17:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZimcMgxN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F86010E7DD;
 Thu, 19 Mar 2026 17:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueq+Gp7k/GCua9XdyPWlCkuysviGA8aWfCTnE0qYPQbfcd2XUZ3M2kgaKt0A3FB8OpFIJXpPm4LiCNqZj9/B06H4AQHiv99XWggTrM7OuNNMclkLNx226hI7alLxryXwaIZa9HNLFOHXh03iLjjqaoPnsZ68vVACpqEn7jKS/738xq68ZSNjn18mKvI7rkbLQRRj2eM31BVg4sLhAZ5xyksxwypqxy69+a0z/ai7fdMUpQG+8dwLcSJrZR04QulT3aZ4Do9bQMYbZohTU3rNgUHzUB8zLYMP5AL9DbLexGst1i3Yu0SknvZw1qNFJLtzo7O00C3H04PeQiGDPNto3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maMqE7+2rPjgFS+gyHTBQ0np9KYdXxEHegU+8U5UuKo=;
 b=bjFsG4vGn5BPQrbGftwdwECyCSwiaHQXnYgusMsLAKoreRfL5o//IrHkAC8Q08WegOoogb/peklb3Hr8wWwvZFk7s+nN5hYWoqDH980AfegxVhr1iW1qLHogQJVjJE4jgP6+mjHl+XsiJ/fw2cqMZdAJ1qqnX7XVhQkRHVdaAW7PyLNJj0k+EJ+0l8rirF5M5+SsgAqA8igbvDudSOaoAHL7f644MlF9E16iOOw64ekXSQVyYL73t+MSAiAwAxBeWSoelTVlatYBn0EOeS4CNbEEQuHAKRI9nrLPEfVZV80+m+YeHrY6D1mPr+cIIAkCXwsLeh8bTaZ3zxmKf9l+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maMqE7+2rPjgFS+gyHTBQ0np9KYdXxEHegU+8U5UuKo=;
 b=ZimcMgxNPr/tG9MniNx5Onpj/6LsLfjJNoWbRVI87dGaL5ZRtulPI4iT5ZJtbutDBFu+vOy5Og6HCpcQyV0fOgiBAkPLofh6e6B4wPOHVvNuI+HvWXp5Sx2eADoCRSPbJHq/JzLeBGgtLyFCCHS7JDtxpkU5psIK5N/CGj5VY3g=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 17:33:47 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::6b) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 17:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 17:33:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 19 Mar
 2026 12:33:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 12:33:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Mar 2026 12:33:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.1
Date: Thu, 19 Mar 2026 13:33:32 -0400
Message-ID: <20260319173334.479766-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 8864df45-1afd-4e12-e9f9-08de85ddad04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|56012099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: t7cRiqFLlt0kn158ot1K3kvWbhTtkXkwuxZImsBF/ANJM9OR13yh69X6WiYFVbdCoQpINR54L0zrRrwzLv+cZvTe4nhV3ZDUAc3jh/8tXb0yUFgKiSZSj0V5ywB7Mw1L/bWfo6R+DRujqUGcplRYnJ3aFWYTKjSCgMpFvzauysC4+IQffBUI7eSXBgfT8I9F616qsfbEa9htArFNvPjewuxAIKju6OXuVALLvmQzwNTeo2/7ZGTSx/Pu7ud4S0cNB81/u8Dx7B+yaJ7+FWT9Z4IbrPTB8QUx43/Km+huB2fA0PGo4jeqf1dXNBTpDr59CHMVmEIPcy2g+6dAav6rNKOkvWjKej6rVMFnYDx6XbmQqJ/OY/ckGNljGyWntl3rFzCl05MUA4GlmX9HtTdI3k4uyZVYWEcK7t3bePtrthi70vqX/bk9HPASBhA4J9OSSPBf3GT+u6IxKshHWsDw2sHZ71nJ87V6FZqGNw54IPs7dsuEaY7LqdnuFVfaBMqqKjkpInWdVD5eovrNE4y78GrwE8RmiQYz9R7Kz/jYjTZdrrpsFhK0fD9K41Uc2RdOVGB1mYgUno6hzmf+0t+GjEFAL0DHiuTyXYXFL280KwuIDp7RqnVLppn7W/aTcFQ6M6+asdZeKIegPnEz/rusTMuFkbAHQBBqSldY6eYk873Zh38bvUzn7GhePWzLjlLYnFdc2Vq/LfFA7/zGalKmzbwCHjlk5G72TIjg+U9EAj0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(56012099003)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ARFlhwWix2eAkWnxPNbgH1VSDwk0QBF1zMKbWk/K1EaJ68mhEqFBMptnL0MhnGc7e2tyongRTd7a/23UML9z79+aAgUUmd7F24DGvfOPEPNs3eSYYlfXD+/GGvr+aeI/YAfizaWLSCr4RjcLBsBIns3BaNxhD5UNXa9AcqA3xwGdhWVPKQgJTyLBazPGIp96mM/wTJKjk5HrRRA0c7Ti2tDSGGa78JBIkY21r16m71sZwNWtr8sR8UVNku5sDj/irMkTLprzKcRtxl20K/AcEDsUvpvoRNq8moX1qQr9e9Y9k6lPiy0+YKHBL5gtLWZBm3wNJwvDw1VoTzaazQliSwZofGu8hVLYqh7MBZwx/mJ2JtDDdn5eqxZV5I06vBubWbx77CX3ZprsrjHheTr/p0hqQ2rHLh9d0NNcRgGdm8v80tRghWIqV9lnFcZZ4Zhc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 17:33:46.8898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8864df45-1afd-4e12-e9f9-08de85ddad04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
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

More new stuff for 7.1.

The following changes since commit d93f8ea0e5ad41d661496d205fac3e2fbd9358c0:

  Merge tag 'drm-intel-next-2026-03-16' of https://gitlab.freedesktop.org/drm/i915/kernel into drm-next (2026-03-17 15:44:26 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-2026-03-19

for you to fetch changes up to daf9f9dd509113d6f49ce7c00d92bc17db58f215:

  drm/amdgpu: Add client ids for gmcv9 mmhubs (2026-03-17 17:50:52 -0400)

----------------------------------------------------------------
amd-drm-next-7.1-2026-03-19:

amdgpu:
- Fix gamma 2.2 colorop TFs
- BO list fix
- LTO fix
- DC FP fix
- DisplayID handling fix
- DCN 2.01 fix
- MMHUB boundary fixes
- ISP fix
- TLB fence fix
- Hainan pm fix
- UserQ fixes
- MES 12.1 Updates
- GC 12.1 updates
- RAS fixes
- DML updates
- Cursor fixes
- SWSMU cleanups
- Misc cleanups
- Clean up duplicate format modifiers
- Devcoredump updates
- Cleanup mmhub cid handling
- Initial VCN 5.0.2 support
- Initial JPEG 5.0.2 support
- PSP 13.0.15 updates

amdkfd:
- Queue properties fix
- GC 12.1 updates

radeon:
- Hainan pm fix

----------------------------------------------------------------
Alex Deucher (11):
      drm/amdgpu/mmhub2.0: add bounds checking for cid
      drm/amdgpu/mmhub2.3: add bounds checking for cid
      drm/amdgpu/mmhub3.0.1: add bounds checking for cid
      drm/amdgpu/mmhub3.0.2: add bounds checking for cid
      drm/amdgpu/mmhub3.0: add bounds checking for cid
      drm/amdgpu/mmhub4.1.0: add bounds checking for cid
      drm/amdgpu/mmhub4.2.0: add bounds checking for cid
      drm/amdgpu/gmc9.0: add bounds checking for cid
      drm/amdgpu: rework how we handle TLB fences
      drm/amdgpu: apply state adjust rules to some additional HAINAN vairants
      drm/radeon: apply state adjust rules to some additional HAINAN vairants

Alex Hung (1):
      drm/amd/display: Fix gamma 2.2 colorop TFs

Alex Sierra (1):
      drm/amdgpu: 57-bit enable for watch address on gfx_v12_1

Andy Nguyen (1):
      drm/amd: fix dcn 2.01 check

Asad Kamal (6):
      drm/amd/pm: Add common smu fw check function
      drm/amd/pm: Use common smu fw check function for smu13
      drm/amd/pm: Use common smu fw check function for smu15
      drm/amd/pm: Add fru eeprom info support
      drm/amd/pm: Update pm attributes
      drm/amd/pm: Add mutex lock for metrics table

Austin Zheng (2):
      drm/amd/display: Fix number of opp
      drm/amd/display: Add dcn_mrq_present Field

Benjamin Nwankwo (1):
      drm/amd/display: Clamp dc_cursor_position x_hotspot to prevent integer overflow

Calvin Owens (1):
      drm/amd/display: Fix uninitialized variable use which breaks full LTO

Christian König (5):
      drm/amdgpu: fix amdgpu_userq_evict
      drm/amdgpu: completely rework eviction fence handling v2
      drm/amdgpu: fix eviction fence and userq manager shutdown
      drm/amdgpu: fix adding eviction fence
      drm/amdgpu: rework amdgpu_userq_wait_ioctl v4

David Baum (1):
      drm/amdgpu: switch XGMI sysfs show helpers to sysfs_emit_at()

Erik Kurzinger (1):
      drm/amd/display: remove duplicate format modifier

Feifei Xu (1):
      drm/amdgpu/mmhub_v4_2_0: expand gart aperture to gart_end on A+A

Gaghik Khachatrian (1):
      drm/amd/display: Silence static analysis warning

Harish Kasiviswanathan (3):
      drm/amdkfd: Don't expect signal mailbox update
      drm/amdgpu: Update MTYPE for GFX12.1
      drm/amdgpu: Support forcing MTYPE_RW

Harry Wentland (1):
      Revert "drm/amd/display: Add NV12/P010 formats to primary plane"

Hawking Zhang (17):
      drm/amdgpu: Limit physical transcation mode to A + A only
      drm/amdgpu: Place gart and vram in sysvm aper for A + A
      drm/amdgpu: Init table depth and block_size for A + A
      drm/amdgpu/gmc12: Set up pdb0 for vmid0 page table
      drm/amdgpu: Correct mmhub system aperture settings for A + A
      drm/amdgpu: Update gfxhub system aperture settings for A + A
      drm/amdgpu/gmc12: Bypass FB resize on A + A platform
      drm/amdgpu/gmc12: Update gmc aperture base for A + A
      drm/amdgpu: Implement get_xgmi_info callback for mmhub_v4_2
      drm/amdgpu: Query xgmi info from mmhub if available
      drm/amdgpu: Retire get_xgmi_info callback for gfxhub v12_1
      drm/amdgpu/gmc12: Query host-gpu interface
      drm/amdgpu/gmc12: Fix VRAM base offset calculation
      drm/amdgpu/gmc12: Update connected_to_cpu flag
      drm/amdgpu/gmc12: Init vram_size for A + A
      drm/amdgpu: Place firmware bo in vram for A + A
      drm/amdgpu: fallback to default discovery offset/size in sriov guest

Jack Xiao (2):
      drm/amdgpu/mes_v12_1: add mes self test
      drm/amdgpu/mes12_1: fix the failure access to MID1 registers

Jesse.Zhang (3):
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion
      drm/amd/amdgpu: Fix build errors due to declarations after labels
      drm/amdgpu: validate fence_count in wait_fences ioctl

Leo Li (1):
      drm/amdgpu/atomfirmware: Add LpDDR5x and new fields for info v2_3

Lijo Lazar (5):
      drm/amdgpu: Add client id helpers to mmhub
      drm/amdgpu: Add client ids for mmhub v4.x
      drm/amdgpu: Add client ids for mmhub v3.x
      drm/amdgpu: Add client ids for mmhub v2.x
      drm/amdgpu: Add client ids for gmcv9 mmhubs

Likun Gao (2):
      drm/amdgpu: retire some unsupport cmd pkt bit for gfx v12_1
      drm/amdgpu: update cp packets for gfx v12_1

Mangesh Gadre (1):
      drm/amdgpu : Update psp 13_0_15 ip block support

Michael Chen (1):
      drm/amdgpu: Fix RRMT for gfx v12_1

Nathan Chancellor (1):
      drm/amdgpu/discovery: Add braces to case statements in amdgpu_discovery_table_check()

Nicholas Carbones (1):
      drm/amd/display: Query DC for gfx handling when setting linear tiling

Nicholas Kazlauskas (1):
      drm/amd/display: Plumb MRQ programming out of DML for dml2_1

Philip Yang (1):
      drm/amdkfd: Update queue properties for metadata ring

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: move devcoredump generation to a worker

Pratap Nirujogi (1):
      drm/amdgpu: Fix ISP segfault issue in kernel v7.0

Ray Wu (1):
      drm/amd/display: Add debugfs to disallow eDP Replay entry

Sonny Jiang (4):
      drm/amdgpu: Add VCN v5_0_2
      drm/amdgpu: Add VCN_5_0_2 codecs capabilities support
      drm/amdgpu: Set VCN_5_0_2 DPG mode
      drm/amdgpu: Add JPEG_v5_0_2 IP block

Sreekant Somasekharan (1):
      drm/amdgpu: Revert setting up Retry based Thrashing on GFX 12.1

Srinivasan Shanmugam (8):
      drm/amd/display: Fix DisplayID not-found handling in parse_edid_displayid_vrr()
      drm/amdgpu: Drop unreachable return in amdgpu_reg_get_smn_base64()
      drm/amd/ras: Fix NULL deref in ras_core_ras_interrupt_detected()
      drm/amdgpu: Add default case in DVI mode validation
      drm/amd/ras: Fix NULL deref in ras_core_get_utc_second_timestamp()
      drm/amdgpu: Drop redundant queue NULL check in hang detect worker
      drm/amdgpu: Move amdgpu_vm_is_bo_always_valid() before first use
      drm/amdgpu: Remove dead negative offset check in amdgpu_virt_init_critical_region()

Sunil Khatri (5):
      Revert "drm/amdgpu: revert to old status lock handling v4"
      drm/amdgpu/userq: Use kvfree instead of kfree in amdgpu_userq_wait_ioctl
      drm/amdgpu/userq: Use kvfree instead of kfree in amdgpu_userq_signal_ioctl
      drm/amdgpu/userq: fix dma_fence refcount underflow in userq path
      drm/amdgpu/userq: unlock cancel_delayed_work_sync for hang_detect_work

Taimur Hassan (1):
      drm/amd/display: Promote DC to 3.2.374

Tao Zhou (1):
      drm/amdgpu: update flip bit setting of RAS bad page

Tom Chung (1):
      drm/amd/display: Add a buffer for boot time crc

Xi Ruoyao (1):
      drm/amd/display: Wrap dcn32_override_min_req_memclk() in DC_FP_{START, END}

YiPeng Chai (4):
      drm/amd/ras: Add unified interface to handle ras interrupts
      drm/amdgpu: Add umc ecc error handling for gmc v12_1
      drm/amdgpu: Add poison consumption handling for gfx v12_1
      drm/amd/ras: Pass ras poison consumption message to sriov host

Yicong Hui (1):
      drm/amdgpu: Replace deprecated strcpy() in amdgpu_virt_write_vf2pf_data

 drivers/gpu/drm/amd/amdgpu/Makefile                |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    6 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |   83 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |    7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |  227 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h |   55 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |   26 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c     |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |   11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   62 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  594 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  181 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   80 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h         |  223 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          |  193 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   76 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |   29 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   78 +-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |  840 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h           |  111 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |  392 ++++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |   46 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |   17 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c            |   16 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c          |   17 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c          |    9 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c            |   55 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c          |   15 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |  194 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |   21 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |   69 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c             |  113 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            | 1219 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h            |   29 +
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h            |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c   |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c   |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c |   18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   30 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   64 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   21 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |    6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   52 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   11 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   10 +
 drivers/gpu/drm/amd/display/dc/dc.h                |   11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   27 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |    9 +
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |    2 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |    6 +-
 .../dml2_0/dml21/inc/dml_top_soc_parameter_types.h |    1 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |    1 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |   22 +
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |    7 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    1 +
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |    9 +-
 .../amd/display/dc/resource/dcn10/dcn10_resource.h |    2 +
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |    3 +-
 .../display/dc/resource/dcn201/dcn201_resource.c   |    3 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |    3 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |    3 +-
 .../display/dc/resource/dcn301/dcn301_resource.c   |    3 +-
 .../display/dc/resource/dcn302/dcn302_resource.c   |    3 +-
 .../display/dc/resource/dcn303/dcn303_resource.c   |    3 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |    1 +
 .../display/dc/resource/dcn314/dcn314_resource.c   |    3 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |    3 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |    3 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |    4 +
 .../display/dc/resource/dcn321/dcn321_resource.c   |    1 +
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |    3 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |    3 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |    3 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |    9 +-
 .../display/dc/resource/dcn401/dcn401_resource.h   |    2 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |    5 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   36 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |    4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |    1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |    2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |    2 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   43 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   52 -
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |    3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   29 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |    1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |   31 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h   |    1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c   |   10 +
 drivers/gpu/drm/amd/ras/rascore/ras_core.c         |   11 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |    4 +-
 126 files changed, 4556 insertions(+), 1389 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h
