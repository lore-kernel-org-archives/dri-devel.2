Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81A606A330
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kvxWfuZ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E50112208;
	Thu, 12 Nov 2026 16:36:01 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99DA112202;
 Thu, 12 Nov 2026 16:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvlJDIc6ktcN83mtydjAJFUvDsnyWIizeir8gFe/Zn+8cWXS9WRvDVqXNupVPWOwnIyOermDILIYbEKB9KMnTdx3dIVlSp/Y2G2w/OqZL3FxG+Thl4LJ6qh/WnTBh4+5PqDEXbBZq7tOztpbzSVRKwP60Eye7vLgnka3eKFY1sE44Y+TaMpJVVJ7fiiIrrQ9PSQ+z/CtGFTjV61ETQhdxx8+5Ah/FA39mvAIZnlTQXWlUUjyTFSB9GQ3qHdYHe5Up7+7xzrkOHZIjV1/5jGBwHlb15W2rStHd1DegXxxVeGXDxe6nvPyElCo2pIpXeZ1Az8rK0NRK0BZzcRql5Htag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy2PXKc7wsKYwSfhbulpZ/s9r6VqPchQyWGYNxMvSgw=;
 b=iV9Uk+/iKPnqN7El8KcvFF+yZuSD/IOkJNbYofCQBIQnCgvvg88gJ/p/yNfJ3svsmBjQD/PzWXQcOqeS2Y85DvAIzlJDP2asaToVspPka8RAq7I3YDTSCWbc7i/5TxB1Z8U4cvf3U7IlpnRqYbQpdDsr3j8SODAucnwM6WJ9vRU7DVxdyZJLBm2Qdy5tBQ1egOLWLKbqhlcgfMOdHpr53nQ2YF8pysdH8Ac2x3VB4oTB0zeB8GsIqZDuMknowEurCFSaN8TShtzZSYONSTXeyuaQDfv0tzEeiZm6u0LF6MuepNWophZStLlj6ZDRSe1TggHPzMZNnwOGLouR9jqpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy2PXKc7wsKYwSfhbulpZ/s9r6VqPchQyWGYNxMvSgw=;
 b=kvxWfuZ8OnynxHu7tfyu4NonwN8gBjouOwM5gjxU5oM2whSXqcUFSOGfn329G6PdW7sGvTYkNOEhIsLCfum+GD3LjJX2geGSYqlz9+BZmjmeagupjAWnhe7lcOKHOKgRXYWGEW4IthxEnKFdB8KLxaZBRDJupZ9jz90DfR0LQCY=
