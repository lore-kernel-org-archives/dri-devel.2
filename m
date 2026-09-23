Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213DAC98312
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9430410F1F3;
	Wed, 23 Sep 2026 22:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gAQinZ4t";
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3953910E4DF
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:34:57 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-6c8f6a53fabso295225eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202896; x=1790807696; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
 b=gAQinZ4tunmpJzr8UWSh/EA+yVONbaMeM7jclzdj72AvKTmwcPobZyfnekQnTISizH
 kHJdinZR/6HtpNUagoXiv3xlt/B21mOa+yyC5M+4PA9lhagMY2rEzr78mXYlW2XAD6ma
 OwK6jCk03ePDRKcw/Ph9/7+5SrmrsKO8S39S+RKZWC1oh7AFxv6swbcze/G7GbVMsq+D
 kRDylfUawPDSlmH+CcAUsQUspzqcwIko54fd+gbMBzVKi0gBUVkjRyLB//kfe+cnHzUH
 KOfyiyhuOAf13OgAtsxpRuieB3I6V9wFvLwnWwnQaEfDXLCIH1Gzo0QQZzpAsWKoLz8y
 3+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202896; x=1790807696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
 b=CWLFVaDH0Yf4gBNyBejc/4SXbjvhlkYc1YNEWrqTvvGTLH580xRGoL/Aaa0yOMgi1N
 MJ8dPrPbgNKqA1ryB74UVcxJu9wp3hK9n9zomzHPzctKDVrWrZQ1jI+2nvgXh5awXdFW
 JuQjStybSHNEluOHbvuouiYWJyT9KH8O1yHRWfJFQxczJ2eAJfdOriTJ19o1OG16d68X
 edsvN5K3iIDOySpt639bj3MLdlALMxc+G1bHkbA/4YdBcGCo3XnljUW/qtbXK/RpPCM0
 JM4O5Kp5dKfcH1SwXwqpcp2vp6q79KQVARRz9HyZ19k0asgl9/3rXeqQ4kacLWc5qEfK
 7fUw==
X-Forwarded-Encrypted: i=1;
 AKwUvByiyNO/r1H7zZ0dix8Zy/PWWH9bGk5hoCrgmMQBAPiN4LRHv+QXNJtY5V5aq151cpGMBvYIGyieMfg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMIF7kHuGSpMbzzE/fIDCERCxmuXnHtmgvMakTqRvuIPTN1b/g
 8mWRVqWXdtRyqEmhQPvuVBdhmLDgh9cQOnw6A4y6JekUuIRSGobzKsvK
X-Gm-Gg: AYBFou0L1HReY6kdfg5XBxnykNDxvRpMhpU0j0cd3kDJCia4HdM06sbtamHoweMYcMq
 BdSYUconhOmxSHqY3BPtxRnZ8HK7qn20ZEDuNnjrgdtPnDP4E2vbZn2HYSCkgpIiaZT5bOMjizk
 tFDgg3z63sEIlI+0bWfkCfDMyUjKo/7W5PVjL+gOOXqzznFsGwnK6U1uFAtFuY1MIHBNIjqZLcm
 vBu8FDGXKYExlJ1zqWwhzyXoD5cL7wjJDAq3ROLzG5GviT0QsysEEM1SekIrbWAJcqVqcttmXt3
 OFU143kHDhG4y2xItpoDjINWgq3iDKyF4AiWyryDi/kOA2ldV0P2/FpHB/cWKj6zMLGktFq57Mn
 P+2ZspKw4lB8wsknMU5zGF5hNyvvxf/ZbDdhx9QQFMAeBKWJaO18fRImrNnX8GEBMJKHu8zRfYJ
 RFVocAX+ER+lm1FZf3HG9qaLgVB0WkpRvRSMi4t6NdSPRbUsJTm+DSzVQudpTscvN5z/pPFSXQw
 wSb/m4X5FvQXL5S9DpQ2duUWPMhvT68yy2/VQLzg2LzXkFMKW60BWstaX6p2Lj8F8v5FWrg0ySX
 2enJudwvMgTkPpU8rHs=
X-Received: by 2002:a05:6820:184b:b0:6d3:abd1:9b92 with SMTP id
 006d021491bc7-6d4417a0305mr572343eaf.56.1790202896410; 
 Wed, 23 Sep 2026 15:34:56 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:34:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:32 -0600
Subject: [PATCH v11 08/38] dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-8-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZuzqA3zGt/j9kYmFGfFlaL94NbjSKGlzcBcWBUqAWbM=;
 b=cFiUQCHIl8Z4t48oIQu3yHhG2L5LBXo/MO7Iuhjmrd9SbV9RgD25fkw2PoMOxn1mE+8jp8rxK
 3fgXCxDoibsBwlH58Y6vngo+1u7JVHUnrHhDnEm91pon7izPcbgrnXy
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

Add the stub macro for !DYNAMIC_DEBUG builds, after moving the
original macro-defn down under the big ifdef.  Do it now so future
changes have a cleaner starting point.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 05743900a116..a10adac8e8f0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -93,27 +93,6 @@ struct ddebug_class_map {
 	enum class_map_type map_type;
 };
 
-/**
- * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
- * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
- * @_base:  offset of 1st class-name. splits .class_id space
- * @classes: class-names used to control class'd prdbgs
- */
-#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
-	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
-	static struct ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_classes") _var = {			\
-		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
-		.base = _base,						\
-		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
-		.class_names = _var##_classnames,			\
-	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
-
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
@@ -138,6 +117,27 @@ struct ddebug_class_param {
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 
+/**
+ * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
+ * @_var:   a struct ddebug_class_map, passed to module_param_cb
+ * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
+ * @_base:  offset of 1st class-name. splits .class_id space
+ * @classes: class-names used to control class'd prdbgs
+ */
+#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	static struct ddebug_class_map __aligned(8) __used		\
+		__section("__dyndbg_classes") _var = {			\
+		.mod = THIS_MODULE,					\
+		.mod_name = KBUILD_MODNAME,				\
+		.base = _base,						\
+		.map_type = _maptype,					\
+		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.class_names = _var##_classnames,			\
+	}
+#define NUM_TYPE_ARGS(eltype, ...)				\
+	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
+
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -314,6 +314,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
+#define DECLARE_DYNDBG_CLASSMAP(...)
 
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)

-- 
2.55.0

