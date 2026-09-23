Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DE1C98311
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69AD410E402;
	Wed, 23 Sep 2026 22:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K7A9Vbg3";
	dkim-atps=neutral
Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com
 [74.125.231.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AFF10E402
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:34:47 +0000 (UTC)
Received: by mail-oa2-f35.google.com with SMTP id
 586e51a60fabf-48f0056ef38so1076531fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202886; x=1790807686; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X1uGbOIzIyWw0k5unFoP8BUkOpwCAhzQ9m2N8luGZ8E=;
 b=K7A9Vbg3hBrB4Z2/ZWg5BX2mz6jmiz+1S58MGPkjcE0cVQ+7BHFUePnIWmU3PDOzdk
 8jvwHketscEO6g+YMYGPmhCrEniA52LqheDVU/2iaYTpPyIC6qodJTADtOzvznGwRbJ0
 bjGVKotgn1wiknS3cHeeIv7c4vtTJ1EBbLkUooe5a9tlXMPfm+aoc0NAVk54Ws8U/OYH
 cNcz9j8NALUmyZjSVKmgf/2Tf+T/+rpB6n2IQq7SeL4/1+6NkhpDYPPO70XW6gbplV+r
 y9hz+fNWiVkzeKvMdBOKkld3qtAcUlbv9uWxuuE2M09Zpim2NWtazdzxSDb70RxIEy5j
 hK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202886; x=1790807686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X1uGbOIzIyWw0k5unFoP8BUkOpwCAhzQ9m2N8luGZ8E=;
 b=XsOncU2p59YGVz1dmuYxea1lgLPSiHkmy568Xh8K/Nir/S+acLSycmlZJqOroRS5ca
 STlJRJ8uElbYN6ErL9Uw1v6EyoCd+StEj8gwaTirG4mJXajO6FC6EkGvILgqvqNUgTZY
 58DrA/fkitTCc8t7+7o3cCo5cY9pObrNAwhLX2SSvGDvL3tAcs2qmAqNYRgS3c/es/1Y
 zNTNDrkuNaAouGg6EJ9xlGBR2kpGv4bnmMhVDThhwrKxqjP69/FtABuOoIfdSAn7AWc2
 UQ/ehLdci8omN3iVJ1BRPQXgNLexttWssFvxsgx5w57cAjKcAPhG1wsPUS19y0OEawtW
 AUXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylBbmr1wIuw8Mh46vtkxoU5gSASI4339vt8404pdy+FpAzQR0TPag8xLMI24C0xcK6MkKtGcOPYbE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lt9cOk4v4MfrhtME2/nwBfcGMtZhryNPwqVI1iBazp/wZsyInl
 7LY2+HCnIa9228ZHjuvOXIjfaM1KG2XzjjmZ1yUuMKHH8YqvQTVIRWit
X-Gm-Gg: AYBFou39esS0eP5e1BWa1bEjkxHuuCxlnV1c/Nj0OLb9/hQjeZnPxVDDKlCORULSFxy
 taHD6/ZI5NWEXlZpmPLY2JJBWJeTi8eJ90i8Z+dFnGuR2gJ9dHgX/G0L442xhMyua5xIs9ec79T
 w5atJkMArbM4TaNYyRxBf+RclFJH5z95Np1xcRlQjNZ/6JqV8EwQxHAXN7UXIZEwx0mo9R6fGj1
 S8T53aWvrTjigNLLVI5Zw1aw/JEqpfFlUfDu3V1nzbMInhLXTm5nSnyLGv3TI4xPTBZVpVtRcBB
 nvCEhlcW5+RpQXc0tMow2ZrRJXP6Y2GPdohJa/+ZTXmqLjyvqT9fas8DmvfRKjFyLYEkyXTMWst
 oXUZJcKcTRyp/fYIDDoPU2kov+qSFfvKWuY+uOgoc5Eu1VU4yLXG5nhZnTcKgp8l1BkOPaGci0k
 VGjxer/7fZzudSmhB1UV2L+Rs7c+KDkpoGGaS0i3KPheYN/SdBs7mWwIHikoysMjSKRaCvpepik
 fQupoRN+sYTN5c1xCaTonnyY4Js8olCfksfZ79wjHEj3EKK+jCjzFzbMCzkYiMvsKkLjo6g5JBJ
 aUyrKGhI5gLoj3P6ZYM=
X-Received: by 2002:a05:6808:4f6c:b0:4c4:d8a0:2773 with SMTP id
 5614622812f47-4d72df6d951mr659351b6e.32.1790202886518; 
 Wed, 23 Sep 2026 15:34:46 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:34:45 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:28 -0600
Subject: [PATCH v11 04/38] vmlinux.lds.h: Fix ALIGN(8) omission causing
 NULL ptr on i386
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-4-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=6221;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=KafV4Ai050cNwyxUNFExAF+ZpbeZ3M0y4ugVhMxmCII=;
 b=max867D2x5WnedlXC8Xh7KRH7w+xDMU16hhtAfusSKWn2//sTylUayWziSo5V8k/X2EU7YocO
 X4wQg6/urptCHhEJgHfL+RVoCPVPNK6nj+dAfldy7sGiLNwU+hIZvQ2
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

Almost all uses of the BOUNDED_SECTION macros are ALIGN(8), either
explicitly, or by being below an aligned section containing x*8 byte
objects.  The noteworthy exception is BOUNDED_SECTION(__dyndbg), which
immediately follows BOUNDED_SECTION(__dyndbg_classes).

On i386, struct _ddebug_classmap is 28 bytes, so without an explicit
ALIGN(8) in the macro, the following __dyndbg section gets misaligned,
causing a NULL ptr deref in dynamic_debug_init().

So fix this with an explicit ALIGN(8) in the existing BOUNDED_SECTION
macros, and introduce _ALIGNED variants to handle the cases with an
explicit . = ALIGN(x)

Also add explicit alignments for: EXCEPTION_TABLE, ORC_UNWIND_TABLE,
TRACEDATA, INIT_SETUP, and NOTES.

update BOUNDED_SECTION uses inside . = ALIGN(x) stanzas to use
_ALIGNED variants, but keep the outer ALIGNs so the symbols between
them are not "re-aligned".

In particular, scripts/sorttable.c does not tolerate sloppy padding.

At the top of ORC_UNWIND_TABLE, add . = ALIGN(4) to match the struct
orc_header __align() call in the code:

commit b9f174c811e3 ("x86/unwind/orc: Add ELF section with ORC version identifier")

Suggested-by: Louis Chauvet <louis.chauvet@bootlin.com>  # _ALIGNED variants.
Link: https://lore.kernel.org/lkml/177402491426.6181.12855763650074831089.b4-review@b4/
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3:

sashiko complained about NOTES and .BTF_ids.
gemini asserts that NOTES are natively 4-byte aligned, add comment repeating it.
.BTF_ids doesnt use BOUNDED_BY, since start/end isnt needed;
sashiko evidently got confused by immediately preceding usage.

v2:

sashiko picked up 2 cases, added to the explicit list above
https://sashiko.dev/#/patchset/20260515-asm-generic-1-v3-0-680b273666d4%40gmail.com
---
 include/asm-generic/bounded_sections.lds.h | 17 ++++++++++++++---
 include/asm-generic/vmlinux.lds.h          | 18 ++++++++++--------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 268cdc34389b..8ff3e3420f60 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -3,19 +3,30 @@
 #ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H
 #define _ASM_GENERIC_BOUNDED_SECTIONS_H
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+#define BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, _ALIGNED_) \
+	. = ALIGN(_ALIGNED_);						\
 	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
 	_END_##_label_ = .;
 
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, 8)
+
+#define BOUNDED_SECTION_POST_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, _ALIGNED_) \
+	. = ALIGN(_ALIGNED_);						\
 	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
 	_label_##_END_ = .;
 
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	BOUNDED_SECTION_POST_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, 8)
+
 #define BOUNDED_SECTION_BY(_sec_, _label_)				\
 	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
 
