Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B47606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRdVmR1S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4697B10F48B;
	Tue, 24 Nov 2026 11:00:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DAB10F47C;
 Tue, 24 Nov 2026 11:00:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3240A62605;
 Tue, 24 Nov 2026 11:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6FF1F000D0;
 Tue, 24 Nov 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795518007;
 bh=6vv0v5aQpbVQLcB4ol0btLOmKdHCUhyhrThlHyI6xWE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aRdVmR1SrzMAOOjHJJBA8p3KZUFPqG3ZwJtmzoUrwUJfSq9VUZQjsGI4AkZ5KMvrw
 RENRQPG5xeLKG9buGw8jjYGnAe4lWCdOwobCDw5Z1/TZcrvRjp+g6b4nkQCdW8kyBa
 Z89gQIH03y/1qbRNGmdJI/ympUItQCogXkk2FcbRz4s0sO0Thr9MqjNTVwCbkVB4GQ
 3NnCYKLgK5WdI1z+MMRGs4GUpN5re7Wcd5H8jqDJKu7cyXl94dIZ/Z2Li68bh5t4M2
 TEIG49oszaG2zGi8vGD+DL3NclQUi5tvZoq6KttuXTN3inSvqYE7eXaKd7geRfgX2s
 0lABldw+Ais6Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 24 Nov 2026 11:59:51 +0100
Subject: [PATCH 1/6] drm/atomic-state-helper: Provide more STATE_CHECK_*
 variants
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-drm-i915-conversion-state-readout-v1-1-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8445; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0Rxxbo/JPNem+2NeBB6VdOHieDVZV2FSEso2vSdBOUg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmseTpLBPi0Jd/q/NmgfcIud52gYG8NU1fX4uVb6yoMx
 KPy4x91TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIkI8TA2HD7ot+Vj48I3505d
 LX1c0RlzqX3P8Z7SLdxCl7zSjU595uJZtje5XKLIiOlhptpB+f8zGOsjGZlS0zwlH3fzcSksKSu
 x4FLcdHbu3iR7bckHgfv23PWdW/In7URq/0cnvenTEta//wcA
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The STATE_CHECK_* macros cover the field types the core state
structures hold, but driver private states also rely on enums and on
integer types smaller than an int, none of which the typed variants
accept: STATE_CHECK_S32() and its counterparts assert on the exact
field type, and there is no u8 variant at all.

Provide STATE_CHECK_U8(), STATE_CHECK_U8_X() and STATE_CHECK_U16_X()
to complete the set of fixed width integer variants, and
STATE_CHECK_ENUM() for the enum fields: their underlying type is
chosen by the compiler, so they can't be matched to a fixed width
variant, and whether they end up signed depends on their enumerators.

The i915 pipe configuration state compares close to two hundred
fields spread over all of those types.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 .../gpu/drm/tests/drm_atomic_state_readout_test.c  | 99 ++++++++++++++++++++++
 include/drm/drm_atomic_state_readout_helper.h      | 66 +++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c b/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c
index 289187ec4359..a2d18d44e76c 100644
--- a/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c
@@ -1753,10 +1753,107 @@ static void drm_test_sro_compare_bridge_mismatch(struct kunit *test)
 
 	priv->bridge.funcs->atomic_destroy_state(&priv->bridge, state1);
 	priv->bridge.funcs->atomic_destroy_state(&priv->bridge, state2);
 }
 
