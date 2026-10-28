Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA7606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GBukKlMq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9803B10E700;
	Wed, 28 Oct 2026 21:44:52 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29A210E700;
 Wed, 28 Oct 2026 21:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAv2aVOe6pF3aj7oSdbeQ+ezHBvvBEZqcJroLRcl1xFZJNM1jNWcggIzn5r6XCRgYE8SfOYMnpgpMvN7z6QduijhRPE2v35qT0gP4xqY/J7F5z4eBx1UMFs3LmE2lsagevHj8Uue9GKOQbq+e83YoGn54FnQ1CO0+LH4e4gAaxJN1G0gKwsHpUOyMfOGn377OOp1Vjbjm/1Px3BFupBYg8pHD4CniZE5PUgn9BoU1wO5pWTPjkKj4Y/bCvdTrkxrv7bQVTajOSrSVEFjNYu43j84OAgBxojDXukn8/Ank6mKw3grk89dHMX7lWRUEukHVOLk6owOMsMsX4FlsXGqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1w27nX9Govz+9iuOs1vbDhzIJ5R+GtIezk0qgXNSVA=;
 b=NAV5pCnw8Wb6T2lHwTSi3CPxyx0MSxEc40OH9vOwsWUj4vNZ8PVEFSFiNOrV9zMO77B9i2rQoc4OaKLZ8VX/YyQ7HbcMwKOrgp8lKwKFVkDYHxINPLoPUNYvPZhrczL8qDgKk4+HVVoWA96BCmgf3bcXovo++7lzmAW90fss3M3Jacs63wQhD4LYwWGhmIsIAPTWqm83GxJ5fTlhU702fGBfVg/DClAshaOPGH5N3Q21pfH4liSfQNTRGomqh8jAoyfBW+Ey3Lp+JS027xj+ghXMWXXi++daOiiIHKbKm7wF5tRpmTu/x0EDN4wVAM4bMohu3WVPLCT8QDhxFjPnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1w27nX9Govz+9iuOs1vbDhzIJ5R+GtIezk0qgXNSVA=;
 b=GBukKlMqj6TsXONaKHFmgWaUaZRdJOqOyQe+OvyyM6Osn3/V9njBWYvcf9eGIVjPClwj5GEPCKIzQirw4DDkxwR/eYHVmWnyU1saGKlT5GpAZZ9ZnckUOSobAiLcoLvfjBIQuqjNUXEK0WOGtAqU0fvLG5dWZTmPbHLjvYUsvtw=
