Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89736C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 03:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D776010E511;
	Tue, 28 Jul 2026 03:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="d+nZIYrZ";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3372910E511
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:59:38 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-848743155bcso1279579b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1785211178; x=1785815978; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZG17+S0Su867GFZUeLwXbhHQn4EdEHkEzu2G3eNwLI4=;
 b=d+nZIYrZGFaOEtdVLp6QFT2ead4DMJ5uIfTMaS/ac/aZzfq85dhVp4Zxe/RjwCPgDS
 MHhia63DByS85f+B1e8v45etVXymjMHKHNM2S/xTmKEUN3ty+M4+a3BU/A2SBQJsFNHd
 pBMk6XbY8Z0EZSt3aPCjkMGgxhgM4O7JsXIFOArqsQeaIiY6PNhyfuQCLJMMkIOfqfcd
 aq9ZzJySiTOBetRBEaGxXoo/cBcHUR5T/37PYxo2iS0daPbf0BnaL8G3oy9bFKZegXLS
 ZIUYaMB5UH1i8Dz0gmy4hn6toNd1mIlEIxtG0tP1GWazmurVizcFcntWMZb224SWUynw
 I11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785211178; x=1785815978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZG17+S0Su867GFZUeLwXbhHQn4EdEHkEzu2G3eNwLI4=;
 b=daoeozF3+e1QqGZ4tXITLgO5/mOj7EPlqZSfAJmcMxXtGtnvRiMeY0mluB96erJ1td
 3g8yPgr+gsz1HcmqphI9ilnBPJGeGqZf0eeC7kfVAZo6nQnyVg6pUSOFradukI5LfKKH
 qaegUkzm+dEeZ2MqjuPlE1dkHiKNbxXQsNVunTItFmo6OVFZ8bo62HnGW762tBUpzUFw
 U1zIrDoOzUuFYtjW/1lScmORB+IxS1hE264hjmS3eGCgMV477xkXnv7n61W8uOA4UeLy
 SsfvzIcY9nM/+R57njzSYtMER9FNk5H6dEP5TGRU9Ai4yq+qWyVanGljWWGmX8sEEHqt
 73pg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQYbfjyApV0uGB9GpXImzh155q3jfhk48VWEK09IUcFmPSr4D57Q6kLoLo8NpRrU0Mo/5LdIBB2Q4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynSj6E360ThmVkYzm7CieecAcAP9T0frC5biPPfVrjAj9SPva8
 4UdjP05mZT600BbB+RDdgcaiwWGmzhqsQThVgtLHBldZ/TrTGMNQQrQ9CuIoORPAJQY=
X-Gm-Gg: AR+sD1320u6H2Ta+ovfEVa/a+selyHnI47wU1Vyc7AUI5uICi0lE55Is/18WLqKA1Si
 4euA12koifLjkhjZiIXjanrHFtG4eSAjNYu4KW1qQ7XXGZOpo1uSQ46hoK0v+W6zI8hxKHsyBaJ
 ahdDees+b/cKn8+dQFvR7nPWr2ZEfa1ouXk+uAjbqgbIIvnY0H1mRzlNNqPpfpeiATaPYrgyJGo
 PhB3vrhwWLiCsYFwx0NhnjkxZsMeOhJzBtBM9BUfE4qWWknVQwbQQl3K792kl3uazN0FyZNCoS7
 neq4WYRw4DrJtHEGzfSvbr4woHEFd53rKm/jKkWxml070RhNdIrf9Gvsi2VkXPJkwt2tCjDxs5O
 +9EJc6H8D653KyWR3BD3ocitUktkhW14K95MYACt9vZplqvpOVE2Zeq/KCiZZSK3PA9fBkHVkiz
 kqxa3TUzyOrZ+Rsue3Udv47tUmRrcFilhlun/aPfWWU28yZU/f2Ak8yXKlbhHrq1GNCE8=
X-Received: by 2002:a05:6a00:451c:b0:848:732b:6b1c with SMTP id
 d2e1a72fcca58-84e932ca702mr673309b3a.60.1785211177675; 
 Mon, 27 Jul 2026 20:59:37 -0700 (PDT)
Received: from terryhsiao (61-219-175-100.hinet-ip.hinet.net. [61.219.175.100])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53418f58sm3779860b3a.40.2026.07.27.20.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 20:59:37 -0700 (PDT)
From: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Subject: [PATCH v2] drm/panel-edp: Add CMN N116BCP-EA2 (HW: C3)
Date: Tue, 28 Jul 2026 11:59:24 +0800
Message-ID: <20260728035931.10342-1-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.53.0
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

The raw EDID:
00 ff ff ff ff ff ff 00 0d ae 6c 11 00 00 00 00
02 24 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 47 ff 08 3c 7d 0d 0a 15 7d 00 00 00 00 05

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
Change from v1 to v2
* Modify the signed-off
* Correct the subject line
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 14dd40afa899d..bbe5c29405a08 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2083,6 +2083,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1161, &delay_200_500_e80, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1163, &delay_200_500_e80_d50, "N116BCJ-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1169, &delay_200_500_e80_d50, "N116BCN-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x116c, &delay_200_500_e80_d50, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x116d, &delay_200_500_e80_d50, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x117a, &delay_200_500_e80_d50, "N116BCL-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
-- 
2.53.0

