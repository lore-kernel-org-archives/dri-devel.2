Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBC0C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E2010E80E;
	Mon,  7 Sep 2026 13:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NdSQSzcv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1F410E80E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:25:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0111B60D87;
 Mon,  7 Sep 2026 13:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0081F00A3D;
 Mon,  7 Sep 2026 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787520;
 bh=TFjHCbhj4MRRWdzGkhW8a2Zwz+heEX6FKmt2CKYmyAI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NdSQSzcvglheYudsFr6cvu58vfsusg9osGoFRATtxZRpKOLigeSooFqHpZF/A7FwE
 p9OUGiT+GQMauEXI/uJB6LVbxcdBerjuimBGww+wrKf21hsiRcOJ9Vg1o3s9MDSHB2
 768IMwKNQ/77b5WwmA3wyTzhjWq4r4gTShLml3/KIBvJhWtNFmqR4bgpVPm/YrU6QJ
 y3JnbI0To1JiSB017T7SgUkrn69sRQFZr4c2m8mmUSL1F1PCnBiB/4/9FOV93leqba
 tIW4Exr65IKy9GLV7i6QxHpx5U6i0/lXU3Rn82UA4wOgHbTqMBWaB9raybEckky6QN
 d6Xwrz4UP2QhA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:57 +0200
Subject: [PATCH v5 21/33] drm/atomic-state-helper: Provide comparison
 macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-21-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10446; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IR6ATL+eVlZj7cYsbM59oR2qKBti6I3jYqsE68URf78=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj1/W72I6QXL0oICvYm/E+S6yiSnixstsAnv62Gb5
 uK+k82uYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkagNjQ5fZJq7doj2f+bLm
 WDsvzfKtvD+FacnEBA454UUqrWZa/z3+7uz8tZfZ3mjf7E9bYqKZGBva1sq7PLh1o+Ukc/qN33L
 //wunWVYKHSoXKDV0X/AqNcGWg1UtevoRZ5UJfCfcjjmGvQYA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

In order to make the implementation of atomic_sro_compare_state easier
and reduce the boilerplate, introduce a set of STATE_CHECK_* macros to
compare state field values depending on their type.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_sro_helper.c |  30 +++++
 include/drm/drm_atomic_sro_helper.h     | 220 ++++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro_helper.c b/drivers/gpu/drm/drm_atomic_sro_helper.c
index 50d1af53bfc2..692a5a24d762 100644
--- a/drivers/gpu/drm/drm_atomic_sro_helper.c
+++ b/drivers/gpu/drm/drm_atomic_sro_helper.c
@@ -405,5 +405,35 @@ int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
 	drm_atomic_sro_state_free(state);
 
 	return 0;
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
diff --git a/include/drm/drm_atomic_sro_helper.h b/include/drm/drm_atomic_sro_helper.h
index a42ed8136a49..71340978ce7c 100644
--- a/include/drm/drm_atomic_sro_helper.h
+++ b/include/drm/drm_atomic_sro_helper.h
@@ -1,12 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #ifndef DRM_ATOMIC_SRO_HELPER_H_
 #define DRM_ATOMIC_SRO_HELPER_H_
 
+#include <linux/string_choices.h>
+
 struct drm_atomic_sro_state;
 struct drm_device;
+struct drm_printer;
 
 int
 drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
 					   struct drm_atomic_sro_state *state);
 int
@@ -23,6 +26,223 @@ drm_atomic_helper_sro_readout_private_objs_state(struct drm_device *dev,
 						 struct drm_atomic_sro_state *state);
 struct drm_atomic_sro_state *
 drm_atomic_helper_sro_build_state(struct drm_device *dev);
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
+			      __stringify(n) " is not a bool");		\
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
+			      __stringify(n) " is not a drm_display_mode structure"); \
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
+			      __stringify(n) " is not an hdmi_infoframe union"); \
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
+			      __stringify(n) " is not a drm_format_info pointer"); \
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
+			      __stringify(n) " is not a drm_property_blob pointer"); \
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
+			      __stringify(n) " is not an s32");		\
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
+			      __stringify(n) " is not an s32");		\
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
+			      __stringify(n) " is not a u16");		\
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
+			      __stringify(n) " is not a u32");		\
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
+			      __stringify(n) " is not a u32");		\
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
+			      __stringify(n) " is not a u32");		\
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
+			      __stringify(n) " is not a u64");		\
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

