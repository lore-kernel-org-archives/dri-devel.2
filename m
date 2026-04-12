Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43D0EBFD10
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F6B10E354;
	Mon, 13 Apr 2026 08:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="glZjDfv/";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F0A10E2D0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:33:24 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so49294685e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776015203; x=1776620003; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
 b=glZjDfv/veZzY4wlOiefEtlPdMswfNmYp2Zi/kJCJgRWqixPxi/VoSNMk0yvGplwgG
 qPBk0DzCJ53nQh9vV4KKFzuTJl1aVRdkcsbht8PR8+lihkdGNguNAx33n9qjsTl4NvwZ
 l2nZ5Ol0UHMwjhXnSqOsITH0Nc3fEvk95y0nCK+cJWrksnhNZjDy0Ky89b1BRvsR/MTn
 snSWTxHVr8Fo+eL2j5lnOynjHTgFCLlHUoEz/0nirVOha1Qo8OQE3oTSraTNVs1mBrXm
 qvZCMvieHXNR/nvCFpi0ILgZQLMUL4c/Ad7e+BgBLZf81ews9Bkud8cfucwNB4s7yaZH
 V/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776015203; x=1776620003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
 b=Oe39QIXeLU/d68QNxUNSelbrHiLtHz/T/Rs0ZlrLZstddYKBplqMY8+xEikwYmkgVu
 vWUJubT3cZm77uaYirPxXRnR3FbJMqKKK1Hm+7Dn+Flo6OJVm9Ji91IAd6PB7VeUBT/L
 jwWbXpzFYGmPph6CjPRaOy/bZpQN4YraWQ6s2X79JMGMMU3K8qDZ484gkJONQQg3HuvD
 7O1fH+8/cDLPO6HDQwcbHvWC8YgKaCKMMuYkmRNU+Y+LNCaF/jHAPKxcmxxR0Xjw0elV
 bWcDJwLB03Uv7idmReci5b9q5+Gm37OoAQo759PhHmaleBy7LBpObsEa8Lu1dbXESZem
 7fsg==
X-Gm-Message-State: AOJu0Yzi5RsR1he27sDmQxQMD7b7tp8VPcmTAh/y78anhQGzQ44hf7AJ
 yIE63tkRwvM911Z93cHHTCWDUOnbjuUgAWR6TQIl/OYjzyS8kn0b8obo
X-Gm-Gg: AeBDies8hQ3CtJb7eaRPkFRX3pcfJuySypaYlGStmnwmVJVjMrEqY1pVwJgAw/b+db4
 cA1MWffE/hHAew2hnGc/UCn1SRWCKM4DdyluUhVwO9Vken7+hrbpcxRpZt8WXmvTXB16FIv5hM5
 2tJthbp7xVGe6Qo4fNJfGLsTpBWGtbSnGAL/888FDODDjBtZvCSov+nLH5jZ0yaQICrONsMkKbJ
 t+OB5dzUWjaK5OkJ3+IvyWvwsRJNRDZYZ3b+SUjnSq7gtEMnRjS6qW8tK6wDK5qi/oA8BHC+XY4
 m4BnZArU0CaAtyo5h3S0J3Xa1dfp87P/dXj2Rgq5q1xG0zBoTrHV9XUJByC9quBABr+cd132oMh
 wl33aF5vOjeHRE+SzJ0Xdz4shH5g8zbCsuGwVI0rBZ6qtTvr9Jj4I+svbUT8+UsX6Zho6pnhX83
 +MwKsO8CmRoZDsHMdFIvuB
X-Received: by 2002:a05:600c:a010:b0:487:300:d9ca with SMTP id
 5b1f17b1804b1-488d68af201mr154253175e9.31.1776015202671; 
 Sun, 12 Apr 2026 10:33:22 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6c0:2682::3d6:8f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d76eeb2d1sm5499983f8f.22.2026.04.12.10.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 10:33:22 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Baker <mzndmzn@gmail.com>
Subject: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
Date: Sun, 12 Apr 2026 12:33:16 -0500
Message-ID: <20260412173317.3329-1-mzndmzn@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:01:34 +0000
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

Remove trailing space and comma before closing parenthesis ')' in
define_fbtft_write_reg macro as reported by checkpatch.pl.

Signed-off-by: Baker <mzndmzn@gmail.com>
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
2.47.3

