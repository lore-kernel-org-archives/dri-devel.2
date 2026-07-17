Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF6CC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3B710E48D;
	Fri, 17 Jul 2026 14:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PUXXfV0w";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A03210E48D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:51:26 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c15ba5b151dso613379566b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784299884; x=1784904684;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8AdUtRfzJF8aQtS4v5fF5lPXueRGdYBtCeyt7x5EaDI=;
 b=PUXXfV0wUDxxUHqzftwGC/qMjANnV4D/N0wC9AK60RlcIHhmFTjWqrOKLceurs0+hq
 HhJJIIZXdJuLvMOkUAaBDGvrXQhS/AhC2qFKHZuuT7T4JkyffmR9Vv8eC9QODVfkxmdr
 VNxJEjH1Qm3FHAq4/tN9woTVr1Nt9vB3cEcpFSEVPgOtyBhwDW9oYWCloSq67H7gWpcZ
 Qse+cfTgHLLi4x8drlMvJA6LW3nMgLr6qtB+JnrqY1zD5N6v6ICjACfVuYD4KEKQ35uN
 ImATQxBeeWxO9wnGZTZGjfMTT9R48/96I1w+MXUlvhA6o0sRI1RcL06xcc0qWWYA26+7
 GXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784299884; x=1784904684;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8AdUtRfzJF8aQtS4v5fF5lPXueRGdYBtCeyt7x5EaDI=;
 b=hACjfvHVdjr78jX1G+MqpygWuxPkKY6eye29Iq1Hv2fg0ELObQjjZWl0up4IyBMyUm
 C5QMiFNTcW5ZgG6iLdmnU3664/nemfMdAJPW5W7YZtVClXISKRCatEpLQnxs4Ks+sDk4
 axkcaUv1fduG2MDvtFOF991DqTwreQRxkk/fSIEd1tG4W/xxS2t74znCk8CLVfWeCDMk
 4AWhXDD5lrqFSHP5UaZUD5m9KvQDDFCFCN9IRYYMUXS5OlX5N/oDZFNFKpeVG2jvEOwT
 WUfNpSW0hKS30HHnWI3Ube8hn6XrYqvooNszoMzPdNrb6wYuK1de3qgfuvgrNugPsZgD
 AoLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU4HmnnFzXUBTaqsCe4F6fSxzt2mCjGVMiFt8jhVNfaFSdwtABJlLFc7TdU2hn8Vtbg0pU6TSf6Vw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFI23OV6+mVta1CCMXquzA9E4mW1gLEoEZEG4MzGvOU8YLef0X
 5/RtLjsZ0pux/vaJufAf4VvlYKP7qlj3Mz2NPHDNMa02W2U46egawiBQH2r2EEfRj7Y=
X-Gm-Gg: AfdE7cnG9it0k4pD6/a3ejqSx5gQ6rTsROZQquu4cVYQvf2YfaNf05mGHPt0X0zPmZT
 Lqfb+hYOscIbAHnHUCRhXEAcldWFdjjCbQKBDzbASRTHy0bS04BWvTjHWnpnCBO5noT+zpPDw2z
 Rf9izHovDqqTN+IpYJ1wEqcLm+xzGXSFedp9T8AxvPM7T9O9fvvhX5Yvqti6pPmQwRPz5PwKuOr
 C4L38xWhFH7os6NjNmOuRIxcFzqeGrXnqYZ8mr4wywXuoDO1QWkanJmKa4kVVhj/SaHV0GOKxbN
 v+ns4Ys754pvXMvqc0iyjFAvkUxETbNQk8xsHmGupN5KT2R3sTVQOxCbA+ZKZIdMaJmr9ayRTcb
 Qmkq3zk3vvE61UBmv3Jv7/IEoaQyKdV6PwGh4faS4KCDtHl4+S8LCrqTqYvx+svzQ4w4vJzvd1F
 guX9kBIkvQ0mprsQSwGcJv1R5AuyQgXx4nFI7qhFcarnyzDXCqpXbPYRCpPfxlmS4Cew==
X-Received: by 2002:a17:907:1b1f:b0:c15:c1fb:e8ca with SMTP id
 a640c23a62f3a-c16b4699441mr149267966b.12.1784299884353; 
 Fri, 17 Jul 2026 07:51:24 -0700 (PDT)
Received: from localhost
 (p200300f65f47db047d2d8b161e35ab77.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:7d2d:8b16:1e35:ab77])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-c1712a5f986sm89319766b.40.2026.07.17.07.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:51:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Frank Haverkamp <haver@linux.ibm.com>, Kees Cook <kees@kernel.org>,
 Eric Piel <eric.piel@tremplin-utc.net>,
 Akshay Gupta <Akshay.Gupta@amd.com>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 John Stultz <jstultz@google.com>,
 Romain Gantois <romain.gantois@bootlin.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Scott Branden <scott.branden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 =?utf-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Keng-Yu Lin <keng-yu.lin@hpe.com>,
 "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
 Vamsi Attunuru <vattunuru@marvell.com>, Alexander Graf <graf@amazon.com>,
 The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, linux-gpio@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 00/12] misc: Improvements around *_device_id defintions
