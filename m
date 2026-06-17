Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D4BCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3256910E989;
	Wed, 17 Jun 2026 10:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="HN8/p3Vo";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA5410E989
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:01:29 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2c132ac5ec2so55690795ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1781690489; x=1782295289; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l4eNR1/9Cfer+QiQ4ZHUlzdr0uRo1Bn/ldqEvLIcKeQ=;
 b=HN8/p3Vov+MVXxrEdZsY9v1MKILNx1ng+HnT0zG+IMhtu6RYnAveBagE2HTzTeO2T7
 DCiP/8vTtjNzfS8p4GVMCn4f0lefqfrNgX4C+/lCH+HET9WECoDbkC2sl8YZXvvKTzjv
 XaRAozmPwgfF+dI8llr22++jwwgVPpd0D8BkkY8x4nZcYYZ7MtWCKYqluuVnxikoVgik
 HC3lyp/vYmaGb/hYhFNOBNbqZWdrAD0UZ9gnn4+SIGUQZAgo6KBfNaFQmDqZ3g8qVXNy
 +ismEA6BCLVvfr2rhm3U8gZsEC+jgUJpSYjDwgD+tu7oU6xE3wXDADJXNnGhkA/C+O+I
 M2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690489; x=1782295289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4eNR1/9Cfer+QiQ4ZHUlzdr0uRo1Bn/ldqEvLIcKeQ=;
 b=Fv0MY8O95tNs13J/CCplqCjMxUcJk3Xg/KAwL6I+BmeHx/H3bOC+pTFDOd0IoK0/hH
 Q8mBDKgwP/cgJi/BUgt7TFT3B3wIjMi0jTFdYEDPDNAo8sxik6QddNmHn9cQMgvxCBZ3
 ziIkihQQC3xH3c6U/tB0G+9ZujPIs69tWXnKWa1BpksAE5urD137RV3FFpi1eGS+S4J4
 RB7gWvF6bwsU23rRy3AIp+LNY4SbYNod4jnG95ku0esLp6vKVsygT9ORZTSyFu7bfwTK
 7m1W5TiKGJehliuLH0uvEPnh/cx1V16NFhY/F+JTawIV+8FKC/FaUUNJApcyY/ErX6H1
 WReQ==
X-Gm-Message-State: AOJu0Yy6fN7OXUU1pP3e2sNlhKbvB02JBK7LAu9N3neecm6DMw2g/6xe
 DdBVQ5Fp3cLLlUYEu2txZM5ZjLWBw2dd6ksBRP5o/YpDEF9WwISIuA8FLaxHoEikvCByRtaLALM
 rBTbB3Zr9mA==
X-Gm-Gg: AfdE7clzYL3ZYFoOg1qQqMHE7+s0yYsBzp4NxEBLEawGaDkwi/k0FV+hhJKE8JHq1Vt
 Od+y6j6yqk/2XnD7xoli32b6xlYt8Rb0dkA9HVUVeZJXCVgRhCEfgu+t2lEzyfE2PQav5vwpsXO
 N108M2ZgaqgN/yTPr55DZBTv2h6Zz+44OP8ehGos6V778bLn2KZnf7KaY12timWh0x8oFcKrJyz
 7oVyeD/hVLqWUq/alDlL32T35WngV7rvtHJz8OmJa/IcJMlZS5E7Art7MRae4ffa3aJE6lWi106
 sr0j5fnkHeEPHi+vIKBcBdXbuv41hT0Cqm/xFkcttuUar16V//ZnnXaBeTmY5d+z5ArzLyEG//s
 23BFlJYiTDvO51FrbPB+y1UNDxlTtEqlKld3KY+WNAMQUZSxPWTcG7Fz6IYYp3DUj95XFVK7cA9
 Q+ibAQ8vtpaKnsYcjhT/8CuzFaTWHk8LRPEiK3/YM7M2Mcwv55L82+ogtS7OqYnu4=
X-Received: by 2002:a17:903:292:b0:2c1:f262:4962 with SMTP id
 d9443c01a7336-2c6bc22756emr31595795ad.20.1781690489323; 
 Wed, 17 Jun 2026 03:01:29 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([103.117.77.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432d8a039sm159438825ad.62.2026.06.17.03.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:01:29 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org, neil.armstrong@linaro.org,
 quic_jesszhan@quicinc.com, sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com,
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] Support new NV140FHM-N5B and TM156VDXP25 edp panel,
 the NV140FHM-N5B need 200ms delays from the backlight to valid data,
 100ms delays from backlight off to valid data,
 the TM156VDXP25 need 100ms delays from the backlight to valid data.
Date: Wed, 17 Jun 2026 18:01:20 +0800
Message-Id: <20260617100120.3426673-1-zhouhaikun5@huaqin.corp-partner.google.com>
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

NV140FHM-N5B raw edid:
00 ff ff ff ff ff ff 00 09 e5 98 0d 00 00 00 00
10 23 01 04 a5 1f 11 78 01 c8 d5 95 5d 59 94 29
23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 94 37 80 a0 70 38 3c 40 30 20
36 00 35 ae 10 00 00 1a 76 2c 80 a0 70 38 3c 40
30 20 36 00 35 ae 10 00 00 1a 00 00 00 fd 00 28
3c 44 44 0e 01 0a 20 20 20 20 20 20 00 00 00 fc
00 4e 56 31 34 30 46 48 4d 2d 4e 35 42 0a 01 87

70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
00 00 53 ff 53 ff 3c 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 90

TM156VDXP25 raw edid:
00 ff ff ff ff ff ff 00 51 a1 39 21 00 00 00 00
0d 24 01 04 a5 22 13 78 03 6e 95 99 5b 58 8d 28
21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 af 2b 80 a0 70 38 28 40 30 20
36 00 58 c2 10 00 00 1a 00 00 00 fd 00 28 3c 43
43 0e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 54 4d 31 35 36 56 44 58 50 32 35 0a 20 01 ef

70 20 79 02 00 21 00 1d 72 0d 90 07 80 07 38 04
80 95 69 5b 8d 95 8d 87 42 21 02 35 54 b0 5c b0
5c 00 42 12 78 22 00 14 ff 21 02 85 7f 07 9f 00
2f 00 1f 00 37 04 27 00 02 00 05 00 2b 00 0c 27
00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 e6 06
00 00 00 00 00 00 00 00 00 00 00 00 00 00 90 90

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 81e1866d54e78..3e6d8f17c3072 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2010,6 +2010,15 @@ static const struct panel_delay delay_80_500_e50_d50 = {
 	.disable = 50,
 };
 
+static const struct panel_delay delay_200_500_e50_po2e200_d100 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 50,
+	.powered_on_to_enable = 200,
+	.disable = 100,
+};
+
+
 #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
 { \
 	.ident = { \
@@ -2144,6 +2153,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d98, &delay_200_500_e50_po2e200_d100, "NV140FHM-N5B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
 
@@ -2250,6 +2260,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "TM140VDXP01-04"),
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "TL140VDMS03-01"),
+	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e50_d100, "TM156VDXP25"),
 
 	{ /* sentinal */ }
 };
-- 
2.34.1

