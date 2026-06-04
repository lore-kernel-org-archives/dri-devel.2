Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7E9CD6E60
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 01:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12D6112531;
	Thu,  4 Jun 2026 01:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0uElJVAw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A416011251B;
 Thu,  4 Jun 2026 01:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSM+wYWouS+QHqMElwUY7YSIb50XYPHHT85k+kO+64y0kbtGtHfFr33kFL1g/nVuKhU5QTuijg8Tt4/6UsPJ52CRMdCoueKDsuKaYhp2qQVqI3JINO/ZGW2BTto7uOmwMQdn0zUXdwj4D0ze1qwS/9L8S3axCIRtX2yiB4Y94EvfpUa1hUaooajaT8rGyGEvmdI2D5+mQAU4aWrpIS4zD8M9LeONl0dYM7trVKA/+oTFIqa7dV0h4Aoo8WYLxhFU221PeOjlQXWUvkm5SWRTkHb1vZwxXXKp5f0cNFBubmfxUqwlbHk0AEcK9l4cUb/75MJ2VfCJ70Vp7SFgu5cB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGToeUkBj0gU1FkqRs6RESVdD+/J7/EWBc9MUmE00Nw=;
 b=SwoKT3PcMYIw51Wg4F+scFjZLx6SGE+gS5XcaR1QRFa8MtvnYy2754YEKovKdl8shXxx39hFZP4gr7BAlT1IB7AxEdP5aHxkVxphfsNBq+AAd+YFCKilwIqtykcDfu5VyM4R5LDV8KUZKVOblLjCzPOA2it9NTwo4k89pn7CERjmjoXYue/gFHct5SyFMslLjo6pBu38eZx3wpHHHWAmA60xSPX7IwFn8pDd81MFFGuhmUQDxLWreM1sXqmcaafKOUqAZEbkn31jJgYXFikgbr1bHZiJemAQD17nGPQSIgKPsODNO8y93Jt7NgxftpAqIZ8vUeRZdc3hY6KKb0EwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGToeUkBj0gU1FkqRs6RESVdD+/J7/EWBc9MUmE00Nw=;
 b=0uElJVAwox/d8UVNrCIgABK33qo4CdrhQY/f3Fls1cH6OOeDoWA48DD7ZU+2Kvgn/N+KieXXkNRTbLLfG//pUNCqbTmYaJvHxQ/lwY+QZOTygvleX+oWIWJoV5sHe3tWvicYxwLPifLAf7H/rtXb3SXpLdfYjNnvu8ryZErdjog=