+/*
+ * A state with plain integer fields, to exercise the STATE_CHECK_*
+ * macros on the types the base state structures don't hold but driver
+ * private states commonly do: enums, whose signedness the compiler
+ * picks, and integers smaller than an int.
+ */
+enum state_check_enum {
+	STATE_CHECK_FIRST,
+	STATE_CHECK_SECOND,
+};
+
+struct state_check_state {
+	int s32;
+	enum state_check_enum enumerated;
+	u8 decimal_u8;
+	u8 hex_u8;
+	u16 decimal_u16;
+	u16 hex_u16;
+	u32 decimal_u32;
+	u32 hex_u32;
+};
+
+static bool
+state_check_state_compare(struct drm_printer *p,
+			  const struct state_check_state *a,
+			  const struct state_check_state *b)
+{
+	bool ret = true;
+
+	STATE_CHECK_S32(ret, p, "test", a, b, s32);
+	STATE_CHECK_ENUM(ret, p, "test", a, b, enumerated);
+	STATE_CHECK_U8(ret, p, "test", a, b, decimal_u8);
+	STATE_CHECK_U8_X(ret, p, "test", a, b, hex_u8);
+	STATE_CHECK_U16(ret, p, "test", a, b, decimal_u16);
+	STATE_CHECK_U16_X(ret, p, "test", a, b, hex_u16);
+	STATE_CHECK_U32(ret, p, "test", a, b, decimal_u32);
+	STATE_CHECK_U32_X(ret, p, "test", a, b, hex_u32);
+
+	return ret;
+}
+
+/*
+ * Test that the STATE_CHECK_* macros report states whose enum, u8,
+ * u16 and u32 fields all match as identical.
+ */
+static void drm_test_sro_compare_macros_identical(struct kunit *test)
+{
+	struct state_check_state a = {}, b = {};
+	struct drm_printer *p;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	a.s32 = b.s32 = -42;
+	a.enumerated = b.enumerated = STATE_CHECK_SECOND;
+	a.decimal_u8 = b.decimal_u8 = 3;
+	a.hex_u8 = b.hex_u8 = 0xa5;
+	a.decimal_u16 = b.decimal_u16 = 1000;
+	a.hex_u16 = b.hex_u16 = 0x5a5a;
+	a.decimal_u32 = b.decimal_u32 = 100000;
+	a.hex_u32 = b.hex_u32 = 0xdeadbeef;
+
+	KUNIT_EXPECT_TRUE(test, state_check_state_compare(p, &a, &b));
+}
+
+/*
+ * Test that the STATE_CHECK_* macros report states differing in any
+ * of their enum, u8, u16 and u32 fields as non-identical.
+ */
+static void drm_test_sro_compare_macros_mismatch(struct kunit *test)
+{
+	struct state_check_state a = {}, b = {};
+	struct drm_printer *p;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	a.s32 = -1;
+	b.s32 = -2;
+	a.enumerated = STATE_CHECK_FIRST;
+	b.enumerated = STATE_CHECK_SECOND;
+	a.decimal_u8 = 1;
+	b.decimal_u8 = 2;
+	a.hex_u8 = 0xf0;
+	b.hex_u8 = 0x0d;
+	a.decimal_u16 = 1;
+	b.decimal_u16 = 2;
+	a.hex_u16 = 0x1234;
+	b.hex_u16 = 0x4321;
+	a.decimal_u32 = 1;
+	b.decimal_u32 = 2;
+	a.hex_u32 = 0xf00d;
+	b.hex_u32 = 0xbeef;
+
+	KUNIT_EXPECT_FALSE(test, state_check_state_compare(p, &a, &b));
+}
+
 static struct kunit_case drm_atomic_sro_compare_tests[] = {
 	KUNIT_CASE(drm_test_sro_compare_plane_identical),
 	KUNIT_CASE(drm_test_sro_compare_plane_mismatch),
 	KUNIT_CASE(drm_test_sro_compare_plane_cropped),
 	KUNIT_CASE(drm_test_sro_compare_crtc_identical),
@@ -1764,10 +1861,12 @@ static struct kunit_case drm_atomic_sro_compare_tests[] = {
 	KUNIT_CASE(drm_test_sro_compare_crtc_active_mismatch),
 	KUNIT_CASE(drm_test_sro_compare_connector_identical),
 	KUNIT_CASE(drm_test_sro_compare_connector_mismatch),
 	KUNIT_CASE(drm_test_sro_compare_bridge_identical),
 	KUNIT_CASE(drm_test_sro_compare_bridge_mismatch),
+	KUNIT_CASE(drm_test_sro_compare_macros_identical),
+	KUNIT_CASE(drm_test_sro_compare_macros_mismatch),
 	{ }
 };
 
 static struct kunit_suite drm_atomic_sro_compare_test_suite = {
 	.name = "drm_atomic_sro_compare",
diff --git a/include/drm/drm_atomic_state_readout_helper.h b/include/drm/drm_atomic_state_readout_helper.h
index 6125ea668fa8..628222274aff 100644
--- a/include/drm/drm_atomic_state_readout_helper.h
+++ b/include/drm/drm_atomic_state_readout_helper.h
@@ -198,10 +198,60 @@ drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
 							       sa->f, sb->f); \
 			r = false;					\
 		}							\
 	} while (0)
 
+#define STATE_CHECK_ENUM(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(!__same_type(sa->f, bool),		\
+			      __stringify(f) " is a bool");		\
+		static_assert(sizeof(sa->f) <= sizeof(int),		\
+			      __stringify(f) " doesn't fit in an int");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %d, got %d", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U8(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u8)0),		\
+			      __stringify(f) " is not a u8");		\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %u, got %u", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U8_X(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u8)0),		\
+			      __stringify(f) " is not a u8");		\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %02x, got %02x", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
 #define STATE_CHECK_U16(r, p, n, sa, sb, f)				\
 	do {								\
 		static_assert(__same_type(sa->f, sb->f),		\
 			      __stringify(f) " field types don't match"); \
 		static_assert(__same_type(sa->f, (u16)0),		\
@@ -214,10 +264,26 @@ drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
 							       sa->f, sb->f); \
 			r = false;					\
 		}							\
 	} while (0)
 
+#define STATE_CHECK_U16_X(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u16)0),		\
+			      __stringify(f) " is not a u16");		\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %04x, got %04x", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
 #define STATE_CHECK_U32(r, p, n, sa, sb, f)				\
 	do {								\
 		static_assert(__same_type(sa->f, sb->f),		\
 			      __stringify(f) " field types don't match"); \
 		static_assert(__same_type(sa->f, (u32)0),		\

-- 
2.56.1

