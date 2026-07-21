Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A08C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDE110EB57;
	Tue, 21 Jul 2026 20:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="soSgYGdl";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B1910EB45
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:19 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so6587457a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667438; x=1785272238; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y4NFPrNHM8NGh27YAZAj6cHMKoI1eI/0WdJe3lAHUCg=;
 b=soSgYGdlA+HLqhW8gjE5JXjlb6FwQK8a+FeyQTWSARS2y0Osij4jFtj3pYsVikcRP4
 YKtxCnD9j/q2ftFza0DVSpbhulz1BNwVuLKTy8ZKPVNz9ryRyWmaO4YlHx8Svv5HxF3L
 oEGWipXw3GIkFkvAyuTM8qZ4qv8a6iKqn65Gj7xbI/A5ppA/3gbz5SpR37HgXAgo82+W
 7x/rsnEWrLtDowZURgC70NTCxFcaP1eAQsqtsazTteVQf0rztrKBs/abhuHMjPPaqbIl
 7GivlJ5bbyz8UITDT+MWHGIesNH8YHZ2fhsp0aOeT6OEIF5MAN+Oy1eCNSzeJwOlqYuP
 4Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667438; x=1785272238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y4NFPrNHM8NGh27YAZAj6cHMKoI1eI/0WdJe3lAHUCg=;
 b=bJ/qDvTGPR1biO3LcDN/Rh9GPsxyvxtW+0pbdAV1lYjzsma+ITSSsVuAIxGu38ktpO
 IUnbkaZ3eIEBek9JW2I1u0gX2THaLHT7uErnudPm7iDIe+Dj4+KOjqZcScb8DNCgZY99
 tRhiFEq59t4AWrTSuVtp2DRjGNGPdfR65ncioY/Orn3+J7Fp3oCbqJ/4BgbveVa2GpEh
 wclzpTLYNnqUr2MYYZ1y01LaVFHkKYeylGCr8U+X1Kp0w0DR5x28/9zUye4OiB9n+3r7
 x5uTLatzWgwKVt7Wvm9Necj7J1/J2GKZYDad3uhM4CghBCl3LzCA+5yBrwz0z22u7AMu
 Ybwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfbpNRDT8MjxXZAESiGfVAhwouBYl2v91e2GHoVOnd07RdNuXwt8sb/V5FB9baWsBwHQZnEp+lDN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJxvfM7ZqaYWC62GV5mjmW50LOg+/8FcL2Y2LcL3b7MAYEd8Sp
 1DMXKDCtID4ZsfVs+p3SDBR3wEs5+HgMVLQr8EAv1X2x6DCEbBrIH0NY
X-Gm-Gg: AfdE7clIy2OvQyFFGo0SznpKBtwlduD1kY23Nm5GAsgVB6vb22582OgqnEb3dlvnsOk
 33Z6BvWJLCNWJaokTdYpf8SiSZ3V2EqeK/egipHfNnf8o1+3XDNGDf/QVhQqRfYXdmgVubd7yjO
 uzGLp6n1+eVlj5Swwxzj6KsOovB3MwDD8N4bP0udj3xh8qFb0pqoR7o6DlSFuwDGjMyRxlJjDEA
 jiV1uD4OzFwTu4l52SRUPtd4zRs4kcOGpqRKqVzia2SThArJtrS9QvOejbivjqbfHtT8fG+isRC
 l+TfT/cDzFBple4kHqSrxQuLFy3qA7tOKiJoqkUvcBNdbas3zFAIcbSdJegtGO3nl9OY00UhpFd
 J0beQI8WfWp256zGR2cTNo5mtloojqb1NmuJLkGkG+9M/7BdrYvB0nQNHBY//ICkg316R0Yp6xQ
 1euJYHSm21Q2TTvMxQVBe9KmAHbKY6q5hqCqWLKn3V13Wboy9yd9LX0Px/aooEXHSoygo6aKsnM
 /1240W4DLCrH6XPrQprne+lsw==
X-Received: by 2002:a05:6830:64c9:b0:7eb:3af8:8c09 with SMTP id
 46e09a7af769-7ed9aa576edmr11770945a34.3.1784667438495; 
 Tue, 21 Jul 2026 13:57:18 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:55 -0600
Subject: [PATCH v7 06/29] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-6-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=0NmENmK0/2sRvdDIHaL4q/g343CMSJD/KWi2ZY5I1ss=;
 b=dJWJ27WqUk8fONxl4JaK5ZSZie5CaNJLzGVkKtYbqjvEm+5q2H9asVwQDtieoqiRI55uEdi9S
 E+ydmXc7WnKD6vkFx0yr6fOfmwtMO4X4a3Xyg1ysvv/m8KPsCPRGU3z
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

Move BOUNDED_SECTION_* macros to a new helper file:
include/asm-generic/bounded_sections.lds.h and include it back into
vmlinux.lds.h.  This allows its reuse later to fix a failure to keep
dyndbg sections in some circumstances.

NOTES:

These macros are only for use in vmlinux.lds.h, where the _start &
_end symbols are needed.  Modules keep sections separate in ELF
sections, with their boundaries known, so the _start and _end are not
useful, and may confuse tools not expecting them.

This patch ignores a checkpatch warning, because new file is covered
by "GENERIC INCLUDE/ASM HEADER FILES" in MAINTAINERS

CC: Arnd Bergmann <arnd@arndb.de>
CC: linux-arch@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3: move include to top
---
 include/asm-generic/bounded_sections.lds.h | 36 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h          | 31 +------------------------
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
new file mode 100644
index 000000000000..8c29293ca7fb
--- /dev/null
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H
+#define _ASM_GENERIC_BOUNDED_SECTIONS_H
+
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_BEGIN_##_label_ = .;						\
+	KEEP(*(_sec_))							\
+	_END_##_label_ = .;
+
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_label_##_BEGIN_ = .;						\
+	KEEP(*(_sec_))							\
+	_label_##_END_ = .;
+
+#define BOUNDED_SECTION_BY(_sec_, _label_)				\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
+
+#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_HDR_##_label_	= .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_label_##_HDR_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_BY(_sec_, _label_)				\
+	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
+
+#endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..f5ddf31b7f26 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -50,6 +50,7 @@
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
 
+#include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
 
 #ifndef LOAD_OFFSET
@@ -211,36 +212,6 @@
 # endif
 #endif
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	_BEGIN_##_label_ = .;						\
-	KEEP(*(_sec_))							\
-	_END_##_label_ = .;
-
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	_label_##_BEGIN_ = .;						\
-	KEEP(*(_sec_))							\
-	_label_##_END_ = .;
-
-#define BOUNDED_SECTION_BY(_sec_, _label_)				\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
-
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
 	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)

-- 
2.55.0

