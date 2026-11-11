Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E80606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MzXmfjHf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F375710F97E;
	Wed, 11 Nov 2026 08:36:24 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011036.outbound.protection.outlook.com
 [40.93.194.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DACF10F974;
 Wed, 11 Nov 2026 08:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDjHAFsIS6qFXVIvHgRfIwKaT9q2z4670usAhMGV7fShm9vPQFUXxX9Y93lywOHIQjFC5a+9JTp3gq/zrWgrx0+DrsIzgMc99mtL99N222PpF57qotFy1Lfqqmv4ouY7DHiW63wnw6FUvMOSmIIQItWuNMTjElwNJUgAD3OwGmtVNbnUoXm6ynEtsZvTMzHkgvmu0/d625o1AFOl9oXU+mXpepmCcphMw9Oe2Xxoey52dr5VE95X0fB8tq0o4UxNw7cFzV0zeQfWF17D0UBIX5EPtx3lhZdZRCukXtUISc6ZUE0rUNpYetnajD96o02hmFNoWL1lP/fsIRGb38WBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IGV4xSr0Ki4lJ3oplvBv/W4fRZV9KZU5EuNii4ozRY=;
 b=CsSUAapw+tux/e8k3jl1hPbirXbPm0aybk6PYFjiIKVSdXDtz8QWU9t+jOoop2LLGtFhY9LMoN593zTj+scg0qjSk692WoosTv9ZDyHbPWHdGh1dJH2xiF6xl9ENtYfzWYl79e0CPz20USZVrlqoiACaohBsGAia4tztjC9QX1UhohWt+I/HfRwLqHKDlzZUDjuZtcBA5Sw/E/+dtGJNZERzig85KY0sf3UzytOxmWml/kVEQMkLQMJPcyGpvAAmceWlyi3jERO1dTmodmZYEcBpMKszhbCBQWCt4PvEckSgutAMxyubipssYlBVhP18avxS24+6mR/4VOcabITL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IGV4xSr0Ki4lJ3oplvBv/W4fRZV9KZU5EuNii4ozRY=;
 b=MzXmfjHfvbw1pEKPUuD/B3x7qHpN5C7a1+Vn+HZ9uekNMhPFY7obaeJudFFbST5vlxd1AuPfX3rDA5J60jp67DXGnF2h5+azoZrNFIk0OR0bArC5qfLH9tr3TMsZC1O0pfBn29qJa1HRACYLY/YDfNcT4Cww64fD/c8CLPlHiN0=
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:36:07 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::61) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 08:36:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:36:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:36:04 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>
Subject: [PATCH 3/5] drm/amd/display: send the flip event right away if vblank
 is off
Date: Wed, 11 Nov 2026 16:35:32 +0800
Message-ID: <20261111083534.514290-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111083534.514290-1-Prike.Liang@amd.com>
References: <20261111083534.514290-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 172a724a-eac3-4e03-d6cb-08df3fced484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|261009223027099003|10067099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OCALIPIOvf9uRvkH4JbLRRyTVNtYJvfI12EJb/CJJ7w5mozKoUy9cN98TsnpnKD/xoDYJUJFuIhIvkQAy8Cau20vsabkH0TwlzLGShYTIxjp9L456CFVuTHj36SPzTw7NrkDtZCenPUDfkoCgZZzYRGBFuuDLpfhLcWD1dv6IgYqBdPLnLgMTv9Rp7dZT5s5OC+OUGOGeP8sINpOtM47N+sDDsgOP8DgGduDOKzV4yIuPpe69BlKkSwkXjd27yedooj6GPYfItwQLBcKlx4yTjkLOsEe/PplgnMRyHBTpKl8ZKJG0OD/GPUUsqLCUIx7wsgR1uZjh0jL0FZEeN0xUbXLe9YrlOrmByK8XhUkH/7RYNZQND3ABdgVA1+8aKtMhUn2xieu+CCqX/MG2RW9UBzdemo1uUfBlWHIHaLcvNVBc3iz+XOoRgakM7Toe4I4DNgRnzi4m9z2E1roP5ePRmOGeqbiQTAQV62hP/l62+CNWWDj12mOx8ADYF1uhSHno9IXvQYU7lFxPbJ4H5CQksEX1xoYzzjEK4koJ9+877q0/hrsAZREUOPqvneu5stCsTnGbNGcUfcUiukuFpBijfVFv2NVXt83erIswUISXmuyHG/vDMCCoR+1XDM8xv2ZaqJPe9F03eMrgNNyHG2Jse5BS2fJ9gmNfHZi8fU8cRRvsSpv4UBRT4ivJNoLCy09j13FiucylUWs7aEt1Z6vqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(261009223027099003)(10067099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NJQGY3wlva2hlp5ro1R4CGA+qQdhKmB1OzStPoCUzrOZHEwG14CygES8Wl0CZ8S4FPKBe7Cw22oEc0YgDavrJXlk8FJBEeUBUyVg3GndYbjU6Di024AeB/6vNIwPL3BVIKh8rMQN8Vf/Tn7zXZzQhpo0M/2Tt0NYHnl7MtLFlNHTdYOpMhMAcJumdgzzXj2LA6ulL7ra25yybpvgRcruY30INY3g3Eyty+k7H+2/6R/v16GDSYEtsusL4TAZamxhObrm1A6LoHw+nFjfM1TMlwS04L9me2CwCSDqe8+1S0MLt4O53r+68FUzV99xMjh+LZuf3vem/+PUVc6ZERTpgVYnDpCktCH7d9lF5C2mwoLkmNeGt+Eh5ANYsjq2WOP+MqS+Q2Wr7mM4nVgB86+HY+aMVACxSlYpFBmehKgXNYVrtYL1p1M/0pFswl5Ys92U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:36:06.9873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172a724a-eac3-4e03-d6cb-08df3fced484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++--
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 29 +++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33c73ca9cff1..d3882ffcb5d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3825,6 +3825,11 @@ EXPORT_IF_KUNIT(dm_arm_vblank_event);
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
@@ -3836,8 +3841,14 @@ STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *ac
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
index b9272b28f53c..ebec1260c510 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1812,6 +1812,34 @@ static void dm_test_arm_vblank_pre_programming_update(struct kunit *test)
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
@@ -5298,6 +5326,7 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_event),
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_planes),
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_update),
+	KUNIT_CASE(dm_test_arm_vblank_pre_programming_vblank_off),
 	/* dm_update_pflip_irq_state */
 	KUNIT_CASE(dm_test_update_pflip_irq_state_dcn),
 	KUNIT_CASE(dm_test_update_pflip_irq_state_dce),
-- 
2.34.1

