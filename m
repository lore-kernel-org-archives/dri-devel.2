Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68426CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE0E10F95D;
	Fri, 29 May 2026 06:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=reznichenko.net header.i=@reznichenko.net header.b="jGx8XE8a";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A90810F95D
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:28:39 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-36b8e1760ccso922928a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1780036119; x=1780640919;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vd2LNsjvev8hJ0X5803HfD2HDCwhY1MQFBDDV02YzaI=;
 b=jGx8XE8axeB84Aa4O/BV8pMv5Gd70gG9AHE3Qmd7C+yJDDyVdnFbOl8ZMRKHIR2vVJ
 deowmWX6rFL9HG+9QuOtmhL1oC8ZTLrp771tb/4cJQm1SnmtjN7SwG9lNoPTKIJfYiWt
 jOVqIp7/Nv9wIE84IGZu7F2J9pcEJMM9RJsHAZRTqze7K9BNqCZJ9EHy3dcSps/r1RXQ
 CEIsXcYgm6fwsy6rZAJIze/OXqzXh610hLepoit8nF22ajfqjASav2yz5Y5w//GUaRCU
 jYxb5LKO71mRVLwuOEZYAWFRF/UHiqkomHq9PRPsrm4hn6ch4XwZQtBV/dH/9XkwAknL
 WYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780036119; x=1780640919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vd2LNsjvev8hJ0X5803HfD2HDCwhY1MQFBDDV02YzaI=;
 b=QvUaEcAKiTVbdV1JIRlYq3mMxto7GbL9I423/C0B6kbQqaMOOjrzp1PZrLmdjEBuPW
 O5uLAzKuSh4yc19j5LqX29DzvuiO21g3gcldtLrOtBiDx44Q0ggSL4ZfrkD6s9UWyQry
 do3BLmhEPYmzcyc1MecaCub/FV0ZYC4v7SkmmpAhrjQWGLVz9A59MWupOmK2zln1S318
 Q0SjaRtsxMjc64B3JOT9Wa9PFPOfBNEZV3HpBOR8W/r6pV9vM5J5xzaGHcIVZnW4z8Yd
 SP+CJA6moP4UnC4++moaPhzvNZQsDydwqwJAhXrOMJuP7VLMN2LfJqJacOP2pinqisT2
 ntFw==
X-Gm-Message-State: AOJu0Yyr2E0wMP8zHZeJ3m1/aNaM4pdD3vyVjLsrmJBma40hppKq0N5n
 oxfdxusA6rbwDdDXCPer5rWH1PUXimBn3DCytbqgSoiGeEtyP+m+y3NduQ+1MF+QtmA=
X-Gm-Gg: Acq92OHJNrwzRsSUXjx3t2CzycFt4ddoNyZBnI6dKWnskDS7HR5LB0QSCaNOZ+/181I
 Fl5wDb4lLQN9/v1ULJLFxmpGrxC/X4lriqSPN0GGrtygePA9Kwj7jig4m9yKGPQXVPvL3Dv8gPU
 7LQ+l/Yx5VoHuIVK6PopSD8IB4Nr5M44uU1yff+74M9R+ww50bIRf5776fLERMwadhhVB0cNtK6
 /dpC6lt2n2XOVqwct2pOZhOCAW/tAJuuzaFZEsVWQQshbu47tnhEqIORN0TAZKV5yF58iuVpJBU
 fT6lyHxFc2A1xxKXFgYCQajLs1lPh1XRISTGKCZnq18BTFE+AL0WbAMznfOLEUU67FtDRDs6BJg
 hMR6Gb3KQb5DN40kdIhapambKzqMv1aHXuhgYIb6vKHjkmCPUQjX+Vz6Z4Rmj5Tn5G/SzqxQJ1J
 SNhFrXILlUNGNkYWkg8uX0Rh5krw==
X-Received: by 2002:a17:90a:d88e:b0:36a:d419:9940 with SMTP id
 98e67ed59e1d1-36bbd120f4bmr1912283a91.27.1780036118855; 
 Thu, 28 May 2026 23:28:38 -0700 (PDT)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bc6a340b7sm717087a91.11.2026.05.28.23.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 23:28:38 -0700 (PDT)
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
Subject: [PATCH v5 0/2] drm/panel: Add support for the FocusLCDs
 E35GH-I-MW800CB
Date: Thu, 28 May 2026 23:28:34 -0700
Message-ID: <20260529062836.203990-1-igor@reznichenko.net>
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

v5: Switched to devm_drm_panel_add() and devm_mipi_dsi_attach()
    Dropped not required anymore .remove callback
    Added display_info.bpc=6 initialization
    Changed 0x21 DCS command to send 0 arguments as per spec

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
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c  | 289 ++++++++++++++++++
 6 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9488.c

-- 
2.43.0

