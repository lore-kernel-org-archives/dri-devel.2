Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D89C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D619B10EF8C;
	Wed,  8 Jul 2026 02:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jcUBoHKe";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9FA10EF94
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:19:02 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-49fa951b2c6so164334b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477142; x=1784081942; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NbF6QlEYI8YeAh15gg2DHV7921lYu+qQ/2CzzHDk6K0=;
 b=jcUBoHKeI9ngvU+l86hma0qCTNs8/xi6ImLCi2/z+ZOrvi0gNTnTz9RwQe0+rmQS4z
 0EcqoJa28FDM/8kyXtmYn8PtcTqN50nD4c57Zf6T7IYgs4sayJEKRAVDFpfEKqOso5w/
 fnVMu3B9EjgZLBS4rPsW8wohFKYmiU9//la2rRREett5j0vUZ8eRDnOvcoS/UZ6bJPtF
 KKMk/kVB3LjJvpPMEnJM5JlmLIY2EUITWJYtTiVhFCkDVX5IFK60WpeFk225pJviIpYA
 6Tn1BJRuqzX9TrE9v2TEwZEgfLbFt8uYTjgQf45lJO6ywxHvTPJuoK/G+p1ZJtmhs84A
 ZNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477142; x=1784081942;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NbF6QlEYI8YeAh15gg2DHV7921lYu+qQ/2CzzHDk6K0=;
 b=KkhsdoD0yJsnBd/bDeOLVMxMtyJhMx18TZrtQxKvSX4HNrHVhtrI7Sspt74evgHbqk
 0CyYaGt2l4u9NpuacjFy8xsP8PdF+AI2KA3TUna4dnGcSTM38NtpcTDHulGmHFWPIrPF
 tPIq9RALD4G2v4cykE9OmBlEvYocibXvJcfRFbbctE3ux+ymIhzbpPxQbpVQSHdI57CC
 PzEbJOjy1mFhgmgphPyOiPHRGwUyLMK1C0U8Ur12x/XhFeAOQcz2i250MWX5wEZwgYz9
 pCv8Exo0GIxFeNcf1CMOxQSkkM+LUTgNQlZVuOvVGso3yBLu2JGB6tTcu+kcT39tNa/O
 Pvyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TtgmGf58NTkYHeUT2JNt3t8vXJaq5LrUcUF64Bwj/8xtYtgrizwIP80on0ZJiADcPuOr3XojyhWg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2BKuicFQYzNImc+A/bTfyB650008dQV7mjjfnZZHb0hMmKqwN
 ihuLQbT27Obppv4XhskHuOYa4z3Q9K97Xk9PCmgrnAw/+Fap22B3feZF
X-Gm-Gg: AfdE7ckju0nXvwksoKysCqZ8DW5cs+iV1lpdLdzJULdXhn66SM05lgUqZ61oiYIRY7M
 7K+WEJg3MMKhJx5HY/Drle+dwgE2MRoYfmNp98hvbUQWx/6u0zrsUgSYI2ogYPkRchrg8UIBpOj
 +D5A25u0bYp+UAG0IBmtr1fNhyEieYN5GIippS8Mb0icjozBC3J9Um0PPK0RAl7zK3mo84Ph6ry
 dCP809de3HDRYgopnyzqOKWjFR6qKIR85PZIDU6RPsSeyieeErWTJb4kGDRsXR8QUfRwIYdVpHn
 N4Zp7sKuodY3ugkzerN1XRT4mRRrFyTC9MUbU+DT8X5e6a5EMbEahrpbIBMuzVonJQrDtlahcqC
 Dr0yiNku2pVA/gbp3m/o2RNs5KliBalsNa1CMRUCn2bwG4p9gnov5OWZ+C1fy8/w8JqZeE9K81v
 b45ofywwr+CxSbotS6yt3IJo6CcUCjTXWOZXrsqZhO0GnIbRq6OaQ=
X-Received: by 2002:a05:6808:1495:b0:497:d3d6:6a56 with SMTP id
 5614622812f47-4a1fed56c03mr344760b6e.0.1783477141665; 
 Tue, 07 Jul 2026 19:19:01 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:19:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:19 -0600
Subject: [PATCH v6 19/24] dyndbg: pin class param storage to u32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-19-381f3edb0045@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=8850;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yuU7Ney2ZEpZhcSHRLhN1Hd3JteSoqhbjcNCSJkzkCQ=;
 b=XZFGUjWBcwqsRZm86CChkkPojSZOAMoeFFo4g9T44j5GcKu2eglhFgA5GpdMz8s+iUnw46bji
 OyIKo4/5amiD9I76DHuP0Jsk8gQMyB0Lppz6IQjoQK3PozAplEwWZq5
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

Currently, `struct ddebug_class_param` uses pointers to `unsigned
long` values which store the state of `bits` and `lvl`, so it changes
sizes depending upon the architecture.  Make it always u32 for
consistency.

