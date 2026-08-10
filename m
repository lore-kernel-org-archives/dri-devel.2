Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685DAC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B36810EAB1;
	Tue, 11 Aug 2026 07:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XE34R7nm";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFE510E1E4
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 12:19:19 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso1172179b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786364359; x=1786969159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N5+dxmrF42+92BXej+kvrBe+Oy4NpEKJDlFbxvsp1bc=;
 b=XE34R7nmgh3HNsxUESxRCR9tjii9t9sahLe33WwF3RAVkylppmbp35jHkecJ5nZBMK
 zBFyPrJVcy5RV1QT/feQcb07jnI63lfVzu/Rq6ZxPv74uwYdCB0PumJl8j2jN5UE79Zu
 iMb33ulLg8wxDixil/lL7bpWkqJwkvMos6S356fFl6eB1/JLnD9sFQUEhJ222OPDmLSy
 hiXnFcuTrsgoLVPute2xTrB35/EfGwrWLH5uAzm3srv+B5xFSvMqbFy5OT+wegKP3Qxy
 Qb6/6lFAG1fmSEbEQPGqc7TP0+fld0Yt8KRyo0ZZIvTKR9lCCnhiGbX5uZ0NHTbRAMIa
 VF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786364359; x=1786969159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N5+dxmrF42+92BXej+kvrBe+Oy4NpEKJDlFbxvsp1bc=;
 b=IVm3yNFSxtbm1TZ1m1NNOuGaROnVYJKzqo7U83Lz3aExzug+8F1c4H7bR8L1lMG5Kj
 /bZSz7/D/2s8FUz32MMn+Od0I3fAaj4GJoSHUC8MdvVCI0shtv9b4hD6j0C11kmSWRTv
 3LGrQyGzWXJ7wMXyKr6o6W/Zdo+Fn2gSc/XmjpsoZtUhyMGSNLOPM9mOAOGS3/SKs8eq
 5YHfefiCipJ80gNnDMIINrKzfKbD/F6yqnP/SQ0ps9Z82xvvykYU1zLRabqrPq3muopA
 DkKpat/OL1bbmLohrqU9pQeXFYsKQ7La9uLQPtQhblk8DDOD4Gz0W9Fv11vS5fp7L9KK
 DBFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RogBXrOmXOkAPZ0DWOpbirOY5C8oUg5MtRfCVibkbwRqn1IB9izBTYpM9D47gPvp2jKeunCEuWP340=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIpon9mMMU6OUD9lUDNiSgqnE+zzHpDUKY4x8js71R2F+Zbcc5
 WIEJ8yDcmejI7vYGJLBAzEEeKJMd5i8mJsF2++UrSl/0V0KozHJcoqMC
X-Gm-Gg: AR+sD12+yknzW4Z0tbIQtz62zINdyuWnILICByT5mabBRR+i67REcPLCqELLcBVQxSm
 e79fSaNgg8aX6xdyq1QA+Yk1VhOlsl+JNKPkiKE/CysbPieRNHPXdD13vV/7CEWl9MVbVTmlDtl
 +sUUykwqHjOWnXY44fcWTK/oB6k/98rthQFml/O8P6M4LeE9LfkEMFkzDC4yj6c07ugx7PGmwLN
 6ae1EZYHLaj608yY1oQTuamzvByizDd8PNV36yiCeIjAlYet5v+l8r/A6gZeuC28gYUM8KVw5sM
 HINWcVbIqU2gN6qbycFfxXKhqWLHugYOrgTHKPDpYYMauQQ4OqPw5wvK9bz6O/HN2eVr1H0bFZI
 sKcZGpbjzqtdVvMszDmOSg8/zrP1nMK1ULeRtcbuzq0qTYj9hF92OnDfpYID3dWWaD+n7rdyWgP
 7GVRL6tcS0BqRii5cOBiEje08BhlaE17PjpfZRPwpd/sOrh9ECcm1owPKLDchQH0uETSfFPz+fi
 i8=
X-Received: by 2002:a05:6a00:3cc5:b0:847:8dec:1427 with SMTP id
 d2e1a72fcca58-84f4fd9f647mr31055016b3a.8.1786364359090; 
 Mon, 10 Aug 2026 05:19:19 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-84f5a3a18a5sm3800788b3a.8.2026.08.10.05.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:19:18 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: FlorianSchandinat@gmx.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] video: fbdev: via: refactor deprecated strcpy
Date: Mon, 10 Aug 2026 12:19:08 +0000
Message-ID: <20260810121908.31307-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

The destination buffer `fix->id` is a fixed-size character array of
16 bytes. The source `viafb_name` is currently a static global string
literal ("Via"), which safely fits the destination and poses no active
overflow risk.

However, replacing strcpy() with strscpy() aligns this driver with
the ongoing kernel-wide security initiative to eliminate unbounded
string copies, hardening the code against future modifications.

This is a proactive API cleanup and there is no functional
performance or truncation risk since `viafb_name` safely fits inside
the 16-byte struct constraints.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 80f95dac32c8..925b56830fdd 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
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

