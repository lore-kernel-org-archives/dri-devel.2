Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771F2C4453C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACF510EDF9;
	Wed, 22 Jul 2026 13:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IVW2UIx9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927D910EDF0;
 Wed, 22 Jul 2026 13:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez1KE7M5H+0aMQsdlpyZQLiva0V81oJIkdeCBnzJURt/kRX/Wgno7RLF9Bjk0RYA4Ab+KvBYsYXJNEdhcy46D2nLO1q8O2WLM8XKmLnLsvqImGUG8OOHCMcybi+O2r7jtS34gkb7kWTAM3YoHT90ZY+0eXcwxv1HMDazWtcBdhKEVyI1XHtPXQudNddNV3PRQJG9qSVZ8NG47UipNu1x8MXtRHWyoKUuqOvP0gBOUlt8PMR7REsX8Rk20THpvSnXgjJFDz40hJr2ueu0H7u1C2Z0TWGvLWaA27Msf2Ulfd2I4N9QN7O2gTL3LLj2/9EWyqltmAPM9+qvMsI8CGe72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekrl1nBfdbEx5vgx3TIuT44m+K4D2XXAg7A0G1mOoEI=;
 b=x+Nxyn94f9Vli1uzxVzRnbZ/jfKmGRmQF8F+6I71mMojD5p7R2AAgi0XvTzbTHI9NPISsJPY1sQZCBieU8q0LYWvERhIsRchgRKtex+YG4zvpK83mqrEtO9ZLgOcZYWcVGQV6PTDhN6mNfPfOA5fZMbQELtFfqlN8XnuP+BVIqfyfrEpquIC3mLjWAZiFZUekhhRO/UlPV7ZRZS/PWkhgQi1/gNtBZLJEzxI4H55xg5cEKI+2MaG/87m4w9UdK9jVIHRE/tLAQAW+FotoQko7kWO6c2hw+mT/FujZheWtLtVqxPsGTo3bYnOP21csSxrB8XpRXlVchgKq+8zFN1m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekrl1nBfdbEx5vgx3TIuT44m+K4D2XXAg7A0G1mOoEI=;
 b=IVW2UIx9F8kuD+18BG3ydcbah0oJKk0umrvU+N3VAMBw5CpT/TuQI1jNh8YED1iVAcjGRV9S3PmE5YNMrTtyih4vR0AhVM7gfPHm2LQcAOxlFDKCBhjPfZwT4JvT4wjepC9+LKjDpmkCbp0yfMMqdOGHFhM1O6Xi35NrKxwIL7E=
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:46 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::8b) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 13:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:22 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:21 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v4 10/11] drm/amd/display: Set color_space to plane_infos
Date: Wed, 22 Jul 2026 09:46:06 -0400
Message-ID: <20260722134607.136293-11-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b10887-5864-42a6-aa5d-08dee7f7ab89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZE8XGDlFTIl33ryXxy4+BGbVqFFebcqTZ2i/KZM6qpTl0QI9p9tvMOAwUY61bK+A9vzvj0UYKoDlZRbwLAKBIT+PMbkwtCSEIFI217YD7C/ITbIgx/W8MD3kc0qQQJTffiiBMUKlSq1Jbd3Zor+RS8kRHPS411k9uHSDUqaKfEuD22W97tdNWIigfkuvKogyFohy1FLFnGxTvFslLqANvvMagd42Dz8+qwRk8HG67aURFfrqtr7fuyK4Aim6qktlMxlCC5OwaSTfM/d04rulWSEkVtgg5ieJs6uFsDMDW5A+f4pKjRrT4lMgmx8UEdzLUA3NqZXTblBxUWtlU7kHFyEYmoEpdzpAh/PIKhOyPNEqrs2FOyXZIomxcClQoQBwfeSReQnpFlXs2yZfgOSIz7hvNqIS6xcT5+Lt4Gjr7jz6C0mAHHYxyriVj8GUZyiZyIGkgh3BNKZxn53ugVzoPw6ULYEkHifIzD4RTtrLNCCDDEtI4eWlf1OnHJ502T7rwNKDQ/p4l1a1vlzah9HYdQ8uAgLgji10FFIY8xEiD9SSj9WifHzHX4juu3xxe5eV7OnJUTJYSbZ0hqq24peA0qaWAJVOF1tQ0zDtQXkGcLLlYuHSoFch/RORaNM4Au+66EM2KaUn8kpLNU5rVJmgEPacywkyeLxp1bFuIc3WxtBcEjwINYA0jHqO1mjYwMnS4diYbYNNi9Z20zoNnHUMMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /gKg0KfeJhwgzhasINimv1kwWJn9ktT8nKWNbBsUJW9UJAiFpqiOwP3/TxL37eENnmKjEkIIe4juuMFA+yNkdAqdNL8TRbkVYSNMseAmoxaPmri6a2/+31NB6veXwJZ13Z4qKVvSxpT8ZgmaXIShDFW5J8Mme5rOuSUmHqhkuK8FtkhNnEWWO+iJJidiezV5Aar07w7GL1Mb6SjrTYA4avDTUyHaJhXMUZHtmnueNd4CebGek+w+s/mIF17bbvIoMYZ59AmSVKxHDAz7t0MZk2oBpFYl6VHvkYAUqsE0eDNi4iSH+PUaqb8U202pRj7soM8W00XsNZi6JZAZtKboJiYXbZan5OnXcjOrwYjqOE10AHSFzZk7eUApVX4+Q1UdWhk8F2qwUFrvmPWnz0Qgwxir/VGjy0RX4p2WwsZO0P//MrMmEIZ4AdVbWuani5Ho
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:45.2710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b10887-5864-42a6-aa5d-08dee7f7ab89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
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

DC looks at plane_info structs.

For legacy drm_plane COLOR_ENCODING and COLOR_RANGE this was
done in fill_dc_plane_info_and_addr's call to
fill_plane_color_attributes.

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b7d815997753..f5515ba64ca0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4234,6 +4234,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
 
+		bundle->plane_infos[planes_count].color_space = dc_plane->color_space;
+
 		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
-- 
2.55.0

