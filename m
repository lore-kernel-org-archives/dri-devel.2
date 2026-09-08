Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90E4C79FB0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1096010E9B0;
	Tue,  8 Sep 2026 04:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fEx2pMbP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C592310E9A8;
 Tue,  8 Sep 2026 04:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLk5PQ4WkO2sa4RJCeH3rQPsHne8DzDEBmBcM8s9G56XSfSgZPk4Pq0H1u2G7gJNWxjATaGe4pp9EuGzLlzXYnQckAcIUTTbAx6dFZHoVgfRANq3KeZVei3DEnG5+GHLFoQK7pH6ZkELr89LQmczhx93X3pJRqED4OI6OeVYjoAzsqJ45p++IkNb/pAAOr6fNUS10f1IsuxUUkON+o7xGSdIATLVpKwgZNzf9d1NDQeIngEFVaBpV1TxYdke+AGdUSy/nq823o0ofhG93BqvSKYco6Rua3RBMcOmtGhrmf2UAqQGzq07LBoJVuLCuOAtx1Y7nOq1HiCgPSjFfi1LkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUyIY1HK1Yhq0IuwaPDZgfceb2Vvf0Njr/WfFQTDPmA=;
 b=pbJdaHLJJ6CT8+zlHMMdw4gmpciwCZJ+EpmoXfTnkBo5bo1OydCwhz9RLt8kb7W1TJCltqkBvWHfwmPMH4w62dKb33B1r6ypr2XwUbJ9Coca6KlF+SigH9AcIlrcE4MJtv7AiCyHiyVqsEq+skkO77SUIIRs86iZJAWP4rj/rTuPjjh31AC+IwSbevU0zp8bRiaXtxcGfTyNW8izFRX53l4CAzjkUbfHmVpVa3LRBG86E/fYaJmn/wktk38SFxPfMhi4T0PWrUblK9wDLgOWaN139xsTUfOu7a8NzZ68vIA8zJQVumfV/4sglkKDvKkx1r7HLpQNOACLdYdgaGxl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUyIY1HK1Yhq0IuwaPDZgfceb2Vvf0Njr/WfFQTDPmA=;
 b=fEx2pMbPB07By+GC2zY1fVSnbIPUQfikGjvo5w9sSA5vM2nQQmbQeOkAdJNllnhGzfgBHifx6z/kuQPNfrKAMEuihkudrVkV1NCjrlJtpYQVvBoCup6SdsqYvnu+OZndZnsqRtFiNmk+eyvbgTTRQxT3TEHxJ/GCJsEgR/ZLIIM=
Received: from CY5PR15CA0026.namprd15.prod.outlook.com (2603:10b6:930:14::17)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Tue, 8 Sep 2026 04:41:03 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::42) by CY5PR15CA0026.outlook.office365.com
 (2603:10b6:930:14::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:02 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:00 -0500
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
Subject: [PATCH v8 06/14] drm/amd/display: Pass up errors reading actual
 brightness
Date: Mon, 7 Sep 2026 23:40:27 -0500
Message-ID: <20260908044035.62093-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908044035.62093-1-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: fd51b513-ca58-4a4d-f636-08df0d636364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FPpRkL9PF7oI55byrvAxn8bwVZ3SMHYkMH6ckYf0ivPzsnNub80hnGY9lqvI93sJXtk9CgnYPafIGRC0jucjF8QR1csrVbJt5o2/A7XfsdD+KtJASrVRUY7AL5/OoagVQwWLOay8gYb7vK+Vmn2Hegt5FElOnzBRC45POVH+sL7+FmSb6j9moXz/5X0WHDl51Fgnkd7tdpyPYigeD8L75/YNUg/b6+VoVmDV1wh1UNoB4QOroqrEopHwKlI3x1VBsKe3OI5AZqNKQEUIrKlkdcky/jRWo0dco6Hf7EYkQ3ALabwPn9FiL1L8ffhPH+FEVXoS7EV0u5602E574F7WG9kkRWUPR8zEy0TQID/mQJdi4u/13oRgQQnFjfWeVQr9IbfTKW1gSOXpNL+icFGhc0cwrhXzzwzKGaP3Vpiim9D68MaUjgfmA3GR0BdevSnvx1DChxNqI0x8iE/lLxWt0t7JA2vEYpa2Hv0jTYbFC1ZarpIIkSNOpjhWgcNYfU6FTLFyke6DyoE3eD0llaE9WR7cjUkHwnjt8P55ujnQBFq3Vusq3gbn97iNt0QGl0WTlKMkoNo7JicOx+ryOdCaaMvc5P6Q+Y3lQpxl2gp+xbsnyubs8cQZSHv7wt/K8EaIpcvzxrZ/VAID1NK+Kuryo7I+vuoK03z6nTiPQZzQrX1gRo1vQOOAbCgTLTVoryYsIUropSiCqH8yEIz8lU/80Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 62wxJH9efK1zD0HRv05Fx0fBro/FSKrfIQ+cP75coTULj0QGUb5fhRFv2Ln9f5FkwcQ4rOfPgdRioSiQNqyErRr2SwiXgIf/cj8atWikPbfC4+pb/LbU3WZQV30DsZOgBPH/24MANCtO9eGHMgDIPCjySX5NYsUdqy6h8jVQCmVi5vzXfVio0C2ilfTY6fIrxnkTbTI4rwHQCCBEtRQz4d8PDovRtbE2DVDkezsNU6ungFUZMIcdFwdEmQvGCg4Km4bPbsi5JQe83+3q904ZHzBNYm1iSZAlNoL3+sy/F+0gnzoE1KJ69je2EHvgsX5YULiuTsXuiCh57OFIOl6yJGlEk5H6C32vyfOgaa4uVlV6x5oW5j7KvvAByal7rEUQdfMG91F7gld1nmKG8j8DZDPz0zsyq+xY1Nw9svqKlF1uGdmnXnSSyQE4r1hET6XV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:02.9747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd51b513-ca58-4a4d-f636-08df0d636364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
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
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 13 +++++++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c      |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index b9e90ea449ca3..406a821d03cd6 100644
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
@@ -376,14 +376,14 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
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

