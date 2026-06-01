Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF13CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB3311327A;
	Mon,  1 Jun 2026 12:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d357Tl3w";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3C911327A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:39 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49041e84237so82060455e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315538; x=1780920338; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LWYGhk2F/MyqS6FkLrsC1PXV1OSFLSJSVfJ4W+L2Bjw=;
 b=d357Tl3wOlaKVEkP4E+lSZLFceQGMwJzM2uZ2gRg2Tn5O7tVIa96BqOzL3CR6m/eDb
 6HAhThiaEHZCpyIoLgeA8wwQSDzSnppUhhWkwsaJP7sdMqr1efD6BedbAg8x6ZtsVSSC
 F5ykCLccpNvOXybZC8HGABYOf/4d8qIC3wD/wIe7hu15e1ENdHx5ONBys6+9XTm6gph2
 eNtnUEDUDPo9sTRdXtUIkFfU5WfU1QrfPwpOa7HhGKTxCty9pyVJh97uyhqMzXfUqWQK
 8XR5earY+p0XuVwCSlDW1Y3byJq11l6SHcFA631OqvKPZKFX2IEwD3nPSQhauaoB/n7V
 WIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315538; x=1780920338;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LWYGhk2F/MyqS6FkLrsC1PXV1OSFLSJSVfJ4W+L2Bjw=;
 b=ARrR/b/ehpQpGbSQr8ZlaZdABzGLPWHALwmosmpu6QCEbGHGr5nDEiA9hbZj3j6qom
 We55uM0/RCblbo7kgdW4YWWOEzlCkQ+AnQEWiCKxEfblsh0k8ROuG7y7XLBruWZ2wOtc
 Su+ACfLMMaUno/FGKMPWjVOtQwRddv8kmaClGpi08VN/oTld/T9ASQuai3CCrLlkV1Ew
 aI5GNjMFlqxiClUIZEW9HoUHtkfGIWYA3jJjOo2kXMQnjGDngMNUJteMDUdy2KgAx99E
 zuNsZkYCpj1BTqhLJ1hy7ebi0TZd4RP/olbdkUqlErRX+e8BGAOEEPA6IIRMJeQd1nlB
 hhtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YqeU7lYAr1gLh1yj6gldMb+IoTULQYUOlPfs0/4fUGBRkTOHFYbsO75yj7D02siOvlDVZQdYjtFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLeXGB7MQ63VAuUB87PThuqRc4EZuw5PBYq73/tzmeoNhqw9ud
 Tbjs3bEQRCWLrgUCLP6hQWvyrk1cE2xLgMfAq0+qxj4KRAoSU38AVrt0
X-Gm-Gg: Acq92OH1F20g38vJ4Qt2Owy6bLQcTfr6by/E43DBvt3ZbC99n5w8g9VguMvly3fEFm6
 9/waKr9TFMOkiwH2ObxDQ8o2gTm/u2qG3xOrw+KcHhkrWSjvqTnuTnSMEkvzRfgYVt0wTyhRaxV
 JxcFWnUozuCfccBim104+vMkWeZjUehGuZx1fznLxR+lNV13SISkfMNCwDlX7uFz8WBSU40+ng8
 ozkRv3srbUX1/If2EThFkZtCkHDVLD/YlG7LjkcrWBvZbWFvkmD390hO2jk+xVHz35LSL76yjum
 kL7YFXGjR27+aCvO6D4BSdXR73MMm4HTJdYNqcXdWiLtm8wASbWaoMrIyiwz85wo8IKNUgA572h
 kE3jq9Fpg2r9a3pO2/YwDhnwBEeJ2I+Dbo0CJWAuuvkBYbsBrkFXlcVhzrSRs8wtCRJoo+caxhg
 GAXPHBqIsXAzWgBtIWAvc1zLcgzyStNeI/NljPlMctng==
X-Received: by 2002:a05:600c:4047:b0:490:afd9:93e0 with SMTP id
 5b1f17b1804b1-490afd99800mr2527795e9.0.1780315537003; 
 Mon, 01 Jun 2026 05:05:37 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:01 +0000
Subject: [PATCH v3 15/24] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-15-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=qrUOU8qnHGg0JvQozawLRdf39GqEwr6BMsdBUWY+zJs=;
 b=XmNB1fBFswv081gt/z1FJsg1wqGy9IGRATjjRtwSJGRi+5lebAnhlFPLse3F6qDEwV+zvZ0GH
 iOECBesKIdkB+6EBhmJin69PnZREkOeg/nCqW3L12Y0nksUfKl9Fqce
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
index 182b84b6f6c5..bb7e16d38f19 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -610,7 +610,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -619,12 +620,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -636,9 +637,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -686,7 +687,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -699,7 +700,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
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

