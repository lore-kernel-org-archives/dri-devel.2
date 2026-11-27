Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A60606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxKoX9xV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB4411290D;
	Fri, 27 Nov 2026 09:53:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E981B10E6BD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:53:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDA344363C;
 Fri, 27 Nov 2026 09:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB5C1F000C1;
 Fri, 27 Nov 2026 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773206;
 bh=tGZm2gWI01B9Mji1HmZ5zX7NxiTxkQ/9LtOJv30XQTw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KxKoX9xVUal29D9JzrQojmdP6gP9mP/roXOi84LYD1Zu+rOmSs6cfTNPtG09KpVAh
 SGVE7jzhk0sqOvIHo7/Ufh2zdtZGCEzi2Z+fcp9eEKBf94m4R3PtT1fmqVF0eMDGQe
 TA0TmXx2wlLPcB0N/ok8hwLVoOqYjnImQZixSBAyHOo0QdSB2aQ2HTRYCBnTZNJdO+
 OvKDlQu9UjwqXE9lZWxy56wozqll9qwryUvG8o9P4ZO6aNmR246InD+B4q2q74ZRt4
 ebZRkI6DER0UuR8BcrdN5817S++Clau87aCeCI4Vy8yoa3GSBXUXkUBZUS/QVpLqqT
 pqAYHb7vGQ78w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:52:44 +0100
Subject: [PATCH v10 02/36] drm/tests: hdmi-state-helper: Handle EDEADLK in
 the 420-only test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-2-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
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
 h=from:subject:message-id; bh=nUzR9NzLF62I1kfaffkuO/syTHzbmSlVitSy83UXDAA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcQX+3RUzQ0Tm8qH/+lzuLlv7IEXqWaPLRyWbOgYwZR
 zhVXjQv6JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATOfScsWHFjNizwu0OJmei
 u5UX3WrrVejaohvuFtrfsvDFx9IpckzergfSjx7XPahx8PJFse8TFjE2nNSWf/5Zefe9mVFLDcV
 rr+1csT6Z893StjeP5Q5amtTmdP2cv3X7z116imrdhT9KNsneBAA=
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
index 35c551b4a35d..395a31171bd3 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -2399,35 +2399,49 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
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

