Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19F9C9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD9210F207;
	Wed, 23 Sep 2026 22:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qQQOGH5m";
	dkim-atps=neutral
Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com
 [74.125.231.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1447410F1F7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:14 +0000 (UTC)
Received: by mail-oo2-f40.google.com with SMTP id
 006d021491bc7-6c72bd8a02fso725270eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202913; x=1790807713; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b6vR03EF+2JMDzElHPysPsvJuI+vzbGvRGTWvBYfvlk=;
 b=qQQOGH5mpePpMsTw8PUnYBVtRcHCh8anHOWbM0NKBdUJCPNrQ2tY1/xtOk28QBoY9l
 tWBtg38jKeyLZXLnla16XMzcmYtRHfiO79W9zbzhfLDRaaHuH/yjwyv7xxTbgJs9wgjx
 Uqe4G9mJ5NQeNEO0UW8ZbG3wyl7xpJvtGu3Pk40FjPId4Fr6N1eni0FSmK6GFI8vBM6x
 liftUDuaUQGYPaGua0STH41J2BTGQvW+twVwvVUj+3HuerKkDcek7tUy4y/HI11DAh2+
 /uwxEb2vEv+nId43TIkK1qPiqFf3yKraOaJXsg8OW2RP7lZlcSOcOvFEOHLZKU4sIkq6
 CvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202913; x=1790807713;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b6vR03EF+2JMDzElHPysPsvJuI+vzbGvRGTWvBYfvlk=;
 b=uG9/SGkyEW5JdZSjHNEBt8UDdOJLF48k8tY1zr+w1uXKdGB1ZqgE+UR7xEHxfdGP7E
 bnJ83g/ZDsKfDAsPP2dFn236H7KxjQZNfFZIT04K3WX8jNi25pihDZyguU7DOcqYJivN
 uBgc+rVXZEfZnv7YET7c3ot3qiEF1DoUQhE5c5C73eJKsJJhH2gtvnHj/H6owtmZCJsV
 lec3WxNQV/wlQH9j9CBr9c890NifuKUDNte06FFrsSikg2QiGbnq5cxbk3eDDcJl7JzL
 5+/anAV+9GCzHgCpRA588T50/+CmFBB4XdxFjExiypeWSiH7ZSa+m++lgNCfnu7PLyrj
 HT+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzM91ibH80D9QRiB1phDfq2TTLfZZftEn/aeQ5QlOh6kvVxFph5qVKe3NazjFy2OFO1TvD0tccHzU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYCospOfp6Kv/H5aZlmUB7jrWSq4lxlutIGWKMKUytjlH0/TTW
 cJ9SXAxYwWbq04oHFmEP3kBgQ/QYdPdXo3NSAaO+nIXrJhpShzHmIQwe
X-Gm-Gg: AYBFou3n/SmXYOvB8VkHDaf50LY0y8BHQB7CNVoAitsEoYU4xWmGFdS1Mydvulh3GVk
 IUwU/1RzMcVeZJhPbe2tbhEnYx52QXmp3ivt2vzPB31cPQymVu/E5sAGObRe7hw1msnyj7ym7/T
 ThjGEeO9IPPg3repNfzHaUZX3XtD/ZQN4v134OnTMBSqHuhVhngFJIXvoWJdSG9uUR9HmFeMpH9
 uP/cYH1YBOUIvv0mmG+9u17ny55DeZw6wXM2S4SF4I37OqBFA8XvUmPdrVUkHZdPIXi0eIFkIMi
 jt8BEH0P1rxGW/I2YiAVappqnk5iT5uNOWSMwVKgcZaDn3A+S8nwnOY8MKG6jJ/CjYDKuktqngt
 7rI0WoOBq2OcUr2kFq88+oZuE5ylJb3fK+BdpEHXHP2ennBQJ5VElHZCfaIlqBC1ysS23O2u3T8
 yM0tpDCJsuj+1UyqIQRZyTueAZXLcORLs2W8k/N2n4iYxlNE5g7HNufNor5WlRlO8dZrlAybNkf
 J9MJA6PTbb5Skdv/LI3ERIizhtgxAKJdB5TRCOCJXHix0y1P1l4Du3iSV2arJqdcuZw6BMYz7aA
 BhPrZ2EsjCSlRrOLNlM=
X-Received: by 2002:a05:6820:1689:b0:6d2:c279:1e7 with SMTP id
 006d021491bc7-6d43f1cd426mr764591eaf.7.1790202913229; 
 Wed, 23 Sep 2026 15:35:13 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:12 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:39 -0600
Subject: [PATCH v11 15/38] dyndbg: refactor param_set_dyndbg_classes and below
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-15-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=6792;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=FPzfUky9yTEG069aIxtUzduRT3A6TOB8XydwgiqGyYk=;
 b=NgVaLCQ1OFIzoKM5o4/SSFh59rts67G4TDz3LRFnnBtSIPXUpCHxHuZkO+vL7U9zkk39mtqkl
 pLBcgJ4hPrAApgrK0nd/POBu1gd8VcXrnenh55Cj0926NZtW2xSBc7z
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

Refactor the callchain below param_set_dyndbg_classes(1) to allow
mod-name specific settings.  Split (1) into upper/lower fns, adding
modname param to lower, and passing NULL in from upper.  Below that,
add the same param to ddebug_apply_class_bitmap(), and pass it thru to
_ddebug_queries(), replacing NULL with the param.

This allows the callchain to update the classmap in just one module,
vs just all as currently done.  While the sysfs param is unlikely to
ever update just one module, the callchain will be used for modprobe
handling, which should update only that just-probed module.

In ddebug_apply_class_bitmap(), also check for actual changes to the
bits before announcing them, to declutter logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
v8: drop kdoc on static fn,
---
 lib/dynamic_debug.c | 73 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d0e793a05655..bbe32fab74e8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -618,9 +618,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits)