Received: from PH8PR22CA0017.namprd22.prod.outlook.com (2603:10b6:510:2d1::13)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:14:00 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::9d) by PH8PR22CA0017.outlook.office365.com
 (2603:10b6:510:2d1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 01:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 01:13:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 20:13:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 20:13:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 20:13:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.1
Date: Wed, 3 Jun 2026 21:13:50 -0400
Message-ID: <20260604011351.2373027-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e838ac-fa84-47d4-3a46-08dec1d68ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: cNrNJsce+ao/gwPia/8ohrs71nruI82WHfSBU+vvxWhUCve2PDbPKJ/BP1weaGiAuXThXWKyVq5PMf1/J8FrG7L/8ONRhgxkpF6oRxaYGgBL+Uk0KB7R2SDytD6n+3V8dX1yspuiEVsdWsCE1yBta4S9NPn6t6quH3Zo+Hwhh3w/KS6MvylLyB51kCSl80sSLUoGJkwdGM5DFOIeiqAJwFhhP129Ayc2giEkisRjYYOOUvvSgDQRp31aXthaTrxu8kCOVll3GVgvrmNMLFQs6ukN3riSKfIgQ49XvXT6sEhEvKM7NsvsR3Fro9DfMZaGei+nldhvWL4iJ46xm2NP1KGrKebuEDdvel/dT9qpeRS2UWforaZNMDmRYceD/RGu5BVIOZ8be2wvSZBKiq6NhQbnsifRFnyPqiHRyFrhRy17NtDD3K7MMVRrePGt2ThUea0ZU5SOMx4aYQAVYKJXj69OkwxlT3fcBrRC//DIsWMPrwj3YhV1wUFJElgeX4eVSuAuPWhyuveuoFd/BacJQ6e7uMelBQBizzDlAPA56jHi1LQLWsUYQNO3Sw4S7XzasvaRgfYDanCl4DyXRzkzNbF+d2X77zgtGs6SpYuR54psUeZAg0RP0mmAWCwNPao+cGxC26ciYr7x/3U1hMwrVnNJqwq5CpoSCjKaNvUyKihWLBCFf4hJJRgrr0DCxbOD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 83MxXk7pRtkBTWR47gZVvz3ZXrSVVPPdlRF3QX/N+ubSZxxbBrHbcve95ujQL8WGwgD1FCwWKgxLStaSPgjjd+r6OEyxCPJVVOGBCBdEBzyxYI8kDIpkJIDukN3+Kg6rE+Ut6KYnzCt9+drT2jLCzL21zDhszlNctC7qAie5gJGlxQt+f18dPjYXKu2VqJffAQZVqmli4xuaAJcnOR757IzRW62nvPKP678/I+Q4lOE7SNXiasSkmD2nWYRuHASebF1G/qZFIcYto2+VyjHTJvg4Z7RzrIpQNzYkc/uhxAh+16k/TdF0Fq5ErKM2WSD75YCZKXn5fOkhLMvev4eCHGgqhWPuGWT2mnu/2wWc2q6pudrRy5HlO6jJHcSxw+TCIUKLVnzaS/b7SqIDnkZRMjt7yOn5DJMHMpMpkU9zp7Q5vlklXp8EHzYYlFmKnESo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:13:59.7565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e838ac-fa84-47d4-3a46-08dec1d68ef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
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

Fixes for 7.1.

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.1-2026-06-03

for you to fetch changes up to 03b70e0d8aa26bab89a0f1394c1c80a871925e42:

  drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set_soft_freq_limited_range (2026-06-03 14:57:46 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.1-2026-06-03:

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

amdkfd:
- UAF race fix
- Fix a potential NULL pointer dereference
- GC 11 buffer overflow fix for SDMA

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/sdma7.1: fix support for disable_kq

Alysa Liu (1):
      drm/amdkfd: fix UAF race in destroy_queue_cpsch

Andrew Martin (1):
      drm/amdkfd: Fix buffer overflow in SDMA queue checkpoint/restore on GFX11

Christian König (1):
      drm/amdgpu: fix waiting for all submissions for userptrs

Donet Tom (1):
      drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K page size systems

Harish Kasiviswanathan (2):
      drm/amdgpu: Use asic specific pte_addr_mask
      drm/amdgpu: drm/amdgpu: Set correct DMA mask for gfx12.1

Harry Wentland (7):
      drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()
      drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Bound VBIOS record-chain walk loops

Leorize (1):
      drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs

Muhammad Bilal (1):
      drm/amdkfd: fix NULL dereference in get_queue_ids()

Prike Liang (2):
      drm/amdgpu: unmap userq for evicting user queue
      drm/amdgpu: improve the userq seq BO free bit lookup

Priya Hosur (1):
      drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set_soft_freq_limited_range

Sunil Khatri (2):
      drm/amdgpu/userq: remove the vital queue unmap logging
      drm/amdgpu/userq: move wptr_obj cleanup in mqd_destroy

Timur Kristóf (2):
      drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on all SI
      drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as needed

Vitaly Prosyak (1):
      drm/amdgpu: set noretry=1 as default for GFX 10.1.x (Navi10/12/14)

Yang Wang (4):
      drm/amd/pm: apply SMU 13.0.10 workaround during MP1 unload
      drm/amd/pm: fix smu13 power limit default/cap calculation
      drm/amd/pm: mark metrics.energy_accumulator is invalid for smu 14.0.2
      drm/amd/pm: zero unused SMU argument registers

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           | 12 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          | 11 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 18 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c        | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c          | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          | 14 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c         | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             | 16 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  5 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |  1 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 10 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 49 ++++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  5 ++
 drivers/gpu/drm/amd/display/dc/basics/vector.c     |  4 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 15 ++--
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 81 ++++++++++++++--------
 .../drm/amd/display/dc/bios/bios_parser_helper.h   |  5 ++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c | 10 ++-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   | 10 ++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 42 ++++++-----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 32 +++++----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  8 ++-
 43 files changed, 289 insertions(+), 172 deletions(-)
