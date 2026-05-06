Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387ACCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7608C10EE37;
	Wed,  6 May 2026 17:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="WzbsYzJ0";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B197B10EE39
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:06:39 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c80148ae949so1672582a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1778087199; x=1778691999; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28KXxo0LUshly9aWm6dlmQsJn/WVgxR4OO3p2iyJ3ys=;
 b=WzbsYzJ0dNtOEzAF9tqSSd56rnM9b20SMIafNcRXJlAV1FNDby0vmt1TMpDtBxocUX
 BLZitB/dyS4/vIfQ06yjMlgG7ivLYn/uL73fq1OCOLpJ7329w2zSVlaWTstH95I6m6U2
 h6FnNtugUufpebKsR5GYLGLxEZXe/+d79x5YMgfFtTru28IYNjK9slGTGcMk2fWN9N4u
 pp+oSJhzUktanN02MG10gPVO6RjPweRms7dNijwpaoQYOthpIyMKctA8LrC7v203orYS
 AIDmOEoONC/YisliI4/Q2Za4QCGwiq+KprzWPWJFVIyQhB090ZGRxfPXVn1mw8RZVpj4
 Hwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087199; x=1778691999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=28KXxo0LUshly9aWm6dlmQsJn/WVgxR4OO3p2iyJ3ys=;
 b=URlbl/pXbO5qr0XJedFoo1YIeYsy5sNWxifFlr8aEcvq2Qf+vEQU4gj/btjvcMAK/e
 ddRVOFJB/4R0qDhKeRaf3bMHjA0TmnW3PX0rPwTnhKU8zoNko5WHrjgWFj3Q9fpxn9Ye
 5le+LwMKL63ptfRKq5hq29BcN/ulbu6qYet3Jk0PnjFxouadJrOxiPYZL+zXZa+krZUv
 7uk2ox1jqfaHBsIo+ghUSIM18emoUirghKPw4NsMXFj34YDzneLVYAM5Rt6Hhz0r04GS
 DnoWUMaBGZVny7gNSwA8okRwWN0388eCQNmTD+pYJV2PguIMrHPz9bcUA/FnV8/hHsHy
 1nXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eqcFA0RmVEfMz+Ognh4qZXMpqtM9nROfXs1Wa1jz843TcUgFPzxJ3HAywUjx/oMnESnrwN1u2CLA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvWygGXymtE+RvzQglmLXMzhY7fdmUmbV+XfxOSrPTXZjK6OvD
 Dof6tZRypQVE9WAuBXBVQGmHcGzJeV1PBwkdvXbpn2UHPrzCtf5XnUUuWSgOyy9gfBQ=
X-Gm-Gg: AeBDieskNejMgp6aegJgwdbRZEvA+lBswB5doyWM1LLRzbvC9mrTSqNfGzjyfJlPQfE
 hndth7XX5UsM6zIBxauTToWpt3ILVbP0yvicaqqgpM1qkKjFyH+JFaSH/ffWaPOXBiIURD+WdNW
 GGq2DyFCynZxzgwAVtDNf4eagrGgaKNrmdFZsEZPW4muJAzb19NehEEXWCgsUM/U5MG5vTDAwdB
 d3T9DDSQu6aJhp56/JFJZe1U+FUb3CVTRFwAbJ4rPsbu9qlm1JxwkOHGewla9bVSdbAslxVI4mj
 2ItZn1WLoME30UjHisFm+vkEPS8wr3QTpEw3BkHC5hqU2h1WQCyOmp/cKQ+C+kBxziwvcl1lT2f
 KXhAsDtNNMOiD0Tin1sQbx8iqCKWWrnJJRNRi+LG3cDU2WDBwmut4E2DexNFgBDW+xjdL32mi3k
 lufvFc4oOvnzP93GxhN2E5xmnm/P9s3AHokvqKaccw83zQisz325UuwdL3CIQnG7DP/mtlbye8X
 674MTcW+vqR03vrzSx5Ag==
X-Received: by 2002:a05:6a20:7293:b0:398:b95c:51ed with SMTP id
 adf61e73a8af0-3aa5ababc9emr4750241637.35.1778087199053; 
 Wed, 06 May 2026 10:06:39 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. ([150.116.253.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8242ab8bf4sm2649096a12.4.2026.05.06.10.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:06:38 -0700 (PDT)
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
Subject: [PATCH v1 4/4] drm/panel-edp: Modify panel name and delay for CMN
 0x14d6
Date: Thu,  7 May 2026 01:06:07 +0800
Message-Id: <20260506170607.10813-5-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
References: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
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

Correct the panel name for CMN 0x14d6 from N140BGA-EA4 to N140BGA-E54.

Additionally, adjust the power sequence delay_200_500_e80_d50 to 
delay_200_500_e80.

CMN N140BGA-E54
00 ff ff ff ff ff ff 00 0d ae d6 14 00 00 00 00
22 21 01 04 95 1f 11 78 03 8e d5 94 57 53 93 27
21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 2e 1e
a6 00 35 ad 10 00 00 1a e7 13 56 e2 50 00 20 30
2e 1e a6 00 35 ad 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 3d ff 0d 3c 7d 11 10 21 7d 00 00 00 00 3d

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 427a4b4c6712..295412ba13cd 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2069,7 +2069,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14a8, &delay_200_500_e80, "N140JCA-ELP"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14c7, &delay_200_500_e80, "N140HCA-EEK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N140HCA-EAC"),
-	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80, "N140BGA-E54"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1565, &delay_200_500_e80, "N156HCA-EAB"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x156b, &delay_200_500_e80_d50, "N153JCA-ELK"),
-- 
2.34.1

