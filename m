Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED82CC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D7E310ED2D;
	Wed, 19 Aug 2026 06:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LGnbpQvO";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D52810E35F
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 11:17:31 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cace91f112so53033735ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787051851; x=1787656651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vP5hOVQLKudYfbAgDB1YvOAq7rzYSIU1ErM8W86kpjo=;
 b=LGnbpQvOwt6YxvOI8MAs9vK2iYorJRgo+q6zDsJzdfERtD03qTPJ4aKNow8uvRtEXM
 IzydNEDMAg9RV0aY+bnnI+HfyXfstVQq8I/T7PDMfHv8GJuX+ZnQzyrqn4H7xfx/Gv/t
 iraAkzCdzLfMZv7Pd8asN/2QcVmLvfpCCaqx8caeWvlnIfhbYCrJSSlRCJJeT1Wd5E3x
 4cuLhcHKyiAjDvSJxGSiEFjpC+gkj6wNy7CsT4vl8BVaORZTQpnWSZxdRQgsT6Wl3BX9
 0HE4D3ymfVhPLYnjNNnIl/ZrAo1AbAPA4Ik8dX3vqWRqP6QqhMIS6qpZl/ZI8SlhhQSB
 ua2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787051851; x=1787656651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vP5hOVQLKudYfbAgDB1YvOAq7rzYSIU1ErM8W86kpjo=;
 b=WekBe3gFFduQD/SjG5PSNA0LPSP1zOTynbD55J9L4KIAol/bYmw6CMHIMieS+/XDrg
 sUGXFrvhZ/8eiXPyN3CUbVSHpogQxFxkhD0c20iOs/aCjJ8wArFqwv7FYVHsl8fpTWe5
 85mVoO2WbCqUiD1Ehrhn0tq7uULWiTtLI4xMPB0SE3l6R1nz4K8pfvItPj8BTnDC1ZEW
 xNk7KC/V/nFtbdjOqcv64h6EZEDu7jM8n7NuBFbV4qzw25/nxkpzgVp7dVBDClX1tg7j
 2puJTHqqsT3dyAYbMAktSyIxO6j5XdxG0xJDv21TTuGRV+S06mTn1/dFIDEs6IUb5sFg
 SUrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWGA2Jgz3ZWDu8Jb1MMRZX2Gh8KCmJhedwmL3sAwfb5s4B91FlDqsB/NnolBtgHkTVruQUVnKECWM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAGJgVsEQjIGLRyZxkiYkV7UlLwyWYwHrN/aiBL73Emdv+1wls
 JzN7NwIGBcxIAgfrFgl/UMjppDVYppcYZL5ABA33kcTJDFE8ij5ZSnzP
X-Gm-Gg: AR+sD12RNnFQDZTK2clLFoXRXez6D181GprXXmclvgX33CwvjqBpmQyYoWC8YqVHsMS
 J8XM+yIofZt+3OjamwhLeytj15ycV0Llvs9QyH3+6RFJIVjQWmbm7HxLHFM/cI1fq3N6ceyx7p5
 PV8KTjWENqng35Tq9JErFbu0bvnUydxcuLAbp1zvEjbpIJhwnaloX8RUgD3H28N/kfbI67D81sb
 bHhjcHfD59GfVG/bKCFYWoyOZZTOhtOR/OREP4zgTDrFS0fYIxo7ukCmA2QISodl69gGtRn/7fm
 j7thsvq/HbIe8qb7znfTYnMM8nvSlqryApakkgli9pANwZtBlHLktC96vPyUfdk79EYmybynM9Z
 eV4XOm5fisMYkZ/QWXG7q27jZWXmvBt7zCP08yJ70vjQ20ri0e6BHABvK0leuwHHJnoNOIppiBr
 TClFfN6DBq8MamK9DYzlK9P/5iquKXtbWWGa5Ai91PKD9/5gwoxc8aLDqfPGZ6xip0oCCP+Ou/R
 Sk=
X-Received: by 2002:a17:90b:4ac8:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-3933e5d22acmr30926781a91.12.1787051850858; 
 Tue, 18 Aug 2026 04:17:30 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-32678dd08d6sm26199017eec.4.2026.08.18.04.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 04:17:29 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: FlorianSchandinat@gmx.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH v4] video: fbdev: via: refactor strcpy and viafb_name
Date: Tue, 18 Aug 2026 11:17:22 +0000
Message-ID: <20260818111722.471340-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Eliminate the single-use file-scope variable `viafb_name` and pass the
"Via" string literal directly to strcpy().

Since "Via" is a literal constant, the compiler safely executes
compile-time bounds checking during fortify verification. This satisfies
the security initiative requirements while minimizing code complexity.

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v4:
  - Drop the variable entirely and use the literal string directly in
    strcpy() as suggested by Helge Deller.
v3:
  - Restore the original "Via" string value to prevent userspace ABI
    regressions, while keeping the 'static const char[]' optimization as
    suggested by Sashiko AI.
v2:
  - Keep variable static but change it to a const array
    'static const char viafb_name[] = "viafb"' as suggested by Helge Deller
    to let the compiler leverage compile-time checks.

 drivers/video/fbdev/via/viafbdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 80f95dac32c8..dd9374e8ad09 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -16,7 +16,6 @@
 #define _MASTER_FILE
 #include "global.h"
 
-static char *viafb_name = "Via";
 static u32 pseudo_pal[17];
 
 /* video mode */
@@ -144,7 +143,7 @@ static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
 	struct viafb_par *viaparinfo)
 {
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, viafb_name);
+	strcpy(fix->id, "Via");
 
 	fix->smem_start = viaparinfo->fbmem;
 	fix->smem_len = viaparinfo->fbmem_free;
-- 
2.43.0

