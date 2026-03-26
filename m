Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131BC10AB803
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6813010EB20;
	Thu, 26 Mar 2026 18:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AtLSE+SM";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1DB410EB43
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:34 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so935267fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551274; x=1775156074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqKdylESk9B/a6b5Oi5X2s5Hl7NPYjGcR39u69Tcphw=;
 b=AtLSE+SM/cyi/AJqCyCwyl8xkqZurtAXHz4zObtgqTH5xjTI0fPfEp/yYvF4Mlq8ev
 lh4a3zdQqi+CNZYibSy0XVgUfGo7lFLcwd5E3hfUSpu2bC+DqcQaqRcDO0LBcIhUH4cg
 KcNNYTFqzj9iInmSQwB02f+Ep0845PSfj1/oi30kn6tSGBSrPUr8aUlS74koGJJUsbGj
 Gspa7dICjzplX0FaeMaKog6SCQ3zHXDuErBBlCEK1NFmvIxm4hj1Jw5aBbx6MHsSk9TK
 kWY2oMZcnqstaGXPRPDO9jPB2FtwEmn06ZEekxHJiMUV15OgFc6ZwtO1Vsl64iWdb22N
 i+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551274; x=1775156074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OqKdylESk9B/a6b5Oi5X2s5Hl7NPYjGcR39u69Tcphw=;
 b=UEkFPgo05/DaZgA5qfONjRkqR/7mbF4hPx1MCIo4nlz0m+0zvgQEMAManZ8xVtDlGQ
 pFM8d1D8cDN7jyxhJFeCXkdOi5sS8dporVSbggpTjpzdjS7bG12GwDmRvpuvz0Ukxuzq
 ROBBndrwcRV2uXqiaKMeYHzrPkPsWd/AsqimD+dmPdw8XoyIQhZdGKyGwvRU7V4XHGa4
 3j7UftNXxL2AbuDCmd8UUEKVaq206D/yaDTqB/UOk49MpmX24TLkNPo3u0L0phGYOya2
 4iWxVvkGpl1kS8/Zs05DyhPdobRbECGuuQWZ6+Sc+XRDkpXqMj4QJF8azdlYik/rNM1+
 7t8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+588fvPKgb9svOY41H4fEkK05E/WrTzVMgd/jdWEFmR8xZ0Xdjd6cLy2dkSbifsssKEYl6Tu1kNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWFQR02t8tgGKG/MdKhey8XngcrJRzOt+Ku5OGt1L7rPzFIsSL
 zYODGT1C45MTCbdvUUYKEvw46UjgK/skh817c8jTmAcCiH8ZcYvdFhes
X-Gm-Gg: ATEYQzw/9hkIYO3E7fGnsV38be3UHOY/OyusHajk/mU9IfEyn0bljkVVJctb9ADPrar
 kP44wOHSg8BDkDP+Xx0QFJ9pWe0qdcij5MstZ+MkJvFQhdkxNQf5zROAlBoXsGfoSXjkUWZCyHc
 wQN3FWzYJg9w2er3c+o3VWcTOgriPYZO0hfzmYo6LmT1Bs1K7nDL+VM1wACJEz8LTUCnosz6yhe
 vZ/JxMSAv0k3f2r4Ed/jZov5esz4PJuxbjp7PhPEM7c3EujLnvCOnYnDbY6x3NV5+PNu+IPOtom
 MowPDW9tXuViNt+oqK6H1GZvRSMIuCwl+9DcuumZAEFAyx7Mk/fqwOA38mlIDyNOfAW4bcROL2+
 rBXjKQqD2e0Mj0tlgjwsjw7HoAZ3JKmh4fJ/cxU+gRmv76dUDGq0QVmR5dy74PVoLG1JSdJ7VhB
 njp8sFpK8EEMjsZnMSrln9kLh1vGdmDE61ZFSoVbiOvCmJCbIO
X-Received: by 2002:a05:6871:2b0d:b0:41c:4af:7f5f with SMTP id
 586e51a60fabf-41ca6fcdc85mr4146349fac.28.1774551273959; 
 Thu, 26 Mar 2026 11:54:33 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 03/69] dyndbg.lds.S: fix lost dyndbg sections in modules
Date: Thu, 26 Mar 2026 12:53:07 -0600
Message-ID: <20260326185413.1205870-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

In an (unused) experimental variation of this series, I had trouble
with __dyndbg* sections getting lost in drm drivers.  While it didn't
happen in this series, it exposed a non-obvious weakness.  So fix it,
by following the model demonstrated in codetag.lds.h.

Introduce include/asm-generic/dyndbg.lds.h, with 2 macros:

DYNDBG_SECTIONS moves the 2 BOUNDED_SECTION_BY calls from DATA_DATA in
vmlinux.lds.h, which now includes the file and calls the new macro.

MOD_DYNDBG_SECTIONS also has the 2 BOUNDED_SECTION_BY calls, but wraps
them with output section syntax to keep them as known and separate ELF
sections in the module.ko.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/dyndbg.lds.h  | 19 +++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 include/asm-generic/dyndbg.lds.h

diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..f95683aa16b6
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	. = ALIGN(8);						\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+
+#define MOD_DYNDBG_SECTIONS()                                           \
+	__dyndbg : {							\
+		BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	}								\
+	__dyndbg_classes : {						\
+		BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)	\
+	}
+
+#endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 462f124ad457..b59f343818b0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -340,6 +340,7 @@
 /*
  * .data section
  */
+#include <asm-generic/dyndbg.lds.h>
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
@@ -353,10 +354,7 @@
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
index 054ef99e8288..8a7b0741bf8d 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -10,6 +10,7 @@
 #endif
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -60,6 +61,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 
-- 
2.53.0

