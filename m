Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2A1106ACCD
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A408D10E045;
	Thu, 12 Mar 2026 18:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPdn4grQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A6D10E045;
 Thu, 12 Mar 2026 18:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCmGN23PtEQBJhHNsQ6GrK2Y1tYcdaTPE4EPsC55jccvceDwxNB6pDbf3ApjyMCK0whczXJZrXgXW8onumSnvRSF1aSsGEX/Ot48xlHT+XJaHxsWv1RmHvufSO6gjJbjFGZefNNiJOYHf7xCUXWQcRYn8nApdEapSsCSJiPDLUZ8ZC7xEPgf7LkEOuxwAslCUmqRGboh4gBM9M8zu5TamVTsr5JxsQ13HiuhVVRqjeUXWyKSTRZhwzCHbyFD+jdbmcv1D6SJZAQITUlKz7hCQ87af5mhn4goz4Va+RbnpvMFqgnXEedR046ulHMhPqOH7KhO7lqkxlGWu8THi6l+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR5hTFswWWqRPJ5k5dvfGMLkxd5IEGk9PiqNvgDk5t8=;
 b=JG9y/jb/mWKx+O0hfz9Ggq7UFzGaonbiOCE4FLCFX+EvvxKoimiS2NfiZLcuu+cYw7KcO2oR3Ht6tqx2Ejhx6jpb2j7zD3WU7hgwYtq6mcbpLJD6/oOBs1YBmk8Xbhp0wKRSmIK0HFX+gTuiJD/ojU60VT752Lu3zNM2+PLbOmTYIqhUoNmwJhgIVWhAtxA4i3cc80WxQ5Wire4FF2Kq0FX7lcicKMPe7Y6r6q88OFXcAtGxk4eWeMOcPzP7gJ/UogXClGh4s9VQ9pKmpAOnoKmYaKeBsV5UeDXL/fXh8EElpwUDKYZlM6H4lBIYtA/ApWALKK9UWNImin64CT8RBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR5hTFswWWqRPJ5k5dvfGMLkxd5IEGk9PiqNvgDk5t8=;
 b=TPdn4grQ41yYSjUjZ0Y+72C/D1G1tCN5UAsqyEUiRj6iLN8I09uVxadOawyKmK4mx9pryhgc148WI54w1ARIoJN2tfUu+WwFCH4Us7X/nVmbuDvXKUzfU8q3VR/l9f+xb4tcrKVJBHpFNvZ3kM/+gaJU88+DsLxz35kWjObHRZU=
