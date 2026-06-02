Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F2CCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F281D10F653;
	Tue,  2 Jun 2026 22:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDyKwjtZ";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF01F10F653
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:54 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso30015775e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440533; x=1781045333; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kG9RuYZKN9VVlKwBSxHqXl1ePoc3WUv6h82ZqRPI728=;
 b=bDyKwjtZq67OG/TgOarodinSo7MP5G4m/X+ZcmheP4625WCzm3nGNSqBybD+NpjdSg
 e9u6QaP07dlPLxeiAGB6E6Vf8huV+F0msEZ/TDWzTmx/t0wuvtEa/ZIUmrnPEjVl5nnO
 cqrCfuCHIwPzzZmjKJxR9T2gIbBVDLUFvmU7SJVscrV6dIbAnDEQxWJd/WVOZdYX8g9J
 VbyBYDTbVWJsT7EzuhbD1nIzalsHyt/72fHSsRvVAAqo7Nv6zoUh9HaL9aMSJk/RzwdL
 KJRMBAtZypJaPCL5JJzkt3rVWxb8/hx+ZF38vEB4k/5m/oDPSEMgMDsd1iZUZQd14LMd
 mMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440533; x=1781045333;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kG9RuYZKN9VVlKwBSxHqXl1ePoc3WUv6h82ZqRPI728=;
 b=eLUMdCOgXhBapOLKPDqnjTLb0A3+weZtXStoFZc3gYXbK5LATJeICJoADkCMyoyQwh
 59QSgqfAzEgVwz4RTpi4unb3Yrc9JH3L7BDoQaarWPcdf0H2yPDAVfReo9V32iZxtd93
 p3x9ThzoQlvW4HT8K5gY6M6h4WD3E1b7gBj7K7ctMm6/VzB1FCLJIL/tMIFQRE2YWbmE
 PzwU5fjyllWkhiI6I4NUJBOklq9qA6+eGO3NBTihu2WcDXwW6P98AUcD6VojzOTmaBQS
 oW/6g4zcB33LrhEmobiA3Lp2oJ0lsKIlV1DhyIMoMgciko+CcXTaB3Gs2sqiY10nio9t
 dKPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pF3ws0VbgUrWeDtIZQFyIBY4mpSWR/LILq6wewgKbDtRGJOniKNtIIAS7yXu8XJP5vt8NKjMvyrc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE5iaRwQDaiv+ZNU5ePcTuRDDqe5NZ8Hcy+28RiS1BCtWpmPH7
 9sUaK3IWjbhc/PjpxLQOjSRjJTu4mUlbE9KUL/uIf/Tz5QotIkSf0TPf
X-Gm-Gg: Acq92OF0M0/0lAdPD+6mlu2xNS9OFpvwALBZ7zZq3ccFuvTpU59vO5VDCqc2yHbOxen
 u8rgww9hjxDY/yWMxzKLHmDOnHWDSV54zS/npSfLTwhntunyVJmkpaoB6yWvyZ2wXLJf5JHglN/
 nxd1P0xyaQwJ8ENJERtJYARqTZotpZTQyAzcXdfeDxGFWDKahNGLOaHmFDcNgiGwdvyA0lxRUx5
 LE41KlCPP3SpR0vwre02ulJBNaPznrzR+fzLxjVHb+mVX03GXqPuDT6HIk2jaloj7iq++afi0X3
 yMpQEycY3aG+Zi2u+y2x/w1CetiFHxP0PLOePWXFLaEXiBKwKgP+k2xaAtjxzEdtcDvx59ci034
 k3K2N13pT/dKfGei3CyKVDcPz2X8s9hrrPn2YzRURZk6jhAHto8U7t0tgrJLb8sNssMHYMvnvwv
 fc8OLC+WtmFTaARf8UdnWruQ5ux++eDw8/xlHKlfncaA==
X-Received: by 2002:a05:600c:1c1e:b0:490:b00c:8e6a with SMTP id
 5b1f17b1804b1-490b5fe65a6mr12193215e9.28.1780440533361; 
 Tue, 02 Jun 2026 15:48:53 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:12 +0000
Subject: [PATCH v4 15/25] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-15-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yYzaloSWpMCcf2mBssnDdUdry2Mk3lsvbkKFQrUnGj8=;
 b=jjLEoXkJF9i9OhldBjaZjELUHRX0zlhmfVnIaKMKki+R8Pk2d8dPgzTVoDEdjIo3+QfsdvfLR
 ByeKIgUGjr4CkUVmBBRNr6e+BZVeYA+GMu2Kfz6YrJtQGL+T8veBJhe
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
index f59fe7b25ea9..9bd521651c48 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -612,7 +612,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -621,12 +622,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -638,9 +639,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -688,7 +689,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -701,7 +702,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
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

