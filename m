Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE47606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SCcsLIaR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1994B10E8B6;
	Sat, 14 Nov 2026 19:32:21 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB8010E5E3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 19:32:14 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso821587f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794684733; x=1795289533; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sI3Abw782ICodBFXVcAkqffcR+yD9cYQ88bcpAcT5c4=;
 b=SCcsLIaRkkW52LsXsPHMILcKrWzBi7YGu61Z7uwketjADdgYH9BFgLZhSZydOvVrbE
 lRns573cPStKTjXGWFxYfY4N4KSCJH/TfwcYK4HM+IKss5DCdJaZpYQ+fkko54US06xz
 WxdzjK/1JOn+p/D+TBFsLHdKRVECUT3urgowcu1wwjcrPGa7JtMCA9WmkIKqRqQJnPvS
 5LuR8YiLHPSmzscz3tAWtGM9pAR4DlClVHSDBRd5Mcj+ENpuLhpmf2UOk69FBj7hwRFM
 krjPqN6qgKkIiAXPtFy0ogw8yq7nOuR3YZC3U4/crDhF5WKF+pYIY5yIEpc8IFurCOQQ
 psGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794684733; x=1795289533;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sI3Abw782ICodBFXVcAkqffcR+yD9cYQ88bcpAcT5c4=;
 b=m3zImbFZ19RD/UGQni2Z7sLSE1fIlOpibKYGh/28dXvM437ibkxx7ok254c2Sncfgd
 OqjXTAogm3oprG/Q3uIqFq4uH6I/T3rC9vnR+336RqZ1Z9rgENnoZeoVbzAKoT8C3mtw
 bNYv1HfvJeSDX+Y6PKBER3g+os8mM00PKcWuPNNC/idiEDY0DGdm5Lo7iouYXnhB6L89
 VATMvdjRf1E+K2J/FpvGuDrgaTS//HP+xs0AFamorR+fWpom8Lp8Y5zkYqlmvC19fPyp
 HGJX1DUeevhUUcJSUPPo4uX9+4luoZwcOYUgmqB+G6/N+qTzCTUwZNnBPOAQcFnwOArv
 6w6Q==
X-Gm-Message-State: APuU4Z9giLchi9sNSmWoLz11hWIuZUd/S0EbhipP22+MfGj5Qc2Xkm4c
 8GVlFTYiTkrohfUZ7BWZgmQ3RlE5FVluRX8QW29v5hkOwy/AMRQ4pVvHvYq5gdDU
X-Gm-Gg: AYBFou3ULsLhOj/OSr4CMnqxS7eEG8sJhCx9ypC426H8eS24kRjSvYeQPQZeiMRxD/E
 EJhQP9AGodkxMUMhWPXwlsUXfcFggNJ6VkF6oV8xUOIYVfX+XOjqk+Pq6DJHgyKPnBuxm2M/fci
 X4uR67Wto5T4sE5KBRQpkozyzO4f4jtBLnOOBknHn46rQieXpG5OPG+rW4iGmb6wObXmpCeTzsZ
 BLEApFgIuDYKETb3PZn1/9/Xmv0SgrtIzA/vKkPLKrK//k9+HKxztEm6mbk751CI4cjmfmeAqKv
 rr7oBNoySZL4A/DTwSDNhxpZ2P92ATveCRDjgTZpH0LFgx6w6XfSlxhDGLvtyGqzh51QW+ZrKM1
 4U1f16/t2jkiV7oCOJivmDbJqpecak/dIlDjll9XwBMmjBohLDYGTiujwfAWXvYA9/P1drmPPiq
 YDStbIYGIMvxY1f5OKIhEChqp9SigvSZmhBS1Wr/3ks3NthVQ7MGn2SHx62wt4uZsF2muu/IltS
 XD/OGjuYypl7+QreabYnJnEQlPluVobeMUVNuBX0jtVBOgy9NQ2i9jCAVixaM0cS9RyC0SN0wJe
 G4rLNvxh4F4G1Qrr3WDznllNenVmF9pqF/oQBrLXNg==
X-Received: by 2002:a05:6000:29c9:b0:493:1004:96f7 with SMTP id
 ffacd0b85a97d-49c747700f2mr8953180f8f.54.1794684732494; 
 Sat, 14 Nov 2026 11:32:12 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608cf46dsm12965021f8f.43.2026.11.14.11.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 11:32:11 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Sat, 14 Nov 2026 20:32:02 +0100
