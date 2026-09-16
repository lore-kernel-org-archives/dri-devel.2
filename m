Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36447C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1F510E8FF;
	Thu, 17 Sep 2026 07:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHQboBdh";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F5C10E1C8
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:39:40 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso6132795e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789551579; x=1790156379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FK0BAI5zlwK5WHRW3pCb1OR6vOTCwaSaqw4lIuR/t0I=;
 b=jHQboBdhOxbFzK6qRWknbYi7oJUkXv4k0xLLg2qpsA8iopGqX5Ls/kivJuo4PlQudl
 TC/m/kefrpprN3byoCXw1vYOYHx50y7LtDe8o71UBv95rcineFc3ksVfiNLScoBUrxvg
 8ZBlbdiJUi/bmfcMoZhAAVijUcKhk+H/EA5PYW1JvDO3wOpdQcr3ABl4C0tWieZZsBmX
 CoRBN5TyOvmCKBAJdvoIFzX99NcY4F8BPlLnq4Rh//tv5dhK0w/MTracPcidlkwiprML
 U+0Fc0Uv7J6ykWSVWC7qVBUpOSg+txUePqkVBXtyZ0DT1qQPucZPoSV1TJWHntpFDDS6
 ohMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789551579; x=1790156379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FK0BAI5zlwK5WHRW3pCb1OR6vOTCwaSaqw4lIuR/t0I=;
 b=QHZ60aa36T/b0fSLYpVgQxtTtmVCqQHJoSsi7bAgMkNsOxLrhSLDju+fyokTPoBS9+
 tTcpaD/KuB5NTHo0Lp64jFFzqzwAmy9qQ6uuRwb/mmwTyTTl3+9fG+2fc3E/RdHXCP6W
 JhmQVf9qEECvtMsv095ojcygNlLR/0P6Oa229/Jmu9OTRXar3pXPdYrNA8LnSOFxwgwe
 /5Doy3KfPMtHZEFn1S10FjBmQkV/0X3Wz6dkksfVU5QPCTbjEst+KEgZGcp1uyKFJ6sm
 eSmTAQE141DbosQ6DJg+kSmn6PX2zKhEWyz4A/abRoPSwhIP8fXp6QtelipKFoAxZ4+X
 FNTw==
X-Gm-Message-State: AFuF++kdBWw+ylqVU0X1KIir+ciIWu8bXFDf02TBeAjC0iLMpRvSdOxN
 r3wosPG+W1lZBHsstjtifUkEMB7SSb/ZegmEgSG/gOONmMYdQi077lBDRrbqK7eAkaU=
X-Gm-Gg: AYBFou2ftcQuXW7kAKJ+/ok7cAE6hmmFgCd2oYjwzDoMltjnEAPMFu1qbfW6+yTYtc6
 N+czm7p6GEIq1PStF4BboK1gI/mGHdqiimLvI9I8pu+tQC4a8uOZ34jUg5p8Ey0ol9JyUH+sJYx
 aCc4eZjLZV/AzhnC/H7sXOOxFyUblC6l+jSq7HSe52xqnj1TTLuch7c8TDdZZj4RUAM0d1jS8mx
 MrkMYOoaPBeCtZFf9mNLzwsAjzF9CAa3TzwzvEfPyjLZ/NqQ1vbv8gnjZn33E7xTzFWB73nX9SF
 +Tnxg7cuQ1STPuQh11NZAaYsDkL5BnzfQ7gJsNUCjYzNaty1RN5KZrdLKXITIkrCHDPqBDyvFQq
 lPDoQCEd2QGYtpy1XWdakQThGWe60WJSfg6Q7/Ko/dvp3GEdOFwIcdBC7DCq7huO/w9DkuXiLrK
 aqfj+5CaiF+nu70iCsRTjlAs7zhrEDsbovEBnktmIq5r9P8pCQYmWVaWSl5mibFJWPJpKatHEo2
 Hv8DNk=
X-Received: by 2002:a05:600c:3596:b0:49c:dcec:bd27 with SMTP id
 5b1f17b1804b1-49eb72f2c40mr23366615e9.8.1789551578513; 
 Wed, 16 Sep 2026 02:39:38 -0700 (PDT)
Received: from omermac ([82.222.238.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da9a7csm61728415e9.11.2026.09.16.02.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 02:39:38 -0700 (PDT)
From: Omer PALA <palaomer100@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fb_upd161704: replace udelay with usleep_range
Date: Wed, 16 Sep 2026 12:39:28 +0300
Message-ID: <20260916093928.52057-1-palaomer100@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

Replace udelay() calls with usleep_range()
to avoid busy-waiting and allow the
scheduler to sleep during delays.

Signed-off-by: Omer PALA <palaomer100@gmail.com>
---
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index 7288140e7..f66dfad1d 100644
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
+	usleep_range(10, 50);
 	write_reg(par, 0x0025, 0x003B);	/* amplitude setting */
 	write_reg(par, 0x0026, 0x0034);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0027, 0x0004);	/* amplitude setting */
 	write_reg(par, 0x0052, 0x0025);	/* circuit setting 1 */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0053, 0x0033);	/* circuit setting 2 */
 	write_reg(par, 0x0061, 0x001C);	/* adjustment V10 positive polarity */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0062, 0x002C);	/* adjustment V9 negative polarity */
 	write_reg(par, 0x0063, 0x0022);	/* adjustment V34 positive polarity */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0064, 0x0027);	/* adjustment V31 negative polarity */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0065, 0x0014);	/* adjustment V61 negative polarity */
-	udelay(10);
+	usleep_range(10, 50);
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

