Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A92CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666A310F66C;
	Tue,  2 Jun 2026 22:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bqAahDVx";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D9B10F65B
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:43 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ebafde87cso8109550f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440522; x=1781045322; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ouT17iaKBzrIR7K8VitMxlklOudvhENGiC0/9mkENrM=;
 b=bqAahDVxY3p6S21aewq/yCSVnEttLdV5ozZjGoSYKoOzCYLjTyNkCQCnhaQbCNhYgH
 TGBua9rvi2ZPa9SY7h9/Q9+TN6UFuVBt3NjkuxeoMaXzlFOo1zQdTwy77ctAbcgeeauw
 EXJlnoi6JI3Oxc/nYS4+TQDDBKYtP0mHusVjK+akfUTLBbHRfCbF7dWBgQjNy0OiIcps
 pwLx+zl+oEryeOzly4TyEVqo5IKZgAZ1OGBnYt+MWqZVWOaTrptyKp1/gUBGy9gZhRpu
 gb2AR9JyB/gHQuZLGYz03qWQFN6loLXahPJtp9BHKv9rEIBmDDEFaixOP3WM2ht+BSOy
 Rtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440522; x=1781045322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ouT17iaKBzrIR7K8VitMxlklOudvhENGiC0/9mkENrM=;
 b=h1YMvTY2LLPBY4D4V/7SLAYSrloK0h2Jh9IYGNXr17Ia8ukPZbGcmXwaLhXBHr+y6e
 RAASynEu/ao5pT9ar0XtoPfZuDBitaPATtKLvdw0hdhSptDgS7ChPDawO28DMGRT1Gsb
 qQpBmk64w0OapLTmnzj5rWoWOFja2XyvOKZCWVMTeiGoDVM5tqMv8+ipN/aEHbrqGxXV
 l0Xbp6xb8XanYZkr6wyqlWmVhQs/O8uHCbQcNjDHQUToAoeUyUlqo5ocGEjFcUYfX+rQ
 H7aeP4IvBOevtdX2KG7zsX2wcgbUDzWOx6HUF3rGe6saopkbqUdtoJk/ebv7/tqUmOZQ
 joNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/p/LuXNOOiaklc2FoibC+lg9qHrrHw4LMrgIxNX63W2h7ZWB3NI/LcV2L3BV6ae/al7zAmvIk1IpI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZKDeP2xroaEVAFYJh1xirKhXWP0mi+HpOhoIwiBmMz/Py1hOg
 YSuZiWxyJF0HmWzfo3HwZjqv09nTlB5yJXyh90f4cimvh94mkCG4brt+
X-Gm-Gg: Acq92OHopab8gwWCnsiL1Sjmgyp6s39/lnD6YpsXMWlew2PPlhX8qE4mCdXXSGNP8sl
 c0Ywv352uKVJFry9oR6pJVmscQBkVlA9mg/dNcZM3fhd1KvDlfZrQUkDT3y+LZdNTNLyzkOLjn/
 cEywM3ngwzgYXM08fznfbOjMAamLaZrjSH9koL5gpO6/bVpK6DFYBS7z46StKWr3QBcr/6RpenQ
 axR2M1Mzl4vnOP4tg7IdKiXNPJmJDT74kqfmP8GsuxetHhUlufBseujLZkOTja00dMaK/UBVz4s
 1p7XRhx1++r1Gknt/0cZRAm0ntXc4DVsvfTqwy2DEGTGNu/9zquIqalvtsoxAcSaETmKJJIzW0/
 uf0m3yKYfmCsbiBCKpq2mr+y1Rm+NM25TWk31URKiGnVRyaUHzW9AMn5MlIXHXzuamZoMph85ax
 ij86agvFPvFc04Dz1vjEDH1QVcwLPoWdnBbZDtod4lZw==
X-Received: by 2002:a05:6000:2401:b0:43b:5097:6f62 with SMTP id
 ffacd0b85a97d-46021760f85mr726977f8f.36.1780440522072; 
 Tue, 02 Jun 2026 15:48:42 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:41 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:08 +0000
