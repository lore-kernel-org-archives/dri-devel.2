Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6DD105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D33310EBF9;
	Fri, 13 Mar 2026 13:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRjL78P2";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0803110EC02
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:03 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4671cbce626so1072239b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408182; x=1774012982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAl9+PvQAj0gWNHtBaTmlj5ZgTYMrxMbOjBXxAyMQwA=;
 b=gRjL78P2WiIT9cmbDtRi+CrWYdpZAiqP0uIV6oZnv7djMc16grHFgpfoX5hBoBG3LZ
 5A0rnMWuOnt7Vuu7ltR+hOYGxX1Xx8lTKovanKIc9dh0glIjM6xnc51wGx05jk1eU0s2
 RBgwnAJBpgoB0URUpj+Z7ZcQCQqSIV8rovxLD4qtYxdAtHEH29bH9uzkF2N3rOJK4vV8
 +I8aMEWRrh94BxWqYcavL7YPgOIWMqs2FE+1anKnq9kA4RK8zuKQZaET6A2Vi0zOgd7a
 VcJxf+ahwUV7S99IlTilJMwvxpDS/QNqq6O97sJLEYAcy9w4cpKJMCThw2a9/lfufQRn
 nhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408182; x=1774012982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AAl9+PvQAj0gWNHtBaTmlj5ZgTYMrxMbOjBXxAyMQwA=;
 b=bPIVB36nFMPod1dmefxYqb/MLmnVFqGZ+bOkenhP2vLRxma4k/Dt7U0D/uOd+LImWr
 kPv8yHzi8yTqKciTs85YxPXevchmxAw2RpY9O2nSDkX1u/LOUFHOOPAr5WlqFBdFWzI8
 3Fr4Yx42ErVcZc048hFyJReQPpPFrAC9Wy1xKV79FJXod8XYDwvb0wkmSzsuxYxIGWST
 7yllv2djoPFzYEyLLxAN6VgsFAzHv7ac9Mkor5inA3TaVWR42B4M8cRzNGinmmH7jUZZ
 BD5oI6TLRA00hvPaHBUGs1mijObF/dqUUW6KYsHEsAisRTk3M31AXBs47cqMIPCvQUS1
 AmxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUanyMljoLZkZRZJNjxtb33k1qo+J0NHBGXQeVPL+AlbXtRssJjhlhzU2A8/Ffj/UcgmKdNPPeD04A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQ/lHajh1hR4EqBS6HydHhcZxABzvAEgXZJPMi5Nd82xHKpvV4
 60YWhHiQ7jXJWI8QSsZv4CsFu6+yEARaWcHvnlRS8DopBQUQMYZegKmd
X-Gm-Gg: ATEYQzxwjV1i8sWNoTeUJuGWwsahdr/tVK8V99ml9eZgOI/yLGw8HmoiaZzk9WG5OpS
 lbkJEX6iZ0Y8X/Q5QKiTmxHj2wzcyaBAbB63aFdp73oxL9OxUG399djZR5qhxV6X0lFca/0ewpN
 Mt5LDX6hlfEZ1k9L8W/1slH4xa++nF9rVnpMzVhoNZINRXTo/J+ocKUveuRVoUoPlS4J7oCMLT0
 zj84xLC+z7GRG3Zsl3Utar7UO+NZjG/VZFdTpD9dbdG7TxojvCKph3qa0zGNZYT6bdGFibR0TZG
 bbzUcR/8Ul+QUqL/1eDJF68uHe1mEYcmMqRLw7vBWEbBPDHVo0PVcsgaFE0Bg/FlGcY5IpTORL7
 4tXtmfbtWUJ6MqMXPd+pLHZrs3nmTvDMkxaw9arJLQgbIuiC82AlX/9TkfIPbWQXRMP2n0Ojv/M
 87Aox83+iU1pNX8gIc+nRgNozlqxx6MzWp6PjX1wWec5/ob/Do
X-Received: by 2002:a05:6808:19aa:b0:467:284:b3cb with SMTP id
 5614622812f47-4675701cd1dmr1817809b6e.2.1773408182075; 
 Fri, 13 Mar 2026 06:23:02 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:01 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 03/65] dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
Date: Fri, 13 Mar 2026 07:19:28 -0600
Message-ID: <20260313132103.2529746-4-jim.cromie@gmail.com>
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

