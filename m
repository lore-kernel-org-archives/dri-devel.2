Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2956ACD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A7910F658;
	Tue,  2 Jun 2026 22:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZopH7uFF";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2890C10F65B
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:49:04 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so2806982f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440543; x=1781045343; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n6yMzakS1WVzaIBy+f9smd1nqOBpafHkibEk4ZXvtyg=;
 b=ZopH7uFFYn/Az5mnhlX/92ch2Jl/eAuzN4g7ceP7JpsUj2fvWruA8zNlsJCSEanfpe
 QXEDgxrIBHxLlE7t5boe8mWV8HROvBpgc63OTNGqvgnfU/WGuHsCNWq5RPoZgdfnZ0rM
 TyCqBRB+jFxO+lMlqoNa+qJcUtlEYIITDaZV+46f9DbjHzJN3ey4HiOr0fZe0NScR3UN
 fxtDBP2pRFU2Fy4ONbOkkGa4FggxQRvEWMuY+DfTkahpsF90vwNGC/GbtSm56kRxcszx
 1z1YNkovm8kEza4NDnYIcUdhOolgwfkJrNqC5ZFBT9e8YJghBUGnFohkeo6Z6JKlMFou
 qg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440543; x=1781045343;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n6yMzakS1WVzaIBy+f9smd1nqOBpafHkibEk4ZXvtyg=;
 b=ezD3mCUEe9t1Z0rpzPxH0++00Z7/pUdOH/OH6Dm7ny7KQ+3thViAI+SRYS2Exd0Vxd
 h1WAJvC0jJFar+G3BjvfaJtxnKMsIEYFP7dYR2MLdonGX1US7vkmPcy4hR8iWrPC6X6m
 kEX1pyRtdSLteqs8FyE13B463opLtxg0sbfLnnDm/+NCH/6gam6E6E1O2oTTvhQxFeew
 DSfy4bKqyn/ShMS2wyEq40fdaY1I8DnNqoA7yu1nH/1DRcfJE7QmHHHzEzwxX0tn4Pd3
 KS2pvE6F6AxT3H5DxMkDdsiP0pCBfaYXKVk15rQLIPHYOxSsnPHu3AmMJ1GX53mX8eBY
 fpuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TRly+F7JjCx3zZQw5LtlJ/NTsGSzqwOGbBzMRYh/SPcNiMRHDRfaBvhqq7cpEGnwBHOeLPB1xZB8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjCVGY4CyLjeqhCSSxGmj1Ju+am5czJSxrjvgDcFLRYewO61HY
 rcqM8hm5lyGZmZKSyYvuWGZ0UDdMkhFRCmAeZpoPkmdTsDOhhxeWvrby
X-Gm-Gg: Acq92OFKP/qR3e+rkKatLlnLNoX8jf6uLVl15W85MP9ZDeZWtiW2U/clkiY6ypD+vdb
 8kGSPpqqyPA5nKeDI3vWyD/lgQOmVfdmAqiyf93c7rnCfdDsbvKb5xQvqGIDYIGdcNNH8snX9Zn
 8sTEHP587mlKSKGkNCYP8gMhaQw5/Q7Vp3KH7IxE6INtHTqWKtTKOTgoCs2awQ1Nv8IDAzm+kUe
 3LGkL3iRetCAg1g27HrOlgpJcMUE8vnmXbpwlZXDaaEQHA8ZIYxko2m89iKdeMUX7/ctKwzLrJn
 HFPxVrHRQglBHrzBQ0K7ju30XzJvZHNDLGnI/EoRh38asEAjBy2wbVryyx6Oe0bbKIxyWIEERez
 Y45XUPnx7DdzqSHGNNnVlPHGthsmOhBO3imFbqOitQEoFjHGz3zlgiATzoklbzlAOf/U9UV9ehw
 YxK7hK3zzNonwpv+MkYjITT0f7FefLYHxQwEdmZRvyWw==
X-Received: by 2002:a05:6000:299c:20b0:45e:f52b:f4b7 with SMTP id
 ffacd0b85a97d-460217f1fddmr454368f8f.17.1780440542599; 
 Tue, 02 Jun 2026 15:49:02 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:49:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:15 +0000
Subject: [PATCH v4 18/25] dyndbg: Upgrade class param storage to u64 for
 64-bit classmaps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-18-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=8637;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=7QkcTyZCWN6yMIODzwkt5kyZDMXqN9r1gKsRuM6vY0A=;
 b=0tpHpFzLjk8I4uwZ21aYU4mH5QtyS0EHyjlodH96NB2V6T/cqfRSNVZpN0KHfArMXx6At1891
 X3DtNc8ymnsDLLJPKFCU+WzVHsGCA8A5P82H74gtj+knahAPOgRnlYf
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

Currently, `struct ddebug_class_param` uses `unsigned long` pointers
to store the state of `bits` and `lvl`. On 32-bit architectures, this
limits the bit-vector to 32 bits, which truncates 64-bit classmaps
(such as the one needed by `__drm_debug`).

