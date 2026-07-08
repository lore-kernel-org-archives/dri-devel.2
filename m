Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D9EC43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54E310EF8A;
	Wed,  8 Jul 2026 02:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4r8+162";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BA410EF82
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:38 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-497d3e4460aso1305412b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477117; x=1784081917; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
 b=U4r8+162iUs+4fackXZizADvDZR0JxUXpzNMKR3F5LUduBDk7SkKTx4Lv4gdANu9N/
 iLfJ6ezjNxDLxY2bSOume7XoC+xSwe+mjcPn6SmgcZrNPkNTaVlX1jXg4YZ+5ObEJgRu
 kuQ8fU5h/AVLMAHtNp0PkkrKStcSAYqD8PCyZ+a1W42b7gr9mElY1MABTxJ5OpuDLluQ
 Yy//ZFYbMiAdl04VVPqvLDECRdSDjTVJWi4B8tq6vW6cxVVOFYnsykVlUBYBwetzBiSp
 lf3vwbcrvV4Mdt/GkTaZgthtCdi9rFDz1VPptnX7W5GWwEM4pbPaqr0g0NAkcOgd0LJj
 CDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477117; x=1784081917;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
 b=nqo8A/gkVDF6r97L95KjqfDX4oBwZVPH+yE969mULVZUpedeY69LvcNQKnRlHeG5WH
 zb2Ue0NP7ToICTorcIBA4s9Pbyp71PskF5SXixiu1bG+9wYfb2GLNksamSXooXDZSz0Y
 WHeKMHzEQV1gpSyDgm2UA5hSbIvICbIYP2Hyoyy9fNWar0b7SrDkIVBvNg8nh6zrzNCj
 U3hHAazmE54yV+K6I0jKOF26avYFhIEb164qFHTsCRjf2W5a9xxpd+/aHRZ61cEtyjkU
 4WabkJBNlrLstAbCQfOMZqcik9DTEFhM+FI+Z1+MEecoOt/VHvPmrjvwWluQvMZTjgAM
 oDXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8g35qgn3/zcV8npXJ1lxXZxir4Etng+OUsrFt2dcvWPVIxf6zmPbrdG+Saa9sINOabbEBVEycDVTk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXxwp3G4GFE8KU1HQC2GYMGWv/Msu0Wju1IcFdVNcMhSjCQBHs
 7i3swsioHksMuT1dyY4eDWEpwZCqHR6XN0n0AShg29i4Ss9KCA0h3Y0T
X-Gm-Gg: AfdE7clI41amY3zUXr9N0p/CrQaDpxG0eNIv5+o/UyDadkdxh0Dtf7KgjnXqcOrGEFx
 oo9XNSieo2QY3u9KR6KOHeH7t5YBo1Cm/Xv3yM4kl5cXD90S3xHHttJ0kPBtEr49Mc4FbyeN1Ml
 UhgcJzoYvWprbxmtEfkWpZbRXmLKNBZLUlDybznEvsM95ypLRZnaxxj3m9dPgoAUv/AgL6aXg0J
 RURZQbbDU6QnZcau/PloRwVtAJEKmMD5Qbot/VOeR2ohEXgTyasvWdKa/q2HBo53kpMLbwzdR4w
 iDMR8zLuuHW9jZ6OM3k7mrSkWn5nk3yHZoKlikEp8vxAbyxjzB9dqF4Laq5GDCfFvAH4fBzlE5m
 yHNzxsIFj+fa/ZXJHufGEfauOi7Dv2qi0jYvh2ysziPvCW7X+XX5Ea++uDXONwtARHKFva+Aztu
 2OPE/vYXOopwtOgtieWEfPHFmUz213fAAr/6A+byzdsb8y8rFeXbM=
X-Received: by 2002:a05:6808:5383:b0:495:dd23:1634 with SMTP id
 5614622812f47-4a078d678fdmr4414093b6e.15.1783477117572; 
 Tue, 07 Jul 2026 19:18:37 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:07 -0600
Subject: [PATCH v6 07/24] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-7-381f3edb0045@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZuzqA3zGt/j9kYmFGfFlaL94NbjSKGlzcBcWBUqAWbM=;
 b=Df/3Jimg35ze3m1P/ozSvM5FvBWV8r61gESD6JGx3nop2TPly5KJeYBPy+kA2q5XrW74Hvatj
 GIqsDorjqu3DRe7lb5t9WSRn+uPKlFWyrPUIZa3ReDIinFblSpF4CJw
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

