Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9DBCD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 06:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A9E10E07A;
	Wed, 27 May 2026 06:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=reznichenko.net header.i=@reznichenko.net header.b="DrEGwVrt";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD37C10E07A
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:23:04 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so118312415ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 23:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1779862984; x=1780467784;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wp7cVAEXMj+4Rtt/nZVyY7sv93Gg+UwhM0RH5MslZVE=;
 b=DrEGwVrtKtvbvdEBD6xg/40Rg7RN5I6euB+g7SPSq/19y3Ofke9iZfvqhjJqJ7fjPP
 rWTpCut2aKEd1Waxuc1qNWHxD9wC6H0Z5M/wjIQT0sHgPKi7ZfPVl/ZrpUQkMFWZg4v5
 z/l4pVwo3IdpZVbhqBXx6KTAucHTz3YzBtx5cXEhRXihPiLoRWNcppduPmAIwV1eWBtI
 e/cdXQlemtLmmRWkG0ZmPSg2lJbPxNjH8Sydve0hTkTLKws7/HcrcvLKJ8mbCq3B5CAt
 ceMyB0rovWlaOelbxOETgtltON4M36xvCK+jed3JZspIVFYKlahBxihlPAE63rqZ2COA
 P5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779862984; x=1780467784;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wp7cVAEXMj+4Rtt/nZVyY7sv93Gg+UwhM0RH5MslZVE=;
 b=l+rQE3N2Xgez/hz6BTcak5SPFcTwmND/RMSN0hTrzmHAZ3n/fQrTV9OoIR/b2D2g4S
 WTRct8q3KlZuKqydW7+msOlNDHneXCa9ulOMoSfZjSw7jsYD9SnFlEBCd+oi3WatdlDP
 ZaC5N0uztiLKxrhAivqbCzxr1gDFjPymn9kny77NvZRm794NuhlL2uduDUyS+ZOpRBhv
 n24et/vTR8S4kt+9zNIqE1nVlIT0HjSvCprvCUZTTbFdYbLn87DrM2sQ4rH6GAS1tp25
 0rcXH2lb+ZQ6/4ZrYWecB6qyAhOqRnUw5D6uLHMs3pQZ9u/+1Zw85ULCxIROw3KnRDYp
 AJZA==
X-Gm-Message-State: AOJu0YwnirQCJduIWpjJ3qvfOEIisWpO9psz2kynCQBO3wYH4uxQ9lnS
 O5Kv6anSLMKMEUHNWxP7tyMte/UtHcUuLBpOCORSMLHpkgir6OMx62D+BlosI1FoJJA=
X-Gm-Gg: Acq92OEqXtjzfFFoCHT2bxywLUKbEHhNxNP3tZ4GuZ405luxTViUOg0znzCaU5Jl7jZ
 YnZHhQwwHuHrMNO058KshPEl2OsNtz4rjgS2uKJIkQDsjpNTj5L8Bo2nFdZEuvTAHqD1djvvP4k
 1W6nbNxgXfYfXiFANNQgcTez4aPP0KuLpop/xEWsyBklbkCZTTTu91zHOJk8OxNcn3Xn7s6HFpQ
 wW8T1pJXDUGhRtx61p8kZ4uJ0xSWw/+ZUV7MbMZeKf90XVGg4Lp/5cP917Z9naZ1tHwLqL0Gyot
 5fUDGEisb/w08N0bErkxxum63sn+h9EyzCTHDwmguhaNR/CI+rDar5Me3s7HFxPPGpsBfwmhlDP
 YavpAx78UCkwlSmVuHXeUcWiWhaVoFS5aNZgidCifGYJk/93H7dZ0uSkS2SOt8p+p8ilcCueCpf
 6w2SvQSObYAtD+dN4piC+ktHewWg==
X-Received: by 2002:a17:903:2f4f:b0:2b4:5f69:715d with SMTP id
 d9443c01a7336-2beb05d9d8emr247054355ad.25.1779862983821; 
 Tue, 26 May 2026 23:23:03 -0700 (PDT)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695f05sm182387205ad.6.2026.05.26.23.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 23:23:03 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>, "Kael D'Alcamo" <dev@kael-k.io>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] drm/panel: Add support for the FocusLCDs
 E35GH-I-MW800CB
Date: Tue, 26 May 2026 23:22:58 -0700
Message-ID: <20260527062300.88928-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
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

Add support for E35GH-I-MW800CB 320x480 MIPI DSI panel by FocusLCDs.
The panel uses Ilitek ILI9488 driver IC in DSI mode specifically.
ILI9488 also appears in DBI/SPI panels, but those require different bus drivers.

This is a resend of v3. Since v3, this panel driver has been tested on 
STM32MP157D-DK1 in addition to TI AM62P EVK. The panel works in video mode on 
both platforms. Additional panels using ILI9488 DSI can be added later 
with their own timings.

v4: Rebased
	Tested 7.1-rc5 on STM32MP157D-DK1
	Adjusted E35GH-I-MW800CB mode timing to a 14.4 MHz pixel clock with
	slightly increased blanking to make it more synthesizable across DSI hosts 
	
v3: Fixed missing Reviewed-by tag
    https://lore.kernel.org/all/20260204060114.345219-1-igor@reznichenko.net/
    
v2: Added comment explaining the "focuslcds" vendor prefix
	https://lore.kernel.org/all/20260203054121.335441-1-igor@reznichenko.net/
	
v1:
	https://lore.kernel.org/all/20260131034101.307486-1-igor@reznichenko.net/

Igor Reznichenko (2):
  dt-bindings: display: panel: Add Ilitek ILI9488 panel controller
  drm/panel: Add Ilitek ILI9488 controller driver

 .../display/panel/ilitek,ili9488.yaml         |  63 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c  | 299 ++++++++++++++++++
 6 files changed, 380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9488.c

-- 
2.43.0

