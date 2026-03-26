Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3579F10AB802
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A9510EBB9;
	Thu, 26 Mar 2026 18:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L4w1+dS2";
	dkim-atps=neutral
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5724F10EBA2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:55 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-66f3e7d9eccso778803eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551294; x=1775156094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr3BXrtiuAvHSgc8/DPsjTxu/hA/+WXgrNkg64S657g=;
 b=L4w1+dS20npyWOJQsM4WDDaXkFhjtieVvSGbRRx9+HJLSZonIblaYxjgHAuuvvYLRh
 y1uIzD5KgRwvMY6bzK4zExYVJW7UtLdgcrYwEOm9U1WPO3h+QPejXAYtc9lcO1j6c+w+
 ni99t0/05VYysA4cBZi/94h7AJBptVgt92WNb8WxunBCxcDg6wTW4X020I6p8dJ3aUyk
 Bhvpk0bpZy0l4cd7WCQ0swNdtA3NrYFcXdEz2ntMxdtZqUsxR0XFXlas6kkHEn2wj+0b
 YsVfCCS1j6jJmHvtuqZAkY4EMZc9QesqPDHgBkf+9Ie3kt7sxSNYrcGHAZV8PpDxNyZE
 8PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551294; x=1775156094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lr3BXrtiuAvHSgc8/DPsjTxu/hA/+WXgrNkg64S657g=;
 b=Hz1/nXPEdIySJkmdce0GO7LSABRTGvMMwMdVTLvVuMgAk07jha9yZi2lEa0jUM3Kfb
 Zo87I+eXmHp2FI568xSbFFQqA0aSZMiuGUSjM1fJ2RE60d/pmCKulUOzh6Gfi0nkGGJZ
 yZoj7VCBgmOEWr0wnHEhrLz/uknzN6eca7bz5BT4SSExly+SYjqgVDZXyDWf100sQBmD
 h9eZcfGOp5fL2d25ylx8O/e/9UFJB8xH/0lD98Pp5DCQKEueEHWayyXG7hnX8wpiGk4M
 nQLxBkN8GPiBj5bj3aRvfMg5JNQJ52MQcW2O1Lfzw3uk5BAPcMvrO5TFZpQq2NG2vJ3m
 onsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5406JcD9vEIxwGHHLCZ65Tao2O184TGdzzByCvcoo88HEvE4eFp3VyLNfypS1bU/2m3rhH1zesOs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAXVtN7WXrF9ooq072Zke5OaBjlX9iGV5oe4qxNXc1skrj+ckL
 t3YbWDgdel9HrbqprOjhwkIvr/vL49P2fk6RCU2gBeNR6mbtEi33VR01
X-Gm-Gg: ATEYQzysUFaUkVXsSrOTlraDaO/oLyjxB6L3nqTOzJJvAWL2d4cPU2ABKwFt7Bb3scI
 HKVW1p0FCEr4LyREsMN8wrpb+4IHN15qgXT/zjEhJ1Eyk0+u/X0rTyezgpZ+s2sCWppMUTPKa4e
 8N1LXRZedfUMiOqVK9AtTrwp06DGobLEUKRihiYv5QpFM1471ndc6LOerNeDnQh7/DvH9Z93/k6
 i6iSXyzqUBzI9e44RzaEvkbTnhe6hPlH/Xm7Wlk7iwADgGKYkHcPnxkwZdc8hrRQ58W4yByY7Q1
 mbHFNJlqJR7BcT9jxRHOv8OfBY9IYhGol5Edl7ZlbhOIYiTJsKeJ7rdXCXBHirvej0qTgIl5x4q
 rDwv5VLzZWWKtJ9beduj15CzbymE2LtTKNVpIJdJxYn/kr5t+wmR8FnprfQerkPDULFT76iwXDh
 uRcwaGjR+LpQn28/r0dI9yDsHhEI3syREZwMdyruCh/TudV+JuUsouYxqH1Nw=
X-Received: by 2002:a05:6820:210c:b0:67c:1d90:3949 with SMTP id
 006d021491bc7-67dff4fc06dmr4216223eaf.48.1774551294126; 
 Thu, 26 Mar 2026 11:54:54 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:53 -0700 (PDT)
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
Subject: [PATCH v12 16/69] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Thu, 26 Mar 2026 12:53:20 -0600
Message-ID: <20260326185413.1205870-17-jim.cromie@gmail.com>
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

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 4313c8803007..a18f4bc63473 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -607,7 +607,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -616,12 +617,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -633,9 +634,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -691,7 +692,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -701,7 +702,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -755,7 +756,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -768,7 +769,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.53.0

