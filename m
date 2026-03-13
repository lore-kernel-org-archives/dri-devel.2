Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44C6105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2275010EBEC;
	Fri, 13 Mar 2026 13:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6vP+0xY";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB09310EBF1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:22:33 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-46702742c99so1400675b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408153; x=1774012953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
 b=P6vP+0xYxO9sZtCWii4VtPh5zzqKSuFYLYAw0VtG421GZefD8mQfEpEb/KZhx8+8e7
 1ZBCYP9X4EzER48qBQs0of/nEhW0v+LPzSjV6k2oz6Ob67ttyiwDRjoS0oMVgReLvQUa
 6SgpW0fezSZshQwOOKO135t7Roqo8KdfKymO8bMBG5EHpS4D9Cy2sjumcp5+Xe7ZsiKy
 QmKnVJbpA6CIGM24SKwVGFtSOuU/s/k0kUMPTF3Xkr7XjJpXsRnavkEHGTZ3vY+YZXIL
 P9Zz78XJbgWe2OG3xUtp2QJtDq9Oc2XQE9dDxFoFjK1RuABq2pS878adfB2TAgwOB+rA
 A8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408153; x=1774012953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
 b=d9ASqZQ6ptAHuYw9++NXom2+YYN3NdqbmLt8jTlbZ9lgJv5woPtYicvgSv6UNuyJSr
 GXc7BQLGXXO9PJZMNKHS+6DcK9q8DzSq3Wg85n5xYWBnNS8JPjpdsLdNJY8fc13HZhre
 Y2a4VhKi/D5L4KqgPNnZ3ASfpYR/MWSotYp74TsBOmgTUVZ/JCBdfZ1xDW7PxwW5QMOv
 pGfL6fl6q9Gs+vuJBhKy1vmzcPhbil89c4ZSoui0UiTJzckmbsTcwJSZ/btHE8qQwAwg
 1H1S9a4u9vpGKpHL86vK8TJYuiX5shn+MX3835iq5YM/FHTaUQGMkppOp/iqfad4gYnB
 2EMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6nplK3Y9TNgGhKCUtqFNlpZgQMd6gVdxBipEH7rGlbcFyLIq2uH1R8yaxt5XlorctmJpSRBkPWuI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRhn31HSC7ktI9Vw8SxFdkvcetwP/qzR0iYmqJK1qUWXhOnbEz
 su0nYUdDvaYDMVJQmi39J4rwcucIdUQ4+bNy8aAp8CMztKQhURjQgTUG
X-Gm-Gg: ATEYQzzkeN+8acjkoRUhM2X6A4nSzCTvv6kRx2vkuXPuf0GbpGE+h9GD4dhIR0F+MNN
 BaVt5dbeSQVBZsMQhhpQ/+3Lk4/UKw+YEAk0/c0Ot3QFL+GEQn0wDZrD1MOg5dddtef9+p2RrVF
 OVqSRjLrYHk7+lAM4HbZG54yvtlkBCUWygPd5Ko46yoB8cA/7gWajNhNIS9gmeRqPT1ojmdSMwY
 U6MgP3Js83NraM06R9UVTCxcMRc2kZabZ/WRnJR2T46YLhDNuCtWyV3Ruve+VxTtKEMz33v0ycO
 GbX0qLEDmo0w6W1qFB9OSPC5NjElnn42t2h/mLmAPoTVOOxoE9ck9tO9V4apaEYuHg9XT80OKou
 KywIJaLHjj/nkaSd5a1V9Zdnk9zSfFVmX4w10ElnMVZHTdgKoBiEeIf4ZdnYxeoUyJxO3ckTf6s
 K232i4exO2tMdpSHLsgDRY6qh2x7i5AZ1x8ZgbfrjS0Ic0W1aU
X-Received: by 2002:a05:6808:1b24:b0:450:d471:dce5 with SMTP id
 5614622812f47-4675701babbmr1567747b6e.6.1773408152897; 
 Fri, 13 Mar 2026 06:22:32 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:22:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v11 01/65] dyndbg: fix NULL ptr on i386 due to section
 alignment
Date: Fri, 13 Mar 2026 07:19:26 -0600
Message-ID: <20260313132103.2529746-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When dyndbg classmaps get used (later in this series), the
__dyndbg_classes section (which has 28 byte structs on i386), causes
mis-alignment of the following __dyndbg section, resulting in a NULL
pointer deref in dynamic_debug_init().

To fix this, employ belt + suspenders:

1. move __dyndbg section above __dyndbg_classes.  This restores it to
its original position directly after the ALIGN(8), and fixes the
immediate problem.

2. add ALIGN(8) to the BOUNDED_SECTION* macros.  This aligns all
existing sections using the macro, and also fixes a future
dyndbg_class_* addition which would suffer the same misalignment on
i386.  Many of the existing macro uses already have a preceding ALIGN,
these are now redundant, but are harmless, so are left to avoid churn.

3. remove BOUNDED_SECTION* uses in ORC_UNWINDER sections.  These have
smaller alignments, *and* scripts/sorttable.c does not tolerate the
added ALIGN(8) padding.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601211325.7e1f336-lkp@intel.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeb070f330bd..a2ba7e3d9994 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -212,11 +212,13 @@
 #endif
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
 	_END_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
 	_label_##_END_ = .;
@@ -383,8 +385,8 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
 	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
@@ -867,15 +869,21 @@
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
 	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+		__start_orc_header = .;					\
+		KEEP(*(.orc_header))					\
+		__stop_orc_header = .;					\
 	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
+		__start_orc_unwind_ip = .;				\
+		KEEP(*(.orc_unwind_ip))					\
+		__stop_orc_unwind_ip = .;				\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
+		__start_orc_unwind = .;					\
+		KEEP(*(.orc_unwind))					\
+		__stop_orc_unwind = .;					\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\
-- 
2.53.0

