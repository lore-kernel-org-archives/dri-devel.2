Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C44C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1D210E67C;
	Mon, 10 Aug 2026 06:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PoEEBZ4J";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCC510E05B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:33:27 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso2390337a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 22:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786253607; x=1786858407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Iiw60go6Fssc+w6jEvdK+NtF+fsX/PqKIb7cNVI3nSc=;
 b=PoEEBZ4JgQAVDr0YXWRQxsjQbXboeGiSm1aYDR3OBo6yNXkORSxWGUO4oChD4yo6It
 z1IDjdvFNH82rgOl4HLqTudLhJmeR0OEzTzBcdk4BPdcHUpybkIJHX8LwVieQCr6tH3K
 +zmdIK7Ub1PVNogWx7h+tvRL0n2RinDK+V9VX/A6CpZQ3CZmWeZjk6fkpC8XIwYfwFm5
 ka7AFP8Uhabib7PQLA7o4QRb+FXq3d2mBqPdwbGLQYLUZYSWL9yYP3fz5b8kDB1TV8Q9
 mqO3gAV+waoD8NVx9g7IAVo2wam6ZxEUSLOju6KAkRbRDBosUHlocgfmY3ROIyjWvewF
 2R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786253607; x=1786858407;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Iiw60go6Fssc+w6jEvdK+NtF+fsX/PqKIb7cNVI3nSc=;
 b=FH34olos8dRCUZpkhPXCii9bLnwqR2wuTs3T+Tv44BGQ17nc+buyxoS1NArnqNG8EQ
 C3RGQAoQ/YlgxQ2dNvuSUGhSslaEIiKZP/iObjHrLkyzEJTYF9VcN/D7QwfIQDVYqT0P
 QMid8cpNT4ur/6RoBZEBTFdQHPLwYPkcWST9DfKP7NeQ94CIOiEF3+Zzt9bpDKVkoo5e
 UAAGRRWGdxcTSJ1djtIcUezzUHN6SFhfJYM7uljcsPLzEHkDENyST0u7ox6SKghPdHIt
 10rRZmsot8Zs5HNAO0J22U7eMm0sYRbYs5xsq/eoFJU4bYJkNWa4YPVZbgUnVORoOuBE
 BQpA==
X-Gm-Message-State: AOJu0YzSr4eAfJVqNjro2ZYGaXHLGd91yqXemsG7SlpGjdgDRmZa+8Zc
 7D3ENKBvpc5QMyBSy29lvXGIglT9xOkH2Ww1I7Y677d3jLIAIe7X2vW4
X-Gm-Gg: AR+sD133Qidjy4XbbFuN+CqBkljNEvIT9+aD8/u5ZufWD6FZRaqm6N0OdYD6Bks9mpp
 nFNFbTne+1YPwZI8W+7HyJNwKHZI5k+tuN3XZ5CVOST94VSCj68sXl1r/c/nOUXFlQkrSCAXC52
 6FHyBL7vCclKwnmXQBb0x3llIRlAxOPffuEDRPElOCWcK/1Ib4CuuJvmlc7xLzmyXEnBqhCnxKk
 eJW0i3VVQyvj/ObLuvh0ymVMHk2wtFRoA6FiYrjKZMVc94FTgLMUwPhVN+fwgKzaywlrcOCcT+7
 K2kHCxIcRXnMRDkUaKJCzvWP1ylUdfpME0B8l7bUcIX97ch2fQxsiEd8u96CXk15kDxP70xXRo+
 CTc20RdWuUs2L675t5EQ+xZXyf+czWAZO04ZHE/bC89cX6/IDG4S598sByRpm2iKgUFFPOK+9NY
 tauQjPxVuGhOtlBTNM9/J1SoJHZAoUEXlAzHVJvgkLadJa+S4Eckx0qHMEyR6T
X-Received: by 2002:a05:6a20:7fa6:b0:3bf:ee42:192 with SMTP id
 adf61e73a8af0-3cbd37eeb4emr10610214637.6.1786253606859; 
 Sat, 08 Aug 2026 22:33:26 -0700 (PDT)
Received: from preetish-pc.. ([36.255.86.159])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb88413sm44390386eec.18.2026.08.08.22.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:33:26 -0700 (PDT)
From: Preetish Amballi <amballip@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Preetish Amballi <amballip@gmail.com>
Subject: [PATCH] staging: fbtft: Fix wrong controller name in fb_bd663474
Date: Sun,  9 Aug 2026 11:02:53 +0530
Message-ID: <20260809053253.14537-1-amballip@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

The file fb_bd663474.c is a driver for the BD663474 LCD controller,
but the comment header and MODULE_DESCRIPTION incorrectly reference
'uPD161704' — a copy-paste error from fb_upd161704.c.

Fix the comment and MODULE_DESCRIPTION to say 'BD663474' instead of
'uPD161704'.

Signed-off-by: Preetish Amballi <amballip@gmail.com>
---
 drivers/staging/fbtft/fb_bd663474.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_bd663474.c b/drivers/staging/fbtft/fb_bd663474.c
index 1629c2c440a9..c34f859043ef 100644
--- a/drivers/staging/fbtft/fb_bd663474.c
+++ b/drivers/staging/fbtft/fb_bd663474.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * FB driver for the uPD161704 LCD Controller
+ * FB driver for the BD663474 LCD Controller
  *
  * Copyright (C) 2014 Seong-Woo Kim
  *
@@ -166,6 +166,6 @@ MODULE_ALIAS("platform:" DRVNAME);
 MODULE_ALIAS("spi:bd663474");
 MODULE_ALIAS("platform:bd663474");
 
-MODULE_DESCRIPTION("FB driver for the uPD161704 LCD Controller");
+MODULE_DESCRIPTION("FB driver for the BD663474 LCD Controller");
 MODULE_AUTHOR("Seong-Woo Kim");
 MODULE_LICENSE("GPL");
-- 
2.43.0

