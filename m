Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359E606A331
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34ED310E703;
	Thu, 12 Nov 2026 22:59:43 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08FF10E6D3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:24 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8b0cf2c0785so4772027b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524364; x=1795129164;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NF40bNuB+7T3fRZ/y9lOpNllM4G0uCoTbmZ6ZV1+NjE=;
 b=Ft1kcPplYOECHGIMQGZpMtHXzlHy4y5wNxLNZvDJ7oDMRcTNHDWOJpbD2yoAOJtwmw
 K7R03jtqfAAECCUDXUOY3QFQRLs2XFNCijJ4+rGIhgUqhLonVH4M2Umrpak3Qtp1cESh
 WDYc7AfwMnBMDJnC7zyTxr2VdGPy59tYkPTxPfXxAzV/NqAZM66B+bwZ7fHA49C+NmYx
 KmlYqKTkfHPpSjkw3Y6VMKDln06rZA8Q1RBIORQqu2hj+UTFdNU7Baj1EkIQe2s0qTig
 2I5+ttOpW3+fhU97evy+A6wJslwMGmEqFffZ0k2P1LJPzHSayi+Fm09pmZZ4vyxtXYIt
 8NbQ==
X-Gm-Message-State: APuU4Z/W5qofh0kfCgt1lKLyCQUK6JKJcO12ctcQx76ER3zy+2lmHKDU
 EFRjZsfit9KoFv9U4HKJCbw3sR/JIXo5YSpzslq9y2YpxEYlovePIFb/
X-Gm-Gg: AYBFou0jrZHKWpoue6QJ8VmTNYm7QdryJid++du/4wLLtPkC+mccZU7iim/13+xIJKx
 GaUphz7M33ua7W35tDb9/YfLReT2tPx30d2b19w3MnlVK5q4Fy8AjpxYS8ky9ndnba4xyCX9YQe
 QQZ0Kw4NI8kGZYs+2nfWfRADxARAoZsxlQZ0tq2EWlfKuodmXTcLtaZSQ2+M/EXSLu7wOKQgeeW
 kVBMd0zBRiXfp448t/19JejSHvvOSEky6o5PjuwVgkqrlnM6nM0N5MekqMUsEvTYL3YRsdi5RIa
 lPFRSaw2DfMx+Qxkl5RmKzLJJgefm94qf9YYcZHr21JRf0PL/iKDP1icwqZwpMR4mkGbaj+hqVD
 4eq03NKVcn/nfhRUnuXyhqQyZGmnF+ZXShxxnCr68DDljSZh52YXZOl+/U6QY3uOgg0mUZ9XZR9
 sZsuoKUrwxTCf5v6m1lwors+BauGY143a9gNToj0RQfrliVTXl7eH2X12t88WSsWd1WbjXT5lhO
 79Hi1/5ESJFHQUnTQTLJpycpQrEupjnnIQx6r6S2Z9zT5H2xtZhUMBxGuRhUSQ2E3Prg0pQ2JHt
 GRCf1Jdgp4TzcVWrkkywgTldssvihzq5ZSGIyTv8292ShdiHnXUNq3OgIwoc5g5L8AvBHAl1TmJ
 m9jsf33D5bazMI5O4JzdRDUCy6OxjbfaQRBsBwgLez/LMYLGNwzxs+LXhp9GS1J7yAuukyYkCho
 HS9IlHOz/2f50D0mP5hu1+APU/
X-Received: by 2002:a05:690c:dc3:b0:8b0:a432:5686 with SMTP id
 00721157ae682-8b4aa2da2f3mr5950117b3.44.1794524363601; 
 Thu, 12 Nov 2026 14:59:23 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:23 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:58:59 -0500
Subject: [PATCH RFC 09/13] drm/powervr_sgx: Add the client command checks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-powervr-sgx-v1-9-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
To: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Userspace describes a job's work as plain structs, never as a firmware
structure: a render command and one TA-kick command per kick. Each
starts with its size and a chain of extensions
for the fields only one core has.

