Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA6EC624D0
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C973D10EB00;
	Mon, 31 Aug 2026 21:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lYIsR9+N";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282FA10EB18;
 Mon, 31 Aug 2026 21:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfCfQ0iKkwRn8JA3JXEdru56HdoCnAVOY2UwpaUmStQyUdDbuL+soiiOaZPLktPl+qD5TWxgkkMDT1Ve0br6wRuuGRWD3FRtULXlE0RChfvFMAndSV2F+00Nc6dTpUQ5ugygibfjpWU+pcrYpYqFB5pv/mYhf4BI7M+/d63TxhQ9hK6l3PtmDmEGzXGe7lBd5GLXineUViezFTHa5Wv8eUS1JzWosTZpa2qXkYc9sW3OpiL4Xm4n8yTi/iMKFPGcaolkwNN4WSOJQH3fzCjISkMwIDeegV5q15etcIl8ARdrYN3uWi/LQy1ECW9BizFfngLYj1K0uUwlQOnJsWwxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=marDazw8N9skqc3rDNfvjid9CJaSpOISs1ASWgkQIS4=;
 b=yI7Eff81FnECheGKV7+Jrtn6DKwbldgjfH9+NigA63mQUXoOM1/hGCs1NHu6s11+pAUWWBD2L7nIFN52Y5Q0+GtZLHXd0a0qcDweqzGLapRikeIKvqFTW9r6G8G7V4tGLqGKa9aw3B0PQnw9Nc0Jho92EU7XUVJFvx17PFVz3RpFnh8TI6VNzUMMJFIkFMUunGSoD9xyPs5Z9IhfItSVj76WPWg+VBmta4+lynhbmX5zOHndNZajahGk9DGVT17lH7oWpdbzxbs2jOUizBla5Fy6o/u8Izvh12dqrwGGhxbmlaNDlKd9QINujpnd4WIqZ6eiYlSI7b6aZsHe4Tv4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=marDazw8N9skqc3rDNfvjid9CJaSpOISs1ASWgkQIS4=;
 b=lYIsR9+NLHr7JH+gL1yT51f4wogBJ61lSyFHBaxDrjkJF3PFVglNycN0iDMmjWqdZoCcuZQGP9417jaTpcI0pTsqdYqp5iPp0P9VgML2pCdHZrM+zRrBGCfY/oq/O50JIx7TRUrGTBF5GyA1AJbs06fkJBWyDBdf+Xx8C0mHMcA=
Received: from BN9PR03CA0432.namprd03.prod.outlook.com (2603:10b6:408:113::17)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:06:01 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::5f) by BN9PR03CA0432.outlook.office365.com
 (2603:10b6:408:113::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:06:01 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:06:00 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v7 07/12] drm/amd: Indicate driver supports luminance
Date: Mon, 31 Aug 2026 16:05:26 -0500
Message-ID: <20260831210531.2334221-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831210531.2334221-1-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: ec235f65-b272-4e10-64c6-08df07a3a998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4zS0ChzVAGComvThfOrifSsDd1M+kCHQ4pZJsqyzDr30ct6aV60URboKGOvgE696IZnqk8Dj3B5hGfUd4ujSO7r4F3cM6WxIdALaXTVkRp1ZtCJCi4vWWnM0R6teDM4GbxGaLIY3WmazNWECd5/A/joA2hZsnCLQRJIvC2Zx5tYYKxbofWqM3LW6urUGMCDiSkNC23U1uNWFhnSe068lWiMeSmmFQ0OqMpuvkxvvwccaWQhrxLp0o/qlvFC8/iVonxFTOzmRCtn9rTtpZRH58+NGBGJT980pvmVmwtQGv63GKQRZy9X0ksgMIZClk/00CAFLaSDh9Y+uixHwUAVxugwi+/qquFbFPLygl3oojVL4IeuvEMFDndc6ZlXa16+MDWZ7sdpU9bsu0Alv7SXDYA8KPsw9nQNnkeQyEEpr3BOyLRDDe7B54+jTkP8CDVmfL6dKK2CvRQchnzJuKalUdU00jBcX/KfkX+bJaFPV9pYLfKzUsQpy+zuzJU36aH/fLmgHzxsxhK+6do63Q8/IycSSKPSeS8o4b0Ts907AC+s3cyltZDM/G0RcS+caxjolaIQ/w2FIDcPHzvCkjyWSQxssQAoY71Aztp7hQbzptBrg4Qd882UZ54ktN6/n+eg3cNoMc1ZxxHki+A4avfZxxjxKdxQdUfX9RRmIHsNC1YY6rO/cdjeZFjvoEPmXzERagAtqZAZMUmDx6N3J7WGELQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MxbqgYcvseu0N8FW4despXbTJjZLRePjBmnH7JW2Fmgfagp3JHAXuEI1Pj3qYLuTM9MJ20/Mq6Mv04JO7J+6z7cTpZnUOkK3yBoOvwfqyJ5bk7AE/5PXR8WIORRn8RTEx8ml3h4Ip5xIGI6djBgACOYNuFi2nBFD174YaI8Q1S8kmApc52yCDXedD5EHDAfzdTqHasBvf3qmraJWjI7HOkEOQsMFaCi2gS9vGNYeFp4JdJyKXOO9G8HcyN85T1ze9LtfreMulLZRv95+HhxRIP43q1JYg1xp0JvfTlcVSymp5WiRivfMKqj3rytINLWW93Xe0gfOgZhix6s5ieFnwfbe5clyJHkn3dJ27HydXrgMrmtyo1fARSRvAEQkg9R13A9S3ri4EDFwNLl23bC8thQc9pa1AUtES8XVP03S5Wwzqam2lbn1bmc3y5NcuGNN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:06:01.5904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec235f65-b272-4e10-64c6-08df07a3a998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
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

This will allow the connector to show luminance information for
eDP panels.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f9f1d6cf65c5e..26ba7852e1ceb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3124,6 +3124,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	    DRIVER_ATOMIC |
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ |
+	    DRIVER_CONNECTOR_LUMINANCE |
 	    DRIVER_SYNCOBJ_TIMELINE,
 	.open = amdgpu_driver_open_kms,
 	.postclose = amdgpu_driver_postclose_kms,
-- 
2.43.0

