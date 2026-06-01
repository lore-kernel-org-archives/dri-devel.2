Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C212CD6E5D
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC86411326F;
	Mon,  1 Jun 2026 12:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i12lQXmI";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1002711326E
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:16 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so2984837f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315514; x=1780920314; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n9btmEwYy4mA0lJ0Eq1DfE2LNHPtUWEmA56rbSRa3u8=;
 b=i12lQXmIHM1zkCLW3sOK29CgoiPOmLxMQ5D4RaYDaB8rueCJ6QSits887Et6VlC4p9
 DpZ216Royd9HtjM3n/4IDDDBQ2BwQM8ULvqGkIcyDb2JS78SHFx1T3FXmobBMRd0xWMf
 tKcf+cCYiZjG2lgdfWO9lZLxIoCDokWal9PkkwtYgKCrw4xO0rmf/IrXAVL5SxDal3ok
 E0MYlyQm0iiy4mQMWI0P+w61s59MqqdLijv1EZPFiH4d9RyAT9EQNASb3TpShUdXfLt7
 AM/6jFNLlQW/8zveNNu8/3zGsorr07mTuCAzwBgTU3hLSvDf4U7Nkm8Dso+2g06S/EqO
 lcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315514; x=1780920314;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n9btmEwYy4mA0lJ0Eq1DfE2LNHPtUWEmA56rbSRa3u8=;
 b=I1PUI5QywjbAi5/w3zw1tWMdjTY+Eu+26AVeV9TNybFEFUzfvkHhGKvTAzpFwbO3xF
 0P8mtghxtVoXCt/wPwF48mXIOXTkE9OQDjv7kVHE+WRpA4RvR9FqqfHRU2dyjcMRtheY
 sterIj6pbTlXAsyqSIfzvmInu3ZC4FPjLGNlDwYuw5XHYB9moO+FY0zp9odsz7hfClBO
 7srETuWYY+dkW8hyV9Z02vykdDoc/ihg24B5bWUPRy1gF07ivtycrnq9WvEItRFkcVwg
 +78f1Xip8BMK0zxVhVfP2bC2bpXOm46IIBXs414KDEodQoFTZuzbrk3YqR3EUtZWsOaq
 qvYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SjXR0R2RJqzj/whENMbSY65H7zP9nfp273zQVqladHODPJcura9FC6ebkasMqHFHa2w/xFEvM6Tw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkZZqcqZ57L9OFSYVCI3i0FSRLe3kLU0nPCXrvmG3jaPc1VkyL
 lbbCcWkhXatGCaDLTFHR8MST1gh1dJuXBv9mV3gNMWSjMsbNwCpl5uBF
X-Gm-Gg: Acq92OEFq79gnNmO8yXgg6z+kHOE0PhEYw64XHLjn0jyjLzztqUaJfx/yaRL6k9cCUm
 nUANVQuNnvfbzGsltrPD9il/fej16mpsAUbkcOdkczQYtL/J+1JOkx+J4/RTqLS+ctvHU53Pbx8
 mkyU2Me9FYFjfSNgNCttRvRigJiDyCa5X3UINpDZlL+gcIlTvVcammnomyGY53CBRoRbsJokhDd
 Pp37oYWMuy4QbqfmHhFTHh4jwGKURUOkChHQfLqew8prtQXLR2ZFrFRChbhy7ey2lELCCSCWCJU
 drriML+t6PPe6sk3xD9zNT2asixUT4OWtfqhzmVUOsB7HDIrdywEOMEfUXIDjEUw9EMVEIQJ0Kf
 8zQoA0Oy1tJfIYjxO3yu7g5dRqOZXgvCcnVVwcSKOPVvbBDsEN5Fevhj0cA0g3mamKT9ReiMBQs
 FXTWlTkX+uMIBMThkN+vkpHJueR1NqkBRqHOrLtgoEaw==
X-Received: by 2002:a05:600c:1546:b0:490:50e4:7224 with SMTP id
 5b1f17b1804b1-490a290bdf1mr200439195e9.3.1780315514334; 
 Mon, 01 Jun 2026 05:05:14 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:52 +0000
Subject: [PATCH v3 06/24] vmlinux.lds.h: remove redundant ALIGN(8) directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-6-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+UeoPcUgk4vgSL6bIOBGSbmEMWJGj+kcMG3jKhNS13E=;
 b=aehCj0PKMwAsGeX1yoA8ZPfivKihRi7JRV3fcSw/dL7t3mWFKMgDCcR0BXQduggaMx72SGO+e
 QFpbl8RtwUmAVWhr759+EI9HvVVPhBIXRwjiL5byPJQq8K/i+TNdP3k
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

