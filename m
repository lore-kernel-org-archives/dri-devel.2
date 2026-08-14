Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C01C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997A410F760;
	Fri, 14 Aug 2026 21:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M9ZLZac8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8372010F759;
 Fri, 14 Aug 2026 21:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0Sd792ATFbw72QWSIX/2KFCEuDxMiLp5LcGLhBecbQhrnifcFXDxYqzyXhEkbYKHHUhgTNO0vwlh0UZpt/t+rTJKhRN248YZRJKipxavuTR/DjV38ieYAbRXt7LLdS3NRba1a1WPbrdAu8j0l7sUpBCfLzHnkqDD2teIkDe8ADVqq4FzghWbvJxaSr2NBlfWzST/feS1cDCOGVw+Maf+0V4Ky+FuL0KkZODSI9RfochRfDATPcRmLCTHl0IvI6bYRLVVATWKQH+6x6gECHaxHoZaY3w8yMM3UGhhBhhT3OG/Se6MCRMPK1Tl/SnXIT+p6Pho/YJdJjqL/yVydxb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri1ggv/BONm7U5mAK1PS9fxsh/DrZbxuPebt0tRLpIA=;
 b=tdr3Z1M7DdUAig4LsE0pALVf3OG4UrYjz/SzPBW5jlnNOxnRG+u4kIiYfCKWYM9b+4gIQmmAGLqOpPidwkr0x1dJK7efNwKZcFLzUbYJ6a0UPKdBVyjDWOAuC4P85URwevccOizgUybJxi635ShAxmQArcCq7M6WZHfpjwFTECrW0bV8wl/QN0tTWLO2mkaZFPVCAmSSF2zOubXzY0VQeLkz/3IG6FVAc2FlVQC+Z0l+jPvxLZY3FBcaTl6JR6FKCPiu7EQ1mtH9R2jcj4O64JRrvB+raE8g1ZK7V0HqKs8qHDT+e3pEdPFrR3MyA9LiDbHkn2nXfdiNRRcOfh6CtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri1ggv/BONm7U5mAK1PS9fxsh/DrZbxuPebt0tRLpIA=;
 b=M9ZLZac87uV6OcEROruu12PyH/vZUXZehlCl4wymCCEdKJqnmoDrkiW+mtRDezo+J8ZE5ubUAhU5SzNE50IUp26dB4DwCxHey1GNqOjZnuN4KCfPBFDzZ4B8rykw3a1QLpthUQVmkKkSGM+9v08OFyXbsF2sUjhgAEGbgSoXjA0=
Received: from CH0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:610:75::29)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:18:24 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::3e) by CH0PR04CA0114.outlook.office365.com
 (2603:10b6:610:75::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:22 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:22 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 09/10] drm/amd/display: Set color_space to plane_infos
Date: Fri, 14 Aug 2026 17:18:15 -0400
Message-ID: <20260814211816.1219597-10-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: a26c472d-c072-4fc0-bd1e-08defa4992f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: N7HuZDtpARK5k79VRYKtk7ZLyUtF8dIiDqj3WGPVun4bl8OPNmq1Hn/99UdmhFDKuJIxi2baYC1D0mDb6sRyR/jRkeFD+64P/dFaWfZu9LaVDbnYUp/TPAYBD3SdaSbghotRilvdUyCyTvTYGxFaMp7BC8x30a+pjgkVnyaZC+I7iw/ZcNBIEqGfXTsHONF3NKVvHS+wpJDm4anl+z/o2h7X7GjufNCEDvw5CVo3zPZejXl+bJE9Z9qXJSZgn2zbGs4A8FqDT9tDRlW85mgmsXKe67WpopeuSL+e4ua9/JrdorKuPuHuYM6LD6cusOaGrJScwYeQ5lVPtbhSSlWT4bi3UDhSQa12oTh8fnT8s+OKfNuj2ySJqE2nPM6aYew5yPFBbszMa57tXLRQoqHLV95wtsQtpWQsjPjMyOBZO987c1f5FpUccspc7rcEWgjmlmvGMTtPqH853leKdSeev5DAcZjb0xHJ3IAh3PFR1BCCgDz4TZRqt7vMeZASEKl9ATWqbi2dYOzyCCyyVaD5ytcsWUqaMoxfWt5z7t93PrxHI2SeOZrcI+aqo4jUaBkoIIFDeI3r+TVx6dk6vFXRZODvrqw+StkwVyDjnaHcOUVZwX35EhOGx+1uFUAr4N+G2jVzx4p7AX17s5hUw1Lh0vZgIR1hzHk1uD+T1o4FPyI8IFaqUNhZz1SNK8o7L4GwZH+7dAh5ca8NBDi/bp4cWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jyq1+SBR2E4ACdqLTKZJLKdRML3nzinKM+/rCCkTP+WyJEFJVBgaDmpVkCZp+bxATLGgbAPAfJ5G+bzvJ0zDOf7a3oPX0kF8Ma7sBt9MBY+jLFosjvLRFmxWibhFNHeETHcyV/y7YeDpB3j6dZzjqPQFktLHp3CBcOjwGMBSDR4o/fI8Ubg3K94Nk5D3VJtm7wILJYXfGastONChXVCFVivRV3Fp+n5BrObJWqVKoL2nHkvNjmw0k4xfaLuE3NHdR267g2lbRV4ok1his3Ipo6Hf6FCdgv/Q6a9MY2zKWutk0WH+9Ip/NByL+cPNayTlilfYp15YLLLfaCar+2Zru+IJXhg9WGN9fY20oenZ7qY3dmfn2fDMaOs7qNFv7+lWQRywLOVbqfPDiolCommCe8O8iIVjQPBqAvYt7xupTq7sEv427UIrd6TWuDtNnO4z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:23.7512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26c472d-c072-4fc0-bd1e-08defa4992f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 48d2d5dc9eb5..49f1a22f2888 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4233,6 +4233,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
 
+		bundle->plane_infos[planes_count].color_space = dc_plane->color_space;
+
 		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
-- 
2.55.0

