Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72074C624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227DE10E67F;
	Mon, 31 Aug 2026 07:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FvFfzHqF";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5574710E1F9
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 16:15:56 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cc891373e0so22557295ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788106556; x=1788711356; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ftpZeIMiNCY2OcgsJYMYoL7K7phvSKcRMGjOcwR8P9Y=;
 b=FvFfzHqFt6Oj/P8j53CZGd2YTLFT7hyugYWLhLfKKkvK/zII1wKrfjg6/eDMS3ZZmR
 pH1TkP3qceA6+LR+jn6L/QWru2ppsxaRPEhKWfLaOiZXC0LtzXJejWresgxowvrf4fVy
 tqb51qrNcGpsNbBCKYJbnNNWf19fgIPhzkLotk6+lJK8lNdYGPbPir+A5Pmr+TOa981U
 aYwmhT5bT/7R+G4ofcPnVYKC80G9HXrV4esrIeL/VO6OU2xob2Xxrb8pgGxmh5gb0sht
 zB3kVw/Dt6FgJqgVQib+pGXscnw8f5Tr29jRs0i5eViZNo/M0j4RBPVfenuGG2jasLlr
 7JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788106556; x=1788711356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ftpZeIMiNCY2OcgsJYMYoL7K7phvSKcRMGjOcwR8P9Y=;
 b=AtSqkXjaASqfY572q/PHNjFWkImMK45A54M418DhCUTx7GGx5UfpMCpz3P1cJH1qjd
 NulYNR1xZnfHVONEGGy0sH3rXLIzp6VihuD/HInib0VnsXw0Za/JK1xO5J0E9ZR7xTia
 rEH+F8VOqSoh5blB8NXGs00k42l5BuMkoCcXsW/xupbVKoRwP1HswMl4HW0UO2XMAxnG
 ugpEwyxxLgrWk2smvuOZ+TpKg+WaY1Qod180r5PyyMW5MnlPu8uB56SxTF9B/GtISgov
 o6NP2tWD3qxxprnLc1lUIXv2zc0vQNEi+v6HpoD1umLLISFiSnWHojNysF8BtCtZiq0l
 oWKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdTbiwIMDxiOWrj4COGMtgP7Y87d/6inuviDU3CEMbmBL4vdH0CT+iEQuYWrF9xJyKNYDJs3UaipY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++meox8EHyNulX8yJ24jzqRwGhAkNurrv2LDfHgKj9fN2CPxSpK7
 p+ZLvfbtI6H5ruUE6Y5swSAxd9+1fdU8b6QvogMtkJw7jy4v6PRRdPo9
X-Gm-Gg: AYBFou32/RdZmyTzSyj8kA18m34oObUybIcj9QsrzkiRXJ/xi279vZHoSdjsy41AwS+
 FcRqKDLGC7GKIRnwbNAobyOAIKAoK8zT6F41zxLIjh16oCCHC73aQKX44KZWQWqR7gHsC494sMv
 TrJ3axrzbSQ7k1I+t4hYhDMxTJHJ7EO1C4nzuWh60G1gQtLTp54r6xOTF/X9FSa0J2tRqXFRGTD
 45TK7rixg5icrsUXm3/9KqFHZ9F/peYS21CieaST2/+MDUMo1JrpMlcU3raar8VhVASpNMAvoaD
 AAp7TfZhZQuDWsu6J3pgQUTgfZpBUUg5Muo1cmBULVMFQ6U8Pz7J74Nb5sru6qeYY+5f2l8079A
 v32JN8AeykoOa3RbAqHWvIyhQAR4nbzkDGLcip4P+8OnTiDv98AInUlV6U+BgmXAgAkK7utLb65
 XOj9IVjMETJQdAQHn4D5/eXsDy/Bo58jmXO1wLjp5d7VbpmH+4iT6pSnX9QaGukvXCLExmZYw3f
 g3Yrq6xgzg7EWjRKvY=
X-Received: by 2002:a17:903:2c9:b0:2d9:6db:9fcb with SMTP id
 d9443c01a7336-2d906dba09cmr88661175ad.11.1788106555702; 
 Sun, 30 Aug 2026 09:15:55 -0700 (PDT)
Received: from Kalpna.localdomain ([106.194.26.159])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7598c3da2sm24396095ad.82.2026.08.30.09.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:15:55 -0700 (PDT)
From: anshika <anshikajain196872@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <error27@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 anshika <anshikajain196872@gmail.com>
Subject: [PATCH] staging: fbtft: name the no-op endian modifier in
 define_fbtft_write_reg()
Date: Sun, 30 Aug 2026 21:45:29 +0530
Message-Id: <20260830161529.14500-1-anshikajain196872@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

Two of the three define_fbtft_write_reg() instantiations pass an empty
modifier argument, which checkpatch flags as a fragile empty macro
argument. Give the no-op case an explicit name instead of leaving it
blank.

No functional change.

Link: https://lkml.iu.edu/hypermail/linux/kernel/2602.0/01917.html

Signed-off-by: anshika <anshikajain196872@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..e03aa251c 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -10,6 +10,7 @@
  *   void (*write_reg)(struct fbtft_par *par, int len, ...);
  *
  *****************************************************************************/
+#define cpu_to_cpu_endian(x) (x)
 
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
@@ -62,9 +63,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, cpu_to_cpu_endian)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, cpu_to_cpu_endian)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.34.1

