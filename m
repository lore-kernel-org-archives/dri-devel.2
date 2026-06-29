Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8DFC43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1FE10E0B8;
	Mon, 29 Jun 2026 14:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j+dR/Pvu";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2842010E07F;
 Mon, 29 Jun 2026 14:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHhH8/7QUaXJM4RDDlhFSU1dZo5tKuBNGGKmeMIGWlVcat0SzOj0+hkAezeqEoMCydoYJ9cBZonO1UszeDJZDCfqKc8kq9n+3KZj+WptcuLZZzIBRjNpr1eW3A/mdkTxmQwdd2KXH5TYgMNSrG8s+ZWlTUv7NH9GLGDlVzJHgjaN8YjWa/d6wosU/l55KRbiSWxg6u9IHSrlyNq5BjZ4kggnVTbBxMQZou0KV/EuTfq8efFrT65vLjmnv4pKSros4mvOEvVxdFDgwGJbJC3IvwGmRxQ72k1xaoFG2eQPB0v1SJzRaKgM1BGJ/6xHQBLcc8tSZ1Uet8QbggQyhtAyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvpScQIUgEOz0wAVPS1NFdprt6ltXr5+BHPmUTzl9/U=;
 b=U1tmwW4G2qByPMM95QArYnFSYmT3Baj2o916ClJweRzvOIz4j/+v/ckunICvQoMbBIPo6AVB4bDQ1avhzaSNKoHKAUgnPfUVBYhLKBk7o/Q5kJQT38EPFCNl4M3IaXQvYJII9RI9qOBy0YRiUCdH8WxvE6NnbC/n2s2i0XDeXZa+EwIx36QTU9S/iuJvbsXXRDqABHrxydX6RzqU+n4NTpVeofCCZdv0+/zWqmquJOyNkmvCyx5+5hD0j+FqOmpMHknLef5Gwgo6YuCIYMWl+BvfEuBi6anI4nIJvIuy7akrl6gI/lHca/5rzR1Wvb1kdkoIffbSeKvF8dKbyhd3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvpScQIUgEOz0wAVPS1NFdprt6ltXr5+BHPmUTzl9/U=;
 b=j+dR/Pvu/SGOPmkW3MZxOYM5EwnP5NqfRB+iQk1MKMZrV1/nreL6RE39Q576UFwtYvyhQ99gUlIW64fG4V3BCHeEZ54NsI9anG1k6HpXZ0K7pTNLsJKVB4Xx0jQaLJjxBK0XEIobC+rSG0YcIpyTZds4I7Uq0BUtCoJnp4uVsy0=
