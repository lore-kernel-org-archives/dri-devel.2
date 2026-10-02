Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9859ECA5FE6
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7177D10E687;
	Fri,  2 Oct 2026 19:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sDUIYoKP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261C410E67B;
 Fri,  2 Oct 2026 19:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHgcPn0MjHeKk7/5+HOVEe0j3MlwFdv0rvgVydx6AgAIv5odhgNF3Y89POYeZmzj0wQ0VTHJijGD4YuPSSKedjMA9Ilw2YZCYdlzVDjBzZsRDAbjwbEMr8Tfa/BOLGwYW7sQn4FISsM2F5EOAuTX7XxtiHD/RorOoEDgsriC+cMdEs8Y8pWVlReiRH4JMQ8gUwYxT3xhRQhdRFQKRVCbXqPhXGTl2HSAKX7AhNCBnpyyXdxrAV1JUIGpoolGudxMYVY1rIQx9KpgWVt/mCXtzKRey7nLzQyjPSsVsjv2jIlKvB1uAUqCqaOSM+3BqgwXnXysWJxM7E0VA8vCIp1O6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIQNt6knvogXBDpS0g/qL3BMOyLcS15KMstdfE3TJ78=;
 b=nwBg6H/6qfO4iIPAZzj9P2VPCJAibcOR947Mn537WpOFGsly+KW5zyq9XyX4t++LuLYBJC4AV+oU9Ot0/OJR90LEh4hIG9q0toKbZgEWmvYw/updK71oabenUxaKx9uHze5cSy5NU0YHQUCpRuOys0WMDf9adGQsrIrRHUKpWplaGDXsDPgqHhZ3ZOWMPvrXk1NWcWfMZj3Jl7KhlZG9ycoBEqOwUkwOaIHttHzt70k4ufLpsJyI12zdtolNxSTGt2X0DzWcr5dkAjispYbr1aS7RsYkcywbPv/dU1H95fKAg4OnmehUVI2d4ywEdyUHSrgdq57nB9OQeQcMIiwHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIQNt6knvogXBDpS0g/qL3BMOyLcS15KMstdfE3TJ78=;
 b=sDUIYoKPqAndiDf9el/kBpCfpu2CrfjrvmBeZps6PRpR5yi0xATeW8qQN4hfEr0tBUXIG8gWPs9Z7jsrO7BTnxAZO5SMH8JIPP39GHzybA2BeC759LDm35tMtwjFoeUHrnxZikMBRFQwIgVITrzTZNG+oKCQRW6LNYAwevbBtU8=
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 19:01:12 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::76) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:11 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:08 -0500
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
Subject: [PATCH v9 05/21] drm/amd/display: update KUnit luminance fixtures
Date: Fri, 2 Oct 2026 14:00:14 -0500
Message-ID: <20261002190030.211356-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e3dc46-96ec-49ef-3a76-08df20b7868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|7416014|376014|1800799024|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZSETQjVCR7r+7b7ryo5O+LfwYOibdQfna9AQWRmsQZskz5FU5uPEWTa6ZfCvB7fB80s3yKzM5H33fLgNK6fWpjOI5I/iaVw782cBSFhsbIUt7BvOwWTnmZNdbGlGCrxRY3k4nixqkBbmSn4odiR7XFnlnEtg3OnUM0WSIbZ5Un0y5uYjfavjB6dmOh81VLvvfHZLD57+hxyFLiuusmCTDPOYT6LSH9EGy0bHMzS0us0j3vANs19/weBoG7djjp1L60fUsSR5gsyUOfitQDEZwhH2s1I/8UxMEbcfT6Garde8/wJYmmXkloEh0/sJ7BwLo5mvoKNfThIATB6Jb77SoM6QsQR1pvGXZH3Ih9BBwK+pw3mGAQVU4pNWOTsZYlO+qPv+ssUpdCAdfB4xFwwF5IrKMb6oGS8Ro3sXN57cjqMzR+uUfh6hU1VPqK+fiS8mrxy4vTFi2U+3Qh1Q8As7H9xBaAfIeKYhWXKLVOC9SBllEil8mW+YWGfxW/Yhw8dmCj/FIsFc3i+bpwsLad+P4swykvKXe19rTKKhZztmRtls1ReQBqvo0xqXUmFoNHCSYw7bgsn+WjembOb/OQFBbUos0Ked5JBaPgPO7KQfwsHoLirwnZk8L6jIpL9w0jXBrNQaSUerPjJVWHoIEw4QlstUu0qfBD23v8/mNnU34pY5LcvDG37MfmPejyD5+mMsLgToxXrlxtWJhQ+7j6iyZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: la8R8nrt82AMO6kyNUA7uFPt8/tYHTbhGmWg0bPjDNC/gxTtiEG6HmCZWRTch1dUUrM0gI25JNUIcDSzTlO+NCHl1O1R4hyhwcQ/6rgE1m8Xw7JeDgcGywZJW7lDluKowX07yZ3vUDjLwrS4dzK+QTuVZ/O7s05Fk7t+LaXotgzE2nEBz7qF3AY/duuq0uoPxtjgU7ECA+TZcecjP+WI9F1Ei+oBFSH9we/uwp0Y6c70h+0wc7hxijFYd4fGVkNCPGtMi3CWQjiKFzs6BCmmVVrojffuFxu79ZUQ+/JQnspxdVIp3CvVizapMqs071fYCAAGTYNrAxaT7PRwE5vBiG8SqVSGX1uF/NVLJYsA93e8SB4IERNBFcPVQaSQoIgx6HUyb37pqKlw7kf0hOu54fc5VjSaeGY4kjyflWN2PRfaMB0ITZpwOwXfF7padQWv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:11.7001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e3dc46-96ec-49ef-3a76-08df20b7868c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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

