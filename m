Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2A6CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221C410E1CF;
	Thu, 25 Jun 2026 09:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ld3yKe1k";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A29710E1CF
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:27:30 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-13810b63a1aso1642078c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782379649; x=1782984449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+GgAGfvLU/sWq0xn5C6mnyJo2AmSG/YZOnlB2KZb/PA=;
 b=Ld3yKe1kTgNBiljdMciplCqzgavI4sYwJe8Ea0kZYpF1doVUoMaqCJFzFk1MR1w5oU
 Nk94caj/guXbzVZFFiOIHKD7lq7kQVFll82rHJUBqN2ja429xmd1eI28fhAk7BPnS58r
 ZCdfGj+zTY/d9A9r6llfZkFzjHOrTGMOjFpX2YOxvuiQyjVhfBUegvnrFxqwGdmZBRDX
 OrL2Pxj/9Fk7mSnrserjr7mkdoUbT8FKlkxrYO0TB6xlja3dBWsituzKOy3y4ztn+m58
 yUFzOP6eP5T7xurIZOyYhcee0ZeV98yEupC4Hcmg/PdR7epc2MjNlsQiFca8RDmWNLn6
 oKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782379649; x=1782984449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GgAGfvLU/sWq0xn5C6mnyJo2AmSG/YZOnlB2KZb/PA=;
 b=EOnrIqVqdWWOXZLtzVHB+JH0Zr8j8AS+Mnzyn0V2tE9yac/yAV3gUCKC8PJ4l3Zgu9
 6MKZDRsUaz/Ahjjs3Uos9vM03xAOQsbSEXzgpzt8pLKv2ojEEGfEgKRyKYoiWsv59hfb
 n73c4BlM2pfpTCDOUxQNStbS5oJc0SUelX2kCN0E58ovV2umEF2GqelO46NMv/QXJqKn
 muuXzbSE8Vk0AQe7K47v6lVS6lMLyxT9RI1wTn70jBNBPYtoa7tsiPNQIESoiC+Dnaw2
 hnc7FowhHiKY4AVXOtVC9mxp98Jivk7exaqBPWRYQ5N+1OzH9rsEzKDsEO+NpP74sVi/
 VozQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qbh0JwVpSJ3yvpDOuh6fji4xk8FUyaxZ5EloFGvvq8rdyPLhIRoLn3PsJLFYGx5aER+EQPH+EwcM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsWHawLtZS/oKawvL5NrfqXg30Cz0Zeb/BGl413jw8qMLqDi/n
 duLQupW5XSJ6Fl5hItxvD/XRG4lFGgB4G6i3u90q5iAAuwnUSFpq8bY7
X-Gm-Gg: AfdE7cljClxefEnsVZQhm+hqrlKpz7VlE1cRAWcX31il6S7fAsACzQEDC4RhbErfwFb
 iQxjvWv4IZbvpojpeqspDFOiexAQJSrg9vsttVEFIkIbfFZBhShsMWDJkSQQD5VVecfNh/vuW4F
 sEX70A6xpCwI4s8LmZZMP+ig+Z18mxRh6Cd86sVKVax+42xWBIJhDk21yssuuPr64LFeQFScqDw
 qG98HblaVi1lD1mWiJADc1uDEEnIMgY9vsXm5w9nfZDI7PDqx9PDtTKKu5vk/UcAAICU9oSwQfq
 yFavXhYrGZ3EW+OitWleOdU5ljxALqdX6KxxXq0aAGwVTO57WcaoHCPtUUpqeFXG2+P4Cq5dGCR
 PHRvS5kUFmw6pXtHf834J6sGajc/WaChRfmND2PIqKJjoBdWgnTCbEdVKPtb29XoLThF4fLr0SF
 K1VWEro3ELpyHcJ+hTlQL28eq5Ni381PGtY8GjSTzlE7Ch
X-Received: by 2002:a05:7022:e12:b0:128:d4be:7438 with SMTP id
 a92af1059eb24-139dbb548fbmr1587576c88.30.1782379649197; 
 Thu, 25 Jun 2026 02:27:29 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e971dsm9709547c88.10.2026.06.25.02.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:27:28 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: fbtft: replace empty modifier argument with no-op
 macro
Date: Thu, 25 Jun 2026 17:27:21 +0800
Message-ID: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Define fbtft_write_reg_no_modifier() as an identity function and
use it in place of empty modifier arguments in define_fbtft_write_reg()
calls to fix checkpatch errors.

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..2169f8d1d 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,6 +11,7 @@
  *
  *****************************************************************************/
 
+#define fbtft_write_reg_no_modifier(x) (x)
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
@@ -62,9 +63,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_write_reg_no_modifier)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_write_reg_no_modifier)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.47.3

