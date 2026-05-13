Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED820CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 22:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DF710F0A9;
	Wed, 13 May 2026 22:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cZ/8WLgx";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2614C10E20A;
 Wed, 13 May 2026 22:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/9+MzyTdRmvz4IKTlvUB+Ia1K9TC1WAsyFTqWVsafq1ld/EVmBkHI8vVLV5L8ru2qfHykgkEQbOBt/zb+QtV/dUWYZvN9myECTWJNi2jb4a0byMVhpSOlmN4IAPNYItP9aQ2lFjB2UFVFad1nf1Z/7P/8bmxF9wKgKW6mCRtWl/iJLFkkoy9K95UdcE1nUSy/oebtuQT6TWB/NnSZoqZtTKuqkb+osndoBWKsXdaQ+uuRF6U4TXB9DmiWKbMXxhsptOqiZytnXhpqSFcqx7bd/cB8ZhDbgNmFdF/i6WcuzjYSmrpLpTP6dlpzvCW4ynQqaxkUz8c69a7qySE8Rz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBHV25l1wd3ywqAM2YMVcnSPaxf0j3shYgsLSjCS2dQ=;
 b=zS9DJD4cforAzPvWFi50cFtWNk3IfU0mi5RRXh2sftMfwXGB+Xy0i+C8NFmyxP3nIOXzCFHWMYby7bAh0zChHJ1aYptjn8vVNHHcETTBi3vvxdkVimmvpxjKkJ/vQnAzV4UwfGV77obJc8NxWcCfDzDEOid3bbEeZlS03J3yIICgrOf0lUQSVWz8mrpOXYLBS+N5B9N3r9lNlFc4ePhqWG+atJlZ3TyH4+vCN2sqN/f1seJyvNGvqBPGcoVQ/T0ljRE98cEHaToV2hyg7YYAmQMNMO/xV2EszTe7RthLj5EDY9lfgtnsjH8GEHnjMwrjJSS66NcH73ZebOHS5994Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBHV25l1wd3ywqAM2YMVcnSPaxf0j3shYgsLSjCS2dQ=;
 b=cZ/8WLgxpHiyHlgwln10gSfv8IUc4ReV68gjbCAEiQ9Sx5+qn8Xdxs054+8DsGVHFifx9VRp5b03a1aSQz9B38hYEHUZRQkeM2GHZ8qNP271JAfKdmQtgGlScM4PPiOv1HH8qsMQ0UBkIq+ecuTYWbxB0vPztvatyQPiD6s5Lrg=
Received: from BLAPR05CA0035.namprd05.prod.outlook.com (2603:10b6:208:335::16)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 22:41:12 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::30) by BLAPR05CA0035.outlook.office365.com
 (2603:10b6:208:335::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 22:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 22:41:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 17:41:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 17:41:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu drm-fixes-7.1
Date: Wed, 13 May 2026 18:40:52 -0400
Message-ID: <20260513224053.40670-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: b40abea8-7280-4db4-df5c-08deb140ba86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799003|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: bM2BVWP3SwHfiqegjbtQuukVXsDkqOHuBsYDrFnObFKrY17j9+TnDmA+5Od2TCkoxkSAOEBJGwgDFbPP8o5LX0rtP0zk/2hf9qaKonsXqK3M9sWpIRT0mopVEERW99wFHRzhB0ZQl6SEoTBoXMKWlUzjjQmSzbGikObh9i30ka3zlyffOTnV0R6h+UvOqwaFKKYhvRbIvhaBduS+Hx9zgb+vZONfK3PRvNVii7RArZQpg6AP/GQuOwJmMcfpAitf1tj6Ymdah+czVV+0tnb3D34TdzP+Wc7EQo7j3xyZ6czDxmqnC8yW5vo6FzXTlMRvX+2e6ApIG6MTT/dZkPcLKT6uq11KuqoaGIvaoOyNg/oWEnsKHOoS54cQ0+6PayQ37LlwskJBNFfKB/uGlvkQCmAWOfL5JUoahRFMr/CILW14F+tuo/vdJmqgdYgGoLuQsZJ9S1PyHpaOFExvqHu9IWw4gq+vb6KknatqtZHTfTLojIxjysl7PsDPiuJSGkP4FBSPbzDcCqYcMr6Qs+m0AbHl8fHFfd0Aa2BvniLU836kFiAyKdGplkyFjSG5w9I8rl+mcN7dzsZsJGctSNcd+cJyd0zGdsCuqy+2zVPNbah58jbWUQaXbkEXhe6S8ueB3+k9nA/V5wuEDXNNQtW+D18g4SjBYgpVN2R/2LFuVHbE6MaS56hhO3OpCQIoXrMn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799003)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uu+ifzYl8uuUiriOVJ0TerpPpwjXipqM6OEeGp0ys6aycJLg3O5V4mkDpT06DMXdwjjQwYcLzT9gLlc9WagJWaKWUJAKDrVxezQUXYJYup+KclXzxvGKz4zZfuKBdE+OpuPoGVzqyE4UBAePEyUlMh3bEvsOFcJouWh46beahWHzmH3+CLSTHD7USb0KveM8G8ntt6Ypkx2VjUrXeXuS9di3gvzDxCgUtu3RZvxGN8coIxsNXDq3HXU2st9be607TiCgMU9wpMMniWfEGd/5NiE9Ml/QvsVbybV+gzTeCMgQ4w+OHRyCR4lKsPA9dEOlPvTY2RuORwaW/BJuJCbTFFL5+ACKfA9N+G6st7MmuLLQvLDBrGypIP0Ff2p8kDyyWXTmnG3uIqnkUtJCGraerDBOuWe4rZnG28hlcPUxcquwEv05tJyGSgtfLA/65YDR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 22:41:09.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40abea8-7280-4db4-df5c-08deb140ba86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

The following changes since commit 5e28b7b94408897e41c63477aabc9e1db439bc8c:

  drm: Set old handle to NULL before prime swap in change_handle (2026-05-08 17:53:59 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.1-2026-05-13

for you to fetch changes up to 5d08559c910cc37673b965a0d4e8d004444d0332:

  drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP header on GFX12 (2026-05-11 17:54:44 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.1-2026-05-13:

amdgpu:
- Userq fixes
- DCN 3.2 fix
- RAS fix
- GC 12 fix

----------------------------------------------------------------
Christian König (4):
      drm/amdgpu: remove deadlocks from amdgpu_userq_pre_reset
      drm/amdgpu: rework amdgpu_userq_signal_ioctl v3
      drm/amdgpu: remove almost all calls to amdgpu_userq_detect_and_reset_queues
      drm/amdgpu: fix userq hang detection and reset

Jesse Zhang (1):
      drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP header on GFX12

Mikhail Gavrilov (1):
      drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED

Xiang Liu (1):
      drm/amd/ras: Fix CPER ring debugfs read overflow

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  29 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 131 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 243 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   7 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |   8 +-
 7 files changed, 220 insertions(+), 213 deletions(-)
