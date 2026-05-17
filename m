Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F8ACD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 07:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB5110E02C;
	Sun, 17 May 2026 07:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jn5F76zy";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F3F10E02C
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 07:43:32 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so616022f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779003811; x=1779608611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kIN4QPzSpV0aaXXOpKphRYVC2gTnp619k6g01a8YFLQ=;
 b=jn5F76zyeMx7t9sCkKVx4X/F8Zm07vQnXy0QJ5njcw9/I0S/Iwcho/2RYSS/hKLCzi
 yBcCaK32yKiMABEeguI3d2lb10d2K32dZWalb2ldVOJNg+7kHdsH9RzvCQslRVSC5Wgi
 O8zu6tXeUYwjxOlZzwimD7CG0vnrQBHXExITuOxqBqENBcKu2ExK7DxUSD/ypcrETiRe
 Tz2OklmmcCriijfO2oT+VLZ63rNPxuELBoDLlxE/mgfJpU90a31fE7Ptug5DDqp9XROs
 Mc8BqpjdRkCDUJ81lROo+oFiABz5ragTTkHlt0IJMr5MBOMEXly4rSoajaawry4U0bxJ
 smDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779003811; x=1779608611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIN4QPzSpV0aaXXOpKphRYVC2gTnp619k6g01a8YFLQ=;
 b=b8pmjyfQe65KeRUFQeJfs8zpBUzbTG323FU+e4qcFIcuDEnwYiOVmi1COfmJZCSr9S
 DvGkm7FdEZObmxcZ9r74eHVVfMYizfAirzMrytPUolBLWlqcYGw7m24t7TF9f6TyV++U
 M0kJ5ZucUDfa5Xb0Ea7HE49T/CAipATTLvAmaDx8zOx7czzO4EGe1bjtfNUfrWFDgSJn
 oBIcK4ouRoTHg4tiIThu3CgJMrrMd4yCalCCpJ4fL7I3OLpz1la3pXWs/b4Zj2H7PvsL
 18HUr1nTegXID0c6IrxLroKwWDXXMvXSUKuEDEmRNYTxwZynuDcwWR07gxRpgDmRSTRZ
 S7eA==
X-Gm-Message-State: AOJu0YwEOlKFZcIMmTenvX1snF+GzrKlasIqhm7IVkvq3vyD8LsyMkPU
 mkWJ0GM7dAxWydM30TJY5nmuXYs8yeG4u9djYgoz8LWWZneAHsEZzW52
X-Gm-Gg: Acq92OG5D4sU6ZLhQbU8EGZr0assDNt1svOwjhrsec/f/5HTLv1ysLR4ngoLjzfKU/1
 ninN51IGgudIWEGzAAqDquuYlmT53hnBiO0KtmBs7bfQestjhYsylLY8PldvrqozteHUVmXiFAT
 xhuuRS5Lx7KFiO28uOGwwnaFt6ySLUOqxbzjL4eTdPz3GMJgxVo1/XM26JDX1PBqT6BNU5nKDoa
 y1rhEHx5h4Vw74GP4VPsAPoikfgbE+GULWCRafT9CuBMLNJZWAQ6r1dMMH+/U5OncNHYZX0NG/K
 R0j2HaoqCDP6iGFAJkqvwWqRHAspvaHXZqA3ky5HvQ4YWWZf1R5DWH/FZddAAdGVPEDm7nLUWxp
 3s3nBqKTUxwBXdrM0xsFukUbZiKdXfV8mCz2Y0cgxigIn+pbarx+wAuwWzNDmkPWI7wQWn05FsW
 D9zk3euJm7LLIx
X-Received: by 2002:a05:6000:2302:b0:44f:c886:89b4 with SMTP id
 ffacd0b85a97d-45e5c589d83mr15861004f8f.15.1779003810524; 
 Sun, 17 May 2026 00:43:30 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 00:43:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
Date: Sun, 17 May 2026 10:43:00 +0300
Message-ID: <20260517074306.30937-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Convert LM3533 to OF bindings, add missing VIN supply, add support for
setting mapping mode and LED sources based on device tree. 

Svyatoslav Ryhel (6):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: set DMA mask
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  66 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 190 ++++++++++++
 drivers/iio/light/lm3533-als.c                | 123 +++-----
 drivers/leds/leds-lm3533.c                    | 117 ++++++--
 drivers/mfd/lm3533-core.c                     | 281 +++++++-----------
 drivers/video/backlight/lm3533_bl.c           | 123 ++++++--
 include/linux/mfd/lm3533.h                    |  52 +---
 8 files changed, 660 insertions(+), 360 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.51.0

