Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEAF10AB803
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D76A10EB82;
	Thu, 26 Mar 2026 18:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UGP+rbLZ";
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8386010EB20
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:39 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-46704177543so884648b6e.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551279; x=1775156079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAl9+PvQAj0gWNHtBaTmlj5ZgTYMrxMbOjBXxAyMQwA=;
 b=UGP+rbLZLU/x1o/F9wTro1qA/ivasRBmILme6zVVrINCRHnGOj3PUqx/BE008Mf4jF
 655m34KxBZIYWbztqo6Gnks8+02OzKkAnDHQShb4jZfLcFzpv8Xl7QXJZNJVvVZAAhxn
 H8G3FyStbR4CIyZnvKkqImyxQ+jzW/4Uxi0fTB0qLiMYPYUVgzkozjUTy4wZek1keck/
 qzpk5hklKvzOzxGFhzPPyih0Km5KIrUIPaEEwia5EHifwdzy7HFE3jc24zWGk32LY9V+
 Jd7LKsnweTXhKAixN1MHw36wTXqkEIS5twjXnJhiXbTR3oWlOl+MsCASxSF7O89lxyNa
 +2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551279; x=1775156079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AAl9+PvQAj0gWNHtBaTmlj5ZgTYMrxMbOjBXxAyMQwA=;
 b=QeVnT9tUmCq6he95Cc4JZlSk0G3V2Qm+gHTa7n+9XEh8YJ9fw6QdY6D6vsDS+tevHq
 mMFvYSIoxHPrhd5ZwoBabRHIR5oEoaVnAErMcMAPlXHt5Xez4lbq+OS1lTidY/bdG4Oq
 6OsyXShY1sPh/OcNO/GzxONGcHfa8VZr/bnhbbc42eATRO2WFTy9eR6tXZoaxt35eKxD
 NLT3lZYG3AlwWZPdeFJHwgsYgA1uY23gjb4wdu8f6vb79H9RYEFcDtG2MLY0qvmwIf+p
 aZdiCnHYdGgfturvZ+7JCifji9bIw/v8Xi19dfm+ZY+dFCghfFEHmCweWg8C720g+sEh
 xFtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWolLPVZthxB8bZ3Sok592j1FUjMEikuNcslcXWdjJNLdhBS5GtJhMgFwK3nNUMpZkoppOTcO28t5I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyybmLHbysr9nZPjWmR3Q6D/BNIln8dCzHZLkZaWrQmtvm5G2YA
 /7kTi4eY3mkU8l1+WqPya6YCUKdPRee79UhrFdwV3aE86kJnnEQAvE5F
X-Gm-Gg: ATEYQzx/Qjq2NrMDnsjNYWeS0hdHLE12nw4LKLSuDuNgHOV1+vLHDFC+ne8+/B35az1
 1fp+b6xrUBxN4T+WXUh9pbWku5KT2OpB5H6t4u/H6ZshNUulIJYkhUz9eAafo+jKZvQ9K1pVIuT
 dXIJ2isGV+ACF6Rd/2N3XgIYVu4h+3i4V5/vYW86Hvg0gmNDrZwQZbzxcYh5B8ZCMz6Q4wVMMOX
 A1lZa8qKAajowE1d+je8s7R2NsTCycDaxX9P2FAaEml+NXCu1e0zQ/Lju2HLkX08kwA0rCKU3u3
 63oYHiUj8l/vmwJYEF8RhSpbfv3TSYG6mnZ77NWYTPbkH2OppWP66kS6PXACTLQXhVlt2p/z2Zx
 TLt+96cs781tV8b+C0vQtD1zNyMmOhkf54aozUXMqVEAqauhVV3TFe8vqKgPgkdFO0eeojpdUAK
 w32mCN72QbY6pV6uev8BVjl8Hv4ouKeN+7Fh8+axzJGDT8IYdUKNj6EnZoon0=
X-Received: by 2002:a05:6808:1a07:b0:467:1633:a1a6 with SMTP id
 5614622812f47-46a5c6728ebmr4492539b6e.13.1774551278780; 
 Thu, 26 Mar 2026 11:54:38 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:38 -0700 (PDT)
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
Subject: [PATCH v12 06/69] dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
Date: Thu, 26 Mar 2026 12:53:10 -0600
Message-ID: <20260326185413.1205870-7-jim.cromie@gmail.com>
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

Add the stub macro for !DYNAMIC_DEBUG builds, after moving the
original macro-defn down under the big ifdef.  Do it now so future
changes have a cleaner starting point.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 43 ++++++++++++++++++-----------------
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
2.53.0

