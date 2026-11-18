Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC7606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5OtvTNh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F2610FBB1;
	Wed, 18 Nov 2026 12:11:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5924510FBAD;
 Wed, 18 Nov 2026 12:10:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0FA26217B;
 Wed, 18 Nov 2026 12:10:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795003855;
 b=dl3oznjNxGN+842jxUFa+pnhu7eqGEw4+9zq3G8f5OoLvlUpubNszDjtcWsDk3C7QKjE
 l5X+icCe3rg8CAE+2GxhYJqXCUXsZwK7+eVkmnfvCRZ3Tx/y0rlOKhjbr9sj0rvh2TepY
 1ePkn6F88i50Vpu4OW8Qi/oGYt6etGtRkO4FePdx7dDbLDf7ULwDaNEFrg/drQGMxYln6
 x27s7rYlJiQ3H6vRcmM5gRm8K0nPmiX0oTgwMnt/xoIWyMXFBq5FKkXkk3zsbUATkl+Kg
 oN0sm3bqolw2jpr+U6JTFzeyrJkmI5ZE04sm1WAGsr+dbUZ93jrj47L+ZSIYkfaizcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795003855;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=IDEsysbOUOCoyzVbk5RHA2xjeTM8D1r4H21fp3dFxwQ=;
 b=BazWJzbE+KDXrT+ooO17ACQfFBoRRr19dV0p2RFY+Xwg4P3TYGrnpjz37AqmDfNd+l6k
 S6MZvqn68tNT+EW42szx/LtGnqb9R46M40MD7ajGCGad6rZq3Snky7tgYFmNpoKf6vFy7
 mP4SKMVMmV8BLYuvO3KkKWuhj3sPUP5/E+Ws8wbDZWqqdzUULqrE7jdb0j1VMKaYJnZPr
 zSuct9x9gmDAbv0tib2YzyCu2d4fEQ3MchYo9NJWuEavPkFKJeq2Qc8cOkSdaqXBDDsZt
 aLQvY3L0teq8yyr75MfVALWLG6NnNnbKI1o8NtV+A3I0HHFUpqFga6jjNPagXNmqovQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 65DF71F000CA;
 Wed, 18 Nov 2026 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795003855;
 bh=IDEsysbOUOCoyzVbk5RHA2xjeTM8D1r4H21fp3dFxwQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=f5OtvTNh6L21HLgacs8LGUHn2OafeO4XuBJhiSfG4SQT07sy1F3Ql8H0zG+2WudPm
 482Evid7cm9dJb6Cj20PvG+3iMKtDHqO01EsqZkk5OQ0/bjsnKZvNiv0F7nkLdxxYA
 txckg6VCI3dOFAQ8VJlG5nasl+gcMhYIRCXm56PCLOW9BQIdAfHDZ3xhHllqYwxs4v
 iHr0SDwTGowvldse0TbJXGvrEeDnGixLdV/CRtWtXWuqQA3zDUNmBUUXXx9Z2xHedE
 pZFOEEJJB3JfbA6cfoWkROGD0G9EeF2DuMz/TYHnzifBz81BnbzLx8ogQ4KlF5f6Hv
 ks88U4GN4rPhQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id EF4AF4AD63;
 Wed, 18 Nov 2026 12:10:53 +0000 (UTC)
From: =?utf-8?q?Eren_=C3=96zen_via_B4_Relay?=
 <devnull+erenozen.protonmail.com@kernel.org>
Date: Wed, 18 Nov 2026 15:10:54 +0300
Subject: [PATCH v2 3/3] drm/amd/display: Test connector init with FRL
 status polling pending
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-frl-polling-wq-teardown-v2-3-957e61c0b698@protonmail.com>
References: <20261118-frl-polling-wq-teardown-v2-0-957e61c0b698@protonmail.com>
In-Reply-To: <20261118-frl-polling-wq-teardown-v2-0-957e61c0b698@protonmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, 
 Alex Hung <alex.hung@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795003852; l=3475;
 i=erenozen@protonmail.com; s=20261110; h=from:subject:message-id;
 bh=kRz6sTM7utoa2NOF2uowuuqvgRr6QvFl4fMYSUZAY+Q=;
 b=TeJT27I2ea5k85PobNZ37mhldRdA5V1rvCsBKLnEAgFInpHi3UPjfMWbmWnkAApYSEOFngEVy
 Sy8cr0kwv9MA7wM5GeQCqnAZ5+REtkxAdPKVwaL/XRU3tP11a/Pac75
