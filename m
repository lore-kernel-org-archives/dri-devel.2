Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D17DCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 980D110EEA5;
	Mon,  8 Jun 2026 08:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="jT+iilLA";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C81D10EEA6
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:03:26 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-36dac5d5da0so1937103a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1780905806; x=1781510606; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44S/gj/9pJInHpSvixTUMfN2DSYlfWjrpJ1QEaxU2+c=;
 b=jT+iilLAWPe/D9Ka66dB/vbKnCleVNuXvy2t0wLJ6Rd+x6Px7zjKF/VM9mYb/ruq5M
 +watqqlTk3yI3FJirS1CzSvvP1VX6JK6nl2U82uv2by+VAQG6LGYUCQcNylkuO2jQ9wP
 x6yu5bc5Uw95ke/pbh/7yYVXbBKT5T+9lJfF9jW7ghb8woOIOk4nTdvlzJvgaGD7g8Co
 N7zIDSN6cIH+DQHO/Vo7q2wYH2/Yd5g3ejw0uIxzBEAatgRuuT8/Q6l1JqfD9+mDTx6S
 rkvSroT0mJTu43zacgntvsgQGnrLMlcYhomGqOCbFIcjmUoepZzWZR0mXA0I/yK+n9u8
 NUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780905806; x=1781510606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=44S/gj/9pJInHpSvixTUMfN2DSYlfWjrpJ1QEaxU2+c=;
 b=e25M0gCu6gZKilV6HoeZdFtywe22gJWK6k589yxx7Vep1ZNHOvd4bGHF50Y/salpLZ
 u2Tnw0A81iYVUHCX/Cb9ukl29UCYGpkg1O4Ic1zm/dauDgR6Mtnh3OOCP9lzepVPn/wf
 8qVg1z/sIe4Ow6fPrJMBhfs1x7bySFKByFwZZItiPd3P47e9MWjst4SF18fBnKsx6oIw
 RH2Gdr7LhSlU2mn9bx0CX7CL3z6WXyZfURdxsFpiwVoOtUnisafxBSEBYsxToau4M/ys
 IMLcAnTcrTsjL8PYiV1A8W3hNBr2w8Msi0HuHZXlFptEOWnXV15njWWjMq/nmvQNrG5D
 EU5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Zri5t8yhRKbZYcfvvl4d4yndx7y0gxa7znEtaFvYlqdl/4PGeRUIq+jdzo/piEMl1lFjS6IyeGso=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzekPmNqFFYw0CQ7j55gy5qnf9qyxfzG1a9qE6dMEoJX/kKb7zk
 Z+vgLPqKcRZ52hhGNiMy4r6Y/u2Avzn1SjnE6HeDc3cgT6vRKqfuJj45xu8BF4CgBGk=
X-Gm-Gg: Acq92OGyIybbv9+d3HIrynZZwX9in2GwgYnPZ6ijAMeBiJ1/dfFRa6Sn+Z8/WNWutaY
 8JREgt3+Y8S6I4oDqu4KGYv/Hcd5mp9vYjhpA9+RkL5irKDI2SEVB36KURTcp5cBzUC1Ds73C3j
 Z1ose2hqEXBNhHcuGLDY+pZF+xK1o/khRd+E5tfvxEaYFF7KXMYbSmSjisF9rFHdinpCiapqJB1
 yBBXOGFjzq4YRoE1nEKC0ovi3IbeQIzmPT8sTDDBo49fFfJAdXnuPP+QBtOhILq0HQleyVc2Vj/
 x5SggyU78tlJPZmLHEulITq9r9XU6cTji/obHejhsXRxOtiSwsA6z/QGk4wf9e7vaX1p0lP8GtH
 IfRGHI2Da/omNKuUnzbJZaKWzcFVt3FaJrju1xVONgGpCZm+hLrUL5Ii2tfoRJgolIz31TdVACw
 eMu+uvcDQhoEZ3RgUCnN+cLpDXvTYTG0gBmyTeBvsxm6q1PBDhjF8cqors/Teq7iyh/3qBIxa54
 wl3d8BiJoNqilkFlNAjs4z2FscZhgu3u0kgxoYSv5JmEtQ=