Received: from BN9PR03CA0974.namprd03.prod.outlook.com (2603:10b6:408:109::19)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 18:04:04 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::f9) by BN9PR03CA0974.outlook.office365.com
 (2603:10b6:408:109::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 18:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 18:04:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 13:04:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 11:04:00 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 13:04:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.0
Date: Thu, 12 Mar 2026 14:03:51 -0400
Message-ID: <20260312180351.3874990-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 880ea23b-ce0a-4bf1-5de3-08de8061be89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ziBWu2agsvrkjF2gqJbLqAoAXgEhh98VYu4jQYOkwZ3kpkq+A+wMtaMKRT0lvt0eiXVAlvk7f1LwkkrhEVwZvsT8fwY3OThsqMWy5+kaLu5sqVydGNPIzoddO0Q3fGrn37MWZ/TYmsBBN6iFtvR9LLSDGNvMiDBsFp+YQT8EOCanEoHZazMCVucE7vbphLIQrO7mIuPNiWubh/vsp+HbD3hY5MA0cbjaa7W4+TwY93oDHTddVgc2KGMqIMFUQcEMbaqGBckWzq5DmyQ8bBF0kuk01kMQVf2wj2h29pHdgYiyfLJmzQBkJtm99praR4DsAUok045qpwkc24wL/m1VlFMNAVMz1Z/PpqdbFn6Eds74lK6WQFScArYBxCpiL4UtJQYgeBMNBg2F/eENrGT9adfMis0aO2ihXWVWncjZZTHPQJDgcQkzk842Qt13++sFeX2/qnMK9UtZHzpF3aR8CS+Q6gJfyT4PZ6b1ud6yypG2ROQhbg42UZJxUi6gKKK6+O/4b4jQQUdW86xnWtMR3j16Sa3mx4roKPe3vJl2uhOtj7Kdhk47HBmT8Gd4I9LIeRuj5T1fTENnC0guVH7Wce1iIWWd5o2aU5gUKWDxihAP4g7YQNfaJdKflfGhH3X37fsYOsQ/YUzjjBzUR5oSID3ddPpOOGLC9MF2d+r4xp77PY7cW42Xjp89DzW5h9BerPLwpiS7CyWtO8kBUwpSnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oc2VQS9N4D1UMukb9rEn1BSOqwvuH3GfVGyMm4JW2YqHyVFPouwZX0zG8K21emXP1UytOAizpIukPcCpynyTLl7IBVcGM1w7OAHAZYOaRhWCZhP73o7m7vz8FlTZ1ysPxEAHG2e40UGMZsQFl+p9jdRplIrV16n8BrYNTC232PfFiD5j1B+Yt5DZfnasLsatbMQL3dI5D0NdOCL+18Rs6LgOV+bEFy7lONmR8PX2SepHc67HEqI9GKsVWneDjchrlNiKt3k7PQ8eGrb58S5CZRawz/YKg1G5Gj/Y9q8BIzKaSm+rJ30gIzQlCApgYD+kAyExsfXPuHnJ14v3hHCtJRzHSNQ+TD7mgCGDbdcRy0oaSAh6IP8iFAPsaXN12swvMHwQQzUHEyfsqMkaCNoXmQA+aTb6SnTbp7YZk35g1qLTTqNLQz0c8Zm6r6gBQNWg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 18:04:02.9620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ea23b-ce0a-4bf1-5de3-08de8061be89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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

Fixes for 7.0.

The following changes since commit 96bfe9ff7e88f0541002640acbcb3ec63c9d0130:

  Merge tag 'drm-xe-fixes-2026-03-05' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes (2026-03-06 19:45:19 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.0-2026-03-12

for you to fetch changes up to 3646ff28780b4c52c5b5081443199e7a430110e5:

  drm/amd: Set num IP blocks to 0 if discovery fails (2026-03-11 14:04:08 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.0-2026-03-12:

amdgpu:
- SMU13 fix
- SMU14 fix
- Fixes for bringup hw testing
- Kerneldoc fix
- GC12 idle power fix for compute workloads
- DCCG fixes

amdkfd:
- Fix missing BO unreserve in an error path

----------------------------------------------------------------
Cristian Ciocaltea (1):
      drm/amdgpu: Fix kernel-doc comments for some LUT properties

Ivan Lipski (2):
      drm/amd/display: Add missing DCCG register entries for DCN20-DCN316
      drm/amd/display: Check for S0i3 to be done before DCCG init on DCN21

Mario Limonciello (3):
      drm/amd: Fix NULL pointer dereference in device cleanup
      drm/amd: Fix a few more NULL pointer dereference in device cleanup
      drm/amd: Set num IP blocks to 0 if discovery fails

Philip Yang (1):
      drm/amdkfd: Unreserve bo if queue update failed

Yang Wang (3):
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v13
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v14
      drm/amdgpu: fix gpu idle power consumption issue for gfx v12

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c          | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h            | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c              |  5 ++++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  |  1 +
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h  |  6 +++++-
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c  | 21 ++++++++++++++++++++-
 .../drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h    |  8 +++++++-
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h  |  5 ++++-
 .../drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h    |  5 ++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    |  3 ++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    |  3 ++-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    |  3 ++-
 13 files changed, 73 insertions(+), 19 deletions(-)
