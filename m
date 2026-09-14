Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D1AC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D1610EE44;
	Mon, 14 Sep 2026 13:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EuPUdTFY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VYQU0d5o";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08AFE10EC37
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:09:45 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hjzqp57f4zKmwd;
 Mon, 14 Sep 2026 11:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789376982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MHeW1CPKnaVftcIvrFx2pYex06w5p9ZRk+t3E962Owk=;
 b=EuPUdTFYedeOhhLAtPjFL+sdg6UWnxKIhVjx8z/UMXjcKiWSswTCVu3ST+x+fBYkDa2i/M
 CUHSDpYXJ6Oic7sSFfP5ISQE4ApPs//q3Sxabk/cpuKRAm7s9ESFwlsBMtRg9mNKcvtqol
 FDB+T28/GkUB2A19eyOyDPFwscPYNkWQQgRNt5fE8qjjG7Rb86ADCYn5p+197VQ59Iwz9S
 D46ogYFT4D8z/QpoWQUk5gVfHoi/UvIX+rkJt0pfb4SttrULlXu/BqCpXgEyGca/2k2iTx
 VLl5NbF1ubAcsv8r13DWcnaPbfLfnY6x6GyB8Nja06sx4fDEKgNgv/ywQbEmOQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=VYQU0d5o;
 spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789376981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MHeW1CPKnaVftcIvrFx2pYex06w5p9ZRk+t3E962Owk=;
 b=VYQU0d5obr2NLWOaeJ7auVMl49K6W9fJEIhD31PqQDmDAx73IJowN0+VY1qt1bXgKiWlHo
 EE0pEBNXpmJF8BqF9s342OWImZc9PowGg6voyEror3RCENtAkyxjI+ZxprDVH77HgZH+Bw
 1W80zqIyrmwZ++KvS0fAzdE0nZZD97eMCnM0fv7sDBErNixOXGBq7bH9JasE+XP7a8U29Z
 5HMkc5nKJUT6AccK6lq9yEM9wtsHayYfT5EpYbRXaPsRNNIEdIi39SYIIX5Uf4d9azjHHj
 FnIu5KOExuufia4AttASzDCepv7Uf90t6W2tlGszd1SEIXV5nLazuk7rNNqWwA==
To: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: replace number with sizeof()
Date: Mon, 14 Sep 2026 11:08:58 +0200
Message-ID: <20260914090858.9939-2-manuelebnerli@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cw4btzrgu7sahhkxa6erqcjkpep5yxpt
X-MBO-RS-ID: 00adecfe0b933e12e23
X-Rspamd-Queue-Id: 4hjzqp57f4zKmwd
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:10:56 +0000
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

Replace integer number with sizeof with the goal of prevent future truncation bugs.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 drivers/staging/fbtft/fb_ili9320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 0f98267a7..655778392 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -21,7 +21,7 @@
 
 static unsigned int read_devicecode(struct fbtft_par *par)
 {
-	u8 rxbuf[8] = {0, };
+	u8 rxbuf[sizeof(u64)] = {0, };
 
 	write_reg(par, 0x0000);
 	par->fbtftops.read(par, rxbuf, 4);
-- 
2.55.0