To guarantee support for 64-bit debug categories across all
architectures, upgrade the internal storage types in `struct
_ddebug_class_param` to `u64`. This inherently makes both union
members the same size while safely avoiding truncation.

This includes:
- Changing union members `bits` and `lvl` to `u64 *`.
- Using `kstrtou64()` for sysfs input parsing.
- Replacing array-based `test_bit()` operations with safe `u64` scalar
  bitwise logic (`!!(val & (1ULL << bi))`).
- adjusting lib/test_dynamic_debug.c too

- Updating `drm_print`'s `__drm_debug` refs to `u64`
  further changes to drm later, when BROKEN is fixed.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v4: undo change struct ddebug_class_param to _ddebug_class_param
this is better done in next patch, with other normalization on _ddebug

v3:
fix undefd behavior when classmaps is all 64 bits.
change module_param_named( type-arg from ulong to ullong)
change struct ddebug_class_param to _ddebug_class_param

in drivers/gpu/drm/drm_print.{c,h}
api change later

v2:

patch was "make bits & lvl same size"
but that size was unsigned long, only 32 bits on i386 etc
use u64 for all bits, and %llu %llx

u64-fix

u64-drm-dbg

_ddebug-cl-parm-drm
---
 drivers/gpu/drm/drm_print.c   |  4 ++--
 include/drm/drm_print.h       |  2 +-
 include/linux/dynamic_debug.h |  4 ++--
 lib/dynamic_debug.c           | 34 ++++++++++++++++++----------------
 lib/test_dynamic_debug.c      |  2 +-
 5 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ded9461df5f2..3a470e808e39 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -40,7 +40,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned long __drm_debug;
+u64 __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-module_param_named(debug, __drm_debug, ulong, 0600);
+module_param_named(debug, __drm_debug, ullong, 0600);
 #else
 /* classnames must match vals of enum drm_debug_category */
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index ab017b05e175..21a0ced0b2f2 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -39,7 +39,7 @@ struct drm_device;
 struct seq_file;
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned long __drm_debug;
+extern u64 __drm_debug;
 
 /**
  * DOC: print
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0443781ed95b..91546a99014b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -91,8 +91,8 @@ struct _ddebug_info {
 
 struct ddebug_class_param {
 	union {
-		unsigned long *bits;
-		unsigned int *lvl;
+		u64 *bits;
+		u64 *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a593e040d1ae..f164e11c1853 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -627,8 +627,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     const unsigned long *new_bits,
-				     const unsigned long old_bits,
+				     const u64 *new_bits, const u64 old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -638,24 +637,27 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int bi, ct;
 
 	if (*new_bits != old_bits)
-		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("apply bitmap: 0x%llx to: 0x%llx for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
+		bool new_b = !!(*new_bits & (1ULL << bi));
+		bool old_b = !!(old_bits & (1ULL << bi));
+
+		if (new_b == old_b)
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
-			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
+			 new_b ? '+' : '-', dcp->flags);
 
 		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
-		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
+		v2pr_info("bit_%d: %d matches on class: %s -> 0x%llx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
 	if (*new_bits != old_bits)
-		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("applied bitmap: 0x%llx to: 0x%llx for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	return matches;
@@ -664,7 +666,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 /* stub to later conditionally add "$module." prefix where not already done */
 #define KP_NAME(kp)	kp->name
 
-#define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
+#define CLASSMAP_BITMASK(width) ((width) == 64 ? ~0ULL : (1ULL << (width)) - 1)
 
 /**
  * param_set_dyndbg_classes - class FOO >control
@@ -684,10 +686,10 @@ static int param_set_dyndbg_module_classes(const char *instr,
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
-	unsigned long inrep, new_bits, old_bits;
+	u64 inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
-	rc = kstrtoul(instr, 0, &inrep);
+	rc = kstrtou64(instr, 0, &inrep);
 	if (rc) {
 		int len = strcspn(instr, "\n");
 		pr_err("expecting numeric input, not: %.*s > %s\n",
@@ -699,24 +701,24 @@ static int param_set_dyndbg_module_classes(const char *instr,
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
 		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+			pr_warn("%s: input: 0x%llx exceeds mask: 0x%llx, masking\n",
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		v2pr_info("bits:0x%llx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		/* input is bitpos, of highest verbosity to be enabled */
 		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+			pr_warn("%s: level:%llu exceeds max:%d, clamping\n",
 				KP_NAME(kp), inrep, map->length);
 			inrep = map->length;
 		}
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
-		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
+		v2pr_info("lvl:%llu bits:0x%llx > %s\n", inrep, new_bits, KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
@@ -762,9 +764,9 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+		return scnprintf(buffer, PAGE_SIZE, "0x%llx\n", *dcp->bits);
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%llu\n", *dcp->lvl);
 	default:
 		return -1;
 	}
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 74d183ebf3e0..c049580d2152 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -40,7 +40,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * - tie together sysname, mapname, bitsname, flagsname
  */
 #define DD_SYS_WRAP(_model, _flags)					\
-	static unsigned long bits_##_model;				\
+	static u64 bits_##_model;					\
 	static struct ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\

-- 
2.54.0

