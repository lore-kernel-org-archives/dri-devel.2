Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A765FCD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00B310E699;
	Tue, 26 May 2026 14:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="aePwRNmC";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5202210E699
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:17:58 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so112015975e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779805077; x=1780409877;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g7+ZEzN34eEHBV2XeA10qliUnFt9aIEOrlvbEy+ooC0=;
 b=aePwRNmC4AFKmgoJHlkY4qH3X2FaAwMWmFu75RLCGEh65URTdwdVjff1oo+Ltn//zT
 ahNoSUFFjn5dinP46lUfWTLN4P5PSmPUN4++Bd2Q81DNvoLYcI1RGAb0M6c/Kjk+Fmu3
 e6ErbpsqrmEEfagjf/MYXEW+7NJ6k4BMngNxHxX4nEWpNyUKRlZNHiNhXVyXUkUDa8bD
 gOIKqK4nNfZbrJbqNfTYaDzaoQ03v5wii9BjFUppw/93hO9I09WCe5HCWhz6YF9Bsbl3
 0p4aGqYASCl4NXKoIEV58/gIxwB9slitOfUamGIQ6rLr81F3gy6m1he4RIh3nqyL4Q/M
 Eapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805077; x=1780409877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7+ZEzN34eEHBV2XeA10qliUnFt9aIEOrlvbEy+ooC0=;
 b=VTN8X81Xe0lGrMTk76xQf9PSmPmUflo3A28Aoi9soCVNGi84OE+th9lOKrocbi4yKA
 6Zeq7ebGiH2sWSLvagx/Ksh+CsIfZLY6l0EsBVsTXv0pEtx3ZfRArYyCIEWvs4kyIGHc
 tILQHspvFnJuPzFZ6RWTKlTUf1ULDngUVmWdIaSwINQfgEijnqsR8OfeVrQPFG0GMMvy
 90pBNQNAuY8MlUe7SNNYkkjEDSsNo5kEAdNtMNQEqGh54Kt+uL+5IJbbtGQXcwklQ8Ag
 aYoaPNCOKFqOzc6s7EfpCxjU6M8rergCZwzF1SEV1zH9735gCW7Ut0OUVoRgkmUmTttc
 91yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R4hw/PJ2T5wS8yxHzH2DCvdNEinLxpbqXIPs/w+Qc49eGVP1pcpUbni5ujKXtgk9yMy6Q/ongp/A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzwape/50JmMJSGGdrw/lZQZMbjkI45JgjwMynNrH6O7IfJJouH
 KZE5pJB0FkuKl9e+zLAifm3/fdPBDuIpD9qqoHAbHQjo82anfIFbpu2g5BPDKEHX/LA=
X-Gm-Gg: Acq92OHYG+4gtvy2Z1xjndqoePaPbyadCjyTZFstSzuNJQReoPsLhnPXV41pdns5/wd
 +A5biarXZK/wlxEkD270mOx71Gj7ppIba5DaB9LcLAdPNdyKX+gDW5kjM196mptsVCYw2xgS9E3
 LdhsxWxRJYHYsGb4NVt5tV6ko/yBz3sx8whG69Xa6AZioTM/PlNn6EmI9XcTOy9H9fxy7+AqPTf
 7KGN5a4mmaj4AapAGAAvFQcgaQUI+0SZhHDxS2BNBwvcTFwaWFV7wSD7FemXj8YuqicRx9FGGYl
 YQ7SJBEzgDF2EH+gbAnIiIVGMzO4fGHD7Hf7hpZdaB8YHJScaTgfwgS3f11Gf+i6E/CEwzxv+8m
 0gKdejdjNsFYaC16OHxXOvbcJYDsK42lFVBeOcm8zSPOQFKmqdADHuNfOIkR/XVtaUj4h5bUTXQ
 bix+7p3uqmC/iHyG6NIWvMPtZX56nWuUiDHuBOoHSCv1/WGS9MOPCJbe3+1T56Dx2Pbk/aXsIwm
 +M24jaG79ewT+lZnvN8bHppFQ==
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-490426cd8c4mr332344195e9.20.1779805076904; 
 Tue, 26 May 2026 07:17:56 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4904526ca21sm323690885e9.3.2026.05.26.07.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:17:56 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>,
 Andi Shyti <andi.shyti@kernel.org>, Helge Deller <deller@gmx.de>
