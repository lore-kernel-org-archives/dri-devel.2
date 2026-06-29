Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D212C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C484A10E771;
	Mon, 29 Jun 2026 08:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XiOmziqS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7AB10E738
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:18:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 694C5413A1;
 Mon, 29 Jun 2026 08:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49621F00AC4;
 Mon, 29 Jun 2026 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721090;
 bh=ctxddJyglZvzNvKobvgO2Jyoat5mRr1jQmBdH7Yk6g4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XiOmziqShEf0kp28135xx1QtbgrYJgo8xjrNtz55fUxYvLTNw1mm4FqIi+pgCteYc
 BsYsYUKaus6fa1xNyg1jcot9Vccnkp1besbylaUA4E5swgXY/OHmxMb67eomEqms+C
 gngCBHQwx0wIFasU03Hb2FQxAKya1EkV6H2gp0VcIcgErhqWPofr54HsqOOm2zBS39
 s4AhWh6J7pbz4uDYiC/gS+CYMuBYx7JW3fVtMDr+MbdNxHUkQNmkA1jtiKoUPR5JHb
 JcEl1cZ9vnD6dE6ZcTb9wU+FnPwluY5ew8UEi8PLQUKPUzuFf07Jefs53lw9yMYvj/
 hyYjYbAEGU9MA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:19 +0200
Subject: [PATCH v4 21/30] drm/atomic-state-helper: Provide comparison
 macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-21-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10409; i=mripard@kernel.org;
 h=from:subject:message-id; bh=oBb6DWzdM47ldXYHEnPKxa8ei+QrvhcS496LP531t2g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWpz7Nui2/ewyiUw8/XzqxCInz8d533YK2Xy3vTJT8
 YFpduK/jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRXbcY64NdZy/VCtu0d56q
 k5/ukn8TI+/vn8B7zM/1xAWmMM82wxpru2OxZafuH5jv7q9SLcf+nrFhZvO/YIZl20vCuiWlVuV
 7Mz98/Kde5+Evx9DY2D7J0Oump8M//1kYqHWsRZXz39ZnnxcAAA==
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

In order to make the implementation of atomic_compare_state
easier and reduce the boilerplate, introduce a set of STATE_CHECK_*
macros to compare state field values depending on their type.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_sro_helper.c |  30 +++++
 include/drm/drm_atomic_sro_helper.h     | 219 ++++++++++++++++++++++++++++++++
 2 files changed, 249 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro_helper.c b/drivers/gpu/drm/drm_atomic_sro_helper.c
index d492aebda119..f6d7d65103bb 100644
--- a/drivers/gpu/drm/drm_atomic_sro_helper.c
+++ b/drivers/gpu/drm/drm_atomic_sro_helper.c
@@ -402,5 +402,35 @@ int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
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
index a42ed8136a49..db5d62ac0db9 100644
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
@@ -23,6 +26,222 @@ drm_atomic_helper_sro_readout_private_objs_state(struct drm_device *dev,
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
+			      __stringify(name) " is not a bool");	\
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
+			      __stringify(name) " is not a drm_display_mode structure"); \
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
+			      __stringify(name) " is not an hdmi_infoframe union"); \
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
+			      __stringify(name) " is not a drm_format_info pointer"); \
+		if (sa->f != sb->f) {			\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %p4cc, got %p4cc", \
+							       &sa->f->format, \
+							       &sb->f->format); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_PROPERTY_BLOB(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, struct drm_property_blob *), \
+			      __stringify(name) " is not a drm_property_blob pointer"); \
+		if (sa->f != sb->f &&					\
+		    ((sa->f->length != sb->f->length) ||		\
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
+			      __stringify(name) " is not an s32");	\
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
+#define STATE_CHECK_S32_X(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (s32)0),		\
+			      __stringify(name) " is not an s32");	\
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
+			      __stringify(name) " is not a u16");	\
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
+			      __stringify(name) " is not a u32");	\
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
+			      __stringify(name) " is not a u32");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %d.%06u, got %d.%06u", \
+							       sa->f >> 16, ((sa->f && 0xffff) * 15625) >> 10, \
+							       sb->f >> 16, ((sb->f && 0xffff) * 15625) >> 10); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U32_X(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u32)0),		\
+			      __stringify(name) " is not a u32");	\
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
+			      __stringify(name) " is not a u64");	\
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
2.54.0

