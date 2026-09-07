Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51859C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81AB10E7C6;
	Mon,  7 Sep 2026 12:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JaoEjqC5";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E708910E7C6
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:29:12 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-66e63afda8fso2714288d50.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788784152; x=1789388952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7BAuZNiA5/uluN+xTnwX3MbZRNEexczkRLqDb6knuzk=;
 b=JaoEjqC5D0vL2bkL/VSVHAEofPL4JJukznKlCAx1rKQx5YXBeE34KFO0H/aG00hIlU
 XaO+5yL4BjGea+UeUzggKhAdydK0I6uilJyBH+/a8YdXaHg3mLPXnsqXaZKMO6t0V65o
 hhPmd1eWY1li/qj5bA2c51laPI8X1FVowqdMgQ9HYf9MyOBBweJnzXD0zKYQZzkaSr68
 g2T8HWid8CZL0e6HOwSaj/GbmKzBjIWHTpYcAVYlmpF0klCscQrjrisyK8H49u3TU1P3
 CgvsR90hOWtzgcXiRKoKIXAaWMQRS+1I+qi+xuOtmIHubSO4ktIaxCFfcssYsCa+TVK0
 YT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788784152; x=1789388952;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7BAuZNiA5/uluN+xTnwX3MbZRNEexczkRLqDb6knuzk=;
 b=Bg2F75Oed83yXELnAVJ6W+84gGjOMnvjYbD62AR6S+VcUBeu0tjmrgf2Y1q5FBQG1f
 HubJm2VXWO4HNfBSMrazXR37b5l25rZm2FvWUuB9r8JjeivMMG+Wq26qIGfvNJwcKv84
 7gHyWkq+pq/wcUOqRaFEXSpsGNY1PMObgPqelRT6mBaXnOhnCntdiBNaCExTHvtzOdr2
 NsLUuutPgLelxtKricyy+6dzOooXPpsmr+Vgsi1on4i61YG6o11tTm3e/RgRxOWFKpef
 urXVM8PZ3f19eqLn5SZL3CCZsb8hO+FcQs7j7tsLPivqmCg3fXW5EdTskBYgSSFG+2Nt
 0XIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTDgT02SnTKearkpMgiW+pc9xPNPwwVpg11hzqERiLHCsiQL0wUrHaAG74KJjE2QpIdDgKT19bryU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mLE9JWI+Ad0VV8mPbngVLvDO1fOLMJhzeqdAye+RhSWqSDO8Bn
 edAWkOkxmU+XkJv+UPn+DsriPMnlZg6bevyGLr0iELVHO2ZS20OJMVk=
X-Gm-Gg: AYBFou1ue8piSeZjJkiSd1ZerpwxWEZ1abUM6Rsyb8p9+vzCloIqZ7b+HH01hejXq88
 9sVsVryHWMcfl3nGOM4zct/GM+cV5EhdxwY1AwGZtyukS+it9mteKNRUvQTBCPBi6VCuUxeUDjJ
 6ITI7Rhpj6wnFMAUkdb6kRKPG1vFxbTxn566bIoK8LqQYWWj+T69AQvqShR6wLZJXQjyjv2wjP+
 fM2T5dzpq7DVEN3mIWfkPyKzOBHtzE6WnxYVpHCkx//PS8M2rfAXS6nqTLg/CZEgQ+6sze869+Q
 P1zGroZZuMparKH9JxKO0lOvaE9M8v3TUMHATPTSYhhQrVQGA65hMW7IsXzxPHO0ajv4rJsQiUN
 U0UuN0+OfThtmmkG/6xeTzndvfTbja3+5BAa3PJrf8Q9b6i/827ejImvOL/dPLZLQXVVdL0xT7f
 OA3438qEy9CzgP8BUK/MyyKhiOVvjAsDbevNwjQE5E0FO1iJ9YsGYcZwB/wS732TxMWQ3uFj7EF
 UvtZMx+lPJbR55gzVudfL7TVgWs9QTgVIo6RQRtrP2oasTY4g==
X-Received: by 2002:a05:690e:b4a:b0:668:9fa5:b9cc with SMTP id
 956f58d0204a3-66fc19c3cbcmr5343158d50.0.1788784151674; 
 Mon, 07 Sep 2026 05:29:11 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714bb0efc1sm70511967b3.45.2026.09.07.05.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:29:10 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v4 0/3] Add support for CH1115 Controller
Date: Mon,  7 Sep 2026 09:23:28 -0300
Message-ID: <cover.1788711082.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series add support for the CH1115 Controller [1].
It is a monochrome dot matrix OLED controller that supports several
interfaces such as SPI and I2C.

This driver only supports the I2C interface, but all common parts could
easily be put into a common file to be used with other interfaces.
I only have I2C to test with.

This is the first driver I write. The work is based on the driver
located at:
- drivers/gpu/drm/sitronix/st7571-i2c.c
- drivers/gpu/drm/sitronix/st7571.c

Tested with Raspberry Pi 3b+.

Changelog:

v4:
General:
  - Patch series based in kernel v7.3-rc1
Driver:
  - Fixed nits found by Christophe JAILLET.
  - Fixed max_width and max_height in modeset to avoid having bigger
  framebuffers than resolution.

v3: [5]
- General:
  - Patch series based in kernel v7.2
- In dt-bindings:
  - Removed "chipwealth,contrast" property (added backlight_device
    support in driver's code)
  - Renamed "chipwealth,invert" -> "chipwealth,inverted"
  - Added default value to "chipwealth,offset"
  - Removed 'status = "okay"' from example
  - Indented example with 4 spaces as stated in the documentation [4]
- In driver code:
  - Added support for backlight_device
  - Replaced drm_dev_unregister with drm_dev_unplug to cover the dt
    overlay unload case
  - Executing drm shutdown operations before turning off the display
  - Checking that the width (panel-timing.hactive) and height
    (panel-timing.vactive) parameters are greater than 0

v2: [3]
- General:
  - Patch series based in kernel v7.2
- In dt-bindings:
  - Fixed linter problems
  - Replaced first_page property with offset
- In driver code:
  - Fixed dst_pitch calculation
  - Renamed file from ch1115.c to ch1115-i2c.c
  - Support flip-vertical and flip-horizontal dt properties
  - Fixed several things found by sashiko-ai

v1: [2]

[1] https://datasheet4u.com/download/1576606/CH1115.html
[2] https://lore.kernel.org/all/cover.1786110720.git.nico.antinori.7@gmail.com/
[3] https://lore.kernel.org/all/cover.1787321297.git.nico.antinori.7@gmail.com/
[4] https://docs.kernel.org/devicetree/bindings/writing-schema.html#annotated-example-schema
[5] https://lore.kernel.org/all/cover.1787973729.git.nico.antinori.7@gmail.com/

Nicolás Antinori (3):
  dt-bindings: display: add Chipwealth CH1115 OLED Controller
  drm/ch1115: add support for Chipwealth CH1115 OLED controller
  MAINTAINERS: add entry for Chipwealth CH1115 OLED Controller

 .../bindings/display/chipwealth,ch1115.yaml   |  81 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/chipwealth/Kconfig            |  16 +
 drivers/gpu/drm/chipwealth/Makefile           |   3 +
 drivers/gpu/drm/chipwealth/ch1115-i2c.c       | 885 ++++++++++++++++++
 8 files changed, 995 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
 create mode 100644 drivers/gpu/drm/chipwealth/Kconfig
 create mode 100644 drivers/gpu/drm/chipwealth/Makefile
 create mode 100644 drivers/gpu/drm/chipwealth/ch1115-i2c.c

--
2.47.3