-#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
+#define BOUNDED_SECTION_BY_ALIGNED(_sec_, _label_, _ALIGNED_)		\
+	BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, __start, __stop, _ALIGNED_)
+
+#define BOUNDED_SECTION(_sec)   BOUNDED_SECTION_BY(_sec, _sec)
 
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 019072d3d391..b77a1bec38fc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -640,7 +640,7 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(__ex_table, ___ex_table)		\
+		BOUNDED_SECTION_BY_ALIGNED(__ex_table, ___ex_table, align) \
 	}
 
 /*
@@ -650,7 +650,7 @@
 #define BTF								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
-		BOUNDED_SECTION_BY(.BTF, _BTF)				\
+		BOUNDED_SECTION_BY_ALIGNED(.BTF, _BTF, PAGE_SIZE)	\
 	}								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
@@ -842,16 +842,17 @@
 
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
+	. = ALIGN(4);							\
 	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_header, _orc_header, 4)	\
 	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_unwind_ip, _orc_unwind_ip, 4)\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_unwind, _orc_unwind, 2)	\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\
@@ -879,7 +880,7 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_POST_LABEL(.tracedata, __tracedata, _start, _end) \
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.tracedata, __tracedata, _start, _end, 4) \
 	}
 #else
 #define TRACEDATA
@@ -908,13 +909,14 @@
 		*(.note.gnu.property)					\
 	}								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
-		BOUNDED_SECTION_BY(.note.*, _notes)			\
+		/* *(.note.*) are natively 4-byte aligned */		\
+		BOUNDED_SECTION_BY_ALIGNED(.note.*, _notes, 4)		\
 	} NOTES_HEADERS							\
 	NOTES_HEADERS_RESTORE
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
-		BOUNDED_SECTION_POST_LABEL(.init.setup, __setup, _start, _end)
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.init.setup, __setup, _start, _end, initsetup_align)
 
 #define INIT_CALLS_LEVEL(level)						\
 		__initcall##level##_start = .;				\

-- 
2.55.0

