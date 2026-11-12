Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6CD606A336
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CC81123E0;
	Thu, 12 Nov 2026 22:59:59 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489FC112362
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:28 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-8b32bbd39d5so3345537b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524367; x=1795129167;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TMJTt9NA8HcdUNf+HD9i5DdzdafzHrVtU1L0YPheFA4=;
 b=YKVnSzy30hFbn7SpYM3xZwqMHv05HDyT6kW1ZKNKNQEGqBfHeiuqlMDWa7ArCF3iPK
 QB42aG+1aFA7wNQEfgeecv6ReQ+oflTaiPBNQ0EZSzXPbpG2JfulBHbsDHL6GMmcqcgn
 RvP4RMA55OKanKx/eXc2eCJmW/APfn3fjk7g7b8HGUxc6MkoMuDKkkOUe90/uErM1KNj
 8QwJciZB4ANKoHv+TJxpZfVnfZdDMY0BYMvnOkNKRkuxfiKpb9TiWAYR8Rx/coGwCycx
 EWQizMVYcQWphzsUbzDzjhX+N98DWbBMaNbiU3TTnOFqeVEUcNXyj7g8o2NbZLwr8Tdv
 oLAQ==
X-Gm-Message-State: APuU4Z8qviD+/Na981544iCV+n1smXMK2I6kYY4QBI1XX3Jr+m2UYCas
 G6zZPuhsG1X+uj4QLYmuxG0m21X5NTytxppCsr0ZScH9VNBckhx+3pEz
X-Gm-Gg: AYBFou3ic2mkTqmbdYzfOYi4yUxMB34f3vsj+6xjIS835Um9Rmxc7lkeOg2at/DtFg5
 02HUXDmcoq+62s1QlNzYcpnVcNuaaUqmysvuG0zH1dZmqgkyYbwVfInfNoUBwNgoFTBl+dQoWtR
 49KzoqRh6I81INGC9D3UYXwpxEfIMzIolY/H4X+oj09gRpGJYEnVWtEwnnxuNoG42CzyOROJN/b
 oQi5OdsPNpCM1asQMFiNQd+yPMeL/B8m1LliZg1HH57vEHU0vPlUkw1QS7jkL319U4nU+NrT4O4
 UjnodwcaEvhCVebNl9te7BBFtmO1ne5yuz2emT3zTseNBYEc99UT8Pl7dUHM8hVkNKTCYfsl9df
 gdbAZd84mIYXK/lD82HE5awo0BzPpBVjQ8S/wkoLx4liZ7PFZzY4RGhXpz9fL2xa0PaV1jStnc4
 wj5MlD277+7DkC9qI2XydUYu/8fj357HHQOemoEhhOJi2QgMDRpbitNlIHk6LQdVOsr6rPcOvTy
 K6ScaIKfmG9vHQUCKrUXMBOV8VHxqyh9QP/c5XnGTtIkZ1dxjWyuvBEahe0GLViYk0/CY4L616G
 PLD9+g0u2Nm6lE5LiLOAMYzUpafVQXAzbhCbTgkyfw1Rj+4N4s4cbyP2/oPEhx3V+rrH/mnWgpZ
 YgcIswzRGmXmn0wo2DhOwTapBZQxl0NyxISWf9DFWsjE3qL/MxtF0zC2Ur4hQXLHIpDTupHZkD5
 nCwK8+45K/MrtAJy7HkWkQlOHI
X-Received: by 2002:a05:690c:386:b0:8b0:a4c4:1b16 with SMTP id
 00721157ae682-8b4aa177242mr8090967b3.1.1794524366911; 
 Thu, 12 Nov 2026 14:59:26 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:26 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:59:01 -0500
Subject: [PATCH RFC 11/13] drm/powervr_sgx: Validate shader code in the kernel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-powervr-sgx-v1-11-c69b84bac011@telaak.dev>
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

A client's USSE task could read the core's registers with ldr, which no
page directory can stop. So client shader code only runs from code
objects that UPLOAD_CODE filled, and the kernel checks every 8-byte
word first: it must match a known instruction form, and it may not be
ldr, str, setl or savl, or a branch out of the object. Code objects are
mapped read-only for the GPU, and the code bases cover exactly the two
USSE heaps, so a task can run nothing else.

The table of instruction forms is generated from the ISA description.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c       | 236 ++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_usse.h       |  45 ++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_usse_table.h | 342 ++++++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c   | 188 +++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_validate.h   |  25 ++
 5 files changed, 836 insertions(+)

diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c
new file mode 100644
index 000000000..9aa0cd4ab
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The USSE instruction check behind UPLOAD_CODE (pvrsgx_validate.c): each
+ * word must be exactly one form of the table generated from the isaspec
+ * description, with every operand in a register file and number the form
+ * allows, and branch and phase targets inside the object. Nothing here
+ * depends on the device, so the same code also builds for a host fuzzer.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/kconfig.h>
+
+#include "pvrsgx_usse.h"
+
+enum pvrsgx_usse_kind {
+	USSE_OK,
+	USSE_REFUSE,
+	USSE_BR,
+	USSE_PHAS,
+};
+
+enum pvrsgx_usse_slot_kind {
+	USSE_SLOT_NONE,
+	USSE_SLOT_DST,
+	USSE_SLOT_DST1,
+	USSE_SLOT_SRC,
+	USSE_SLOT_SRC0,
+};
+
+/*
+ * How an operand's number bit 6 reads: part of the number; a flag for r, o,
+ * pa, sa and i under C10 format control, which is on at program start and the
+ * only setfc allowed keeps so; or, for every register file, a flag while
+ * format select (that bit of the word) is set.
+ */
+#define USSE_NUM	0
+#define USSE_C10	1
+#define USSE_SEL(bit)	(0x80 | (bit))
+
+#define USSE_MAX_SLOTS	4
+#define USSE_MAX_PIECES	3
+#define USSE_ALWAYS	0xff
+
+/* An operand slot: its value is the pieces' bits, each shifted into place. */
+struct pvrsgx_usse_slot {
+	u8 kind;
+	/* USSE_NUM, USSE_C10 or USSE_SEL(). */
+	u8 fmt;
+	/* The slot exists only while this bit of the word is set. */
+	u8 when;
+	struct {
+		u8 lo, width, shift;
+	} p[USSE_MAX_PIECES];
+};
+
+struct pvrsgx_usse_form {
+	u64 mask, match;
+	u8 kind;
+	u8 slots;
+};
+
+#include "pvrsgx_usse_table.h"
+
+/* The forms of each instruction set (pvrsgx_core.h). */
+static const struct {
+	const struct pvrsgx_usse_form *forms;
+	u32 n;
+} isas[] = {
+	[PVRSGX_ISA_SGX545] = { pvrsgx_usse_forms, ARRAY_SIZE(pvrsgx_usse_forms) },
+};
+
+/* The register files an operand's bank and extension bits select. */
+enum usse_file {
+	USSE_R,		/* temporaries */
+	USSE_O,		/* outputs */
+	USSE_PA,	/* primary attributes */
+	USSE_SA,	/* secondary attributes */
+	USSE_INDEXED,	/* through idx1 or idx2 */
+	USSE_CG,	/* constants c0-63, then globals g0- */
+	USSE_IDX,	/* the index registers */
+	USSE_IMM,	/* an immediate */
+	USSE_I,		/* internal registers */
+};
+
+/* By bank | extension << 2 (dst, src) or << 1 (src0, dst1). */
+static const u8 dst_files[8] = {
+	USSE_R, USSE_O, USSE_PA, USSE_INDEXED, USSE_SA, USSE_CG, USSE_IDX, USSE_I,
+};
+
+static const u8 src_files[8] = {
+	USSE_R, USSE_O, USSE_PA, USSE_SA, USSE_INDEXED, USSE_CG, USSE_IMM, USSE_I,
+};
+
+static const u8 src0_files[4] = { USSE_R, USSE_PA, USSE_O, USSE_SA };
+
+/* g46 on (number 110) is undocumented; i0-i3 and idx1-idx2 are what exists. */
+#define USSE_CG_END		110
+#define USSE_I_LAST		3
+
+static bool usse_slot_ok(const struct pvrsgx_usse_slot *s, u64 w)
+{
+	bool sel = (s->fmt & 0x80) && (w & BIT_ULL(s->fmt & 0x3f));
+	u32 v = 0, n, file;
+
+	if (s->when != USSE_ALWAYS && !(w & BIT_ULL(s->when)))
+		return true;
+	for (int i = 0; i < USSE_MAX_PIECES && s->p[i].width; i++)
+		v |= ((w >> s->p[i].lo) & GENMASK_ULL(s->p[i].width - 1, 0)) << s->p[i].shift;
+	n = v & 0x7f;
+	switch (s->kind) {
+	case USSE_SLOT_DST:
+		file = dst_files[(v >> 7) & 7];
+		break;
+	case USSE_SLOT_SRC:
+		file = src_files[(v >> 7) & 7];
+		break;
+	case USSE_SLOT_SRC0:
+		file = src0_files[(v >> 7) & 3];
+		break;
+	case USSE_SLOT_DST1:
+		file = (v >> 7) & 1 ? USSE_PA : USSE_R;
+		break;
+	default:
+		return false;
+	}
+	/* Bit 6 is a flag only where the format says so; elsewhere it counts. */
+	if (sel || (s->fmt == USSE_C10 && file == USSE_I))
+		n &= 0x3f;
+	switch (file) {
+	case USSE_CG:
+		/* Read only: what writing c or g does isn't known. */
+		return s->kind != USSE_SLOT_DST && n < USSE_CG_END;
+	case USSE_I:
+		return n <= USSE_I_LAST;
+	case USSE_IDX:
+		return n == 1 || n == 2;
+	default:
+		return true;
+	}
+}
+
+/* br's and phas.i's targets: l0-17, in instructions. */
+#define USSE_TARGET		GENMASK_ULL(17, 0)
+
+static s64 refuse(enum pvrsgx_usse_refusal *why, enum pvrsgx_usse_refusal r, u32 i)
+{
+	if (why)
+		*why = r;
+	return i;
+}
+
+/**
+ * pvrsgx_usse_scan() - Check USSE code before it goes into a code object
+ * @isa: The core's instruction set.
+ * @w: The instructions.
+ * @n: Number of @w.
+ * @first: Instruction index @w[0] will sit at in the object.
+ * @obj_insts: The object's size in instructions.
+ * @place: The object's start, in instructions from the start of the code base
+ *	window it is mapped in, or %PVRSGX_USSE_PLACE_NONE. An absolute target
+ *	(phas.i) needs it, and an object with one must lie in one window.
+ * @abs: Set when an instruction has an absolute target.
+ * @why: If not NULL, why the instruction returned was refused.
+ *
+ * Linear in @n, no allocation.
+ *
+ * Return: the index in @w of the first refused instruction, or -1.
+ */
+s64 pvrsgx_usse_scan(enum pvrsgx_isa isa, const u64 *w, u32 n, u32 first, u32 obj_insts,
+		     s64 place, bool *abs, enum pvrsgx_usse_refusal *why)
+{
+	const struct pvrsgx_usse_form *forms = isas[isa].forms;
+
+	if (why)
+		*why = PVRSGX_USSE_REFUSAL_NONE;
+	for (u32 i = 0; i < n; i++) {
+		const struct pvrsgx_usse_form *f = NULL;
+		s64 target;
+
+		for (u32 k = 0; k < isas[isa].n; k++) {
+			if ((w[i] & forms[k].mask) == forms[k].match) {
+				f = &forms[k];
+				break;
+			}
+		}
+		if (!f)
+			return refuse(why, PVRSGX_USSE_REFUSAL_FORM, i);
+		for (int k = 0; k < USSE_MAX_SLOTS; k++) {
+			const struct pvrsgx_usse_slot *s = &pvrsgx_usse_slots[f->slots][k];
+
+			if (s->kind != USSE_SLOT_NONE && !usse_slot_ok(s, w[i]))
+				return refuse(why, PVRSGX_USSE_REFUSAL_OPERAND, i);
+		}
+		switch (f->kind) {
+		case USSE_OK:
+			break;
+		case USSE_BR:
+			target = (s64)first + i + sign_extend64(w[i] & USSE_TARGET, 17);
+			if (target < 0 || target >= obj_insts)
+				return refuse(why, PVRSGX_USSE_REFUSAL_BRANCH, i);
+			break;
+		case USSE_PHAS:
+			/* 0: no next phase. Otherwise from the task's code base. */
+			target = w[i] & USSE_TARGET;
+			if (!target)
+				break;
+			if (place == PVRSGX_USSE_PLACE_NONE || target < place ||
+			    target >= place + obj_insts ||
+			    place + obj_insts > (s64)PVRSGX_USSE_WINDOW_INSTS)
+				return refuse(why, PVRSGX_USSE_REFUSAL_PHAS, i);
+			*abs = true;
+			break;
+		default:
+			return refuse(why, PVRSGX_USSE_REFUSAL_KIND, i);
+		}
+	}
+	return -1;
+}
+
+const char *pvrsgx_usse_refusal_name(enum pvrsgx_usse_refusal why)
+{
+	static const char *const names[] = {
+		[PVRSGX_USSE_REFUSAL_NONE] = "none",
+		[PVRSGX_USSE_REFUSAL_FORM] = "no known form",
+		[PVRSGX_USSE_REFUSAL_OPERAND] = "operand",
+		[PVRSGX_USSE_REFUSAL_KIND] = "refused instruction",
+		[PVRSGX_USSE_REFUSAL_BRANCH] = "branch target outside the object",
+		[PVRSGX_USSE_REFUSAL_PHAS] = "phase target outside the object",
+	};
+
+	return why < ARRAY_SIZE(names) ? names[why] : "?";
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.h
new file mode 100644
index 000000000..c63b883c6
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_USSE_H
+#define PVRSGX_USSE_H
+
+#include <linux/bits.h>
+#include <linux/limits.h>
+#include <linux/types.h>
+
+#include "pvrsgx_core.h"
+
+/* A code object's place when it isn't mapped, or is mapped at more than one. */
+#define PVRSGX_USSE_PLACE_NONE	S64_MIN
+
+/*
+ * One code base's window, in instructions: 512 KiB. A task's absolute targets
+ * (phas.i) count from the base its PDS program names, which a compiler sets to
+ * the window of the task's first word.
+ */
+#define PVRSGX_USSE_WINDOW_INSTS	BIT(16)
+
+/* Why pvrsgx_usse_scan() refused an instruction. */
+enum pvrsgx_usse_refusal {
+	PVRSGX_USSE_REFUSAL_NONE,
+	/* Not exactly one known form. */
+	PVRSGX_USSE_REFUSAL_FORM,
+	/* An operand's register file or number. */
+	PVRSGX_USSE_REFUSAL_OPERAND,
+	/* A form that is refused outright. */
+	PVRSGX_USSE_REFUSAL_KIND,
+	/* br's target outside the object. */
+	PVRSGX_USSE_REFUSAL_BRANCH,
+	/*
+	 * phas.i's target outside the object, the object has no one place, or it
+	 * crosses a code base window.
+	 */
+	PVRSGX_USSE_REFUSAL_PHAS,
+};
+
+s64 pvrsgx_usse_scan(enum pvrsgx_isa isa, const u64 *w, u32 n, u32 first, u32 obj_insts,
+		     s64 place, bool *abs, enum pvrsgx_usse_refusal *why);
+const char *pvrsgx_usse_refusal_name(enum pvrsgx_usse_refusal why);
+
+#endif /* PVRSGX_USSE_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_usse_table.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_usse_table.h
new file mode 100644
index 000000000..1a0b09063
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_usse_table.h
@@ -0,0 +1,342 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The USSE forms, their operand slots and what the validator does with
+ * each, generated by gen_usse_table.py from sgx.xml, the isaspec
+ * description of the instruction set Mesa's compiler uses; both live in
+ * the driver's source repository, https://github.com/The1TrueJoe/powervr_sgx.
+ * Each form is the bits its patterns fix; each slot the fields its operand
+ * is built from.
+ */
+
+static const struct pvrsgx_usse_slot pvrsgx_usse_slots[][USSE_MAX_SLOTS] = {
+	[0] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC0, USSE_SEL(54), USSE_ALWAYS, { { 14, 7, 0 }, { 34, 1, 7 } } },
+		{ USSE_SLOT_SRC, USSE_SEL(54), USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_SEL(54), USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[1] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_SEL(54), USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_SEL(54), USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[2] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+	},
+	[3] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS, { { 21, 7, 0 }, { 32, 2, 7 } } },
+		{ USSE_SLOT_SRC0, USSE_SEL(54), USSE_ALWAYS, { { 14, 7, 0 }, { 34, 1, 7 } } },
+		{ USSE_SLOT_SRC, USSE_SEL(54), USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_SEL(54), USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[4] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC0, USSE_NUM, USSE_ALWAYS, { { 14, 7, 0 }, { 34, 1, 7 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[5] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[6] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS, { { 21, 7, 0 }, { 32, 2, 7 } } },
+		{ USSE_SLOT_SRC0, USSE_NUM, USSE_ALWAYS,
+		  { { 14, 7, 0 }, { 34, 1, 7 }, { 38, 1, 8 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS, { { 7, 7, 0 }, { 30, 2, 7 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 39, 1, 9 } } },
+	},
+	[7] = {
+		{ USSE_SLOT_DST, USSE_SEL(50), 20, { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_SEL(50), USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_SEL(50), USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[8] = {
+		{ USSE_SLOT_DST, USSE_C10, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_C10, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_C10, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[9] = {
+		{ USSE_SLOT_DST, USSE_C10, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC0, USSE_C10, USSE_ALWAYS, { { 14, 7, 0 }, { 34, 1, 7 } } },
+		{ USSE_SLOT_SRC, USSE_C10, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_C10, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[10] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS, { { 14, 7, 0 }, { 30, 2, 7 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS, { { 7, 7, 0 }, { 30, 2, 7 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[11] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[12] = {
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 14, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[13] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 14, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[14] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+		{ USSE_SLOT_SRC0, USSE_NUM, USSE_ALWAYS,
+		  { { 14, 7, 0 }, { 34, 1, 7 }, { 47, 1, 8 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[15] = {
+		{ USSE_SLOT_DST1, USSE_NUM, USSE_ALWAYS, { { 21, 7, 0 }, { 39, 1, 7 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[16] = {
+		{ USSE_SLOT_SRC0, USSE_NUM, USSE_ALWAYS,
+		  { { 14, 7, 0 }, { 34, 1, 7 }, { 50, 1, 8 } } },
+		{ USSE_SLOT_DST1, USSE_NUM, USSE_ALWAYS, { { 21, 7, 0 }, { 39, 1, 7 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[17] = {
+		{ USSE_SLOT_DST1, USSE_NUM, USSE_ALWAYS, { { 21, 7, 0 }, { 36, 1, 7 } } },
+		{ USSE_SLOT_SRC0, USSE_NUM, USSE_ALWAYS, { { 14, 7, 0 }, { 34, 1, 7 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS, { { 7, 7, 0 }, { 30, 2, 7 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS, { { 0, 7, 0 }, { 28, 2, 7 } } },
+	},
+	[18] = {
+		{ USSE_SLOT_SRC0, USSE_NUM, USSE_ALWAYS,
+		  { { 14, 7, 0 }, { 34, 1, 7 }, { 50, 1, 8 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[19] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS, { { 21, 7, 0 }, { 32, 2, 7 } } },
+		{ USSE_SLOT_SRC0, USSE_NUM, USSE_ALWAYS,
+		  { { 14, 7, 0 }, { 34, 1, 7 }, { 51, 1, 8 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[20] = { },
+	[21] = {
+		{ USSE_SLOT_SRC0, USSE_NUM, USSE_ALWAYS,
+		  { { 14, 7, 0 }, { 34, 1, 7 }, { 51, 1, 8 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[22] = {
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+		{ USSE_SLOT_DST1, USSE_NUM, USSE_ALWAYS, { { 21, 7, 0 }, { 39, 1, 7 } } },
+	},
+	[23] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS,
+		  { { 21, 7, 0 }, { 32, 2, 7 }, { 51, 1, 9 } } },
+	},
+	[24] = {
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+	},
+	[25] = {
+		{ USSE_SLOT_DST, USSE_NUM, USSE_ALWAYS, { { 21, 7, 0 }, { 32, 2, 7 } } },
+	},
+	[26] = {
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+	},
+	[27] = {
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 0, 7, 0 }, { 28, 2, 7 }, { 48, 1, 9 } } },
+		{ USSE_SLOT_SRC, USSE_NUM, USSE_ALWAYS,
+		  { { 7, 7, 0 }, { 30, 2, 7 }, { 49, 1, 9 } } },
+	},
+};
+
+/* 109 forms, 126 entries */
+static const struct pvrsgx_usse_form pvrsgx_usse_forms[] = {
+	{ 0xf800060000000000ull, 0x0000020000000000ull, USSE_OK, 0 },	/* fadm */
+	{ 0xf800060000000000ull, 0x0000000000000000ull, USSE_OK, 0 },	/* fmad */
+	{ 0xf800060000000000ull, 0x0000040000000000ull, USSE_OK, 0 },	/* fmsa */
+	{ 0xf8000684001fc000ull, 0x0000060000000000ull, USSE_OK, 1 },	/* fsubflr */
+	{ 0xf8410600301fc07full, 0x0801040000000000ull, USSE_OK, 2 },	/* fcos */
+	{ 0xf8410600301fc07full, 0x0800060000000000ull, USSE_OK, 2 },	/* fexp2 */
+	{ 0xf8410600301fc07full, 0x0800040000000000ull, USSE_OK, 2 },	/* flog2 */
+	{ 0xf8410600301fc07full, 0x0800000000000000ull, USSE_OK, 2 },	/* frcp */
+	{ 0xf8410600301fc07full, 0x0800020000000000ull, USSE_OK, 2 },	/* frsq */
+	{ 0xf8410600301fc07full, 0x0801020000000000ull, USSE_OK, 2 },	/* fsin */
+	{ 0xf8410600301fc07full, 0x0801000000000000ull, USSE_OK, 2 },	/* fsqrt */
+	{ 0xf800060000000000ull, 0x1000020000000000ull, USSE_OK, 3 },	/* fddp */
+	{ 0xf800060000000000ull, 0x1000040000000000ull, USSE_OK, 3 },	/* fddpc */
+	{ 0xf8000684001fc000ull, 0x1000000000000000ull, USSE_OK, 1 },	/* fdp */
+	{ 0xf8000684001c4000ull, 0x1000000000004000ull, USSE_OK, 1 },	/* fdpc */
+	{ 0xf800060000000000ull, 0x1800000000000000ull, USSE_OK, 0 },	/* fmaxmin */
+	{ 0xf800060000000000ull, 0x1800020000000000ull, USSE_OK, 0 },	/* fminmax */
+	{ 0xf8000684001fc000ull, 0x2000000000000000ull, USSE_OK, 1 },	/* fdsx */
+	{ 0xf8000684001fc000ull, 0x2000020000000000ull, USSE_OK, 1 },	/* fdsy */
+	{ 0xf84107fc301fc07full, 0x2801000020000000ull, USSE_OK, 2 },	/* mov */
+	{ 0xf800077800000000ull, 0x2800050000000000ull, USSE_OK, 4 },	/* movc.c10 */
+	{ 0xf800077800000000ull, 0x2800040000000000ull, USSE_OK, 4 },	/* movc.f32 */
+	{ 0xf800077800000000ull, 0x2800020000000000ull, USSE_OK, 4 },	/* movc.i16 */
+	{ 0xf800077800000000ull, 0x2800030000000000ull, USSE_OK, 4 },	/* movc.i32 */
+	{ 0xf800077800000000ull, 0x2800010000000000ull, USSE_OK, 4 },	/* movc.u8 */
+	{ 0xf800071c001fc000ull, 0x2800060000000000ull, USSE_REFUSE, 5 },	/* op0xf3.s6 */
+	{ 0xf800071800000000ull, 0x2800070000000000ull, USSE_REFUSE, 4 },	/* op0xf3.s7 */
+	{ 0xf800000000000000ull, 0x3000000000000000ull, USSE_OK, 4 },	/* fmad16 */
+	{ 0xf800000000000000ull, 0x3800000000000000ull, USSE_OK, 6 },	/* efo */
+	{ 0xf800000000000000ull, 0x4000000000000000ull, USSE_OK, 5 },	/* pck */
+	{ 0xf800000000000000ull, 0x4800000000000000ull, USSE_OK, 7 },	/* test */
+	{ 0xf800000800000000ull, 0x5000000000000000ull, USSE_OK, 5 },	/* and */
+	{ 0xf800000800000000ull, 0x5000000800000000ull, USSE_OK, 5 },	/* or */
+	{ 0xf800000800000000ull, 0x5800000000000000ull, USSE_OK, 5 },	/* xor */
+	{ 0xf800000800000000ull, 0x6000000800000000ull, USSE_OK, 5 },	/* rol */
+	{ 0xf800000800000000ull, 0x6000000000000000ull, USSE_OK, 5 },	/* shl */
+	{ 0xf800000800000000ull, 0x6800000800000000ull, USSE_OK, 5 },	/* asr */
+	{ 0xf800000800000000ull, 0x6800000000000000ull, USSE_OK, 5 },	/* shr */
+	{ 0xf8010ff8301f007full, 0x7001000020000000ull, USSE_OK, 2 },	/* rlp */
+	{ 0xf800004c00000000ull, 0x7800000000000000ull, USSE_OK, 7 },	/* testmask */
+	{ 0xf800000000000000ull, 0x8000000000000000ull, USSE_OK, 8 },	/* sop2 */
+	{ 0xf820040000000000ull, 0x8820000000000000ull, USSE_OK, 9 },	/* lrp1 */
+	{ 0xf820040000000000ull, 0x8800000000000000ull, USSE_OK, 9 },	/* sop3 */
+	{ 0xf820040000000000ull, 0x8800040000000000ull, USSE_OK, 9 },	/* sop3l */
+	{ 0xf820040000000000ull, 0x8820040000000000ull, USSE_OK, 9 },	/* sop3x */
+	{ 0xf8000004001fc000ull, 0x9000000000000000ull, USSE_OK, 8 },	/* sopwm */
+	{ 0xf800000000000000ull, 0x9800000000000000ull, USSE_OK, 9 },	/* ima8 */
+	{ 0xf800800000000000ull, 0xa000000000000000ull, USSE_OK, 4 },	/* ima16 */
+	{ 0xf800000000000000ull, 0xa800000000000000ull, USSE_OK, 4 },	/* imae */
+	{ 0xf9308ffc001fc000ull, 0xb000000000000000ull, USSE_OK, 5 },	/* adif */
+	{ 0xf9300ff800000000ull, 0xb000004000000000ull, USSE_OK, 4 },	/* adifsum */
+	{ 0xf83000f800000000ull, 0xb020000000000000ull, USSE_OK, 4 },	/* bilin */
+	{ 0xf930400000000000ull, 0xb010000000000000ull, USSE_REFUSE, 4 },	/* op16s1 */
+	{ 0xf8320b7c00000000ull, 0xb030000000000000ull, USSE_OK, 10 },	/* ssum16 */
+	{ 0xf8320b7c00000000ull, 0xb030020000000000ull, USSE_OK, 10 },	/* ssum16.o8 */
+	{ 0xf8320b7c00000000ull, 0xb030010000000000ull, USSE_OK, 10 },	/* ssum16.s8 */
+	{ 0xf8320b7cc0003f80ull, 0xb030030000000000ull, USSE_REFUSE, 11 },	/* ssum16i */
+	{ 0xf800800400000000ull, 0xb800000400000000ull, USSE_REFUSE, 12 },	/* firh */
+	{ 0xf800000400000000ull, 0xb800000000000000ull, USSE_OK, 13 },	/* firv */
+	{ 0xf9000020001c4000ull, 0xc000000000000000ull, USSE_OK, 8 },	/* dot3 */
+	{ 0xf900002000000000ull, 0xc000002000000000ull, USSE_OK, 9 },	/* dot3s */
+	{ 0xf9000020001c4000ull, 0xc100000000000000ull, USSE_OK, 8 },	/* dot4 */
+	{ 0xf900002000000000ull, 0xc100002000000000ull, USSE_OK, 9 },	/* dot4s */
+	{ 0xf800000000000000ull, 0xc800000000000000ull, USSE_OK, 9 },	/* fpma */
+	{ 0xf930000800000000ull, 0xd000000000000000ull, USSE_OK, 14 },	/* ima32 */
+	{ 0xf9388f7e001fc000ull, 0xd010000000000000ull, USSE_REFUSE, 15 },	/* op1adrc */
+	{ 0xf800000000000000ull, 0xd800000000000000ull, USSE_REFUSE, 3 },	/* fdual */
+	{ 0xf808000200000000ull, 0xe000000000000000ull, USSE_OK, 16 },	/* smp */
+	{ 0xf840000800000000ull, 0xe840000000000000ull, USSE_OK, 17 },	/* eld.d */
+	{ 0xf840000800000000ull, 0xe840000800000000ull, USSE_OK, 17 },	/* eld.q */
+	{ 0xf840000000000000ull, 0xe800000000000000ull, USSE_OK, 16 },	/* ld */
+	{ 0xf80000800fe00000ull, 0xf000000000000000ull, USSE_OK, 18 },	/* st */
+	{ 0xff30f00000000000ull, 0xf930000000000000ull, USSE_OK, 19 },	/* atst8 */
+	{ 0xf87fe1fffffc0000ull, 0xf800000000000000ull, USSE_REFUSE, 20 },	/* ba */
+	{ 0xff7fe3fffffc0000ull, 0xf800004000000000ull, USSE_BR, 20 },	/* br */
+	{ 0xff7fe3fffffc0000ull, 0xf900004000000000ull, USSE_BR, 20 },	/* br */
+	{ 0xff7fe3fffffc0000ull, 0xfa00004000000000ull, USSE_BR, 20 },	/* br */
+	{ 0xff7fe3fffffc0000ull, 0xfb00004000000000ull, USSE_BR, 20 },	/* br */
+	{ 0xff7fe3fffffc0000ull, 0xfc00004000000000ull, USSE_BR, 20 },	/* br */
+	{ 0xff7fe3fffffc0000ull, 0xfd00004000000000ull, USSE_BR, 20 },	/* br */
+	{ 0xff7fe3fffffc0000ull, 0xfe00004000000000ull, USSE_BR, 20 },	/* br */
+	{ 0xff70f1cb0fe00000ull, 0xfb30000000000000ull, USSE_OK, 21 },	/* depthf */
+	{ 0xff30000000000000ull, 0xfb20000000000000ull, USSE_OK, 21 },	/* emit */
+	{ 0xffffb7feffffffffull, 0xf820000000000000ull, USSE_OK, 20 },	/* idf */
+	{ 0xfffb000000000000ull, 0xfc10000000000000ull, USSE_REFUSE, 20 },	/* imo */
+	{ 0xf87fe7ffffffffffull, 0xf800008000000000ull, USSE_REFUSE, 20 },	/* lapc */
+	{ 0xff7ef77ec0003f80ull, 0xfe20000000000000ull, USSE_REFUSE, 22 },	/* ldr */
+	{ 0xff30000cf0000000ull, 0xfc20000000000000ull, USSE_OK, 23 },	/* limm */
+	{ 0xfffff7ffffffff8full, 0xfd20000000000000ull, USSE_REFUSE, 20 },	/* lock */
+	{ 0xff7bf7fffffffffcull, 0xf800014000000000ull, USSE_OK, 20 },	/* nop */
+	{ 0xfffc34ff0fffc000ull, 0xf840300000000000ull, USSE_REFUSE, 24 },	/* op0x100 */
+	{ 0xff7fe7ffffffffffull, 0xf808020000000000ull, USSE_REFUSE, 20 },	/* op0x98 */
+	{ 0xfffff7ffffffffffull, 0xff20000000000000ull, USSE_OK, 20 },	/* op0xd6 */
+	{ 0xfffff7fffffffff0ull, 0xfa20000000000000ull, USSE_REFUSE, 20 },	/* op0xd7 */
+	{ 0xff7387fcf01fffffull, 0xfe10000000000000ull, USSE_REFUSE, 23 },	/* op0xfd */
+	{ 0xfffc34ff0fffc000ull, 0xf840200000000000ull, USSE_REFUSE, 24 },	/* op0xfe */
+	{ 0xfffc34ff0fffc000ull, 0xf840100000000000ull, USSE_REFUSE, 24 },	/* op0xff */
+	{ 0xff70f7c30fe00000ull, 0xf830000000000000ull, USSE_OK, 21 },	/* pcoeff */
+	{ 0xfff4f7ff0fffc000ull, 0xfa40000000000000ull, USSE_REFUSE, 24 },	/* phas */
+	{ 0xfff7df00fffc0000ull, 0xfa44000000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44010000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44020000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44070000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44080000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44090000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa440a0000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa440f0000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44100000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44110000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44120000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xfff7df00fffc0000ull, 0xfa44170000000000ull, USSE_PHAS, 20 },	/* phas.i */
+	{ 0xff7bf7ffffffffffull, 0xf830800000000000ull, USSE_OK, 20 },	/* ptoff */
+	{ 0xfffff7ffffffff8full, 0xfd20000000000001ull, USSE_REFUSE, 20 },	/* release */
+	{ 0xf87fe7fcf01fffffull, 0xf800010000000000ull, USSE_REFUSE, 25 },	/* savl */
+	{ 0xfffbffffffffffffull, 0xfd10000000000100ull, USSE_OK, 20 },	/* setfc */
+	{ 0xf87de7ff3fffc07full, 0xf80000c000000000ull, USSE_REFUSE, 26 },	/* setl */
+	{ 0xfffb000000000000ull, 0xfb10000000000000ull, USSE_REFUSE, 20 },	/* smbo */
+	{ 0xfff8ffff0fffc000ull, 0xfb18000000000000ull, USSE_REFUSE, 24 },	/* smbo.r */
+	{ 0xfffb000000000000ull, 0xfa10000000000000ull, USSE_OK, 20 },	/* smlsi */
+	{ 0xfff8ffff0fffc000ull, 0xfa18000000000000ull, USSE_REFUSE, 24 },	/* smlsi.r */
+	{ 0xfffb000000000000ull, 0xf810000000000000ull, USSE_REFUSE, 20 },	/* smoa */
+	{ 0xfff8ffff0fffc000ull, 0xf818000000000000ull, USSE_REFUSE, 24 },	/* smoa.r */
+	{ 0xfffb000000000000ull, 0xf910000000000000ull, USSE_REFUSE, 20 },	/* smr */
+	{ 0xfff8ffff0fffc000ull, 0xf918000000000000ull, USSE_REFUSE, 24 },	/* smr.r */
+	{ 0xff7cf7ff0fe00000ull, 0xfe28000000000000ull, USSE_REFUSE, 27 },	/* str */
+	{ 0xfffff7feffffffffull, 0xf920000000000000ull, USSE_OK, 20 },	/* wdf */
+};
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c
new file mode 100644
index 000000000..cf9cfcf87
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * Shader validation: what a client's USSE code may contain. The threat model
+ * is in Documentation/gpu/powervr_sgx/index.rst, "Shader validation".
+ *
+ * Client USSE code runs only from the two USSE heaps of its own VM (the code
+ * base registers cover exactly those), the USSE heaps take only code objects,
+ * and a code object's contents arrive only through UPLOAD_CODE, which checks
+ * every instruction against the form table generated from the isaspec
+ * description: its form, what the form does, and each operand's register file
+ * and number.
+ */
+
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gpuvm.h>
+#include <drm/drm_print.h>
+
+#include <linux/dma-resv.h>
+#include <linux/iosys-map.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <uapi/drm/powervr_sgx_drm.h>
+
+#include "pvrsgx_core.h"
+#include "pvrsgx_device.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_gem.h"
+#include "pvrsgx_usse.h"
+#include "pvrsgx_validate.h"
+
+static bool bo_is_code(struct pvrsgx_bo *bo)
+{
+	return bo->flags & DRM_POWERVR_SGX_BO_CODE;
+}
+
+static bool heap_is_usse(unsigned int heap)
+{
+	return heap == DRM_POWERVR_SGX_HEAP_USSE_PIXEL || heap == DRM_POWERVR_SGX_HEAP_USSE_VERTEX;
+}
+
+/* Code objects, and only they, go into the USSE heaps, read-only. */
+int pvrsgx_validate_vm_map(struct pvrsgx_device *sdev, struct pvrsgx_vm *vm,
+			   unsigned int heap, struct pvrsgx_bo *bo, u64 offset, u64 size)
+{
+	return heap_is_usse(heap) == bo_is_code(bo) ? 0 : -EINVAL;
+}
+
+static_assert(PVRSGX_USSE_WINDOW_INSTS * 8 == 1u << PVRSGX_USSE_WINDOW_LOG2);
+
+/*
+ * Where a mapping at addr of the object from offset puts the object's start,
+ * in instructions from the start of its code base window: what phas.i's
+ * targets count from when the task's PDS program names the window its first
+ * word is in. One window per object makes that base the same for every entry.
+ */
+static s64 code_place(const struct pvrsgx_heap_layout *h, u64 addr, u64 offset)
+{
+	u64 base = addr >= h->usse_vertex.base ? h->usse_vertex.base : h->usse_pixel.base;
+	s64 start = (s64)(addr - base) - (s64)offset;
+
+	if (start < 0)
+		return PVRSGX_USSE_PLACE_NONE;
+	return (start / 8) & (PVRSGX_USSE_WINDOW_INSTS - 1);
+}
+
+/*
+ * Once code with absolute targets is in an object, every mapping of it puts it
+ * where those targets were checked. Called with the object's reservation held.
+ */
+int pvrsgx_validate_vm_link(struct pvrsgx_bo *bo, u64 addr, u64 offset)
+{
+	if (!bo_is_code(bo) || !bo->code_abs)
+		return 0;
+	const struct pvrsgx_heap_layout *h = pvrsgx_heaps(to_pvrsgx_device(bo->base.base.dev));
+
+	return code_place(h, addr, offset) == bo->code_place ? 0 : -EINVAL;
+}
+
+/* The one place every mapping of obj puts it, or PVRSGX_USSE_PLACE_NONE. */
+static s64 code_place_mapped(struct drm_gem_object *obj)
+{
+	const struct pvrsgx_heap_layout *h = pvrsgx_heaps(to_pvrsgx_device(obj->dev));
+	struct drm_gpuvm_bo *vm_bo;
+	struct drm_gpuva *va;
+	s64 place = PVRSGX_USSE_PLACE_NONE;
+
+	drm_gem_for_each_gpuvm_bo(vm_bo, obj) {
+		drm_gpuvm_bo_for_each_va(va, vm_bo) {
+			s64 p = code_place(h, va->va.addr, va->gem.offset);
+
+			if (place != PVRSGX_USSE_PLACE_NONE && p != place)
+				return PVRSGX_USSE_PLACE_NONE;
+			place = p;
+		}
+	}
+	return place;
+}
+
+u32 pvrsgx_validate_pte_flags(struct pvrsgx_bo *bo)
+{
+	return bo_is_code(bo) ? SGX_MMU_PTE_READONLY : 0;
+}
+
+int pvrsgx_validate_job(struct pvrsgx_device *sdev, struct pvrsgx_job *job)
+{
+	/* A job can only reach validated USSE code: nothing to check per job. */
+	return 0;
+}
+
+int pvrsgx_ioctl_upload_code(struct drm_device *drm, void *data, struct drm_file *file)
+{
+	struct drm_powervr_sgx_ioctl_upload_code_args *args = data;
+	struct pvrsgx_device *sdev = to_pvrsgx_device(drm);
+	struct drm_gem_object *obj;
+	struct pvrsgx_bo *bo;
+	struct iosys_map map;
+	u64 end, *buf;
+	enum pvrsgx_usse_refusal why;
+	s64 bad, place;
+	bool abs = false;
+	int err;
+
+	args->bad_offset = ~0ull;
+	if (args->flags || !args->size || !IS_ALIGNED(args->size, 8) ||
+	    !IS_ALIGNED(args->offset, 8) || check_add_overflow(args->offset, args->size, &end))
+		return -EINVAL;
+
+	obj = drm_gem_object_lookup(file, args->handle);
+	if (!obj)
+		return -ENOENT;
+	bo = to_pvrsgx_bo(obj);
+	if (!bo_is_code(bo) || end > obj->size) {
+		err = -EINVAL;
+		goto out_obj;
+	}
+
+	buf = kvmalloc(args->size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto out_obj;
+	}
+	if (copy_from_user(buf, u64_to_user_ptr(args->pointer), args->size)) {
+		err = -EFAULT;
+		goto out_buf;
+	}
+	/* VM_BIND links a mapping under the same lock. */
+	err = dma_resv_lock_interruptible(obj->resv, NULL);
+	if (err)
+		goto out_buf;
+	/* An unmapped mapping counts until its jobs and the BIF invalidate are done. */
+	if ((!list_empty(&obj->gpuva.list) || atomic_read(&bo->code_unmapping)) &&
+	    args->offset < bo->code_end) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+	place = code_place_mapped(obj);
+	bad = pvrsgx_usse_scan(sdev->family->isa, buf, args->size / 8, args->offset / 8,
+			       obj->size / 8, place, &abs, &why);
+	if (bad >= 0) {
+		args->bad_offset = args->offset + bad * 8;
+		drm_dbg_driver(drm, "UPLOAD_CODE: word at 0x%llx refused: %s\n",
+			       args->bad_offset, pvrsgx_usse_refusal_name(why));
+		err = -EINVAL;
+		goto out_unlock;
+	}
+	err = drm_gem_shmem_vmap_locked(&bo->base, &map);
+	if (err)
+		goto out_unlock;
+	iosys_map_memcpy_to(&map, args->offset, buf, args->size);
+	drm_gem_shmem_vunmap_locked(&bo->base, &map);
+	bo->code_end = max(bo->code_end, end);
+	if (abs) {
+		bo->code_abs = true;
+		bo->code_place = place;
+	}
+
+out_unlock:
+	dma_resv_unlock(obj->resv);
+out_buf:
+	kvfree(buf);
+out_obj:
+	drm_gem_object_put(obj);
+	return err;
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.h
new file mode 100644
index 000000000..e4871c181
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_VALIDATE_H
+#define PVRSGX_VALIDATE_H
+
+#include <linux/types.h>
+
+struct pvrsgx_bo;
+struct pvrsgx_device;
+struct pvrsgx_job;
+struct pvrsgx_vm;
+
+struct drm_device;
+struct drm_file;
+
+/* The shader validator (Documentation/gpu/powervr_sgx/index.rst, "Shader validation"). */
+int pvrsgx_validate_vm_map(struct pvrsgx_device *sdev, struct pvrsgx_vm *vm,
+			   unsigned int heap, struct pvrsgx_bo *bo, u64 offset, u64 size);
+int pvrsgx_validate_vm_link(struct pvrsgx_bo *bo, u64 addr, u64 offset);
+u32 pvrsgx_validate_pte_flags(struct pvrsgx_bo *bo);
+int pvrsgx_validate_job(struct pvrsgx_device *sdev, struct pvrsgx_job *job);
+int pvrsgx_ioctl_upload_code(struct drm_device *drm, void *data, struct drm_file *file);
+
+#endif /* PVRSGX_VALIDATE_H */

-- 
2.50.1

