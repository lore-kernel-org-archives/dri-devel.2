Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F7606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AO2zzj+T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E2D1129D5;
	Fri, 20 Nov 2026 12:55:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD441129D0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69D7761F5A;
 Fri, 20 Nov 2026 12:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610841F000CF;
 Fri, 20 Nov 2026 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179329;
 bh=nZ/VfvSTA1uJZ90QtrWHqvgJ6Lu6zcDy8EVNrJUd16Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AO2zzj+ThbvtY5vdjLfUo8hnogO6VjsRvT8sifG+y6+pWsKWQE1GFr32Lg9wqNmJL
 kqAu2941JX3nWxIZT+vAUqBqa00iAwRh7vs8Vf2p7n6AfJz5YTyMMf6npMJbJJJxap
 MmpSM/izOU9o7PyBmI2k07rV0aQnCCnGMqAGneOkjnMyRzdOYCSbQGcRXy5NquNrmY
 ZVedkDnTGECzKpUvfvIbpL4oy2qQrsK4Mx1yeKKmodd8YWhPWM1Di4ySYKQkllNG0l
 eUi6sOA0m06frGf+BThlv0LgwEy1Bov55DYD5uiGg4wSnSbRK1cQMaKPWS+XGt94VM
 /uXPimvjglUyw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:54:55 +0100
Subject: [PATCH v9 03/42] drm/tests: hdmi-state-helper: Handle EDEADLK in
 the 420-only test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-3-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rPzDax1Zbhf6wi4o6GvTlKn9vO0UCOYhQN81KsSgGv0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzirbOIqf/dbVYBI86vpgU8OUS2JiQsdsZtzK1Yz87
 rXWeXpvx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIncuMdbZO11aHbyzi8O8q
 2DmzLMdfae1FnQjm1580YyNqP0/xe//Ne9k/9uVrKo9GaqxbssoliLHh5+Yf0o1Ve1ntGb5btCr
 zWyddvR04aW3iqaNtGhpiF78KtBukBLBvlGQ/z+/XxXA6Ph4A
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

The atomic state API is allowed to return -EDEADLK whenever the
wound/wait mutex code detects a deadlock, and the caller is then
expected to back off and restart the whole sequence.

drm_test_check_hdmi_color_format_420_only() wasn't doing any of that,
and reported a spurious failure when drm_atomic_set_crtc_for_connector()
returned -EDEADLK. Since the ticket ordering depends on the execution,
this could only be observed occasionally: the structurally identical
drm_test_check_hdmi_color_format() test hasn't been observed to fail so
far.

Add the usual backoff and restart pattern.

Fixes: f7235a4805a4 ("drm/tests: hdmi: Add tests for the color_format property")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 336bb644cb7c..aafe78b7cbbd 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -2398,35 +2398,49 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, dank);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
+retry:
 	conn_state = drm_atomic_get_connector_state(state, &priv->connector);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
 	conn_state->color_format = param->fmt;
 
 	ret = drm_atomic_set_crtc_for_connector(conn_state, priv->crtc);
+	if (ret == -EDEADLK)
+		goto backoff;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
+	if (IS_ERR(crtc_state) && PTR_ERR(crtc_state) == -EDEADLK)
+		goto backoff;
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 
 	ret = drm_atomic_set_mode_for_crtc(crtc_state, dank);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	crtc_state->enable = true;
 	crtc_state->active = true;
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto backoff;
 	KUNIT_EXPECT_EQ(test, ret, param->expected_ret);
 	if (!param->expected_ret)
 		KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, param->expected);
 
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
-};
+
+	return;
+
+backoff:
+	drm_atomic_commit_clear(state);
+	drm_modeset_backoff(&ctx);
+	goto retry;
+}
 
 static const struct color_format_test_param hdmi_color_format_420_only_params[] = {
 	{
 		.fmt = DRM_CONNECTOR_COLOR_FORMAT_RGB444,
 		.expected = DRM_OUTPUT_COLOR_FORMAT_RGB444,

-- 
2.56.1