Date: Fri, 17 Jul 2026 16:50:46 +0200
Message-ID: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4565;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=v6KGcwddb0l8IcWTqCRDb4zO+LUewoltHwDvvn+vphg=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqWkFG1z8C4NRHLFUNeuqopgHw00qW+nI9nFAsy
 Lfpc0JrQqqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalpBRgAKCRCPgPtYfRL+
 TgjPB/9mDiKAMUXV0wTB+CyNHbQLJZIEXYEmWQVuhH9QRBDgKl1H4iFu+J0C1cRYAMVVBXeWFKm
 bptw/U5yGNddrGZvPJIizrYRpjxAnbfRAeB11r9vDLxDKnILPO0Gvw8AZGCVsF0Y8eD40XySF0I
 4wW5eRLSjMmzGU85S2ppLQevXoWQJKNEG7yr3Iqo2otnw5M0yZi7bzrfo0svgyXHp0KRM4CSb0V
 17EyD29NvMnGBXwhZFUY2b6eghbBe8aTG7/1aR4zbNON8LPAmHRIFWIEMu0jgHftV26VB3u4Of1
 3S89MPmxjLcxL6oF/2/xjjiCEz0G0TxVyXHqaWkJMimv5c5w
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Hello,

the main motivation for this series are the patches that introduce named
initializers to these arrays. The reason I want these is that I plan to
make .driver_data a union, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for more details about this quest.

This series superseds a patch that only handled i2c_device_id, which is
available at
https://lore.kernel.org/all/20260515162734.469327-2-u.kleine-koenig@baylibre.com/.

Changes since then:

 - Also handle all the other *_device_id to ideally only have to bother
   about drivers/misc once for all the similar quests
 - split drivers/misc/eeprom in separate patches
 - rebased to yeserday's next

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (12):
  misc: Drop unused assignment of spi_device_id driver data
  misc/pvpanic: Drop unused assignment of acpi_device_id driver data
  misc: genwqe: Drop unused assignment of pci_device_id driver data
  misc: eeprom: Use named initializers for arrays of i2c_device_data
  misc: Use named initializers for arrays of i2c_device_data
  misc: Use named initializers for arrays of spi_device_data
  misc: mei: Use named initializers for acpi_device_id array
  misc: mei: Use named initializer for platform_device_id array
  misc: ibmvmc: Use named initializers for vio_device_id array
  misc: eeprom: idt_89hpesx: Unify style of of_device_id array
  misc: Unify style of of_device_id arrays
  misc: Unify code style for various *_device_id arrays

 drivers/misc/ad525x_dpot-i2c.c                |  52 ++---
 drivers/misc/ad525x_dpot-spi.c                |  58 ++---
 drivers/misc/amd-sbi/rmi-i2c.c                |   6 +-
 drivers/misc/apds9802als.c                    |   2 +-
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   2 +-
 drivers/misc/bh1770glc.c                      |   6 +-
 drivers/misc/cardreader/alcor_pci.c           |   2 +-
 drivers/misc/cb710/core.c                     |   5 +-
 drivers/misc/ds1682.c                         |   6 +-
 drivers/misc/eeprom/idt_89hpesx.c             | 202 +++++++++---------
 drivers/misc/eeprom/max6875.c                 |   2 +-
 drivers/misc/fastrpc.c                        |   6 +-
 drivers/misc/gehc-achc.c                      |   4 +-
 drivers/misc/genwqe/card_base.c               |  88 +++-----
 drivers/misc/hi6421v600-irq.c                 |   2 +-
 drivers/misc/hisi_hikey_usb.c                 |   2 +-
 drivers/misc/hmc6352.c                        |   2 +-
 drivers/misc/hpilo.c                          |   6 +-
 drivers/misc/ibmasm/module.c                  |   2 +-
 drivers/misc/ibmvmc.c                         |   4 +-
 drivers/misc/ics932s401.c                     |   2 +-
 drivers/misc/isl29003.c                       |   4 +-
 drivers/misc/isl29020.c                       |   2 +-
 drivers/misc/keba/lan9252.c                   |   4 +-
 drivers/misc/lattice-ecp3-config.c            |   4 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c        |   8 +-
 drivers/misc/lis3lv02d/lis3lv02d_spi.c        |   2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c |   2 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   |   4 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c |   4 +-
 drivers/misc/mei/pci-csc.c                    |   2 +-
 drivers/misc/mei/pci-me.c                     | 166 +++++++-------
 drivers/misc/mei/pci-txe.c                    |   6 +-
 drivers/misc/mei/platform-vsc.c               |   2 +-
 drivers/misc/mei/vsc-tp.c                     |  10 +-
 drivers/misc/mrvl_cn10k_dpi.c                 |   2 +-
 drivers/misc/nsm.c                            |   2 +-
 drivers/misc/ocxl/pci.c                       |   2 +-
 drivers/misc/open-dice.c                      |   2 +-
 drivers/misc/pci_endpoint_test.c              |  16 +-
 drivers/misc/phantom.c                        |   6 +-
 drivers/misc/pvpanic/pvpanic-mmio.c           |   8 +-
 drivers/misc/pvpanic/pvpanic-pci.c            |   4 +-
 drivers/misc/qcom-coincell.c                  |   4 +-
 drivers/misc/rp1/rp1_pci.c                    |   2 +-
 drivers/misc/sram.c                           |   2 +-
 drivers/misc/ti_fpc202.c                      |   2 +-
 drivers/misc/tsl2550.c                        |   2 +-
 drivers/misc/vcpu_stall_detector.c            |   4 +-
 drivers/misc/vmw_vmci/vmci_guest.c            |   4 +-
 50 files changed, 362 insertions(+), 381 deletions(-)


base-commit: 1a1757b76427f6201bfe0bf1bea9f7574f332a93
-- 
2.55.0.11.g153666a7d9bb

