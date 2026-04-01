Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040AFE7E351
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5090710F219;
	Fri,  3 Apr 2026 08:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lcfc-corp-partner-google-com.20230601.gappssmtp.com header.i=@lcfc-corp-partner-google-com.20230601.gappssmtp.com header.b="hsh/Xoe/";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D49610EAFC
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 09:03:43 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-82a3d3235c9so5525947b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lcfc-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1775034223;
 x=1775639023; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUYa9X0WVzD3ZaNiuSe96MbGzpjXqAhyynXjDtnFg24=;
 b=hsh/Xoe/Z77lDVTL7Be/k4ceN4CiUiVk/fBGIZlg4XYHmllV0G5kET9oKOM/6xIowb
 J4qdTWIziz8S8+um+C93gQwdaBkX5QVCARkdyUhQl0Ep0DzipxpXAoELBkN1NduQuA91
 zsG48NFOSl77+f57rLaYDGJ+wQ0h70oR4qOUTg+9GFM8qI/whTsj2BBn7Tp3DRBPV4Wm
 8TkWEnsPLMSSZ4xYIL0JnHfiSurzrgEfHWWz8DGdlD8YkqwCbOiT8KGKYLaEHzUf/Mzr
 jQJ4KcNWeQXgPzvDR1r2XH/+zhsfdewcOXihwGQgLoOJKWIlSd31AQH3eNoe56X5hNfM
 40bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034223; x=1775639023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUYa9X0WVzD3ZaNiuSe96MbGzpjXqAhyynXjDtnFg24=;
 b=i3lWUNHO8JgPT8IQeSGkP7sKKgwIsng9InjdHMeYO0xGln9ILoRqrBclrr0kKgcOzG
 jioGYRJYXDwrA7kPDuhruET1t/7XnAp0LS6KH5Y5rWHaVtboLCFovmTfhzAoVvZt9DAE
 +Uem+MBD5b2UtXaqlymYtsF08oAol+TC78Uxop5+qaAuFl0uq5cPZqx+dRuVA76n/fWF
 h8dyEUZovDk08hEG2uhoIcASe6VQIcgNI5BDLbPbhKlmIegG+fAoGI+wW6l8KpB+dtv7
 e7TPburAuiLVKg2Z9xfU3VfuS09wUrlPSxTsNhPUMnbgTXdU6HUoEz/tkp4EaTgC2Tcz
 GJWQ==
X-Gm-Message-State: AOJu0YwLDqurHCptBSpbJUj5V10A3WtnTAsil6u21nTqv9OIg9W1HLEi
 ENm2RE89uHyQp1Huy2jKkWtUwbdcuVNpE/Jqsib+X6k0mFhwlsLcl0167fC/LSapwjPND6318i3
 F++cQlsE=
X-Gm-Gg: ATEYQzyXnWH9FyztQDVseEowCB7KCupJhI+VFDXovIzBbL5sniuNr6xETBuU4JMz2x8
 /AbicIvIvbu3gJs9ST4EbUuNZPvWHJc8RP2HDHe6O87CXwawVVDO2nLa6NQbceiNNbogauuir25
 2fF3HSIGEr0PESBI4IrzacypHtXFUd/rINL04Km9WpTW/b8JP26iSilQKktJeFfrGHzptixPS/T
 F/T/PiKVG7nllLvvuGxhTtH0hIcxRRn1rW4Z6z2PUtPBkljG+jiVVPaLw/14hsLWCqcXsqf6xMt
 nTHYx8B4aHqZUj+45YULlpSmqfFSItnTeDBrqu1rYgxZhucb1nmWR6V9waH7xlK4isB+o2MrsuX
 1wAn1ySWQxxOPtx12Besj3NcN8mW3iyZS9BWM9NL5ZoS9pSAoMQhKRbcjv8rW6asTAm/2xmGGyy
 xsQamNy/DCCQG58bAyM3A+Vg47PDyT+jyBtxe/IW4TKGbymq4vThML7+kiq2HUXaERWuNmxg9+i
 xDfs/vpLA==
X-Received: by 2002:a05:6a00:f97:b0:82a:805a:7cc with SMTP id
 d2e1a72fcca58-82ce88bbc42mr2890517b3a.4.1775034222893; 
 Wed, 01 Apr 2026 02:03:42 -0700 (PDT)
Received: from thinkpad.. (211-21-152-94.hinet-ip.hinet.net. [211.21.152.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca862dee1sm14033934b3a.61.2026.04.01.02.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 02:03:42 -0700 (PDT)
From: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Change BOE NV153WUM-N42 enable timings
Date: Wed,  1 Apr 2026 17:03:34 +0800
Message-Id: <20260401090334.2329270-1-alvin1.chen@lcfc.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

BOE: NV153WUM-N42
00 ff ff ff ff ff ff 00 09 e5 b3 0d 00 00 00 00
11 23 01 04 a5 21 15 78 03 af e5 97 5e 58 92 28
1f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 9c 3e 80 c8 70 b0 3c 40 30 20
36 00 49 ce 10 00 00 1a 00 00 00 fd 00 28 3c 4c
4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fc
00 4e 56 31 35 33 57 55 4d 2d 4e 34 32 0a 01 92

70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
00 00 60 49 60 49 3c 00 00 00 00 80 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 cb 90

The default 80ms enable delay (T8) for the BOE NV153WUM-N42 panel
has been found to be insufficient for certain hardware units,
leading to intermittent display initialization failures and
"drmSetMaster failed with -1" errors during VT2 switching.

Through extensive stress testing, increasing the '.enable' delay
to 200ms provides a **significant improvement** in synchronization
reliability. While this adjustment may not completely eliminate
failures on marginal hardware units, it substantially reduces the
failure rate and provides a more robust timing margin for the
DRM driver to complete initialization.

Validation:
On a previously failing unit, the 200ms delay demonstrated a
marked improvement in stability, successfully passing over 1,200
cold boot cycles before a failure was observed. This is a
significant leap in reliability compared to the original 80ms
generic setting.

Signed-off-by: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f3cdaea89b29..a39d33afdd4e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2025,7 +2025,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
-	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e200, "NV153WUM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
-- 
2.34.1

