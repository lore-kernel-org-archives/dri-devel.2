Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E652C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC0010E9BF;
	Sun, 13 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TP5d84dE";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E55410E09F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 20:19:39 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5c9649f1fcaso75836e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789157978; x=1789762778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g1w8AB8ju+xRNZIlH9cljncNnhc+gQt/Y6AH8/ZH7TA=;
 b=TP5d84dEQKMQLIlqmR+my4OqfjBuBCiL8pXOd05Oqb0x70zIhDYUiRQwyVbFThk7Cs
 Uw4WKvW/05wAxrBOi+GCi8yDSuoUQlufMP+Ps+6DW71GUYPoRRx2Gx9pTdFFVh+ILNBb
 dO+FyDXBA7ABXlVCbKFK49Y7dKUZnLupsKpREfXLPJBGqBSHRpnmct8c9UzE3wfIC1Q7
 e5R2mcDlTTEygjlJ3tPXeMPYh2rC9nkRdvA15Uh3lXcZkvhvmVQYHuPX6KI5h8P6B6QY
 AzJvKQCk6QQgtKzzqw4317kHd57Di/I5NLdWkiDHeol6Ks0jDdrbEgEWOu5XGxGvINTW
 kraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789157978; x=1789762778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g1w8AB8ju+xRNZIlH9cljncNnhc+gQt/Y6AH8/ZH7TA=;
 b=NmRW/5yEswJWcFujNrKIXspRmwl3qdaauvU7/0K6h8p6w/aE95ifLRIO3dFgB2WtHU
 BGtJ8CvXowo0Q8fBCqhnxz2Wsu7OhxCBMzV4WpoHiyP4MWZ2bE1EMjpT7kUgd3LVf6aX
 2LfzuzBo5PUnQYLFQ/0uUw8r68FfVsXkhzTEub3rm2x0ueAKlwYkyd1HjHnK9Z7P72lY
 gG3IFVSI9X0zuPNXX+8n8O7G/Fc05Ge+O0ycvrFu5HUgunuCCLTDYxA0klN/XhNXwv8F
 WmsKBY06f+vLdVC0Q9TvojqJLBjqxqM+3y88TzKny05q+7TOqc/bJ+RlIfOuY9tWgoez
 KwUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR4TgQiKwl2tXn4hYE0GjUAoufoKYNcje5FivP/z2lqr51oaSEwW6cI4Pr5HFGvcxSDh/rDPT9+HI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpIQJF9wBrBmySwWWSA1MP/tjIVvP4S/7DH072L1xvBvSl8EkJ
 kcX39WIxWZ9w51FvEfp2Vb7ooWj1w0IKKpXmoU+qK9z75Ti3vOk+RlNQ
X-Gm-Gg: AYBFou0T5tJu+crkEmVQwo8pJU13nbxiqx6bnY5MrlBSiYyztWE1X+5ZGS1lQXCiket
 ZfmVwnXojBlY1I0NnKWEztN4rokb3lUSf2Xmbv0tQFCudxBKgnpEo/yYIXvEPudHevMiwqwW8AT
 BcRN36ZIufwkxyCTcHL037+RS8qGR6KJKc/YGDzUXBWIpB35HrmIau0JxTCNJIiBxNbzBxPcDcC
 mSQ6D9EgKhXZ5fV0b6ptDmFx3xReJY59bTYjEDGYWMGWDj+DpPPwVBE+1Nsd567vA5gT351CArV
 I7Pu5H/XZKa2dE2zTfhEtuX8dsygPc/Dv2wXzTH8Ocs4UwAQ5/ZvDCHE4sANbAbpUigZ/c3eT/7
 dyfKDwRtIpZlJV3Jg3ilmmLzYT/44VCFUMNPFs8MUxC7FD6IvYT0Mo7p4L3T+zxsiNbBBzOjCdS
 K0wHLAv/XI8rv33LBCeqB4cXeZ3HKpZ3B4CnmTMoS9FaWV2Dh9gZc3rnrwTq0t1H8I
X-Received: by 2002:a05:6122:c8f:b0:5c8:2852:36cc with SMTP id
 71dfb90a1353d-5c846277c7dmr8968833e0c.4.1789157977995; 
 Fri, 11 Sep 2026 13:19:37 -0700 (PDT)
Received: from frese.. ([189.60.169.129]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c847153919sm4031544e0c.16.2026.09.11.13.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:19:37 -0700 (PDT)
From: Enzo Frese <freseenzo@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Enzo Frese <freseenzo@gmail.com>
Subject: [PATCH] dt-bindings: display: panel: mipi-dbi-spi: add st7789v-tft28
Date: Fri, 11 Sep 2026 17:19:20 -0300
Message-ID: <20260911201920.72734-1-freseenzo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

This is a generic 2.8" 240x320 RGB LCD panel with a MIPI DBI compatible
SPI interface, based on the Sitronix ST7789V controller. It is commonly
sold by various resellers without an identifiable original manufacturer
name printed on the PCB.

A basic mipi-dbi-cmd[1] script to get the display running looks like
this:

$ cat st7789v-tft28.txt
command 0x11
delay 120
command 0x3a 0x55
command 0xb2 0x05 0x05 0x00 0x33 0x33
command 0xb7 0x75
command 0xc2 0x01 0xff
command 0xc3 0x13
command 0xc4 0x20
command 0xbb 0x22
command 0xc5 0x20
command 0xd0 0xa4 0xa1
command 0xe0 0xd0 0x05 0x0a 0x09 0x08 0x05 0x2e 0x44 0x45 0x0f 0x17 0x16 0x2b 0x33
command 0xe1 0xd0 0x05 0x0a 0x09 0x08 0x05 0x2e 0x43 0x45 0x0f 0x16 0x16 0x2b 0x33
command 0x36 0x00
command 0x29
command 0x21

$ mipi-dbi-cmd st7789v-tft28.bin st7789v-tft28.txt

Tested on a Raspberry Pi 4B using the panel-mipi-dbi driver.

[1]: https://github.com/notro/panel-mipi-dbi

Signed-off-by: Enzo Frese <freseenzo@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
index 6f0290c4e291..c28659bd05dc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
@@ -75,6 +75,7 @@ properties:
           - saef,sftc154b
           - sainsmart18
           - shineworld,lh133k
+          - st7789v-tft28
       - const: panel-mipi-dbi-spi
 
   reg:
-- 
2.43.0