Subject: [PATCH] drm/tests: bridge: check the bridge chain callback order
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-bridge-order-v1-1-4f11d1c21937@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5AMBCE4VeRPWuiiIhXEQdtp6wDskUk4t0Vx
 2+S+S8KEEagJrlIcHDgZY7QaUJ27OcBil005Vleaa0LZYRdXBdxEIXal/AmM7UHxcsq8Hx+ubb
 7HXYzwW5vg+77AeKZY3dwAAAA
X-Change-ID: 20261113-bridge-order-e8f4efb0b8fe
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_atomic_bridge_chain_pre_enable() and
drm_atomic_bridge_chain_post_disable() document the order in which a
chain's bridges get their callback called, but nothing tests it. That
order has been wrong before: commit e18aeeda0b69 had to fix both
directions at once.

Add a KUnit test for the example those comments give, and for the chain
where no bridge sets @pre_enable_prev_first.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 112 ++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 15583ade8494..e910f22ee581 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -20,6 +20,9 @@
 
 #include "drm_kunit_edid.h"
 
+/* Chain length of the callback order test, and size of its call log. */
+#define DRM_TEST_BRIDGE_CHAIN_LEN 5
+
 /*
  * Mimick the typical "private" struct defined by a bridge driver, which
  * embeds a bridge plus other fields.
@@ -31,6 +34,8 @@ struct drm_bridge_priv {
 	unsigned int enable_count;
 	unsigned int disable_count;
 	struct drm_bridge bridge;
+	/* Position in the chain, as an index into test_bridges */
+	unsigned int chain_index;
 	void *data;
 };
 
@@ -59,6 +64,11 @@ struct drm_bridge_chain_priv {
 	 *                of which the first @num_bridges entries are valid.
 	 */
 	struct drm_bridge_priv **test_bridges;
+
+	/** @call_log: @test_bridges indices of the bridges whose function was called, in order */
+	unsigned int call_log[DRM_TEST_BRIDGE_CHAIN_LEN];
+	/** @call_log_len: number of calls logged, may exceed the size of @call_log */
+	unsigned int call_log_len;
 };
 
 static struct drm_bridge_priv *bridge_to_priv(struct drm_bridge *bridge)
@@ -99,6 +109,27 @@ static const struct drm_bridge_funcs drm_test_bridge_atomic_funcs = {
 	.atomic_create_state	= drm_atomic_helper_bridge_create_state,
 };
 
