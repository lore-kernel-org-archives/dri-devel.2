Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADD0105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54FA410EBFD;
	Fri, 13 Mar 2026 13:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kQrwk93L";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB9E10EBF8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:22 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4671cbce2feso975284b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408202; x=1774013002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr3BXrtiuAvHSgc8/DPsjTxu/hA/+WXgrNkg64S657g=;
 b=kQrwk93LE62KbrsLbEFRGVmaI/Bz0SEXQ5grieklpiQ8itw5IjbMcy5en4rL+P9sBG
 y7TmRkUcDqibsoZA2nVML/3PoCWRqTh444NC12Jwjvv0DgWPW3Ue7oXGtATFBT2CRfsq
 rAeQ71t5gj/1QD1wHZMvq3po766gTHyB5TWEtxbkgYldpVR2+jqwRbxk8cR1HYXHQn5f
 jIpH+U4R93vsQuh6HpvaAJkXKrWz/mdfglNVxGI1MNv7jm6a7VslNuepuZtV1+Mel1pz
 cVvdMNVVZaolDzOwf4yQX1DGQo8O9JeauCT+lKXFSX+bASKK/XFLbd7jFTja8WB18gWn
 cRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408202; x=1774013002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lr3BXrtiuAvHSgc8/DPsjTxu/hA/+WXgrNkg64S657g=;
 b=PLAfX3mxtaG4m4Qwc28V1iQ08maYsLEEDU7KS+hc+v0cv8EG5lhDvOgC7cAvw9qeQs
 qi+LAyMpss5fAcEuMX8FuKnqLzed/6o06B8mi+5eLzl63pn4NdgznooIfbzqQElF56mg
 0EbsleWpckl0t9tB4P0COwi968Ijro3QJRckdKPpKZD1yJQ4oqle+nbWYXlzpDc70/SP
 NfAR4Ro81i/G0hULAgPsClSk0NyYMGVDZhdYLFRDe688v6O3oc5H1b02JDNHdfmDc2wg
 hzv7OB77Yn6zCB/LVvvFsazxOf2ckEnkShhrkdTxpmn6YYVov/DYcADpnXYRPZO0e4xj
 onCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTwB+TAGRC/VJv1cr717q0+J7PHKUvuel0HU9Ze5ZzNRJUHMIg1Kr5uBv/O6grSFirvX9VHldg7GY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyjRMpz823xk1c8gEyjGGMi9oPiEwa/68YNwaU1ixaFduwcAT2
 W8054tGt9Q0a9rzT4332x+l/DNJS4ElfffkqAzWkM8sU8EqwiPiEMuYG
X-Gm-Gg: ATEYQzxnEu4UY3vr4l2f6b9dnf4pOT2OSXpiz7hwjZRRQ+ZutzD+NJdh5czq8HzAolr
 czhEjGJSVE+SuQnD/87+ZCp+ODxj9uLSzB0oXZ3yHlXJV/vholfrKeiSrdC1El4JzQh9rZtM6QC
 L/Bj3LgxxqMpd2gS2UvwQw8eBw/7ROO0eKRVgxZ5G1RbRgFNy8BwUHffbHUZGr9qLE7djiDCv+X
 +tTsSq4Sue18G3+kL8suGqUYKDcz/2EdR/op2xdldnHAHagttW3VUWvfH2nLZeSaxG32KxyxL52
 E0N+sJdIqGzguJT6zvufO5zALvtrFDCgHtp2+PsY9uSvLEtlhSev+PX7R7CM+Xg23t+wdTX0k7L
 zQebmWQ0bK9ge1DDU6XkZM09OaYalImC8ixTFsIt+V1lTXNV5jPCIjbWz5S+e0X/fDlwlCuWrY6
 Zbg+zKsdVSOL58rCgcyWCBBWfl90U+8/3DTHj/NnMHQvJWoWMBNZcv7XxgBbo=
X-Received: by 2002:a05:6808:1a21:b0:467:13b5:8ae6 with SMTP id
 5614622812f47-4675704ae1cmr1541416b6e.4.1773408202078; 
 Fri, 13 Mar 2026 06:23:22 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 13/65] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Fri, 13 Mar 2026 07:19:38 -0600
Message-ID: <20260313132103.2529746-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

