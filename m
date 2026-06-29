Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE40C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE33310E0D2;
	Mon, 29 Jun 2026 01:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="SafkKM4I";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 200DA10E0D2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:22:24 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-37fa53bc22dso1689420a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1782696143; x=1783300943; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JINw6mrv6sr3RfSan4QTPDxq2EMWJH8i5FW6cBbjHF8=;
 b=SafkKM4I/0A7ZAWtRcisv9g2QPPVLe4B9VHHn2ynYdCvWbeqw/bkAGk2ZZQr2uYfL8
 HbAtvn6ZLqX+U1AbKBLJxagd2iXxudvWqF31TbFCx9HaVQZfbR1XChShxdm5PCAUWKQ4
 C1BHclDe/lfP5wbjXD+oUCq/b0pJZyFEQUfFyLNhwufw64zhUJHbp1UMTzn9pJgzPDU5
 hb7g0jyNRbDqeQxjETjPz/AUkHbLv7c8ZTK220JlkUBbMXPjo6spKwMSgD4HP5DpZcRo
 6fSPjcruQ1Mmg43XsVnivVDr64qv1PnGpmkl9ahdOZktfVzcgdoHCoXhXM6CwFOzZN81
 y5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782696143; x=1783300943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JINw6mrv6sr3RfSan4QTPDxq2EMWJH8i5FW6cBbjHF8=;
 b=JnkWwPO8jqw25UyGFh8GFRF/0YcSFRbh28OW88KAQodvLJEQZ1xEob7gUNudzyO1Wj
 6YeFPim4HAjw0FYKGwxNxZ1a5u+g/iqAZQJP37GsblFQnQzAaQH7GnsxzIyy4vr1fAS6
 qfeqFRv7UkuFEvpWbEI2zBFRhC1r/FNUkukjPljNHCw2Zd/ZDgJxDuJOepyAaWfSboMO
 A7EhwWTFvtZeaCwyorL1NV0b6bYahAMKr3yP7kDZ1pC9Eo/apilRec39mNKSPSieM1qY
 lpRMOsTI2FnfJcNZZa5BI+HguJmQwtOwRX6ZqSo30MsheBFTJfcGAwGlmrJZXtxIcdLx
 Co+g==
X-Gm-Message-State: AOJu0Yy7EWP4qSHrqTU4CSALYkolgVxGSRLCuN7CngsKP/awVuf79bpV
 I/ENKAd0pHvKrx4eS2fdM6VmciIOvqMa7mL8w11BznidhaqghTiQETjx/zuASiZe+3Awt1QPXvl
 u33uN/UA=
X-Gm-Gg: AfdE7cnUL5a0H74rjwGg9rjpTHuLAV3Znarlep0p4NCjYFOzFW42vvG0eotXw8NMV/6
 ELNWBUJAOmtQ0+1AHPp8qpOGtOJgTdmsvRXqT2dIS9BrYWhEWHsTtKTX7cDOS1x+CjTrlTiKWxT
 bnYrZrhRyIuIVUTATKbBPFWKGNZDRHJW4tzmbKg7pZ51wPjMQzmdkhVq+Sfy6Hv1wHIQLFTzBX9
 feXzkjnqvVnSr+lycMLSA9NaGWYmfX/nIhJC5NRyhqej42J1718VVPuLUifxltKt0ZQpAEgFIk3
 6jfY+IvSvVg5pHXeZoaOLV8wNVf7AFq1eh9JpwzoQcI8OKs4laGBXitkl+Y9Uc0hRv2C+l+TwDg
 sg4/MnIxg9VJE8KDpSTxkjjZK49a10oWiDLi01md0iM+OpP9D7A+toEu0PFSkcMNh3mjDm9nzAl
 etbxh97V6QT+yDh+YEw9j2mkd5I6uU2rZewAnWz3DT70f5vkeQPHux7uOtVb2ClpIoL9Vq03wvP
 w==
X-Received: by 2002:a17:902:cf4b:b0:2c9:c16f:eda6 with SMTP id
 d9443c01a7336-2c9c16ff3eemr50005275ad.39.1782696143609; 
 Sun, 28 Jun 2026 18:22:23 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([103.117.77.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f63d09f0sm82534685ad.56.2026.06.28.18.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 18:22:23 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com,
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Support MB116AS01-3 edp panel
Date: Mon, 29 Jun 2026 09:22:00 +0800
Message-Id: <20260629012200.248066-1-zhouhaikun5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
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

MB116AS01-3 raw edid:
00 ff ff ff ff ff ff 00 21 63 03 12 00 00 00 00
00 23 01 04 95 1a 0e 78 23 e7 05 9c 5b 56 93 27
21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 36 1c 56 92 50 00 1c 30 60 18
a8 00 00 90 10 00 00 18 00 00 00 fd 00 28 3c 30
30 07 01 0a 20 20 20 20 20 20 00 00 00 fe 00 48
4b 43 20 4d 59 20 20 20 20 0a 20 20 00 00 00 fe
00 4d 42 31 31 36 41 53 30 31 27 33 20 20 01 cb

70 20 79 02 00 22 00 14 1c 1a 01 84 55 05 91 00
5f 00 17 00 ff 02 1b 00 09 00 07 00 2b 00 06 27
00 28 3b 00 00 81 00 13 72 1a 00 00 03 01 28 3c
00 00 00 00 00 00 3c 00 00 00 00 25 01 09 1c 1a
01 1c 1a 01 28 3c 80 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 e7 90

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index e70d2615b3722..b51bc2f7bcd13 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2215,6 +2215,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
+	EDP_PANEL_ENTRY('H', 'K', 'C', 0x1203, &delay_200_500_e80, "MB116AS01-3"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "MB116AN01"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5c, &delay_200_500_e200, "MB116AN01-2"),
-- 
2.34.1

