Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD76C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36BE10EF6F;
	Wed,  8 Jul 2026 02:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g2FNAOx4";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B0210EF6F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:27 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-48d6c621a67so105108b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477106; x=1784081906; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y4NFPrNHM8NGh27YAZAj6cHMKoI1eI/0WdJe3lAHUCg=;
 b=g2FNAOx4c3NG3U5g087drL7dHLQ6kteNXTIZ5hhRKPLB5JjlB0iFh5dUf9qCyvAded
 LCQ7wPHk+pwbnsNqge55jWUI5+/8kYrEnVNSE3O05b9C2s/3L2AlQOKSulmgO618ds64
 3SzLZrXegJKqWUAoArUQf7Ge5vbM5Ch7Mk0NqGt3ZdKcAH/DZI7H4AoweZPE0N/Twz3m
 cC65TmhcZla6457JmSt5Gupu1Ayx7xjoCWKPmjcn7R8TUO46rqYrz+iy+I9wj7Owk7Ao
 lPvdqDApfuKTvsZSZQm0eY+ixxigTOnde5BCXFDk1+E21FpNxaWSdJqB7elW3n5oHv8w
 2fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477106; x=1784081906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y4NFPrNHM8NGh27YAZAj6cHMKoI1eI/0WdJe3lAHUCg=;
 b=JlYEifpSp2pfeqabN5dDYwRwVXMHiSCxcxGtfbszUzBaX0Ta+oGORAYHfU+0UseQiD
 dHisNUbPYBD7eireM1ckDLRRaic8l9V3t3njmcgqvsOkM/4g/GG95INhDkJL5gouVhPd
 1REeMogYBapNX2fRFd3kaK+0wZvtrc5/dTruXGmYIT3PjW07OI5ttu1/sohu8igkjtkv
 rnKccSRDDSGaRpbc/o3M/lYkVlsMfSkjj+gEYLS7s47eUAizM+E7uCR4Kk9DooihmADc
 +vT8RFkHEY0dtK9T/ddHid+vKD4pY2cITdYn28hr3lG8QhLE/Gt7CqHflkI5pzFvoW+x
 uT1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RQYIcx5nOz+FHNdfOfQ981SX13Rpw2n1lIo0mIwd5Mq2j7Z5aCdoXJ+UPgh0m/t5TSv8o67wdx7s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzh81o6SXEjMrkG5y1yw3iG7EumYJBhA1xc7AH/1Hndr8Nr0cKH
 NCY1/aqSxEequ94tbUsKEePbyRzyySF1rbQ2gavWFJ/lEwsfkNq7s4NB
X-Gm-Gg: AfdE7cmUMlYQXlkq1C+06ykX9EeYsJUAq/H9hXpan/s7x1+MrQipWAF6nGg+FMuuvKl
 dgn/MG7LzUPkSMQqD8Mn/BlG/Ru7pMUNAQEqmz1Ugd/Z5SDDp35RGryRO/0LJcljQDcLjvUu0ve
 i6qgsgH0thiHU7dFWiZsdgN/+aaJmVK7nqXIaoCYD707W9OmZSeUsnLQL+wK+fYw5wv2h/VF6NM
 aPt2AM5zlwAyMkUVH5uW5Nhe5sfD9CeCNXZWn3O+mS2sToDWoAIrDlNicQRLx05qS8WS9Dim02M
 pKCB2qUy+FdJEmgWixx0jf3HYypzecW92jShuFRPis1AvDjg3jREH2f33Z8VOwmwavKdBeHLq6j
 ETevHR0p72f1Tr6qFSugE6uU/LWmFWmkcE2tC/aNpvYYVAK+d+0wmwzgOzR86wR1NSlKWaF3L3F
 W1FhzHwP1NkfDqqTmgRh7L9wlbJzoIDxdJ4zjqBKGxrPxIs5s5S2M=
X-Received: by 2002:a05:6808:d52:b0:497:e39e:a002 with SMTP id
 5614622812f47-4a204ce54bemr328581b6e.30.1783477106446; 
 Tue, 07 Jul 2026 19:18:26 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:01 -0600
Subject: [PATCH v6 01/24] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-1-381f3edb0045@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=0NmENmK0/2sRvdDIHaL4q/g343CMSJD/KWi2ZY5I1ss=;
 b=J5qh+4g10P6PxlYU4nAckTFiyCYyWy8E12UFb35F97Nw7iIf6MPXOCAEx5iDTUw+fHx2cU5pf
 cf9ZNbHSrxBDC+PzcTD/aLHqo1Ed7y4Hj6FhQAs+Z0+HxpF1ROodkbk
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
index 5659f4b5a125..f5ddf31b7f26 100644
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
2.55.0

