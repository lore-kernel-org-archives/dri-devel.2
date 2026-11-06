Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0D606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kU7IEjGW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5769A10EA07;
	Fri,  6 Nov 2026 13:15:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34D810EA04
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:14:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC4C542488;
 Fri,  6 Nov 2026 13:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367041F008A2;
 Fri,  6 Nov 2026 13:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970896;
 bh=IK9jMSaDEIrN5MyP3YzzyErMrBftsipsty2biW/p+SA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kU7IEjGWn80xg2wWQRk+jPLi/jcUrG7DWh3tunB9TqLb+WY3euj2dnZRO9H8/n2Kh
 vRilPSUPo2CqYgmjgn34idEqb4yoUncIrvU6hpV9BxzA96jmnrvxaMLfT+mQzhPHNY
 YelgUW1WhaHXhJOJXtDusdozKZB9WSbBzWN7Z81wFaxiuMkMdhfqUbCLgc4Ea+nZbd
 9gwoq1aEA1jdlsD4se6IhlRLczW1YhPRs02exHF8ntxoYozB/Vk+drAaD98OAr7nZI
 vKTB6Fm0JAq6HixsB41p9OLiggJ1rdZOZRAp35tzN/6gWX1UQtXgsk5yx/KTPZkXQ7
 MKcp2RxoLJKAQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:17 +0100
Subject: [PATCH v8 04/39] drm/tests: hdmi-state-helper: Handle EDEADLK in
 the color format test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-4-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Ou6p+9s1xTKPHWVMx9w3aCNoSyhYVPZRac2eDsEQq28=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL607x3xvT+kym+nT7XunJK/29RU6Zar1IKmtJV/z9
 PmpLkdfdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ3PVlbOi9z2y4+2HQ76yH
 z1ZXPuNtucGfM6F/zazXPCL7/iwRunS7MTHiRLm2NUtOiqFHseGGM4wNMw6e+bFp6+qTS4purmb
 ZIDnJ/c9O/8UfnCpnW7WeSIqKSg//JHXu1c1rBcnXnnckyHbUAQA=
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

Add the usual backoff and restart pattern, and remove a stray
semicolon at the end of drm_test_check_hdmi_color_format_420_only().

Fixes: f7235a4805a4 ("drm/tests: hdmi: Add tests for the color_format property")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 63d6f8bf1396..a4dad1f5bfc0 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -2300,4 +2300,5 @@ static void drm_test_check_hdmi_color_format(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
+retry:
 	conn_state = drm_atomic_get_connector_state(state, &priv->connector);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
@@ -2306,7 +2307,11 @@ static void drm_test_check_hdmi_color_format(struct kunit *test)
 
 	ret = drm_atomic_set_crtc_for_connector(conn_state, priv->crtc);
+	if (ret == -EDEADLK)
+		goto backoff;
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
+	if (IS_ERR(crtc_state) && PTR_ERR(crtc_state) == -EDEADLK)
+		goto backoff;
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 
@@ -2318,4 +2323,6 @@ static void drm_test_check_hdmi_color_format(struct kunit *test)
 
 	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK)
+		goto backoff;
 	KUNIT_EXPECT_EQ(test, ret, param->expected_ret);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, param->expected);
@@ -2323,4 +2330,11 @@ static void drm_test_check_hdmi_color_format(struct kunit *test)
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
 

-- 
2.55.0

