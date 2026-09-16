Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E6CC88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBEB10ED02;
	Wed, 16 Sep 2026 18:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vjt9XJty";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E0A10ED02
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:01:22 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4ca696d43so177888a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789581682; x=1790186482; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zR4pKSFylW/FPLWgCmmFMf3xKUuXlJtRP0WK8xx/BHE=;
 b=Vjt9XJtydT9NQCR7qNaWUPlrjGXjW7tHvdXrKtp8kEstLLknil/Nn3uEORgJTUY7Wk
 HCdGjxcl+20dWxQPZfk6Ff9Oo3vZYUrL9ZzEl02LXOaSy3i1naLhOsatO4I6F94RDbq/
 JfWd8oaNNTKmemzYZFDdPeBhU3AwmHrYVuAFDuDZK6UCGj29FVvUsGYFs0w0jlc5Gt2a
 zYeR2bmXDGBFIE17tuwsUNiBCm3arpXSfrI6ImLR0Htho7FP8dTGrGrE5LO4uhSM3ntM
 PGgcEdEtq4HyXyw2agr5JaR52I2eey+p56csc0Ca4hIFMni121fU858o3VdIh463TguY
 jetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789581682; x=1790186482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zR4pKSFylW/FPLWgCmmFMf3xKUuXlJtRP0WK8xx/BHE=;
 b=0+Zz5BQ0fQBiUQ3r803X1f/FBl/rpUE3fj58ot2Ehb14+8WfaGXgqXyBEOSh3Z3Ccf
 TCbiWJJEhVszIoR2msiWTXhFcB6j6XNk/MfUWnCKuhEItobI51MsojqjrRz6P8h7LtJf
 Fnme9EyvqYgJV8oMWzEICyzVm+D4ePbNAbaqf2vs28AAMnCSQd0rVZSNS6qPPkmFhtSX
 sG6yDz4QESHji8bSmjMdJHDihbRcSP0basTyh4rg1EuwlZJdNsaE4mGT9D7YcAk3LcfY
 oWLLqy6fCOfrVjBiu5kk+oQuqI3l9Z9EjWVx1Splac1/tMYl3TqJKlU1QKq/obnJURiF
 mCIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZIyp4NZfX+lxIeYcsem8jc0Q24xHzmxHGkCrlNoO+WrfN2lM+H82M4GLE3dDqmiZwFOphjMQpl7o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkE8/LmDWInNZdaRlaw9llx+YkCss2Q4rXHE3EOMW5bATN4obQ
 4yA+ElIce/KWqysW1AxFZlgSn+OMLNnv7Dmpl4O7qGdzQax8iiY6ntCp
X-Gm-Gg: AYBFou3gjFx7nQWoMwA+iSTiBV//NOw8XIxT6fZZph8UcuCvgYkW+TYxPoqkIwlOVva
 3/d+oVVaNhwyZh7CJnZHgRSI9rQv5AGMyNcbiI7VT7XmwfVUHVoS4X8lWV16zrhJyBBKbz2disH
 x38/i1c/kXoVok3DJ/wsdmKrZadHn6aqgdnE1o+tFgRBxiBsowHkqYT34tZMB3SEWH2WAtys5eV
 wu5JWMve3vYW5FhcTm4jKa55SHkavrdizm31DB9UiwZefqJIp8qqPBBne9VJq5iPKPwkEYTwEds
 x2jEg+6ccUlvz66NRYrvZaCkcUs2d28sqRiv8exYNcWiv/fw89jDRXsXa21MMjECHrJlAUkCcnQ
 cY70UDfakbH2cgHwXGY3Rixg+Xk7Tm2d2faikoNzi8CalXbDE3J/d3RCixPtY+vpdqQcuq3T+ae
 LWGwnQIxprVJvlGGeFOJwAL94JduIiulh5ojMrAZo/bYrf73/0293u6wh9i6y1zQc7YKVK4DM=
