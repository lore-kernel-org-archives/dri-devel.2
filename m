Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B442C98311
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD6B10F215;
	Wed, 23 Sep 2026 22:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jx5e2F53";
	dkim-atps=neutral
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E2E10E50C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:34:49 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-466ccdd76a9so1649341fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202889; x=1790807689; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4UQi/f5isfar5Z7OcMk/Q60vYo883RzozBQH2ZM7wKQ=;
 b=jx5e2F535ARKvLcQYmf0sWi4lFg5E2LmAmmcSGEu+/59tV2TdQkTYFWxl+pCqJnjpy
 nSAKSArNq3h+O+lySoc5ccAnuQkQ4SqW2FBDUqqJRWppKRkDYZuuURwXopmF/B26qmrn
 xeJeJwf9M60f/FQ7QSRnPAQfw4e582tpwp458SxPQGxhsC7xXbkRAozNjPdFWihoCEOt
 Ec9/RjpfXg/VYEDcypKB7BJ1n8Nn7aDzRZaEVWQu7EVhb0z359vpm6bxHec1KQH3b37w
 gOoMLYFVD+efOsTQ3peuICthZ/Ptx0AXKeZZTFuvZj/y24u5jfx3DmmT4LWC55c5bWdH
 WiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202889; x=1790807689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4UQi/f5isfar5Z7OcMk/Q60vYo883RzozBQH2ZM7wKQ=;
 b=OpWeY8eW8lx/FR1JxKUlYIUCXbKivY161o1ADFhOKN+iS5TUcDeQOlzV5lvRXEpAm+
 bzKTudDODoGL++YeGvnlsZgg7ws/v2tLu4MZnnkAdxh+ekal2DLfs7+BM1EQrAz2eUmB
 h/ISOeWyVd8fecLEWPwSBkyhuRSMVK/Mkfef5+NNLmTGR7uCJPBrYIWrhtNr4McZdxXZ
 YbQAElIpVTLRrRzj7j4HxojNveHQ8hnQtQreEVsB0uZPME24KOPH/+NAelQgmeJwpYxi
 jbKsMaz0tVu9C7IfTW3MRqtDTJj77sHn4rMGeZ1etZFkOcQvYJzi7aMIFlo79n9xBBw8
 Y8wQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwn/LJimUKEQ1JoDeqzpUzcmfGpBVmbq8Gs8IoILYXPzS0/0ZAhV2yFaUl74MsUO8FhhNgSsecaJ2E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLraJgcACpAHq2isaWY9JJkG4N8Z5p30mTTtkK1sOvcWR65+3N
 t3RQxez7vtmlaj6cfGE/Jw8ZhAr0jNrDDptASuRtgMBhNGbsihPe2kqA
X-Gm-Gg: AYBFou39NizQ40GhUA2ClR5wDdYD+3c3FecsjEonklntgsvFFKfR3hiuIm5UEcwoxgZ
 D9WqmD89sveqiFuRDqaSrLAI40GcpJXSA1wxaBj+6e+00vbdjKwvxd+nkZyhY4EFflxYMOUabpD
 wUgzI5BY0vU5SjN1MeXHXTBn9jZv1hi+U/7OADuzaaV0bDiWfTIjn0Ak/ZgLpw7I/aJ2heINJS9
 7jbwkCftF+Sain4cKrr4/FUgOjbQJfIO3Ih4giLJ/PHNV2Zo2wasgoSZEzBi2JjF88ldRS+e/Rm
 zt0D8yyFgavKjnIhlCxS1k+tBAQuP6/YffxyLw4YGI5NLlL9/DrRBtE+niXI6GkgSibTJrYDia+
 kfDNYNsGm07aCj1vRLuiTuT2BCD3XOod3jyucSlMzFzqpHn8LSfo+KSajzxdBq2wlLjis9Kzyat
 NGqKPbrw+nrJNoCet4cdOhspM+LO+X3Dr15PPOqkk5OH7PfRbzgG25vGhlB+wIt3UVzHexgj8/j
 QYvlshuee+6OgVleZnY8cBY5Svz2Ut431vXYH99rQ0K8OS5TrpoD8mMICjNx35l6qTLcr0vReu3
 sLDMMffBTKLuqYrkbFyUHg6fremZeQ==
X-Received: by 2002:a05:6870:1770:b0:456:772f:682d with SMTP id
 586e51a60fabf-491e58d53f1mr696582fac.19.1790202889087; 
 Wed, 23 Sep 2026 15:34:49 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:34:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:29 -0600
Subject: [PATCH v11 05/38] vmlinux.lds.h: remove redundant ALIGN(8) directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-5-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=l6AIJhiAS8uI/E6oLBlS30Zn+N17+e5SUNO7rKZi0c8=;
 b=YvrpsXALXEyyh89YApvvIyaONwvvC8tJK7qCvqPONwFXKFIpE7UguIUXaXdduT3IiPh4wp+G2
 2rwNPSg8wCPAThMFQSWJ6MndAatSRiatgw+NcFoElJDWHm8/i+yH05f
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

The BOUNDED_SECTION_PRE_LABEL and BOUNDED_SECTION_POST_LABEL macros
were recently updated to inherently enforce an 8-byte alignment. This
makes the explicit '. = ALIGN(8);' statements preceding 'naked' macro
calls in vmlinux.lds.h redundant.

Remove these redundant alignment directives to clean up the file and
clarify that the macros handle their own alignment padding.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b77a1bec38fc..47586c6e9839 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -228,7 +228,6 @@
 
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()				\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION(_kprobe_blacklist)
 #else
 #define KPROBE_BLACKLIST()
@@ -244,7 +243,6 @@
 
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()							\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION(_ftrace_events)					\
 	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
 #else
@@ -261,7 +259,6 @@
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define TRACE_SYSCALLS()			\
-	. = ALIGN(8);				\
 	BOUNDED_SECTION_BY(__syscalls_metadata, _syscalls_metadata)
 #else
 #define TRACE_SYSCALLS()
@@ -276,7 +273,6 @@
 
 #ifdef CONFIG_SERIAL_EARLYCON
 #define EARLYCON_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__earlycon_table, __earlycon_table, , _end)
 #else
 #define EARLYCON_TABLE()
@@ -284,11 +280,9 @@
 
 #ifdef CONFIG_SECURITY
 #define LSM_TABLE()					\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION_PRE_LABEL(.lsm_info.init, _lsm_info, __start, __end)
 
 #define EARLY_LSM_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_PRE_LABEL(.early_lsm_info.init, _early_lsm_info, __start, __end)
 #else
 #define LSM_TABLE()
@@ -314,7 +308,6 @@
 
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_acpi_probe_table,		\
 				   __##name##_acpi_probe_table,, _end)
 #else
@@ -323,7 +316,6 @@
 
 #ifdef CONFIG_THERMAL
 #define THERMAL_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_thermal_table,		\
 				   __##name##_thermal_table,, _end)
 #else
@@ -403,12 +395,10 @@
 	__end_init_stack = .;
 
 #define JUMP_TABLE_DATA							\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_BY(__jump_table, ___jump_table)
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 #define STATIC_CALL_DATA						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_BY(.static_call_sites, _static_call_sites)	\
 	BOUNDED_SECTION_BY(.static_call_tramp_key, _static_call_tramp_key)
 #else
@@ -453,7 +443,6 @@
 		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
@@ -960,12 +949,10 @@
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_POST_LABEL(.kunit_test_suites, __kunit_suites, _start, _end)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_INIT_TABLE()						\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_POST_LABEL(.kunit_init_test_suites, \
 				__kunit_init_suites, _start, _end)
 

-- 
2.55.0

