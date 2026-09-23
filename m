Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E51C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E016510F205;
	Wed, 23 Sep 2026 22:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wi9mF0yv";
	dkim-atps=neutral
Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com
 [74.125.231.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F6610F202
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:39 +0000 (UTC)
Received: by mail-oo2-f41.google.com with SMTP id
 006d021491bc7-6b1ae7166edso823994eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202938; x=1790807738; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=txroU8tpb4AveGN1UplgKFnHMl0k756Ds3MugkCIGpA=;
 b=Wi9mF0yvUOhlGpE8UwJVYw2RNg16sqr54ykQxtEcZMpmvfZpnTP/7Vu7HD91HvY4Co
 OEDHaHA81jCF4d+mDEvlwKoW86ZG/XkEZzR7QYVtaCDx2GKEKPl3FHJLyyx/2ZeuCRDH
 94fGMLzXytOmWYrHcJErQttmUfg+bVMEInimNILYr5Vi0GuSWATz2fyTbyoP3PKL26Ol
 cdefSxs9zgOXckEWrLoUofQ0Gx/ontzEMNh7enHM0n3SbmkvNorp/iosqLW7cXyTFTnw
 gPkykejGJmqd4r8OaMiV5nVKgnDS0/FqrY1Ddds1e/SdFyO3mVi780sCtRj4v7EcltHk
 ZR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202938; x=1790807738;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=txroU8tpb4AveGN1UplgKFnHMl0k756Ds3MugkCIGpA=;
 b=rWo5yvJ82iIp0DZ1WoMU69wO0v90A6xrHDCx7KhKPSgUko9Pd7KGNGTJ4NEHMo1Iv5
 7E8ytYu6WV29FuXPDDKeo7d1tOWa8L5GEox82lzaT/+ra6GzrrVYntR7aoGWw5tkh0CJ
 XgKxIjRjij2LTm5cdD7ECd7EpXGzAMt2kMoTqtLFeAyE7NbTLxe6bd/qXifutj1CqVa+
 /b/PNWm37Z+PESwupwX3wvS6+CZfIy5YKWQz6L8rhkw1mhCpe3VJa9IeP6VmI+hUhaJ+
 EWU8JfnXMdB9jjS/n4nMs85uc8F8du2P5mTo5qjxL/yv79yt1PbYCljQyqPauFm492qY
 +nUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBydTnyHWU6fM/aJZec2pRP/2t3FBRd0ZMqnN8oubXm1qQZo7Ld/HhE5knW2NxVsyVMHQa1v509NtVE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nqvboaTLQ2WmT94PijNPlfMr5y1ZTPR5Bw1eO8qZuneyb0ERVg
 0o6r4J6IBQqmvZP0Rob2PmY+yWaAkTpQS8TQdr7zBeqsyslsIiZJBxZz
X-Gm-Gg: AYBFou3kDAPG1YDqiOyJT+nK0X4ksv+/buFtkT+bzLkhno9gPFSxWWKTLt5qxmZa2/t
 nBha6Y1p09ohAJ+Z+LHFJ9k6lWjvdocTgVZLJzdIDJu/FrOFAqD4lPXpgWX8IytZYJ9V/CIb7tr
 JDHFrKsDGNd3/Twvs8QZDOLJaYu1K+V+y9jw5S9SyCFBzS/Yema+Cq73/zHl8kBRB6ek9yejEbS
 veIUFOby6TNUVSRKlr+95PTr03YAL51EaWWtiFZ2vba3UvhPJ6kZCAu+oIiLU60DKWmT8U/MDxw
 rSKfs90E7FOkcrw1tTG01rXuK2RU9YEdjmqAyDTVq4xr9hCba1vGJBAwsdnvF/PepACqAfXakSo
 GGU6zEi3kozc/6TS4iP3Eo920ZyAwI9OW3zm2d/mhgxU5k8NmkJN0jDPL4cJs6HxpR1x7SUM6Nk
 s2FBNukTHG8QjjoIbwrKD8zGQOXNv6eO2YZM8UgThedqPMsG9rI/znxBYUQEYLLr5sEkHewdy8H
 6/p0vSIWzvZaGbiNR3j6XuIwF9LAjgfmOjGUwDJDEp/6eMYTpF/Zt7fc9iYQ+cnEkRDrRb8RWMq
 NFoJ29gFKClk0yzMwi4=
X-Received: by 2002:a4a:ee12:0:b0:6cd:3ffc:acf9 with SMTP id
 006d021491bc7-6d441b8251amr657309eaf.73.1790202938243; 
 Wed, 23 Sep 2026 15:35:38 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:50 -0600
Subject: [PATCH v11 26/38] dyndbg: check
 DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-26-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=3976;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=XlwJxsMLoOEmQpSddsPPKLnRgIC9ISIuuOLCD/BSHY0=;
 b=EiptybYCzB6D9ZP87jAlknvFfrN1+LB91BbDMF60BOUBfjDrPvXh9+w10WbHf5H/XbP0syE/Y
 IJx5x2PY9QUCJnmB6hoFeKj+1H0mzvCzbpWlc8waCN4UItOiSWdLBUu
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

Add __DYNAMIC_DEBUG_CLASSMAP_CHECK to implement the following
arg-checks at compile-time:

        0 <= _base < 63
        class_names is not empty
        class_names[0] is a string
        class_names.length <= 32
        (class_names.length + _base) < 63
        dd-map-type is known value

These compile-time checks will prevent several simple misuses, issuing
obvious errors if violated.

Several bad examples are ifdef DD_MACRO_ARGCHECK qualified in
test_dynamic_debug_submod.c and will fail compilation if enabled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 16 +++++++++++++++-
 lib/test_dynamic_debug.c      | 20 +++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 61f9fd4aa7af..26c858588eb1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -192,6 +192,19 @@ struct ddebug_class_param {
  * __pr_debug_cls(22, "no such class"); compiles but is not reachable
  */
 
+#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base, _mapty)		\
+	static_assert(((_base) >= 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
+		      "_base must be in 0..62");			\
+	static_assert(__DDEBUG_ARRAY_SIZE(_clnames) > 0,				\
+		      "classnames array size must be > 0");		\
+	static_assert(__DDEBUG_ARRAY_SIZE(_clnames) <= 32,			\
+		      "classnames array size must be <= 32");		\
+	static_assert((__DDEBUG_ARRAY_SIZE(_clnames) + (_base)) <= _DPRINTK_CLASS_DFLT, \
+		      "_base + classnames.length must be <= 63");	\
+	static_assert(((_mapty) >= DD_CLASS_TYPE_DISJOINT_BITS) &&	\
+		      ((_mapty) <= DD_CLASS_TYPE_LEVEL_NUM),		\
+		      "unknown class_map_type")
+
 /**
  * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
  * @_var:   name of the classmap, exported for other modules coordinated use.
@@ -205,6 +218,7 @@ struct ddebug_class_param {
  */
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	__DYNAMIC_DEBUG_CLASSMAP_CHECK(_var##_classnames, (_base), (_mapty)); \
 	extern struct ddebug_class_map _var;				\
 	struct ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_class_maps") _var = {		\
@@ -212,7 +226,7 @@ struct ddebug_class_param {
 		.mod_name = DDEBUG_MODNAME,				\
 		.base = (_base),					\
 		.map_type = (_mapty),					\
-		.length = ARRAY_SIZE(_var##_classnames),		\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 		.class_names = _var##_classnames,			\
 	};								\
 	EXPORT_SYMBOL(_var)
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 3a69cc3cae6d..01ce07001d4c 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -148,12 +148,26 @@ DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 7);
 
 enum cat_level_offset { Vu1 = V1 + 7, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7 };
 
-#endif
-
+#if defined(DD_MACRO_ARGCHECK)
 /*
- * now add the sysfs-params
+ * Exersize compile-time arg-checks in DYNAMIC_DEBUG_CLASSMAP_DEFINE.
+ * These will break compilation.
  */
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_maptype, 3, 10, "no such type");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60,
+			      "base", "plus", "classes", "length", "too-big");
+DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
+#endif /* DD_MACRO_ARGCHECK */
+
+#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
+/*
+ * now add the sysfs-params to both sub/super-mods
+ */
 DYNAMIC_DEBUG_CLASSMAP_PARAM(disjoint_bits, p);
 DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
 

-- 
2.55.0