+/* @data points to the drm_bridge_chain_priv for bridges using these funcs */
+static void drm_test_bridge_chain_atomic_log(struct drm_bridge *bridge,
+					     struct drm_atomic_commit *state)
+{
+	struct drm_bridge_priv *bridge_priv = bridge_to_priv(bridge);
+	struct drm_bridge_chain_priv *priv = bridge_priv->data;
+
+	if (priv->call_log_len < ARRAY_SIZE(priv->call_log))
+		priv->call_log[priv->call_log_len] = bridge_priv->chain_index;
+
+	priv->call_log_len++;
+}
+
+static const struct drm_bridge_funcs drm_test_bridge_chain_funcs = {
+	.atomic_pre_enable	= drm_test_bridge_chain_atomic_log,
+	.atomic_post_disable	= drm_test_bridge_chain_atomic_log,
+	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
+	.atomic_create_state	= drm_atomic_helper_bridge_create_state,
+};
+
 static int dummy_clear_infoframe(struct drm_bridge *bridge)
 {
 	return 0;
@@ -459,6 +490,7 @@ drm_test_bridge_chain_init(struct kunit *test, unsigned int num_bridges,
 		return ERR_PTR(-ENOMEM);
 
 	priv->num_bridges = num_bridges;
+	priv->call_log_len = 0;
 
 	for (i = 0; i < num_bridges; i++) {
 		priv->test_bridges[i] = devm_drm_bridge_alloc(dev, struct drm_bridge_priv,
@@ -467,6 +499,7 @@ drm_test_bridge_chain_init(struct kunit *test, unsigned int num_bridges,
 			return ERR_CAST(priv->test_bridges[i]);
 
 		priv->test_bridges[i]->data = priv;
+		priv->test_bridges[i]->chain_index = i;
 	}
 
 	priv->plane = drm_kunit_helper_create_primary_plane(test, drm, NULL, NULL,
@@ -1357,6 +1390,84 @@ static void drm_test_bridge_rgb_yuv_no_path(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/* B, D and E ask for prev first: the example the documentation gives. */
+static const bool bde_prev_first[DRM_TEST_BRIDGE_CHAIN_LEN] = { false, true, false, true, true };
+static const unsigned int bde_pre_enable[DRM_TEST_BRIDGE_CHAIN_LEN] = { 2, 3, 4, 0, 1 };
+static const unsigned int bde_post_disable[DRM_TEST_BRIDGE_CHAIN_LEN] = { 1, 0, 4, 3, 2 };
+
+/* No bridge does: both walks are plain reversals. */
+static const bool none_prev_first[DRM_TEST_BRIDGE_CHAIN_LEN] = { false };
+static const unsigned int none_pre_enable[DRM_TEST_BRIDGE_CHAIN_LEN] = { 4, 3, 2, 1, 0 };
+static const unsigned int none_post_disable[DRM_TEST_BRIDGE_CHAIN_LEN] = { 0, 1, 2, 3, 4 };
+
+/* Order documented by drm_atomic_bridge_chain_pre_enable()/_post_disable(). */
+static void drm_test_bridge_chain_order(struct kunit *test,
+					const bool *prev_first,
+					const unsigned int *expected_pre_enable,
+					const unsigned int *expected_post_disable)
+{
+	static const struct drm_bridge_funcs *funcs[DRM_TEST_BRIDGE_CHAIN_LEN] = {
+		&drm_test_bridge_chain_funcs,
+		&drm_test_bridge_chain_funcs,
+		&drm_test_bridge_chain_funcs,
+		&drm_test_bridge_chain_funcs,
+		&drm_test_bridge_chain_funcs,
+	};
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_bridge_chain_priv *priv;
+	struct drm_atomic_commit *state;
+	unsigned int i;
+
+	priv = drm_test_bridge_chain_init(test, ARRAY_SIZE(funcs), funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	for (i = 0; i < ARRAY_SIZE(funcs); i++)
+		priv->test_bridges[i]->bridge.pre_enable_prev_first = prev_first[i];
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	/* The chain helpers skip the callbacks when @state is NULL. */
+	state = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	drm_atomic_bridge_chain_pre_enable(&priv->test_bridges[0]->bridge, state);
+	KUNIT_ASSERT_EQ(test, priv->call_log_len, DRM_TEST_BRIDGE_CHAIN_LEN);
+	KUNIT_EXPECT_MEMEQ(test, priv->call_log, expected_pre_enable,
+			   sizeof(priv->call_log));
+
+	priv->call_log_len = 0;
+	drm_atomic_bridge_chain_post_disable(&priv->test_bridges[0]->bridge, state);
+	KUNIT_ASSERT_EQ(test, priv->call_log_len, DRM_TEST_BRIDGE_CHAIN_LEN);
+	KUNIT_EXPECT_MEMEQ(test, priv->call_log, expected_post_disable,
+			   sizeof(priv->call_log));
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+static void drm_test_bridge_chain_callback_order(struct kunit *test)
+{
+	drm_test_bridge_chain_order(test, bde_prev_first, bde_pre_enable,
+				    bde_post_disable);
+}
+
+static void drm_test_bridge_chain_callback_order_no_flags(struct kunit *test)
+{
+	drm_test_bridge_chain_order(test, none_prev_first, none_pre_enable,
+				    none_post_disable);
+}
+
+static struct kunit_case drm_bridge_chain_tests[] = {
+	KUNIT_CASE(drm_test_bridge_chain_callback_order),
+	KUNIT_CASE(drm_test_bridge_chain_callback_order_no_flags),
+	{ }
+};
+
+static struct kunit_suite drm_bridge_chain_test_suite = {
+	.name = "drm_bridge_chain",
+	.test_cases = drm_bridge_chain_tests,
+};
+
 static struct kunit_case drm_bridge_bus_fmt_tests[] = {
 	KUNIT_CASE(drm_test_bridge_rgb_yuv_rgb),
 	KUNIT_CASE(drm_test_bridge_must_convert_to_yuv444),
@@ -1376,6 +1487,7 @@ kunit_test_suites(
 	&drm_bridge_helper_reset_crtc_test_suite,
 	&drm_bridge_alloc_test_suite,
 	&drm_bridge_bus_fmt_test_suite,
+	&drm_bridge_chain_test_suite,
 );
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");

---
base-commit: c88084027d0e922dd925b96e5a0d184ba04a8f43
change-id: 20261113-bridge-order-e8f4efb0b8fe

Best regards,
--  
Oarora Etimis <oaroraetimis@gmail.com>

