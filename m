Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FBBC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB5F10ECE4;
	Tue, 22 Sep 2026 13:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="ZgG0K8Fb";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D292810ECE4
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:33:39 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso29023845e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790084018; x=1790688818; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C2Z6J0Xb+XGgk1d/nTkGyflldNnpf7sHk7JSW+3DTk4=;
 b=ZgG0K8Fbe6Trprg2fKC/61MIvSbrZrvy+fdgjOJTQnbvN+h7fGnDhQr02b7qKO8GU+
 v0ShR8e9341t5Cmlt54j+yC3gAicuU/ZFLaVcIsgSg4e+YkzouW5Dw9b2SphELoakNV6
 4DXZM5lDamYkM4IdCCm5k9UedjJXxJ9tJ8AJc4wzR4tTa70O7uF/T42lW0UlqWja+r1a
 Kxem5Vc72jZgWJUTYp2FknZhTDoVENn5mmQEAww46iXXxHb+tHv7plpRMoDKCEktEft3
 2KQjzUvHcVauTbttteP/5JFNmPefJbMe8y6PUB/YA8th878UDBj0K9ehVsg3q/BCRyHk
 /nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084018; x=1790688818;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C2Z6J0Xb+XGgk1d/nTkGyflldNnpf7sHk7JSW+3DTk4=;
 b=N6B5dBFVhNnZUD111R0MMXj94rKzkPiiNzpxJOFe5oLSYlFP6T6EyM31Z2TFMvZQyf
 aK84ylboyWJwZo9aco7niHwAGwQDFx5SyHVSSdc5mgucs4Bjy9vGWcDv7s6eXK0Oh13i
 /oUr3b7I6smjSk/kXn1WP3xcF0KY+AAw1VktJKaq4Xtnns33sBR9KE8uTtn58KjECFf5
 DpUg4BVg3/gLKIb7EZQgCW8/ZQERqnicuJp9fQuTGz9TveG+AgSP1qzF52VMmbUamOIb
 EWidqpkj1Zaw1Hov+AEALgMzvZPpLSdFFzrFzwCYQ9R+DKnLZQMAN25p+71V+sqdDBmX
 UtWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBm4BSE8KkASwZ8/v0IbpQvoRNAIsaUy/79dotVo7PM1pyhJrPssIByasfP+AUHKyED/j4K6+TJlE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mg0qdYiScTRgKT28Jij6+72K0xRlYQCUGD8VtC9447UftyPD8K
 xdCaa4hNnQCduVWFyOKPn6Xgfv4NZ/yt7cFFvkolH7dnPTh1oFSZGEO4Rn73R2JuCKs=
X-Gm-Gg: AYBFou1hd35ozb3C/gv4jxIGzTIClfMIJ2rk80zHkf5zWEcSeHRpzGzaq2wfVSddTUL
 /7/1NX922k+Cik8pkLybonJAHWbUlyv+mL+H0bTsPiDUs6RB3KAQwc8FHivjQjTX/lIPqC4pqFo
 bo4i4gByeo5oDoLHa8N5ILyz803+LX6Toxe7K06S+0Ho553+nxHH+FTBaEvWNytZvb8IAyqVlun
 Tb9pWa5T/yYr7aTwRaZ1L3ZrXLCiO1jrlFI3vl+e+8mcZj7KE2RQBBjWNW1kcLFc/dWihrxp8II
 5URfUp5mEm/nh7tOxPyTxhJmZh1+QrnMmyPAbjXi4rOCvtwOTNw2BEjJMO4EW1QNnI0aWLb/f4E
 8ljGRwtCBjvqIZqS2yt0IUHz4e0jjHyVGUp7Pxz5AiVS3eX1NtmW+uW7+s+OX24ZCxxajlDnDDG
 Ypya3lpzcil9Z1btuq+gsqOKXApaGtiVg6D6P862AenXoQageYC6OvjzpXo+v/XT9+If7JR7OZ4
 2bc7FubQRuHv44nzCL0Uhk/GQ29peVm7kTsyj7PPuin1I+dcDZ58lKZHo5HwOXAvVov4wo=