Subject: [PATCH v4 11/25] dyndbg-API: remove
 DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-11-19a1445585a8@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=9437;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=3/WKOcRSB+nt/VjxfVuHRY5i0B3sWWTVXpV+X5m2Kcw=;
 b=0Oro+fvs96gHBULnbgqI8LvicLUd9KRubfWOKkcC+3im25aR56j8yFM54WrNioaUJX2NhahT3
 g92pijhfZ9+BxZYVa1GA+7gp/D5ui60gQw3JyQREtZAWwxIMkqut0il
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

Remove the DD_CLASS_TYPE_*_NAMES classmap types and code.

These 2 classmap types accept class names at the PARAM interface, for
example:

  echo +DRM_UT_CORE,-DRM_UT_KMS > /sys/module/drm/parameters/debug_names

The code works, but its only used by test-dynamic-debug, and wasn't
asked for by anyone else, so reduce LOC & test-surface; simplify things.

Also rename enum class_map_type to enum ddebug_class_map_type.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v3:

fix name of enum in kdoc
also change name of struct (to future name)

v2:

move RvB after SoB

respect const instr in param_set_dyndbg_module_classes, return -EINVAL on classtype err.
---
 include/linux/dynamic_debug.h | 27 ++++--------
 lib/dynamic_debug.c           | 99 +++----------------------------------------
 lib/test_dynamic_debug.c      | 26 ------------
 3 files changed, 14 insertions(+), 138 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a10adac8e8f0..78c22c6d2312 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -59,27 +59,16 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-enum class_map_type {
+enum ddebug_class_map_type {
 	DD_CLASS_TYPE_DISJOINT_BITS,
 	/**
-	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, one per bit.
-	 * expecting hex input. Built for drm.debug, basis for other types.
+	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, mapped to bits[0..N].
+	 * Expects hex input. Built for drm.debug, basis for other types.
 	 */
 	DD_CLASS_TYPE_LEVEL_NUM,
 	/**
-	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0-N.
-	 * N turns on just bits N-1 .. 0, so N=0 turns all bits off.
-	 */
-	DD_CLASS_TYPE_DISJOINT_NAMES,
-	/**
-	 * DD_CLASS_TYPE_DISJOINT_NAMES: input is a CSV of [+-]CLASS_NAMES,
-	 * classes are independent, like _DISJOINT_BITS.
-	 */
-	DD_CLASS_TYPE_LEVEL_NAMES,
-	/**
-	 * DD_CLASS_TYPE_LEVEL_NAMES: input is a CSV of [+-]CLASS_NAMES,
-	 * intended for names like: INFO,DEBUG,TRACE, with a module prefix
-	 * avoid EMERG,ALERT,CRIT,ERR,WARNING: they're not debug
+	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0..N.
+	 * Input N turns on bits 0..N-1
 	 */
 };
 
@@ -90,7 +79,7 @@ struct ddebug_class_map {
 	const char **class_names;
 	const int length;
 	const int base;		/* index of 1st .class_id, allows split/shared space */
-	enum class_map_type map_type;
+	enum ddebug_class_map_type map_type;
 };
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
@@ -119,8 +108,8 @@ struct ddebug_class_param {
 
 /**
  * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
- * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
+ * @_var:   a struct _ddebug_class_map, passed to module_param_cb
+ * @_maptype: enum ddebug_class_map_type, chooses bits/verbose
  * @_base:  offset of 1st class-name. splits .class_id space
  * @classes: class-names used to control class'd prdbgs
  */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a9caf84ddb22..0377d9f8dcd1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -646,76 +646,6 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
-/* accept comma-separated-list of [+-] classnames */
-static int param_set_dyndbg_classnames(const char *instr, const struct kernel_param *kp)
-{
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
-	unsigned long curr_bits, old_bits;
-	char *cl_str, *p, *tmp;
-	int cls_id, totct = 0;
-	bool wanted;
-
-	cl_str = tmp = kstrdup_and_replace(instr, '\n', '\0', GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	/* start with previously set state-bits, then modify */
-	curr_bits = old_bits = *dcp->bits;
-	vpr_info("\"%s\" > %s:0x%lx\n", cl_str, KP_NAME(kp), curr_bits);
-
-	for (; cl_str; cl_str = p) {
-		p = strchr(cl_str, ',');
-		if (p)
-			*p++ = '\0';
-
-		if (*cl_str == '-') {
-			wanted = false;
-			cl_str++;
-		} else {
-			wanted = true;
-			if (*cl_str == '+')
-				cl_str++;
-		}
-		cls_id = match_string(map->class_names, map->length, cl_str);
-		if (cls_id < 0) {
-			pr_err("%s unknown to %s\n", cl_str, KP_NAME(kp));
-			continue;
-		}
-
-		/* have one or more valid class_ids of one *_NAMES type */
-		switch (map->map_type) {
-		case DD_CLASS_TYPE_DISJOINT_NAMES:
-			/* the +/- pertains to a single bit */
-			if (test_bit(cls_id, &curr_bits) == wanted) {
-				v3pr_info("no change on %s\n", cl_str);
-				continue;
-			}
-			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
-			*dcp->bits = curr_bits;
-			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id]);
-			break;
-		case DD_CLASS_TYPE_LEVEL_NAMES:
-			/* cls_id = N in 0..max. wanted +/- determines N or N-1 */
-			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
-			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
-
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
-			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
-			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id], old_bits, curr_bits);
-			break;
-		default:
-			pr_err("illegal map-type value %d\n", map->map_type);
-		}
-	}
-	kfree(tmp);
-	vpr_info("total matches: %d\n", totct);
-	return 0;
-}
-
 /**
  * param_set_dyndbg_classes - class FOO >control
  * @instr: string echo>d to sysfs, input depends on map_type
@@ -734,28 +664,14 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	unsigned long inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
-	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
-	case DD_CLASS_TYPE_LEVEL_NAMES:
-		/* handle [+-]classnames list separately, we are done here */
-		return param_set_dyndbg_classnames(instr, kp);
-
-	case DD_CLASS_TYPE_DISJOINT_BITS:
-	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* numeric input, accept and fall-thru */
-		rc = kstrtoul(instr, 0, &inrep);
-		if (rc) {
-			pr_err("expecting numeric input: %s > %s\n", instr, KP_NAME(kp));
-			return -EINVAL;
-		}
-		break;
-	default:
-		pr_err("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
+	rc = kstrtoul(instr, 0, &inrep);
+	if (rc) {
+		int len = strcspn(instr, "\n");
+		pr_err("expecting numeric input, not: %.*s > %s\n",
+		       len, instr, KP_NAME(kp));
 		return -EINVAL;
 	}
 
-	/* only _BITS,_NUM (numeric) map-types get here */
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
@@ -783,6 +699,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		break;
 	default:
 		pr_warn("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
+		return -EINVAL;
 	}
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
@@ -804,12 +721,8 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 	const struct ddebug_class_map *map = dcp->map;
 
 	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
-
-	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
 	default:
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 77c2a669b6af..74d183ebf3e0 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -74,13 +74,6 @@ DECLARE_DYNDBG_CLASSMAP(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
-/* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
-DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
-			"LOW", "MID", "HI");
-DD_SYS_WRAP(disjoint_names, p);
-DD_SYS_WRAP(disjoint_names, T);
-
 /* numeric verbosity, V2 > V1 related */
 enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
 DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
@@ -88,13 +81,6 @@ DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
 DD_SYS_WRAP(level_num, p);
 DD_SYS_WRAP(level_num, T);
 
-/* symbolic verbosity */
-enum cat_level_names { L0 = 22, L1, L2, L3, L4, L5, L6, L7 };
-DECLARE_DYNDBG_CLASSMAP(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES, 22,
-			"L0", "L1", "L2", "L3", "L4", "L5", "L6", "L7");
-DD_SYS_WRAP(level_names, p);
-DD_SYS_WRAP(level_names, T);
-
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
@@ -102,10 +88,6 @@ static void do_cats(void)
 {
 	pr_debug("doing categories\n");
 
-	prdbg(LOW);
-	prdbg(MID);
-	prdbg(HI);
-
 	prdbg(D2_CORE);
 	prdbg(D2_DRIVER);
 	prdbg(D2_KMS);
@@ -129,14 +111,6 @@ static void do_levels(void)
 	prdbg(V5);
 	prdbg(V6);
 	prdbg(V7);
-
-	prdbg(L1);
-	prdbg(L2);
-	prdbg(L3);
-	prdbg(L4);
-	prdbg(L5);
-	prdbg(L6);
-	prdbg(L7);
 }
 
 static void do_prints(void)

-- 
2.54.0

