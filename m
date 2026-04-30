Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F68CCD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9376910E476;
	Thu, 30 Apr 2026 17:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZxkGCFNO";
	dkim-atps=neutral
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com
 [74.125.82.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660EC10E112
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 10:25:46 +0000 (UTC)
Received: by mail-dy1-f195.google.com with SMTP id
 5a478bee46e88-2d9916deb14so172547eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777544745; x=1778149545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uyYaWTV5ahYl27fxYzw7aiTm9/pi+cupE4KnUEMoGHo=;
 b=ZxkGCFNOEhHnzbJtTa6WW3VoKvPYsgeC2fjRRKCOlILgMCKh4LplpEeF8Rv+NlCsvw
 p8JCh2zOT57x2dynoci7GJGmUDbniMGaR7Cil7kn1Vhv+JiDnxXbGU0o05O/UGJVlUBr
 y8m+r0emMypZILRlRWgzWd/6Q80d3v99BeFfSRGRlkq9RTKJSrV2iTxSzHcvr1poyDZY
 40c8MgvTAJDUhSryntqbCiUiYbQ4V+8SgNpm+HyjTeyXA/eor03Z+bYi+JIrKd2qH7PX
 LOQe/1UuK1oi69w/Gtvhbm8u7BC0WmbnEYmT82+m8w7IHgd8wb8J2aIunDlVhOPqFAyj
 Mc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777544745; x=1778149545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyYaWTV5ahYl27fxYzw7aiTm9/pi+cupE4KnUEMoGHo=;
 b=Hcl3ATWZ+hcoCeZ9smV9ElTBkP8dx+qkDYL0X/2QROgnWiUtPDBx9/yWnguyiMOCsO
 x2MDkyU2A5g4itQ/yx7981KeEbFucNowCeQpsu6ZwFRQKCOx9aT67UDu1KpBVsUvT7oJ
 odQk89ZeZ8ylZwrURkbSp6g8214OdwMy55lE87UWQfhI2BwjOfEVgcyxnMFjwX8F5Lfi
 sQVynfYMYpWl8Ty1KpSNjW4d+MRJq77u/GpGSB6BsSRNH4iwUnrm95otU+m//xY0BPkl
 LtMk6gWsNFk4SwEzCBvBNZ9CRs88yKNm7erX3S7kTD0TDGqsjhI+6/u9VuRU2ijCm40Y
 5wNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Gb4uicdtGmJh5mg7F/ymWUozYt5ig+iaXNipsdCTCw96l2mPP3ghqOvcRrJboCAMVfUKcbII+2FY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8XIq9O6wSp4aLMn7Rq6YuG6/EmICJNQawnfLk392VE5/tlyvG
 JBv7miK0rU662LP85ESoX6XAG7go/Bkjc7CQkP/QWslyrWUQQBujyspV
X-Gm-Gg: AeBDieuMMcpE2Pn+fEUXOwUeMW+ZDtEWU18K4EEm3PmOdRxxTUQnLoDkG72DlTjFAYd
 wOO2cGXZjhurjCBwJxPjMUl265kLYPAP8HyXa+faKE/c2f9vvCSFxlXsDsaFPZZ+tj+qW5Z8CFk
 y1hKS8hm6taPKQN311PX5wYglUjvDB4KWvEmGJ5njJ9T0GLioZXHyLnIQEDqUmzkc45xDr6a329
 puO76rqFXFOQGucwVIdR9bmLAZehya8VmgAtiXpXV4HpJO99VHLX03uWMbjBm1L1+siGFV4ZaCC
 zC1e8AJMn25dLNpxHXolhmTuyoXUWCbDh6onfyVop0h0hrKxx6zh2FFKpr2R2DClsHFKGQtH1nB
 AF6UnWUkak697Q4pTLMnOQD0N4ADPgpkWdPszNuIyIWXIRuoJhRTXK3Y0dI9QooSvF6hkHIG2IU
 6XYwoLT4/yoDgVmyRIALhtNd0BcMFwcrf6ib517ZRA76vV8KjF5uYupZDNZWf9RYo2rw==
X-Received: by 2002:a05:7300:e614:b0:2e6:4d6e:2cbd with SMTP id
 5a478bee46e88-2ed3bef29dcmr951391eec.8.1777544745512; 
 Thu, 30 Apr 2026 03:25:45 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d419sm6191614eec.2.2026.04.30.03.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:25:44 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: gregkh@linuxfoundation.org
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] staging: fbtft: remove unused function
 fbtft_write_gpio16_wr_latched
Date: Thu, 30 Apr 2026 10:25:29 +0000
Message-Id: <20260430102529.25019-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 17:06:40 +0000
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

The function fbtft_write_gpio16_wr_latched is not referenced anywhere
in the driver and only contains a stub implementation.

Remove it from the driver.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/fbtft/fbtft-io.c | 7 -------
 drivers/staging/fbtft/fbtft.h    | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index de1904a443c2..7d331eba947a 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -227,10 +227,3 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
 	return 0;
 }
 EXPORT_SYMBOL(fbtft_write_gpio16_wr);
-
-int fbtft_write_gpio16_wr_latched(struct fbtft_par *par, void *buf, size_t len)
-{
-	dev_err(par->info->device, "%s: function not implemented\n", __func__);
-	return -1;
-}
-EXPORT_SYMBOL(fbtft_write_gpio16_wr_latched);
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 317be17b95c1..c7afb0fd3943 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -262,7 +262,6 @@ int fbtft_write_spi_emulate_9(struct fbtft_par *par, void *buf, size_t len);
 int fbtft_read_spi(struct fbtft_par *par, void *buf, size_t len);
 int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len);
 int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len);
-int fbtft_write_gpio16_wr_latched(struct fbtft_par *par, void *buf, size_t len);
 
 /* fbtft-bus.c */
 int fbtft_write_vmem8_bus8(struct fbtft_par *par, size_t offset, size_t len);
-- 
2.34.1

