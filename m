Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE474606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dH+IhPf6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F250110EAED;
	Fri,  6 Nov 2026 13:16:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE6610EAED
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 366AB4395A;
 Fri,  6 Nov 2026 13:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4781F008A1;
 Fri,  6 Nov 2026 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970969;
 bh=xyXUwhrg9ImOa/JC5J1Wxl+85IvRWVt3MrsPokCrqcA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dH+IhPf6dChVVBUn+EAXIa2DzmzNdCLqfkzHkQxtPAam9u5gS37JF23VCQzgv9W10
 e/CN8mqAei6DSBNx5FEw5GiaqWfhOit5ApBTVbRoS4T20/cyl9EB11BY/1UGLH2Laa
 AtFzA987zD0w+rdXZ4FZR6mmFMXxZLZffGQC0gBxPEsU1cuXpI7JXp5J8YkepzWdjJ
 DsHPo1nH+BI4mhpy0YJGBlcfU4ud+gZDhMA+63BIFId4CFGQYX11sXuebprzY05pZk
 Q0LQmq1fp1ymWLD9iOwVzQ/uGZmBViwJ9UMaAVTxSpvd27zk665Z/+A78mrXJWvNu7
 uBMLPw6Bv5anQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:37 +0100
Subject: [PATCH v8 24/39] drm/atomic-state-helper: Provide comparison
 macros
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-24-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10212; i=mripard@kernel.org;
 h=from:subject:message-id; bh=njz1h97G0vB7yH/8DOkXJhjPvFyq83fBJ5WuvDp3tKw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL23/7slzpmN+1utXX13ez2d4J3P9a/4pgdPm7yytD
 hb/69De3zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmEn+bseHk35bowlBW7s8M
 7B+PF9vOztSMf8E/Z3PJnz1XFDiZ7OWtuzWjyt60Lj8uZHl7tuqCRMYarglvXm6zFdrzXH8C+8e
 pD6cpqtyQ9c5pEEq7Ot1k/r+Kj4wy3hr1u26c5q4tv3r/jZ0+AA==
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

In order to make the implementation of atomic_sro_compare_state easier
and reduce the boilerplate, introduce a set of STATE_CHECK_* macros to
compare state field values depending on their type.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_readout_helper.c |  30 +++
 include/drm/drm_atomic_state_readout_helper.h     | 220 ++++++++++++++++++++++
 2 files changed, 250 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
index 1b6cf304702c..4156f3a27f04 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
@@ -788,2 +788,32 @@ int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_atomic_helper_sro_readout_state);
+
+/**
+ * drm_atomic_helper_print_state_mismatch - report a state comparison mismatch
+ * @p: printer to report through
+ * @name: human-readable name of the object (e.g. plane or CRTC name)
+ * @field: name of the mismatching field
+ * @format: printf-style format string describing the mismatch
+ *
+ * Helper used by atomic_sro_compare_state implementations and the
+ * STATE_CHECK_* macros to report a field-level mismatch between the
+ * committed state and the state read back from hardware.
+ */
+void __printf(4, 5)
+drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
+				       const char *name,
+				       const char *field,
+				       const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	drm_printf(p, "%s configuration mismatch in %s %pV\n", name, field, &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(drm_atomic_helper_print_state_mismatch);
diff --git a/include/drm/drm_atomic_state_readout_helper.h b/include/drm/drm_atomic_state_readout_helper.h
index d685644ec25a..d4e941ab7452 100644
--- a/include/drm/drm_atomic_state_readout_helper.h
+++ b/include/drm/drm_atomic_state_readout_helper.h
@@ -4,7 +4,10 @@
 #define DRM_ATOMIC_SRO_HELPER_H_
 
+#include <linux/string_choices.h>
+
 struct drm_atomic_commit;
 struct drm_atomic_sro_state;
 struct drm_device;
+struct drm_printer;
 
 int
@@ -33,3 +36,220 @@ drm_atomic_helper_sro_build_state(struct drm_device *dev,
 int drm_atomic_helper_sro_readout_state(struct drm_device *dev);
 
+void __printf(4, 5)
+drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
+				       const char *name,
+				       const char *field,
+				       const char *format, ...);
+
+#define STATE_CHECK_BOOL(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, bool),			\
+			      __stringify(f) " is not a bool");		\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %s, got %s", \
+							       str_yes_no(sa->f), \
+							       str_yes_no(sb->f)); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_DISPLAY_MODE(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, struct drm_display_mode), \
+			      __stringify(f) " is not a drm_display_mode structure"); \
+		if (!drm_mode_equal(&sa->f, &sb->f)) {			\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected " DRM_MODE_FMT ", got " DRM_MODE_FMT, \
+							       DRM_MODE_ARG(&sa->f), \
+							       DRM_MODE_ARG(&sb->f)); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_INFOFRAME(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, union hdmi_infoframe), \
+			      __stringify(f) " is not an hdmi_infoframe union"); \
+		if (memcmp(&sa->f, &sb->f, sizeof(union hdmi_infoframe))) { \
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "infoframes don't match"); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_FORMAT_INFO(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, const struct drm_format_info *), \
+			      __stringify(f) " is not a drm_format_info pointer"); \
+		if (sa->f != sb->f) {			\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %p4cc, got %p4cc", \
+							       sa->f ? &sa->f->format : NULL, \
+							       sb->f ? &sb->f->format : NULL); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_PROPERTY_BLOB(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, struct drm_property_blob *), \
+			      __stringify(f) " is not a drm_property_blob pointer"); \
+		if (sa->f != sb->f &&					\
+		    (!sa->f || !sb->f ||				\
+		     sa->f->length != sb->f->length ||			\
+		     memcmp(sa->f->data, sb->f->data, sa->f->length))) { \
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "blobs don't match"); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_PTR(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %p, got %p",	\
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_S32(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (s32)0),		\
+			      __stringify(f) " is not an s32");		\
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
+#define STATE_CHECK_S32_X(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (s32)0),		\
+			      __stringify(f) " is not an s32");		\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %x, got %x", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U16(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u16)0),		\
+			      __stringify(f) " is not a u16");		\
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
+#define STATE_CHECK_U32(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u32)0),		\
+			      __stringify(f) " is not a u32");		\
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
+#define STATE_CHECK_U32_16_16(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u32)0),		\
+			      __stringify(f) " is not a u32");		\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %d.%06u, got %d.%06u", \
+							       sa->f >> 16, ((sa->f & 0xffff) * 15625) >> 10, \
+							       sb->f >> 16, ((sb->f & 0xffff) * 15625) >> 10); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U32_X(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u32)0),		\
+			      __stringify(f) " is not a u32");		\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %08x, got %08x", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U64(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u64)0),		\
+			      __stringify(f) " is not a u64");		\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %llu, got %llu", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
 #endif /* DRM_ATOMIC_SRO_HELPER_H_ */

-- 
2.55.0

