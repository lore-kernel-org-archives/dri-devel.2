Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5C2C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D832210EF8D;
	Wed,  8 Jul 2026 02:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5E1tOAy";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D50910EF94
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:56 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-4a071495be0so150376b6e.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477135; x=1784081935; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pHdFR6BhJ4eiUKTqpuGaMPESoaVdVadkoTnW9J/lC14=;
 b=c5E1tOAyOhWhzsOui4Yn6mFhCSVCmR46pV7MEmyCeO1WVJSDbc8bT21KUfO9zvr1Of
 wg1FZx1FgnM0RaL+8OcozvpmU+I9PVJIVRs5bOTdZ6jnoYdhNnEyDw9CVFsSb6QgZIYn
 uKw/lFx7CLoARXNmy9Prh50QXxpEiCOt/797V4KV1WjF+rGuQDhR+JEVb7WU6QB5fOq2
 X3Uzp7Ofblw0UhbgcA9vKM1IKO7ql0mCPytxZu0eLXHVHzvWILY5MgL7i1jAH8Zgtq/u
 SRQyrXEKm8qEwMNge015rouEvhtF2IgCpNtqZK68BV3X1bxyEk+ag5ib/dUjZXCFhApx
 p8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477135; x=1784081935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pHdFR6BhJ4eiUKTqpuGaMPESoaVdVadkoTnW9J/lC14=;
 b=k8VzNFb1MO1f0qKLdyznX/4c+Us7ucz9fDoQ+T8D6XDqQhBs/KoZ85EekqnfFHO75/
 wFdMhej4BFP+iymWdc6qCo08MWz+HjzZqMkGrEHw9X0c8Dxb8ql0kEFB4ssOf6GlPXES
 w7Sng2iVBmipCEdnEUOH8Jzfnsbwg2sy+ac1yD3om4mo7btqbJ0g6aFohR1tNZJMZae+
 whdTPcnI+yd8950/CQKaw3YYZXi1PLftByu8sVJSiFuXEMF4sJvkAo+c4JPMrTLkkAYg
 11eUz/VGa+LJBbxEF2s6B05TlNiD+910voHyAtrU8Z6BzGLMyODyqEoRRVGCRd+7SsRh
 IILQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WTw0GwNuqZAoHk5/l5VNVVTAk2WOoEVuwn06rbFswQpYb4+KdufAmjnnkxts3tDN3wEFTOqiKGJM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEqq73MtUvhKYraMInM0XQwY1B46YS+kDObh2zBNkHiFkuUXas
 6C4Rndv1P34NzRFuT0mNmW0IOZ/qDDhZ8Dl+1blJ18/LYBCePK7YayOV
X-Gm-Gg: AfdE7cmbEwv05VFa6pzT6qTEFyn4JHnCk2GkabQYAh0ael16uqiNJN1/ZZIO6Eupa5y
 RmnZ2W+zeWHs3o2kmFhiBNiVdG3lU6WrSyJfm0HjzphBlQATTgT8WdcJU/A5B/a7bzFneMOXP8V
 ejJLUpz/FMr9UP+0rdPwgB153sgNdiJFOWNKNThsnKaakKA3MXjxjConceMLEuRLCtfkPCAnA1b
 3fxEPwzYGsdhKSlVfldfbbSGaUJ9Qg1ntrxFlL8G0nZnmibrXNX22SxZn/n/B2L2zTUJT5I1IG9
 4nCbpebpJS85YGEpbNvf3APQn2Kf+gL2VR65xHB2lkk1bc6UYcKRaKpABKLSeL318maVxJW72oG
 Dtz8JvIpv8svKm/92V63+tu+EsvHqQYUor3DKh+RbkGgf28IXzHAenBujjW6LwGPN4EJ0cGQNkP
 MekV2Gu/r3DgEc95mXok3w6qWwPfMnLdLlCesozsDgUrcEOWX6IEJ4jpTat6aQ/w==
X-Received: by 2002:a05:6808:320e:b0:495:eb9f:53c4 with SMTP id
 5614622812f47-4a2023143a5mr371501b6e.9.1783477135614; 
 Tue, 07 Jul 2026 19:18:55 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:54 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:16 -0600
Subject: [PATCH v6 16/24] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-16-381f3edb0045@gmail.com>
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
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=PPomXDqOPZZDfNdm43tbxaOgsUnHx8T5uRdXvuxBFp4=;
 b=CIr8KuxqpMOHsAfVjd2PFFNWeCo8/hjQ5nOwJ+0lMU9uKP5hmdjYMw/MtKkedGI69KPkPmNQK
 JOhoXQzKoBnDMud5UhPktl0b/rz+onEomJ7YEpnrospkJKIN+8/VBcL
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
2.55.0

