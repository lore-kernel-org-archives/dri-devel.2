Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F54C79FAD
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C481210E9B6;
	Tue,  8 Sep 2026 04:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKVbIp5L";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013018.outbound.protection.outlook.com
 [40.107.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9586910E9A7;
 Tue,  8 Sep 2026 04:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGw5O8XvH4oMbhcpSLkmuvNnH1hbIWaq0uzvIC0ljxlgPP0J2n0cl8D5YKyY6Q35ZwQzWqj3Pk3d/tNDeVDgGtXg4v9VaSwp91qAOmtZCRJEGXuJCndASCLOIKnf70orqZrilniV0h+4CBzGSo8+LCo9LWXHl8KEtgr+ZUtL+7UvWXdj2NY8Gd0KFywY4H+uk/mprldDVudN0Q6pFY3K8v9Hi68xSzgxyJy3jkZ8IIA0VF1b+Jn1UP99rn5chZkEuzzUT0W89/gXrhKWheZ2OPWSUy3ulm/i+2N8fbTeoCIhnI9LHK3IN2089m1n9VNDs18abybDWhD5MHGrk/Goxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJJCotAnOnQusdclPzMqOmu1n071js6qlpHaPkAAEJM=;
 b=USZeJKTf6iGgjdHRNlfUI6aZnmqzlYRKkTmv+x4ZCZH1dNauHRBYqK6nB40DsX0zzX+R4Yfti/J4Pw3H3cwWMVa3IVrFYbl0pXWIzBYVf3LXvhXCOik3w5TcRZOvZaoZAeV8YYZL/GTtHq2j/xpQIpS6+eBvDLbjGg6CIh9QfP4dmXUGay6hdO42Ohl7nXi3Jh3ln0Wl9Nvlf1iyPV7LXHyXbKkiI3+iFwGTP+jgxTEyU2gQWobvk5rCTYnxOgOoA4Vh7Ve9zLlX82a0fAsbTDawII/hM7YG+AJAjK8DpVEkiQK692cgHbLZYz3Oom37deyYtLsr34xrFezmOoI0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJJCotAnOnQusdclPzMqOmu1n071js6qlpHaPkAAEJM=;
 b=nKVbIp5LNGc4qr5HvNRzFZBSr8oSPuhiGyy3fpT2rDYI3bkXK7kafXK4ce3T9BOovF0/uc5KQKeyYTFvAIrRoEnQpZ4qzgvqKHj3O6Xp/uQN8WWyG7KaxfRNwGlVTegX3bM9EQYXh26rZvSuw6hLGW2WrA1Ip1JBVIWJgjsL9kk=
Received: from CY5PR15CA0028.namprd15.prod.outlook.com (2603:10b6:930:14::24)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Tue, 8 Sep
 2026 04:41:07 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::27) by CY5PR15CA0028.outlook.office365.com
 (2603:10b6:930:14::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:07 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:05 -0500
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
 <hansg@kernel.org>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v8 10/14] drm/amd/display: Update KUnit backlight tests for
 luminance property and fixtures
