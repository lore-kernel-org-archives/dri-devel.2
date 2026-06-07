Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC326CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE2B10EFC2;
	Mon,  8 Jun 2026 08:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSL1A8e0";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C069D10EB71
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 20:17:23 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5aa2c25c632so3865212e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780863442; x=1781468242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cy/zUtWfVLlQnRmwYycbaxD9q0kWKYQ8XVFOlWopOt8=;
 b=GSL1A8e0+YRChNdCUhkYERI+790lzw+vGjfQNngUQjP4sDDYA36emWq3yymBLlB00M
 mhqanc7OOJ/CkWua+qU9sth23EHUwImqr0QfQcSDgKxhYFh18HXVMQyt7pAiPRwXp9JP
 kPYeJYYzsPmx2hjv1SmuldijHqDMpNS/13A93Njk31QVpSXe/iHcTEYyyLmH+B0rYFjO
 ikcx+KF+NLBUxx0bMkMT+hebTnGvZisU2p9OsnPfrk5gzbhgBdyI0UKgJ/vGQjDs0MeG
 lvJuR6AE2iWhOdRm+pQeyqE+xLZ2t52GOncSPgLjTFwTaiUBNtv0NDc+K3sJNnjR7X67
 3hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780863442; x=1781468242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cy/zUtWfVLlQnRmwYycbaxD9q0kWKYQ8XVFOlWopOt8=;
 b=s3QedQtmUFx7IFTJRkYubOOBdi+KpR6xTOnOt/VQxnQ1kjSdPVhuhh7ww7p/Wije45
 CiyX9LMvxCBPRVuCl7Gt9wgXt5q1fkHamqBuoesiprV9AzsbqkccOeLipcLHTmaFm6MD
 GvlUM3zexqXr7osDcRZmgRGgNpkY+tlBXm4X3yDcBrsP1b5wDYIOpl/KZE1MSKCieiPO
 7Zoe3Bts0d1I9JuCm4QbOIVaZimqCoKzxZv1Cto8iu9yCm493QZ8o/xMYEWq0gTPmYJv
 t07kAwIlTupdThU8e+p4baHJBLQwN6WJikm7gsfPdHXl27p7fGH30c/IwHbbp/iS7GJP
 CjqA==
X-Gm-Message-State: AOJu0YyNR+1wvVLXcMq/FZyHA5G2nXymPUl6X2vDobG5LWCeZVTxXLz7
 bIguv6LhklcdBJgHyujAtuMYQQ58CZ+3eO0Elt3jAXGkWt90Ds47a21B
X-Gm-Gg: Acq92OHWFDEzTXe076HfX1a8fS2GtqBfTucxS69zTD0bTQwxTQb2kOy7Fk2iT1pMGkL
 kGsA4JsUBAId/D1XYbyNszOEhDbY99rLN0bZDdcABpwlCBkzZq01CDb2u4YoX11846Lh0i3fLZK
 MX3Ajz0CsV6/v+xLUXUI7DmBlkT7B/ZjYF+zRhaKKe8Ey9ZSTqPYlL/9k8/Di9xPEq9mKHL3AlZ
 E0ze2GFLwhxs+kirfkPEc7ZHB+oHf0Yj9TPjDLzYnAqZFER6x2oBSqo+0lEsu3EPPLTwZMC+hJ0
 G1HtQ10eLQWc7WL96Y/i5Mf/GnbvxCF9D78yXbwGtgeI7YwYGvzQN0BLSgtEYMga4LIz9eW92w9
 SHBx476ib7/ArSqIRaMwWZJfTPmdri5v70xjpEW1DccSO+jvzhfWC0tmoVVquqzbsnXwv7jA9uZ
 CZrIxzQDFd8DzqfrDJ8WZ2SWOBZpNqhJg=
X-Received: by 2002:a05:6512:32c8:b0:5aa:7078:4a12 with SMTP id
 2adb3069b0e04-5aa87c23abbmr3618491e87.42.1780863441904; 
 Sun, 07 Jun 2026 13:17:21 -0700 (PDT)
Received: from fedora ([37.113.99.0]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b907269sm3276268e87.34.2026.06.07.13.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 13:17:21 -0700 (PDT)
From: Georgii Druzhinin <ilovelinuxgames@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Georgii Druzhinin <ilovelinuxgames@gmail.com>
Subject: [PATCH 2/2] staging: fbtft: fbtft-bus: remove prohibited space before
 close parenthesis
Date: Sun,  7 Jun 2026 23:17:08 +0300
Message-ID: <20260607201708.88644-2-ilovelinuxgames@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
References: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:58:33 +0000
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

Fix checkpatch.pl error: "space prohibited before that close
parenthesis ')'" by removing the empty argument and comma
in define_fbtft_write_reg macro calls.

Signed-off-by: Georgii Druzhinin <ilovelinuxgames@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.54.0

