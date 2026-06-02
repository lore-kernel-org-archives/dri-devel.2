Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B3CCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1277E10F655;
	Tue,  2 Jun 2026 22:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NuTAXzzU";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739D710F655
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:51 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso3160371f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440530; x=1781045330; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cHUkaftriuBz1I51Pi91MxDc690icL3AXvv3wepV7zM=;
 b=NuTAXzzUIFCRCwFYxuu/I2AOYcF68vV/4M6M5ZaWISUWi9N9MbRRVbc/uAgwW612uK
 qgiBrMKVyGpee6QbhanzYZmsSmyDeOYoBC7PzRHQa6RF+2uA4DVBoy4EwpfB/D2U5+uF
 WUEORhGcV8oJWNLO75queOVGgJgivk5v5kyF2/uF7IvFJ+AG3Cyg7eWN1SY/9J17PjHW
 IkItNaOXyqPSyrNs11wYursm+/muM/9NbaivT7bLCCXKVLKWlc7LBaYcBwb4nHujB3Gl
 EwJ03vcm7A+vIvfTi5vCbjQQ9AYDiS3fSu+kk1leLZzryXm/iCOQtK7PIAin2q1NdIcy
 6kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440530; x=1781045330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cHUkaftriuBz1I51Pi91MxDc690icL3AXvv3wepV7zM=;
 b=s6YAGvdwoYa+CUdNBgFcSeptf54iZvwYrZy5dXM2MzKSqWIAdtMY6jsJjWe4aScKEk
 m+E9XZ4qHN81dq6BbDH9y5//9rZ70Mzh/GKyzGVpttjOXd2ObwYJ/YwtKOiXu/8CYA/y
 UCSxmrtckFrnsq5R8TN4gg7we2c6PNKkV1LdXQV0bLcjP5NIJP6yvmSprATi6YIYy6kn
 pUwdSf3gHPAFzc3/9Iew0TPcxAHtJ3tgdie8Wo/m4LjHHOpQ/m3/f8hnhcBUxQqVJPNU
 4zGT0LZMTD+m4vzhUh66Nb6FlQDFbzPiHVJxJ2lLFMEKDinl1/Zyt8N9zfZGV4UwT6PB
 zyLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qL/dzpUJjVTAwZAT2FgChFRvhUf7YIUfAI49Lspbv5kd5ZfQ7UUYyD6ohs8BS11VvqDKx1uMxe0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/Q9DgETl7jnmqy+TseKmSEXDHLCec+NLr6q4Wfu58g/3+HI9p
 RSKOrcjXXJFtCa2ILHyE6BlCv1Ye7WheFHpJtoZ/4AxSMsExIkCoQDWq
X-Gm-Gg: Acq92OEcRBYuKZdgF6IsLfY81FERSDdD9jN3G4stDfQvX0uAsW2gvgrkhHhHTxE7nIO
 9ckapQbUWxjqVA4t3ILqhryXPPO5brvc6w6rvAFoPcPlgsQSXuPXfgFDSnnB+ccN1NbrWiTcaYM
 2IkofFJUCyErSoj5pC6h7EmX5tKuL2oyYBa1Sij0m7AOZxlhyMLwvPA62UZxyToTmDrkoBA0KMJ
 19l0LyIoPn43ARaa3hyCgOwv1sggAJM/2kBobUBQpSICox2Vu4BCi32TJoS30CpeGGovKmqLVyk
 wAiKZ6m4OsI4AUSH8rteUwBn4jmZAuTBd+AydQCn+J0BMxl4IQedVQxJFNTnvY1rnsXjq7GW3rP
 bJr8EbE3oc+ygQKIz0sgswST+H4N/UYxgRQhMQHIgi3rBLPvVwZlcBLdHBUkJLG7GPZRZ9ZGujm
 Z/Gcw9b+IhOW8nGMelMod69DNU6ELAkFQZvpdLcuh8vA==
X-Received: by 2002:a05:6000:2c12:b0:45e:e3ea:1101 with SMTP id
 ffacd0b85a97d-460217e3eabmr717005f8f.17.1780440529770; 
 Tue, 02 Jun 2026 15:48:49 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:49 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:11 +0000
Subject: [PATCH v4 14/25] dyndbg: refactor param_set_dyndbg_classes and below
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-14-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=6146;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=h314q4SgzcLZs5zSIhdTXKF8/miA8xW5BwEyLKquswY=;
 b=+vaQbkvBmItkENuH0Sby16WrI923FPRJx+YTL6H2fFFwgm2l3DAqqE03QJWrfGp4jOg4K/Nev
 iMnKtry41eJBvqKyCRWLHeD1tXZ4FqKTCS72cYFQplzfW0jo4/eFygW
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

Refactor callchain below param_set_dyndbg_classes(1) to allow mod-name
specific settings.  Split (1) into upper/lower fns, adding modname
param to lower, and passing NULL in from upper.  Below that, add the
same param to ddebug_apply_class_bitmap(), and pass it thru to
_ddebug_queries(), replacing NULL with the param.

This allows the callchain to update the classmap in just one module,
vs just all as currently done.  While the sysfs param is unlikely to
ever update just one module, the callchain will be used for modprobe
handling, which should update only that just-probed module.

In ddebug_apply_class_bitmap(), also check for actual changes to the
bits before announcing them, to declutter logs.

No functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a967e3ef1dbc..f59fe7b25ea9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -610,9 +610,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
@@ -620,7 +621,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -629,12 +632,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
 
@@ -647,6 +654,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
  * param_set_dyndbg_classes - class FOO >control
  * @instr: string echo>d to sysfs, input depends on map_type
  * @kp:    kp->arg has state: bits/lvl, map, map_type
+ * @mod_name: module name or null for all modules with the classes
  *
  * Enable/disable prdbgs by their class, as given in the arguments to
  * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
@@ -654,7 +662,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
  *
  * Returns: 0 or <0 if error.
  */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *mod_name)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -677,8 +687,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -691,7 +701,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -701,16 +711,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - classmap kparam setter
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ *
+ * enable/disable all class'd pr_debugs in the classmap. For LEVEL
+ * map-types, enforce * relative levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
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
2.54.0

