Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FC3C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382E210E2DA;
	Thu, 10 Sep 2026 16:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mB7+YWTv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012F810E2B7
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 16:28:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87ABB40F64;
 Thu, 10 Sep 2026 16:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C8A1F000FF;
 Thu, 10 Sep 2026 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789057728;
 bh=rq3v6IDpCKYvcZnfGrqUurfiS216mfdDk4RHW1732TE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mB7+YWTvTh5ZMcda+z4IaGizwwwsiLok1IBiaPGVIt6PFYVoyCqMqAkbOGsqDjtK4
 ra9m6kFPyyMWFiTFLAKy2EhYA6771OgGWMUe4FT4LiyhvYr83m1HJCjDa19U+YGvri
 cMrg1RdTuBdjb8HmGGkz9MPV9Vj5/oYK/BCtBDl5fO/u3fnbPnsZVfYPgNVbwFGT3H
 FSyMsi1O/sfyBcHyzhoymo17d6B9CB6Vglbmyq8Q5XRSI1BNxj65fDU4Kn91JpmEWJ
 N60xG0yhTqVkQU/97L+ErDfT/Wteg00jqgBQZ/5vZ2eR4ng/W3YYE44jPT4SzMNAWc
 FGCj1gX8XHsGQ==
Date: Thu, 10 Sep 2026 17:28:41 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, Backlight, IIO and LEDs due
 for the v7.4 merge window
Message-ID: <20260910162841.GL1051768@google.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
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

Enjoy!

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-backlight-iio-leds-v7.4

for you to fetch changes up to 0077e5ed836a01a0c82f23b91afdd38e42ace8b8:

  video: backlight: lm3533_bl: Implement backlight_scale property (2026-09-10 15:02:16 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Backlight, IIO and LEDs due for the v7.4 merge window

----------------------------------------------------------------
Svyatoslav Ryhel (13):
      dt-bindings: leds: Document TI LM3533 LED controller
      mfd: lm3533: Remove driver specific regmap wrappers
      mfd: lm3533: Remove extern from shared functions in the header
      mfd: lm3533: Pass only regmap and light sensor presence to child devices
      iio: light: lm3533-als: Remove redundant pdata helpers
      mfd: lm3533-core: Remove redundant pdata helpers
      mfd: lm3533: Use dev_groups in struct device_driver
      mfd: lm3533: Convert to use OF bindings
      mfd: lm3533: Add support for VIN power supply
      mfd: lm3533: Set DMA mask
      video: backlight: lm3533_bl: Improve logic of sysfs functions
      video: backlight: lm3533_bl: Set initial mapping mode from DT
      video: backlight: lm3533_bl: Implement backlight_scale property

 .../leds/backlight/ti,lm3533-backlight.yaml        |  69 ++++
 .../devicetree/bindings/leds/ti,lm3533-leds.yaml   |  67 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml        | 169 +++++++++
 drivers/iio/light/lm3533-als.c                     | 185 +++++-----
 drivers/leds/leds-lm3533.c                         | 121 +++----
 drivers/mfd/lm3533-core.c                          | 386 ++++++++-------------
 drivers/mfd/lm3533-ctrlbank.c                      |  33 +-
 drivers/video/backlight/lm3533_bl.c                | 188 +++++-----
 include/linux/mfd/lm3533.h                         |  77 +---
 9 files changed, 722 insertions(+), 573 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
Lee Jones
