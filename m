Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F0AFF885C
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560CE10F6CB;
	Fri, 24 Apr 2026 22:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQgx/N97";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8421B10F6C8;
 Fri, 24 Apr 2026 22:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvMK8fBo1RLq4yKUs1rzThFc0xZblHej8U9IM6G+yAoRo5eQi5hpdelxv38yFiFv6xsUefMT5pPfU9CYjW1EsAJydsbSkgwfZd7KwD6pdvr9YkHLKRlvO5JQHuVt60NRkcoNE4u56ApWxwU0F6vhHn+vq+KczmrNxf89eUlOFqkOx6UPFYEZBdNNTknDRwP2l9PixTnZlSHQiSrTuIpdl3V6rxm6D4Aup6U3IgqPQwj4ea+OEk8axx2N9wOeNLY+ZgMIwOlZj9vDOuYntyUHLmsSTKFnRRnTxTHgeY69nSwm6M6dv9Mq1QrRGZl8lGI/o3dVB+nUgPSDqMI6ExGzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tngbu0G3HBaIf2PkNMPemDy4zO41gKCtE+JeEChAMEk=;
 b=PbHQFR58T7TW49j8hgUuW5MjbYr61aLeJ1H2shgnbyDSDfsow6uTj2gVDwCVlz8t4Wyv4H9h06swZPLMak9UUYwnLXlaK28UIPK6zwjQHcXbAqHRycCrFuGX0mzImoSf68e18I9tnh8LG+jyPJbcn8WViXjZQgs8Vc2R/F5OYRqisQg8AG5aEJWrNQznZ7f5FOyplEBPh1EBT/5vtXaOGfDngAzVSMrnBHVeA9vdBE/njcmO19Id3UbU5HNWAFKhwRUDcvap+MHMKL+5TE0+NyC4dhZKIOhkz22aFQUmr/Ne5TilevRjRQInANVawdnVALXpkjwtSC1XeqolwxY9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tngbu0G3HBaIf2PkNMPemDy4zO41gKCtE+JeEChAMEk=;
 b=IQgx/N971kHKKohNAt4jIpwEZYQ3kvrEqzpwyp+w0C48a9Dx5MQdlSmJROfpMKwX7qrPZGupjqhog9iHqLeeBIw2dyT48bVgoPxRBZrDYUeUkCpzlID9y3G77Zijp05w/oXUTccieW/lvR/qPpuUN+t4poK4S9ztpLMMqnnvboQ=
Received: from CH5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:1f4::23)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 22:10:18 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::b5) by CH5PR04CA0023.outlook.office365.com
 (2603:10b6:610:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Fri,
 24 Apr 2026 22:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:17 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v3 5/8] drm/amd/display: Pass up errors reading actual
 brightness
Date: Fri, 24 Apr 2026 17:09:50 -0500
Message-ID: <20260424220953.167058-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424220953.167058-1-mario.limonciello@amd.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 470550dc-94c7-4194-2e63-08dea24e44d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XxIbR46q57j41FKV2iWwEb93nZxWWLCP4pvToerdyoYZAlDFZvdNn62iHiMpLHY0j6FWzRlEImdhp/Scn6ghPdP5gIfgn6LVT0yNNAd2OHCd24Z+FAHejcs82IND094cJDriobeWyadw4TXBdF7luOqeYFBJBppNnPjmBzUu2AzigNahPNdxydunDsvCNXaYzYunxztjVFnHsBXQ4MhSy8r4IQvv9d/DPooCK89e9YC7Y1u95yzEYcysB7GHtXk3ykabiYb+fLRGhoWfNU2psj9Qze6pZbTtrdjl+2YzPPnXWW6t9P+lo2KhE+257qVM4aUlxU+WaVrSD7q69Uns1A22PnccnQkwB5x6GW4sKUNBafuZH1MYoKlg97SBzi61EA9cAePES3R24NKCcsWBcukBsgGMiFkUW1Z71qSmzVO4wYD/tL9qscZPC1VcYj7oIFAmR/DvA0+IyK+p9EAGxLhRPebtvkvldN+VlMibAHcMBnpJtjUFcZKkEGh2Y0vHA6MJzcKm1XaowxyNb9F4P1uj1ODnpBLGhY2mNCOUeNnXuD4GfwK9TVsOziPM+r7c4fCHtlDeS+4V3+0epNV8Dd8U1zoyYpLHa0us0+zZI4eVigxGFV8BW4UQ1IJnXEq0I3LrCP1TTi2GLzUvmor/HWie72/TMGT5UwbJ4RKTN9l7bwOuopCUu65KwRvEK7xn5Hp7+oGfDFGJHXu9jNDu7DCrDrQyB/xl4tWq3esy2DQiQaWHtvG5fI/V+IcVlt7foX0X4eAmVrNAI98gcKKNAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BaXZVwXcZSRZwCd7uzavqMQSD3OwpZzvBuXVsICirDnFfZi90rnaSBa/3KDW+9uvQeTMIaFJi0uhiv8uLSWn1kBiA9E9fzgQUn2jdWiDSxJNwdKG8GEeS8iCuXU8+98ksofc5xBSFfnOjr34rfkD5ZlUQWgSsOY4NsC8w5qZD/6MwE3w4l5gGYK5C9PQnbzryybz1xzFFnGO0VDv30cwvOJHC/n8k5UaDiBy4F4rRIXA07nM1O5cp+hdufPaSi/OuInzO+tP1+u0bb8ekJfA/fmNtz3LxZqiL8TjDsmJFc4N+dzyMG8kSuQNNV18lLiSFhndzQe8BrmyzehA7cfERGu8Rh1HJlMtv3fxnS4ED80GUyvF1EveoP9WdEZXjUHKUgNW1yonprQ81JEb0SAKNmzslH7OSMDimbY5kKC0DOkd4JihIfUj4ngKpRI0iqqT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:17.8754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470550dc-94c7-4194-2e63-08dea24e44d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
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

[Why]
If the DC API fails to return actual brightness when backlight control
API requests it, then the wrong value may be returned.

[How]
Change return type of amdgpu_dm_backlight_get_level() to an integer
and pass an error code up to the caller.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1d9ceb432ec37..5b8a0dd558e76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5302,7 +5302,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
+static int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 					 int bl_idx)
 {
 	int ret;
@@ -5316,14 +5316,14 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 		u32 avg, peak;
 
 		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
-			return dm->brightness[bl_idx];
+			return -EINVAL;
 		return convert_brightness_to_user(&caps, avg);
 	}
 
 	ret = dc_link_get_backlight_level(link);
 
 	if (ret == DC_ERROR_UNEXPECTED)
-		return dm->brightness[bl_idx];
+		return -EINVAL;
 
 	return convert_brightness_to_user(&caps, ret);
 }
@@ -5331,7 +5331,7 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i;
+	int i, ret;
 
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if (bd == dm->backlight_dev[i])
@@ -5339,7 +5339,12 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 	}
 	if (i >= AMDGPU_DM_MAX_NUM_EDP)
 		i = 0;
-	return amdgpu_dm_backlight_get_level(dm, i);
+
+	ret = amdgpu_dm_backlight_get_level(dm, i);
+	if (ret < 0)
+		return dm->brightness[i];
+
+	return ret;
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
-- 
2.43.0

