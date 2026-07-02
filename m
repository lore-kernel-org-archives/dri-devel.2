Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E103C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C502F10F4F5;
	Thu,  2 Jul 2026 16:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kq/wX2se";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725DF10F4F0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:18 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-43bfe209e45so966080fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010477; x=1783615277; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
 b=kq/wX2seFBQg6icbbu7E7dOCwW0Mbi2f8VyIOUjW5dchol9Q32IwlWMuCDjZKe9SpJ
 qkEUIjGT9mQOkTiNV1tFmfQcbc7gZ7rfNf+s7CK8PG5Kh+SDktKz3ttvSRJIHRkokWHC
 zQrJGD6fRmWNlL+woGNNdfs7sM1QfzL6k8tRlygBC2BuLvQ9+8y5IobAzht92Zkq8QBx
 naGQo6EmGLQTModw8jjLFBlxRlughkLsnhn6jVd3GB7RxVxMRYAjLKBrOYn+0ISc3l3W
 pFEzPN6OPd/KeNUPSUrJIVNF1kqsuMRqyuBFjrsSW5GZQKgU8JTw90rYREutyc6+WHWd
 VZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010477; x=1783615277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
 b=pRK5YLIMipt5GZYTA7W/AFFGe0DHfFuJXLizMC/yUCq1Bbq0L4PoFU7x9u66iRbPKf
 lWj/mU4uOsPipVUqfkonx/4NZPCcRVWJVp6+/QRaK5BSpHAwDB2oQ0VzhCciD4km4XYa
 fd5gCU67WhYV3dpPEK1Crg4kQzMXWQhppk+zSfM8sbqjq+e4Y989BeciEkYP+uSlergV
 nA/+0AOGfnnmY+c+Ppfi5XXxXGbZUWeTHdqYnW7iYI6c9yT/NvLSWxhJS4q1BlmyGEMR
 HToD4O/COUqTHtdpGkR2rtSW3R45WI+GJFpLdoRIOjwD9QqNIEU+PKgRN7zTl2qPDfeu
 loag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMDRhGXq7b+4mLAoasO8ONEXEQlF6vzSoMkytfrku+I3mUX4ODS8iLNk2xDRQhGRzXCa+yIoRQFW8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQEuxA/9u+PtGzGECV5NIUHn7SSRXB2oyVGQCVCvCo8MzG2XSF
 fpRJ9NrfKwfZAwf2x1ictkyfCdAvtYTZv6dY8f9YrmfGCnu7A8DtH9Bi
X-Gm-Gg: AfdE7cllaCc97CX7CpFbMRre3zP1letFm61b59bzFb2CpwaRLNNrdI86kFgjF3lyI7V
 tUdhXPToNFxiEDvyDTVCFIh0kjkLFPo0el73c8lvt1T16m5zvM/FNb8Vq7MrmKD6mSeFphqOqdc
 aP8qONRUJNnQlbosBHEVHNqslj/ZuKSKP+3I8zpHoljeHjACc7r7CgbK3o3eXAJzXmTWdCVsRbj
 ygKefvpwHz6d5z2nRMebqGCGtoHtLr2VyI8HeWdWeW5++KLh2YNiIh0EKP71Zk6qsf3/daConAm
 YRaO5dh6E7tyfpmMhStkWdxOF4rYtRtn/+IJM3mHPQJk0iurgwBaaQcL+jrqC/DcTmzc5tF3Xlo
 c1hR2scIb4Aaub1JU49oHnF1GDDd+EpJ++crDWsKYWU9StI4hFFg98Pls4hr+5V+S5hbQuZ8Ghz
 D8scbGj0kDiylJCnEphb2LCuFwvRbnfMh4olMfSlZ9HEBTxRk7+qK7yHA2qgxBSw==
X-Received: by 2002:a05:6871:c8ce:b0:448:501d:9c80 with SMTP id
 586e51a60fabf-44cb466ec74mr3708004fac.30.1783010477603; 
 Thu, 02 Jul 2026 09:41:17 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:54 -0600
Subject: [PATCH v5 02/18] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-2-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
 b=s3V8oxULKuOEwzd0zRiR4WVTXWzlzQAHWMQGPjEk1YtVvFgMWa7Ii++Nul57WSvKUwkHFcYcH
 obiCY5GqJZPAwDtHEDzD89Poxk1fRQkZ1aqcT763rr3ApG33oWvKUnk
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

