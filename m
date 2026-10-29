Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5A606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BNM6GGY7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B125A10E733;
	Thu, 29 Oct 2026 00:42:20 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8567110E733;
 Thu, 29 Oct 2026 00:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRtMtapUqJfXZKwyKItr7sOrHU/1XvWDsf2sNRYCuDjUGFYcfRVsLCY5dxNg0yRQY9VPJYTVMYvHTB74hI/nLLD7STl2qsDCEeIPP/K0jm87D4OgM8PMtGyP6g2ePhImOTpTDxBJPhWAzh9T9wYNqJ7xFslH3SkceBlQP+zyyqiyf7hbM5e5puAcZHKxBxtcOrj2pTZHO0pJ6G5L3P4m5QNGCWiS8mbr91lvh8cvISrBmrutIoVLNa52Feh99BSwXwS0IqhWpXW3eSv2avOnnPpIYRHfbRoZhT5M6zPy/+jcdBc0F/O/w034T+xzQK4VYrY0RLkT2OZHPARENnLwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrw3XKAPoZsBi9dNNs36nL+Cf/Vrg45sxLf4QGWWjQ0=;
 b=maODE1XRASYAiBhsXUe5n3eSsyTPTwtjU6tSn4hSfFT2A19dV85NRbdBro5yGqIKn8EMi2hWAAQfS/Qkx/5iBQD5+S46s6YMfdW6apYHGgFzSqFtfuQW+w7sJqC4zhmNt78ovi2b4A+u88XpBOGGQNreKV1aAs+AUs/DJOM1Oa+p5ro9jGnGEKFrGhffe55VObIqCBeQkkX5CYnDEgotOZngzqT/BLL6vPKz9rga6YK0Tl4c8XEgYTFriL3Q1IK1OzwjLooIJ1RHyai4MQVY3K9qfXnisz6ZRoRZXJuOOfOEPNIOmAaOx1AvwGURckbFGxmWxiPCwraysrsEfoGutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrw3XKAPoZsBi9dNNs36nL+Cf/Vrg45sxLf4QGWWjQ0=;
 b=BNM6GGY7FpZwKyabwN4owQ8/Ij9LSG3ZheakdAO7QE6U4EAPIkswv+gnlBOitBcCZXWOOefZB0fX48G7f0Q0bALNCuo7Iqqtw9cfWeDnEdlLO2g0e4MgdkntsSa/gm7Mbh/uF/agx2RMomsI+f9/CgCfxH7OiDCtcau4Ce+V4W4=
