Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165C9C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6289A10F50B;
	Thu,  2 Jul 2026 16:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HvXFyeVJ";
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056C810F506
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:32 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-448de0cc236so1176977fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010491; x=1783615291; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Erf+9mXLsSsdoKA6DDUH191uMINCSbpojgzEHl3ic+4=;
 b=HvXFyeVJ24RLBNmWnzbIcCeeERJvT/LrdGMCJcDWBukSw5YjnMNyLDYV3kxjJGQfL7
 HcoA3iYU/RrPqP510NILlUw8e5O9E4h0d8KLjkZNVkvSNR3qcv+lWbuTOYzZdKU7rOGv
 CyDcZnwc7sitRoUAU2i2ygYeHBMQhT7tWT5cIxrGX9Iewb19xaU8wY/noChBDVDOoP8S
 1+PVSJ38ORizJbRHeLzrpej6EwAAeODozGy75WeXL5AQdj/Qr59qr4EhCKU9vvyBrMS9
 tORvybQuIzBFk2NRqOE5T7FLQcsAXOhLmptijyWN17/bOW80Rm/4FnkQA63/XvGiwcWL
 Z/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010491; x=1783615291;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Erf+9mXLsSsdoKA6DDUH191uMINCSbpojgzEHl3ic+4=;
 b=bSvKIyHJ7Dq3JPdCUce2DHxwr3xOiQcCw3RYOC5r8JvAdL/EX2rdbSulzSPGk3SKYu
 w6qO6q3JNAA7+jol3sh8+8ThubqizNCh3L6Ch3KVEr1AgK1RkYhJIsHwuWTGoLjOfi+c
 PxvRVGL+bOvyWvwmh7dOjcTBo7vYASDmpbSKDXPWtEQ/ywMyKeSRK2+E338pSwA8Dn+K
 jkb5HlIL0BUGnhJci7BErnvs0apJGuDkm4/1x91UOXmBU/VOav4oa6s6H7N7Dh2Ec2jS
 wtNW5XJTs37TzlByoMA2LqxoPkF2XuSygICUpQ0sMh0r+UHP9covp2ki1qVgrYbU0uIT
 e7aQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLsUTNRMIO8WmLR387UtTJt97vSMg3L3gZ1IVLZFfvpf20WwxcxlFJgFqWmftPHht0dSvRz/ntKh0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQN+bcjGfk81GZdzGjdTSKgul2m99Jg1cb+hVPfodSq3uTktIo
 D+8zZU1I1fZe4HM3fu+Q751PGPXXBphkvRzHL8ayGz+4Redd90QjkkKL
X-Gm-Gg: AfdE7clnT9XqRTvYb8COKNG3cqzquWdoMNoj5ym+2qCttqHhq+OuDolkFB1ldOhC9Sr
 ZiLjil3wCnOb2mUbNlnUeZnKJhphWUBqNE5oQXsFClFvUpIcrH9qO3ML6/zpCdizwU4rc5uErBL
 M7BX7//2G1ZxGgDdliTneQ+wY0zEI0xgwU/3xhaWfWKQwhTt/yjoMBf5sscfMeldL0q5uRTve9J
 izAefUzCJKr03y0bVVpVt2hUOqlPbYpb/uoa+y603iED4mYo8f4N1+GY7YBOYi9Ivi9C3PFPOzE
 A3LI7gQvx0cuj9msjWChYq6GfMKl/Lbf+LQeXE7SBLULvpWMFXX6TWh2rm4uyr/sPQAvZ44K9N9
 h5jd0xT3z73M5HvdRCuMsKomoCpHVY2hmdO3QtNb2n5xFRYRuA00TRGyDFIEtpyyQsEzw8jCYAV
 x7Dgl6sfh/3Cc8UDPRVvIXVCyKASNogLJj0lxEHP5VQbspB2L/mWY=
X-Received: by 2002:a05:6870:e0d2:b0:44c:a364:fea8 with SMTP id
 586e51a60fabf-44cabc88b37mr3590704fac.41.1783010491169; 
 Thu, 02 Jul 2026 09:41:31 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:03 -0600
Subject: [PATCH v5 11/18] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-11-24f22b052bf2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=DkA2pTZNQqVs9Nrf7TD5N2m0l0e3VhiWsrxu2lYAwiU=;
 b=8qVdQFuygCFOI55ytb23VvBu9ZTlSpFhxL0vul4wxXXXDard415mjlNzyLE9vOheQ5VjLSith
 GgQNUK30WNDBHOz/OQHVK/eeYsBfjNOG8IDQcKcLTTIGM/82SHFKPQw
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

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0fc9cd14e2d2..8c3b29904346 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -617,7 +617,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -626,12 +627,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -643,9 +644,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -693,7 +694,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -706,7 +707,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:

-- 
2.54.0

