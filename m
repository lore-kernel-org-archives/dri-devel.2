Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B40C55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7AA10F2DD;
	Fri, 31 Jul 2026 15:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qpkAk9x/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64F410F2E4;
 Fri, 31 Jul 2026 15:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsJk/BIqss8QXJz96Uj/nnBKEC2smRYm/ksF2Xst7OVuoBu9rDzHOs1ndJOv5eR07E3GTCys5MztwTfyTAE/YT+Tm2t+ugqCJiOVptDNFW/iYyD+5t9OZ/VU9GEiWOhevpJ1GKJCNvPPvs3X+BmwTFVLekNHIFtaIzPXyMESNSsybGEqr8WU6Owo0KDM80aBbmoMt6OE613ZFaG0krkDjJLrJHVpEUSf4y5EWhKPuLysPPqbR/sgAScDVBOfI0u1UZ87YryebXcEt7gvpiVzeBAdzGskz4OG3FejFZ4t/BppohCPFl70Bbu7SwieBwSFkov13b19X1zBAURchhnT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn0SSeHjjjiZ0GmDYqLc7cooK9W2DPzbHlOiRCNrpKQ=;
 b=pUN55HcaxnfJuApHcyc1wftD7W2aQoL+t3W/Z78tSlCoZVY9JosVJ2GQLepYRVy63/zuRcgPZ2AI2vn3FkELT5RhAnfWTNt9VkVVLhl5xeUNXCLWoFmeVUAvRXUj0kPNbulUxw9wnd03Kr2ZDGsn3Wcbi/YU39QVLKemK7XFBR6x+/HpMJ/q5gZGn7IsnURfND83O18U5PsACtOPxmH/lo8DKZCvkYb14zVhnO2esJGedugo92qbNSKzC3DOpW5mOOXkzjsgT0QBMGTBxUBUAVU4gniDcrS+Mi9nb9jp2su104Ri6uh2t62jQKpxSL6ll4TicgDpwt8eHKPlMHQE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn0SSeHjjjiZ0GmDYqLc7cooK9W2DPzbHlOiRCNrpKQ=;
 b=qpkAk9x/FM5FjnEuv8qdI5YFJ4QsZtBBLTZHQvmPrZ9gxFKiugwoTg3/T4rmGfoqKNx6OqjkZoaDO6POjK6OGnMsEQ+/MTJzQbPtNefeuI1eTK7d+AyA/RK2TfDJVqhGcMw3UaOqmNfs5qpMydCoqSDJiCtpmi+5DlGrPBFINhE=
Received: from CY5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ed::13)
 by SAWPR12MB999316.namprd12.prod.outlook.com (2603:10b6:806:55f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 15:33:02 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:ed:cafe::44) by CY5P220CA0005.outlook.office365.com
 (2603:10b6:930:ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 15:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 15:33:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 10:33:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 10:33:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.3
Date: Fri, 31 Jul 2026 11:32:53 -0400
Message-ID: <20260731153253.1393962-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SAWPR12MB999316:EE_
X-MS-Office365-Filtering-Correlation-Id: 832aece5-1914-4cc3-e699-08deef1901da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|13003099007|56012099006|11063799006|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: dqbPANmZdUrnGvYrDM9PrfvWe6kpDMNLsqU8+UHa/qbxXNchtKvnm/tEcbISwmOX6WwZCQxtcd/GdsQNERL1OjraZrAfitJpb4S8QpFylLYD4C21pJ7nLxuKMrBmn32mFUv+7aqAw/fKWVk3BBC7RlY0D7SQTWsSc+ULCkgB36MeJsz2BwSLlQ4b0nnIuYXGtPKaHDJXMXI31vTMcjyEsaslsLSxDYbFcBfTTHdu8CIcIBeMvpm0K+iaSWrc0g7SWD2i7Wd1frEIqWCleiz8UnyOkPaTauki7Vy5NDa+lakmNb6zre9jA35/udGbdoQpm4KcAeihYK9nmS24sXlTaoYnAyg6YmzpqbXQHcIeV0pzYKVLpEvIv37EAK6RVNBAPXBDHC/PHf/7fLDN8Qea5TwMzFA7YdEhANV3lJ1plF9JrcNjbcaeZG3ek9YNVgos7Q6UG2j5at5pf3orFXpSniJurtf0DPLwgVROFMGdsByUDDtN2T8F0Toy4scOfilgWKVGXu1IkvEivqryArEHWc2w15uRtgJm/XvzXNDR+3HF9p8NNmNH6ZH2Gy7V0vAEliyL1qVQhAnTzXwy7sx2OqwKln9rwiT9DoMNadIn7zyeuaVsfSbxOo8EfImvzlQ3T4Et4TSie6gZkEwrEQ/zHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pyn+W3gEHR4q3v8ClVkPhwwxmJXw1C031AbKpCnppIChvrweZXGiS4e8oYT43G6lQHX+0OJP2gywl7pY3mjYXyAyDYgtMSt+Ip6dA3MCdz+XX26c6bFiGKiqdRGy84r2C1R6uNFHConvUToAR77hC8WXUbQoo10wbLO7BHTqiVZj6OiGaEr7F5dWlshTF9iLPFBTP/+IsmF7n5DIDSxHjxTQuAbyQUOXd0ztR/4AtG0vigcUotJUSJi6B+alDQverpI8XRP3rvyt9+2Rp+C9KueR2B7hjq8zuxTIYmg461WWzSPvMf3HxQ+TiEH/yGDgCP6yjpr4YBdBnGyz0rQcdr+xXny5UTFvofc4XDkkHpm77UeWnSfHJm2S0BxpKLAgKW8gMwhApUc3ECYHi82Dudk4dpawo0WzwfqE43J+iAqwDBqoukjIDjOBjv8fEkFs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:33:01.6651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832aece5-1914-4cc3-e699-08deef1901da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999316
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

While I was doing the follow up fixes for 7.2, I thought I'd do a last
few updates for 7.3.

The following changes since commit 6f16fcbb0c46a87e3d9685407e906573d60104b0:

  drm/amd/display: use proper context for logging (2026-07-28 19:17:34 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-07-31

for you to fetch changes up to 9243cf4777fc780157602603caa52c285908f26a:

  drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12 (2026-07-29 17:56:28 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-07-31:

amdgpu:
- PM sysfs fix for APUs
- DC pageflip timeout fixes
- New GFX7 soft reset implementation
- Misc code cleanup

amdkfd:
- Remove svm_bo eviction fence

----------------------------------------------------------------
Leo Li (1):
      drm/amd/display: Exit idle optimizations before programming

Philip Yang (1):
      drm/amdkfd: Remove svm_bo eviction fence

Timur Kristóf (9):
      drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable on GFX7
      drm/amdgpu/gfx7: Refactor MQD initialization and finalization
      drm/amdgpu/gfx7: Return error code when compute ring tests fail
      drm/amdgpu/gfx7: Return error code when failing to start GFX ring
      drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
      drm/amdgpu/gfx7: Clean up gfx ring during reset
      drm/amdgpu/gfx7: Use COND_EXEC
      drm/amdgpu/gfx7: Fixup IP block soft reset
      drm/amdgpu/gfx7: Enable IP block soft reset as a GPU recovery method

Ulisses Paixao (1):
      drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12

Yang Wang (1):
      drm/amd/pm: hide pp_table sysfs on APUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c        |  21 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h        |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c           |  58 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  48 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  49 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 331 ++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c          |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c              | 109 +++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h              |  13 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  78 ++---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c               |  13 +-
 17 files changed, 374 insertions(+), 392 deletions(-)