Initialize complete DRM connector state in backlight test fixtures so
the atomic LUMINANCE property can be attached. Check the optional
property and keep the ABM property expectations correct with either
interface selected.

Also initialize the display-manager lock and mode configuration needed
by the existing backlight registration test.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../tests/amdgpu_dm_backlight_test.c          | 43 +++++++++++++++----
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |  7 ++-
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index b21850788f36f..8883010e8af9c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -41,12 +41,21 @@ static void setup_test_connector(struct kunit *test,
 				 struct dm_backlight_connector_fixture *fixture,
 				 int bl_idx, enum signal_type signal)
 {
-	fixture->adev = kunit_kzalloc(test, sizeof(*fixture->adev), GFP_KERNEL);
-	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector), GFP_KERNEL);
+	int ret;
+
+	fixture->adev = dm_kunit_alloc_adev(test);
+	ret = drmm_mode_config_init(&fixture->adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fixture->aconnector = dm_kunit_alloc_connector(test, fixture->adev, NULL);
 	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
+	ret = drmm_connector_init(&fixture->adev->ddev,
+				  &fixture->aconnector->base,
+				  &dm_backlight_test_connector_funcs,
+				  DRM_MODE_CONNECTOR_eDP, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&fixture->aconnector->base);
 
 	fixture->aconnector->bl_idx = bl_idx;
 	fixture->aconnector->dc_link = fixture->link;
@@ -483,12 +492,17 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
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
@@ -1872,6 +1886,7 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 	struct dc_link *link;
 	int saved_abm_level = amdgpu_dm_get_abm_level_param();
 	int saved_backlight = amdgpu_dm_get_backlight_param();
+	int abm_index;
 	int old_count;
 	int ret;
 
@@ -1890,6 +1905,7 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 				   &dm_backlight_test_connector_funcs,
 				   DRM_MODE_CONNECTOR_eDP, NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&aconnector->base);
 
 	link = dm_kunit_alloc_link(test);
 	link->connector_signal = SIGNAL_TYPE_EDP;
@@ -1900,15 +1916,26 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 	dm->adev = adev;
 	dm->ddev = &adev->ddev;
 	old_count = aconnector->base.base.properties->count;
+	abm_index = old_count + IS_ENABLED(CONFIG_DRM_LUMINANCE);
 
 	amdgpu_dm_setup_backlight_device(dm, aconnector);
 
 	KUNIT_EXPECT_EQ(test, dm->num_of_edps, 1);
 	KUNIT_EXPECT_EQ(test, aconnector->bl_idx, 0);
-	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count, old_count + 1);
-	KUNIT_EXPECT_PTR_EQ(test, aconnector->base.base.properties->properties[old_count], prop);
-	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[old_count],
-			 (uint64_t)ABM_SYSFS_CONTROL);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count,
+			old_count + 1 + IS_ENABLED(CONFIG_DRM_LUMINANCE));
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		KUNIT_EXPECT_NOT_NULL(test,
+				      aconnector->base.luminance_property);
+		KUNIT_EXPECT_LE(test,
+				aconnector->base.state->luminance,
+				(uint64_t)MAX_BACKLIGHT_LEVEL);
+	}
+	KUNIT_EXPECT_PTR_EQ(test,
+			    aconnector->base.base.properties->properties[abm_index],
+			    prop);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[abm_index],
+			(uint64_t)ABM_SYSFS_CONTROL);
 
 	amdgpu_dm_set_backlight_param(saved_backlight);
 	amdgpu_dm_set_abm_level_param(saved_abm_level);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index aad122c7229f5..66c9b2cb70fcd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -20,6 +20,7 @@
 
 struct amdgpu_device *dm_kunit_alloc_adev(struct kunit *test)
 {
+	struct amdgpu_device *adev;
 	struct drm_device *drm;
 	struct device *dev;
 
@@ -32,7 +33,11 @@ struct amdgpu_device *dm_kunit_alloc_adev(struct kunit *test)
 						   DRIVER_MODESET | DRIVER_ATOMIC);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	return drm_to_adev(drm);
+	adev = drm_to_adev(drm);
+
+	mutex_init(&adev->dm.dc_lock);
+
+	return adev;
 }
 EXPORT_SYMBOL(dm_kunit_alloc_adev);
 
-- 
2.43.0

