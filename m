Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACD2C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2569710EB47;
	Tue, 21 Jul 2026 20:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bJIOW2zB";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070A010EB47
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:27 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7e9f5637634so5328057a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667446; x=1785272246; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
 b=bJIOW2zB4A1tnJqn9OX2F/7Rm4tBzJJzCGO+3OTYzoXrmFAjqvMcZuktre/n3Bv5/H
 JnQeGWVjRL8TMZ7VyzwPSYwMjiYOFtp1hnby3ogxLY9VfNvjjK30po13I4F+Lqjd9HCP
 k09kaj0nUgP2wXQPTxjdTKsvIncleAYrjvjfZ5JKhzpzERoqL90IzCetR9so50lKphqR
 ieA/KeZ+Aa8nLNPB/xoL63SvppMwOuC5jOneROwqh7eaZczXQL3JCwElJJFU0G0ArTyL
 Y/NdW6gekkZ+u0IUIuXmVeWvmPtCw3GgEfESHLoQc/SBAHDvkz3p0w56P7955LQnJlpK
 id3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667446; x=1785272246;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
 b=gqYGHUgAaZiFE8fz0SH5ozmsb8jL0NUNtBGSWYkXaxCuOYL9M/ZaTvMOP7RQl0rzYH
 ZagE2H9ybc9EIiqsolNWZZcHGaF1I7A78Sq+pJ2eduig18nJmuiIPuXm2MFXYQgiK38o
 KRZqX+OZ+ttN3CI1dPPPNGUTC/gY5P4fqSEmF4Osjs01Mc4aTmu3LNMQsGDNi3WSMgzT
 Aa7rBYJ1QaHYqmFQoJbe6+xRRbn8QW96iOOOBXvoD7MHZr7ulH0LKqpIfAu7l3fkxP9Y
 17aMffd85H8nP1Nnja8MU2UGsX2mre0sB0YF/3Ko9bjkHfs/81oQHLmrKwbG9RazbXKn
 V/RA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjhdpzcNYmYV+u3Wbk18xLJ2zNOH2oA0uLoYjDphrbTZ9NLFm2zRlzwkWUM6Y6hxdUiab4cDMmUrk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVq8RDtKqKvQ26epcZwS1613wHGUzPyvvC99pFMTiVOnG/EFJ3
 v+4JZ1X6xYZ50EmAzhOeELSdV8f+DAHsV/hBkENCypWSnlk4vG/3u7CW
X-Gm-Gg: AfdE7ckXAZP8ojWBkn1pQh+iz/7pw9LCNpIAnmkZfc3GtkYt22N4SLFdol/dnhSlpqZ
 GSW+xP1OzYzkQiwvk3HueV+kkqsZmvfPnre/ULUYjSIN7FnfvAnuGDgXmbmjJyAftcED3q1TNKf
 7kxJsFzAxX6ADXPC7cJPGR7KCIToSMReEq/Q96weitscVlGVZ4KtI3pJHaNTjVYPMoEqPX/ji5a
 8i1Vob3Rq6QlJNK1rxJozGUQ55COyDhxTCL/QZkMt44+h+uGWqtXfffLyxD/buj+qCgwr+hk1LN
 dECwaHBJnZo2vM5+uSv/j7/ppz3aKTDtyzklxE8XhfbobqnUN7J+dgy8qlB38/jgaC/sRMikWUT
 wQ+PX2jcGedKcx8Aou3fU/KjIID09s1sRIOHpUFhW4v/36VscoJUEDPt4Lan1F8TzADFyzg/Ha5
 fBFponA3YjPDSTj/Lizn8FI/PMGVx0+u/Ud7Yxx+VGlaamjOleJcVv2g2qhCi18WJ4BJbzHYYs0
 J9nbNLHvgmvLzGkKo+lsWt+6A==
X-Received: by 2002:a05:6830:8d0:b0:7e9:f8e8:d905 with SMTP id
 46e09a7af769-7eda08f5dd2mr11421608a34.16.1784667446035; 
 Tue, 21 Jul 2026 13:57:26 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:01 -0600
Subject: [PATCH v7 12/29] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-12-010fbe73b311@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZuzqA3zGt/j9kYmFGfFlaL94NbjSKGlzcBcWBUqAWbM=;
 b=cmjG1wuVFQ3XeBJO9nnXcth44nNR224HlVxlEIfZaMRweihCUg7g+TJnOA1kkcfy9eKicXJmj
 oPA6pA/V2aUBYis47EkzWfSFRMoDQfmCdKNGmQyTivc2nl++knJC2DY
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