Received: from MW4PR03CA0259.namprd03.prod.outlook.com (2603:10b6:303:b4::24)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 21:44:34 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::5f) by MW4PR03CA0259.outlook.office365.com
 (2603:10b6:303:b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 21:44:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 21:44:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 16:44:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 16:44:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-fixes-7.4
Date: Wed, 28 Oct 2026 17:44:23 -0400
Message-ID: <20261028214423.1295475-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b337311-92d4-49e1-05ee-08df353ca806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261028144727099003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|10067099003|261022105027099003|261021121427099003|261021123027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: r5K1lQc+6qdQWbWXesUwBHkHJgc+VGqsRfpD+P5V599xrtSI7dsW+UM9lOVqD1UP5BgQU1xAakqIee1nElo76iP+UM0tCZvJJyZGL0/pFOiv+dhxqYpAI3tSyFLKh3s/QYQTazD3pNyz5N62m+KGB2yv9S8+VPxRDAADinfY3BCS4889NF97tzW8FErikooTEMYSHKrFtZT5GGyrvFX/MHba7UZTPoAxjRR8cA9eBru+sadq4iJ9Nw9m7EkJs3LDqXdIDd0Gj6SrLbkaioytnakh8JNJagmz8gWUGP6mI9V3UlMhZD6PvJDbUHwYedlUpldc2I4YZfIGml2gTQSLf7zwztIhhW2ObaANqCIXUmTgHaNJEqQyaWvWGT74eO2jGohZ7DWY+jmMLPrHs41QXwaJCEsvN9K+pymKWDnmttwv78X/uKc0V1IpiRQLZ+scedwzep7BkvMUad4k1Mc/cyYdM4VxFSaiQx5CovVRgvEwN/W2+M702WIGWPOVEXj2gSWXI16MaxqS0H8pCxXaLSPLzmiS+26zXowFC8sa74BR0XmhHLbgjnwtZe2lerBj9lEIWENxlxShbU9y0NASi9ruoPFCZyArt7VNAsNp5TSMEKbByApuzH1IC7h5EqL4zt4EUMHVtyZWIiB78pC0Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(10067099003)(261022105027099003)(261021121427099003)(261021123027099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 15yW3odueRVY1ZHwLfamRI4kyuqi7v23He/KIeG5b1LTzzSjEp5bEpBro0JF7MqHeo1VS0Rr3xYpITKhsGM3PrPG0tQ3o0GEmc/lQhy96TVmxzJUK0dXQNRq8qxtv7/xZMf62JS2/vH8diniPI4FLYaMu+sM48RqJNum4vgoRB6dhJv4E62hsQ2OFvy/Kvo1qkWqvtW6/1gW4Mq6BLqOyc65W+zHGS7xFLtjkuU2k5aIwOgZmbFfDAr1Q/CvnydAeXocAHL+nPWKZ4XaqY9vWpcUrljOYIdYdxnBSAOIrg+pJXqiwuZ7V/RZHM4KeCnQTf4NmGWMiPpn3vF6WLNDd2wvz16xGMH7gYExOHuS0a9B1Cyiwg+6rHJIVTsx+lWcrSXSZ4sm+aAcN5N1qzWXelkUfGXZTCtJtsPyKkn/+Ts9p63eutu6S1OQdZ8sVEye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 21:44:34.2184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b337311-92d4-49e1-05ee-08df353ca806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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

The following changes since commit 9131cc85d0dedd8ba4cae60dbe5985d081551f30:

  drm/amdkfd: correct vram_available calculation (2026-10-20 12:10:23 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-fixes-7.4-2026-10-28

for you to fetch changes up to fbb201890156e04b062c4488d1b500de52367684:

  drm/amd/display: refresh cached HDMI FreeSync state (2026-10-27 17:06:02 -0400)

----------------------------------------------------------------
amd-drm-next-fixes-7.4-2026-10-28:

amdgpu:
- VCE/UVD sched teardown fix
- Display runpm reference fix
- Display TD-LUT fix
- SMU 13.x fixes
- SMU 14.x fixes
- Gang submit fix
- Passive DVI sink fix
- USB4 tunnel fix
- Freesync fix

amdkfd:
- Bounds checking fixes
- Hotplug fixes
- SVM fixes
- CRIU fixes
- GFX12 fix

----------------------------------------------------------------
Avi Weiss (1):
      drm/amd/display: Initialize missing TD-LUT programming inputs

Fangzhi Zuo (3):
      drm/amd/display: Poll passive DVI sinks for EDID readiness
      drm/amd/display: Cap DSC bpp for USB4 DP tunnels
      drm/amd/display: refresh cached HDMI FreeSync state

Harkirat Gill (1):
      drm/amdgpu: re-enable GFXOFF for compute on GFX12

Jesse Zhang (5):
      drm/amdgpu: reject CS chunks too large for kvmalloc()
      drm/amdkfd: split vram_pages of SVM ranges prefetched without a GPU mapping
      drm/amdkfd: send SMI process and VM fault events only to allowed clients
      drm/amdgpu: drop the gang leader reference when freeing gang jobs
      drm/amdkfd: evict the queues only once for CRIU PROCESS_INFO

Jiale Yao (1):
      drm/amdkfd: validate SRAT subtables before parsing

Kenneth Feng (1):
      drm/amd/pm: add zero fan stop temperature support on smu 14.0.2

Kevin Wang (2):
      drm/amd/pm: preserve committed OD features for SMU 13.0.0/13.0.7
      drm/amd/pm: preserve committed OD features for SMU 14.0.2

Luigi Lauro (1):
      drm/amd/display: take a runtime PM reference only when a CRTC turns on

Olivier Kaloudoff (3):
      drm/amdkfd: tear down KFD processes before early fini_sw on disconnect
      drm/amdkfd: stop restore retries on device unplug
      drm/amdgpu: guard VCE/UVD sched entity teardown on failed probe

William Palacek (1):
      drm/amdkfd: Validate the control stack of a restored queue

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  35 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |   9 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   2 +
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  30 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |  60 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  21 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  15 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  22 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  17 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |   2 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 193 ++++++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 193 ++++++++++----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 283 ++++++++++++++++-----
 28 files changed, 734 insertions(+), 255 deletions(-)
