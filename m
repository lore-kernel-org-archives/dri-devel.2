Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67125C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B693C10E16A;
	Wed,  8 Jul 2026 02:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C8AmcC2Y";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5463C10EF82
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:33 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-48a0ca07c38so145279b6e.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477112; x=1784081912; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mIr7EDzYU51k5dwRJ4xyktkhZnjgQlPT6aQVBoqHtP0=;
 b=C8AmcC2YFgrZMZVkQRlBNXEIpbtNYi8WZRDNuvbCdGkQ6fqW7nos2VBvyRegm9yIeE
 tKCPOZQ7uLf2OGjgiSCGzzwFdz849Z9zbdHa9RQiXYdRcIS+gZc6gtWfxepdZHHUF10Y
 QLlTDoNR57qBCQQjVo8jR+Vhj2UCfIZHf1/RKiMzfTyvSNbyYKcSKduVu0auHhL9oeEj
 sTjUYR/p4N6ZGzsiy3cmQU4jJivWPVoXGrlQbTS8i+bH5LIeEaTyIzCCXPHhpS1Hq7cr
 nEvdeEFZRoA93NibFV8B/NSGaqjPLoPDvtGWbnG+RV4uRRP2/bpHFT2D+Y44Utao0ZR2
 U3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477112; x=1784081912;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mIr7EDzYU51k5dwRJ4xyktkhZnjgQlPT6aQVBoqHtP0=;
 b=c2Q2eBzR6pRgl+6S4ii8IeyYxEWbMecLibKDzbaWgA/Scsj85SujMrBLIKkf0/Kk33
 48+herFk10nkyUFwJoH1rbHtDg0UJX+kkEblTxhJstwnwRLqkxTL/u5IxS24r3xJuRMI
 YT8ivrd4xGv3NUZKMM1SSTlXgP/AU5APY/7YKoUMxuAMqOP9kpni/L05jplXD/TEKAJg
 pE1v7vW8irQHmT68zrGPPbtU2kRL4xSfC2LcqQWV5+p9sE+pqPiRb/8YU6qIEJR7+6JL
 SSe6v4U9lhoOpwcQU0lqb4MMlm/kJQX73zmvVaZOHjuJfiYSt2F0FdaiNX368J4h50+S
 obZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+o8epm6WX5nBRdk45F+kWga9iq7HGB19Hhaoa+J/Wy1hbbdYbEfP5dvRVDhSO8qZUkeWaLaoCn310=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0WcB2AyGs/XmBYaARAK8WZXmZvZY3IjBEpNJPxV/0yM96TK4d
 FkXxdLW+b/HmFAFaHQhHW2LYHXb+IFGyoU/SHzY0/MDyS+TINF4rWqHD
X-Gm-Gg: AfdE7cnVBHWcm+VQQKpRCTO3fBBdqHdfhIAobb/tN9QxktQw0kPMG/70SQCj8S+GL7t
 2tuWDLv0Np94KoVTatZQXJXYoUMrlT2aL+KinRyxt06Cpz6EIfs0DPSPeaz6K3nSjF6yfQu3cv9
 ukicbzyKZeIzcB7aS4NIMw9mO1y7lpi5KcTAEtdJA4XFqO5afDMjJBs5ltgMiwuTMe1NZljbCvo
 35npVeJaPaDx/K16kX6eBpMPMqdAeDprBlBB+b/hEEC8CpUdjBSmeu0/n3fYBAKRQTfMLe1cwR6
 r0qz8W5fZEClJVBLLO809uDIaDMIMmUuGJDtc2nRQjQfVMAm45vDESPQ5PFX6z59yCwtwefNu49
 G75yNZdR5h+JsSPRSvKplDu2oEBqRU36EPM1O3QlCPVnjeRijzsCJ0cHHAtFDailgPKs7Q7hzEC
 4qG9eMB2z7yugatTSyODHrNfAtTH3yxZ+HHqXYTitziab1y6tRedU=
X-Received: by 2002:a05:6808:120e:b0:489:352c:5153 with SMTP id
 5614622812f47-4a203cc09c6mr359812b6e.21.1783477112483; 
 Tue, 07 Jul 2026 19:18:32 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:04 -0600
Subject: [PATCH v6 04/24] vmlinux.lds.h: remove redundant ALIGN(8) directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-4-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=GB3dU5ZMSM1npKfwdvenqJkQ+9VdtadPzRaTWIRvhi4=;
 b=ZtFvxz7HqE55HCnzDg0W6lx2AVLgDN3LiYJVZtPVeOyRYsPldS6CnPusTvdPeSPRFhpZoslbN
 cUk0y7dwxMrAwhJcP9d5Lqssiar/M7+1d8rtdXoSo3DdUKqMZLnM6Cs
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

