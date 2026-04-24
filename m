Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9FBFF8850
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076FF10F6D6;
	Fri, 24 Apr 2026 22:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gkv9mRkC";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7851B10F6DC;
 Fri, 24 Apr 2026 22:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLLyaegY4lwOxKxHRqi925KU0/RIFR2f/1Ru9w5oTywo5EQ3ghbcjmXll02bP/CdiK3mtvNC4dkWc2a3ISnFCzOmFdzHQIbC9Za5QFjyv7JP/IfdknXcyf97jU42JwndUQmR1GblrZJx9yoasHTRB5HRoqP+pbx/c+eMowxX8D7VPeT3qBBIEJ6vjkV7JncaV92m5//J6NG1/8BAwP/vgthRMXnvW/Dg9IlQ950KXJ3vBRYG0A5wcItFcrGy6Kq3mFe6Lp4K8q2+HAR4GjL6f7KKd3o8WNAMrZcEad2DMOFtMc5czUL4qu2GOfR3b3iYQ2aYz80gHZtDSiC5+izjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmaHa5eDtuy7vkkRJT9nfhykxGbUm9fxc6sxOHFjJFc=;
 b=DoVZk9zqjsqTCeKt3PjRHk+F+WWByUY/fmgCxblY9TB49Ahavvza8v7FN4gLj48Jxv286mcJj9X8p2CVyRlOY0MoDv8eIoDgZWSlK6BHBd2eHhmE57WnDs9d0CcI1b5jiiaaOaiIvP1me8W/D1k9P9bYSieX90zKJbXzSwyswuCu0820GU83MtY8/tkGQ8Teg1B8ZLXqQ74CeWJyClNqhiP63GAkYAqDECFZ+9k7Z0GnPgg3CQzYGm/Z4djqwCtw14sgPfw32r2hFEJkfgQcNYY36FPVqmU8OUy5Pt36KSK9PRVWmCvrXQGC+mZom5fvSBJ45Bt74wGMPjlm9pcyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmaHa5eDtuy7vkkRJT9nfhykxGbUm9fxc6sxOHFjJFc=;
 b=gkv9mRkC+ccK49/8LasAXraz82rHuchjwqA/NxH7xs/f826fXLH4TDufAdc7sLGeIEbYcIklKYGzJ1vBjnVwUuH76QZ3WC010F6ksrZY+Va8dv7T7HhMPsXpmznGBDm9duX+JvqoVDCyClFCeDym7pRlj8AEYRjvsm5vYilkvuY=
Received: from CH5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:1f4::12)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 22:10:20 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::13) by CH5PR04CA0003.outlook.office365.com
 (2603:10b6:610:1f4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 22:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:19 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v3 7/8] drm/amd/display: Allow backlight registration to fail