Received: from CH2PR14CA0038.namprd14.prod.outlook.com (2603:10b6:610:56::18)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Thu, 29 Oct 2026 00:42:08 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::b) by CH2PR14CA0038.outlook.office365.com
 (2603:10b6:610:56::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 00:42:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 00:42:08 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 19:42:04 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: Rodrigo Siqueira <siqueira@igalia.com>, Alex Hung <alex.hung@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Accept HDMI 2.2 FRL rates from the sink
 EDID
Date: Wed, 28 Oct 2026 20:44:57 -0400
Message-ID: <20261029004457.40545-3-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029004457.40545-1-jerry.zuo@amd.com>
References: <20261029004457.40545-1-jerry.zuo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: b95cf6b6-37f2-4c44-3ac1-08df3555763f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|22082099003|18002099003|56012099006|11063799006|261028144727099003|261022105027099003|10067099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: OnuGWpBoP8BxLVgEj3zFQ8nwzSD+cyAGz2yXOyikL0SpF+ojGTlxOeRSXikVNAxi3p3pbligSK/vU5glbB44jOtjNFBslx6UXx5JlJbkhn85APEvsdwQpcUc9WnKOLWYaXdC4ptL+JJOUjJ2vjRBAdl/o1FifDq+pdccANxxAiKa4QEsrypO+WXNTmqUogeVnFYUXrivZfVFEHuy6Mv6mQuFjWJVK8exLEjCmOiGyawpqzhhn8TTZsUWK7lKsNzIag31NUe/CoOZit6WlUCu4INJPNZwaa1xSYazat+K10Q4eEsx5ZHRreqz4h7M3sR9tEn86P5EZ1uKJ/PpVNQDbu1/oeIUfMwPLVhqrLMGancmyBat9GN5tnXZOl97XoVpvMOljGEllGhImiBnDGBavANDUAqlHWTalTVap6yE42OBElxnI8E6C2/hsHJ+od9+/SyMpYN9333dxXpF52YmjfHcvwD5wINA5FX0taVU1dCakQ7u+0o/3CsYpq5u1S055N/f88+PT6y7zNouSWjwpYqh2Iu+J2Obb/s5ZLoAXJ99+FPQrEnc08nAFV5zIRDJ2lAlSyKyUkv7C1Qe6Rda8Wd50QqIetjydyQTlF+GLQK+XV+oMeSLyRvAZAvWrTCNCkUPr9jHd0gcK1a5LIvcCKk9Nss+cVPRJHhFQYC8sgUeMYxAxxQaaIxssAxizHvWt+XMo1y2GOZqi29aXC6rng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(10067099003)(261009223027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6HbbNlaRU6QjEIskqyBz+tq5+T/AVz9g8/iYwTc4Naurl2NNnZdhOs2KGr1pj2EpgEORb8jlJxcESeFWMruV9/OGHrrHpaDWPH00wjX/tWgZh4s+Xm+m8wqLT2vQE42cKwz/8042Hr7DRfko7/X9V+ODqzY0ol1DfHpvvBVZBmlP9YRcHZ8JCFSBkn3o24A65rGOKe4MSr7yiP6fMiIRR5+F9GweavJelsLgZozKFr0kU6pqGLln+LXJwCiCnBFxLWEMFAsVkd02HyZ9mmFxIJxHwP8ydkOzVdytcLTYUWEZg4Dabo539QNA/6PHHmHrcCosRxUQDTxD02XUI+R+lqm5x9Bu6fsKj81Q19GqAsJuszCPtXTYoDB1YWMH5BR0gksdWD8wNx54J6TX2+HcmRBpRkXxvKX+R5r4VTjNGEeO5qqvy7J24lg3TPSyZBrq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 00:42:08.1914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95cf6b6-37f2-4c44-3ac1-08df3555763f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Why]
get_max_frl_rate() converts the DRM lane count / per-lane rate pair back
into the FRL rate index used by DC, but it only knows the rates up to
12 Gbps. A sink advertising 16, 20 or 24 Gbps per lane therefore falls
into the else branch and reports edid_caps.max_frl_rate = 0.

[How]
Map the remaining 4-lane rates to the matching hdmi_frl_link_rate values
(16 Gbps -> 7, 20 Gbps -> 8, 24 Gbps -> 9) and extend the KUnit coverage
alongside the existing per-rate cases.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  6 ++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 30 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index f0fc6d080c20..3067ac5bb0cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1190,6 +1190,12 @@ STATIC_IFN_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_pe
 		max_frl_rate = 5;
 	else if ((max_lanes == 4) && (max_rate_per_lane == 12))
 		max_frl_rate = 6;
+	else if ((max_lanes == 4) && (max_rate_per_lane == 16))
+		max_frl_rate = 7;
+	else if ((max_lanes == 4) && (max_rate_per_lane == 20))
+		max_frl_rate = 8;
+	else if ((max_lanes == 4) && (max_rate_per_lane == 24))
+		max_frl_rate = 9;
 	else
 		max_frl_rate = 0;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 38f53c596f0d..6e564f60b0df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -1267,6 +1267,33 @@ static void dm_test_get_max_frl_rate_4lanes_12gbps(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, get_max_frl_rate(4, 12), 6);
 }
 
+/**
+ * dm_test_get_max_frl_rate_4lanes_16gbps - Test Get max frl rate 4lanes 16gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_4lanes_16gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(4, 16), 7);
+}
+
+/**
+ * dm_test_get_max_frl_rate_4lanes_20gbps - Test Get max frl rate 4lanes 20gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_4lanes_20gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(4, 20), 8);
+}
+
+/**
+ * dm_test_get_max_frl_rate_4lanes_24gbps - Test Get max frl rate 4lanes 24gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_4lanes_24gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(4, 24), 9);
+}
+
 /**
  * dm_test_get_max_frl_rate_unknown - Test Get max frl rate unknown
  * @test: The KUnit test context
@@ -4893,6 +4920,9 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_8gbps),
 	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_10gbps),
 	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_12gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_16gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_20gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_24gbps),
 	KUNIT_CASE(dm_test_get_max_frl_rate_unknown),
 	/* dm_dtn_log_begin / dm_dtn_log_append_v / dm_dtn_log_end */
 	KUNIT_CASE(dm_test_dtn_log_buffer_accumulates),
-- 
2.53.0

