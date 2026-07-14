Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758B5C44513
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDE210F1E5;
	Thu, 16 Jul 2026 08:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HexUSnT/";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322C810E057
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:11:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493b1710405so24900085e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784056285; x=1784661085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bOMU8cZKzzQg02swhcvJoLmSoAF1bo7hqLkWzLq/6T8=;
 b=HexUSnT/zr+m/xDuUw1TQzSKA1tuRkNNZulsYPLRw9oicXmfppEXcb588Fw0iKDdbu
 uiUcaxFXg5HAIfqPd0EjlXoXr/zB5NReUNlDf64GD1XJw/CX5YYZhhrzdFOGmCTVdnUh
 frpcM5NrS77WJhoqWfGoxSqNhFsiseFXK2WCGkS0n4JCDLArxPn1/JJ+LaTzeUI78uto
 Pjn4Db46qk1x/ZL8R9ClaBvgTiegpnjxfXF/VGewcp2hRMd85apF44j76j/gL0+sGa/R
 hzPn0IOvE++tIKlyJ+878uI2EYI4J/2axD3j29qbHMSi+agRRXpF9NJO6KH7V+skTYwW
 n2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784056285; x=1784661085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bOMU8cZKzzQg02swhcvJoLmSoAF1bo7hqLkWzLq/6T8=;
 b=MuYES+gDzJr49xq9dqfgMo9NIhFj88KUmcWddEvGSeeWtWjfZp2zfaDij5VnpG9CSZ
 mX6fYBOFlDXmgfhNzgp9AzZY5rVdJ+j1Vn9MP8BwaAYHVyKt4hb6ijNnaNG2emgkO976
 v3DtuHaGhWN7e/0zcEO/0fyH4Xv3XaTgzf+GCX/Ebbun0LLE24ka9c7d+i90UHxMESLo
 4Ek4Nf1xL3e/umWYrUqQObMrFajWCqEKNf1iZx7NxDiA6XASpCmod2t7/H0EFf5sBQwt
 keQn+1UfHAUEbGgAfnK4dYOajJ8bV1cwxyufYiSYBDWpP+U6AvJdyUCCiS9AzJPxdU9U
 4z3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0oaM0vy7WWcbHJxPn3NXSXdAITf4nOhaOOIfK7WrUmUrHwWOjZTjXP0rulYr6OL7riuV6r2OGyEI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2Cpu0a8agnUiFtZ0ViU2N2DVUNn1NQlHcuTdojBuZCwnMDtZY
 0Y/Nh10iy2wCdhHN+tM98jbje+Buuv2IgNzmijwSuwPuC0kPxhUAtnfC
X-Gm-Gg: AfdE7ck6WjikL+Rx3YpTjTX+tAM3dZA8fzf3ZBF70ixxoAy3pfLZzd1MnpD11E7j1PS
 dIakZyk4uPyB/q+kn3F8ucckTPfXtFhSKIgynGI3AkPx2JLpmZ94Yt+76ZIrh824mN2hmDnfXbC
 DsQNmRc6obVonBfjctPOqBQ8wWTeM4wXMWmrMuJt3waAJeGyd0O6dOPeZkrFYbF/mmZISlOLBcG
 VgNxXEAN1owRCGEnDSMY/wtgLkg6LR+kTMbuOuNypIqdtSvD506EGKH5E11LIfAZZuLEjnRroPG
 5Ki2PSkN3cr3M4HlKvw46zcpMztKtgxlLm9p94nhUKlez18qhbJVzeG3CVC3/oFJnUJI/HjN8wH
 aSzVbsmkc2hJlpTtZTGXGNjaiV12uM03MED23FblBHo8hqbihnCgy7OIrIDlc+vdLliFo0dCXew
 /wAryy1FUfYTqLMiRA7IyWZ/+JFdkkRd9WmWZWy/ZEmFFmCCk5ffVPCgkegHSm3AprNesInL3u2
 1P9WVP/2QB6JxPqld4ndg==
X-Received: by 2002:a05:600c:468f:b0:493:cbdc:7cd6 with SMTP id
 5b1f17b1804b1-495158c6a71mr56346085e9.7.1784056285501; 
 Tue, 14 Jul 2026 12:11:25 -0700 (PDT)
Received: from evil-archie.tail5479a9.ts.net
 ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f951asm100677815e9.14.2026.07.14.12.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 12:11:25 -0700 (PDT)
From: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: namcao@linutronix.de, tomasz.unger@yahoo.pl,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Subject: [PATCH 2/3] staging/fbtft: Align arguments to match open parenthesis
Date: Tue, 14 Jul 2026 22:09:41 +0300
Message-ID: <20260714190958.219437-5-graviaspanagiotis1@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

Fix checkpatch warning for alignment in write_reg() call to match
the open parenthesis, improving code readability.

Signed-off-by: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c740c5..d58b1247262b 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);
-- 
2.55.0

