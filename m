Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6644210AB805
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B920C10EB9B;
	Thu, 26 Mar 2026 18:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e1jrUvHJ";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E64310EB43
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:33 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-41708f6c3feso860838fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551272; x=1775156072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jl0zqIzGDZsFGD9VB82Xk4qavMNkml4BIjsBRoCBMtY=;
 b=e1jrUvHJu0y4AomU+bcHNsEKvIdx7nMJR2paZxQ+M8vtg8DXIRG31Pj15C64e1vqLt
 FfHyPNSEK4jdufdz9lj6nCJliKWApkEFmUu8avOuXHl0wotHAfWXdrPLCFqysiL1AAci
 /EmojhI8SwHhs3rBOevlWbmA6/W+7cbIB4JhK8Bg0zOidH13FRnzKjNlXcm40txTlous
 527BFv7vgIA2kO0Wxo0Eo07055Z/Bv1LMlGxVY7cDYGq7ElQCQQV4ysovILKj6HBKiBB
 HlCYKollzrRhIXEJNqAUvkgaVjBln17sfGjUR3iB7gIf+YQI65RpAwvB+NN0tL9tgi5E
 RLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551272; x=1775156072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jl0zqIzGDZsFGD9VB82Xk4qavMNkml4BIjsBRoCBMtY=;
 b=qp5H9IWxsWh8yBEBsW8nbVNQSNhxsdoLeBZrfJHSQNrotL0rww+EwbHeqSpDviz0tT
 /x+j9U2vfbO/fgr6PCCRiSVrGecdT84x3m/M1bK4APoTcrN8jbm72fAG8HtF72qchMWA
 rlYTuxqnQLoPW6+SqU4H1hu8Rt9zrHhfkOySsLkqw3twdG0qaxQnl8/P8nVU4/rx/L7e
 BKnJGkgUpR7UPy0gOyoRaI2gjlKtvBc8JgLCzHIxadvItxAqQDlYAvT3IVDng5hSg2vq
 /Jap5NjarW+mPMOcRvIiytcv5DIe3CStTrsu0uAn3YWwRAqjTlq7QfJJ3krCOcgVdXsu
 j1Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXz4dO8V5UgfJwQrIWxxbxcpo2KOrQv8yYDTlLzkZFMkyD+Y9rBGWgtG925nVRsG+kZMjgzY1hWhA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy30ZgPnC9eiLvQVtDoOkQ1TXrUP2xH27YKnkx8u7b1WfF2a4AA
 RSWIIamdmTnQr9uUeFsSbOa0aNY7HkF5oFBltj2PeEWea+GAXWj7fwSM
X-Gm-Gg: ATEYQzw7vmQKXhvMMPiTBZv2mVtmJy7GMkGrhUzMiqKhKl0AmUzLuMrr5VWqpXp6mKA
 Q2AxyO+Rd5Z07rRbFC6M48H0gWS6oEOpFauP2mpcW1PojpcUoZpLTKkZZSfpMxTdZB0PHCIWesK
 BJWPPWZjtz5v2Ux82b1RL7Jgj1lRDF7seO9bfGo3vqZrvmK7/yJ2AcO0Po5RJ+0FqFq2ovt55FZ
 /5QlT4eeBUfZAKWnvma/CFEm0M6w7YWFBExmeOlZdaczO4s9VTTOxru9fDmaOnsSPLFpPLMod9V
 oDibKGEEsW9vyUsynBRZvd+dowdLByP9esCwubLOQm8aPFKwD6vlwxlz68GemaGekZCwi7K9C/1
 5QlZjLbYH3FoLQJdcX4ff+PygalYffDON7NzyQjM7xSAN3GvXrJLLIOQ3HRoRFs73gLf9FQSJKS
 LSn17Msmd6wKF162PTBwmdT9I08XaxMTD3sATUO5WhopSzhAL0
X-Received: by 2002:a05:6870:1649:b0:40a:40d3:8727 with SMTP id
 586e51a60fabf-41ca7153b2bmr4402973fac.47.1774551272481; 
 Thu, 26 Mar 2026 11:54:32 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:32 -0700 (PDT)
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
Subject: [PATCH v12 02/69] vmlinux.lds.h: move BOUNDED_SECTION_* macros to
 reuse later
Date: Thu, 26 Mar 2026 12:53:06 -0600
Message-ID: <20260326185413.1205870-3-jim.cromie@gmail.com>
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

Move BOUNDED_SECTION_* macros to a new helper file:
include/asm-generic/bounded_sections.lds.h
and include it back into vmlinux.lds.h

This allows its reuse later to fix a future problem with modules
failing to keep dyndbg sections in some circumstances.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 36 ++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h          | 32 +------------------
 2 files changed, 37 insertions(+), 31 deletions(-)
 create mode 100644 include/asm-generic/bounded_sections.lds.h

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
new file mode 100644
index 000000000000..280a893bbe29
--- /dev/null
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H
+#define _ASM_GENERIC_BOUNDED_SECTIONS_H
+
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
+	_BEGIN_##_label_ = .;						\
+	KEEP(*(_sec_))							\
+	_END_##_label_ = .;
+
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
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
index 58daa551420b..462f124ad457 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -211,37 +211,7 @@
 # endif
 #endif
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	. = ALIGN(8);							\
-	_BEGIN_##_label_ = .;						\
-	KEEP(*(_sec_))							\
-	_END_##_label_ = .;
-
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	. = ALIGN(8);							\
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
+#include <asm-generic/bounded_sections.lds.h>
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
-- 
2.53.0

