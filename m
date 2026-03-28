Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE2AF3D5FE
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 09:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65ACF10E45D;
	Sun, 29 Mar 2026 09:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQS9Dpn3";
	dkim-atps=neutral
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA2210E2EB
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 16:02:15 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id
 41be03b00d2f7-c73ba417c6eso1191980a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774713734; x=1775318534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zO3fzyE74uT1xNOETXZiW8HFjDihl3ZHhtgFTBMYTAU=;
 b=QQS9Dpn3ZaitcWrfFJYl84x5CDKEcBsiq79dwQZC6M0vGEiAFOKMdmlTs1yONA+UBT
 9yCp4LgSPKW46eaI48gIS0vKeT9vjY0LtrthtHwu4wm2yTeJpjm7NwgWZibL/TnaN8/A
 AW6VDDCDx5EHJ6MU1BIvyjCTKq+do1QJmjIJ+ZsUfdkUkSd7p4vUOcXUkYSC2FEQTFIx
 qCIb4LV+z7YC9sjmY1gcutF8i6VgMuMv29bgF+XdQhGtil75O79lxCTrvtI8CWooY1/s
 DHWTJgwqz8B3juRpHsp/+1JGQ3rdP6KVQnPExLpONofYGw+qHzgJCWHcb2bIpmIzNzJk
 WRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774713734; x=1775318534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zO3fzyE74uT1xNOETXZiW8HFjDihl3ZHhtgFTBMYTAU=;
 b=WRdx+wXFtIM8m47ycf4mstn1jH3IO3wWo0RhvOmP3KppOhS/U8VpnKrYVXgon+OuUw
 2f/1WE0+Qr2CZq0DAV5kn4rQLqa19xzI+QBuqoaZQmBaFbT6kVVkYYXVN1/X2Gb6gGgB
 afkhrlSKKB1bcbS/pFSva+NjBXub03t1RFF7A/bhkoEdiwOka/BdugHwsNzUHSJQ9fEc
 MDuIWW1tzzWKsblja5Nabp5ij2uFYczxheA6jo+r8OSul1EsnPGo9mXXRXQgEKX4Y9tD
 VZC86SJ7XnxqX19FNbwVZXawQDYwyvOLQoxg+uY1uEzSuAVhmDzqCEbDL8oJw5nxHTr6
 7BDA==
X-Gm-Message-State: AOJu0YxHvyjZskFYgyzgMiluLDAItBChm+BaKd5r3fthATnds+e/trG/
 EM0E5obJS7MA2Wnprz4bc1Wc08VKN/BewEVg7oI8c+44ydQ+ELGVIaEr
X-Gm-Gg: ATEYQzyR/l5mQ3mgInSpTypJYG1nDJRJrc73J4Q/gFygt//bWuwlxwOC4OUtk2xrt+C
 t0sBnHM7qdmp19UctSJXqeeHAiGv8trBFZnMhQfDLiMygxfRH7DHzTBORx+l0Nen4qegJT0BlN7
 poQq4CF/LTND0g12j1051GN+Vv5iQuYngAQS4mnbvaVFQuWKW8hBbASIJN7EeBQ8vYhVfThZMCX
 WYP1xCCJDqUG1ILXX3lKqkKVYzkLtKvqhm0uegulRoOHYMfoWT9Cbn/43zXdr2J2BnyBvH5bvch
 kt3YYsQ3YtSaewiQqLby+Tyq6pvHwJbiEhk5HaR+cP7kH4NfbJPJjBg/lVGMkSjIDCXmrRSJ+S5
 EtFe+2506+tBtnq7epGRtpdxewzW+/V++UvU/f3KVSx7BAwx0tQHCp2so3rZj/nbF0t8ieyXpct
 Oh2b7Q1boiT9r963wg3fl39gNgpnGztltflZYg69tE0Q==
X-Received: by 2002:a17:90a:da8d:b0:356:22ef:57ba with SMTP id
 98e67ed59e1d1-35c2ff1be2cmr6546483a91.7.1774713734243; 
 Sat, 28 Mar 2026 09:02:14 -0700 (PDT)
Received: from Panzergrenadier.localdomain ([222.205.46.26])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35d9509cf33sm2266914a91.13.2026.03.28.09.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 09:02:13 -0700 (PDT)
From: amanohina1 <caiyuhe80@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 amanohina1 <caiyuhe80@gmail.com>
Subject: [PATCH] staging: fbtft: avoid empty macro argument
Date: Sun, 29 Mar 2026 00:01:14 +0800
Message-Id: <20260328160114.1143108-1-caiyuhe80@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:53:39 +0000
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

Signed-off-by: amanohina1 <caiyuhe80@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..d1eb3fc03d7a 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,11 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+#define fbtft_nop(x) (x)
+
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_nop)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_nop)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.34.1

