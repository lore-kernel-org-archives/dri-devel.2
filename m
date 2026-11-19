Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CD606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4B5w7jP9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D28112123;
	Thu, 19 Nov 2026 08:25:02 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3851120F8;
 Thu, 19 Nov 2026 08:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPdk/BoXh+2TMKWvZHEzlVGImTLHwvThSMMZRP+yARcKJ4h2NSMopkyo6NrqkeuRPQwAaE2Z5o1fc5qpLceja6mu0AwwhSOrjNOASazwhHbHzFsQD8dzesXUJZpVMqkOdJH47pgfzoYZr1kDpH7vGonA5x7jugz36k/Xjrg00oNjOWXytcbcfS6k+jp0K1AZEcHxLyxySokmtcGzAb9N8oANrhXVlh5OEnajLTwE9mlcF8OHIxVc229NiuPFXejdxEdjMUDV6fQhaROaem8/T9PDDE6AkdmeYi7mtP3z5mBwu2+/fl5cK/2VnjynftRPEh2rnvbn3FRxMhzDCQqmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHsVjrVn5YL0uSDG0jcVdjYsJtRnV85IexVaJLYScjQ=;
 b=B2XZK4qIGynI93Cp9RqON/9qu+fmmY8pnVbMUsRKPj5xxTMcwtP8fnvyB2M6wQEvdNVlOLK8tnc/rcElsFcHdAAKbEYFXZiazBWwEIu4EZC/bTPXXxqkE+/+xZsEdwWjPwjsvRBnIBbRQVKKTGeVXaN1Zu3dOoIKSrKnTr7Sgyf/SxfeMHtre7NvintbXW02RoXvwqAhntQS8by7PkCbj32AMxm4VGRrrZp5Qn3o7pnUTcmXfNq1H8ZML3qw/MIJw+ihxSEQUt1yuU5QoDzBBoD+pC1DMPrH8Iwl7hmySk3TgxZRbZ3WjXmNMg7bjDuV9ZSC/ZfCMTSZk6HrXYWUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHsVjrVn5YL0uSDG0jcVdjYsJtRnV85IexVaJLYScjQ=;
 b=4B5w7jP9YiDQ8GEJNwKL/ClcS8AEIF/bUk5l8Fq2yMGd64lvHGKs8tZePufhuKlU6C0vyl3hb0QpWQsrALmIYXa9zPYlSpcBrtWnN8WrFk7LaCiQXBoIzXlj6yhFNNqOuY2dw4IuzehwrUU6CaaeJ4zdMga/zkJTKoz/z7NUB2U=
Received: from SN7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::26)
 by DS1PR12MB999190.namprd12.prod.outlook.com (2603:10b6:8:495::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 08:24:46 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::9e) by SN7P222CA0012.outlook.office365.com
 (2603:10b6:806:124::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 08:24:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 19 Nov 2026 08:24:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:24:42 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>,
 <ville.syrjala@linux.intel.com>, Prike Liang <Prike.Liang@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 4/5] drm/amd/display: send the flip event right away if
 vblank is off