Received: from CY8PR10CA0004.namprd10.prod.outlook.com (2603:10b6:930:4f::25)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 16:35:50 +0000
Received: from DS4PEPF000001C4.namprd21.prod.outlook.com
 (2603:10b6:930:4f:cafe::6f) by CY8PR10CA0004.outlook.office365.com
 (2603:10b6:930:4f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 16:35:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C4.mail.protection.outlook.com (10.167.23.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 12 Nov 2026 16:35:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:35:47 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:35:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 10:35:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.4
Date: Thu, 12 Nov 2026 11:35:39 -0500
Message-ID: <20261112163539.1265175-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C4:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e103bb-53ab-45a4-691e-08df40db01f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|261009223027099003|10067099003|261021123027099003|261022105027099003|261021121427099003|261026140227099003|261028144727099003|261022075727099003|261026121527099003|261102123227099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 2yBG9EPXtTAUsZzT80RXiKAonql/9cmrYkybo444TRlTlvFs8dOhqamjqUoXq8Qt++yVUIq3IXNZscYV2ZRCMe2tGRF1PChPcKpfyCEqHgR4Mob6CKlrgwENbt68hFLKt0Iw3UfAfJfQa7vE6F4V9D5JSPg5kgWBnDuvDkxP/aUw0y4PFxIyc4KaYFY9xU08ud2Xda3/JJhtkhIYEra1JC31Oc/WX2PUNlWD0CbUX+8x2oXzBL3ObOft4J22I4uCIZJr5xx20tBezzWI7+a7nkp9jtaWHdxrlCDHWGpQCXUJhk19HXu39aodAMzrrgXGTJd8WUADZuknMFWfVHsj5FVYj3yC4NpE9sf6SxIHlsHCAxNEbKoNaBQJONQsBBcxe1Jdu2QwbOauWbJn13PYRCZdFbR9BQyE27+pxEoPOkSQW6lgeDhyth9oIDL853D9IyLLprVvNkhhLNbcZxvHl+k378L9kZ0Dbkai051aZDwfE5bBvs16VFuWv8UkcW8hTfH3AVKR3KIS38FDcVBVdTM4bpOayCp3T6vCul1tLNmuJBwoXnixK16g6vT2j8BrzT1JCNpmbcZwqVPi0ya/vvag91dPyo4NWh/hxhNvfWpn3NE9zxvyucBwyDdmyM1ZUw36WlEKiLiHswpg9In7hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(261021123027099003)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261022075727099003)(261026121527099003)(261102123227099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +EEH/34o5asl9jVoR+84Pdh+SfCyxDA0y8bnil7Flxx06UXGDr545RoxfeBedgA6UccR2jYGDdjZDwnKnpxA8hg03ykIsUB8UYq+5wV7Oim3PwQOaEURGH8Pu8/EDJhEst161g1hzq9jP3rnuOVEYCpYhk5xezTbFo48KGxaxQo3chXiUIP7O1zFPFIVtRyQpXPYe0eBFZReh6T/eEM+jnOKKumLKWJr1/NNniGHLFjciqWJVXrHshlBdA+WoKbDkpLy15bGS5LvYKcAlpPXwWOn1DFPkmMWSaYNuJMSjPcfaTckMZyIulpGzzAYWih9IKIjDfk/GzVSS2NfbGUxA1l+y86uoAmV9DMoFAZR+JK7G7BS3RXlxeKv2IeEl11lXUnh39mBrZimn4S/iuyHBVCjgD/l5c+A4jJ648Z+sKPHHIoSKDTUa8r2NNnYY9Pu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:35:48.4089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e103bb-53ab-45a4-691e-08df40db01f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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

Fixes for 7.4.

The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.4-2026-11-12

for you to fetch changes up to 566ed98e48be75a76eea34745815a51ba36687a8:

  drm/amdgpu: fix TLB invalidation fence handling v4 (2026-11-11 15:56:58 -0500)

----------------------------------------------------------------
amd-drm-fixes-7.4-2026-11-12:

amdgpu:
- DCN 6 DML2 fix
- VCE fixes
- GC 11.0.2 fix
- SMU 15 fix
- Error handling fixes
- Partition fix
- IMU firmware clean up fix
- TLB fence handling fix

amdkfd:
- SVM fixes
- CRIU fixes

----------------------------------------------------------------
Andrei Krautsou (1):
      drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2

Apurv Mishra (1):
      drm/amdkfd: Don't reuse a VRAM page that is still referenced

Christian König (1):
      drm/amdgpu: fix TLB invalidation fence handling v4

David Francis (2):
      drm/amdkfd: Acquire buffers in CRIU queue restore (again)
      drm/amdkfd: Acquire cwsr buffer during CRIU resume

David Rosca (1):
      drm/amdgpu: Fix VCE buffer size check for DPB and input surface

Ivan Lipski (1):
      drm/amd/display: Fix __udivdi3 link error in DCN6 DML2

Jesse Zhang (3):
      drm/amdkfd: skip GPUs without a VM when checkpointing the BO mappings
      drm/amdgpu: fix the error handling of amdgpu_vm_init_entities()
      drm/amdgpu: release the IMU firmware with the other GFX microcode

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: use supported SMU clock messages on SMU 15.0.0

Lijo Lazar (1):
      drm/amdgpu: Allow cancelling a requested NPS mode

Perry Yuan (1):
      drm/amdkfd: check CRIU SVM priv data bounds before allocating

Timur Kristóf (1):
      drm/amdgpu/vce1: Fix checking whether VCE1 is idle

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            | 32 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            | 52 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            | 33 +++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 49 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             | 13 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c   | 22 ++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              | 13 ++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  3 ++
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              | 25 ++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 10 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           | 20 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  7 ++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 44 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             | 17 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  7 ++-
 .../inc/bounding_boxes/utm_qos_model_dchub_v2.h    | 32 ++++++-------
 .../inc/bounding_boxes/utm_qos_model_dchub_v3.h    |  2 +-
 .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h |  2 -
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |  2 +-
 23 files changed, 273 insertions(+), 119 deletions(-)