The bits field references __drm_debug, which was unsigned int, before
commit f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
changed it to unsigned long.  This patch changes it back.

That enlargement was a thinko; although modules can have up to 63
classes, and *could* have all those classes in a single classmap, the
real reason is to support multiple classmaps (with non-overlapping
class-id ranges).

32 bits is a practical limit for a class-param's usability since all
classes are set together with a single write of a hex value; 16 would
be a realistic limit, drm.debug has ~12 classes.

  #> echo 0x0fff > /sys/module/drm/parameters/debug

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5: u32 for all arches
v4: undo change struct ddebug_class_param to _ddebug_class_param

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
---
 drivers/gpu/drm/drm_print.c   |  4 ++--
 include/drm/drm_print.h       |  2 +-
 include/linux/dynamic_debug.h |  4 ++--
 lib/dynamic_debug.c           | 35 +++++++++++++++++++----------------
 lib/test_dynamic_debug.c      |  2 +-
 5 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ded9461df5f2..711ae6606c6e 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -40,7 +40,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned long __drm_debug;
+u32 __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-module_param_named(debug, __drm_debug, ulong, 0600);
+module_param_named(debug, __drm_debug, uint, 0600);
 #else
 /* classnames must match vals of enum drm_debug_category */
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index ab017b05e175..ed7ce7d7b74c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -39,7 +39,7 @@ struct drm_device;
 struct seq_file;
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned long __drm_debug;
+extern u32 __drm_debug;
 
 /**
  * DOC: print
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index d164a24dece1..250b8391cb14 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -105,8 +105,8 @@ struct _ddebug_info {
 
 struct ddebug_class_param {
 	union {
-		unsigned long *bits;
-		unsigned int *lvl;
+		u32 *bits;
+		u32 *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d99c69b9ad12..af05f4ae3b55 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -582,6 +582,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		pr_err("query parse failed\n");
 		return -EINVAL;
 	}
+
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
 	v3pr_info_dq(&query, nfound ? "applied" : "no-match");
@@ -632,8 +633,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     const unsigned long *new_bits,
-				     const unsigned long old_bits,
+				     const u32 *new_bits, const u32 old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -643,24 +643,27 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int bi, ct;
 
 	if (*new_bits != old_bits)
-		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("apply bitmap: 0x%x to: 0x%x for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
+		bool new_b = !!(*new_bits & BIT(bi));
+		bool old_b = !!(old_bits & BIT(bi));
+
+		if (new_b == old_b)
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
-			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
+			 new_b ? '+' : '-', dcp->flags);
 
 		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
-		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
+		v2pr_info("bit_%d: %d matches on class: %s -> 0x%x\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
 	if (*new_bits != old_bits)
-		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("applied bitmap: 0x%x to: 0x%x for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	return matches;
@@ -669,7 +672,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 /* stub to later conditionally add "$module." prefix where not already done */
 #define KP_NAME(kp)	kp->name
 
-#define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
+#define CLASSMAP_BITMASK(width) ((width) >= 32 ? ~0U : (1U << (width)) - 1)
 
 /**
  * param_set_dyndbg_classes - class FOO >control
@@ -689,10 +692,10 @@ static int param_set_dyndbg_module_classes(const char *instr,
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
-	unsigned long inrep, new_bits, old_bits;
+	u32 inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
-	rc = kstrtoul(instr, 0, &inrep);
+	rc = kstrtou32(instr, 0, &inrep);
 	if (rc) {
 		int len = strcspn(instr, "\n");
 		pr_err("expecting numeric input, not: %.*s > %s\n",
@@ -704,24 +707,24 @@ static int param_set_dyndbg_module_classes(const char *instr,
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
 		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+			pr_warn("%s: input: 0x%x exceeds mask: 0x%x, masking\n",
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		v2pr_info("bits:0x%x > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		/* input is bitpos, of highest verbosity to be enabled */
 		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+			pr_warn("%s: level:%u exceeds max:%d, clamping\n",
 				KP_NAME(kp), inrep, map->length);
 			inrep = map->length;
 		}
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
-		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
+		v2pr_info("lvl:%u bits:0x%x > %s\n", inrep, new_bits, KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
@@ -767,9 +770,9 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+		return scnprintf(buffer, PAGE_SIZE, "0x%x\n", *dcp->bits);
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%u\n", *dcp->lvl);
 	default:
 		return -1;
 	}
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 74d183ebf3e0..9e8e028461ad 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -40,7 +40,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * - tie together sysname, mapname, bitsname, flagsname
  */
 #define DD_SYS_WRAP(_model, _flags)					\
-	static unsigned long bits_##_model;				\
+	static u32 bits_##_model;					\
 	static struct ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\

-- 
2.55.0

