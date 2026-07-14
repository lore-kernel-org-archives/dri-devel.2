Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBFDC44513
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF1410F1FB;
	Thu, 16 Jul 2026 08:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qgftXjlc";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291F510E057
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:11:30 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so29828865e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784056288; x=1784661088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EfWoPu5aITaJ5jCwkR3a7VKo4LHkSTdvVPxiL19RVY4=;
 b=qgftXjlcgyzV4WRDw275Y0v22ysG4jMLDzMElSyAXajrwkknuKWFbGZb0Mp/EDPvzk
 JbLe431/c+ATKnKbxWelum/C5UJsWYKdXXm7Eqse2vKzhdwoaFiV5ZBvHl97c+ux7ib3
 ycWIfyUtNOXbnJQY4YfP6U4rw9FiMilUsepCK2JnFUE6knwzRsLmxu0bNMA2YbwFsbaS
 XDNKbQ8aSdYbYrp2EapSivEg90wQcw4Wd/z93OXAiopefocJpQTv/Qac7Wmby38gu1Sk
 ZIyrwaOWr4LNvAIWuwLhjpalz/jDxzgbaFS7ffY+Br1yE7+6AlT1PYtwjCw575rWC2gA
 /vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784056288; x=1784661088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EfWoPu5aITaJ5jCwkR3a7VKo4LHkSTdvVPxiL19RVY4=;
 b=naO6pP1Z6nyL2v0bHQDyOXJ1+RoLI/zBrVLUJP5ooSJf4SkbXlm4YhFIa1KLN3oo9u
 1mbov20P7Cnq4ottwjKRZxyp58uYrbO+iLo4IPU7h53FEVkaPbc5sS2uFP6z9ZUckvZV
 NMBbH7eUOQ1PvPXdwXpl2/JNJJX9L+oV1c8vQDOdbScUa1gfJNyJe9ZhwXxib3n8OGmi
 o8wmSeNe3a1QH1f5o0OtHHuwswCnEn65IH4odlOO5QHJJCHnn01c+pQ+kRKw1g5t5rbr
 fCDhj6bTFQ2CTdqrdoGC3T1WU1h4eWfQfLVAxFyG1Hz4TTa1byCmJRhtTJt87I6YQay7
 kIGA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqjn3o6wp2IJ46EIFY5jMznfyhHIosgGubAPGHmm+cmr/4+0pxGyH81MtVPi4zZKU/MEJBB9hyCWl0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbnAqXzlulMkPoQ7BWTcJZG6PzopGV84dYjMNFb2CHYolDwbD4
 CTIr1pLrX6QO2FKsvXtEngxnfgAlZBJY8pfFkl1JQ36+U7RHQr7NKpYmhNvRpVCc9uQ=
X-Gm-Gg: AfdE7cmWpvyVFnHsNgL0vbCqGAUZfPqS3mRO8LNfym17HFHC0WNuHYfsqkV1HhfyDZZ
 q3PzcuqjywnmhIJB2I2k+I3PBrRYVu/3ssPZhawVRw8TeHfEht53Z8TMRaV4s9uSwxMaPC1hc8C
 g2Z3wg7isRZ/NXf5Xk7FJ8tKVgkdFOiqsgLxWHxhyU6CpN8RKBXZQva4zAByEBwa7v1iUNJVY3f
 H+LvX0nxQ+/9gRSlA5tkFnoLwEqN14BZOadgdNOmH7xwzLwGqAb+R4iGb2dIkQKTK52VqEjnRsS
 VKLthOpzXhUVaTnleT3kOUWi7e2uxeLkIuN1UZ001uQYYNqyyZlNB0SMOvnMDf6ddQV6YLunXW2
 TH/8dD1UPzrNnkYjRN2/isaT4LQGTmh2lD2SGtDx5eqW9wmeuX8+omu9uXGG9QrAGNHZQ6e9iUk
 20LPdzCNDBxvq6zV0CzXtEdX0C2P1OOE/bPvg7erRx1D19reJNH1ohysEO/F1CRBhxQEnGV5NMB
 XaO6y31Te8ncSgqAGpnHQ==
X-Received: by 2002:a05:600d:644d:20b0:493:c601:3e23 with SMTP id
 5b1f17b1804b1-49538992cfbmr31608585e9.5.1784056288413; 
 Tue, 14 Jul 2026 12:11:28 -0700 (PDT)
Received: from evil-archie.tail5479a9.ts.net
 ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f951asm100677815e9.14.2026.07.14.12.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 12:11:28 -0700 (PDT)
From: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: namcao@linutronix.de, tomasz.unger@yahoo.pl,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Subject: [PATCH 3/3] staging: fbtft: Replace udelay with usleep_range
Date: Tue, 14 Jul 2026 22:09:42 +0300
Message-ID: <20260714190958.219437-6-graviaspanagiotis1@gmail.com>
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

Fix checkpatch warnings preferring usleep_range over udelay.
Replaced udelay() calls with usleep_range() providing a reasonable
upper bound to allow the scheduler to coalesce timer interrupts.

Signed-off-by: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c    |  4 ++--
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..d2400bb44f1c 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 200);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 200);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index c680160d6380..e26766f58a50 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
-	udelay(100);
+	usleep_range(100, 200);
 
 	/* y-setting */
 	write_reg(par, 0x0024, 0x007B);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0025, 0x003B);	/* amplitude setting */
 	write_reg(par, 0x0026, 0x0034);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0027, 0x0004);	/* amplitude setting */
 	write_reg(par, 0x0052, 0x0025);	/* circuit setting 1 */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0053, 0x0033);	/* circuit setting 2 */
 	write_reg(par, 0x0061, 0x001C);	/* adjustment V10 positive polarity */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0062, 0x002C);	/* adjustment V9 negative polarity */
 	write_reg(par, 0x0063, 0x0022);	/* adjustment V34 positive polarity */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0064, 0x0027);	/* adjustment V31 negative polarity */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0065, 0x0014);	/* adjustment V61 negative polarity */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0066, 0x0010);	/* adjustment V61 negative polarity */
 
 	/* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Power supply setting */
 	write_reg(par, 0x0019, 0x0000);	/* DC/DC output setting */
-	udelay(200);
+	usleep_range(200, 300);
 	write_reg(par, 0x001A, 0x1000);	/* DC/DC frequency setting */
 	write_reg(par, 0x001B, 0x0023);	/* DC/DC rising setting */
 	write_reg(par, 0x001C, 0x0C01);	/* Regulator voltage setting */
-- 
2.55.0

