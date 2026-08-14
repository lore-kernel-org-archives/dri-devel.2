Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F27C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D64A10E2DA;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UdfOXQfg";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A9710F343
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:44:44 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-381b831d535so1044256a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786693484; x=1787298284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cwYk4ejoNMOniCBgkjcxx38Ml00PjaYwyPcbfZWz9ws=;
 b=UdfOXQfgURF0wYkowh/dUKAw2d4GuEf/aZVJ7wX8BhOklCqTog6nGbPwtjWoGp11M7
 0KNu4uzd5zFzQCyaVPrjwTqJLCXcnCIrcPmN6RNgkD+KvUQji6uOm4SUEcfXwgV9eQzT
 FGxKAfHbun3rmP3MxYZ+H/J9IDfkuWdL8SRguvjqf8gwHviyyq0JFGLqz0UatdBmldq+
 UCXwupc+mqeonae3HQm7rPX76bTA47fkRNTjG0ssrJeDkQ1IOts8I6UQh/TcJffNqbgt
 9pvHiwZ4ESVneKUhkYDdwaGDvAI/QYPKTaN5O33V3fzlC4Cv+FxcMpSZtT0kSJXva2+L
 eViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786693484; x=1787298284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cwYk4ejoNMOniCBgkjcxx38Ml00PjaYwyPcbfZWz9ws=;
 b=PUgVVX+yc94h04G9g0R+kIJJLfGgPCAjnUhBG2CDJde+FhLwlAPrG2HhObfQzXKWDk
 aX+PHurB79xoOj6AeQTHglOVWMovbQj9XA9laf54QUd4EkMVFX8HhwHM2G+JuJ+MYyfh
 34qQNSxsYsSIH3aF5/cVoqBm0rRvWNVBR2mohtCrq+Zk/kdBUEVmgaugt/PGII4pjTuR
 v3zDzvjw2ub7vGEg4QoKtmdAviHu5g4JdzIwdIKkGZp7sRFZh5mkz5L1GvC7kEyg29Hd
 1n4Ent8NJsL8aCR+WPBSzPmzF5OWqRZbeHV/WCXawJBwATd6omi7SSKQZtrGKZUz2D44
 ub4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4yarBZZBJi8lyoL3rJKNPa5jBzuNcWAy+jd6cwus0tfQVGwpcqjSXjl7e1Uex1ja/Jao9niW/FOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzobVA6WuVecSr7CCDL/UpF7IzLJzWqfnHpcJ1Z3ynym74U50U2
 jOPSUguqn3ORwuLjP/qnbXKBluWPAf5dmBxAIZ3WVemhWRDArfpdXjvg
X-Gm-Gg: AR+sD13oLMnd7ficaIrg11R7lt7JjZ7xlrLD+2TWXHhv02a3FN4tsbQ+wUwjjx3udsX
 TsLQQnUBvsXDr7kAkX50zBOumzur6vR15TJJNEA3Dsij2tjPonNpRRhs1q7ltEsEk0jSVdiLlCl
 6jEc99+vMstlhMapI7MQMqLMFiPAFqzRIz5biJf7PWULKJ0fQ/cQC664sMWPHlKCYiDseYfTGoj
 dP7Stgrln+Yy0UmClXR+udQ1XWN2a7ZNpc0VH6GUcBjW+wGgUid7fCW8xdbOkAkLC4w4S1Ho6f/
 XFlsyfeIj9vpr0c3m2yRmY5RKhD1zJzwnfLvr1UnnaxxsB76iEz8kv8CaaEdq3oDXqFLiHHYrqJ
 Ytvkl1JM2CfxA0VJtM31oBOL3TmWvrX8+DdmwufgQJv9r+1JVYSAFiWjE0Eau7jkiUTgAcQE+oT
 6GNPuis4ZHo8dmCZ10YMQ7dvYgsaStlezXQhN58rNFjW3YsFMHUw8uuLGGezWuZr5EDELAdZwaz
 6c=
X-Received: by 2002:a17:90a:ec83:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-3933b8c1041mr4446396a91.16.1786693483969; 
 Fri, 14 Aug 2026 00:44:43 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-394ebbcc34csm1462260a91.15.2026.08.14.00.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:44:43 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: FlorianSchandinat@gmx.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH v3] video: fbdev: via: refactor strcpy and viafb_name
Date: Fri, 14 Aug 2026 07:44:35 +0000
Message-ID: <20260814074435.277441-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Replace the deprecated and unbounded strcpy() function with the safer
strscpy() alternative when setting up the framebuffer fixed screen
information [1][2].

It aligns this driver with the ongoing kernel-wide security initiative
to eliminate unbounded string copies, hardening the code against future
modifications.

Additionally, convert the file-scope `viafb_name` pointer into a
`static const char[]` array while preserving its original value "Via".
This allows the compiler to execute compile-time bounds checking and
optimize the string copy operation without breaking userspace ABI
backward compatibility.

This is a proactive API cleanup and there is no functional
performance or truncation risk.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v3:
  - Restore the original "Via" string value to prevent userspace ABI 
    regressions, while keeping the 'static const char[]' optimization as
    suggested by Sashiko AI.
v2:
  - Keep variable static but change it to a const array
    'static const char viafb_name[] = "viafb"' as suggested by Helge Deller
    to let the compiler leverage compile-time checks.

 drivers/video/fbdev/via/viafbdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 80f95dac32c8..f6823beb4d7e 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -16,7 +16,7 @@
 #define _MASTER_FILE
 #include "global.h"
 
-static char *viafb_name = "Via";
+static const char viafb_name[] = "Via";
 static u32 pseudo_pal[17];
 
 /* video mode */
@@ -144,7 +144,7 @@ static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
 	struct viafb_par *viaparinfo)
 {
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, viafb_name);
+	strscpy(fix->id, viafb_name, sizeof(fix->id));
 
 	fix->smem_start = viaparinfo->fbmem;
 	fix->smem_len = viaparinfo->fbmem_free;
-- 
2.43.0

