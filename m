Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507E1CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D88010E508;
	Fri,  2 Oct 2026 08:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="QE2Fp7wS";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B42E10E508
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:32:22 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff9621c5dso46616805e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790929941; x=1791534741; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
 b=QE2Fp7wSyzfKkO7b6YkCW6eyFCHZAG4Vydm5lGG25PRSBX5P2IxNOehvnRbX8or4Pn
 whS+oRfX8bMRsGi/BbXA+7KXaNUyeMiH6B2ueSm6okVLttD4GXjmlKXCH6lVHdIj4RpA
 YVMmqjuoJIMyCWPnCJGdn8aACNd5LiQTjJz30uUeeC8Wy5XJ8bYU8BbjivN+0KfgMi7R
 gkluzJrNtJCRUsepcQAR4E1NSyzD+4CpngnvIe/VAbJ31gor5XeJfFZd2rWmUne4+tKX
 BYU2iNekWpkdgkDaSsDDiTCfqw5Y53RsN31g2/59XUvUSFMIp8cy1b6ke8GH5hYoYEtg
 CiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790929941; x=1791534741;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
 b=BawoducQH2nNnfuU328obw9Rvj4hcmTwyaqInW17IPQv6nM0NmfwO0hEPujgHOXvnF
 0Ta7CvwzPcfjmvNV2qMo1RHluNDNqaEJDnsfpt9g9J92HZOTNXBR3x9wSOtPx88wMDsn
 HaFDgetuR2DqORk0mTPmL4iHxkJqb5VoJmv4QZ4+6mSwqxwjYrpMJ7T8IUJiuWOxIbU6
 7K/jMhjY/KX63qfcq82vuZeYmgMQOwPFQHI+i3qIXvQ/8FGcBkGxqLcMMzervftO02c2
 DRo0Xfml3f3rPLGvU+hYepEVIBkkj8vbgu5vKHQd8XbvApvnulOMHLBmv5c0X5SZJwiw
 KSPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOJuEthCzhmouii7RJqOq/s96F+XAI17/FWGOxr2OEWM60nN8Zomak5tbTrn10rmk/GnPQ4ongqa0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nv2HZ2uxV+8XCEzxdia5y88mu9cVerA12N9fFMxRxClMKha3AZ
 oDbKj7eQt+CBnZEitHddhc+FTjQfwVkBbTSK4HMLcegiHywsmYA2eAEKG+YqmlUOPEo=
X-Gm-Gg: AYBFou05yoieAi6uhfyjMLucWIRhVtToVJ7sClxdqbwb9ufj64uonBUTswMa8Gf4gtZ
 QqSGAfPApjlkG7k1KYj8s90YZSuRkEOGxfxDItQEqRNsmb70sg6noDKoUm3Azny6imVHzjGOIwr
 IS3bPt3ScztMhqFkT3SY6ZTTaDjGu8SuXWn07EnAWtwim036p49hfi7lKib+mAXy1XC3LbnodlE
 R5Coc28brBtQDNkkA2jLLd+V7TMyhjOIy05IiNIUwFl5TFoiYBuDazaNLvELpFdhi9aVcUNL7uu
 xh8lIN9QsrzM8qveRhDqcpfiFfqNa+sORHeci76BxTv/iUILgQlI3sTkXxliAiQOWDhGWgywLZd
 tVP18gD89U4Z2b+nhLaBe7eNiM10UPzHvUd3XftND7Yh5xBKp+FuCbSeD1mfWnnevVNQHKmQodL
 giBSThMNgeFcBSdPn78PoAn+A0zMU3ofF6A9J8p6xJM/+pKQeHSxiRlEp5iP27oR4Yxg==
X-Received: by 2002:a05:600c:4e41:b0:49c:e27c:6b10 with SMTP id
 5b1f17b1804b1-4a0274f9bfbmr42577955e9.3.1790929940907; 
 Fri, 02 Oct 2026 01:32:20 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:32:20 -0700 (PDT)
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Date: Fri,  2 Oct 2026 10:31:00 +0200
Message-ID: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
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
Changes in v2:
- Rebase on top of next-20260930.
- Drop 'watchdog: Replace __MODULE_STRING() with __stringify()' since it
  has already been queued on watchdog-next.
- Split the hwmon changes into a separate patch.
- Link to v1: https://patch.msgid.link/20260922-module-string-v1-0-c18766690185@suse.com

---
Petr Pavlu (3):
      hwmon: Replace __MODULE_STRING() with __stringify()
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
 include/linux/module.h                                |  4 ----
 21 files changed, 76 insertions(+), 65 deletions(-)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260919-module-string-d64816f203d9
