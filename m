Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D28FCA5FEA
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3535D10F99B;
	Fri,  2 Oct 2026 19:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HgtwxssW";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7140110F991;
 Fri,  2 Oct 2026 19:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXQ2R1WrRtJSnfhGN35+7GFdbaE+LPWxUAXYiTakBWBkjTUJJBXdxOc6ohgQzf2mdDzztlyrqsw2KT5nrAT2EAiQAUQTDdFiuuBdoKUAquegvBVtNyQcAC+nzXDp+bIcxz9rz9UPHFyjj4qfltKa2sJbcCgHp0krG5C8bXt4IiEwOIRqtSjWexBAtXxdwg6b7KNoEHvNdaeleQiBs8I7TYPa5Fgd9i+e8mVIrsl0dnlWh56Nm8l8IiwVT3DOBquC6op0r3OmlRpnRvJBrJht6BTnfROM9AijymuxyiJLkXu0af4Tl05jUJa2LIcK8cyxktayKe34TMKVoPM5QwzxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kfO4BJ4H5zIbEp+4ig/JzRhllniIOATESy4AWiLSas=;
 b=c9e9vj+/cy5OoiYKiEsUSwAJolh09Z0GizJBFF5n2tESB48jbzi7ASx9XVqhuWKIyYEYgIXdnVoMSEA5ca1MNBtcAgcT3yGVd0tR4cCm8EKNGc82TsqmHVsyucy32/XemM8mknlzlFdfFSN6soYCiHaROY1g1yx4VSsq65RhgtY11waMK1Jpmu04NLjg5fIlazapgcp4qWHXSh6jAAo7Mt+L6YyhhzM/8yOyf1uIRswlSIT+D8RsFl7/vwTYtAUBbjaTQiesdihRIz3/jspWjVyXQGmrzYd2JHp912ZaEHYE6syQt/TsFwPUQGVAPQOZq1nRqZ9aMnySq+nYkZ0I7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kfO4BJ4H5zIbEp+4ig/JzRhllniIOATESy4AWiLSas=;
 b=HgtwxssWpn/S4tPIxIIAos2N49dbF3AkWXKJPaMNOiouE2Lnyg8YPmCIbkN0uapzx8cVUkjj5HYY4Dg0HdaYKVEzh5X1IXGMMtxo2nC4LYIuwu42gan0XEsRt9mU0WJiBpoP/v70aUbp7CmdC89t7WHmtairE2jDu3xEUXLZjMI=
Received: from PH7P221CA0054.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::34)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:09 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::13) by PH7P221CA0054.outlook.office365.com
 (2603:10b6:510:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:07 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:05 -0500
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
Subject: [PATCH v9 02/21] drm/amd/display: Pass up errors reading actual
 brightness
Date: Fri, 2 Oct 2026 14:00:11 -0500
Message-ID: <20261002190030.211356-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e90e996-5e99-404b-631c-08df20b783c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8eB/ur4OXXKURMAXMR4zzwq0i6PzzWB1Bav09tHgTUTcls0YyQvqAgo3Erc3hhb8nfV7YUFMri5x3C3H42cOT1Ze8BX9qUBxPBbWtcaUOaItgeDRPiTuoryEcdX3uIVsJQduNjwmFGZq4ORVH8GHKzSW9lxUW06LmshYRebE1EOWDi9FNF4NS+kfx/jvWSplz3xYSdxtYC/V9Nlfu+SMzBQ025x97A+lejWz0biqVQXqEvZEr9GV4hNjboNLDc6UrcqP3mBGjkLzlCH7cfeCbQKipGlYSGNHu70ln4RfV73gm6EZ9zf7SEmWTlVQq36KR8drrUQDRTzuXcWL9kxNL5w9+0IyKnvNVlsp2lGUAX8naGTuYcTRx4yjVLtjRtJ6SUglITIccCmBIpcNiMQbDtYGCcrXMrJ0cijtSwGpzstmehJvzClCI1/QJEdHt/YxPhxGgw2iMsWalN3itQNNov4+1MinU5ckuJCHp+Rx1v2HwM9N4xeqlVTv09YaokKGyHdC+ygSaCY5nO+z6yPVRtkJHAAjFwh7s7LvkqRqOXWWS1SiLx3dS2/q0cbUyRYUgHJvWSAMys0sAAbx+ep+pM5sHIwZqTjVbehjAHfrntByRnk+mtpLSaZsMKMjGcZ30idZjY2l8AsNNUJ8gJr+cXkwCc1+DThPgKJRn9Zb/DtZl+nh8EEH8pXGfSCFQsM23QUyH+VeduVSyzdci83+bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WMnhb0cGB8QrUeQk1ml3kQ6Hx3y06BQJV9SKlNtMuRFf/izMdsYnJ8jTHIsSHFDt589OynTRBmktlJZrMiwvK1o1ACIWxa/qahNsvDokNgxSfVO3BHZKfLKzjDjuEoNbyJpdOBMZLohlljUsWYsNEnYarK7Rio93BSq5yWxZ64iqHspwLFWIWHUEwD16zxiIuvz25/HrvVA/EvnOzuxuKElI3+0T63wCxe2Ft100CSMTpPVk9bE/t+hANRI8xQ0h/Lb5hOWEiE9Cu5zjKn7Ney/YXi+zxnhkJ6jlwIFs18vsPzHt93mEDwpj+2kH61vXhxz8ltmuAOv8Hs3xZs0Moayg9Med62PHikqVODYi0WJh5kFw4IuOgDgq2kp2qssSjx91iueGV4cVsofu1cduUZ39Wddvyu5U4eGD6y5fGHvEfZajCvU42NBLiExsqxv1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:07.0929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e90e996-5e99-404b-631c-08df20b783c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 13 +++++++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c      |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 45e1732a5b041..64a963c218c8b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -372,7 +372,7 @@ int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
 STATIC_IFN_KUNIT
-u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
+int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 {
 	int ret;
 	struct amdgpu_dm_backlight_caps caps;
@@ -385,14 +385,14 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
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
@@ -403,8 +403,13 @@ int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
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
index 9ad888d3ae7b2..891749322191c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -57,7 +57,7 @@ void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl
 struct dc_stream_state *dm_find_stream_with_link(struct amdgpu_display_manager *dm,
 						 struct dc_link *link);
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd);
-u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx);
+int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx);
 int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd);
 ssize_t panel_power_savings_show(struct device *device,
 				 struct device_attribute *attr,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 5221050dec2f1..b21850788f36f 100644
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

