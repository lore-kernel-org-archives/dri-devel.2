Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361AACD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CB410E1EC;
	Wed,  6 May 2026 17:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="vH2pYybw";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A036310E220
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:06:29 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c8027e876fcso1449907a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1778087189; x=1778691989; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kYzVxcp2GZP31p1UCN1NcXChbN0sEVGLqG/rT3K3gw=;
 b=vH2pYybw1S2T1OxO4BJw2ZuvhJKI2IpMGUN/Rn8Eqc7XHZY8tio1GW/5SQ+LHl2ToP
 3cOvzSDz+vYRsg/s0dAihSb6/kW8YtJaot9SsCESORb7KD37uC4w9Wn335XKW9FkyMMW
 pwuhsUsZmzeYTpig8tgVmg05yDkFXIfiIscDVwsn4w1QNefUFJ39XjgOW7yDhgiCeHIy
 59TBqeUmEPagTXGUdMtedGjm8JtZS8y0ADM4Keab789RtU/NEL913/n0oLMtuY5U7VkD
 3l6TFoZrij7DZVyD+OCSD4owlyUuKAGTBZCltZaie4pRO+JQBHhRYsoSnV7YbuVGOX8a
 ZGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087189; x=1778691989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5kYzVxcp2GZP31p1UCN1NcXChbN0sEVGLqG/rT3K3gw=;
 b=XeY7GHfMmsnc9kS8D/T09VCKnFOnxf74541c0rkiteq7A16lD7MSIgwzc/CHMFbfL8
 0wREX36zxrTcAru3vOMg0psv3nA+8kNrpxmQERYYiI7Z46Vw41RtJdqiRlr9bw+T4meh
 6MkjW315azsjDdcu+BcLlehhEidYfbRNKY0VZQT9CzriSa4p+PNCDPre3ytm7FCVavZG
 1J+IyCJoU0l9uR/NU1UO++HaYbSmv+lstKr/HamFChNFj/5BaqmRHasUFZPaFGgK3QYe
 et+EiVg3zJdd7w72pJIG9IJBlXRE+DUwRlHcxS0rgRYPo0cwcapNfkCThtmDxCmaGXSe
 6MeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KIP0JJ8kZEoT9H/PKqLvilzJ5PxqOWihutybxfEUa44ex7D40cztKz1jWUfbKN90QBQZMgm23TTo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIjHO3VrClTuBZq5PcsB4+Au8uBtgoSCavAr6H5sjG/RR9E6ye
 UH3fxWF64D+3q4OtEZuIvzoMOD1Mbsk2i6/Fn4Hpd6K1f/XHT3oRQusfUqDp1rknpNc=
X-Gm-Gg: AeBDieszpOlUpHGn0sQNAyw/qudJdVnRZgdgI9U7PT+Wzd+PkjbX8hy3iHChGw4mqf3
 nBY775cRZKEiSqOxCge+IKX964sYeXChogxa35klyFNOUkxroqCF3ZE6ye7HWeo4taN50tVm5Yi
 R6V+/0Tj+H4nRwc/Hatrc6FlfEISgqlYGvs2SJHrpWFiarCG2jiQw1457grTc9w8tTRQkL5c7yy
 Xij73HXIDuS1OK+UhGDIVb+A8H+Ry9YPGDaeL4mhT+fe75lQKDzpP5uuo9d6FMLKrkfPIEfTxcl
 p/oBERnt7Gw4hFOB/fNdf8enJkrUO2rB7WIlukt/xgCAC8zm/FecQ4LsbafYVU7pgu694AEQwsU
 Nw+9HKzBOz1KAZMhB1n4qHbfYsc3lzBE2nOTHBKJOv8HmoU+3Uf+ahICIskoBBOztHva2D+Lr8Z
 ygcnMyffcJ2R4opsjS/cOWiwRUWiciuK3F/aZ1d42+0YGx4ygfeu5dhy7EQ3c+1EO3zcB6Agveu
 ykACsmWGig=
