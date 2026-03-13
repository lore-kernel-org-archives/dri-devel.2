Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFE2105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 072E410EC05;
	Fri, 13 Mar 2026 13:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AaF/Apbi";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5AD810EC01
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:49 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-466f935a82fso1463923b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408229; x=1774013029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2MYJzJHADFhmDlQmMQlbImDYfLHhfEQ7IriPsfmok0=;
 b=AaF/Apbijun7Cv0lz+Xam8ftDdVFzHsSMtDYju7MucCTl/ZXiTSyxvYpakqzODdkUG
 +3nGdEFeASKvPJvp7vBMDriXU0MFypUQhmm3zHrKnewF60e2WYTl7IeYmBrNFiU+FOuh
 6B1JTghwuRAwjjlY76Z/anANP72NVV/jls8+fccgvuzL5tSojQtI7atMeFi+Y8VzEbQ8
 BaWTynikekUMn6GlNIYJr/srLiGoPktENs9K1eCudF5fuIu95Cu5OWjAt17PIxCQ65tD
 qvcf73HocStSBs49hYvFqM7xbPJP/BwwVfEqKm3sHbTuqpFp9aEuizwmdTr63mso3cYX
 GB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408229; x=1774013029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j2MYJzJHADFhmDlQmMQlbImDYfLHhfEQ7IriPsfmok0=;
 b=RNrf74jkv5RCUvmQ51s6wSWZKh9R7gT4wXqBhjdeYEIZOAuRdkIWmNFASECInCUjLD
 dfT2sLq4Nivf1rgtJtMuCPh8XMC3as0TRp/m32oIIjHZQV9oKhmI/Vs9SoFHaetPc/IW
 nTmGzpbmyAXhVRBnUvv5O0YNa43mq+XxxneLj6MxUUWffcoViHi3E5U+XypjWQaq68Z6
 P5WTwVJdxLEe2Kavy+JGwdVFPK6wqnqq02MGnlvzHvHrJmZXjPUat8I7cgjUcuY3GGJt
 wadm0ikMujUarNb7vvWao/jkXAiVrC7ng2WYAliWVHDbd/QREkrJ3yjQ1UGMqbc9qq8b
 aoYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSKO06rU1gmDO48VOJxk0GDi+1OG+3llQarZfIVOupOIW7ZwMDhUhHTIr1oVCLEqCF9uZn/glx4MA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyFf69mxUFq7NU2xA3JGMTknloCudflKeG8BEc7RDu9BiBfsrg
 uZ2N2jaUUJxYGPlQ8XsslrG89SMXZkKtDaW/r3R3wSAsM6IoVkAQ2kZt
X-Gm-Gg: ATEYQzy61UsR4epyVcVHilQ/QggM3rFshGSqJ8nHVLitQOP8EM5vGGDRA5Z0FYYh5A9
 SkIMB8uuMHTE3DlwUmvjOEhvUAq+0bzYHNM4rDXQhaYCUAFq7I1WnvRCXkNY/IClnI4t1ROuN6l
 HeXinR5NZ+vREPMN4cWmFAsitMK9it8cTHqypxHPF7BvGFUHNzFqHCOtWwcQ6DJYq2tkWt6e4DJ
 AjRCduZ9mjuLn/A73TLqbaZ6TrAMaMoXN2tWn5UR7V1+lpZodrkg8rCVbc/0mxHp5FgTzSN3WB+
 lBq+MNgLZ6bV6SN8vyuB2iRxCR2Pdvu+WXo8xSXlPby8fiidroxuCH2m+KFM0uLzmP5fGLMqLUz
 wuUIsc5WUBKqvcy/Ft80ljvZtA4FqChCFs4lfP+UwwC6+oV4Dvcwr5p6U+1KcPdlUMtNCrPOex5
 spv/zFT6fsgJi150twmWmVF7m4x8TanzhjDX3YcbuxBwUfcyYH
X-Received: by 2002:a05:6808:c2d1:b0:467:26e4:728e with SMTP id
 5614622812f47-467575c42d6mr1645259b6e.49.1773408228837; 
 Fri, 13 Mar 2026 06:23:48 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 24/65] dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at
 compile-time
Date: Fri, 13 Mar 2026 07:19:49 -0600
Message-ID: <20260313132103.2529746-25-jim.cromie@gmail.com>
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

Add __DYNAMIC_DEBUG_CLASSMAP_CHECK to implement the following
arg-checks at compile-time:

	0 <= _base < 63
	class_names is not empty
	class_names[0] is a string
	(class_names.length + _base) < 63

These compile-time checks will prevent several simple misuses, and
will issue obvious errors if violated.

4 such examples are added to test_dynamic_debug_submod.ko, and will
fail compilation if -DDD_MACRO_ARGCHECK is added to cflags.  This
wouldn't be a useful CONFIG_ item, since it breaks the build.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  9 +++++++++
 lib/test_dynamic_debug.c      | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 74ed18a038bd..d3889173abf3 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -181,6 +181,14 @@ struct _ddebug_class_param {
  * __pr_debug_cls(22, "no such class"); compiles but is not reachable
  */
 
+#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base)			\
+	static_assert(((_base) >= 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
+		      "_base must be in 0..62");			\
+	static_assert(ARRAY_SIZE(_clnames) > 0,				\
+		      "classnames array size must be > 0");		\
+	static_assert((ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLASS_DFLT, \
+		      "_base + classnames.length exceeds range")
+
 /**
  * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
  * @_var:   name of the classmap, exported for other modules coordinated use.
@@ -194,6 +202,7 @@ struct _ddebug_class_param {
  */
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	__DYNAMIC_DEBUG_CLASSMAP_CHECK(_var##_classnames, (_base));	\
 	extern struct _ddebug_class_map _var;				\
 	struct _ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_class_maps") _var = {		\
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 1ba4be9a403a..b2bdfdfb6ba1 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -133,7 +133,7 @@ DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
  * Enable with -Dflag on compile to test overlapping class-id range
  * detection.  This should warn on modprobes.
  */
-DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
 #endif
 
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
@@ -146,8 +146,19 @@ DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
 DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
 DYNAMIC_DEBUG_CLASSMAP_USE(map_level_num);
 
+#if defined(DD_MACRO_ARGCHECK)
+/*
+ * Exersize compile-time arg-checks in DYNAMIC_DEBUG_CLASSMAP_DEFINE.
+ * These will break compilation.
+ */
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
 #endif
 
+#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
+
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
-- 
2.53.0

