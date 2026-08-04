Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEDEC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB9D10ED2E;
	Wed,  5 Aug 2026 07:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="F7kwTMh+";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61EF10E150
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:13:15 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso14676945e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838394;
 x=1786443194; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JTO+yub/oHkWnNxE/PR+YPqKbJIe1H0uu4C2i4wSPEY=;
 b=F7kwTMh+ihoc79obw5D7yldE8f5Gm8HmFXd+4v0wctjVRpGRpwsgw1TPNbt1O09jQJ
 cnfx242PXkhiRQVsAxwqCjhuL/8W0c4UldBvaplr8BAsO/v/akCqo+xsWxsSffX+x37h
 j1JWbVcpJpO59tNf1CBgCCcHoi93auzJ9Nax3GKSsfJs9QyPv0jya5fnP4blzwQsmQW9
 +51HUPcLyCNZs5Xeg7YCthAXuRXqNw8C1uN9IIo6j3KRthY0yXQPnrg15UaAM2/WR+rF
 7h/r1b/kcbswOh26rf6B5VFffoOlOYniFgq0UJco0DZ0ei+SOSSHIWKvOZJKKuCsrs7E
 VrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785838394; x=1786443194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JTO+yub/oHkWnNxE/PR+YPqKbJIe1H0uu4C2i4wSPEY=;
 b=mfHUVP6XFQHlGMIR+HQjmOeneb49D0/C/sqF7D2bvjY7a0FAiNDSaMKjPTbf/uA3om
 EWDqz0idWQdP1Y/v9CnVJTRQN+q6wfnErPyK0RWzSMTB7w0FhywMmCUdiLfISfwgtrAS
 adcsie/cac82RBvbny7Z1UrPbUZnTRSJSjzWCq3ug9MWmw35DnXX0e9EgQnfCqIwWiyN
 gKDoPNtEtD4hkt4EakNZD7tpOHV8fNN8/RLjqmzvVvz0/YwlJ8fmQAFBgO7szVVymwks
 IC+1X4FXX80mSM/3dG6zybOMjgGAhrOZ2c4+46YwxeZBuDGS+CPvPFQfl91sn4exYMqA
 6J3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHJ3GAT1xXe0ywCErcyaufJnYBrUmsKKqlXhqqnMJG4toTID4vgpZeWUIVOEWD0wvZOdFwlO75xis=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+L4tiPcD92bdfmTyYIgAVlXdpeZROb8WH3qV6nHurspwWQIfh
 wv3YjIB15sqQeTfDiRq+DfAd0cWtHRE0sNGR7VG/JV5Nx8JEMBcKd14D5NcMql3QSQ==
X-Gm-Gg: AR+sD13+gFM4OdOsdmg0lyK8TNXLXgFf9XVBVw8TrVePXws5WBbWpwsYnkC07qhPHFg
 XA77DUEYoGUiKRrS7Vdei0n7RQfEI+3N+PhnRJ88gdoY9URXFkZyHkKxQQbh1HJ2FAWs7UjXjMU
 /NvxNlymXBJBECr89e8t2hFHP6dJxVBRdlIgl/mGKaVSH63dyYspkaSi+/2Biavrgpd1T+3BbFZ
 +9iqh7Wx3YRRVKncowNkihDYE1CqSYfO+J1/KvCVyAuDQHc7Xp0lZ3GpYFkOY4I0vN/3UgtsLR5
 g8TaQ0Grp3Nimicc4oV+NQ8guxn2MeuCvYAww7U1RGSi/dsC1R7Sw25slrY+1JHrCazbgxDSBok
 f91Dm805CCHDqe1rJ1ne4JAc02uX5bjNWRKtAwCGG0iUtf+6uSijGw1BB6WGFvmb0udvtsuEcu4
 XTNKTGeu6CF3miC890VHODDS5MX7posjoFx71I7mISqHn2dnBEiPvNj4kRNoZUjefO2Gl7IIT81
 NMs9PxNjttsjjzDu78eJVYjdlHHWQT1
X-Received: by 2002:a05:600d:6451:20b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-4980c66d950mr239212685e9.7.1785838393168; 
 Tue, 04 Aug 2026 03:13:13 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fcb0c5sm67300275e9.4.2026.08.04.03.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 03:13:12 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: chrome-platform@lists.linux.dev
Cc: Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Sean Rhodes <sean@starlabs.systems>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Michal Simek <michal.simek@amd.com>,
 Sven Peter <sven@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org,
 Oliver Lin <oliver@liuxiaozhen.dev>
