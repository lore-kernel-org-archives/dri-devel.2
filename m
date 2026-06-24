Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5237ACDE008
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3515210EFD6;
	Wed, 24 Jun 2026 16:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mX1XAqN6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC4E10EFDA;
 Wed, 24 Jun 2026 16:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoG9rz01hdvQVqHX3bPLlGVRdPNGqbks0IGBqKK6NLN11zb41rIW0Uf6MnYVfWdg45uEUNYV3K9d4sPk0fZN0nrcoVlIyHrlTpcweyOySDqzgfHG1LLSlPrLPVtVh3+fHocv787hN++FjreDRbwYXybob5etKr+LifmDgVdUYXw3b6oemkTscrECSMOYhoRlK6ltoU1Eol38Z2BaxtJfDaRSw4za8qAKKYZ+ekqQ5Ucjp5KTzGKEgauypz22DdI+NCpCluT0PGLdBgXsulR7Ac25DBwkeMxfwIqm1INQUEqojl6ieBlLB+kkr4eiu3ZjpidH1w+lJyxcClQsQCfqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knczg6GjhYN7xTvT1S67BSIcLg6882nZ4u/MRUvNesc=;
 b=MMrs+VPaidbgC5QM+BHvS8p/UJ1/JSycFndVTPmfbFtcVVBRDLehZGID0qwp+vI5oq4bx29IeIyvYzHnAX69D65yZwok/Xqj/lyyPDuB+mf+9hfEGoIGVDg4jgmzFQayTuyFYGn8MQhMue00w8D44xBgDNKFXQO30epS89mqENZWhAp9csKbA9CMJJ9GrzjwK9Jiiwo5n3j7WyXo8C8hXOm0f5zMrf7StFHrhWyiDyguYqDuIV6hcNnHmFfpJwvWKby3u8uM5UztB/Pb+gH90E+W85wLYvHWe8tYVVLD9BQVOuAuGPK6cjx9b7C9NZONUZE82U3IBzaq6RFE2Tk86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knczg6GjhYN7xTvT1S67BSIcLg6882nZ4u/MRUvNesc=;
 b=mX1XAqN6lXR2VMpQnDCIzwnCzz0hkupOh3ztu0d4msum2azHumVSYDyFDLisWFVE0WbfYTiuLP5YnRrvx+YcpqsLdftXbbCyL2YMKf1RwJ8PIh7BV2dJ6gFxW8Z+GXTPU0SoegTiNmnowRxHbrTStFodZbGXxl94jaYcjxzByjg=
Received: from CY5PR19CA0074.namprd19.prod.outlook.com (2603:10b6:930:69::23)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 16:58:31 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:930:69:cafe::65) by CY5PR19CA0074.outlook.office365.com
 (2603:10b6:930:69::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Wed,
 24 Jun 2026 16:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 24 Jun 2026 16:58:30 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 11:58:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, Simon Ser <contact@emersion.fr>
Subject: [PATCH v6 05/10] drm/amd/display: Pass up errors reading actual
 brightness
Date: Wed, 24 Jun 2026 09:57:45 -0700
Message-ID: <20260624165751.2014759-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624165751.2014759-1-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 14164d69-efef-459d-9188-08ded211d1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TDrRtqakypwQ8dfHNmJrd+21xH6QIjp69lizYb5bk1abQVoh52TugOvULKZPz6pv18tPVZmhlzE1iQ8b3fiUw6QxPq46gBcUYnTT9We707QwPSLw96uqNQUvVohqF4SLoASGsSeth69n8iThKTIvPQ5dqlRG5EWiZhtJNI33G1SMjHyCCgih9BHxPmWbARFDKBhgS55bIeBLdysJPa5kZZkLe6rYzc7wDYZGeXftqQ2I0tOv4sHi8n5XEXbEgGMPmgWAXZCmxEP0u1W04pFpEc5+RKysHMmyVHGxWnvF6z52SNyXCrKICucDg7iIJNJWeaB/+EzemjYnMXpXWeNCiVv0fXTb8NJ3B+i15mj0ChxFwFCwjWQ1+TLhUesTIlOZ07H+pX4U0ZmWPmFLQcy6a/8tiIVH63WoUNY7qPvv5DxJg/mi7aJiHIxsgplUw4U5S0HePYFlk2I/0HG22jNz9EwPa/9AbH0yqdjngQZAc+8B2bl9SJew3iv1sbDNfSD6uGc9UzQCE0y+0ClinkSfCq03leQdPYLR+lF+O7VA4NgTtJ09RUlsm5FKtEOGrjyU394GAQ9/S2EAIGi4ApkBOJwn5H0d/QFqlo6xM7t0kzQLGGf5KoDeJzW5bXlxh6wDmN+bmxThPaRRaob2SiZwUc/SCTVwg3PK3YyM9QYEVwc5DwlSfdU93aEZIx9xySN0J1DlLxO+32b9oCF8Hf2d/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WTwzA9dfBbkWl7Z5i9O/CLPrmToqLko3sRpJyhfG/wW0enJbjpUqZeUOqhq29gh+g9LDI+CIcay0g5Y9sXWzDRWRzfYDsVrqvmSfOKuwBoVEJSMprXqb2iOCOdkOJ+MYYYUKTOYAfRTg0mQbHI0RgCqdXftXz6HJkP6pVEHLRsWe5fAhPCFmm6C1/BQonNpKnZvACEWeKhnELi7fcvLCfs9m/xT+Sp5hamtU+ngsmDkYeoN9/HtFFrC09jJBsBv7IyqnfnK5BQ9qs6i5KktTW7SoYZQlwcu7ja1rOXhLA2+W5mWrirvbNaeYXGmd7OeidI3tiHzE+g03H+YenwUhNoHOmWCv+rgQmcsCnZolV7z+txrFhhuDh7KSSkHV/IM5rIk834lYvG5qX6p0jU7mhA43tYbVBtSqGGDlPU4zcIeN1dIl3cxyc3+PwbIf9hSv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 16:58:30.8558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14164d69-efef-459d-9188-08ded211d1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[Why]
If the DC API fails to return actual brightness when backlight control
API requests it, then the wrong value may be returned.

[How]
Change return type of amdgpu_dm_backlight_get_level() to an integer
and pass an error code up to the caller.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb5696b5daeb7..9b3e2fc6cef5d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5492,7 +5492,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
+static int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 					 int bl_idx)
 {
 	int ret;
@@ -5506,14 +5506,14 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
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
@@ -5521,7 +5521,7 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i;
+	int i, ret;
 
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if (bd == dm->backlight_dev[i])
@@ -5529,7 +5529,12 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
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

