Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE5606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB8xHwrk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F941129DB;
	Fri, 20 Nov 2026 12:55:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2222D1129D4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09DD3441BF;
 Fri, 20 Nov 2026 12:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD6F1F000D3;
 Fri, 20 Nov 2026 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179333;
 bh=mAOg9cbA59SAaUTmOXI4dUEovS1i5/58CkVPY7xzSkU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BB8xHwrkPHP7wR0spacJYPD2uB3qk5fSyiCdfrZ6EjfYXLgop6fzQU2K9ZjTldUaQ
 l+NVFu+cLaCAwpmU3e0t7K3j3wJIXiskwFKOnOcbFa27CGGRrsiZiEGZhPe6kMNqDQ
 hYVct7PGaVtoL5oaUoZsyb9oLvLzYsb6y1OW1yJ5JBDq0Dj8Lj8Ec5ZJgTOMTVyujP
 htxSAQEUOcKw+yztO9gNSNbtVLd3v9CfYtQ5gZEnTvHUvYkfC4hELKQiDANXxnNMXC
 Zvhk69glNk8plDTOPU0p4q2uXmFdKxW2Z/7f6b0DbOokJt7pVwrXccg8XQtS0hG4iz
 SPxHHtPj8vXXg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:54:56 +0100
Subject: [PATCH v9 04/42] drm/tests: hdmi-state-helper: Handle EDEADLK in
 the color format test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-4-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ETUGIvdl6CvVQHMhX2UxuefRLnRXMXupcWdJLk8SOi4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMziquG22U1H80N164avi4QP0u3yqzHvUJR1qE0o4dz
 d29+mRZx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIfQdjnfE+uXXPJ/N3TvaV
 TD3WWOS83eqz6loWL7twM42ec7rBbvbpfx8qVi7WmJ7263/whC/TGOusjaw6zr4PP7zO9tzCw4+
 TdnJ/k54TtjRX5fkjJRfRPO+N09e8TLHiWatw5/P664fWbrMCAA==
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

drm_test_check_hdmi_color_format() wasn't doing any of that, and
reported a spurious failure when drm_atomic_set_crtc_for_connector()
returned -EDEADLK, just like its 420-only counterpart fixed earlier.
Since the ticket ordering depends on the execution, this could only be
observed occasionally.

The assertion also aborted before the locking context could be
released, leaving connection_mutex held when the device was released,
which drm_modeset_lock_fini() then reported through
drm_mode_config_cleanup().

Add the usual backoff and restart pattern.

Fixes: f7235a4805a4 ("drm/tests: hdmi: Add tests for the color_format property")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index aafe78b7cbbd..8e3e9bb4a202 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -2295,33 +2295,47 @@ static void drm_test_check_hdmi_color_format(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, drm_mode_is_420(info, preferred));
 
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
 
 	ret = drm_atomic_set_mode_for_crtc(crtc_state, preferred);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	crtc_state->enable = true;
 	crtc_state->active = true;
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto backoff;
 	KUNIT_EXPECT_EQ(test, ret, param->expected_ret);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, param->expected);
 
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
+
+	return;
+
+backoff:
+	drm_atomic_commit_clear(state);
+	drm_modeset_backoff(&ctx);
+	goto retry;
 }
 
 static const struct color_format_test_param hdmi_color_format_params[] = {
 	{
 		.fmt = DRM_CONNECTOR_COLOR_FORMAT_AUTO,

-- 
2.56.1

