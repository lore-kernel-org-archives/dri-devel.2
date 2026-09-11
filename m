Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02F2C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E1810E9E4;
	Sun, 13 Sep 2026 20:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IyRpGBMI";
	dkim-atps=neutral
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6496810E40C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 20:33:55 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-97ccaa61510so533547241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789158834; x=1789763634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TNQAtUsfSHMHHKsvw6ndB+vrFH/q79ludt31IUIO6iA=;
 b=IyRpGBMIpz83b0gIExz6vrBFVEdLTjZjBh2tiGNnn9GI2xOs1voJuX1leYUoBwoP6T
 mCyJs9fc0mpTiU6N6oZeBGChnqhwbopak1fPfhPGk6oYLmkXLmYbTClE22pdD3TEWbOn
 P0LgqE7k8KupSuxhzzhrNyOiuWniAgIVdg25x21RSfJmHCKS/H4nxSIGhTkstF7xX9ep
 P7zT7Zi5geF77ez4mDJz3HTBmb7gKGG13tb3KjEr4mUD3WMSX6tkXeHHZfMFvjSG8GcL
 Ggfrd8sZm7FU/0x9Jl8ZQYDsuFUn4brpnHBV19GQCAShOtaXelfTJFWTiMjwfj5yy/z4
 40eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789158834; x=1789763634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TNQAtUsfSHMHHKsvw6ndB+vrFH/q79ludt31IUIO6iA=;
 b=MX1aWKK5wDRz4PLNKEvH/Pd2gPmfWAxsbvOrNFQDyjfrTJ20A0qOorLpkTgTEx7NYR
 klAglVjZCmrWhx6UsxcNhj5WbLZEtssQpFzD16fh0kskJuiKKNmofl17Tnz7gvKkJK92
 8VMMcONVL/K/94OOHK+Ib/SaMP1rJIpQBRssLqWCXoKybDN5yMHIOCxPANgEixrGgLZr
 /hP/DslSxI2WzZ4t2hl6ELZhMN4NlqkKXi0PBgnPZjZ4U4+iLzfxnowHrB4AMW0ER8ra
 ehLaK/rYSMLVflFieU5CdqP/37OfjM0KCkvzCmesvAvfO/rEMQEUHMmJDM33ONKXehOj
 P9PA==
X-Forwarded-Encrypted: i=1;
 AKwUvByNbYkeR0dnVo8mZbrcq4CVt4fXpkuJoysdBfPpOiKuVM99VPhT0rjcZsOTNnmYguby+4K0ujlgX4Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqKftH9yq79zCSFLh95V78zcdGkashRVFiNjpEMW3uWlRCfUzo
 W2kCxKBoLB9e7V2DOW7owtHrjia9gBmZxRVqlZIPS0oZUTG7okF6zOHp
X-Gm-Gg: AYBFou3cwn72Ft2udXxuhCXoOiqHTXfOjj5q0NxllvectPX+WTh7oNIEI0ZMEpsy3A2
 RgamzLwDhnFwIuYMaX2xGApbAvRnMMbOgpkxxW5QgzyfcQ2qzmJMI3kiiXzZhFYhVYMserJrTsr
 xNb2sxgi/XPfXxfUbifiZIcYTFtnMkLwiwa9h0q6n+/3inHcovHV7d5IvUl19iXSNfZYgFj99An
 S1zpK5v5OEg5g3fTk4OSt4b9x7rUe6vr/YYCTa19A/EcT3tDw6+ewguh6KRbxbnqi99xsJWs3b8
 uULTt+KkNe3aaaxWpAE82sC1HjDFwegEGdc1lqfoaaCFPhucrrICp27ofmPbV4jYkrp1WGl9V/z
 6JNbm2DP1fg37CL9aYlpk/htCflmkyhDoOt/qxx6aVQXs2YogSSFsOGdtGbxoCIMD9vD4xACuKb
 RZTz9lDxDCfQqYM5DeLLg0XXfqmm5I0Or8MUp4lWkuPbdZXwx7so+Q3Tk7L6K4uTOZ
X-Received: by 2002:a05:6122:6217:b0:5c8:46e3:ec57 with SMTP id
 71dfb90a1353d-5c846e3ed98mr10169733e0c.1.1789158834008; 
 Fri, 11 Sep 2026 13:33:54 -0700 (PDT)
Received: from frese.. ([189.60.169.129]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c8470e7ef4sm4187018e0c.9.2026.09.11.13.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:33:53 -0700 (PDT)
From: Enzo Frese <freseenzo@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Enzo Frese <freseenzo@gmail.com>
Subject: [PATCH v2] dt-bindings: display: panel: mipi-dbi-spi: add sitronix,
 st7789v-tft28
Date: Fri, 11 Sep 2026 17:33:42 -0300
Message-ID: <20260911203342.76692-1-freseenzo@gmail.com>
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

$ cat sitronix,st7789v-tft28.txt
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

$ mipi-dbi-cmd sitronix,st7789v-tft28.bin sitronix,st7789v-tft28.txt

Tested on a Raspberry Pi 4B using the panel-mipi-dbi driver.

[1]: https://github.com/notro/panel-mipi-dbi

Signed-off-by: Enzo Frese <freseenzo@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
index 6f0290c4e291..25c176b0098b 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
@@ -75,6 +75,7 @@ properties:
           - saef,sftc154b
           - sainsmart18
           - shineworld,lh133k
+          - sitronix,st7789v-tft28
       - const: panel-mipi-dbi-spi
 
   reg:
-- 
2.43.0