+				     unsigned long *new_bits, unsigned long *old_bits,
+				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
@@ -628,7 +629,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -637,12 +640,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
 			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
 
-		ct = ddebug_exec_queries(query, NULL);
+		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
+
 	return matches;
 }
 
@@ -651,22 +658,17 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
-/**
- * param_set_dyndbg_classes - class FOO >control
- * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
- *
- * Enable/disable prdbgs by their class, as given in the arguments to
- * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
- * levels by bitpos.
- *
- * Returns: 0 or <0 if error.
+/*
+ * param-setter helper to validate numeric input, clamp its value by
+ * the classmap type and size, and apply the bits.
  */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *mod_name)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
-	unsigned long inrep, new_bits, old_bits;
+	unsigned long inrep, new_bits, old_bits, old_val;
 	int rc, totct = 0;
 
 	rc = kstrtoul(instr, 0, &inrep);
@@ -686,9 +688,10 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
-		*dcp->bits = inrep;
+		old_val = READ_ONCE(*dcp->bits);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, &old_val, mod_name);
+		WRITE_ONCE(*dcp->bits, inrep);
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		/* input is bitpos, of highest verbosity to be enabled */
@@ -697,11 +700,12 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, map->length);
 			inrep = map->length;
 		}
-		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
+		old_val = READ_ONCE(*dcp->lvl);
+		old_bits = CLASSMAP_BITMASK(old_val);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
-		*dcp->lvl = inrep;
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		WRITE_ONCE(*dcp->lvl, inrep);
 		break;
 	default:
 		pr_warn("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
@@ -710,16 +714,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - classmap-based kernel parameter setter
+ * @instr: string value to set (numeric bitmask or level)
+ * @kp:    kernel parameter info referencing classmap state
+ *
+ * Enable or disable all class'd pr_debug callsites in the classmap,
+ * independent of the module they're in.
+ *
+ * Returns: 0 on success, or a negative error code.
+ */
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+{
+	return param_set_dyndbg_module_classes(instr, kp, NULL);
+}
 EXPORT_SYMBOL(param_set_dyndbg_classes);
 
 /**
- * param_get_dyndbg_classes - classes reader
+ * param_get_dyndbg_classes - classmap kparam getter
  * @buffer: string description of controlled bits -> classes
  * @kp:     kp->arg has state: bits, map
  *
- * Reads last written state, underlying prdbg state may have been
- * altered by direct >control.  Displays 0x for DISJOINT, 0-N for
- * LEVEL Returns: #chars written or <0 on error
+ * Reads last written state, underlying pr_debug states may have been
+ * altered by direct >control.  Displays 0x for DISJOINT classmap
+ * types, 0-N for LEVEL types.
+ *
+ * Returns: ct of chars written or <0 on error
  */
 int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 {

-- 
2.55.0

