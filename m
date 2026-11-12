Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9D606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C465sI0U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FCB1121F3;
	Thu, 12 Nov 2026 16:32:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0F610FFE7
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:32:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E57544380F;
 Thu, 12 Nov 2026 16:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531181F000C8;
 Thu, 12 Nov 2026 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794501143;
 bh=bBg0p6MY69gwWMSsuXkmi1O0AL9b/cHh43WEUCk3kj4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=C465sI0UIb39wwVcZwz9QiE4RuerjMOTTZAmMOH+kpFDRhiAlrvCVSFLPgCvyuGAJ
 xVQowtK2kxoI3VdS6i9dNVqECx706uAE05rzbHtyJ2MTJDO9rdzUE4aHVgJSP6/s55
 WLYmtST60xtsvB6jo8CmlnGlxpBgKrLhPgPq3vDhhLYIbDhkkd46v+nUGpfuIVFLbq
 lOgKqmNTYapLVUfUbyriGY1AABgpACmwusCjr56IBjfnnE1Tmx9Ezg6m3+g5aHkKkU
 mAZWj50wJaEgvJWoI8GmW26O3KRf0eluR/gt3EotgiGT7v5Z3lH4hsQKK6a05jGZeZ
 3SYuXhRM/TI3g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 12 Nov 2026 17:31:55 +0100
Subject: [PATCH v10 6/9] drm/vc4: Carry the HVS channel over to created
 CRTC states
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-drm-reset-state-flag-v10-6-cefaa1ed056d@kernel.org>
References: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
In-Reply-To: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6786; i=mripard@kernel.org;
 h=from:subject:message-id; bh=MdgUI9oZhoGM9H2Ux74IeNHR8pguaAageXhvGfFYnu0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlfXzG0Zeko/xO2rrR0vGi7Jv9lrOakZOPpK59ZZHbP5
 HfZr7a6YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwky56x4brxlv69VcWbBI/2
 bZxud8T0Rbe0rsZD0809TT1csTNsmz4cY5vTZf6/68bWR5/eRpZxMNZZ3fFbJFxu33O5+mL3Rq/
 cP//q0j0eF0RM+mlkv2V5GhtHte0674wfsp/8eD71FV+dfwwA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_atomic_commit_fill_with_defaults() builds its commits out of
states created through atomic_create_state() instead of duplicating
the current state. A created CRTC state comes with its
assigned_channel left to VC4_HVS_CHANNEL_DISABLED, while a duplicated
state carries the channel currently in use.

vc4_pv_muxing_atomic_check() skips the CRTCs whose enablement doesn't
change, so a CRTC that stays enabled with a created state keeps its
channel unset, and vc4_core_clock_atomic_check() then indexes
hvs_new_state->fifo_state[] with VC4_HVS_CHANNEL_DISABLED (-1U), far
outside of the array.

Copy the channel of the current state over in the skip branch, like a
duplicated state would have carried it. This is a no-op for duplicated
states, which already have the channel set.

Add a KUnit test that enables an output, fills a state with defaults
and re-applies the same configuration, and checks that the CRTC kept
its channel.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

To: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Maíra Canal <mcanal@igalia.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 105 +++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_kms.c                  |  16 +++-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index 7a54f46acff9..c868d2cd1b3d 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -1119,14 +1119,119 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Test that a CRTC that stays enabled with a state created through
+ * atomic_create_state(), like the ones drm_atomic_commit_fill_with_defaults()
+ * builds for a reset, keeps the HVS channel it was assigned:
+ * vc4_pv_muxing_atomic_check() skips the CRTCs whose enablement doesn't
+ * change, so their new state has to carry the channel over from the
+ * current state, the way a duplicated state would, for
+ * vc4_core_clock_atomic_check() to see a valid channel.
+ */
+static void
+drm_test_vc5_pv_muxing_bugs_created_state_keeps_channel(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
+	struct vc4_crtc_state *new_vc4_crtc_state;
+	struct drm_device *drm;
+	struct vc4_dev *vc4;
+	unsigned int old_channel;
+	int ret;
+
+	vc4 = vc5_mock_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	drm = &vc4->base;
+retry_first:
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_first;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_first;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	new_vc4_crtc_state = get_vc4_crtc_state_for_encoder(test, state,
+							    VC4_ENCODER_TYPE_HDMI0);
+	KUNIT_ASSERT_NOT_NULL(test, new_vc4_crtc_state);
+
+	old_channel = new_vc4_crtc_state->assigned_channel;
+	KUNIT_ASSERT_NE(test, old_channel, VC4_HVS_CHANNEL_DISABLED);
+
+	/* Make the enabled state the current one */
+	ret = drm_atomic_helper_swap_state(state, false);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+retry_second:
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	/*
+	 * Fill the state with defaults, like a DRM_MODE_ATOMIC_RESET
+	 * commit would, then re-apply the exact same configuration.
+	 */
+	ret = drm_atomic_commit_fill_with_defaults(NULL, state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_second;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_second;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_second;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	new_vc4_crtc_state = get_vc4_crtc_state_for_encoder(test, state,
+							    VC4_ENCODER_TYPE_HDMI0);
+	KUNIT_ASSERT_NOT_NULL(test, new_vc4_crtc_state);
+
+	KUNIT_EXPECT_EQ(test, new_vc4_crtc_state->assigned_channel, old_channel);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 static struct kunit_case vc5_pv_muxing_bugs_tests[] = {
 	KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable),
 	KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state),
 	KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_stable_fifo),
+	KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_created_state_keeps_channel),
 	{}
 };
 
 static struct kunit_suite vc5_pv_muxing_bugs_test_suite = {
 	.name = "vc5-pv-muxing-bugs",
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index ab551eb2da50..562f2d1f45a4 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -970,15 +970,27 @@ static int vc4_pv_muxing_atomic_check(struct drm_device *dev,
 
 		drm_dbg(dev, "%s: Trying to find a channel.\n", crtc->name);
 
 		/* Nothing to do here, let's skip it */
 		if (old_crtc_state->enable == new_crtc_state->enable) {
-			if (new_crtc_state->enable)
+			/*
+			 * A CRTC that stays enabled keeps its channel. A
+			 * duplicated state carries it over, but a state
+			 * created through atomic_create_state() comes with
+			 * the channel unset, so copy it from the current
+			 * state to make sure the core clock check and the
+			 * commit see the channel in use.
+			 */
+			if (new_crtc_state->enable) {
+				new_vc4_crtc_state->assigned_channel =
+					old_vc4_crtc_state->assigned_channel;
+
 				drm_dbg(dev, "%s: Already enabled, reusing channel %d.\n",
 					crtc->name, new_vc4_crtc_state->assigned_channel);
-			else
+			} else {
 				drm_dbg(dev, "%s: Disabled, ignoring.\n", crtc->name);
+			}
 
 			continue;
 		}
 
 		/* Muxing will need to be modified, mark it as such */

-- 
2.56.0

