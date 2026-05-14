Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46875CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 06:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9A610F118;
	Thu, 14 May 2026 06:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HdmZmst/";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F9610F118;
 Thu, 14 May 2026 06:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZMN2GZCc1wYYhzv3Z+jiH+vuJgOCx7S59UKP0+lx4YrxxOY2oy4cmVg7Tk8lCmeWJ69u7MQAWPRB3oso1ARe1JqFXJFots7VsR0d1THvdGV22gk0Rlb3MkuYNf57DuUpW0gFjQtGy+F1wFOYJkh2DBXSCKEdWkEHR45cFc7I9ZWM9kBo7zqZnxRIRVQgjUH41AieU8DdMHgOUEvDSWqLQfUcgJvzVRbEW+7OFS8XJtY88PQsj3z/nrCn+9U1w6NMP8m1UldzA7MrEXLoxGa2ikRgVa+nSXh8HDSMCtejU+vGavzfPuTIx81zd5MTH6vyNFrz2/qzZ7FC79x16o69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QsydKX90QMV5lC7BlrCjtjEd0buymTVpalhyZO8YSI=;
 b=NUr22iOxIil+MpHiIWi8PkeoDslRCn4GzsqOHeC3tGI1tg+cBUEZm1AYazs1zJ4UZhiBPdfvdMUCheLrESJrskbgWPfNOMNFt6erNwQbLtd43kqEzycDyKV73BaaB8b8aQ6npIRSTLFaWFob1aKJ01TYrHqbhUwh3LGdLl8GOyjUbeh58e5w94N5BWQNGjH/FJBWTFTd88e6vi9e9ZrHCJXsdobskqppFlvRNXt2MAlnJ6K1AMtDbPsZVnuI31cC+G80vZpJap2QYIVyVIhJhuRkq7W6eM/4RZcPGRIJnMVKcSlA8K1qfESCukO3O4O8o+eGrMKN48hufNQ25nRNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QsydKX90QMV5lC7BlrCjtjEd0buymTVpalhyZO8YSI=;
 b=HdmZmst/zYOmedzHBuF5EPutO0VmdboiKSov5jN98xtZj2/GsicEbGztLN6HTFCsNBfH84HculY7soDiCO1f6+yzh8cjSoY7OJOlfxYQ+YNpuZlIDdPO1+lavio3mkFh8ZkOUHGuhjdHvRfZ5wh82ikroj0Qyfh5Os3HgFvH3gw=
Received: from BLAPR03CA0119.namprd03.prod.outlook.com (2603:10b6:208:32a::34)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 06:56:30 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::47) by BLAPR03CA0119.outlook.office365.com
 (2603:10b6:208:32a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Thu,
 14 May 2026 06:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 06:56:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 01:56:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 01:56:29 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 01:56:22 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amd/display: use DisplayID panel type in
 dm_set_panel_type
Date: Thu, 14 May 2026 14:54:21 +0800
Message-ID: <20260514065606.1151834-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514065606.1151834-1-chen-yu.chen@amd.com>
References: <20260514065606.1151834-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac4d6c3-088a-4256-f180-08deb185ed6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: J7lzhINEeZFEn5vcnIi79CfcXM5aI2eZ9QHbHtOMsjvYsr0MFNGGLGzMvqc16d3jk06uBvrWzoqfAFz3QSbolmiAp49ATdDjmCvOEWcgergP4QsQLFIJqrAmk333Y1303abBO9ec6X1Xg+fpkHGpLoiKcX1wGez3fTdLUiLC7mGRfrXf3q/QcZWXBJjX4jOCyABUrHSAAqqy9eyqzYsvczQAxGyiFKWEHtugJC6jxk0/I9u7moPSBX/kd1R2i7I4DWW1W0/j/uViQN65CDXhZnogXEed2rmoWZ3eBO7chs0S0a+ir+jkhv9z+/R/vZO7EgzN+RaiespFgGSkSdyZGAuHJYcokXaQ/3RB8Vq4G37QEknrcTPqO35n1nYRxMLyeVHDUCM14Ed80vonUJNZsAAZ6MkK/ndpuQ0erMkPixGi0c2giatmrSvRUr6wX45dmS3oyLN/Mzfx85HQ49CVH6ft2iV0pdoZuk7sQzylS7LeOaStK1Hszo9czdUCZg7OIaB+kFxwm1Qy3qt+EbRT/gXterP7ATjcdAVzjQ/5ZDLNIc9obixXHDAhOV88PpJawJD+DdwNU7dHJRfLjeJNW40RkgDxYSikHa2S44/XgD/A4CuwnUJBN9wN2oni6cviA/sva639kw7SI2hQar91BzQyYfqsav/iCyDkf3dibu0mQ/aljQRUOS/umurzHf1Hou4RP9yMKaZI+hQFraeWaPC9wonUtDAdUy43HQq8p0E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ocIUJ7emNlRzRihb7MQ/V/X0oc+2d+XKBKB1j/ZF3bCgerxEtlStzO7vXVvA21FcdNnu6OsZpWnd2cPkSC+MiB57Uw06Q8oFJD54tlaJB9NJXSWEsg6162XYNf7vefqJ+yaRPqMi3vprhxExicdGM1yvNIoCIhMVO5AI7saH9nzhqVJFl24NGo8kRrobj2rUahoqnPOzfePcHeEfQak77bmkeArBRebnwOfEL0ilcoeJvHEuqxu3LapoFnAs4q6DoGVunvPdgETeGQQxlQ2UNzQVc/iF1ZL5QXhRkFne8kLA77zfGMuO3sNYrsWaBC1yTcbzHiU0oVKV42fEec4SM4Sv2WeeGpwUBXryxeVnYPSlHPQaIqzOxrmLUv0wClqi4Uf0rzfu/g2QZ/stVTZuMnhBp9bZ1spgDuqjCHnhA20VOBcPkeQcxWTj9NXsMZnB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:56:30.4697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac4d6c3-088a-4256-f180-08deb185ed6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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

Wire up the newly parsed did_panel_type from drm_display_info into
amdgpu_dm's panel type detection path. When neither the AMD VSDB
nor DPCD determines the panel type, fall back to the DisplayID
Display Device Technology field to set PANEL_TYPE_LCD or
PANEL_TYPE_OLED accordingly.

Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e42a5eecdf46..353a4982333d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3944,11 +3944,13 @@ static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 			link->panel_type = PANEL_TYPE_OLED;
 	}
 
-	/*
-	 * TODO: get panel type from DID2 that has device technology field
-	 * to specify if it's OLED or not. But we need to wait for DID2
-	 * support in DC and EDID parser to be able to use it here.
-	 */
+	/* If VSDB and DPCD didn't determine panel type, check DID */
+	if (link->panel_type == PANEL_TYPE_NONE) {
+		if (display_info->did_panel_type == DRM_MODE_PANEL_TYPE_LCD)
+			link->panel_type = PANEL_TYPE_LCD;
+		else if (display_info->did_panel_type == DRM_MODE_PANEL_TYPE_OLED)
+			link->panel_type = PANEL_TYPE_OLED;
+	}
 
 	if (link->panel_type == PANEL_TYPE_NONE) {
 		struct drm_amd_vsdb_info *vsdb = &display_info->amd_vsdb;
-- 
2.43.0