X-Received: by 2002:a17:90b:2706:b0:36b:ad81:c134 with SMTP id
 98e67ed59e1d1-370ee928d34mr14895848a91.10.1780905805709; 
 Mon, 08 Jun 2026 01:03:25 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. (36-231-165-24.dynamic-ip.hinet.net.
 [36.231.165.24]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f68b03ef6sm15262168a91.0.2026.06.08.01.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 01:03:25 -0700 (PDT)
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
Subject: [PATCH v1 2/2] drm/panel-edp: Add BOE NV116WH2-M30, BOE NT116WHM-N21,
 BOE NV116FH1-M31, BOE NV116FH1-M30
Date: Mon,  8 Jun 2026 16:03:10 +0800
Message-Id: <20260608080310.15126-3-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608080310.15126-1-terry_hsiao@compal.corp-partner.google.com>
References: <20260608080310.15126-1-terry_hsiao@compal.corp-partner.google.com>
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

The raw EDIDs for each panel:

BOE NV116WH2-M30
00 ff ff ff ff ff ff 00 09 e5 6e 38 00 00 00 00
0a 24 01 04 95 1a 0e 78 03 0b 55 9a 5f 58 95 28
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 96 1d 56 c8 50 00 26 30 30 20
36 00 00 90 10 00 00 1a b9 13 56 c8 50 00 26 30
30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 40 ff 0a 3c 7d 0f 0c 17 7d 00 00 00 00 80

BOE NT116WHM-N21
00 ff ff ff ff ff ff 00 09 e5 79 38 00 00 00 00
08 24 01 04 95 1a 0e 78 03 3a d5 95 5c 58 94 29
24 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 38 1d 56 c8 50 00 1c 30 30 20
36 00 00 90 10 00 00 1a 7b 13 56 c8 50 00 1c 30
30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 40 ff 0a 3c 7d 0f 0c 17 7d 00 00 00 00 7a

BOE NV116FH1-M31
00 ff ff ff ff ff ff 00 09 e5 8b 38 01 ff 00 00
0c 24 01 04 a5 1a 0e 78 03 50 d5 9c 55 52 8f 27
15 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 9a 36 80 a0 70 38 28 40 30 20
35 00 00 90 10 00 00 1a 67 24 80 a0 70 38 28 40
30 20 35 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 36 ff 0a 3c 96 0f 0b 1a 96 00 00 00 01 cd

70 20 79 02 00 20 00 0c 9a 0e 00 8b 38 00 00 00
00 0c 1a 00 21 01 1d 03 0a a2 05 80 07 38 04 88
c2 39 55 1e 15 8f 7a 32 15 02 35 54 b0 5c b0 5c
00 36 12 78 22 00 14 ff 21 02 85 7f 07 9f 00 2f
00 1f 00 37 04 27 00 02 00 04 00 81 00 15 74 1a
00 00 03 00 28 3c 00 00 53 5a 53 5a 3c 00 00 00
00 00 00 2b 00 06 27 00 28 3b 00 00 2e 00 06 80
4b b0 5c b0 5c 00 00 00 00 00 00 00 00 00 89 90

BOE NV116FH1-M30
00 ff ff ff ff ff ff 00 09 e5 8c 38 01 ff 00 00
0c 24 01 04 a5 1a 0e 78 03 50 d5 9c 55 52 8f 27
15 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 9a 36 80 a0 70 38 28 40 30 20
35 00 00 90 10 00 00 1a 67 24 80 a0 70 38 28 40
30 20 35 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 36 ff 0a 3c 96 0f 0b 1a 96 00 00 00 01 cc

70 20 79 02 00 20 00 0c 9a 0e 00 8c 38 00 00 00
00 0c 1a 00 21 01 1d 03 0a a2 05 80 07 38 04 88
c2 39 55 1e 15 8f 7a 32 15 02 35 54 b0 5c b0 5c
00 36 12 78 22 00 14 ff 21 02 85 7f 07 9f 00 2f
00 1f 00 37 04 27 00 02 00 04 00 81 00 15 74 1a
00 00 03 00 28 3c 00 00 53 5a 53 5a 3c 00 00 00
00 00 00 2b 00 06 27 00 28 3b 00 00 2e 00 06 80
4b b0 5c b0 5c 00 00 00 00 00 00 00 00 00 88 90

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 44922896e743..42f5031c4382 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2039,6 +2039,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x386e, &delay_200_500_e80, "NV116WH2-M30"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x3879, &delay_200_500_e80, "NT116WHM-N21"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x388b, &delay_200_500_e80, "NV116FH1-M31"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x388c, &delay_200_500_e80, "NV116FH1-M30"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
-- 
2.34.1

