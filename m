Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A55C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AEC10F4FD;
	Thu,  2 Jul 2026 16:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UlQQD8/Q";
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADAA610F4FD
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:30 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-69dead44101so1365947eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010490; x=1783615290; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z7bxxo1B+K2xgi+Y8TLpeTHXA6asmMdj2sriPZDg0Jo=;
 b=UlQQD8/QQ6fICqbbVOeugX24Sg5n78B0+ZMHdS7gML5OqbnyvLMUYhg8re9YGtmIAn
 CfkmePGDvlZBwKvoN0J8/tF5vJFkrVPBgUHTmzwpsMa5tXpa1FKI3E2C+oao69b33I5T
 CPx9Cqo7/wHWNOYPelBYa0vTEAk2eUmA09gymb+oCLXGaFPgshGsW4TgdiXTW2pmzoDj
 ELSa3xxTx4COeT8EEheq+uHJqGYB8FXIDCEDTs682FGsZm/GxZWOk9ogr1XEk39JyFBC
 5Ql/hSHuPISEGHNLSLw+QiwL+Feb0zSL4wRbGv6fRrBArhqi8k8H0WfrNj6G5V1l+DQj
 k70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010490; x=1783615290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z7bxxo1B+K2xgi+Y8TLpeTHXA6asmMdj2sriPZDg0Jo=;
 b=qv8Y8tZECUsRKpc7QuzVew7yAHjb01/Uv/HVL+1SeZ00frXnXpqD5AneGuffti5DbE
 iByiJHpQdcp9hFiYUgl6OXd5PTZWWK+gwbLBObl600kTUjWaS+oiig2kebY0jR+3rtqY
 q0bsLVFO2hvg/qaSmecUTVaP3JxJvd9ApmKFDIztl8zSl5NdNS/eBjk+SVbwIh81FuNl
 Phdb+JXe2tQnXYEaxjJJzzp4QtYCVE7I6HVbvqf1y88pRClApkz3ParCKw51Po3CCKOz
 EEnZqHJkKpWE+LDOyVREPlr+hMAZ40NIpkZOH7CaA+QWEMZgkvdVoS+fvFtFY4uDMUm8
 CaSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qcZg5BAt7dbwwCL0BGrSRBBpZkAvfrBlMeqacsix18CBuhZn6KnZiGNmbnV7Ee2MqfCFAeEZk8zw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtbkWXJhx7eOf0tNhKGVp0HLOwDAQm16Q6xN9MHfXheA4iy6uI
 ueXDP59faiisIh9PjgWfG6Zv45+ynDxDsxbepY3pFNGHPEUh2+D6jGNA
X-Gm-Gg: AfdE7cnL8gfMnDZ19srVzsV7CYrsynUOBxdL7peHTEcCuLHqk18jNc9vmZFoXIQjjlU
 HlgfG006k5xnIgjr9iclm6tltFEmu2POJsO1iJAqHDHsntzpLeYArhw1J/QyQR0DYT3MeiCSpQP
 YIhUnTn1UUOvMqc3d7TO+g8EQjcjyE1j5pR+4e5LUUi2Fp4FlLad8VPr6HmRpvaWcVXWixZ7hmQ
 U4IJpoZm0tfL0vDayEL1TS6GC/qOdsi9ZhJFuVXmAV88Udyu0mZMXcYqgl/x14EfnlBpYRbSz0T
 yftVYfeiUOKt2RqCXB7v2rloqV7oqAiObb+Fc7b/Nn0L+imn3rjsYbfAD0BMayo72HL0DNTfWlg
 x48qIQ1Qorebg41iOzoirht21b+miERVZkkhvVi67O3GPLM5674YTWvn7oi8YaModcptM9zUP+w
 y/gGBa+s2JcaYmS8yMYP5lWBLyjTAzUlR0aANc55Y0XvIletaYUmptIR3mZKm5uQ==
X-Received: by 2002:a05:6820:151c:b0:6a1:3e91:dcad with SMTP id
 006d021491bc7-6a309974cdamr4260572eaf.29.1783010489767; 
 Thu, 02 Jul 2026 09:41:29 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:02 -0600
Subject: [PATCH v5 10/18] dyndbg: refactor param_set_dyndbg_classes and below
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-10-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=6125;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=tqt5MwiD6HrQDvcR6oykSbqGC2S5kT6zF+EiGPTLOLQ=;
 b=dtCmCUkIoPQyPYUkmr/tIhrdAZAkTruYS8RLcJJsPFM2W/MJ8aSTSu3o3jka6HXYcJGj2EFzb
 n6Z4WZZ41aDBc92CXsRJa3H8g9D+rPox8CYU4Ywq9+x8JepISk3xy1l
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
---
 lib/dynamic_debug.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ce42e03f1600..0fc9cd14e2d2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -615,9 +615,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
@@ -625,7 +626,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -634,12 +637,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
 
@@ -652,6 +659,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
  * param_set_dyndbg_classes - class FOO >control
  * @instr: string echo>d to sysfs, input depends on map_type
  * @kp:    kp->arg has state: bits/lvl, map, map_type
+ * @mod_name: module name or null for all modules with the classes
  *
  * Enable/disable prdbgs by their class, as given in the arguments to
  * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
@@ -659,7 +667,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -682,8 +692,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
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
@@ -696,7 +706,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -706,16 +716,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
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

