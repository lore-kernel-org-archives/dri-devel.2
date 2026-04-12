Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CF4EBFD15
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE8F10E357;
	Mon, 13 Apr 2026 08:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cuHhw1qW";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813C910E0D9
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:21:55 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso36222515e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776014514; x=1776619314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
 b=cuHhw1qWs5DWkmLsv5bqFs8eidulfPw3QApr4OxThfOW/N1rHX0Rx5mFzpIdKQefPG
 1RHbRiFb1iJ+n3ETvW1+rJWdOM3J/4/X33zPV/NOwl59Iay/Fdquuus89BoVrDiDl+nr
 AqTLLW+zSoME78Ut4eSQqLDVdyjqX+dKnfwliq0eiFrUspap1KXhoyPJOsEcOE+WMKB7
 cSKw3Ga1AyGeZ9IMUqWjtgukCRFP0hd6aU3/6x8hqb+1t/HFvVUvt823KyXpPwgYWTIi
 qMixJJ9KLOVEWBCNwhN3V8oHe7IHEEDxdRYdV0lqu1Mp+WvYLr3s5NKxzl0LetbzNObZ
 E14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776014514; x=1776619314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
 b=d1sfAHPPahuuA4TVfH4aPelGEXhI2NVLwF4mseItT0uQ3ehQYmV1fjeU2e+aDeAvYI
 wB6PoMYbPHPrQ5GfNs+Ua3nc6CWdekopp2TfpQ+oGcu5yY6eFbzZaICczCXms+dGZtwY
 DrLwFOlB4NbRlndZhSi4Oy7NHFTthi9xcJKWT40Ik0JxgoApTWMBSX2UVE6QaQPfl8/4
 7o2LDcAactZ5LTLgqUas23Edfvpc3vMwjrzDC4SCsLMT4ro/nIj8eYfn2Ceh24gcNXwc
 KuO7hua4x2pXvys0p68FwfFZWLHpnr1Zq49RiaGt+gF78zVAkmc1nRl4MaPooanMFsu1
 znrQ==
X-Gm-Message-State: AOJu0YxXjZ4aUhEd7Jsi6ApwKJik+vUfn43emwsRo6DmtzlNGsiu+hK9
 HfCAbHuR8xnoymtSSB4QyMh97f1FWvMADD1IUh//OY4py1RO6XENBrWe
X-Gm-Gg: AeBDiesV6Fb5XTBccG6wPORN4bCoqIy0jsYkxsjbRPVj4xTvJl4O414yEC1V7aq3dQi
 ruTqHrwAlu2a6f5pBlFVBOF4S1YZIMwXhrEJ+x8J4tz6kgVa+/NPMkwpvze7QR3hxnhibybQXwD
 /o9UE4ltFKW4YBlOASEa2octQpaPUbW1um48VZpyVWFoOabZVVygnpRDFyQfmznGoNXwzZItpUW
 hoss43+V4FuXI7YzDqfanXJfaaF7ltdsVA8HhJ4/KB7g3V8b6WpaHHTSC+WUUzYtRADZYpRS4sl
 d5GuzAf+oR5y6Hrxx6AqmFS50+S257/QWEX2seGt8GA2dtpftwxNpJJoEk2i5SO4z76sSgbzISr
 ktSN7/jqvk3KFNHWx1SHzpOP3HqGKF8xfF3W3PFbaM+Mc1y+t7xZ2aEFeBg/isQtI7I/9McIajr
 as+Ku3+liwNJp3ErtDTbYc
X-Received: by 2002:a05:600c:c0c8:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-488d67bbc13mr104496465e9.4.1776014513771; 
 Sun, 12 Apr 2026 10:21:53 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:58be:2682::3d6:8f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5380feesm287047045e9.9.2026.04.12.10.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 10:21:53 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Baker <mzndmzn@gmail.com>
Subject: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
Date: Sun, 12 Apr 2026 12:21:46 -0500
Message-ID: <20260412172147.2817-1-mzndmzn@gmail.com>
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

