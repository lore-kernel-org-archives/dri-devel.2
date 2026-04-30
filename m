Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B225FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 12:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D79E10E156;
	Thu, 30 Apr 2026 12:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IxJKOjDB";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723E810E156
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 12:22:23 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so774039f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777551742; x=1778156542; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RqyMbVlgU8cqot3Hcxn2iVprpaqj6ssogqlpcrZk9L8=;
 b=IxJKOjDBtOi2lZE2AtLS4OlvM+q9/fXNMO4xBG8aftOLA8KEbmgwVUseVlDUChTvgG
 RZnVH7BmmeYdpurkwrGg93f1SWhRfqWU9pwiWVkzqDPzzdO/8AqRn7iVJYCitkoZgLl2
 cYy7kFIaPxT0/9exax9FQu5vlC+MwdkeEm9+uRsDt67zVnxqEReddzPa/vSsYmainMvp
 j67wanKayLjCi1xGClNBU3uM3k3L16jAr9+aB1WrsEW+HTrme5ZSKGlNEHoFK/mQUx1Y
 sYrkMisDQA8QSdz8A2syGy8KlbjfxMi50PY1vcqUqqNn/Wflg6LPd0zezSJwcvDNUcm6
 tyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777551742; x=1778156542;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqyMbVlgU8cqot3Hcxn2iVprpaqj6ssogqlpcrZk9L8=;
 b=F7MI5czyRVpnbajgItOzPgSC3waBQOL3VHC6WCfad3O3mDPzzr3TgGBder951e0iCm
 UOwdzjWrPqpjySRkTJYo9uyu95Ga7MMwbiZdDp8AvRYh2zL7oQR80qTlvKmsctNJvkDd
 4mnlynhFFYL6MtFRqfV2q7bt+NGaog6pwBj6VC8Ek/Nm1UYW9t/YhlxmhmamwpgBZ4oz
 D5g/5XqBT0tEt4byQlxGcNDtwT1wmzvUXFimqVGNBHcbhZ0X3vVT8SjSA4IMnQ+LCKsm
 sPbeWFZz6PaRjWl9YMteLE9BINoSK7rxeR1YtX7lTcsNQf1SEX6MyWuJXjOUBck2mUdA
 qD6Q==
X-Gm-Message-State: AOJu0YzdD7+hABP8iTHCnmU6DOM/uagsM0DTyFyJCcdf1JJ4jkKjY8XQ
 mxa557/ALWW1myDSTcci4YdKxKPfNEtY8wO41q3/b7ZRM+Io9cds2ZROeEjb1KwZUyo=
X-Gm-Gg: AeBDieub0qYmt+hnavWIoEKs5t4Ae3TeTTmNiuUtTQ4jZ0Psz95upJWDc+tTc/2hbe6
 glLkqVyNS+gyVGcKnPWV8u4eM/GH+4+P3gE8wH3hMQUWFwLS9lUv4lN10h2qOfPlpgAP9P0OXwG
 LyqqmZzl0u6OTinBZp89T5RBqXr37orc/id+o85oHdf2MaBbzvZRLs1ntcMZ8cOKJgKSnbe3grs
 bYoi4tydclwbOZSESXs1qNpnfg5mRs15kvnby8+mr4JyoyU0nKn3/tDSmlkEb5VaklAm/8cq15D
 v9fIb4S50k6FWisNFUvFGCHTw3yes0epMLrUYZ4/12/xyveGLsF3ZyqsDH6S7mJEKSifbKGIlsE
 Rqp/mBiYC1lFtgkLUvOY1Q4IaWJqIHidvqk6AiL5xx7mifxgui0pCgEhDFnITDV8XgJm3sZhIZu
 rqrslTC3xZZcU4+l+bEwKFL1pTs1R9YF3o4YeT5TheNAEROrh7slo7v3M=
X-Received: by 2002:a05:6000:4284:b0:43d:71b:204b with SMTP id
 ffacd0b85a97d-4493ee4d3a7mr4784038f8f.39.1777551741675; 
 Thu, 30 Apr 2026 05:22:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5afesm11163639f8f.30.2026.04.30.05.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 05:22:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] drm: panel: support the R63419 based dual-DSI video
 mode Display Panels
Date: Thu, 30 Apr 2026 14:22:16 +0200
Message-Id: <20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-0-91ac10453d0c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHhJ82kC/5WOTQ6DIBSEr9Kw7muAKmpXvUfjAvGprz9ggJoa4
 92L9gRNZvMlk29mYQE9YWCXw8I8ThTI2QTyeGBm0LZHoDYxk1wqnskSohvJQHiVKuegZ23Rwej
 MAyMECV6dM1EBFjJTBcq24R1LqtFjR5995lb/OLybO5q4ubfGQCE6P+8/JrH1/pycBHCoSoFNr
 lNycX2S1d6dnO9Zva7rF5hfThnrAAAA
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DBmrIk2P2SCzJFS2zeYznzHxjTl1f4Qtg2F+1FDx08E=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp80l6ioUpRGgLOhdWf2OCm1AyXBCyDPSG01l5c3KS
 r3zvDKyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafNJegAKCRB33NvayMhJ0cLxD/
 9RN6EGHKiC0AXQMAK1thshpNMvYkLrE0lx2nhe1Ypeu/R0j4RFaWQUm4BhTodQUFgO43U1tUZc3GaS
 8ECanj75MWHPY/+ho1PT6uPS0DYLSL8PRC+Pn0REu60sucxglAgJmq35A0vecK0AFVhcT4Fhg0Lf4W
 5Nsw9Yi61yZxhEt9toNrnXw0bU2vuC3jyzgp+7+HGj4j4ORgEvT9PO44uMWPuOzdFYBlIiSGVqRyPp
 umnMF8HEzTgkNPfHgjdvmLS3nUziOkhyuadXOAlE23vsbOTdGBog+WEY4+fGhHRsFjVAtVIt2gnihq
 bLr31XGSkZAAww4/Osvqv+OIBh6G5k6b0z/OjU3H8KN6VZBe5bCTfm4x/U/19uz3snM+AGTPvWTsTd
 Qdl1mnq1g/gRp49rZxX/5tQGE7baztD4iyNJvf1REda7VBqiMj9IbEk6Gy3iJte1O3iaRL4VSR7uJC
 iBI0NYeUPVYW+3EQSCKbkvFVuTNevlW5Q/V1eC0bBytOcdXGX/f8/Bnzm9f09zlAihlsHGF72diLQj
 RjGO7uJ5Upe0ejKHbIJ3VVqdaXbOPp/fWuqlonRkAstRC56yo4hcdlwtopCdPInTw/J5m4JSSJ98S1
 Ox9ShYGeSN0lHfP1gXg4ddqfzfH45c9jmJnYE1GoPGMTLvEubp2hIXoBuGHw==
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

Add support for the Renesas 63419 based dual-DSI video mode
Display Panels found in the Ayaneo gaming handled devices.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Add missing rotation property into bindings
- Fix commit message & subject typos
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-0-981eb5ab5a51@linaro.org

---
KancyJoe (1):
      drm: panel: add support for the Renesas R63419 based dual-DSI video mode Display Panels

Neil Armstrong (1):
      dt-bindings: regulator: document the Renesas R63419 based dual-DSI video mode Display Panels

 .../bindings/display/panel/renesas,r63419.yaml     |  93 ++++++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-renesas-r63419.c       | 356 +++++++++++++++++++++
 4 files changed, 462 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