Date: Mon, 7 Sep 2026 23:40:31 -0500
Message-ID: <20260908044035.62093-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: a6dafeb5-65d8-4c5d-5664-08df0d6365da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /ShLSIUugH8m9UrSckeq3/lSAsOvFrKjUEltiTuCXw92QdR+T72eXpJO2yduWCMI1Hs8LkYOv5A9KtphNY1ExMOL4GZoAXCg+wLjenlL9QmyR+0RtWFRFWlJuu5h0oZ5pISv5oH3XCHAPvXaYvv3pax7dO0vUCgO9/pQvUmBdT9YRQaL/w9alWOytbHSjO8PItYZAInKYd4uRXp3DepSZKnpdd/T7bHr1IviYmkL5DSrihWOUk/GiRDWZiaSdIS16uQB6L3t+leQafxeoJhAkGwLaPyObusGH7c6b17qvIgDpLXgw3SPkgbCv8tehbldthWwUwKFpouOfNSoodr3jZVW8IEvIA7MV3RU9VFC+fPbtoaIP2X/Nu16cY2WCCQXS4yYpN+/1AA2JrMo3RGMsWAOt4p/dhSKu263yvDPnrgrZb8y5ux94PUudB4cq0eYWMnW9HjSsKk/MzpVFNxAqifUoJCvME1AGt2HaxXLBlO3dxSf3dk3qUZDfIwO5Hkf49BGr8Tp3CDm2bvP0zlXaaI/ff6jkitD1SNGLSVCyEyLP+WN1eZY77XAhFZK0JLEpzVrwMFEQNlfIleUvOwMSuZNZaCOf3cytxEusQ8o5pWvvFo/Jy/MLRtooRyhFwLKs5chMrrb1oaYcec/YZZVEya5oyx3Y8oRbl2BdLeu4bTlfq64rOlBFhiYqditdmqMtewELxsrxKIn36Af5VnTiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R1D2il0sn0ii/7jbAPkJUcb/vFiSxsDc1S+SqUaSseK60gbO62Wa3Gcbj9MbnjrS/aZEh6bpUsfV2nQp80MgJ1eWdCskn3GcECz4JEt9esJbb3WIaiwhNk/NVxiCrfHKdKdDylwhSUmS2DrA+cYoqzS4WcQOf+GDdlw/fCFJteD58rv15kdo6yGrovYsnXoHtJ+8o7r39p6/Ry65Dqz5BJGTm7C86VyNftWu6xILmC2JMXLh0kGYElOsAZjfTyzCL2u36573OiV5JpSw4ErWPI8LFdc2f8ob7hShkKx+MKE2nUCD3XjKiS2Ew5oIvIGRj4IhyiRu0yXnv4Ca8r/c48kKcN5T31JtyQSYuINbTJGUwXPebi6U+Lv6YY4K087F6Q7qRguE2fNo7UZTcoon3tNMRDx4A5fcTOgChWCYVVMdjs891yjPs5WKjX6q1NrZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:07.0757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dafeb5-65d8-4c5d-5664-08df0d6365da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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

Initialize backlight connector state and display manager dc_lock in
KUnit connector and adev allocators, and update property count
expectations in tests to account for the newly attached LUMINANCE property.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 14 +++++++++++---
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |  8 +++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index e03173d4e5bd8..c5f65e9a90ca8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -52,6 +52,7 @@ static void setup_test_connector(struct kunit *test,
 	fixture->aconnector->dc_link = fixture->link;
 	fixture->aconnector->base.dev = &fixture->adev->ddev;
 	fixture->link->connector_signal = signal;
+	drm_backlight_connector_init(&fixture->aconnector->base);
 }
 
 static void setup_test_dm_ddev(struct kunit *test, struct amdgpu_display_manager *dm)
@@ -483,12 +484,17 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
 	struct dc_link *link = dm_kunit_alloc_link(test);
 	struct drm_minor *primary;
 	unsigned int max;
+	int ret;
+
+	ret = drmm_mode_config_init(&adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
 	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
 	adev->ddev.primary = primary;
+	adev->dm.ddev = &adev->ddev;
 	adev->dm.backlight_link[0] = link;
 
 	aconnector = dm_kunit_alloc_connector(test, adev, link);
@@ -1884,9 +1890,11 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 
 	KUNIT_EXPECT_EQ(test, dm->num_of_edps, 1);
 	KUNIT_EXPECT_EQ(test, aconnector->bl_idx, 0);
-	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count, old_count + 1);
-	KUNIT_EXPECT_PTR_EQ(test, aconnector->base.base.properties->properties[old_count], prop);
-	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[old_count],
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count, old_count + 2);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    aconnector->base.base.properties->properties[old_count + 1],
+			    prop);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[old_count + 1],
 			 (uint64_t)ABM_SYSFS_CONTROL);
 
 	amdgpu_dm_set_backlight_param(saved_backlight);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index aad122c7229f5..ed5045c948fe9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -7,6 +7,7 @@
 
 #include <kunit/test.h>
 #include <linux/module.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
 
@@ -32,7 +33,11 @@ struct amdgpu_device *dm_kunit_alloc_adev(struct kunit *test)
 						   DRIVER_MODESET | DRIVER_ATOMIC);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	return drm_to_adev(drm);
+	struct amdgpu_device *adev = drm_to_adev(drm);
+
+	mutex_init(&adev->dm.dc_lock);
+
+	return adev;
 }
 EXPORT_SYMBOL(dm_kunit_alloc_adev);
 
@@ -172,6 +177,7 @@ struct amdgpu_dm_connector *dm_kunit_alloc_connector(struct kunit *test,
 	if (adev)
 		aconnector->base.dev = &adev->ddev;
 	aconnector->dc_link = link;
+	drm_backlight_connector_init(&aconnector->base);
 
 	return aconnector;
 }
-- 
2.43.0

