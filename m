Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842F3CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED0B10F2CD;
	Thu, 30 Apr 2026 09:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q/p220mN";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4500310F2CD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:47:23 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so5323355e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777542442; x=1778147242; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vRjYmZEKAOcTK8eSw3z2UVlFOUwJtPih74xVLDcM6go=;
 b=q/p220mNbQb6kwz3k0zZWG+iuXpSDgxI/9Xtwj14FpB+ra9vtQh22Q/gGS+DEpYF9U
 uX8LglCaj0MYhDnJABmfY2yNtF5xuKT7C3aApKtFIGcQDN2rdVl0ymx/R6spD321tbhl
 88a7WhMAxvvNiuMUbQI82V8fZWbfWtetcuiVyiIQ5RiV8fYsma+zZE7Nf2tTmIFI/ru/
 lNP4Bsj6FjqF782cuiV+J/+CGlAGCnUi7URt9yk410flpjPI4DDtYvP1V8QAomXydhTw
 5UoZY9LDV77emQxJlSZym9s5LOukY2JWJXL0ad4f/hEl8eP9qk0iGxCdsoip9UEy43XL
 91+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542442; x=1778147242;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRjYmZEKAOcTK8eSw3z2UVlFOUwJtPih74xVLDcM6go=;
 b=HCW1OsiR88BHuRjqRvEOYV7UZOxXYRmDVxZfTUUqaR8ZhCoohlzyA43AxdmzYDFZ5K
 tCsB8q92VGnilYv159XgZk+vs+e62mmGoCalOfScehH9i9jBMnE4FDDWSdleQT7xK8Kl
 XMZQkH/qeZP7HXLsY+ps9eJ0PlWHZB762ASDrhFi8yTt1OjZJBm/1nYyqGfDqCE9bKuw
 MwLUpOnkOuQ5YSDzPcLzxdPOIm5g435qcLYxBfx2K6zYbi3nzc+WWtEEcGfMBvDgFdtv
 8lEFJN58CfMXkiaIxmEZmUmjYpEwm5+Iwam1UD1Qbr012O5nxe1NBAkMkh70RXI+t2z8
 0JEw==
X-Gm-Message-State: AOJu0YxzbTHDE/buLQjpJ8veasbYrly9S0Qf2rMr6rxXmU46HevXPSiN
 8Zrofl/cQxqM7WEmHuY5wACoFB/tZE2PdJAm65fgXjcE3dzlrzDQ9KE3XBrM2TfYff8=
X-Gm-Gg: AeBDiesxRK6SbMTcya/da1Nf/00rlr8v1VLm3JwCEYJ+eJUEIHgmyIMAnG+4Z+S4tYb
 XYukgEmYXxt4jA7v1Co5sbDzv/0QeMb6LDutypHvSP2QTrq96hWzdy9DMjqpvovXeHT+tf0XkQw
 JQkiav9Sa0EC+Cm2Q5WJPIwpH2ud+/tAMGzvjH4JRbtDISNokfY2ok2Euhh8t55D6Uk8A4tm1BI
 xTUFQqIh6z4irJoh0YgA0XEkdfvCGwwlsD5TsL2IkGzmIJhcNIlp+KQZj5jmeokpXO5E/Riz8e5
 eUS5l5v0Vo1vukkDEkg7xKsVb+VE3U/9Axmp50Zb5eY8YM/u7lp+JOGMmb0b5S9NPd10mRwDGE4
 IQfDQoLvUx27b6+C1UXK+PwHuYv+YJvpYaeKdj8oW0sxexXI8x06Mhmit4DZe20IsQZ1YqQflH1
 KXu0QjyuyH//uiredrcmWlEzpGVKKn9kMaw38zeBDcMj+Q4fitzhloNMY=
X-Received: by 2002:a05:600c:a312:b0:488:bfc3:efc with SMTP id
 5b1f17b1804b1-48a83d119a7mr27313465e9.0.1777542441736; 
 Thu, 30 Apr 2026 02:47:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b9493bsm48984745e9.0.2026.04.30.02.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:47:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
Date: Thu, 30 Apr 2026 11:47:14 +0200
Message-Id: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACIl82kC/5WOTQ6CMBBGr2K6dkwpFhpX3sOwKGWA8aclnUokh
 LsLeAKXL3n53jcLxkjI4nKYRcSRmIJfQR0PwvXWdwjUrCyUVIU8KwMpDOSAX6bQEuxkPQYYgnt
 gAlbAU1lqA7k0GWLZZqi0WKeGiC199syt+jG/6zu6tG1vRk+cQpz2H2O2eX8mxwwkSGdtg7pt6
 lxdn+RtDKcQO1Ety/IFCKGgpOsAAAA=
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sTmt6cdg1kP2+eYTeEKKnHTzDGESqLOto0bqSvNzmv4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8yUmoqUJMN6KNXMYggn4lvttmBXtPuV5E+4QafFy
 alS9YaSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafMlJgAKCRB33NvayMhJ0USJEA
 DLLfrV+XmHVTW0+P0QA9uwsYnnl//UlTxUS+XiiMlrgttbffXtd9m2HIhP7aWnLwK3BcGSNyvm8z3Q
 nbl4+8HkGfS/jsDRnCrHRT+cSvpBl0gLyaF7yarxlI4U2FlS8dcDyWEOD6306AXPrFcSnzxXYwNO2z
 J6HOROZkbBe2rsbTC7kTI9BsJq/vwizGsHzOnLEczfJp1bks34RE8PrAr/U/25d+09/jkXoU1DGXeZ
 8+i3NE4tV5P0+TXCWCHsBdPrvtJlGXFYG/4/nk9J1zNTISz/XXOwy8MIziBkv+wX4s6d5S6+M9aK9V
 oXFOBSScGN7N2/y54VcDJ/k6jI5z2KBkvoSFfwvLkQ8pbRBCCyLFnimrT+bLgT6RZyImrVrJi70MNI
 IEiCN1hGnAYbcsldxgw0oFbUr3swseraQKWequ5W0vGwVWJGC6ORpy7XdOyETiiqt9D1rrvrnPdEZq
 cTK/RAPZcoJbCtDuJw88xOXVxaa/2/xkDJFH5VBxAmVlALPZTKjXFFNjkXObuZqgfiO5bBHezjkFHm
 H6tN/NVPOfFIE8iXMOgMCHOIzbrdBlN2czkQ6FHmhRK++TAlvsr3HWr7s6v1+GnWABOzsQ16wYQ+u/
 A3a3Z7suvh4S3r8aqe3gaWm5HVEHtPNvPQ6IxtLBvVuR3WaASL2HSIbfJ5YQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed bindings subject and removed "|"
- Added review tag
- Added higher delay before reading ID from HW (100us was too short)
- Removed probe defer if i2c read fails
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org

---
KancyJoe (1):
      backlight: Add SY7758 6-channel High Efficiency LED Driver support

Neil Armstrong (1):
      dt-bindings: leds: backlight: document the SY7758 6-channel High Efficiency LED Driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  53 ++++
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 311 +++++++++++++++++++++
 4 files changed, 373 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

