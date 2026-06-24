Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8384CDE002
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCFB10EDDE;
	Wed, 24 Jun 2026 07:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQU9z8Qs";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3937B10EDA9
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 07:38:38 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4926046fbc5so5543275e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 00:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782286716; x=1782891516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vk2iYqcO7LMBB/0161whJq3oPaKM69uvROOVp1OGQZM=;
 b=RQU9z8Qs0D8FiL9Qgsip/oFOFNzmn7QuF+AZwystcokNd6b3nKlavvRz4JI62eZi1k
 UBQDoa2FVhFh9CXBRorOISYGl4AsEZhGznMfTW2pOMbrOv99EUcJY4DKTTXEiv+SOIBQ
 jLuU8N89vEDY7HLeKnxaTvjjNP6Hx6vHY7LfS1SoK+c/wKDkhxcGrEqy7MRDLRsw4hoz
 aEveBXhen9kMOcYLcX/ME4+bGcI8wOlmYTllxAMa6oeRg4ELSuvIMLNgL4fTOQpSPUhI
 GywyEkZbf8n3viHHXXSGaCapgiOdNewgSaRJ5usWUfPpMh+tSxkzIosLQS+xEQHxA3QR
 9uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782286716; x=1782891516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vk2iYqcO7LMBB/0161whJq3oPaKM69uvROOVp1OGQZM=;
 b=LvhUKX80KHua5c5SYNSCdwOuHSCioe0i+c6hG8EQHd3phEcHei4qPKvFyxCYrOuAeY
 1u3Xd3V1RUNngQ8iUs+JizaE47RmCN5bTAV2s4bu7+x73FQh212watQHQttgMGOsO1BR
 glRNnv+G3FcO81Nl8tbDjAwWRQJd6goCPXQUAhyd3KRNW6vZgWt/T2BNtYA+gslNokMG
 Aj8BeueGyCLT1gGYXx2nkgKRAsvDLEV1RzWdeXppKtLhBt+PMNdKl6/OgmA1Jr3BdOUB
 sOmpWK5v9KNyZ5mQ6vBDzn1oL56J7RJyi+ADxLFlZenkbu7m9+BwyBteTi/iq1LIzrI6
 7cRA==
X-Gm-Message-State: AOJu0YzZ10uamLxfeLpiIEsoN/NDstSh4xgqp2dxFYu8njCaPemdo/4F
 bsy7F3o7b6x0u43pgKC8sO1c8lkn5B6jt+2tHC1cUHDYl9DO5pdwStknWeESFwwG
X-Gm-Gg: AfdE7ckoohw8cO5DuhZ5jWG5Vm7NxEpFI+AqPzFCGLu6JKHbl2w58Mv96GKBkmxAm16
 9/jMAv3i5na2bvTwGpcicEJvbaTAzGgSN+SCaRIrAED7SYR4OaI+x3FrmaVcDOKm4PpN3ECck9W
 xuRRFViHAunTOj0MF1Z7af6y+KOFBM9ilDhOkzt52+rP9Sd9jTf44cW5krfVgOQdOTkrPc+VQX5
 A5sV6QeKimB1SH2GQT0qz9qiU/4gjWbxLTJA98oUq7Sa7HoIYYyr6P4mPd+wtG1mcOON0mbauEG
 rC3HCgoe2Okqitcw032XnOKWLgJLH3xQHHBP/OhQ4J8U3yEsYrf7eK8QyOF9c2r2cHUXGXhrK+l
 kPamk3nfiXLemIJT00Uuk6g1+VA9iS+aP7KNB1oznHUI/XJRQbQgTz/2kCZ1PS3Mp45X0+RBeVu
 HplK9H7AkGIKbllYeLD+8xyUfCQw==
X-Received: by 2002:a05:600c:348e:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-4925a0c564dmr93840065e9.16.1782286716400; 
 Wed, 24 Jun 2026 00:38:36 -0700 (PDT)
Received: from localhost.localdomain ([115.187.36.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49260915286sm78796755e9.1.2026.06.24.00.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 00:38:36 -0700 (PDT)
From: Joyeta Modak <joyetamdk@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joyeta Modak <joyetamdk@gmail.com>
Subject: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
Date: Wed, 24 Jun 2026 13:08:04 +0530
Message-ID: <20260624073804.4391-1-joyetamdk@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

NUMARGS() computes the number of arguments by dividing the size of a
temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
macro is the correct way to count array elements in the kernel, and
ARRAY_SIZE() also provides a __must_be_array() compile time check. There
are no functional changes.

Found using make coccicheck (scripts/coccinelle/misc/array_size.cocci).

Signed-off-by: Joyeta Modak <joyetamdk@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index c7afb0fd3..48da1503f 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -4,6 +4,7 @@
 #ifndef __LINUX_FBTFT_H
 #define __LINUX_FBTFT_H
 
+#include <linux/array_size.h>
 #include <linux/fb.h>
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
@@ -233,7 +234,7 @@ struct fbtft_par {
 	bool polarity;
 };
 
-#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
+#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
 
 #define write_reg(par, ...)                                            \
 	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
-- 
2.53.0

