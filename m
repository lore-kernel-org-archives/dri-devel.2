Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38BFCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467AD10F650;
	Tue,  2 Jun 2026 22:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TehuF273";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B8910F650
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:29 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso4078719f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440508; x=1781045308; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n9btmEwYy4mA0lJ0Eq1DfE2LNHPtUWEmA56rbSRa3u8=;
 b=TehuF273+kU1DWrmAnAADiyJDpM/jE0V0WEJsuZXQV8v+Y4FHerZND8KyxqLS5O3Ea
 6Z8tbeypKlhdv/IP4CLZ3Cc/XRDKHC9D0TEUd6+OU5nrPRfosG8KNp5JJMXksnxa1VlJ
 Mdq3RQWb1gGgn+P9oCSqpyGXePh2Z7QkRYC0XKnQt1ux33/JEdlAd5dg1Iq6CnNL4m49
 Dan6Gd80rEFt8bQJ9Z8jz1ruCr5R0J3SOnwMZnR/ps2O4yEegel0pZuH1uI524mkl6gL
 YsLcLr1DgPTB3Ix2XmSYhEdqjblZEv1UVb+rNkGbNeEfcpVuWPOktBdlZptf9426XZk5
 etmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440508; x=1781045308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n9btmEwYy4mA0lJ0Eq1DfE2LNHPtUWEmA56rbSRa3u8=;
 b=go09TVpAhjRaHfeMWNCNDJKlx3sMqR/7t6S/hdgUUCtulY8tluaHhaiHwTgqc4jWiG
 9IeNFpc9+GQccDwhm5r00DGNA1X1bshq6kUYJSqwShZH1Fi4MHAgebzoesnAcXzl4Pi9
 HLCfHs+nrRQELyUK/UtHXxQlUjGu3XdjGwcQkfWJYE00DZQdznrIxIwPoBFabtNBBcVr
 9EwQ1XT4uGq4MHXZ66XnV73YO1vUWfQSsR6tH1xU7xGkBFLv1e/0Pf4g68pp4hT3fRX1
 fpPQXNX4AW1qxfNUlazzKoG9KKvgVYI/tpdBSkAOxUhzrBAjTIZEQ8NI5a4hjAf4AU1S
 h+hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gtNLnl/OtSdLJ/L4HTQQ5nHBGDEpa6K9kUeregb5O5kf1QeWQPuoBi64wbcPybwdCi6dhmtZ119c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLC2GdexG6G7h8VvkpJXlspx1fRHUKePyym0F4TI3EMDGlziBE
 xLaisiwoupvDshTthNLNjWQqI5dUSJ9q7MHNf8ZodtwnJCOMy209Tg0k
X-Gm-Gg: Acq92OGXHCAE8etZAZvxRtYov4rYOgWCs77eUwg/qGfOJl1T6uTZ29cwGwMVAfZYYNI
 VxwFCYq7qD6ECHPBLxetmzc7WCIjCoGTAixWIiVMVPgwV0IKsZkBaX+YXeM9248oLDGy0Fny1Rk
 wOClCWgTFeF0qzDxf5oGqP5aJFD+ogQbKMaCNshFOH8nkEetyef3lD/gdcRRYRTq5WrLHP1/CGS
 pwX+D7awPnzzLh+6KNLuLxtVd2kM5OFA9CJeERy8ab8HQvmDY0Y6m9idqIZ2cSJEhRDHltPNtrU
 fDIiU/tH019CbWEmOXFZ7pStQLOpasqmR6+sQr14LhqbD5NkeCiDpdg8uKdcXMnln4FjFWplkXg
 /XCHKbIusnLT0H4eSY8ZINxMTlr+DIzqAvZ4GF7OvtEVrw4rOtgjphw84EpwqafBY5IqxHFHtzi
 Yz1AsieIt/eFF31oGO4ulxz50M0Cs5r4+l6L5chKbFQA==
X-Received: by 2002:a05:6000:2081:b0:45e:ed7e:f900 with SMTP id
 ffacd0b85a97d-4602178ae06mr723209f8f.6.1780440508010; 
 Tue, 02 Jun 2026 15:48:28 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:27 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:03 +0000
Subject: [PATCH v4 06/25] vmlinux.lds.h: remove redundant ALIGN(8) directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-6-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+UeoPcUgk4vgSL6bIOBGSbmEMWJGj+kcMG3jKhNS13E=;
 b=8YvEAPoW9Zb0SdA8n29Rq4/x+ymnjVU2aF9GW/hlp7J8X4pImXdIV61FGkChWr4t0qJXiM8yF
 7JUjhv70j7kA8WQegySLYFgP/s98yMXecJXL4zXvv+/zRUqWaGh7XSD
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
index 145beb14b94b..2b1becd809be 100644
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
@@ -947,12 +936,10 @@
 
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
2.54.0

