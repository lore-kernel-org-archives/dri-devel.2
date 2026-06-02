Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881E1CD6E64
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E561410F651;
	Tue,  2 Jun 2026 22:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rdwUSzzk";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671BF10F665
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:38 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso31284f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440517; x=1781045317; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
 b=rdwUSzzkTgyBo+8fSook8MLvtqVTqVUgHuNV03TtRt4O5h40X9RihPzYJlDphweDY+
 mRaIVZ89ynXPOV+vyse1SkdBvPNhePSNrxv1LfrNdU3Ue3X1BWCXJ59efuL5NSIvLhDT
 LV2K7+38IC+UArUpRHZCZ+LGgseOTvoEkpZ4mMnTYOsp0c7HmnwXE01+fTtLE+6gu+9a
 /OCTCe9dWM6C8/zWV25oODjg1lE3+ahW99O05BVMGK/ODpr85MTubwdWX/PRJ/XrZsrR
 bbf9NSBcd/uj7tEdT2XGcm/msKv3e+KSmjzto2NlIT/pDYU7hZTEugkHmYrvLDUvhdlV
 UGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440517; x=1781045317;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
 b=E2y/o6nqrOSKKWekSbV/RU34OuRjQNxesG7oG5NAxKLWNt0nGPw0NuKyQPjGCEz8sI
 22KXp+hBMejsiekM/2B1dkpdcU3mgTCIULrZlbJifhd8NerJX/1No01X4RwU11JTq1O6
 g7tlRzv9/ASzNhXe0XPDbrdUKZ3cWxAm/RvVhbvMXQr4BTNrlFlf4SPG4yHtfomCFHmK
 mxfhRQFfmYDH4RLxMHBIKHd+v8snbY0/zbiofJPJMQSaTrIEqcjLyn/kNwTSb22rDvPM
 t3EQun7SEQkO8/GUMIAnQo2FtRe7sFD82b3QiWs1osdVsEffx76XwsrN8ia1UduC3ugn
 0NNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TlbNQqYOutm82YLaKqf/NENh5Ft8fooStBs3SGkNZqc9GACgNeMCnjP4jnhPQW1UnzPcirCZ4weU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzezku7nCkW/QuixwberzS+9zCnJIQ07o/+sTo5JIYzziWnqLno
 kHt4sLDKG3lk6DR0vT7PcLrMYy/RPMB8u8f6hTo5pxfK0dBq5YsdktCJ
X-Gm-Gg: Acq92OHAjZZTRdAlb8BSfEZqMasLerO3VwtqLlFRHFw+PEHyYA0gSzF4dhMirYMsJrp
 TGbVLKc1G/5U1TtgWT4ThbQrjADhI79h2u7/aMp5i+rQP57fIj2t5w4LNUZAtVstS5BIIEZFJ1A
 fpohBGdXLhon6ADIJROwnHLbtgA2OmCUUkRt8O24wALZfapZNiJD+G1uWpe2/UWMkexu61ZIajd
 7q7rTgKfg4kSCTDR8Hd70LDt8Hj/8/g2eLkU5EV/uBUEsZW8yld651sXPn0WbjB0HzNgSFBlgDa
 Hevm9vylFuan+WP43+FtMSBu6hySKxw00wR4DfW81/OmhPKsgy/hL+P4P6+mTjmMoYuBGp+xQtR
 6vQBXWhpENaB0Fdj+44GwLrsehIa6Yc2ohTfg7Hc0yCaCawfFlzszE7PI/tec/h+jGkzsroQ5Co
 RDqg0C3Cw2upAhuMQvcpwd0Hyc3hLOKehbbeows0uYyw==
X-Received: by 2002:a05:6000:41cc:b0:457:ff13:b2a4 with SMTP id
 ffacd0b85a97d-460212d45famr957487f8f.3.1780440516932; 
 Tue, 02 Jun 2026 15:48:36 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:06 +0000
Subject: [PATCH v4 09/25] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-9-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
 b=yKRcSUGKJPF1N81xOkwGdUsrGS5e7k+0oxRa79SHVcqZnYwsk+bAI6TglGb/cerMPabg8MXRZ
 vNNsAP0WXz6D3Gpiqi344zOSBq0aoaRivT8jjMznCdZuOtdT7emOwdg
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

