Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9001606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vZbOhsya
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1148710F988;
	Wed, 25 Nov 2026 02:13:02 +0000 (UTC)
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com
 [203.205.221.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7081F10F988
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795572773; bh=B6cY3g9M6aIJ1cOHnpA5JmgZ3gMhwaT/4SWTnG3huYU=;
 h=From:To:Cc:Subject:Date;
 b=vZbOhsyaXvhw+PSINZX4KEbrpA0Ri2AFGz/tZZZqU1xen9vkBhpqNy9SQ8ye4Tuj0
 fggD3CiXjZgQ1uNLow2/r3jHtw671ZQFoZFmlHt0wrnJgBYVWA8kJ35LUhbbcnTTEd
 kXtlAYhIi3wm6SaQy7aia4auHLhQSjXKelcQurKk=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 2DCBA053; Wed, 25 Nov 2026 10:11:28 +0800
X-QQ-mid: xmsmtpt1795572688tbgb0nvlx
Message-ID: <tencent_85512BC6F53EF0ACDCBECB09839EAA7ECD09@qq.com>
X-QQ-XMAILINFO: MUSna4nE7xDo7h/vIVXnez3VilgWE/NyqABZK3mjSII1tnhfZyz+kc0Wdtw701
 Cg/w/pPUKUJEIY+RaPLxAYpG4Wx4R2oWO3/IMJVAvyy59zWE/KCzMf/g393Ucgumo54+kcRKY/df
 rUSfZEjCa6jfKSajBFVDKblZL2psfNsAPCUS7hw66Ux4FeJNWy1SHqEM5wXLbXb8usFfcHIwQKPq
 gjCUyi4kOzHQ7Y/o66MbWnWdt4eJbhNMtVs6PPU1drpBQRMhmzmYChQyTwDHLU9n7O5V21Ht551V
 4RE+VubO7YuopeZDHV9ZeRTM5wu1YF7CRZh2tMAeJ2CdnT5GMa4FM1bEJ24Ezm6ngl2gscwc0dfz
 /H7FstMpZN5vnqwL5qe1riBpiq1X4fRcFjYLx5lEii8PkPpVqbZa05ArNtYbR8fKEhHIAoDYbs/N
 NucPK/o3LCpUpXgHzVl+bPb+Q4BtVO55MfOE5/hekIPjjjH8ssWqR/nTYhyCMkoK4awI1bPeUECu
 CvZrIcF+2j6W6sVYPkg5q0od+75wqC7vquwO+sB+iMU8H5k+7Dq/op35rMg89tUjnGpBDweogXry
 Sk2Wm+Th56BF29iCEm7BDacmkgL227dFqSS6o6SQQ1yz4IAqUvHHf9vthunh3U9O2ubx9u3d9/Fa
 7k1im/AXI9xNtd9CYF8B1Qw+30WsCfkPOGd2ZdN/whtwuD0FxEgTvuefbpsPlJjihjvY1RP4fAEJ
 2fbzERoeXItrGOLg0lXbQupqPVpDi0cjmK9gl0zdWKVtUkAOLfasvthUA0IOBtjBfRH9miHbhbew
 HDWDlPRJJNhqFc39YjBsa7HZQmf5xIM+ribgSXktvjM9jLehtt5yx2Urg3M8PFGVgFR8jgXNO3VF
 b/QJWZE6wZ8lYHl4+A6QqmvdfuRTLSV0/erzTm9xwPHeifr3ix2m2G93f6oGacfeDBNMFJGv5qlg
 oyk+X06cssSb1+R/RRIO8NQ1s7H1N4vQFhomRnlsIafkxl/rcgCPYwk+bhpc4xbJWS7n8AM8FTgV
 BM3OUyjPkGlVuwX+Vxg8TfJwOyMIfl1FjwgI7VtFQAYyCESlgJ/UzDPYsWGrNCUuKcqCo9N++Ey2
 fLF6TaK4i9HaYxziPkkXX342g0Q+Dgfw2HIechA4JLYEV8DvYH/qwQcXglYQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v3 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
Date: Wed, 25 Nov 2026 10:11:21 +0800
X-OQ-MSGID: <20261125021127.1430-1-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series adds support for the VIEWE 7KF82 7" 720x1280 in-cell MIPI-DSI
panel based on Jadard JD9365TX (2-lane video mode), plus the companion
I2C touchscreen and I2C backlight MCU used on the same FPC.

This is a different programming model from the existing JD9365DA driver
(panel-jadard-jd9365da-h3.c): page select uses 0xDE (not 0xE0), bring-up
uses 0xDF unlock, and lane config is via 0xCC rather than 0x80. The init
sequence and bindings are therefore kept separate.

Tested on Raspberry Pi 4 and Raspberry Pi 5 with a downstream dtoverlay
(not included here). A matching series is also under review for the
Raspberry Pi downstream kernel:
  https://github.com/raspberrypi/linux/pull/7633

Changes in v2:
- panel binding: drop data-lanes from the example; require iovcc-supply
- touch binding/driver: drop jadard,coord-addr; add vdd/iovcc supplies
- backlight: use module-specific compatible viewe,7kf82-backlight
- panel driver: drop per-command 1ms delays and pre-reset NOP; use
  mipi_dsi *_multi helpers; remove redundant enable()
- touch driver: accept only known chip IDs; drop duplicate backdoor enter
- backlight driver: drop unused wrapper struct

Changes in v3:
- drop an erroneous Co-authored-by trailer that was accidentally included
  in the v2 commit messages

Please review. Please prefer this v3 over v2.

Thanks,
Hefei

Hefei (6):
  dt-bindings: display: add VIEWE JD9365TX panel binding
  dt-bindings: input: add Jadard JD9365TX touchscreen binding
  dt-bindings: backlight: add VIEWE I2C backlight binding
  drm/panel: add VIEWE JD9365TX 7 inch DSI panel
  Input: add Jadard JD9365TX in-cell touchscreen driver
  backlight: add VIEWE I2C backlight driver

 .../display/panel/viewe,jd9365tx.yaml         |  70 ++++
 .../input/touchscreen/jadard,jd9365tx.yaml    |  64 +++
 .../leds/backlight/viewe,i2c-backlight.yaml   |  46 +++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c  | 353 +++++++++++++++++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/jadard_jd9365tx.c   | 373 ++++++++++++++++++
 drivers/video/backlight/Kconfig               |   7 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/viewe_bl_i2c.c        |  79 ++++
 12 files changed, 1018 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
 create mode 100644 drivers/input/touchscreen/jadard_jd9365tx.c
 create mode 100644 drivers/video/backlight/viewe_bl_i2c.c

-- 
2.55.0.windows.5