X-Developer-Key: i=erenozen@protonmail.com; a=ed25519;
 pk=tPAwfVmIbYF3QziJ3LcoTIZDU12BsjVK+EkAB9nN1gA=
X-Endpoint-Received: by B4 Relay for erenozen@protonmail.com/20261110 with
 auth_id=1479
X-Original-From: =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Content-Transfer-Encoding: 8bit
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
Reply-To: erenozen@protonmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eren Özen <erenozen@protonmail.com>

Add a KUnit test for the problem fixed by "drm/amd/display: Initialize
FRL status polling work once at DM init". When an MST branch device is
plugged in, amdgpu_dm_connector_init_helper() runs for each new
connector while the display manager's FRL status polling work may be
pending, and it must not re-initialize that work.

The test queues the work with a long delay, runs the helper for a
DisplayPort connector below an MST root, and checks that the work and
its timer are still pending and that the polling delay is unchanged.

Without that fix the test fails: the helper re-initializes the work,
which drops its pending bit and its timer while the timer is still
queued, and with CONFIG_DEBUG_OBJECTS_TIMERS the kernel reports
"ODEBUG: init active ... object type: timer_list".

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Eren Özen <erenozen@protonmail.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 33082a674d9e..bac147717e41 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9624,6 +9624,39 @@ static void dm_test_init_helper_hpd_debounce_disabled(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->hdmi_hpd_debounce_delay_ms, 0);
 }
 
+/**
+ * dm_test_init_helper_keeps_pending_frl_poll - Test a new connector leaves FRL polling alone
+ * @test: The KUnit test context
+ *
+ * The FRL status polling work belongs to the display manager and may be
+ * pending when an MST branch device is plugged in and a new connector is set
+ * up at runtime. Setting up that connector must not re-initialize the pending
+ * work or change its polling delay.
+ */
+static void dm_test_init_helper_keeps_pending_frl_poll(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct delayed_work *dwork = &ctx->dm->hdmi_frl_status_polling_work;
+
+	INIT_DELAYED_WORK(dwork, hdmi_frl_status_polling_work);
+	ctx->dm->hdmi_frl_status_polling_delay_ms = 100000;
+	ctx->aconnector->mst_root = ctx->aconnector;
+
+	/* Long delay: the work must stay pending and never run in this test. */
+	KUNIT_ASSERT_TRUE(test, queue_delayed_work(system_wq, dwork,
+						   msecs_to_jiffies(100000)));
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_DisplayPort, ctx->link, 0);
+
+	KUNIT_EXPECT_TRUE(test, delayed_work_pending(dwork));
+	KUNIT_EXPECT_TRUE(test, timer_pending(&dwork->timer));
+	KUNIT_EXPECT_EQ(test, ctx->dm->hdmi_frl_status_polling_delay_ms, 100000);
+
+	KUNIT_EXPECT_TRUE(test, cancel_delayed_work_sync(dwork));
+}
+
 /* Tests for amdgpu_dm_initialize_hdmi_connector() */
 
 /**
@@ -10803,6 +10836,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_init_helper_edp),
 	KUNIT_CASE(dm_test_init_helper_hdcp_property),
 	KUNIT_CASE(dm_test_init_helper_hpd_debounce_disabled),
+	KUNIT_CASE(dm_test_init_helper_keeps_pending_frl_poll),
 	/* amdgpu_dm_initialize_hdmi_connector */
 	KUNIT_CASE(dm_test_initialize_hdmi_cec_registers),
 	/* amdgpu_dm_update_freesync_caps */

-- 
2.56.0