The kernel copies each struct as copy_struct_from_user() does: a
shorter struct reads as zeros, and non-zero bytes past what the kernel
knows are -E2BIG. It walks the extension chain (at most 16, each name
once; one this core doesn't accept is -EOPNOTSUPP) and checks what it
copied, so a racing writer can't change a checked value. Every field is
checked against the core's table: ranges, masks, alignment, and for an
address the heap it must lie in and an extent mapped in the job's VM.
Then the cross-field rules (depth and stencil with ZLS, tile
rectangles), and only then does it build the firmware command from the
checked values.

The structs, their extensions and the per-core check tables come from
one XML description. The generated tables are committed, so the build
needs no generator.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/powervr_sgx/pvrsgx_cmd.c        | 234 ++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_cmd.h        | 132 +++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_checks.c |  62 +++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_checks.h |  13 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.c   | 353 ++++++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.h   |  43 +++
 6 files changed, 837 insertions(+)

diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd.c
new file mode 100644
index 000000000..0da4f387c
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: MIT
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * Client commands: the copy from userspace and the per-field checks, from
+ * the per-core tables in pvrsgx_cmd_defs.c. The per-command cross-field
+ * rules are in pvrsgx_cmd_checks.c.
+ */
+
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "pvrsgx_cmd_defs.h"
+
+static const struct pvrsgx_cmd_ext_def *ext_find(const struct pvrsgx_cmd_def *def, u32 id)
+{
+	for (u32 i = 0; i < def->nr_exts; i++) {
+		if (def->exts[i].id == id)
+			return &def->exts[i];
+	}
+	return NULL;
+}
+
+static int take_exts(const struct pvrsgx_cmd_def *def, u64 uptr, u8 *all, u64 *present)
+{
+	u32 n = 0;
+
+	*present = 0;
+	while (uptr) {
+		const struct pvrsgx_cmd_ext_def *ed;
+		struct drm_powervr_sgx_ext head;
+		u8 *dst;
+
+		if (++n > PVRSGX_CMD_MAX_EXTS)
+			return -EINVAL;
+		if (copy_from_user(&head, u64_to_user_ptr(uptr), sizeof(head)))
+			return -EFAULT;
+		if (head._padding_4 || !head.name || head.name >= 64 ||
+		    pvrsgx_cmd_ext_owner[head.name] != 1 + def->type)
+			return -EINVAL;	/* unknown, or another command's */
+		if (*present & BIT_ULL(head.name))
+			return -EINVAL;
+		ed = ext_find(def, head.name);
+		if (!ed)
+			return -EOPNOTSUPP;	/* this command's, but not on this core */
+		dst = all + ed->offset;
+		if (copy_from_user(dst, u64_to_user_ptr(uptr), ed->size))
+			return -EFAULT;
+		/* the copy is what counts: a racing writer can't change what was checked */
+		if (((struct drm_powervr_sgx_ext *)dst)->name != head.name)
+			return -EINVAL;
+		*present |= BIT_ULL(head.name);
+		uptr = ((struct drm_powervr_sgx_ext *)dst)->next;
+	}
+	return 0;
+}
+
+int pvrsgx_cmd_copy(const struct pvrsgx_cmd_def *def, u64 uptr, void *all, u64 *present)
+{
+	const void __user *src = u64_to_user_ptr(uptr);
+	struct drm_powervr_sgx_cmd_head *head = all;
+	u32 size;
+	int err;
+
+	memset(all, 0, def->all_size);
+	*present = 0;
+	if (!def->supported)
+		return -EOPNOTSUPP;
+	if (!uptr)
+		return -EINVAL;
+	if (get_user(size, (const u32 __user *)src))
+		return -EFAULT;
+	if (size < sizeof(*head) || size > PVRSGX_CMD_MAX_SIZE)
+		return -EINVAL;
+	/* -E2BIG for non-zero bytes past what this kernel knows, as everywhere */
+	err = copy_struct_from_user(all, def->size, src, size);
+	if (err)
+		return err;
+	if (head->size != size)
+		return -EINVAL;
+	return take_exts(def, head->extensions, all, present);
+}
+
+int pvrsgx_cmd_take_elem(const struct pvrsgx_cmd_def *def, const void *elem, u32 stride,
+			 void *all, u64 *present)
+{
+	const struct drm_powervr_sgx_cmd_head *head = elem;
+
+	memset(all, 0, def->all_size);
+	*present = 0;
+	if (!def->supported)
+		return -EOPNOTSUPP;
+	if (stride < sizeof(*head) || head->size != stride)
+		return -EINVAL;
+	/* obj_array_get() copied min(stride, def->size) and checked the tail */
+	memcpy(all, elem, def->size);
+	return take_exts(def, head->extensions, all, present);
+}
+
+static u64 cmd_field_get(const u8 *all, const struct pvrsgx_cmd_field *f)
+{
+	u64 v = 0;
+
+	memcpy(&v, all + f->offset, f->size);	/* little-endian: the low bytes */
+	return v;
+}
+
+static int check_field(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_field *f,
+		       const struct pvrsgx_cmd_ctx *ctx, u64 v)
+{
+	switch (f->check) {
+	case PVRSGX_CMD_CHECK_NONE:
+		return 0;
+	case PVRSGX_CMD_CHECK_ZERO:
+		return v ? -EINVAL : 0;
+	case PVRSGX_CMD_CHECK_RANGE: {
+		u64 max = f->limit ? ctx->limits[f->limit] : f->max;
+
+		return v < f->min || v > max ? -EINVAL : 0;
+	}
+	case PVRSGX_CMD_CHECK_MASK:
+		return v & ~f->mask ? -EINVAL : 0;
+	case PVRSGX_CMD_CHECK_ADDR:
+		if (!v)
+			return f->optional ? 0 : -EINVAL;
+		if (core->va_bits < 64 && v >> core->va_bits)
+			return -EINVAL;
+		if (v & (f->align - 1))
+			return -EINVAL;
+		if (f->heap == PVRSGX_CMD_HEAP_CLIENT)
+			return 0;	/* VM_MAP maps only client heaps; check_mapped covers it */
+		if (f->heap >= PVRSGX_CMD_HEAP_MAX || !ctx->heaps[f->heap].size ||
+		    v < ctx->heaps[f->heap].base ||
+		    v - ctx->heaps[f->heap].base >= ctx->heaps[f->heap].size)
+			return -EINVAL;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int check_fields(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_field *fields,
+			u32 n, const struct pvrsgx_cmd_ctx *ctx, const u8 *all)
+{
+	for (u32 i = 0; i < n; i++) {
+		int err = check_field(core, &fields[i], ctx, cmd_field_get(all, &fields[i]));
+
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+int pvrsgx_cmd_check(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_def *def,
+		     const struct pvrsgx_cmd_ctx *ctx, const void *all, u64 present)
+{
+	const struct drm_powervr_sgx_cmd_head *head = all;
+	int err;
+
+	if (!def->supported)
+		return -EOPNOTSUPP;
+	if (head->_padding_4)
+		return -EINVAL;
+	err = check_fields(core, def->fields, def->nr_fields, ctx, all);
+	for (u32 i = 0; !err && i < def->nr_exts; i++) {
+		const struct pvrsgx_cmd_ext_def *ed = &def->exts[i];
+
+		if (present & BIT_ULL(ed->id))	/* absent: all zero, rev 1's "off" */
+			err = check_fields(core, ed->fields, ed->nr_fields, ctx, all);
+	}
+	return err;
+}
+
+static int mapped_fields(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_field *fields,
+			 u32 n, const struct pvrsgx_cmd_ctx *ctx, const u8 *all)
+{
+	for (u32 i = 0; i < n; i++) {
+		const struct pvrsgx_cmd_field *f = &fields[i];
+		u64 addr, size, samples = ctx->rt_samples ? ctx->rt_samples : 1;
+
+		if (f->check != PVRSGX_CMD_CHECK_ADDR || !f->extent)
+			continue;
+		addr = cmd_field_get(all, f);
+		if (!addr)
+			continue;	/* an optional address left out */
+		switch (f->extent) {
+		case PVRSGX_CMD_EXTENT_BYTES:
+			size = f->extent_bytes;
+			break;
+		case PVRSGX_CMD_EXTENT_RT_DEPTH:
+			size = (u64)ctx->rt_pad_width * ctx->rt_pad_height * 4 * samples;
+			break;
+		case PVRSGX_CMD_EXTENT_RT_STENCIL:
+			size = (u64)ctx->rt_pad_width * ctx->rt_pad_height * samples;
+			break;
+		case PVRSGX_CMD_EXTENT_PDS_ROWS: {
+			u32 rows;
+
+			memcpy(&rows, all + f->extent_field, sizeof(rows));
+			size = (u64)rows * core->pds_row_bytes;
+			break;
+		}
+		default:
+			return -EINVAL;
+		}
+		if (!size || !ctx->mapped(ctx->priv, addr, size))
+			return -EINVAL;
+	}
+	return 0;
+}
+
+int pvrsgx_cmd_check_mapped(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_def *def,
+			    const struct pvrsgx_cmd_ctx *ctx, const void *all, u64 present)
+{
+	int err = mapped_fields(core, def->fields, def->nr_fields, ctx, all);
+
+	for (u32 i = 0; !err && i < def->nr_exts; i++) {
+		const struct pvrsgx_cmd_ext_def *ed = &def->exts[i];
+
+		if (present & BIT_ULL(ed->id))
+			err = mapped_fields(core, ed->fields, ed->nr_fields, ctx, all);
+	}
+	return err;
+}
+
+u64 pvrsgx_cmd_ext_mask(const struct pvrsgx_cmd_def *def)
+{
+	u64 mask = 0;
+
+	for (u32 i = 0; def->supported && i < def->nr_exts; i++)
+		mask |= BIT_ULL(def->exts[i].id);
+	return mask;
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd.h
new file mode 100644
index 000000000..ec5c29dff
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * Client commands: copied from userspace with their extensions, then checked
+ * field by field from the per-core tables in pvrsgx_cmd_defs.c.
+ */
+
+#ifndef PVRSGX_CMD_H
+#define PVRSGX_CMD_H
+
+#include <linux/types.h>
+
+#include <uapi/drm/powervr_sgx_drm.h>
+
+#define PVRSGX_CMD_MAX_SIZE 4096U
+#define PVRSGX_CMD_MAX_EXTS 16U
+#define PVRSGX_CMD_TYPES_MAX 8U
+
+enum pvrsgx_cmd_check {
+	PVRSGX_CMD_CHECK_NONE = 0,
+	PVRSGX_CMD_CHECK_ZERO,	/* padding */
+	PVRSGX_CMD_CHECK_RANGE,
+	PVRSGX_CMD_CHECK_MASK,
+	PVRSGX_CMD_CHECK_ADDR,
+};
+
+/* CLIENT has no range: VM_MAP only maps client heaps, and the mapped check covers it. */
+enum pvrsgx_cmd_heap {
+	PVRSGX_CMD_HEAP_CLIENT = 0,
+	PVRSGX_CMD_HEAP_PDS_PIXEL,
+	PVRSGX_CMD_HEAP_MAX,
+};
+
+enum pvrsgx_cmd_limit {
+	PVRSGX_CMD_LIMIT_NONE = 0,
+	PVRSGX_CMD_LIMIT_TILES_X,
+	PVRSGX_CMD_LIMIT_TILES_Y,
+	PVRSGX_CMD_LIMIT_MAX,
+};
+
+enum pvrsgx_cmd_extent {
+	PVRSGX_CMD_EXTENT_NONE = 0,
+	PVRSGX_CMD_EXTENT_BYTES,
+	PVRSGX_CMD_EXTENT_RT_DEPTH,
+	PVRSGX_CMD_EXTENT_RT_STENCIL,
+	PVRSGX_CMD_EXTENT_PDS_ROWS,
+};
+
+/* One field's check. Offsets are into the command's all-struct (pvrsgx_cmd_defs.h). */
+struct pvrsgx_cmd_field {
+	const char *name;
+	u16 offset;
+	u8 size;		/* 4 or 8 */
+	u8 check;
+	u8 limit;		/* RANGE: replaces max when set */
+	u8 heap;		/* ADDR */
+	u8 extent;		/* ADDR */
+	bool optional;		/* ADDR: 0 means none */
+	u16 extent_field;	/* PDS_ROWS: offset of the u32 row count */
+	u32 align;		/* ADDR */
+	u32 extent_bytes;	/* BYTES */
+	u64 min, max;		/* RANGE */
+	u64 mask;		/* MASK */
+};
+
+struct pvrsgx_cmd_ext_def {
+	u32 id;			/* DRM_POWERVR_SGX_EXT_* */
+	u16 size;		/* sizeof its struct */
+	u16 offset;		/* in the all-struct */
+	const struct pvrsgx_cmd_field *fields;
+	u32 nr_fields;
+};
+
+/* A command on one core. Not supported: a value it depends on is unknown there. */
+struct pvrsgx_cmd_def {
+	const char *name;
+	u8 type;		/* enum pvrsgx_cmd_type */
+	bool supported;
+	u16 size;		/* sizeof the base struct */
+	u16 all_size;		/* sizeof the all-struct: base and every extension */
+	const struct pvrsgx_cmd_field *fields;
+	u32 nr_fields;
+	const struct pvrsgx_cmd_ext_def *exts;	/* the extensions this core accepts */
+	u32 nr_exts;
+};
+
+struct pvrsgx_cmd_core {
+	const char *name;
+	u32 va_bits;
+	u32 pds_row_bytes;
+	u32 max_samples;	/* RT datasets: 1, or 4 where 4x is known to work */
+	const struct pvrsgx_cmd_def *cmds[PVRSGX_CMD_TYPES_MAX];
+};
+
+/* What a command is checked against: its VM, its RT, the device. */
+struct pvrsgx_cmd_ctx {
+	struct {
+		u64 base, size;
+	} heaps[PVRSGX_CMD_HEAP_MAX];	/* size 0: refuse every address */
+	u64 limits[PVRSGX_CMD_LIMIT_MAX];
+	u32 rt_pad_width, rt_pad_height;	/* the RT's size in whole tiles */
+	u32 rt_samples;				/* 0 is 1 */
+	bool (*mapped)(const void *priv, u64 addr, u64 size);
+	const void *priv;
+};
+
+/*
+ * A command at a user pointer, with its extensions, into @all (def->all_size
+ * bytes; absent extensions zero). @present gets a bit per extension sent.
+ */
+int pvrsgx_cmd_copy(const struct pvrsgx_cmd_def *def, u64 uptr, void *all, u64 *present);
+
+/*
+ * An array element obj_array_get() already copied at @stride (a TA kick):
+ * its head.size must equal @stride. Copies it into @all and walks its extensions.
+ */
+int pvrsgx_cmd_take_elem(const struct pvrsgx_cmd_def *def, const void *elem, u32 stride,
+			 void *all, u64 *present);
+
+/* Every field on its own: padding, ranges, masks, addresses' heaps and alignment. */
+int pvrsgx_cmd_check(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_def *def,
+		     const struct pvrsgx_cmd_ctx *ctx, const void *all, u64 present);
+
+/* Every address's extent is mapped in the VM (with the VM's lock held). */
+int pvrsgx_cmd_check_mapped(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_def *def,
+			    const struct pvrsgx_cmd_ctx *ctx, const void *all, u64 present);
+
+/* The extension names @def accepts, a bit per name (DEV_QUERY COMMANDS_GET). */
+u64 pvrsgx_cmd_ext_mask(const struct pvrsgx_cmd_def *def);
+
+#endif /* PVRSGX_CMD_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_checks.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_checks.c
new file mode 100644
index 000000000..ae0848f3c
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_checks.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: MIT
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The cross-field rules of the client commands, run
+ * after pvrsgx_cmd_check() has checked each field on its own.
+ */
+
+#include <linux/bits.h>
+#include <linux/errno.h>
+
+#include "pvrsgx_cmd_checks.h"
+
+/* SGX545 ZLS control bits that use the stencil address. */
+#define ZLS_STENCIL_BITS 0x3U
+/* SGX545 3D flags bit that uses the stencil address. */
+#define FLAGS_3D_STENCIL BIT(8)
+/* ZLS addresses are offsets from a 1 MiB-aligned base; the 1 GiB limit is assumed. */
+#define ZLS_BASE_MASK 0xfff00000U
+#define ZLS_OFFSET_LIMIT_LOG2 30
+
+int pvrsgx_check_render(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_render_all *r,
+			u32 samples)
+{
+	/* The SGX545 extension; all zero when it wasn't sent or on another core. */
+	u32 zls = r->sgx545_render.zls_control, flags = r->sgx545_render.flags_3d;
+	u64 depth = r->base.depth_addr, stencil = r->base.stencil_addr, base, limit;
+
+	/* Multisampled depth and stencil are per sample and always stored. */
+	if (samples == 4 && !zls)
+		return -EINVAL;
+	if (zls && !depth)
+		return -EINVAL;
+	if (((zls & ZLS_STENCIL_BITS) || (flags & FLAGS_3D_STENCIL)) && !stencil)
+		return -EINVAL;
+
+	if (!depth && !stencil)
+		return 0;
+	if (!depth)
+		base = stencil;
+	else if (!stencil)
+		base = depth;
+	else
+		base = depth < stencil ? depth : stencil;
+	base &= ZLS_BASE_MASK;
+	limit = BIT_ULL(core->va_bits < ZLS_OFFSET_LIMIT_LOG2 ? core->va_bits :
+			ZLS_OFFSET_LIMIT_LOG2);
+
+	if (depth && depth - base >= limit)
+		return -EINVAL;
+	if (stencil && stencil - base >= limit)
+		return -EINVAL;
+	return 0;
+}
+
+int pvrsgx_check_transfer(const struct pvrsgx_cmd_transfer_all *t)
+{
+	if (t->base.first_tile_x > t->base.last_tile_x ||
+	    t->base.first_tile_y > t->base.last_tile_y)
+		return -EINVAL;
+	return 0;
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_checks.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_checks.h
new file mode 100644
index 000000000..06b14ae15
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_checks.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_CMD_CHECKS_H
+#define PVRSGX_CMD_CHECKS_H
+
+#include "pvrsgx_cmd_defs.h"
+
+int pvrsgx_check_render(const struct pvrsgx_cmd_core *core, const struct pvrsgx_cmd_render_all *r,
+			u32 samples);
+int pvrsgx_check_transfer(const struct pvrsgx_cmd_transfer_all *t);
+
+#endif /* PVRSGX_CMD_CHECKS_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.c
new file mode 100644
index 000000000..f73c80199
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: MIT
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The per-core client-command tables, generated by gen_cmd.py from the command
+ * description powervr_sgx_cmd.xml; both live in the driver's source repository,
+ * https://github.com/The1TrueJoe/powervr_sgx.
+ */
+
+#include <linux/array_size.h>
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+
+#include "pvrsgx_cmd_defs.h"
+
+/* The uAPI layout, pinned. */
+static_assert(PVRSGX_CMD_COUNT <= PVRSGX_CMD_TYPES_MAX);
+static_assert(sizeof(struct drm_powervr_sgx_cmd_render) == 80);
+static_assert(sizeof(struct drm_powervr_sgx_cmd_render) % 8 == 0);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, depth_addr) == 16);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, stencil_addr) == 24);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, pixel_event_pds_addr) == 32);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, bg_pds_secondary_addr) == 40);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, bg_pds_primary_addr) == 48);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, pixel_event_pds_rows) == 56);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, bg_pds_secondary_rows) == 60);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, bg_pds_primary_rows) == 64);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, bg_depth_f32) == 68);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, depth_bias_units) == 72);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_render, depth_bias_factor_f32) == 76);
+static_assert(sizeof(struct drm_powervr_sgx_cmd_ta_kick) == 24);
+static_assert(sizeof(struct drm_powervr_sgx_cmd_ta_kick) % 8 == 0);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_ta_kick, vdm_base) == 16);
+static_assert(sizeof(struct drm_powervr_sgx_cmd_transfer) == 56);
+static_assert(sizeof(struct drm_powervr_sgx_cmd_transfer) % 8 == 0);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_transfer, bg_block_addr) == 16);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_transfer, pixel_event_pds_addr) == 24);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_transfer, pixel_event_pds_rows) == 32);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_transfer, first_tile_x) == 36);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_transfer, first_tile_y) == 40);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_transfer, last_tile_x) == 44);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_transfer, last_tile_y) == 48);
+static_assert(offsetof(struct drm_powervr_sgx_cmd_transfer, bg_depth_f32) == 52);
+static_assert(sizeof(struct drm_powervr_sgx_ext_sgx545_render) == 24);
+static_assert(sizeof(struct drm_powervr_sgx_ext_sgx545_render) % 8 == 0);
+static_assert(offsetof(struct drm_powervr_sgx_ext_sgx545_render, zls_control) == 16);
+static_assert(offsetof(struct drm_powervr_sgx_ext_sgx545_render, flags_3d) == 20);
+static_assert(sizeof(struct drm_powervr_sgx_ext_sgx545_ta_kick) == 24);
+static_assert(sizeof(struct drm_powervr_sgx_ext_sgx545_ta_kick) % 8 == 0);
+static_assert(offsetof(struct drm_powervr_sgx_ext_sgx545_ta_kick, ta_flags2) == 16);
+
+const u8 pvrsgx_cmd_ext_owner[64] = {
+	[DRM_POWERVR_SGX_EXT_SGX545_RENDER] = 1 + PVRSGX_CMD_RENDER,
+	[DRM_POWERVR_SGX_EXT_SGX545_TA_KICK] = 1 + PVRSGX_CMD_TA_KICK,
+};
+
+static const struct pvrsgx_cmd_field sgx545_render_fields[] = {
+	{
+		.name = "depth_addr",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.depth_addr),
+		.size = 8,
+		.check = PVRSGX_CMD_CHECK_ADDR,
+		.heap = PVRSGX_CMD_HEAP_CLIENT,
+		.align = 1,
+		.optional = true,
+		.extent = PVRSGX_CMD_EXTENT_RT_DEPTH,
+	},
+	{
+		.name = "stencil_addr",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.stencil_addr),
+		.size = 8,
+		.check = PVRSGX_CMD_CHECK_ADDR,
+		.heap = PVRSGX_CMD_HEAP_CLIENT,
+		.align = 1,
+		.optional = true,
+		.extent = PVRSGX_CMD_EXTENT_RT_STENCIL,
+	},
+	{
+		.name = "pixel_event_pds_addr",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.pixel_event_pds_addr),
+		.size = 8,
+		.check = PVRSGX_CMD_CHECK_ADDR,
+		.heap = PVRSGX_CMD_HEAP_PDS_PIXEL,
+		.align = 16,
+		.extent = PVRSGX_CMD_EXTENT_PDS_ROWS,
+		.extent_field = offsetof(struct pvrsgx_cmd_render_all, base.pixel_event_pds_rows),
+	},
+	{
+		.name = "bg_pds_secondary_addr",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.bg_pds_secondary_addr),
+		.size = 8,
+		.check = PVRSGX_CMD_CHECK_ADDR,
+		.heap = PVRSGX_CMD_HEAP_PDS_PIXEL,
+		.align = 16,
+	},
+	{
+		.name = "bg_pds_primary_addr",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.bg_pds_primary_addr),
+		.size = 8,
+		.check = PVRSGX_CMD_CHECK_ADDR,
+		.heap = PVRSGX_CMD_HEAP_PDS_PIXEL,
+		.align = 16,
+	},
+	{
+		.name = "pixel_event_pds_rows",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.pixel_event_pds_rows),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_RANGE,
+		.min = 1,
+		.max = 63,
+	},
+	{
+		.name = "bg_pds_secondary_rows",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.bg_pds_secondary_rows),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_RANGE,
+		.min = 1,
+		.max = 63,
+	},
+	{
+		.name = "bg_pds_primary_rows",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.bg_pds_primary_rows),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_RANGE,
+		.min = 1,
+		.max = 63,
+	},
+	{
+		.name = "bg_depth_f32",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.bg_depth_f32),
+		.size = 4,
+	},
+	{
+		.name = "depth_bias_units",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.depth_bias_units),
+		.size = 4,
+	},
+	{
+		.name = "depth_bias_factor_f32",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, base.depth_bias_factor_f32),
+		.size = 4,
+	},
+};
+
+static const struct pvrsgx_cmd_field sgx545_sgx545_render_fields[] = {
+	{
+		.name = "zls_control",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, sgx545_render.zls_control),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_MASK,
+		.mask = 0x001ff007,
+	},
+	{
+		.name = "flags_3d",
+		.offset = offsetof(struct pvrsgx_cmd_render_all, sgx545_render.flags_3d),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_MASK,
+		.mask = 0x00000180,
+	},
+};
+
+static const struct pvrsgx_cmd_ext_def sgx545_render_exts[] = {
+	{
+		.id = DRM_POWERVR_SGX_EXT_SGX545_RENDER,
+		.size = sizeof(struct drm_powervr_sgx_ext_sgx545_render),
+		.offset = offsetof(struct pvrsgx_cmd_render_all, sgx545_render),
+		.fields = sgx545_sgx545_render_fields,
+		.nr_fields = ARRAY_SIZE(sgx545_sgx545_render_fields),
+	},
+};
+
+static const struct pvrsgx_cmd_def sgx545_render = {
+	.name = "render",
+	.type = PVRSGX_CMD_RENDER,
+	.supported = true,
+	.size = sizeof(struct drm_powervr_sgx_cmd_render),
+	.all_size = sizeof(struct pvrsgx_cmd_render_all),
+	.fields = sgx545_render_fields,
+	.nr_fields = ARRAY_SIZE(sgx545_render_fields),
+	.exts = sgx545_render_exts,
+	.nr_exts = ARRAY_SIZE(sgx545_render_exts),
+};
+
+static const struct pvrsgx_cmd_field sgx545_ta_kick_fields[] = {
+	{
+		.name = "vdm_base",
+		.offset = offsetof(struct pvrsgx_cmd_ta_kick_all, base.vdm_base),
+		.size = 8,
+		.check = PVRSGX_CMD_CHECK_ADDR,
+		.heap = PVRSGX_CMD_HEAP_CLIENT,
+		.align = 4,
+		.extent = PVRSGX_CMD_EXTENT_BYTES,
+		.extent_bytes = 4,
+	},
+};
+
+static const struct pvrsgx_cmd_field sgx545_sgx545_ta_kick_fields[] = {
+	{
+		.name = "ta_flags2",
+		.offset = offsetof(struct pvrsgx_cmd_ta_kick_all, sgx545_ta_kick.ta_flags2),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_MASK,
+		.mask = 0x02c80000,
+	},
+	{
+		.name = "_padding_14",
+		.offset = offsetof(struct pvrsgx_cmd_ta_kick_all, sgx545_ta_kick._padding_14),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_ZERO,
+	},
+};
+
+static const struct pvrsgx_cmd_ext_def sgx545_ta_kick_exts[] = {
+	{
+		.id = DRM_POWERVR_SGX_EXT_SGX545_TA_KICK,
+		.size = sizeof(struct drm_powervr_sgx_ext_sgx545_ta_kick),
+		.offset = offsetof(struct pvrsgx_cmd_ta_kick_all, sgx545_ta_kick),
+		.fields = sgx545_sgx545_ta_kick_fields,
+		.nr_fields = ARRAY_SIZE(sgx545_sgx545_ta_kick_fields),
+	},
+};
+
+static const struct pvrsgx_cmd_def sgx545_ta_kick = {
+	.name = "ta_kick",
+	.type = PVRSGX_CMD_TA_KICK,
+	.supported = true,
+	.size = sizeof(struct drm_powervr_sgx_cmd_ta_kick),
+	.all_size = sizeof(struct pvrsgx_cmd_ta_kick_all),
+	.fields = sgx545_ta_kick_fields,
+	.nr_fields = ARRAY_SIZE(sgx545_ta_kick_fields),
+	.exts = sgx545_ta_kick_exts,
+	.nr_exts = ARRAY_SIZE(sgx545_ta_kick_exts),
+};
+
+static const struct pvrsgx_cmd_field sgx545_transfer_fields[] = {
+	{
+		.name = "bg_block_addr",
+		.offset = offsetof(struct pvrsgx_cmd_transfer_all, base.bg_block_addr),
+		.size = 8,
+		.check = PVRSGX_CMD_CHECK_ADDR,
+		.heap = PVRSGX_CMD_HEAP_CLIENT,
+		.align = 16,
+		.extent = PVRSGX_CMD_EXTENT_BYTES,
+		.extent_bytes = 0x200,
+	},
+	{
+		.name = "pixel_event_pds_addr",
+		.offset = offsetof(struct pvrsgx_cmd_transfer_all, base.pixel_event_pds_addr),
+		.size = 8,
+		.check = PVRSGX_CMD_CHECK_ADDR,
+		.heap = PVRSGX_CMD_HEAP_PDS_PIXEL,
+		.align = 16,
+		.extent = PVRSGX_CMD_EXTENT_PDS_ROWS,
+		.extent_field = offsetof(struct pvrsgx_cmd_transfer_all, base.pixel_event_pds_rows),
+	},
+	{
+		.name = "pixel_event_pds_rows",
+		.offset = offsetof(struct pvrsgx_cmd_transfer_all, base.pixel_event_pds_rows),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_RANGE,
+		.min = 1,
+		.max = 63,
+	},
+	{
+		.name = "first_tile_x",
+		.offset = offsetof(struct pvrsgx_cmd_transfer_all, base.first_tile_x),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_RANGE,
+		.min = 0,
+		.limit = PVRSGX_CMD_LIMIT_TILES_X,
+	},
+	{
+		.name = "first_tile_y",
+		.offset = offsetof(struct pvrsgx_cmd_transfer_all, base.first_tile_y),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_RANGE,
+		.min = 0,
+		.limit = PVRSGX_CMD_LIMIT_TILES_Y,
+	},
+	{
+		.name = "last_tile_x",
+		.offset = offsetof(struct pvrsgx_cmd_transfer_all, base.last_tile_x),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_RANGE,
+		.min = 0,
+		.limit = PVRSGX_CMD_LIMIT_TILES_X,
+	},
+	{
+		.name = "last_tile_y",
+		.offset = offsetof(struct pvrsgx_cmd_transfer_all, base.last_tile_y),
+		.size = 4,
+		.check = PVRSGX_CMD_CHECK_RANGE,
+		.min = 0,
+		.limit = PVRSGX_CMD_LIMIT_TILES_Y,
+	},
+	{
+		.name = "bg_depth_f32",
+		.offset = offsetof(struct pvrsgx_cmd_transfer_all, base.bg_depth_f32),
+		.size = 4,
+	},
+};
+
+static const struct pvrsgx_cmd_def sgx545_transfer = {
+	.name = "transfer",
+	.type = PVRSGX_CMD_TRANSFER,
+	.supported = true,
+	.size = sizeof(struct drm_powervr_sgx_cmd_transfer),
+	.all_size = sizeof(struct pvrsgx_cmd_transfer_all),
+	.fields = sgx545_transfer_fields,
+	.nr_fields = ARRAY_SIZE(sgx545_transfer_fields),
+};
+
+const struct pvrsgx_cmd_core pvrsgx_cmd_core_sgx545 = {
+	.name = "sgx545",
+	.va_bits = 32,
+	.pds_row_bytes = 16,
+	.max_samples = 4,
+	.cmds = {
+		[PVRSGX_CMD_RENDER] = &sgx545_render,
+		[PVRSGX_CMD_TA_KICK] = &sgx545_ta_kick,
+		[PVRSGX_CMD_TRANSFER] = &sgx545_transfer,
+	},
+};
+
+/* sgx530: render depends on a value not yet known there. */
+static const struct pvrsgx_cmd_def sgx530_render = {
+	.name = "render",
+	.type = PVRSGX_CMD_RENDER,
+};
+
+/* sgx530: ta_kick depends on a value not yet known there. */
+static const struct pvrsgx_cmd_def sgx530_ta_kick = {
+	.name = "ta_kick",
+	.type = PVRSGX_CMD_TA_KICK,
+};
+
+/* sgx530: transfer depends on a value not yet known there. */
+static const struct pvrsgx_cmd_def sgx530_transfer = {
+	.name = "transfer",
+	.type = PVRSGX_CMD_TRANSFER,
+};
+
+const struct pvrsgx_cmd_core pvrsgx_cmd_core_sgx530 = {
+	.name = "sgx530",
+	.va_bits = 28,
+	.pds_row_bytes = 0,
+	.max_samples = 1,
+	.cmds = {
+		[PVRSGX_CMD_RENDER] = &sgx530_render,
+		[PVRSGX_CMD_TA_KICK] = &sgx530_ta_kick,
+		[PVRSGX_CMD_TRANSFER] = &sgx530_transfer,
+	},
+};
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.h
new file mode 100644
index 000000000..611e46e39
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The per-core client-command tables, generated by gen_cmd.py from the command
+ * description powervr_sgx_cmd.xml; both live in the driver's source repository,
+ * https://github.com/The1TrueJoe/powervr_sgx.
+ */
+
+#ifndef PVRSGX_CMD_DEFS_H
+#define PVRSGX_CMD_DEFS_H
+
+#include "pvrsgx_cmd.h"
+
+enum pvrsgx_cmd_type {
+	PVRSGX_CMD_RENDER,
+	PVRSGX_CMD_TA_KICK,
+	PVRSGX_CMD_TRANSFER,
+	PVRSGX_CMD_COUNT,
+};
+
+/* A command with every extension it can take on any core: absent ones zero. */
+struct pvrsgx_cmd_render_all {
+	struct drm_powervr_sgx_cmd_render base;
+	struct drm_powervr_sgx_ext_sgx545_render sgx545_render;
+};
+
+struct pvrsgx_cmd_ta_kick_all {
+	struct drm_powervr_sgx_cmd_ta_kick base;
+	struct drm_powervr_sgx_ext_sgx545_ta_kick sgx545_ta_kick;
+};
+
+struct pvrsgx_cmd_transfer_all {
+	struct drm_powervr_sgx_cmd_transfer base;
+};
+
+/* Extension name -> 1 + the command it belongs to, 0 for none. */
+extern const u8 pvrsgx_cmd_ext_owner[64];
+
+extern const struct pvrsgx_cmd_core pvrsgx_cmd_core_sgx545;
+extern const struct pvrsgx_cmd_core pvrsgx_cmd_core_sgx530;
+
+#endif /* PVRSGX_CMD_DEFS_H */

-- 
2.50.1