Date: Thu, 19 Nov 2026 16:24:23 +0800
Message-ID: <20261119082424.554841-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119082424.554841-1-Prike.Liang@amd.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS1PR12MB999190:EE_
X-MS-Office365-Filtering-Correlation-Id: 659e8d31-8bee-4a0e-672b-08df46169192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|11063799006|260925021311599003|260925021911599003|10067099003|260925022911599003|56012099006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|261102130727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: x3o5rH1XqB27nxAOglZM/FafW3W3xLt5vYnhYu452jdhIcShiK5kTZ/FwxocFw77jHLIvsFbazKIKUnn+YHPywlU8tCH3t6q5lqAndEWJx1WfWiP5ElH+JceJ54VNkaIdsIEauvH9+tgOX9XGlBLSt87iiWmK60IXhuuzT9a6tqz3BGv8vSIUIAvWqClUVXMYPSiMbTi3b2P8RXpDwlkJXkIBWhSWI5uD1xkCeNKov/onZ9Ob7Az6ICnyhuODJpaJAZsi8knWMbQLR6xHlNmfi03yQBwIopVUGn7MRWLvenj2hn9xbCdK3EjMhpGr2rBbm3KHSzNUJ56aFTFvtk7mGjxBhcyUWOfk4/CnXVDUJ2wheoROUxRawDYzXY0MCj06l6+nq+dCYlfnvYrO8swB+PL+/1UdyNDIIsAm6+CByJQpvxiVSFb3C0rdNt2A2NS1Ke5YOiSdUiU0XBLEwp/va4dZSdfcJlkAhJfypCw7M/k484wc0uF3VngZB3rNRiEKclno9MVv28KBTJN7hujRhLrF6YTDDgFovl7ciV/4xjjyl6P+9AeuKcxeuzZ+cmnuB4iezljJ5mY0tjg9qHK7NhaHDzQMvtMBXdPabIQagtL8Jsg2DohNGfUw+1xrMapDDVYBkp4l0VJ69TOn0YthtYLAKcJaFtyNJfqcCgWLG7QRYpu2oav9G4aawua36GDCBzYMeVGdN3LOfqZ+676Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(260925021311599003)(260925021911599003)(10067099003)(260925022911599003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102130727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1k+6J+hQM8aimwNSKyQwTHaauev49oFtJpJhciX/nzWM5F10dGgzikD0QYThvwtdbCYS35h++ZpnOlg/HR2Uanjc7ZxrLXgs1mup8tAlgV48YrwtPLAj6HEZ6XM5uondJhaN8wq68+DAM7QOsa1YLhIRlXETozlwFiMBCSTNDa8/mCQZSRvXgqYPMDvSNeYWRSJ6okVEBzvrLsRw9OUsD7mf/8oIjGhbjWP5qEe+aERnF5sgS4Rg6LVk0g5IEa6J3c5LRWhkuZXtC4EMu6fmJWzOIAsH7SDBaw6BAuwiiIPZOwbN/x5qX76oH2SnUDmy8UCr4yF36j573EnJcYgSRkDSh5iowBZn/bDjo0hsDdZ8CShdvgenhpTiSHduQtaol3DL3eq5ASwUST6INHoQ89Ays/UswgtXmOn2+Oy1r5o0Py7LBupeIN7IisNiZQ9A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 08:24:45.4755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 659e8d31-8bee-4a0e-672b-08df46169192
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999190
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

dm_arm_vblank_event_pre_programming() takes a vblank reference for a
page flip or cursor update that carries an event, and the handler that
later sends the event drops that reference again. The return value of
drm_crtc_vblank_get() is ignored, though. If vblank is off, the event
is armed anyway, and the handler that eventually sends it drops a
reference that was never taken, which unbalances the vblank refcount.

That can't happen today: DM only turns vblank off for a CRTC that it
disables, and a disabled CRTC has no active planes. The next patch also
turns vblank off while a GPU reset has the streams stopped, though.
Page flips that don't modify the DC state skip
amdgpu_dm_commit_streams() and only take dc_lock after this point, so
they still get here while the reset holds it.

Send the event right away when no vblank reference can be taken, like
drm_crtc_vblank_off() does for queued vblank events. No vblank interrupt
could deliver it in that case anyway.

Add a KUnit test for it.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++--
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 29 +++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3d2201285888..3bf6b407bfdf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3824,6 +3824,11 @@ EXPORT_IF_KUNIT(dm_arm_vblank_event);
  * Grab a reference on the vblank counter if a page flip or cursor update is to
  * be programmed. Do this before programming so the HW is not in any
  * idle-optimized state (such as PSR).
+ *
+ * If vblank is off, no vblank interrupt can deliver the event, and the
+ * handlers that send it would drop a reference that was never taken. Send
+ * the event right away instead, like drm_crtc_vblank_off() does for queued
+ * vblank events.
  */
 STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
 							  struct dm_crtc_state *acrtc_state,
@@ -3835,8 +3840,14 @@ STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *ac
 	if (!acrtc->base.state->event || acrtc_state->active_planes == 0)
 		return;
 
-	if (pflip_update || cursor_update)
-		drm_crtc_vblank_get(&acrtc->base);
+	if (!pflip_update && !cursor_update)
+		return;
+
+	if (drm_crtc_vblank_get(&acrtc->base)) {
+		drm_crtc_send_vblank_event(&acrtc->base,
+					   acrtc->base.state->event);
+		acrtc->base.state->event = NULL;
+	}
 }
 EXPORT_IF_KUNIT(dm_arm_vblank_event_pre_programming);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index d400a223f1ad..99f2a6a41970 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1813,6 +1813,34 @@ static void dm_test_arm_vblank_pre_programming_update(struct kunit *test)
 	drm_crtc_vblank_put(&ctx->acrtc->base);
 }
 
+/**
+ * dm_test_arm_vblank_pre_programming_vblank_off - Test the event is sent with vblank off
+ * @test: The KUnit test context
+ *
+ * No vblank interrupt can deliver the event, and the handlers that send it
+ * must not drop a vblank reference that was never taken.
+ */
+static void dm_test_arm_vblank_pre_programming_vblank_off(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+	struct drm_vblank_crtc *vblank;
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&ctx->adev->ddev, 1), 0);
+	vblank = drm_crtc_vblank_crtc(&ctx->acrtc->base);
+	drm_crtc_vblank_off(&ctx->acrtc->base);
+
+	/* Sending an event that has no file frees it. */
+	ctx->acrtc_state->base.event = kzalloc_obj(*ctx->event, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc_state->base.event);
+
+	dm_test_arm_vblank_pre_programming(ctx, true, false);
+
+	KUNIT_EXPECT_NULL(test, ctx->acrtc_state->base.event);
+	/* Only drm_crtc_vblank_off() holds a reference. */
+	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 1);
+	kfree(ctx->acrtc_state->base.event);
+}
+
 /**
  * dm_test_arm_vblank_event_no_event - Test a commit without an event is a no-op
  * @test: The KUnit test context
@@ -5481,6 +5509,7 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_event),
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_planes),
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_update),
+	KUNIT_CASE(dm_test_arm_vblank_pre_programming_vblank_off),
 	/* dm_update_pflip_irq_state */
 	KUNIT_CASE(dm_test_update_pflip_irq_state_dcn),
 	KUNIT_CASE(dm_test_update_pflip_irq_state_dce),
-- 
2.34.1

