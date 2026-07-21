Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7569C44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1015310EB70;
	Tue, 21 Jul 2026 20:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nr5ZCaiV";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A1610EB47
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:24 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7eb34c17b96so7815273a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667444; x=1785272244; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8WUTP1SeYu0XxIoItMj1x7HW2i1GXPO5OoDtdjBdMko=;
 b=nr5ZCaiVtgn3nQO5PPJPViLkQfHQz/cgJhrhxWpDX+MZt8TB8YfYQ+hZyyW6XabFdg
 dTguKcM2bjhKVfe5BDZRxobPGwCqTSpxCOkvA9k2NQF2lVUcIfuqzwe/r3cZ2a6m/4Bp
 jATGuLCTrJ9z3hLoibaMzHcRUGGXkYgyVkyaN3nwAtXDnUNbOfKqN56LV/YNTtrZ6sK4
 ww13nqsVAWOQAQvxrsrUn84XpOew4ooQMip40Wht0xf3ZFYUEp3tNGISFd+xwErVTYfn
 BbrBr0K6ZX43YD7Tb/dHPR6UxPUMhnfatezf3xrU+AMY2xeyako3O92fAIxgkE8IxXpQ
 47Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667444; x=1785272244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8WUTP1SeYu0XxIoItMj1x7HW2i1GXPO5OoDtdjBdMko=;
 b=ex5P6Ce9fKXKO4V0wNFOQX+RzhwKp+dtC0eRkptIo/ON3S0nRVWUleZmo035aaEfDm
 zj7i3GAheFN6z6hXJByUx9oTezZWUG63yWGAzMn3zLcRLUNYW4QLPp7aeqRgvwKQRG6H
 DLFcJlq6Xf7KyBo3DXP13z36+s/YXduXoUyQEojGbhytMlYPOfzgP/X+O8dmBYlGZmw6
 XOHtwIb/LR4+qS+z9MWrBWQX0nk/AH22Z7B9PSoMnZsIT8+Fd2A2bM0+UQOK+mzJCiU2
 dVxW/QpTmvERz01oCSwIkU2pGv0uXww7TFyU4L9RJlON0b37Yx+ZsOJy1VFIMFQuMA3Y
 dbmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqlc9/Y4YUhotpAcpq5INDtKDwJMU+2Z5hsfXdasYr21wG+XsSSWNjDKKkSWYRTZfTeg3mEoUBG/tY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7XrnoIC95ydehIv/mUcjf4c1NjxM8I0qc/4A66pTkn5Ma8IO3
 76ltZx5EfUejVsaewWydRew6FUX9+/lWtJ9Fdwu3HjGLgTDJNJTy88Tx
X-Gm-Gg: AfdE7ck/oHI7cnzGxxM9y33ArWsA6W8Zcu6LfRaS5zMsIsnrdC5dz2iv4rtV6R1P6zH
 f+jTN4gWGNiYP154i0FDb1EPEPibHYINtF5tcNSLbxN4vMZPlOqo6BNubLVks6TnaTKdW6W3dci
 QR9gqQsDVDRPmtCWlp4wSfFYvSBASU8UaBgUIRhElhpwC55+IsF7KYjGL/NWQDPI7Q00RKo4YPT
 U4B0A4Eft+zwOzlDDmX/RPeLE187QhoPx+KIgskUJrfEq5ylZiIjWku+m+kI4+CwEU/72078yvz
 HfHlAqnuhq9l9Gn/ijfNBEC+/HEOngneI68k95nN7pMCVvJuRbW12nFcAyMDzsGetnia/A7T6Yw
 6lcPw20wv6b6iEiuxIk7eZ/37qJ/nKOWzxD8aKTiQzHBWm2/yjfdE4boxUpDn0tS1jorhlk++nq
 e0PEg9Or7pYJkHJpOscaosei09hCOGYnFapOujycjkD6+vlHj3c009s9xGg3hf5/MaAavJzvHmh
 4h3iKlEpHkBSGfvyuwApKImEw==
X-Received: by 2002:a05:6830:6406:b0:7dc:df37:844b with SMTP id
 46e09a7af769-7ed9aa450bfmr10317408a34.4.1784667443681; 
 Tue, 21 Jul 2026 13:57:23 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:59 -0600
Subject: [PATCH v7 10/29] dyndbg.lds.S: fix lost dyndbg sections in modules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-10-010fbe73b311@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=5103;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=r7cPyNH2Cq6jQDJAyzg6SZjrmdAYuNsGswuzcZ7IE5Q=;
 b=HHJhPc6cyqr0abrHwJzpK82ggYBPl5p+GL7B/HFk72Yl6DLblSLMXMT5Q0lJgAJArXRzsB0Gi
 SgK5hr4om+kB0pCbEM3Ahc4fvz8NjsyITghiAkTjVDc+RglpXjrXJ6J
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
index dd6e351d2a98..ac050552923e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9179,6 +9179,7 @@ DYNAMIC DEBUG
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
index 3758a79d0430..bd60f278f762 100644
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
index b62683061d79..2e62dc5bd5d4 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -10,6 +10,7 @@
 #endif
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -61,6 +62,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 

-- 
2.55.0

