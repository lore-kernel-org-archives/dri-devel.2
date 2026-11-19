Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46D606A339
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tg2HjEGD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227D0112784;
	Thu, 19 Nov 2026 23:28:01 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A583610E097;
 Thu, 19 Nov 2026 23:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIFnYz5RCTAZTejNYMCnQgLlu3mcScUqd9UVANtKxJjnbAipNIegGc7qcrTPErVk/6WFbLc0tg4nc5aYEL3REdJu1r5Aa1mh1H4DqjSVwEEyu3GFg5Re+BVgPkKZGg+8Md9C5c1vfdQbt/CH+8NhNK0Z02RZkLwH040gUkQ35+R+BVx6qnNbAAfQahe7hSPdGDmt/sfrv6dGJllROkoVcjp8N7wiXyui33qJw4gPdvX49KpPsHAEJNAvvuqfC29NYFEy9P/MNvZ48cKqMEfuZnn+YqgbBg8ViQwpmOJN6gtPouxNooYcZpny/0db7lD8UCbaJCluDnlEdHACPH41zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w07INIM6jvnU92ypg+yXJvw5dWq8a1bCFTKCor998w=;
 b=JjFhFIfjXflVjL+p/AQqo6n9CEfb+2G02RsQZ/fl/uW/+SowVWpkQL8Zg3BtFEBomarv3h9BvEx4TKYGGpMI4l5UPQTX6Y75heYYKKm5QXMtELnkD6xuXHqW4cotQ9PPhkBBJjK/PbYRE0W2U8LGW2EVkEpS5zVx1Ux77mD/cwCh8f/LL4fQY5UjujHjoicXKfGFLwwicFKcXYJMuJDyQba1OTSLN0cRwHhzHLrjOAc/E/FnnaPJqocMMqoPLVIFbn0VrTinV1G6RFbo0jy7y9wGFI6Dbz7rIRUL1BvMs4zotSm3rLld7kcduIdhOs3HfTVGlM0ujq18LPw/i0khMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w07INIM6jvnU92ypg+yXJvw5dWq8a1bCFTKCor998w=;
 b=tg2HjEGDQ6iVrBOGBJrWYjnIoGuu11HCT3riubF/NqKTmlwufodyTxAyRhYQ2ZKQxGtqddE9toTCcb2Bofggv/h5arWj36vSHBdPdWGGgrx9A+Z6iIx3wy5PF28/frzi6ycvT1GuwKA3gcekwc5Shae0N3IycwiS87X268LvQ/s=
Received: from PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::6)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 23:27:45 +0000
Received: from PH7PEPF00000007.namprd04.prod.outlook.com
 (2603:10b6:510:348:cafe::19) by PH8P220CA0028.outlook.office365.com
 (2603:10b6:510:348::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 23:27:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000007.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:42 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:29 -0600
Subject: [PATCH v12 02/12] drm/amd/display: Pass up errors reading actual
 brightness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-2-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
In-Reply-To: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
To: Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>
CC: Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000007:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: d14a950e-9c06-4dd9-bbf9-08df4694b74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|18002099003|22082099003|11063799006|921020|261026121527099003|261022105027099003|10067099003|261026140227099003|56012099006|261028144727099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: kswnXb8CCyWy2y2BSi9DGyluI9VjI9shdpq833vxpDmWa3m7yxGb+iSjCWIWQOZmMEVAK10cQXblIjE8E0mv5YoE6yoZ91N4vvjrZEdxUIy/xQ7TUCRMsklwNZkBGe36bn8DxYSmOBoxhktDewAo744zeDoBXxj119UaiAD5fpqRRIld8dJ77ccQkfWpq1tGdyU/o2nYr5hpoxHBTY94/ekue33JbkzinaGie4dgRKj908FK4IIxpdp5F5aMZGOAnFFEpucOSbX0iPllRQRQ/tYcrjty3FO0O5jcC2kAG76Uv5L70nPH4i7SXBQEFJTu16JJn9bdRyX/x9H1E3eOQqU7ImuPFUi2xplOx5xgbH/V0D8F4jm4wYn+nzQix/ca1avYLgEYyaSo9GmmzVwDi+66eEve1tXLeZg/+M8OJ6IjBCR3WjX0A46GRluCVIid6pgtCPzmO4yAHvDD79lE6xGsxXgrZeTZ3iEuGVNLti6/4GXMqq3nLlHZTyVTl4J49e+KHQrWUfGz19Xk5L5Zlrn4HaP4nRI7wzAMaD7B3lIxiGp+4JIId/iDy5Ej9Hr9g9Eek3TQyHGvFYJ6fiu2rLqZ0usFWV/4Ozey/41lt37j9jPa2MwZEHpLabfMiTuSBDEGMTy+DlMP1IkazVZsGB13BoDjtvMoWIM0PE2wWM0o83vWkkXbgmHOfRT5fO0PwLivoIA+X1ZTZdGx210NHTPGQ4AgPSWcwvDYwVHND1BeV/rfWWe1SYiWrskdHcUD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(18002099003)(22082099003)(11063799006)(921020)(261026121527099003)(261022105027099003)(10067099003)(261026140227099003)(56012099006)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vrg7D5oNzlL/hOE5TOkMTeAHV9Vh4NbS9ulweNyV1z34t8zuRlMZwdJwNxD4r2kFQ3HsEwtCH3Zzh0yYhgZCog+k3pVog+GMKxlulSMzex3yrZIajb6E3ttrpwvnqL+CWpG/pssuZjHcLX+R8hwo8hqY4PNfRDVAP06zc+i9vXJ7VaCppS7jPoROK8ffBvp+G8yAUDBscBdypn+flzrXENqbYqqBLsAcB3fMwOXwTL61I6+pU379s2VWH86TV5FNwB0rXQaFubX4wTsOvYwlEdt5N/ZQzbZQh8YBDkzMIcMqrDaJZ3sEB3uVqD13G9i1ZUj9LBC+DIcIgb52hB7igl2kDa4RsG1d0tYGl6R1Xf5gO7bfr9ESUhBoYitnYhRqajZmTW8ipCQ2lm1KZu4o0J02oyR2+nOepmsFVkqMOc6UGWV5Y04a3KCd4z2H5Pwd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:45.3279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14a950e-9c06-4dd9-bbf9-08df4694b74f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Why]
If the DC API fails to return actual brightness when backlight control
API requests it, then the wrong value may be returned.

[How]
Change return type of amdgpu_dm_backlight_get_level() to an integer
and pass an error code up to the caller.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 13 +++++++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h |  2 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c  |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index cb74b00723fda..0f664c658a127 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -438,7 +438,7 @@ int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
 STATIC_IFN_KUNIT
-u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
+int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 {
 	int ret;
 	struct amdgpu_dm_backlight_caps caps;
@@ -451,14 +451,14 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
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
@@ -469,8 +469,13 @@ int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
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
index 28dda5324dfa7..8fc1c2f997688 100644
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

