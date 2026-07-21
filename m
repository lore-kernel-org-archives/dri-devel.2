Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EEBC44537
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF1710EB6D;
	Tue, 21 Jul 2026 20:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iuc0pghF";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62A110EB45
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:37 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7e9d7464b71so4196335a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667457; x=1785272257; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GcxmLO0X4fD/rjCQxJy9THFKb1UhZCTTFFY7ow+im5M=;
 b=iuc0pghFoY9SwjUhn1rVEyH5i1uhfCl4PXkU892duecnh3sBEPXPW1HIJ9gqXNSFJ8
 w3f9LUOSO2SGNiXgOt5pfoHxjHmA+g2y8ER+0MCPDiXCn6nlExxkmZJMI5payeb21itE
 vN1Ydn+4YEgHVWH380jIXVrJqyw12vSgtXeIe+FF80/Hz/kTN1w8r8RMYSEPkDD9Yv7h
 Qh2DIXJUo9Q8Xgaz33DjIvwrDQ4XtuJWcxhQc4Y9JrfBV5E2aqi2cAns/Ft3KnQce2bt
 2AvVf0SpSE+ZCXaKHr2G3xtZIcfrm/uGt0LRbQuQXls1+P/KIHHbrKn6YR55WP/wwX5S
 ZX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667457; x=1785272257;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GcxmLO0X4fD/rjCQxJy9THFKb1UhZCTTFFY7ow+im5M=;
 b=k3RLM0fTIsPY4iQ9vfYSqxa8U4MVQLWJhwNwmQ3tSVz+tlBT4422V3qxS51ozuab4c
 buAT7mOiElsES+CqMdLILluV6Bdy/1ftWyWgG8oiyYvxuHpdDVbmJlvirAzlHxulJ6b1
 hlaYBBHO3t75zTUyBQndLv9ptrrnqaGYQRTR5HiCy8Py8x9+5+J7JAy/fI7C+3R0HAZl
 OkxTOMVY9D0+trLixFLDP02YJtlFUVYCheLa6pXDEca8ckKMM9qF+0/fhXz2vv0eVPdu
 es8uIIIvdSGwKaiabycHh4bRl+jcJ/rhHM1Vz77t8CnPYGbxFDqspqfWH6LnXV8e7/a+
 o5Sg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqC0wIBgz6t8labYaG4KohEF0WTxo1iTlgsQyw695PJJ4djMUAGgPEuj23YsgbWARyFgyLUmRQicU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFI5yWDsM4fDwlL4kqbd3f7I+Ag+8Ra7FPt1Y+EAOMJdOp8fRN
 TXS9cax14mhvQMRBaFWZl4YtQgSjSGwWiuo/gYpm6x60f2FV+ae6SP1o
X-Gm-Gg: AfdE7ckJONrfkYfQvUAWqTR7eEi8UqkzoWPnumi8eTv5ODFwVbSeRp+HXX6EyEujMIh
 7Yc1xtkUHmJXNvd6hY9KEn06fjkdG4ttdbc9cnwyPgx2fUAFdusCv5ZXU9wt724Ttyu4nCCINPh
 xFGrkYGNV8MXWyZ6nmwFU+1FjQKeaIhowCI+mPyP0AFAIGS4ZblF5MPoRaKnPteYZdbEVSl2skI
 V0Vr+1Hvzexuj4zPgqLzKLYvlgKjQlXJKgrJ3zjiVRgNGtNK0kugGFKRiIBXOIeKqBt0gIvDbvq
 EopDweZHWWv5DNr9cWhJ4adfH/l23M97sDzUrzTpd42MUmBH7WxVtaSXedM5CmsCdmKGP0ft/yX
 +uZ4DNLYggiPIB/hAJ6HwkvXouTNpXLscaTuHc77zH6XmggrexGGZej7dpKk2i5HqBVxSrPhE/6
 SBpsS7t2nbu8xcOPGRhh8mek9gqd9u3qcICdeE4e8W1Wcos9LhOvnLlJXcaEZIWi9LPJBNoZLCI
 aPhAj7BKxGxMUKTRDpHaqjxJA==
X-Received: by 2002:a05:6830:64c8:b0:7e9:9e6d:2e2 with SMTP id
 46e09a7af769-7eda09465c7mr9134654a34.20.1784667456701; 
 Tue, 21 Jul 2026 13:57:36 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:10 -0600
Subject: [PATCH v7 21/29] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-21-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=vCopXpS5A+0vqa65Xr7hPuZt6GKzyDjwpQ2PFX7VP+Q=;
 b=czh1EfKT5RalhVAtXzYlnQgEplQjMG6WdxIUWtEMin6k1ovGoPBlCCL0JHcEYTnSi3EjGomuo
 h7SvBRMagkHDcxuNUD21k8cPmwjlqwFtrohmn/pin09/8049fPMLTi3
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
index a619cefd801f..364a55fc9447 100644
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
@@ -694,7 +695,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -707,7 +708,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:

-- 
2.55.0

