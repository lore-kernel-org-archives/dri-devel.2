Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8541BC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D7210E50C;
	Wed, 23 Sep 2026 22:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZE/AC610";
	dkim-atps=neutral
Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com
 [74.125.231.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6409410E50C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:34:52 +0000 (UTC)
Received: by mail-oi2-f43.google.com with SMTP id
 46e09a7af769-7fccd4c3f36so1559010a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202891; x=1790807691; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYBO1elgU02juqjocVCetj8tAPEOFrTtjQUE5YuJ7kQ=;
 b=ZE/AC6107JidfunGFBL8/TN8z6kEo+IuBtAE5/4RcH6iOCs3EmuzB+NaPRuM0AKmAq
 4z4oG86YSOwBzS3gZarFmxZ77miC0tg0+dsJK4DVrdBO78CUQMo9ZCihFOYIZBlOgeEb
 eU9cBzMHUW2nfTDx0wy1oDS3zwgPXnxU5Dhw6I/8Znnk1w/UBSJ1Dykri+e8gLEKDhz5
 dPgqZjyzofJAVDVP03DMyScU6OwI4LWU/yyNwcrnTTFY+4hLB1YjnOMTX/5g2r7kIudX
 TwqkiWjlSg8vukPC+VaVuVvXlM2M+xwFDrf9AXQfXaSNIHmNHBy40/NgVhfcA2z6qMsR
 pgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202891; x=1790807691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HYBO1elgU02juqjocVCetj8tAPEOFrTtjQUE5YuJ7kQ=;
 b=j68rtCwJRIFdP5DUS5++VzeX3RYj0fgJG0QtZdzsTlCwvUpKC6XUBMkjH3aDghtcuT
 mqK1tS/+j+IhKnPHbx9uev6Ej+GUkiMrx9WD/EkVJFLEH3RJMAcyjAGAPfk72eQEtawk
 dTPZnvteAVxGwc0T0DzliSWeQt6imryPSnKKmGY9IR1LtGi3JEWQIHC5zuwZPHsSKTcb
 4toOMFn9TBJ9P5hZOQDTQErudwIglFEoZ5MzGdaef4o1S20dSP31o84kooqVXBtxubef
 PDN0l9LigD7aJ2c/hQwjFNeSyJJLgMENdKIBrDtVK1K/FdcX46J34uJYkd5TMu9nH2bG
 MhVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuP2zp1lBm98TgTqv/YEEdaHyk1HlDneeZIOalEVF9FZkWMWkLS6NNMtsy1T7PywGKUm+NKiw+bkw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mzOUF40nUpfOi/+L/007X9jIZx4E9wkmoBr8hcUhdywpQ/JUhk
 rlTZql1tSC45a+0fKNl1lepcyl/gRaqWuhGPt4doDEm6z725MUKqs47X
X-Gm-Gg: AYBFou2hWHesMSgzuhCWS7thcKuf0ZwdtCMH9BcJQRSduNZji0jwXAYzrH82u7adhPG
 38m/T+e/vZnjEPGP8oI+flLRtp/ymPmCRJfi1BomfKTzKCCCkpqjVDUIXE2bejEASt5q2M4ujNE
 E731kZNy3Q7aLTmdbUR4PI2y0GiVoee202w5oMo/qEdiWQZsspmQVLgd979c+ZDLQal9H4n5oTP
 ET5fht1IXB0sOd7Ndu4mFc6dVnjCAjmaawQHpFctyvQ7fy3Qz0okXmT7pV8ol7DU4akK3Kcp3cm
 63sVTxlyLyFYhj2q0WvDZe0h07xydXNIfeeLyXxfJ1BJv8x727ey5fIYj47CDUy3dZKxmy5Txll
 t0YJXxb3U0XiglJAZfx7qiPK/jcsuUOtMjnWeY9xIaWmsp6U4BCy1Ag9ZwCV9AxiFxgZHIp3Vtl
 mGO9RaqrCgWPHT+dahO8A3+TAjtZq3bRZyv+sMO7iTZdZEY5kBNb2Y8geFU+WsCtjd/Pr/tIz9x
 ExPDcepX9Zy9r+H972+yLoSMjy5JXZ6Ns9wAHI5jMi6+0xXTMr0JcgtMV8IPKSweU6OE8h8bJ6R
 WwdJMiifnuF4KQK9x7w=
X-Received: by 2002:a05:6820:823:b0:6cd:3fdb:fa5e with SMTP id
 006d021491bc7-6d44179fef3mr638299eaf.73.1790202891371; 
 Wed, 23 Sep 2026 15:34:51 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:34:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:30 -0600
Subject: [PATCH v11 06/38] dyndbg.lds.S: fix lost dyndbg sections in
 modules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-6-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5098;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=y3lSA8Y56umPh2HgV6WBl8hk1Eie/5gIm0L03MEj1o8=;
 b=WcpmPX6A4hTWlUg2X3ONugbdk8SAN/6D/u3lSsJZ+nbEh6zbA/zDo/rbHg/QQkGuiXnzwOayV
 lz2oRKiazvqBU/t5jXfD9VYVFMp9M6ty4Gd27PRwT3Vi37djXrYr/g6
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

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, several build configs had
problems with __dyndbg* sections getting lost in drm drivers.  Fix
this by following the model demonstrated in codetag.lds.h.

Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
multiple sections together, into 2 macros:

vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
the new file and calls the new macro.

MOD_DYNDBG_SECTIONS keeps the 2 sections by name, aligns them and sets
the output address to 0 when the sections are empty.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
v3: move #includes to top, drop extra ALIGN(8) in DYNDBG_SECTIONS, add RvBy

v2: Address linker script review feedback for relocatable modules.

MOD_DYNDBG_SECTIONS() used the BOUNDED_SECTION_BY() macro, which
proved problematic for kernel modules for two reasons:

1. Unwanted Empty Sections:
   BOUNDED_SECTION_BY() automatically generates `__start` and `__stop`
   symbols. When applied to `MOD_DYNDBG_SECTIONS()`, the linker assumes
   the sections are populated due to the symbol definitions, forcing an
   empty `__dyndbg` and `__dyndbg_classes` output section in every
   compiled module, even those without dynamic debug configuration.
   Since the module loader uses `section_objs()` to locate data via
   ELF headers instead of relying on `__start`/`__stop` symbols, these
   assignments are completely unnecessary.

2. Non-zero Output Addresses:
   During relocatable linking (e.g., `ld.bfd -r`), omitting an explicit
   base address causes the section to inherit the current location
   counter. This results in non-zero sh_addr values in `.ko` files,
   which is confusing, degrades compressibility, and can cause issues
   with external tools parsing the ELF.

Fix both issues by dropping `BOUNDED_SECTION_BY()` in favor of a simple
`KEEP(*(...))` constraint and explicitly defining the sections with a `0`
base address: `__dyndbg 0 : ALIGN(8) { ... }`.

fixup-inc-vml
---
 MAINTAINERS                       |  1 +
 include/asm-generic/dyndbg.lds.h  | 18 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74790be45d06..009d628417d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9257,6 +9257,7 @@ DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
+F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..9d8951bef688
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+
+#define MOD_DYNDBG_SECTIONS()						\
+	__dyndbg 0 : ALIGN(8) {						\
+		KEEP(*(__dyndbg))					\
+	}								\
+	__dyndbg_classes 0 : ALIGN(8) {					\
+		KEEP(*(__dyndbg_classes))				\
+	}
+
+#endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 47586c6e9839..f5d508df84bf 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -52,6 +52,7 @@
 
 #include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
@@ -344,10 +345,7 @@
 	*(.data..do_once)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	DYNDBG_SECTIONS()						\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index d0f200428957..5950ff8edc31 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -5,6 +5,7 @@
  */
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -56,6 +57,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 

-- 
2.55.0

