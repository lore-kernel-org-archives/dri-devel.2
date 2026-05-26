Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B70BCD5BD2
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 09:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A1210E13F;
	Tue, 26 May 2026 09:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="impR7dqW";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0B710E13F
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 09:57:45 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so108524175ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779789465; x=1780394265; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gSOWa+WoGd25f9CoUvwpEs1bBTK5FG4rfD00vKZHrt4=;
 b=impR7dqW6u3xiCiggw0hidAkGAggaGAAWmkHJfdXf4uE1P3G7xTJY4b4BQQal9t7ZA
 bAD3C20Exbj3Mjzg3ImfAiYJHZOQ81tvhTR/cV547NqVzH8tcuApP2f80lqdScmd8/Zt
 xZV8DDSD7xi+wU4UfktbIVS8LJ9Q9VNCPYAQaLBO9UQn7Jgy75Yuy63NrdZAFkaUkI2I
 qTylEwnmrdURFu0GjToe+0nFg+vNnxa1Qi1jlGGfDxcLxU+7Lg7zG0pyfM6AvpW2h4v6
 D+4LylZzBOKR5wQ7DM7tVQGrEQ10LQhXpa394pv3/tHzqPIl4ZofP17qlGnEPZG9yay1
 W/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789465; x=1780394265;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSOWa+WoGd25f9CoUvwpEs1bBTK5FG4rfD00vKZHrt4=;
 b=n7zmtZLBN8K0pC0dQQmwiouY9PSXm6JddZBg92W7dRQIA8h6adFcjcu8c4eR7DLIjN
 8cBIzmJveYS58Y/rD7QtNDanrb4ZwYUbTr7xsLyE4Poq6aFSFEgZ52iDi3rgL6WJmHY9
 Z5lfAetKI/DrbSjemV1qj1Gk0k9TPqcdpvb7LDaUZJOpQiIrgDDNj5cnWXpzLtA8twCy
 4RYTaMfWpUnikfQmDJPaDs1fzyfI2GzM1dTxFyZJZsM1+ef32e//KcY7b+BwReO2Nm/x
 UV3yYAQSxPpx+X7lQri13Mz8/r9JMzgZAZof+LDchEbXcITXovP9eiz+Yzij19LgZcKS
 sMLA==
X-Gm-Message-State: AOJu0YyldSHMxIrBat3YBuKI9XHjy3rcVUDb3p29zLlp7YA8hij8bUgv
 Q05OeS5RUWlhfuAgCEfyCDcLnibtPiKfRAzZZdFatWRsrAkfmWqOcBEU
X-Gm-Gg: Acq92OHIVFaMDk3sfHrAXhgEZP0XR4z0LoMvtYk4XlJ2AB7mADisGBGGh2tTYKV0OIu
 eCXqLOPeOwhOw/TZNGbfj0HLPlM8APgvXw4cCoySQ8P/x23IzbAzJPCusbJxZWjrQJ+gJ2YOd6x
 FhchHJl/DobTGK4uq9nTSGi57MqRZyrmf0UW2L7xUA7tXunB7xswNLviU3QF9XuIyUWS814zwT7
 KzuCCpSNjZoOrsWlUIfnjNqAikSPDkafTlhcoYXxb/yBf0OIwlG92XRkS6Xoxug4CSBes3d0qkn
 r248YQpSC2qDD40pkemBrBpfrFuMjPd7213BnaPGWOBeibFZYErDHnvSn2VZUou8KTa6WQAuKiI
 ipEC2DncrUyU8aToGJ5bDeLsnuWvr3KeVSvP3DuE6+VmxvWc2LU+VH1PZHNNOeW92TD7dYC+2ox
 DgYhEZDz0Rjcg2+9Xy3TRBG686sD4eE7vj25g0xblwfa8iCpsW2e2JVWAphGsJl8pk4YPYbh0Qz
 UjF4QKrPTc=
X-Received: by 2002:a17:902:ce8e:b0:2b2:4f43:b48c with SMTP id
 d9443c01a7336-2beb0381369mr203545545ad.14.1779789464668; 
 Tue, 26 May 2026 02:57:44 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b2d47sm147055165ad.45.2026.05.26.02.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:57:43 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH v2 0/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Tue, 26 May 2026 17:57:15 +0800
Message-Id: <20260526-bar-v2-0-c66df9a840c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHtuFWoC/zWMywrDIBBFfyXMuhYfUbCr/kfIwtoxGWhi0SItw
 X+vFbo8l3vOARkTYYbLcEDCQpni3kCeBvCr2xdkdG8MkkvDNdfs5hLTUgXpVTBWWWjPZ8JA716
 Z5sYr5VdMnx4t4rf+fdP9IhhnQgqrR27CiOG6bI4eZx83mGutX0IBFuqWAAAA
X-Change-ID: 20260505-bar-523f2c3f6939
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779789463; l=1797;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=Kmq+0JLaZnUA+G7wcCq8VCK1JhVzlHRY2UTpbNvp+v0=;
 b=H20lFZ57zk7aLVD9tzw2j8UNuMfNWBa3MKA5sXBHiXJmdmFROxPxHaCPGx/w/yU34eWDDAUXZ
 pgYnO/HpbeIB5T8zuWr/aDgC+EEg/JnKGg4LLGiEJGXw+g1avjDnKhI
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

This patch series adds support for the Mayqueen Pixpaper 4.26
monochrome e-ink display panel, controlled via SPI.

The series includes:
- Device tree binding updates for the Pixpaper 4.26 panel
- A DRM tiny driver implementation for the Pixpaper 4.26 panel
- A MAINTAINERS update for the Pixpaper DRM drivers and binding

The panel supports 800x480 resolution with XRGB8888 framebuffer
input and uses SPI, along with GPIO lines for reset, busy, and
data/command control.

Tested on:
- Raspberry Pi 5 with Linux kernel 7.1.0-rc1

Feedback is welcome.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
Changes in v2:
- Explain why pixpaper-426m requires a distinct compatible string despite
  sharing the same SPI and GPIO properties with the existing Pixpaper panel.
- Drop the duplicated pixpaper-426m DT binding example.
- Update the binding description for multiple Pixpaper panels.
- Select DRM_GEM_SHMEM_HELPER instead of DRM_GEM_DMA_HELPER for the
  pixpaper-426m driver.
- Link to v1: https://lore.kernel.org/r/20260506-bar-v1-0-12195406f4ef@gmail.com

---
LiangCheng Wang (2):
      dt-bindings: display: mayqueen,pixpaper: add pixpaper-426m
      drm/tiny: add support for PIXPAPER 4.26 monochrome e-ink panel

 .../bindings/display/mayqueen,pixpaper.yaml        |  13 +-
 MAINTAINERS                                        |   3 +-
 drivers/gpu/drm/tiny/Kconfig                       |  16 +
 drivers/gpu/drm/tiny/Makefile                      |   1 +
 drivers/gpu/drm/tiny/pixpaper-426m.c               | 828 +++++++++++++++++++++
 5 files changed, 855 insertions(+), 6 deletions(-)
---
base-commit: a293ec25d59dd96309058c70df5a4dd0f889a1e4
change-id: 20260505-bar-523f2c3f6939

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>

