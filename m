Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA72606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xsEApE82
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2476510F9C1;
	Wed, 11 Nov 2026 08:56:03 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB7710F9B0;
 Wed, 11 Nov 2026 08:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSv5RBl1QkUMHdBXKVBndz5x1HNF8eEvj01oSzjYQhtEGSYsHVr4zRyQUteAmfvIckn+mhQx/gfb9zbJbkyuXUD37r1aujHZ/7OqEUcxkh8bRc0wKQ8jc1FCn0HVd38Iu+ZVw0YR3lM2OmJ2MqQNz0d7E89XFrdAtdEnMFrncXSOa1ovd4DzTK07X00jvrPlFVS2hT/Rrk/FncUTvXiw+vNg8m8YwQslZN84/vfYnmQnQN+B8BX1GNCqab2aqfTRn2Wxc1Y/6Q9lAukR16XzzjI/v5WIamb03Jc/4YPI7llchHrXNdahge8vJg8S9muvvGJ/HKU9Jmw2QB66GZz9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4tr5Q86YLIsGVPzrF0pOpSffOyk7+SBi6GblPpZ9Aw=;
 b=b4+9mlkw7ZhuDykNMX57TwXfwxSbmAn/b1adWFgFi0hkOqTcZDVGKSa1y+IsV1tGk11vgBLvK+rl/Y1pYlL6PtoArHOVytdQI25WSO1N6HmuA86nqVgNLNkEkR+gGBC5QKaFOSb/fSdl7t+eo9b411d874E+tet9BSJG5d7J5ZJZcE0Kl+Uu1hwkWPqsy8sG5WWnYgj1nf0yvKR0/2YpIDgnIhY1rymJLD7B5zoCUPfDNea4sNYf+n9ORYxTos5LVF9sMFqDkuZjTKAGux+r5We/vlUVRM+5mdn00M8G4SwwpJV4EEkS+v5ipsNrPf7HjIlvIJ4D1a6WlBMqS/n4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4tr5Q86YLIsGVPzrF0pOpSffOyk7+SBi6GblPpZ9Aw=;
 b=xsEApE82Mi3mDL0De4lzt7cM1S19zhslIhFn6/RUvw2I2cN3Nkg+kBRJqxgJeAZ4Jg1yTgnRfY7F+b914P9tSRl7EVraI1NBsRVfSrL3wr7hRrmnwvx1YSgmAE6OxWsVVR4SQOz9czCyHMZeZPIEPPD6AdYZ0mpbC0ePDiylinU=
Received: from CH2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:610:51::28)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 08:55:51 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::c) by CH2PR15CA0018.outlook.office365.com
 (2603:10b6:610:51::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 08:55:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:55:51 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:55:48 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>
Subject: [PATCH RESEND 3/5] drm/amd/display: send the flip event right away if
 vblank is off
Date: Wed, 11 Nov 2026 16:55:32 +0800
Message-ID: <20261111085534.514957-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111085534.514957-1-Prike.Liang@amd.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bbea3d-aa2b-4c6e-8e54-08df3fd19693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|11063799006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261102130727099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z78La4e8G2+i5CyhzYoS4RphVYtx/6JnarZ7zB2qSH7WHjCUqvp4gQNyM3lLaAQBc51D5JUjPFpxXciJ7rk7wr45I68sDhAsxIjmUGQNfG7iwcGmqNfw2PrBIUFy+xjbwyIzsioP2EgOqqBUpo9WmphO7CyYIZR+AOEOokTR2gCfyFnZoWbp34MfxpoRzvOCdQmy9iebeDGb1P04yyNINwyaSimUiJ1/HTiGF8pfloIm9iyATW7qZvB2q4IJ/QZQcs6tyyuGFqpsOx+NBFma7XKSjEvC8QXJ+sCVfW2fRJFoMwlBCikclI3IralteEKT6pEc6IdQ6GlQb1dmrCzSnCYQsVsIjskBWVBtSD3vlZGqyULaKwJLxBennnsskRS1MlEgoJHupx1U2u41e/6p3JeeGCgHJGxbXy5YGedHEFGH084WfTqSAAoaHuFjJKjLjinc2Fe4QB2NaTVlFBXuRzsKiD4lnn5HWhONp3Or0Ejy69phOidBW2fatqJos9SZt6sazp+dDS3RYdKhMjWWQ/5QyRtwhW1nYAUD81mqnP2ykYQh+g1WXHgV3dF0B0ISBcQ+yyESD4hMWBcuLmtjVgTu+4vGADsnOc/jqcBfgj0kG6HDTlJLCcsvOCUrOFL5CGIJOjvhxc5rrhTGJjRWRTY407wQWRn0RrMkrbPAZ7ENV8+pEtckTNsTxbt33pqXd8nHZhVsVBMZ0B2712MwbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261102130727099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MPzQC7RSi5N66zDsXueE5hzKV7Po2ansJb2bAzKKUXKnUWctnGba+B442CobKHvp+tsQ0h0UNzX7x9zjFP6CCKkoVuQhBqIeMOP/LV7Azq7fvqJ2AQzn2vFvZe7TDy19IsHX2N1ws6OeYkLjpKITT0Gv3Amlt5GknmTTWd7cRyEczvdkNUnlD8ucElUg3TTKCLE0MrLxMbSK2EDZrrUlJ2i3+SxbTjYk1vMUw4rlA+JNM2OksCx1ShQXVT+N1rsZB91lKqkzntZnazZPbUkapmvV5+SxrD0MBa5qpygPzZAm/lETpvQu+ihHZ9jSL59U1P8Aqq8QUOkupNgFdeoTijpou04n0lvSSqv39UxQWBDEjN50eGlrUPO1uFZV0cjQscRHm1JXp+ob3rZEssBr0G6EVjSC29cWb3uB1NenMZDaLyBaHe1M54Tc3cMVMXvN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:55:51.6112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bbea3d-aa2b-4c6e-8e54-08df3fd19693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
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

