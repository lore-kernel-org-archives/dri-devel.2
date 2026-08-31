Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE1BC624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D221010EB25;
	Mon, 31 Aug 2026 21:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T61NFd4Z";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C3910EA2E;
 Mon, 31 Aug 2026 21:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVJ8ff5AIW9vJlyQNNTt+a3NiIowfETeeF2LuI5woIAPBtm9LKjrou36f96oaY2G3Ct3+/2I4GzNY0dSmSUs27EXXG8wjK5MT5CCuGoyZWwv3jv0330x6SaUyXOWDqydkDYb/ZAFgMQ9TsUv7Lc7a3PV7EbX+nU3Xza4/r+IqJDT9h6kYaSVuz1deSnN2Whxed4JXYNy7fyg7zRT4OpYdWw5LsM5zIEty/PDzM/VkLDHYj3xK6YCMONhtjUBpaxm+Cz572Je9zsL6V1BhrVVPfNNlGgG1n0J1JkuFyjQgjoQrBFWxi00f/XzUYygSS+e2hAdcOH3zW/jwwn4dn9jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/6HZA7vteqHpcjg7FyGTk07CDXLJ3gQoRlrtCpACZo=;
 b=wfb4D6dMAPaSmfkcQz+03WkRgsgZJuQ3PtY+MQLLhjMWZZo2vtFQkn5Pknxkpiw0jhB8qyWII8j9UQadgB49Db1ZaVcqanR/NXyGBUJPFApz9df++5gIPJutEtIvEPgy2i7Jr7UNhN6U5u7iMMTeWryG6aqURWWnwcNjsUJ0MoF4pKdWEUwCbNFkLTRnIyttPqT363X0W5WavAfAZogG17vV0+YxVDfhZO4F2NLjCpkvARKoJWj0tUWcDF/okB7AMw/RDmRRqqv5w+jFX+vzLEvatrxCypp9CdgdYePITy7Ww/2+pJY3CUjocsALoxakSG9q6sN6iP67yGb586EovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/6HZA7vteqHpcjg7FyGTk07CDXLJ3gQoRlrtCpACZo=;
 b=T61NFd4Z+X8qoHHCImTCLJemhwNRJfnVM1h6C1NVeVl4qtr4JkxrJA1BbOQLkpTCQiwOg6lRlDWFMvYbZItbdBMgmRcpcorydG5v+aHHgCdl/R8QdqZswfOPCxtY1jB4DU8FSrbmPRbrO+OyEBzbO2BYt8Ki9XLu7+QYIXTJeH4=
