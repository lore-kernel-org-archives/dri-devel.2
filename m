Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C753DCD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D55711326A;
	Mon,  1 Jun 2026 12:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AQ08qCEP";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0F911326A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:07 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so6961455e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315506; x=1780920306; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
 b=AQ08qCEPWMmmwPFv23/Z31SRog7Cn7PYC5BfcMmN9aqXqTphT+ZkpfL0Smd6Xfnfvh
 EOi9ltISwf1eft8YED5foK7dZV/QXpy3CSrhVspibCLXnw1rEgJUWaNjKdMszug81Qz4
 LxO498E7oAia5z2C2NYPaQNAf9foUbGj9xRyyLuO+Pkiv3DEdjZ8I80cSmZIfWLPqb//
 0vrhi89GtRlR9jreecUQxFE0YqnMBGzHXf9scCF4qaotGz145KYR7L6pEYhEuS17iz7C
 1h8hlkrJ6cHfYRASGb05MQW9khncK/pZawiX9aqzjg1UzyRlfwxh72PoSrCxfBopIiwD
 qNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315506; x=1780920306;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
 b=SdQKTaztnQOXLkT/RtaWq3mPmakhLxDmVLTpJUtWn0Ow6cbVvHs0ziNUBvufHYCp+J
 InIyCAqvnYrGiuJVbN27hxbtrdiBuW/qisj85CAo2ATqQ2BFgZs972N6GUZK3BMPbOEI
 fJG4aCIjighvJ75duQjMEW2f5wYGj4Mh5+EHOy/WDmNCLvmVcQ1ZL6b4nCbgr+7lwFTe
 6/TDktERstpPG23f1Q1OjEpPuS0KBqMxvKHulQAjvI4buJmz18SeRjDwZitZlZSCti7E
 6zlfits1GbmLLT8/KQtypsyM/qUbdHuCj9X7eiESywpq1M/vWU5Q1CxzHOR2Av9ZMKJC
 GTIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9it1UGx5x4ksidbRiewa2lskzN1mrJSSdXfTkAdjQwMUWeutaO9BmK9IrSpZZibYU3ox8m6UTzTOs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUt9BmgOAqKVL/D66zWJdJXJSiWEZ17NGF2xk+kbiyCC0IrYrj
 hbayymft0yMzS4ZkLY0oIXnJDkp3O0ef1RPnPXebiAQblDVO/EgnTK1X
X-Gm-Gg: Acq92OHhkAaGzhNwGd/xIKomZ4T37l1XIqjjhAcSyUDdsa4NLt4bCchnmtSWNEUYLwE
 0GeDCpjLHwxlSQ0goMc1jm9AIdG20uZF/FZTsM0CM4ewXluRag16uAo/6/5QPJTB3lMgLTCLZ9p
 kPCiDuFiOMbHeo0r4MXAHQSvXKGVsJalzWUSmmTBguaMezAd5TaBuIIcqCImfPZy3I2H0LRpmba
 jbMqo1Nzz/Ue6XesM71h9np1n3gwHVdPFJMA6xvHZx1Tv2NlB2+BLvlNr0D3rkQO2weDrHnQh2U
 1unYqdoJNpM1zuqvq+PygBMyzZncaBSbgyJxCusE2jXwpu6ZjSCBSL6UvHs75zVQe1IEptfHZon
 AbtScQH9HmMzJdv3CVtk6lrUAnXs1fNvNYiaWzXN/A3q1ADj/YEElcEdiCDjDM86GCR6ieeJGDC
 cGOq2NSG2U0R47eIDJhW1srQKjYldO1ztAej1Pahc+wQ==
X-Received: by 2002:a05:600c:8b53:b0:490:5380:f2cb with SMTP id
 5b1f17b1804b1-490a28d390emr196642905e9.0.1780315506191; 
 Mon, 01 Jun 2026 05:05:06 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:49 +0000
Subject: [PATCH v3 03/24] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-3-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
 b=23QYrIUZ1wxoDtn3LfFw5w6UrO7uc0VBpToTUa3IhI2RQwMNTu3xUACitTHnN+z2ok6VpXv6S
 09Unjbi/6e/C1jEzWOXpjsOo1u2YBPX4AC9D6qCB5SWs3nM4Ct+JMqo
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
index 60c8c22fd3e4..9c61dd083f26 100644
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
2.54.0

