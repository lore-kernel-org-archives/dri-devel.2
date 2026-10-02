Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61702CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE14A10E68C;
	Fri,  2 Oct 2026 19:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qWNnqNis";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6673A10E67B;
 Fri,  2 Oct 2026 19:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj8XX4yx2V3SaIy4vPzQBOHIl3lYD1W1Js3Guf3GfxWsSvOYpEHIlGFRVsqn9PLieLLosq/6geVV4gh4mxEs1YNfne008ylL13b07s1YpgJYbTKKFiOx+LWIsQGX6kjsdTNPC9xygNVOQnatEazdW46c1pusouRkZdohvK7gscenySLb4OWkVglRgobS6yp/tIGNTMbcMMOIPy/hzRSOzGYFMNn1HsEXYzwtId0mKQFG2QmaicMVfdjPQQbwADqdMEuyMOTdeFwktfuRz/qfdu8sBdLBQ4eTOVov/HuMvcBO4bYy/onSeHzxuQmOt/aYf2tjBBG3Bc1XY/365J1oLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWaFSVCK4+H+QRs9FT+yebpSQinMbm1+ydUa+hITn+M=;
 b=NiVJYW6HPcbkZakzmEZNhxCIUVP60ZwSoF2kJ23ZJY4ZmfWIVqxvcwurjrlBWhq5Wx8lR8G1Gtiz6g+G6mOTH4fQv+NaTsxdtSvwzo4EqPPhVLFdlpmdlU65XodTPHgQ3BfaTeINyePYzMg0tzUAX5Pofh9n4b/Eh16PDj6FE8O0xnqMzznWfrNR6ef7omimAzDg1ZIozehECCbZ+yC4kt+vuA8WXEUFVv54EEO3G6vLjTzELb8N7WMeK5OtVc2ZcE9Iewd5qTU/gR7VQlZ96s/rTNkNYra6gopAGW8LgyXmHJc1EXfJLTDN35YY0pRqomHbNoz6GM38muHHCGm2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWaFSVCK4+H+QRs9FT+yebpSQinMbm1+ydUa+hITn+M=;
 b=qWNnqNis67q7Y9p36gcSbMak3Vt5rpEaaoD5M5gnDXykHYDN2iY5R4J14VlBwp0iWWjCPIfzbzr1MvUxYsTJ4Imb/0KGgmfTpKxbdP2Q+UpmHJM7tG82rRKuLxJc5q2Z5J9BoysQpM0DvFPBPaYAOXWXXM9ce3HUQisGi3vVE84=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:11 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::47) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:10 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:07 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v9 04/21] drm/amdgpu: Check bios_scratch_reg_offset in
 backlight level helper
Date: Fri, 2 Oct 2026 14:00:13 -0500
Message-ID: <20261002190030.211356-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002190030.211356-1-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: b79c6ed3-f30e-4672-9f2e-08df20b78601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|36860700016|376014|82310400026|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 41JqE1DyrIoLyyjnrln1iYYmGuaYhFxoRplv3N5oLsG9d9pUpIMjN49pEdZ+oCzzPEKuUcZOl/+Zvv86KPAc5ikmsck1TZxP861BV0vD7ScHykCEiKM6hNxoyV+ViC8uxmV10MJHs1Krsr8di0IwhQsxWYqc2O2hWYNzSlmgXgOK8TjwAFNoSUHzMmbT+5ER8WxNoLysl+F8fgF1qb2MAYxcEyZq2KBGWBC4JQb1vScBnK8IPB3MyanxPjYLamLRgRIGJdvSTcoEcj81eTMzkXltGYu6rhlLA8U1ZsMqDm4CxVN1xdLmi7b7wKgOyonWPDb3GBkR3sGHWF6J8E74JQBCO05KjZaKrRMdC7C/HzI7c9141EvIJ/uo/hqxRxdemQl/FrjQz2ze/tcHIsj8qBYeYit4DJCD10YBJQVF2q2XdF1b7kXlq2nJAJ7aBhNLY+00ntPsUNSndFYGOdCOA6LeuwaNAnHPVyObVoCOY0YBz/U7DYKYe9yFGKU57E9x7NHMU8rLIZm4MyDgGESGYby04hOzIb1rYz2o+g0uXO23pVyXtneXxYWmq9nbjxkNQql7tnR2kWPafJQ2ZQBLN3iNjLBWP8dv7L0FyNxMDDNVglDrBWOQL+zNpBBwMy7arvyVckj/7rcu3SsgQ7f+SJ4kYvabSl/O8mUp2oWI/DDqUfdCzhfMsO7SuHBIzqyqDskTsiClfZr4HRa4dUSybQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: utxX5fnUQnrfrApT2ZA2VZWzo8JfK0qsAWVZMSgEJNjAWygP3oVY99tRuciD2ARRLkyaxkcfxX9y39hZIrD8iPfETIEhnIyIw9hgnB6Y0HZT0RoX0P6cM4rcS18Aw2R+ing9J4jggmY7iN9IZSxjKK9ncwL0MIWH2UiaDGLrOUdXMdJ6bZ/BYgo0+49O5XtGuqosE9H8nFaUrUzRAgOuL9H4Xd6ENf4BAwhsbamVPcJUH4kuU1AtZ3ytTpT8so8agCcpOnfUB6XV/CgC9LQiydruR27Lgdla7ASl5cYUw0UynSiKMtobqggundu8ggoOu+VcKsY8NwhXsalZpaLw3JF3A3dvhveblN5GGlnIC+C1bLlxDW7duz6foZq1w/PlNjQMG3CxH66KkEMaWZNz3F7cp/5kXG1+WNl+QSSWlAI8mMuMyUPj7iCasLpWMP0P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:10.7902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79c6ed3-f30e-4672-9f2e-08df20b78601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

Ensure adev->bios_scratch_reg_offset is non-zero before accessing
scratch registers in amdgpu_atombios_scratch_regs_set_backlight_level()
to avoid dereferencing unmapped MMIO offsets.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 27c0dc8f6137a..2d8c2ba04e670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1622,7 +1622,12 @@ void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
 void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
 						      u32 backlight_level)
 {
-	u32 tmp = RREG32(adev->bios_scratch_reg_offset + 2);
+	u32 tmp;
+
+	if (!adev->bios_scratch_reg_offset)
+		return;
+
+	tmp = RREG32(adev->bios_scratch_reg_offset + 2);
 
 	tmp &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
 	tmp |= (backlight_level << ATOM_S2_CURRENT_BL_LEVEL_SHIFT) &
-- 
2.43.0

