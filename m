Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407CBCD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A6510EA54;
	Wed, 17 Jun 2026 14:32:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=reznichenko.net header.i=@reznichenko.net header.b="hIOX/X+h";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAC910EA54
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:32:49 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2c6d4851142so2236915ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1781706769; x=1782311569;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SIB+sVIyO2GVi+Ekcv1ypmmhsYnRKgdWrBtHiIQd63c=;
 b=hIOX/X+ha8Oz8ZNaJCJ6njbjPgqMGrWHqRkvICJTufHdH0kvbtK24cj+7SK8urQU1b
 A8NBw7wc/uJGZT82QH3/aMkSJOMgs0ugV/0AcnQOzmIVaXT1S2/7zRN8djKQpAJfSJez
 CYVn9bl52BIvLp4VrGvnESdbohCyEKygGtEfgcq8PWFNVH6Gjp+MrXWNCLP4YnbL1WOF
 z9D5lRziZ2qMpVNSpG0BHYvtk9AMBOmpQqa/DOvVgcaLu7jfQ8Z/vDaypazajdElwYoP
 s2GiWh98cl4Mc3qDvFQVWGtXgIVzvxBMSW5+ulHb8ED9wF6ItYZ3sTe/Lc9fGG/Xrgcz
 CFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706769; x=1782311569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIB+sVIyO2GVi+Ekcv1ypmmhsYnRKgdWrBtHiIQd63c=;
 b=Z3edCllYjOQPofBF3JX44bL1sv6Wimcoe2QKsrH4fMGT59JGssMuywTYzt30z40xnM
 UbPnJ1L+1rEbWTSbng5ibgBSGhidNUOfNS/1A03OL4VPK1+JYpUmdq88rk5MLEb9aj3z
 Q4FjC1AQOk7GGGgxe8zmHBBgo8O1RqD4CcTVt/FxSqrBpfr3YeRZQB6mUfqSqptHkFFi
 EQdE8gMUKXZfvGPF9au4cqaZkPdyvN/Lk7BzD1apAcjAAS+939zEC+YHBDSOIqDcRmaF
 7XjAb/Fd+INUgHzFrpXaTdSXcY1uPJSrOEYfbWuOhsX2FzYQbTAA7oIquahzYycZDEEj
 fL4w==
X-Gm-Message-State: AOJu0YzE/TiezXEghce1UJWauizJ2hs51biZJHerUN6VjlPJH9PmDHWj
 QQnz4f1gfoEc3iWy8yLtNc7umPzOuohs20dbmKCO+vgaVMHdE7FymqNUN26KVtGLPS8=
X-Gm-Gg: Acq92OHbmOjlztNGsyQ6YLoMGB0Ph6otcbShv0O7tWUTyGPj5Q02uJmYO/s6/TByn8b
 C06MG+F2M1BBPHEtwm0/M/DhjR6Xc9SQ6hTAbWMgS4vKE1CZk5njN/4Ckf70poJHbrzw0X9xusB
 xi581LAw2q7kbqhBn+F8Yi00jcFE6/r5YZR98ti8E0ZY1C9dHhjALz8BMlumEA/Kv2cbgPvEaGX
 z76hrmBRqoDzlObIDqE/6EfOGpuNwIiifmfocfybswEiYksB5+RPOOuoGDNFqUPDP4sc0QAoy78
 it3VGGj70p+G+SWqlQGCfbAVJVaBkB7W2ylC5terPIR+kSxfV+Pv5P8+i8YMtunPvKy3zNRKGnH
 Qc5KInwmD08vjs9JJSijN3ylGW14tnsOAtwAJQrPI2lwfz1br0HGG+MABio4CkSR5JNHKGiSoMQ
 uoeaI5zCiRe7KzPIs=
X-Received: by 2002:a17:903:37c5:b0:2bf:1aa9:6c8a with SMTP id
 d9443c01a7336-2c6bcfd164bmr36575935ad.12.1781706769197; 
 Wed, 17 Jun 2026 07:32:49 -0700 (PDT)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327aca78sm176065565ad.54.2026.06.17.07.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:32:48 -0700 (PDT)
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
Subject: [PATCH v6 0/2] drm/panel: Add support for the FocusLCDs
 E35GH-I-MW800CB
Date: Wed, 17 Jun 2026 07:32:43 -0700
Message-ID: <20260617143245.372182-1-igor@reznichenko.net>
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

This panel driver has been tested on STM32MP157D-DK1 in addition to TI AM62P EVK.
The panel works in video mode on both platforms. Additional panels using 
ILI9488 DSI can be added later with their own timings.

v6: Rebased
	No functional changes

v5: Rebased
    Switched to devm_drm_panel_add() and devm_mipi_dsi_attach()
    Dropped not required anymore .remove callback
    Added display_info.bpc=6 initialization
    Changed 0x21 DCS command to send 0 arguments as per spec
    https://lore.kernel.org/all/20260529062836.203990-1-igor@reznichenko.net/	

v4: Rebased
    Tested 7.1-rc5 on STM32MP157D-DK1
    Adjusted E35GH-I-MW800CB mode timing to a 14.4 MHz pixel clock with
    slightly increased blanking to make it more synthesizable across DSI hosts 
    https://lore.kernel.org/all/20260527062300.88928-1-igor@reznichenko.net/
	
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
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c  | 289 ++++++++++++++++++
 6 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9488.c


base-commit: 4af021a977735420e8fe18d64bef18ad0608d981
-- 
2.43.0

