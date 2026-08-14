Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE00C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D09210F328;
	Fri, 14 Aug 2026 07:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QyOzBNPk";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261B710E0E2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 06:54:44 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38101f85591so1746251a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786690484; x=1787295284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1PkZxLg/YUIIPhFH7X7edGrEemSCt8bVkd1Lamr5k8U=;
 b=QyOzBNPkPpUe/Z6Xgp4knePHClXPpMBEmtjcpzQJCTGYOnv2x6CVkGcG9lVjHp/QDi
 ANY9G6ZVjgHJAXuQMveEQV+GJGb2tptjZmwlGPj7wVVFPvhlVbbDxo04gYHtUeTPlQ57
 5ljy0LyMbqlSYCsCPp4qiAHFl3NDoZUuZDonxckdvyman306zyCg+YJVxbbG9NDmx0nV
 ntxbz8SJhZzJt7uu62GlYN7TwExPSFERFS6BGDn/2smg690l+b1MUJZcbwyLVVlL1Vaz
 wincaWvHCVuXLlZ/6N8MHpEgLeQSyVybAN3swQOaMR6NjinPRaKxaPsXh2T9w3GB7Zna
 JyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786690484; x=1787295284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1PkZxLg/YUIIPhFH7X7edGrEemSCt8bVkd1Lamr5k8U=;
 b=ZVGHiFY/pAm67nvBujVXQ6yisfehOka/vdDaU2rEtzrHO3VgUsnnGhQdvfc7PCd+lU
 snf+4O67XtohlR0q0GOzI03MQgzlcCbz7i8VPdoCuR86eChdS/klUc6iPY/p/qsuqco1
 pvcQGMN5MP/FbPkMK81ZB17YdwQs3MEM+gFhbW7WvGosyjhVkg8ThDd/IQVuXtwQgqTO
 vURrLJh74evzI0Fy7EUtnqiGKU5gTWuweffQwuKig631fZFcwioj1zEDrk/2JwbN8rZh
 4b/vlyRDCVZqnucV3Jc33eC0LtoDlD5OlsIAfYOokuqBviXPQhlogzUtn567e+BgWvUW
 arFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoE4d12Lv5zrFthHfJz6CYavZYj0V+Yn+CJIY65NNIEy/RQl9XTykRQI0X5sA7CjihuVSmDqGDCq9E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5nGha/QnIELFMYzfIke3lvyUeAqSceMRw+KXXuN4evTilzJqk
 VrTNX7ZvJUZDyt48JMQNmP8J+2RdSZKQp04sI+OFC3R2qVvs4afI18uc
X-Gm-Gg: AR+sD10zo/6NXIxFmgwpvRwUufnb1R+PH/haZIdsGQCK7P40uaw5i+H3s7IJgvLcctN
 vSQLrh3lK9gGtJjxXUi1QHKkDZg7soUQytwq+illxTA0AAEomaREHy4/Gvl+pOowMOb/gju2x1M
 rxUkuZYPIy77sBcHp3PeX3D0nRLKJaa2KYN3PvAsfl9JFhOUcqg9Hrs+McAHaxk5IcsPMj8gwE7
 Ds2Bka+FbfvQDG+tjshnsweUpgomVTAUp8jQnrpIDmOLvq5YmsbVEf9K+t6d33KdaSNb9Cji7GA
 XB+tBH3rifIEN9PVC2SWEtg3wjibiPebyYC6nea63+oz7ICKSfGlwzOytQB5u3Ph9ZV7/I0O3vU
 Dzlnap50oWGt8UgXJOk1TdWDHQ0wsLd2McXPMEuRHKPLSU7MyO2QE0FnfZ80hzkQ3mGotzJ0vVB
 VpcO/R9QofqHp1g1sp1n4M7ipCUcUP2qTcEX+1PDYuiQK6ZqLlwLCLYNIcWv4c7r27TyTMwWUr6
 I0=
X-Received: by 2002:a17:90b:4c48:b0:38e:b3fd:d584 with SMTP id
 98e67ed59e1d1-3933b0d5cc6mr2450142a91.15.1786690483528; 
 Thu, 13 Aug 2026 23:54:43 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-394ea9a1301sm1372145a91.7.2026.08.13.23.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 23:54:42 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: FlorianSchandinat@gmx.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH v2] video: fbdev: via: refactor strcpy and viafb_name
Date: Fri, 14 Aug 2026 06:54:33 +0000
Message-ID: <20260814065433.269375-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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
`static const char[]` array and update its value to "viafb".
This permits the compiler to execute compile-time bounds checking and
aggressively optimize the runtime string copy operation out entirely.

This is a proactive API cleanup and there is no functional performance
or truncation risk.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v2:
  - Keep variable static but change it to a const array 
    'static const char viafb_name[] = "viafb"' as suggested by Helge Deller 
    to let the compiler leverage compile-time checks.

 drivers/video/fbdev/via/viafbdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 80f95dac32c8..b3a2e07b61a7 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -16,7 +16,7 @@
 #define _MASTER_FILE
 #include "global.h"
 
-static char *viafb_name = "Via";
+static const char viafb_name[] = "viafb";
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