X-Received: by 2002:a05:600c:a085:b0:49d:25b0:cc60 with SMTP id
 5b1f17b1804b1-49fc5747f7bmr216383615e9.29.1790084018052; 
 Tue, 22 Sep 2026 06:33:38 -0700 (PDT)
Received: from zovi.suse.cz
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdace76e8sm70243845e9.1.2026.09.22.06.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:33:37 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rudolf Marek <r.marek@assembler.cz>,
 Andi Shyti <andi.shyti@kernel.org>, Chris Snook <chris.snook@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Remove obsolete __MODULE_STRING()
Date: Tue, 22 Sep 2026 15:32:20 +0200
Message-ID: <20260922-module-string-v1-0-c18766690185@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260919-module-string-d64816f203d9
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

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Replace the remaining uses of __MODULE_STRING() with __stringify() and
remove the macro.

Apologies for the wide distribution. Acked-bys are appreciated.

[1] https://git.kernel.org/tglx/history/c/136839a1b4

---
Petr Pavlu (3):
      watchdog: Replace __MODULE_STRING() with __stringify()
      drivers: Replace __MODULE_STRING() with __stringify()
      module: Remove obsolete __MODULE_STRING()

 drivers/comedi/comedi_fops.c                          |  5 +++--
 drivers/gpu/drm/drm_fb_helper.c                       |  3 ++-
 drivers/hwmon/fschmd.c                                |  3 ++-
 drivers/hwmon/nct7904.c                               |  5 +++--
 drivers/hwmon/sch56xx-common.c                        |  3 ++-
 drivers/hwmon/w83793.c                                |  5 +++--
 drivers/i2c/busses/i2c-kempld.c                       |  3 ++-
 drivers/net/ethernet/atheros/atl1e/atl1e_param.c      |  9 +++++----
 drivers/net/ethernet/atheros/atlx/atl1.c              |  3 ++-
 drivers/net/ethernet/atheros/atlx/atl2.c              | 11 ++++++-----
 drivers/net/ethernet/intel/e1000/e1000_param.c        | 15 ++++++++-------
 drivers/net/ethernet/intel/e1000e/param.c             | 16 ++++++----------
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c |  7 ++++---
 drivers/platform/cznic/turris-omnia-mcu-watchdog.c    |  3 ++-
 drivers/rtc/rtc-ds1374.c                              |  3 ++-
 drivers/thunderbolt/tb.c                              |  3 ++-
 drivers/thunderbolt/tunnel.c                          |  5 +++--
 drivers/tty/serial/8250/8250_platform.c               |  3 ++-
 drivers/usb/atm/speedtch.c                            | 15 ++++++++-------
 drivers/usb/atm/usbatm.c                              | 17 +++++++++--------
 drivers/watchdog/acquirewdt.c                         |  3 ++-
 drivers/watchdog/advantech_ec_wdt.c                   |  3 ++-
 drivers/watchdog/advantechwdt.c                       |  5 +++--
 drivers/watchdog/airoha_wdt.c                         |  5 +++--
 drivers/watchdog/alim1535_wdt.c                       |  5 +++--
 drivers/watchdog/alim7101_wdt.c                       |  5 +++--
 drivers/watchdog/arm_smc_wdt.c                        |  3 ++-
 drivers/watchdog/armada_37xx_wdt.c                    |  3 ++-
 drivers/watchdog/aspeed_wdt.c                         |  3 ++-
 drivers/watchdog/at91rm9200_wdt.c                     |  5 +++--
 drivers/watchdog/at91sam9_wdt.c                       |  5 +++--
 drivers/watchdog/atcwdt200_wdt.c                      |  5 +++--
 drivers/watchdog/ath79_wdt.c                          |  5 +++--
 drivers/watchdog/bcm2835_wdt.c                        |  3 ++-
 drivers/watchdog/bcm47xx_wdt.c                        |  5 +++--
 drivers/watchdog/bcm7038_wdt.c                        |  3 ++-
 drivers/watchdog/booke_wdt.c                          |  3 ++-
 drivers/watchdog/cadence_wdt.c                        |  5 +++--
 drivers/watchdog/cgbc_wdt.c                           |  7 ++++---
 drivers/watchdog/da9052_wdt.c                         |  5 +++--
 drivers/watchdog/da9055_wdt.c                         |  3 ++-
 drivers/watchdog/davinci_wdt.c                        |  5 +++--
 drivers/watchdog/db8500_wdt.c                         |  5 +++--
 drivers/watchdog/dw_wdt.c                             |  3 ++-
 drivers/watchdog/ebc-c384_wdt.c                       |  5 +++--
 drivers/watchdog/eurotechwdt.c                        |  3 ++-
 drivers/watchdog/exar_wdt.c                           |  5 +++--
 drivers/watchdog/f71808e_wdt.c                        |  9 +++++----
 drivers/watchdog/gef_wdt.c                            |  3 ++-
 drivers/watchdog/geodewdt.c                           |  5 +++--
 drivers/watchdog/gpio_wdt.c                           |  3 ++-
 drivers/watchdog/hpwdt.c                              |  3 ++-
 drivers/watchdog/i6300esb.c                           |  9 +++++----
 drivers/watchdog/iTCO_wdt.c                           |  5 +++--
 drivers/watchdog/ib700wdt.c                           |  5 +++--
 drivers/watchdog/ibmasr.c                             |  3 ++-
 drivers/watchdog/ie6xx_wdt.c                          |  5 +++--
 drivers/watchdog/imgpdc_wdt.c                         |  5 +++--
 drivers/watchdog/imx2_wdt.c                           |  5 +++--
 drivers/watchdog/imx7ulp_wdt.c                        |  3 ++-
 drivers/watchdog/imx_sc_wdt.c                         |  3 ++-
 drivers/watchdog/indydog.c                            |  3 ++-
 drivers/watchdog/intel_oc_wdt.c                       |  5 +++--
 drivers/watchdog/it87_wdt.c                           |  7 ++++---
 drivers/watchdog/jz4740_wdt.c                         |  7 ++++---
 drivers/watchdog/keembay_wdt.c                        |  5 +++--
 drivers/watchdog/kempld_wdt.c                         |  7 ++++---
 drivers/watchdog/lenovo_se10_wdt.c                    |  5 +++--
 drivers/watchdog/lenovo_se30_wdt.c                    |  5 +++--
 drivers/watchdog/lenovo_se30g2_se60_wdt.c             |  5 +++--
 drivers/watchdog/loongson1_wdt.c                      |  5 +++--
 drivers/watchdog/lpc18xx_wdt.c                        |  5 +++--
 drivers/watchdog/ma35d1_wdt.c                         |  3 ++-
 drivers/watchdog/max63xx_wdt.c                        |  7 ++++---
 drivers/watchdog/max77620_wdt.c                       |  3 ++-
 drivers/watchdog/mena21_wdt.c                         |  3 ++-
 drivers/watchdog/menf21bmc_wdt.c                      |  3 ++-
 drivers/watchdog/menz69_wdt.c                         |  3 ++-
 drivers/watchdog/meson_gxbb_wdt.c                     |  5 +++--
 drivers/watchdog/meson_wdt.c                          |  3 ++-
 drivers/watchdog/mixcomwd.c                           |  3 ++-
 drivers/watchdog/mpc8xxx_wdt.c                        |  5 +++--
 drivers/watchdog/mt7621_wdt.c                         |  3 ++-
 drivers/watchdog/mtk_wdt.c                            |  3 ++-
 drivers/watchdog/nct6694_wdt.c                        |  3 ++-
 drivers/watchdog/ni903x_wdt.c                         |  5 +++--
 drivers/watchdog/nic7018_wdt.c                        |  5 +++--
 drivers/watchdog/nv_tco.c                             |  5 +++--
 drivers/watchdog/octeon-wdt-main.c                    |  5 +++--
 drivers/watchdog/omap_wdt.c                           |  3 ++-
 drivers/watchdog/orion_wdt.c                          |  3 ++-
 drivers/watchdog/pc87413_wdt.c                        |  7 ++++---
 drivers/watchdog/pcwd.c                               |  5 +++--
 drivers/watchdog/pcwd_pci.c                           |  5 +++--
 drivers/watchdog/pcwd_usb.c                           |  5 +++--
 drivers/watchdog/pika_wdt.c                           |  5 +++--
 drivers/watchdog/pnx4008_wdt.c                        |  5 +++--
 drivers/watchdog/pseries-wdt.c                        |  7 ++++---
 drivers/watchdog/rc32434_wdt.c                        |  5 +++--
 drivers/watchdog/renesas_wdt.c                        |  3 ++-
 drivers/watchdog/rn5t618_wdt.c                        |  3 ++-
 drivers/watchdog/rt2880_wdt.c                         |  3 ++-
 drivers/watchdog/rti_wdt.c                            |  5 +++--
 drivers/watchdog/rzg2l_wdt.c                          |  3 ++-
 drivers/watchdog/rzv2h_wdt.c                          |  3 ++-
 drivers/watchdog/s32g_wdt.c                           |  5 +++--
 drivers/watchdog/s3c2410_wdt.c                        |  7 ++++---
 drivers/watchdog/sama5d4_wdt.c                        |  5 +++--
 drivers/watchdog/sbc60xxwdt.c                         |  5 +++--
 drivers/watchdog/sbc7240_wdt.c                        |  5 +++--
 drivers/watchdog/sbc8360.c                            |  3 ++-
 drivers/watchdog/sbc_epx_c3.c                         |  3 ++-
 drivers/watchdog/sbsa_gwdt.c                          |  5 +++--
 drivers/watchdog/sc1200wdt.c                          |  3 ++-
 drivers/watchdog/sch311x_wdt.c                        |  5 +++--
 drivers/watchdog/shwdt.c                              |  7 ++++---
 drivers/watchdog/simatic-ipc-wdt.c                    |  3 ++-
 drivers/watchdog/sl28cpld_wdt.c                       |  3 ++-
 drivers/watchdog/smsc37b787_wdt.c                     |  3 ++-
 drivers/watchdog/softdog.c                            |  5 +++--
 drivers/watchdog/sp5100_tco.c                         |  7 ++++---
 drivers/watchdog/starfive-wdt.c                       |  7 ++++---
 drivers/watchdog/stmp3xxx_rtc_wdt.c                   |  5 +++--
 drivers/watchdog/stpmic1_wdt.c                        |  3 ++-
 drivers/watchdog/sun4v_wdt.c                          |  5 +++--
 drivers/watchdog/sunplus_wdt.c                        |  3 ++-
 drivers/watchdog/sunxi_wdt.c                          |  3 ++-
 drivers/watchdog/tegra_wdt.c                          |  5 +++--
 drivers/watchdog/tqmx86_wdt.c                         |  3 ++-
 drivers/watchdog/ts4800_wdt.c                         |  3 ++-
 drivers/watchdog/twl4030_wdt.c                        |  3 ++-
 drivers/watchdog/txx9wdt.c                            |  7 ++++---
 drivers/watchdog/uniphier_wdt.c                       |  5 +++--
 drivers/watchdog/via_wdt.c                            |  5 +++--
 drivers/watchdog/visconti_wdt.c                       |  3 ++-
 drivers/watchdog/w83627hf_wdt.c                       |  5 +++--
 drivers/watchdog/w83877f_wdt.c                        |  5 +++--
 drivers/watchdog/w83977f_wdt.c                        |  5 +++--
 drivers/watchdog/wafer5823wdt.c                       |  5 +++--
 drivers/watchdog/watchdog_dev.c                       |  5 +++--
 drivers/watchdog/wdat_wdt.c                           |  5 +++--
 drivers/watchdog/wdt.c                                |  5 +++--
 drivers/watchdog/wdt977.c                             |  5 +++--
 drivers/watchdog/wdt_pci.c                            |  5 +++--
 drivers/watchdog/wm831x_wdt.c                         |  3 ++-
 drivers/watchdog/wm8350_wdt.c                         |  3 ++-
 drivers/watchdog/xen_wdt.c                            |  5 +++--
 drivers/watchdog/xilinx_wwdt.c                        |  5 +++--
 drivers/watchdog/ziirave_wdt.c                        |  3 ++-
 include/linux/module.h                                |  4 ----
 150 files changed, 428 insertions(+), 288 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260919-module-string-d64816f203d9