Received: from BN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:e4::23)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:06:00 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::26) by BN0PR02CA0018.outlook.office365.com
 (2603:10b6:408:e4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:06:00 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:05:58 -0500
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
Subject: [PATCH v7 06/12] drm/amd/display: Pass up errors reading actual
 brightness
Date: Mon, 31 Aug 2026 16:05:25 -0500
Message-ID: <20260831210531.2334221-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8f0c47-6e06-4002-2f1f-08df07a3a8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: T1/lJJi0Gvp5LFWfhdmWNEi37izsz4ndfTMiJGqMRpebN8ToRMXtvpGEZQQa33wuxSpHurw3Nei1SbnoBuh1+bL/BierZvNU3bssr3q1oEAHIE2cVvjUkOx1G4AvdLADAWKpVEVz28WubRQpOXsFZaqTioTfu6A7sFi/nWFUD96nMgCxekePuIqwzhpIH3cN4aiwXBfSTb+nuoKOXeicX59jhWcgUnZJLHh5DVGXMJiefPh+Ys86Ra2V2fx8umk8KxbBFIHmkMlGgP43XyH1EzESJDgtLF0LhfQynVOZQqUGLPVqWp1JluN3AA7vS9AbNmFWXx+s8bbGvSLlFEqylXn+UXFgbwZv8//5Hc5kHfOHuxRPzM9/L3jL7atS3mw3hYUWI7V49EoiidtnK7rrHhRS8basDAVFkyj+TWl2Poupj2MmZEO0mRrmCAfvCW6+WmZCB/vKjHkntZ/r6oxPc95MHyt7Y04o2PBMHxqM5IT/BH9ji50BuyrctxFVGSp1vbqzoFekIM1T5AqQbbuOWDakRjV8zDq+6/lH4KSdSH2HCKSRIjl17ykDOPE1On8r2zo6jNX5nw1lf/+YlRB1IvK/mOL6s3Qj+RGnSxzCd3QtE3MncHyTd0piou5RBSmgmz7QCJ1K1R3NMiSCvbJDpGihx4w9Hr9owRQ3XpQc8AP2elPYfP4v6ZgWjx2urYpxnW6qazmhEZ+lcw608uRJFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q8U79qiqWUr2uVOjjpbasdQsJx5SDFb8OwKNULFKE8RiAESS9JebsrTqSJi9BDm27hO+c4IY90FGwGHwCPe9OoGCwanTHnxLE+aey0+PzchKjZ2WSUkM01R5Kt31n0s8iRw63Q4hTvlH6cP4hLexdM3lFHdscQSKGOHT0dEv13s+CoCFidwDMHAOLH3BRjFOrh+L3dH2rJ1CNDZNFXenFDDmOS+mQ5IIWh4uBPu6KTg0fCqtfxHXh9TQ9KsnI1iiGzNaaFalLR5FCIpEwlJ2QpxG3cs30Kp8U7fwmV41vdA78/MATwn9CR/X8pCDKXmEgV7S5VEmgPIYYRj9PzwHMcPTOHeNuRIUx7Nh0z4wXrBTdmGbl1GqhV9cTcYsmLmBKJT2vHq2Kn7bTneVF14USDU7xF2K1j12eoSDx7sdqpOvO0t6Pwk6O0ZT0MxQhsmo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:06:00.2760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8f0c47-6e06-4002-2f1f-08df07a3a8d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c   | 11 ++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h   |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c        |  4 ++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index e61bbc310f33c..fb2aaf0178c2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -363,7 +363,7 @@ int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
 STATIC_IFN_KUNIT
-u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
+int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 {
 	int ret;
 	struct amdgpu_dm_backlight_caps caps;
@@ -376,7 +376,7 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 		u32 avg, peak;
 
 		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
-			return dm->brightness[bl_idx];
+			return -EINVAL;
 		return convert_brightness_to_user(&caps, avg);
 	}
 
@@ -394,8 +394,13 @@ int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
 	int i = amdgpu_dm_backlight_get_device_index(dm, bd);
+	int ret;
+
+	ret = amdgpu_dm_backlight_get_level(dm, i);
+	if (ret < 0)
+		return dm->brightness[i];
 
-	return amdgpu_dm_backlight_get_level(dm, i);
+	return ret;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_brightness);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 07b75064847c7..72f1c8d861c8c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -56,7 +56,7 @@ extern const struct attribute_group amdgpu_group;
 struct dc_stream_state *dm_find_stream_with_link(struct amdgpu_display_manager *dm,
 						 struct dc_link *link);
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd);
-u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx);
+int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx);
 int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd);
 ssize_t panel_power_savings_show(struct device *device,
 				 struct device_attribute *attr,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 7ca17f803f9d7..e03173d4e5bd8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -382,7 +382,7 @@ static void dm_test_backlight_get_level_pwm_error(struct kunit *test)
 	dm->brightness[0] = 4321;
 	dm->backlight_link[0] = link;
 
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 4321U);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), -EINVAL);
 }
 
 /**
@@ -424,7 +424,7 @@ static void dm_test_backlight_get_level_aux_error(struct kunit *test)
 	caps->caps_valid = true;
 	caps->aux_support = true;
 
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 6789U);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), -EINVAL);
 }
 
 /**
-- 
2.43.0