X-Received: by 2002:a05:6a20:2587:b0:3a2:d68d:9e73 with SMTP id
 adf61e73a8af0-3aa5accad95mr4610731637.47.1778087189001; 
 Wed, 06 May 2026 10:06:29 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. ([150.116.253.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8242ab8bf4sm2649096a12.4.2026.05.06.10.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:06:28 -0700 (PDT)
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
Subject: [PATCH v1 1/4] drm/panel-edp: Add AUO B140XTN07.5, AUO B140HAK03.5,
 AUO B116XTN02.3, AUO B140XTK02.4, AUO B140HAN07.7
Date: Thu,  7 May 2026 01:06:04 +0800
Message-Id: <20260506170607.10813-2-terry_hsiao@compal.corp-partner.google.com>
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

The raw EDIDs for each panel:

AUO B140XTN07.5
00 ff ff ff ff ff ff 00 06 af 90 02 00 00 00 00
00 1e 01 04 95 1f 11 78 03 c0 d5 8f 56 58 93 29
20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ce 1d 56 e2 50 00 1e 30 26 16
36 00 35 ad 10 00 00 18 df 13 56 e2 50 00 1e 30
26 16 36 00 35 ad 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 48 0f 1b 7d 20 20 20 00 09

AUO B140HAK03.5
00 ff ff ff ff ff ff 00 06 af 9f 3c 00 00 00 00
00 1f 01 04 95 1f 11 78 03 f5 65 8f 55 5a 93 2a
1f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 b0 36 80 a0 70 38 24 40 10 10
3e 00 35 ae 10 00 00 18 75 24 80 a0 70 38 24 40
10 10 3e 00 35 ae 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 14 0e 1e 7d 20 20 20 01 02

70 20 79 02 00 22 00 14 df 22 02 84 7f 07 9f 00
0f 80 0f 00 37 04 23 00 02 00 0d 00 25 00 09 df
22 02 df 22 02 28 3c 80 81 00 10 72 1a 00 00 03
01 28 3c 00 00 60 50 60 50 3c 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 3f 90

AUO B116XTN02.3
00 ff ff ff ff ff ff 00 06 af ba 49 00 00 00 00
00 23 01 04 95 1a 0e 78 02 6b f5 91 55 54 91 27
22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ce 1d 56 e2 50 00 1e 30 26 16
36 00 00 90 10 00 00 18 df 13 56 e2 50 00 1e 30
26 16 36 00 00 90 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 50 05 18 7d 20 20 20 00 7f

AUO B140XTK02.4
00 ff ff ff ff ff ff 00 06 af a8 67 00 00 00 00
28 20 01 04 95 1f 11 78 03 c0 d5 8f 56 58 93 29
20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ce 1d 56 e2 50 00 1e 30 26 16
36 00 35 ad 10 00 00 18 df 13 56 e2 50 00 1e 30
26 16 36 00 35 ad 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 11 23 21 6e 20 20 20 00 8e

AUO B140HAN07.7
00 ff ff ff ff ff ff 00 06 af ad c7 00 00 00 00
21 21 01 04 a5 1f 11 78 03 fa 95 92 56 5a 92 2a
20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 56 37 80 bc 70 38 28 40 10 10
3e 00 35 ae 10 00 00 18 e4 24 80 bc 70 38 28 40
10 10 3e 00 35 ae 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 3c ff 0f 3c 96 23 10 28 96 20 20 20 01 66

70 20 79 02 00 22 00 14 5b 29 02 84 7f 07 bb 00
0f 80 0f 00 37 04 27 00 02 00 0d 00 25 01 09 5b
29 02 5b 29 02 28 3c 80 81 00 10 6f 1a 00 00 03
01 28 3c 00 00 8b 11 8b 11 3c 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 c0 90

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f3cdaea89b29..d883399bff3e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1918,6 +1918,7 @@ static const struct panel_delay delay_80_500_e50_d50 = {
  * Sort first by vendor, then by product ID.
  */
 static const struct edp_panel_entry edp_panels[] = {
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x0290, &delay_200_500_e50, "B140XTN07.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x04a4, &delay_200_500_e50, "B122UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x0ba4, &delay_200_500_e50, "B140QAX01.H"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x105c, &delay_200_500_e50, "B116XTN01.0"),
@@ -1934,17 +1935,20 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116XTN02.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x30ed, &delay_200_500_e50, "G156HAN03.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x3c9f, &delay_200_500_e50, "B140HAK03.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAN04.0"),
 	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0",
 			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x49ba, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x52b0, &delay_200_500_e50, "B116XAK02.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x643d, &delay_200_500_e50, "B140HAN06.4"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x67a8, &delay_200_500_e50, "B140XTK02.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
@@ -1954,6 +1958,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa7b3, &delay_200_500_e50, "B140UAN04.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xb7a9, &delay_200_500_e50, "B140HAK03.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc4b4, &delay_200_500_e50, "B116XAT04.1"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc7ad, &delay_200_500_e50, "B140HAN07.7"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc9a8, &delay_200_500_e50, "B140QAN08.H"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xcdba, &delay_200_500_e50, "B140UAX01.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
-- 
2.34.1

