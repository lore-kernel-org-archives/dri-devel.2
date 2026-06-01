Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FFDCD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BC4113274;
	Mon,  1 Jun 2026 12:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qQA+55Dp";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3857B113273
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:23 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490a7627033so11116415e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315522; x=1780920322; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
 b=qQA+55DpUP//oINxHdZVUutV3gm1FOD8IXt0ioqzWZi/1pk3tZc2eU23HdgIXo1R7f
 54bOk7BxhBXEAHsfsTIOOSn+GdoEGHQ+jTtun3R2yI0W9VEGvJoMNJgPVtEm4SuNTf3O
 MwgbiYeYGkDmt50DWl67zISV5sVoaUscb8pgAWN7kjL25XvbWxeTX7u/8gUgKSoYlS13
 61p97foyPaFZ4atcAYRbW7dQgNgn9v9qqxinxORm8iTBIvpcjw3X1Q1BYI8i+JpiAAPm
 NNW57CMnfV4ATjmiWp4JxDlk5A2NgFNEzjkZR8Vhz6KfvZMFqW9M7VQsBafKwrhgRvo3
 ivcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315522; x=1780920322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
 b=sIVh95cYHzfFfKJYxXRl3G7fWSzz+KkliEjGAbMkUsxcmDRJn8QBk8uK6tAfBDAV8j
 M/UqlD6mc7f/97gmkiSElfLMW/mmvRNiAqWEfs8E9EMiENXMcR23JEwBTnRpPmfD9D9l
 HQUFAJBQ3VH/ycxK3YQmQt3XtuPGlRutg8gMcGaI9u5z2vk47iPoCv/4IQaG4o2JPlYP
 DzhLKCbFwt8vU2/rcr7YaP0Ld+00Ux/SLCYjWgdxhUs86NijLym3gzYGh4LaB9ZM3ah4
 seMEYV82Qki/X6VXgxyynw0A8hCHetmLkRXPFZlgogSpMWhfufAhrTzr46WqnlVT5+jP
 3/tQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MZrz0DY0GvYWoyPpOTEiiXjQ+pg45xVQjgsxXmfZvT0JaUVWdpe2fxiudkOHE9cw/zguwAHqls3w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC5wAHShXfsmCtE7WsQC28SAKBbUOwvNO8QQJ9Sp6KmJg2hO+2
 3AjRVGkiJ5OysefCamz6yLwQY0nE8HJIBiYGWdOF3Adc5r309O7O9trl
X-Gm-Gg: Acq92OFRzMkDtoHchlKgyU2boL6WTKyRncP5vUZtZEyOcPI31S/w5EresWF2bjzYvhK
 Hx2MtBqknIeP4hd4rwy3NxOAiCrOkId+F6ibbUeOgVI7v0MDZN8DR+AJGwh7wvFZIDIcw2xla48
 rTIQLS/QZj9B4cD/ybUIKvCELNnlMh6Vx2iZ1sGlbduxSa/gQGCDskRH0iVU8dTDZIQ/rDWVZjx
 y0hshLI08ilDrsAM1FlCr2ALC22l/HBKORJUjiDNUYrrWmtvmq8iL/fglEQczCEZ76CtAvP6XVQ
 Y36ccwg7wAui7yF2UnhQ8ZHDh5FDy7c+nroEdzhhR3FIxn2dMiLzhigwK4fuZU1MxRUeAQ7BnoB
 RXOFbBtpuxtM0H2hLHLl2g/nrwtaNbxsBCyEXZAFq9S738zibo74vhOX9W92OE83M+1GcgOfAoR
 9ynzcJdxNQzHTSTZBiwy7AxQRbTHPwvoexho36L8h/ePWUxVfwa8eR
X-Received: by 2002:a05:600c:c0d2:10b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490a2938f7cmr143236735e9.25.1780315521656; 
 Mon, 01 Jun 2026 05:05:21 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:55 +0000
Subject: [PATCH v3 09/24] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-9-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
 b=mCaalRPbwAZWy05AH+RmNzLnWg9gvB9Y7Zw40ICDhFM/JPQZF0PXJjeUPFSkOZHwyr2XgFYzH
 m1Cpsj0zzBUCiL+DlEjp+UVmoRnPewyX4K7Im0+VZ4vutjmBmnyF51m
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
2.54.0

