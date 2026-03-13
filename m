Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89102105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB9E10EBFF;
	Fri, 13 Mar 2026 13:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQDWl/Q9";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6877410EC00
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:36 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-4671119c1c0so1595299b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408215; x=1774013015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcJXGqnsuOO9Xg5FS/rnxA0pG/BimILzK8l4HmhOuOw=;
 b=gQDWl/Q96hcEtBPXij8/J3HBEWjyLfedZjrBnEYN8DnxzOlY5D9lawUWJDFuhlI0ub
 kHYb12+wTYa72hgKKa6EpukeLo9JtjL/nRi78lS0SzBOTxh8GmVX4w3o6IHHZfKDNwQq
 wjIMNLIsyGIjrosFcrJ+GsQhXThD1tP1Dy/BnSKaQRYr6Ct448Ta4DtTmxk0MH1jZ8fL
 sJ7BNfgNIhfbEb6oYdUgWT0Obnb7vnTbgUz3ZAKtKTFsNHlX5QUO5I6wPScdPtpbEAyD
 P8hYech4tcvWOCCb/ibG2laAfZ7eTwTn8f3+/giCKOsVEhDjlXFH3+pNaKv92gIJrKBt
 nAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408215; x=1774013015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OcJXGqnsuOO9Xg5FS/rnxA0pG/BimILzK8l4HmhOuOw=;
 b=heMFgP4H8jFS9E4IijmoGY1WZ0IIP2NOzEqyCySdstAYjtaSgij6Y7CcSlNz5nweIq
 EUFK43ntA/6EY5LQCEiKaL6L0QTGRO99Yyq/wjajiAJ+1idE6gWj00rw1xmZ8IwxX5v9
 iRenzVKmZhApG44CG9CiImdF+d8FN0AntRnX0QsugJRBR98luR2lfJ/u+9/xA1KAnpI4
 nMlXSkhY2ku4VEFj1V846zUjVRXj1ut/TCC9sutHXp/3zf1RRV53eM7FT5n5KN1SEy9q
 RuUP1ud83n9aagtFI5DbEXfx7Ko7UWNUfgWGoxoK4CCBRIpOwms9TuuUOr329uQz07lP
 E8BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWks+aL3wQSAzN95JQ7e1iTYErYYDejwEYGDN7jzwkcnE2JRHlP/5PkQIMy1GFywabAuN17h8o1lAY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEw1floqVLWw/aZjah3uSCcOIAjCQXwmKuwET1vs2dLrBflalm
 wQ4XTyV7ybAI4+a69Rib/6R5RNfTt6cbjWkmRSEUCeab0oj/IPIPUUNL
X-Gm-Gg: ATEYQzz15aOT3D9CGI17zrGNpCoi/TFsK1LLllfnfOUxcK4Xf411beNv9rEOlCxnIx0
 +j612VLa+aaNiZ9aDAWiTf/aNjuztniE7bj50IxB53NAmCcAspGtLNxN9S4XUIcZ84Wbt9/RYhX
 NGipsNFe1yECxIJ8ykKCGEkso4ZzesgoMmZ2GB5GVyNfjiVDIWeqDN7bmTwXe32xouvQ+ycEg3I
 sC4t4Ee+0+sieNVEienHXNVneAgFPZnUq8szd40I0MmRDChuaaHuPhztYp/7LYvn0Ytuae3rGs9
 KkztksSR9eYTiaIYP1GdxvhmQNX0YkJh4G6x/1ZAGBioPoe9EcWs0Uj6f/e+XZ4gyRSlxhxI8p4
 MnCfq1jIsEhany6muwnGTEZNKrdjHU78UMQTkItO9ERR9qhuIgIfSj417DMK1RTWYLHbjmrLtwl
 0UCbUvxZlU5ChH/hXMpaZyh6lmLvfV3TNvmdNVunsxkr4QMFqd
X-Received: by 2002:a05:6808:1a07:b0:467:5571:7f3c with SMTP id
 5614622812f47-46757048b54mr1479926b6e.6.1773408215390; 
 Fri, 13 Mar 2026 06:23:35 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:34 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 19/65] dyndbg-API: remove
 DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
Date: Fri, 13 Mar 2026 07:19:44 -0600
Message-ID: <20260313132103.2529746-20-jim.cromie@gmail.com>
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

Remove the DD_CLASS_TYPE_*_NAMES classmap types and code.

These 2 classmap types accept class names at the PARAM interface, for
example:

  echo +DRM_UT_CORE,-DRM_UT_KMS > /sys/module/drm/parameters/debug_names

The code works, but its only used by test-dynamic-debug, and wasn't
asked for by anyone else, so reduce LOC & test-surface; simplify things.

Also rename enum class_map_type to enum ddebug_class_map_type.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  23 ++------
 lib/dynamic_debug.c           | 102 +++-------------------------------
 lib/test_dynamic_debug.c      |  26 ---------
 3 files changed, 14 insertions(+), 137 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 34dbca0beaf8..b6198ecc854d 100644
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
 
@@ -89,7 +78,7 @@ struct _ddebug_class_map {
 	const char **class_names;
 	const int length;
 	const int base;		/* index of 1st .class_id, allows split/shared space */
-	enum class_map_type map_type;
+	enum ddebug_class_map_type map_type;
 };
 
 /*
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 34297f658bc8..e8ffc2b5b330 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -667,76 +667,6 @@ static int ddebug_apply_class_bitmap(const struct _ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
-/* accept comma-separated-list of [+-] classnames */
-static int param_set_dyndbg_classnames(const char *instr, const struct kernel_param *kp)
-{
-	const struct _ddebug_class_param *dcp = kp->arg;
-	const struct _ddebug_class_map *map = dcp->map;
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
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
-			*dcp->bits = curr_bits;
-			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id]);
-			break;
-		case DD_CLASS_TYPE_LEVEL_NAMES:
-			/* cls_id = N in 0..max. wanted +/- determines N or N-1 */
-			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
-			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
-
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
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
 static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *mod_name)
@@ -745,29 +675,17 @@ static int param_set_dyndbg_module_classes(const char *instr,
 	const struct _ddebug_class_map *map = dcp->map;
 	unsigned long inrep, new_bits, old_bits;
 	int rc, totct = 0;
-
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
+	char *nl;
+
+	rc = kstrtoul(instr, 0, &inrep);
+	if (rc) {
+		nl = strchr(instr, '\n');
+		if (nl)
+			*nl = '\0';
+		pr_err("expecting numeric input, not: %s > %s\n", instr, KP_NAME(kp));
 		return -EINVAL;
 	}
 
-	/* only _BITS,_NUM (numeric) map-types get here */
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
@@ -833,12 +751,8 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 	const struct _ddebug_class_map *map = dcp->map;
 
 	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
-
-	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8434f70b51bb..9c3e53cd26bd 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -74,13 +74,6 @@ DECLARE_DYNDBG_CLASSMAP(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
-/* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 10, MID, HI };
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
2.53.0