Cc: linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
Date: Tue, 26 May 2026 16:17:26 +0200
Message-ID: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=Kybdz7vMHfQVHVOh6L5fYiSlCH/4zeDGpuUchAH7Tmw=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFat2pwUr5NuB2EXH5DJBMYu0MFsCRZClzwm2T
 O9dYlR4RvKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrdgAKCRCPgPtYfRL+
 TkGXB/437E8f30EKdaE8q56oaJt5WlihQ7/3LiGG3zpapj74Iu08O8/GcyZKo9eVo8NUFaoQUo0
 0hif3fK8HhAxSruKgus+1EQhLy4QeBS7zZsfKLyQOA2B83qRv2SA46ZptWCnVfQXneJtq5rnt/p
 z+XAhB5HNmZ0vPCrnsT8fL9BH8Yuh3zYqxT9eUnhr+pmthPLdEZiphMZPNHOU/10eCiEJb0TQUX
 jspmFLtmTRiWApFBZdcAJAZ22LyP1Ls51jKz1i9KFNk3U1cVVN3KNX/HmgRm8an2jPEYqs0Aq03
 oaSi8UN/pRU/wOeZjcBFx1K5Dq0XXmkIHLJB0BQbJ8js9PWI
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

this series is about improving the handling of pointers in struct
zorro_device_id's driver_data.

While it's ok on all current Linux platforms to store a pointer in an
unsigned long variable, it involves casting that loses type information.
This can be nicely seen in patch #7 where after profiting from patch #6
the compiler notices a missing const.

Preparing for that change, all zorro_device_ids are converted to use
named initializers, which is also a nice cleanup that could stand for
itself, as it improves readability for humans. (That is necessary
because an anonymous union can be initialized by name, but not using a
list initializer.)

My motivation for this series is the CHERI hardware extension. With that
pointers are bigger than longs and thus you cannot store pointers in
zorro_device_id::driver_data. So this series is also about getting
support for CHERI into the mainline, but I hope the clean up effects
mentioned above are justification enough to accept this series.

The dependencies in this series are as follows:

 - Patch #5 depends on #1, #2
 - Patches #7 and #8 depend on patch #6.

So if the ata maintainers agreed to merge their patch #1 via scsi, and
Geert agrees to patch #5 and that it's also merged via scsi, patches #1,
#2, #6 and #7 can go in without further coordination.

Patches #3, #4 and #5 are only about using the same initialization style
for all zorro_device_id and can go in without coordination.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (8):
  ata: pata_budda: Use named initializer for zorro_device_id
  scsi: Use named initializer for zorro_device_id
  net: Use named initializer for zorro_device_id arrays
  i2c: icy: Use named initializer for zorro_device_id arrays
  video: fm2fb: Use named initializer for zorro_device_id array
  zorro: Simplify storing pointers in device id struct
  scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
  video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr

 drivers/ata/pata_buddha.c             |  8 ++++----
 drivers/i2c/busses/i2c-icy.c          |  4 ++--
 drivers/net/ethernet/8390/hydra.c     |  4 ++--
 drivers/net/ethernet/8390/xsurf100.c  |  4 ++--
 drivers/net/ethernet/8390/zorro8390.c |  6 +++---
 drivers/net/ethernet/amd/a2065.c      |  8 ++++----
 drivers/net/ethernet/amd/ariadne.c    |  4 ++--
 drivers/scsi/a2091.c                  |  6 +++---
 drivers/scsi/gvp11.c                  | 17 ++++++++--------
 drivers/scsi/zorro7xx.c               | 16 +++++++--------
 drivers/scsi/zorro_esp.c              |  2 +-
 drivers/video/fbdev/cirrusfb.c        | 28 +++++++++++++--------------
 drivers/video/fbdev/fm2fb.c           |  6 +++---
 include/linux/mod_devicetable.h       |  6 +++++-
 14 files changed, 62 insertions(+), 57 deletions(-)


base-commit: d387b06f7c15b4639244ad66b4b0900c6a02b430
-- 
2.47.3