Received: from SA9PR10CA0013.namprd10.prod.outlook.com (2603:10b6:806:a7::18)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:46:54 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::ad) by SA9PR10CA0013.outlook.office365.com
 (2603:10b6:806:a7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 14:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 14:46:53 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 09:46:51 -0500
From: Alex Hung <alex.hung@amd.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona@ffwll.ch>, <alex.hung@amd.com>, <bhawanpreet.lakha@amd.com>,
 <george.zhang@amd.com>, <aurabindo.pillai@amd.com>, <chen-yu.chen@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Drop dm_pp_get_static_clocks KUnit tests
Date: Mon, 29 Jun 2026 08:46:28 -0600
Message-ID: <20260629144628.1710240-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a2a3c7-2f25-4da7-fd64-08ded5ed427e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|11063799006|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: 7WCSX25V00n5mbLKqO03sqf68XeBbovBRD4ze58P2cRWh+7fGoBYzAxM4PnQUTzXivG7yRUHMgYd6srB9mWhU5BiJRkyHv/CtFb6xDLT6EnHbRWd7ZzNEvYzbUQ+tbHr6NYYtEPOacND03dqjIksL05sjiDV/HULlcZgfDEUTzDIzHyYCiTtf3Y8Y1KQ1P4UceSD+LbutTW2ImBLtirsIf7uvjkVHC9XBE4iQGmjFg+FWRpTrBLN+QeczQ4fdkQhKKbIECtNoBLRNV3bonh44phj1I9uIrH1z9Y4e6vRw+5C65X9rpZc7/g1VCWWfdK6676hNnVyJQKEZjvqDxSjqvunVQMv7Bvb7JSnRwPYysjMRol+YVv8oS1qfjCvhC4NEx4VHCaLY1J15AwMUfh2X1IvbhFc/q8TwD2L4iuAlzjWlhZtkiTy50XnBb60muYvJ/h1H8z3hONozg2tz0t2CxEeQyOsa4K/EUR8fJCkIEPHIl+3+wZF+e6UqOKZbyp/5Sk0K9mSs9Rf4BIAZtWbixaBGsTDQyjJ9gbGyKKP1xAE/s8t9V7l5i2NRorTg39f/I8e7fa/oXZHRngAdamQS94c+bS67akR4Tklb2icWnifgD4X4Toso6I14dTs85Fj+3YXbaj8v+sQqBuepurjLdIU36ZBiu6jHlMegV4OzdA5nr74wRFXfqkrJe5FSFVYWeh1e1Gxz4BN20R2YzVWJ8tZG7i5CsOVZveg6if/rjFA6ytwd+yjZBasUMmSk1tV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(11063799006)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O1BMII7lIcihspskHBUr9lUeaD72xPW++mNP6v2kXmIzTFsVlO0UwWSj0VAj9iQ423J2ZLqhGy6IQEdxWiGPDseK8p16ioY6GGy0B5kPiZ6DU1xBpEQ4+q4kpTWsR+7kx7hg/F5UP2tBnU9fgtbEIKK///jP3qE6Sr/mhXzUFh4duxJFMsnerKWU48/di1OikXwRVlSRskJ/GU7LMvhmG2Tb6oV98CMVaA7SCB58XJE+M71lOYF6nU4HdvuJ5scawlo3imbixP31PThGgtt4QEc73yDmPjAKww9q5sEGVI6bUsqlD2OI+zeGwR7/NbZbu8ch+DlWm7gP9VMHN4vz84xDZGEgGxLQ8Vai7zXXFWtz9amaJ1MU2/KsKmVCJ3JF6y4IDyrTfzV8sY+v899NleXyrEk3aDnloYThgeIDHxs2g6VQdwxHr4k08zbzzeZs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:46:53.2112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a2a3c7-2f25-4da7-fd64-08ded5ed427e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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

[WHY]
dm_pp_get_static_clocks() is removed, but the KUnit still referenced it.

[HOW]
Remove the two dm_pp_get_static_clocks test cases and their entries
from the test case array so the suite builds again.

Fixes: 897f2ea8a45e1 ("drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu")
Assisted-by: Copilot:Claude-Opus-4.8
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   | 54 -------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
index e1d5088d8c0f..8d1d26bfcc16 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
@@ -1121,57 +1121,6 @@ static void dm_test_nv_clock_id_invalid(struct kunit *test)
 
 /* ---- Tests using stub DPM layer ---- */
 
-/**
- * dm_test_get_static_clocks_success - Test successful static clock retrieval
- * @test: KUnit test context
- *
- * Verify that dm_pp_get_static_clocks returns true and correctly scales
- * the max engine and memory clocks from 10kHz to kHz units.
- */
-static void dm_test_get_static_clocks_success(struct kunit *test)
-{
-	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	struct dm_pp_static_clock_info info = {};
-
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, ctx);
-
-	setup_stub_dpm(test, adev);
-	ctx->driver_context = adev;
-
-	stub_dpm_ctx->get_current_clocks_info.max_memory_clock = 80000;
-	stub_dpm_ctx->get_current_clocks_info.max_engine_clock = 72000;
-
-	KUNIT_EXPECT_TRUE(test, dm_pp_get_static_clocks(ctx, &info));
-	KUNIT_EXPECT_EQ(test, info.max_mclk_khz, 800000U);
-	KUNIT_EXPECT_EQ(test, info.max_sclk_khz, 720000U);
-	KUNIT_EXPECT_EQ(test, (int)info.max_clocks_state, (int)DM_PP_CLOCKS_STATE_NOMINAL);
-}
-
-/**
- * dm_test_get_static_clocks_failure - Test DPM error returns false
- * @test: KUnit test context
- *
- * Verify that dm_pp_get_static_clocks returns false when the DPM callback
- * returns an error.
- */
-static void dm_test_get_static_clocks_failure(struct kunit *test)
-{
-	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	struct dm_pp_static_clock_info info = {};
-
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, ctx);
-
-	setup_stub_dpm(test, adev);
-	ctx->driver_context = adev;
-	stub_dpm_ctx->ret_val = -EINVAL;
-
-	KUNIT_EXPECT_FALSE(test, dm_pp_get_static_clocks(ctx, &info));
-}
-
 /**
  * dm_test_apply_display_requirements_dpm_enabled - Test DPM-enabled path
  * @test: KUnit test context
@@ -2424,9 +2373,6 @@ static struct kunit_case dm_pp_smu_test_cases[] = {
 	KUNIT_CASE(dm_test_nv_clock_id_phyclk),
 	KUNIT_CASE(dm_test_nv_clock_id_pixelclk),
 	KUNIT_CASE(dm_test_nv_clock_id_invalid),
-	/* dm_pp_get_static_clocks (with stub DPM) */
-	KUNIT_CASE(dm_test_get_static_clocks_success),
-	KUNIT_CASE(dm_test_get_static_clocks_failure),
 	/* dm_pp_apply_display_requirements (DPM enabled) */
 	KUNIT_CASE(dm_test_apply_display_requirements_dpm_enabled),
 	/* dm_pp_get_clock_levels_by_type */
-- 
2.43.0

