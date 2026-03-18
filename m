Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED51FCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C0310E2EB;
	Wed, 18 Mar 2026 07:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BsbaqmYk";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F40B10E2EB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:34:00 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-486507134e4so17920555e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1773819239; x=1774424039;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pSUUSmmsogfaETb+4P0uT6nWdrd+bWZzxMlOvJd/ddk=;
 b=BsbaqmYkT0Wn7wAWRGduMSw+F1sz6WJMLMQq6oJ2PmsoJ6RLvSiS3PiJ6NzmfMqf9f
 KrYWXYTL8Z6K5LfKuD8fguDDrJj3IiI8EcqbASHVSowoVar4I1U8wGAZRhAi1mHA64Ms
 Wg64YAtgdTHLDeZM/XZ5b+hhOcwIyvbiTSvSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773819239; x=1774424039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSUUSmmsogfaETb+4P0uT6nWdrd+bWZzxMlOvJd/ddk=;
 b=SNo+rkxiTqYFHyc0hjj7cMsTtCd6tcqj1zjNmRC93cxDz88QI87iPAKKx8SU2vT1GU
 ipOX2CljyLvELHB/z/BGQ3TX9O/dT+Y4Arotqge5B5RbmPgAauAs3c010RobOKScyDR8
 pfjqhg5qU+qRKfUo89XRz1zib1WryfFnozxT1T3nGbFDWPYO9QIlF2aILRWgTtoMVlmZ
 c621wiYC2Ko9HhTqtTDPHMojwPDV78VDgVMIEPDAAQ3m8akrYCj06RhRMnEMItTt8wwt
 gm/wVyXcvkX7/VcMfFOzxUIbgAOh2BSyJtJFBRRJpWTGEzW3thRpcYCqqpjEvOP2oYRw
 I/Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe1aLuKL900D6jQ64TNgEOBuBaiXwU3Z1+pCUNmDG2W8uWxhIThn3v2DHqdAvWlrGCPK2FYb0bqL8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzhhsGGrZT0N5FNBcNND2j2uW5Ba7kIW6K553GgFaJmqeb6Uwf
 IHn0pq2IeiBEdFZ9/LnxGyeD17fiamBEfC7EKSAW76Ixq7Nyz9oQupkp3IHgviecTN4=
X-Gm-Gg: ATEYQzyv2RsQuN2V/YxEy917VSM32Gq9GLzKNORhYpQLGaLJpuJQzZcadsRYc2qvHDT
 OCCT5Wdf/XOcVy7o8Aueziz2uGb94nvYkzOzitEoP3ABrpKRKY5yK80CBD6Cs/ETy7zOvfV8nOb
 G9Lx1LewqiIqCYjeWtgYHH1frjZY5abH5+rHF5guXmrYjZuE6PAQFhYmms4ZUpNQe/3PE8ZpWGt
 67gnsVAilddhDLgBbgDQkdhStGgalG6R32xMIYbn+I4BSddnR0Tsu9e+mkSWOnv0TORQ6Du7P5P
 pSfxyuog8C1fQpuJatP6J7jEJnaqm5DrlkP56a0OrE8VEGf6AkQrGH+ujGiAfQfirPR8XpYOgsT
 jXsw0ar7FuASl3wDDTf1+hYX17R4Pxgh/cWTmxqV7gJ0KSeg+fCCwY08WUO0LYU0PwCNW+L27An
 sp4BooLmQyfmRk8+h74AC1Bw8tYamoba2ozC21/GMp8gcYzDqkJcunlqZdpBHUovYVii/c9YIBb
 4wDPsUQ6NUSocY1L5uSPEY/6XQ0+NtGtuxA8DnAx2CUykVS79fVUwargE4yikr3de8RmbaJB9h5
 WP0zwXF9HFsio8NQA+BOFw==
X-Received: by 2002:a05:600c:8518:b0:485:4328:407a with SMTP id
 5b1f17b1804b1-486f44435d3mr34511445e9.19.1773819238694; 
 Wed, 18 Mar 2026 00:33:58 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-97-160.retail.telecomitalia.it. [87.9.97.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f45f7e96sm25615765e9.0.2026.03.18.00.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 00:33:58 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v5 0/4] drm/panel: ilitek-ili9806e: add Rocktech
 RK050HR345-CT106A support
Date: Wed, 18 Mar 2026 08:32:49 +0100
Message-ID: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
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

This series extends the Ilitek ILI9806E panel driver to support the
Rocktech RK050HR345-CT106A model via SPI.

To achieve this, the current driver (previously restricted to DSI) is
refactored to support both DSI and SPI variants independently.

The series includes:
 - A refactoring of the existing driver and Kconfig to support
   multiple buses.
 - DT binding documentation for the Rocktech RK050HR345-CT106A.
 - The implementation of the SPI-based driver for the Rocktech panel.

Changes in v5:
- Add Reviewed-by tag of Neil Armstrong for patches:
  - 1/4 drm/panel: ilitek-ili9806e: rename to specific DSI driver
  - 2/4 drm/panel: ilitek-ili9806e: split core and DSI logic

Changes in v4:
- Fix "WARNING: unmet direct dependencies detected for
  DRM_PANEL_ILITEK_ILI9806E_CORE" reported by kernel test robot

Changes in v3:
- Add Reviewed-by tag of Rob Herring

Changes in v2:
- Introduce DRM_PANEL_ILITEK_ILI9806E_CORE hidden kconfig option.
- Split core and DSI logic.
- Restore vdd-supply as required for both DSI and SPI types in the
  dt-bindings.
- Dop useless settings in case of rocktech,rk050hr345-ct106a in the
  dt-bindings.

Dario Binacchi (4):
  drm/panel: ilitek-ili9806e: rename to specific DSI driver
  drm/panel: ilitek-ili9806e: split core and DSI logic
  dt-bindings: ili9806e: add Rocktech RK050HR345-CT106A display
  drm/panel: ilitek-ili9806e: add Rocktech RK050HR345-CT106A SPI panel

 .../display/panel/ilitek,ili9806e.yaml        |  38 ++-
 MAINTAINERS                                   |   3 +-
 drivers/gpu/drm/panel/Kconfig                 |  22 +-
 drivers/gpu/drm/panel/Makefile                |   4 +-
 .../drm/panel/panel-ilitek-ili9806e-core.c    | 134 ++++++++
 .../drm/panel/panel-ilitek-ili9806e-core.h    |  15 +
 ...ili9806e.c => panel-ilitek-ili9806e-dsi.c} | 153 +++------
 .../gpu/drm/panel/panel-ilitek-ili9806e-spi.c | 323 ++++++++++++++++++
 8 files changed, 576 insertions(+), 116 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h
 rename drivers/gpu/drm/panel/{panel-ilitek-ili9806e.c => panel-ilitek-ili9806e-dsi.c} (82%)
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c

-- 
2.43.0

base-commit: a989fde763f4f24209e4702f50a45be572340e68