Date: Fri, 24 Apr 2026 17:09:52 -0500
Message-ID: <20260424220953.167058-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 89700b6f-b419-4c92-2a56-08dea24e460e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: y6nzEb8e63AtzqX0VaqJ6YQENEl3ef9MLCELVX0wZHcL+YLE4dI7D9Yf1/fsF+/ZxnRL3sioQCH9uhFm+5TAuh9nePkKdEAnyfnS7NCYalnPGDH6b/fm7NEDMepMaQvBHOAZOULD0J/48lTPORmXNJx0YWhDfr3JAI0cjimxrcm/mqhXeJ6X2iCiNyNY3NV9YQHQTIvfo801yXRz5jg12gS+Bu+E4gIuNst4FPSlILG80dWTA+gwS31zdooKh9K+6++nKTTVMbu8W9MEULN6BbEYCD41/beYwyu78I4MYzZM+5B3xrl/nU7hf8hKw1XwRXc3f8OdI3QXZ7trCgAmkQZufufUpGWkZ5Ql3TNmznGcoz3wpRMxPKEmT1ISuFK+frzuWkYGPaajzA5FqB3aLr2SoxhldsSPseQQ1Et3XgU28JYxRE9fuOI3DjU53qDLsXwcLW0zATY+WaRdYj0wXdUyhqRFMH1Bi4xMS2m12Nu0vvoEdv95SthTdF6WhTVIn2VRq12AVYNL7ut2QP+Iw30PoqdA0pscVZHfu2p/OVTkbvqucW3WA+ar2kUSj6BpGzUk0JcD7ko9ef/+BZqorFJZCazl9DlVEZZUK2/48nxQKaF1DiO9DEMq4l8zJa1oAjF91Azmm3pMKYz20E/YpFKK6Rnjto1GeuEdjPme96ygpbvAggwyzUsUHTEZV8Gx2KkKOzRJh9NbJhzNS/gKSXhyrWG0caTV+h41Fil+QxpmtH9QRJ9yAyFz156dE6gAQoPqfj/y/Xl+G6acBj50xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Xb5dEY4WCD5fPo5KlGsj4FVg4YWnQJakuSAERJgr7pl7tfZMbWCwPI/n1wInud/8CyEvOUmEc8HWzTk5oFJs6FBDKsGkTgn6tMV3SN7UXsoQfI6ERr8qZW0p1L+V/jgeJMDn6QLO9WojCFGdLBj6CyN40wu66QKXPyf6Gb1lMcmz8I/rmd9wej2RcGlNJUQLsNnKd2eW744APoWdpDpeO4Mi7BnvHd2GC0Z+phNm1xMx7p3Utubd8dpQd9j3fG+VUC5+Ykd2NrblS2r0nPSHjwmKf6pLrnh+agyFcQPHUHfIF+CxwgTAxsSZwDcBFyUOvonAnagFXbVyRFf2UzTheIxRiEapMgL8GHHx8AEyj0lbCHcQAuqYErR5L5YR3+W2Rr1o2eFDikdZ/nIWxZ6ugoLioT2mbc3WWMI5lzmi2Y6Xd9tMVNu0yYHghc3P4u1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:19.9342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89700b6f-b419-4c92-2a56-08dea24e460e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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
If backlight registration fails then it's ignored. This could hide
a fatal problem to a user.

[How]
Pass error codes up from backlight registration failures.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +++++++++++--------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b8a0dd558e76..6b29e5b6b41e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5353,7 +5353,7 @@ static const struct backlight_ops amdgpu_dm_backlight_ops = {
 	.update_status	= amdgpu_dm_backlight_update_status,
 };
 
-static void
+static int
 amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_device *drm = aconnector->base.dev;
@@ -5364,15 +5364,16 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	int min, max;
 	int real_brightness;
 	int init_brightness;
+	int r;
 
 	if (aconnector->bl_idx == -1)
-		return;
+		return 0;
 
 	if (!acpi_video_backlight_use_native()) {
 		drm_info(drm, "Skipping amdgpu DM backlight registration\n");
 		/* Try registering an ACPI video backlight device instead. */
 		acpi_video_register_backlight();
-		return;
+		return 0;
 	}
 
 	caps = &dm->backlight_caps[aconnector->bl_idx];
@@ -5406,22 +5407,26 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	dm->brightness[aconnector->bl_idx] = props.brightness;
 
 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
-		drm_err(drm, "DM: Backlight registration failed!\n");
+		r = PTR_ERR(dm->backlight_dev[aconnector->bl_idx]);
+		drm_err(drm, "DM: Backlight registration failed: %d\n", r);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
-	} else {
-		/*
-		 * dm->brightness[x] can be inconsistent just after startup until
-		 * ops.get_brightness is called.
-		 */
-		real_brightness =
-			amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
+		return r;
+	}
 
-		if (real_brightness != init_brightness) {
-			dm->actual_brightness[aconnector->bl_idx] = real_brightness;
-			dm->brightness[aconnector->bl_idx] = real_brightness;
-		}
-		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
+	/*
+	 * dm->brightness[x] can be inconsistent just after startup until
+	 * ops.get_brightness is called.
+	 */
+	real_brightness =
+		amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
+
+	if (real_brightness != init_brightness) {
+		dm->actual_brightness[aconnector->bl_idx] = real_brightness;
+		dm->brightness[aconnector->bl_idx] = real_brightness;
 	}
+	drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
+
+	return 0;
 }
 
 static int initialize_plane(struct amdgpu_display_manager *dm,
@@ -7953,7 +7958,9 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 			return r;
 	}
 
-	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
+	r = amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
+	if (r)
+		return r;
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
-- 
2.43.0