Subject: [PATCH v11 0/4] coreboot CFR firmware attributes
Date: Tue,  4 Aug 2026 11:13:05 +0100
Message-ID: <cover.1785838269.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

Move the firmware attributes class helper out of platform/x86, rename the
coreboot-table firmware driver directory from google to coreboot, and add a
coreboot CFR firmware attributes driver.

Changes in v11:
- Keep the scoped cleanup in the CFR driver, but use explicit goto cleanup for
  the nested sysfs group registration path.

Changes in v10:
- Address the nested cleanup-path review on CFR attribute registration.

Changes in v9:
- Add the missing kstrtox.h include used by kstrtou32().
- Use a single kobject rollback path when setting registration fails.
- Split a few helper locals for readability, including the pending reboot
  device lookup and enum-value population.
- Avoid an intermediate void pointer cast while parsing numeric CFR options.
- Check the possible-values buffer length before computing each label length.

Tested on a Star Labs Byte with firmware 26.07: runtime APM_CNT apply was
verified with power_led, and reboot-needed behavior was verified with
debug_level.

Sean Rhodes (4):
  platform/x86: Sort firmware attributes class includes
  firmware: Move firmware attributes class helper
  firmware: Rename google firmware directory to coreboot
  firmware: coreboot: Add CFR firmware attributes driver

 MAINTAINERS                                   |   18 +-
 arch/arm64/configs/defconfig                  |    6 +-
 drivers/firmware/Kconfig                      |    5 +-
 drivers/firmware/Makefile                     |    3 +-
 drivers/firmware/{google => coreboot}/Kconfig |   88 +-
 drivers/firmware/coreboot/Makefile            |   15 +
 drivers/firmware/{google => coreboot}/cbmem.c |    0
 drivers/firmware/coreboot/coreboot-cfr.c      | 1205 +++++++++++++++++
 .../{google => coreboot}/coreboot_table.c     |    0
 .../{google => coreboot}/coreboot_table.h     |    0
 .../framebuffer-coreboot.c                    |    0
 drivers/firmware/{google => coreboot}/gsmi.c  |    0
 .../memconsole-coreboot.c                     |    0
 .../memconsole-x86-legacy.c                   |    0
 .../{google => coreboot}/memconsole.c         |    0
 .../{google => coreboot}/memconsole.h         |    6 +-
 drivers/firmware/{google => coreboot}/vpd.c   |    0
 .../{google => coreboot}/vpd_decode.c         |    0
 .../{google => coreboot}/vpd_decode.h         |    0
 .../firmware_attributes_class.c               |    2 +-
 drivers/firmware/google/Makefile              |   14 -
 drivers/gpu/drm/sysfb/Kconfig                 |    2 +-
 drivers/platform/x86/Kconfig                  |    3 -
 drivers/platform/x86/Makefile                 |    2 -
 drivers/platform/x86/asus-armoury.c           |    2 +-
 .../x86/dell/dell-wmi-sysman/sysman.c         |    9 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  |    9 +-
 drivers/platform/x86/lenovo/think-lmi.c       |    5 +-
 drivers/platform/x86/lenovo/wmi-other.c       |    2 +-
 drivers/platform/x86/samsung-galaxybook.c     |    3 +-
 .../linux/firmware_attributes.h               |    6 +-
 31 files changed, 1340 insertions(+), 65 deletions(-)
 rename drivers/firmware/{google => coreboot}/Kconfig (57%)
 create mode 100644 drivers/firmware/coreboot/Makefile
 rename drivers/firmware/{google => coreboot}/cbmem.c (100%)
 create mode 100644 drivers/firmware/coreboot/coreboot-cfr.c
 rename drivers/firmware/{google => coreboot}/coreboot_table.c (100%)
 rename drivers/firmware/{google => coreboot}/coreboot_table.h (100%)
 rename drivers/firmware/{google => coreboot}/framebuffer-coreboot.c (100%)
 rename drivers/firmware/{google => coreboot}/gsmi.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole-coreboot.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole-x86-legacy.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole.h (82%)
 rename drivers/firmware/{google => coreboot}/vpd.c (100%)
 rename drivers/firmware/{google => coreboot}/vpd_decode.c (100%)
 rename drivers/firmware/{google => coreboot}/vpd_decode.h (100%)
 rename drivers/{platform/x86 => firmware}/firmware_attributes_class.c (94%)
 delete mode 100644 drivers/firmware/google/Makefile
 rename drivers/platform/x86/firmware_attributes_class.h => include/linux/firmware_attributes.h (60%)

