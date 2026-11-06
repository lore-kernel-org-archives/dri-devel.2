Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10859606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRAdhyx0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E78E10E929;
	Fri,  6 Nov 2026 13:14:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA2010E929
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:14:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F432605F2;
 Fri,  6 Nov 2026 13:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A0E1F008A2;
 Fri,  6 Nov 2026 13:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970893;
 bh=28UHQ+RZ8hiPqkFaA0MrPlgxaXOlwBlnapyQE8hTxCQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JRAdhyx0cUI4BwZqg6JR1/H1KJI2/HqU2jU/+2EFZ+7SbIqGgy5KXN5ThUKnKUQgi
 qEuAnOecWPv6QxSbjxx0bpPyaOTFAeb1DYCbjHtkJMnAYPI0zziTdRsM7B3UPZoJts
 x5+X2/7zhqA5haz4YqaqgClwVsr68cslJcHMbmzzxMhuo/2wSCdJlfPszfH3gJ3Tic
 6xpO05Qc5kggK1FW23Hbyytz2GAfJMAYoamuQOpMvUJxdhb1PJNRDc1icsIdZ7eBfR
 sXAAIl8hNtJbNzn5dhJAsof2VCDFSqw0ehtifw9Y8r7z/CYBisx0fzfxa/F7BnE2Kg
 0XT7iAjJQwX1Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:16 +0100
Subject: [PATCH v8 03/39] drm/tests: hdmi-state-helper: Handle EDEADLK in
 the 420-only test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-3-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513; i=mripard@kernel.org;
 h=from:subject:message-id; bh=agoltBorFEhSqHDKMeT782YKhOrc7jYDkJ/DKCLkPLs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL607rLB9U3jp7x3Oewsdj+v8dQvmmsGYq63y4Pmlq
 jPxLJXMHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BeAi8YwNu6tDNP5Nu8qU2fBt
 04kvPzd5Tco89uzb0lkfGD69OsvCYGmp++qov87m+X1bj4aHfXDyZ2w4tE4s7qrF2ltp/t4f4yT
 tHy6bdjd8/88F+6d+eiF/rqDz3qHjWwqC2j8Wb4lp+G4kvf4PAA==
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
index 99a0fa479704..63d6f8bf1396 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -2403,4 +2403,5 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
+retry:
 	conn_state = drm_atomic_get_connector_state(state, &priv->connector);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
@@ -2409,7 +2410,11 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
 
 	ret = drm_atomic_set_crtc_for_connector(conn_state, priv->crtc);
+	if (ret == -EDEADLK)
+		goto backoff;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
+	if (IS_ERR(crtc_state) && PTR_ERR(crtc_state) == -EDEADLK)
+		goto backoff;
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 
@@ -2421,4 +2426,6 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto backoff;
 	KUNIT_EXPECT_EQ(test, ret, param->expected_ret);
 	if (!param->expected_ret)
@@ -2427,5 +2434,12 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
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

-- 
2.55.0

