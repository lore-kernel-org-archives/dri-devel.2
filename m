Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015B5C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC3110EB4C;
	Tue, 21 Jul 2026 20:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="isfjwZob";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930EA10EB47
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:23 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so6587485a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667442; x=1785272242; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mIr7EDzYU51k5dwRJ4xyktkhZnjgQlPT6aQVBoqHtP0=;
 b=isfjwZobkcw1IFK09Xo3v+49gzx0UxISz2YYDBi23OJPfZ75Wv5yYcr+tPsUx5x0Z5
 a1MzRYOPBAVF901OecWQb2S9nzbI4aT0WrH3kI38PmiiZZTCjU5yZaoVCKyoJUhPdJjV
 s/g88CvQFL6SJOpsWgnAgd0j5eDKpal3UjssH03eZ84ZbCQDmHa1pempSq6A25uGCxvz
 CsfnTtS+8z/+Hf+tuNmw7SvJLGWjDHgSAGgdRbBdL7/Awxsi/JDLffBd6FTz5IMone89
 HAYzYpn75YcGv0cEOekiJdYojXRxgDSyXuw6k750jFdDIBlSBsWZIFpJbokYlD8zVcbx
 ASsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667442; x=1785272242;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mIr7EDzYU51k5dwRJ4xyktkhZnjgQlPT6aQVBoqHtP0=;
 b=NfKE64c5IpWaeG6YBF+JHq6WjeDYZrPyO5M/sXmslIIt5UgreR/yu2oOIGWG7zHMyo
 hOw50oJ6U/QeAduB7hvip6PyNLRYOPG8WwFpEt6sB2f2lmRZ7CTlz9ON+VrFkTJlwu6i
 B42Lcb/A3Ho/HoixrEaUkKbKget2AbleJRuUYnQ9yNmpcYYaxTGNjya6aajCARNbspC3
 zFpcksR21a1rWTQOAOV9bLN5RsBFky6tztA2k7ux3h+5gur6GliMYOAwQ0LqpqzhIdOD
 JAWiyRjLKxVj/s8geDgce0XDm+qdeHgRzzd2/l5cm0NQbaY9gdy7lXQ95oFqsSMJsIJ2
 Pwow==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZxFSqmYQ6ROZLzB7d8annJG28IE7amVY8O70/aFDMTBQJSFn1IF1FwJn0E9Jvk0x+HeQbjExXOvs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywb8kRefDD5SlI/edQ10at2Gc3wA+bgZo1n2fa4bjdKOuNyJuAX
 Q7xbkfYeSC3epAf5SfGl9Q5034Wlbg0k3vCR+12/IwQI6wOMBg6B3pk2
X-Gm-Gg: AfdE7clAx+AJoVNOxOCbhwXgrVp1FD3V9yqbprh8WwJFrBbUZgGPnm4HaN6O13cCcDA
 vVARUXtysVGYXyQvWesealDDPafAhH2UHumGh+dQ4H92aG5vYoeODJsvW5E59Qi9+3ZY9aO6mFM
 yqi9EMkTnNwD/u1+DKJ4e33ngKirBI4SRNHweKDYJNb/Qbu4mpldBP/c3EpEe7UEF3L1JLptTQo
 POhjqdSP9PC9PbjsNHNG33S1/ZGFJ9UWhX6JpxXRq0wg1lj1LTeaOn3iZAl8BK755WpvitrQ4kf
 /n5DxOvCN1+qYhWlmKOVmmjOhuHEA2CjGrQbPPPEJinb7F4niob58vDwib4WGMOWGfzWcszgRPa
 5uY9/0/7l0QaN6GpchBTR0/77vPPlJ8T1Upq78vzxhLszFbNr5mwLmLwuRw2Kx3GGPdoiXmtQnJ
 VCkS36j0ZIBJ/xyL79Tyd9c2VuWHncFfq8PzKiaewbtCOt70+3Nsx4cONliPd/moRlcWUK/KNBC
 A+llipEb0VaqnMxeuPe84+wgw==
X-Received: by 2002:a05:6830:6adb:b0:7e9:e8a6:6389 with SMTP id
 46e09a7af769-7ed9aa576e2mr10590818a34.4.1784667442474; 
 Tue, 21 Jul 2026 13:57:22 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:58 -0600
Subject: [PATCH v7 09/29] vmlinux.lds.h: remove redundant ALIGN(8) directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-9-010fbe73b311@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=GB3dU5ZMSM1npKfwdvenqJkQ+9VdtadPzRaTWIRvhi4=;
 b=ZV0Hf5SQFYitl5dRK/Vjppu+sY3dn2KwpohorWYYcZjLdYd7AVfUYjBQZqiIJ29O3A8qWH07J
 J0XSkBAYlYPB/oHwwSJMwH8bU9EVzr39K8fIs87eSjMO5ekJ5NM9czP
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
index f29fc079e37e..3758a79d0430 100644
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
2.55.0