X-Received: by 2002:a17:903:90e:b0:2dd:7671:3101 with SMTP id
 d9443c01a7336-2dd8e428bd1mr50842225ad.3.1789581682196; 
 Wed, 16 Sep 2026 11:01:22 -0700 (PDT)
Received: from marchy ([2402:1980:e96:7839:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89ee0cc9sm16195875ad.46.2026.09.16.11.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 11:01:21 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Azuddin <azuddinadam@gmail.com>
Subject: [PATCH 0/2] drm/tiny: Add RAiO RA8875 display controller driver
 support
Date: Thu, 17 Sep 2026 01:59:40 +0800
Message-ID: <20260916175942.3186804-1-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This series adds a new drm/tiny driver and matching dt-binding for the
RAiO RA8875 SPI display controller. An fbtft driver for this chip
currently exists at drivers/staging/fbtft/fb_ra8875.c, but fbtft is a
legacy fbdev-based staging driver, and nothing in mainline DRM
currently supports this controller.

This driver does not use drm_mipi_dbi. The RA8875 SPI protocol is
structurally incompatible with both Type C options drm_mipi_dbi supports.
Type C1 encodes command/data as a 9th bit within a 9-bit SPI word. The
RA8875 uses a full prefix byte (0x80 = command write, 0x00 = data write,
0x40 = data read, 0xC0 = status read) sent as a separate 8-bit transaction.
These are not the same thing and cannot be mapped to each other.

Type C3 models two transfer types via a D/CX GPIO. The RA8875 has four
transfer cycle types and no D/CX pin. More critically, the GRAM write path
is stateful: an MRWC register-address transaction followed by a streaming
pixel pump under a single CS assertion. I thought this may be too
complicated to cater towards, but please let me know if this is the
correct approach.

My ER-TFTM050-3 board has RST tied NC, and VDD is a fixed supply
set via an on-board solder jumper (3.3V/5V) rather than software-controllable,
so reset-gpios/vcc-supply are not implemented in either the driver or the binding.
I can add both as optional properties in v2 if reviewers know of RA8875 boards
that do need this.

Tested on a Raspberry Pi 3B connected over SPI to an East Rising
ER-TFTM050-3, a 5" 800x480 panel driven by the RA8875.

Ran fbtest (https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) against the
resulting framebuffer:
  ./fbtest -f /dev/fb1
  Using drawops cfb16 (16 bpp packed pixels)
  Available visuals:
    Monochrome
    Grayscale 32
    Truecolor 5:6:5:0
  Using visops truecolor
  Running all tests
  test001: PASSED
  test002: PASSED
  test003: PASSED
  test004: PASSED
  test005: PASSED
  test006: PASSED
  test008: PASSED
  test009: PASSED
  test010: PASSED
  Benchmarking... 10x10 squares: 74.24 Mpixels/s
  Benchmarking... 20x20 squares: 152.49 Mpixels/s
  Benchmarking... 50x50 squares: 334.09 Mpixels/s
  Benchmarking... 100x100 squares: 591.46 Mpixels/s
  Benchmarking... 200x200 squares: 999.49 Mpixels/s
  test012: PASSED
  Benchmarking... R5 circles: 45.90 Mpixels/s
  Benchmarking... R10 circles: 98.84 Mpixels/s
  Benchmarking... R25 circles: 236.37 Mpixels/s
  Benchmarking... R50 circles: 459.98 Mpixels/s
  Benchmarking... R100 circles: 851.43 Mpixels/s
  test013: PASSED

Adam Azuddin (2):
  dt-bindings: display: panel: Add RAiO RA8875 display controller
  drm/tiny: Add RAiO RA8875 display controller driver

 .../bindings/display/panel/raio,ra8875.yaml   |  66 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  13 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ra8875.c                 | 739 ++++++++++++++++++
 6 files changed, 827 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

-- 
2.55.0

