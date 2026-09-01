Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6BAC624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C9810E25D;
	Thu,  3 Sep 2026 07:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="bE/Nfw2+";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601A010E401
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:48:10 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso456355e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1788284889;
 x=1788889689; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uBK06/P7IANNt8rczOHS7wy56i3XV/2ANmKJ76fwSP0=;
 b=bE/Nfw2+fjOCA3jfAV6XIjcxGWHyR6m/HaHKIhJk9qhqHMJNjJ6d6wqE2DhdbKTnsI
 8fEQGXM1ZdT4gaAlhU8yq8VFVPQiO3AndGeUqZhWwo7gQgAVsaT2nwmUpd6JGxcix61v
 WxkXsy2EhSheVd4a/S91eiqflQR6HlbHGF8d+N4ECCnvAx6Laspi/jSASINDZYYm/72E
 CjdMYn5AS+5Kk5Gc3xYvkAfWQWBJgl+n94rtjTwhAh1Fw2Yv3chE+tocKfg149Ra0nqs
 pLpdPjD5RXIYW5C66rEVO4dq3+BjWgdMP2bL045cnPvjMclTQ/2HkYUTBAR4M2L2FSer
 IQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284889; x=1788889689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uBK06/P7IANNt8rczOHS7wy56i3XV/2ANmKJ76fwSP0=;
 b=P0Jnk2f7eIJgau5PsECIsJvZhpu7vyB0dS219wSNyfqBm3Fhe3SX0JQL/ZULByLoI0
 1Dkb/xnP+yMfTY/cF5qDl40B2CCrTB71+fUecmrtTPQlfNDFs7PNI2/i4c3Pa0iN3dVJ
 FEldjucIrKN51jcy4TRlf5tKl7rgq47/KUOfLnV4tWaFXDEO2ZJp7B7Tbn5wHr5aTZWB
 MjWYYac8U6PV7NQ/stQ92vnqThPtduHZ8iJuURd5PejonSlRiB0m2nfZWdJy8pjT5jiy
 LyD6Q+XYLP+cKtPfX+ZiSXAB61LhyT52fIKG1TOA/zOqiLwlZaItUgAB/eJonJlZrrE2
 5HTw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2S52YkvGrr8WlfsrdgScEpIrlzdTQe1Y2nyG7x9k/zlKrYrNGc3OlDTXwNBNVMrGPhLm03sSmyJc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kCoZl4hoop9pwjGItokhnS2uZi4TL7DaxRVTey4QL8o8HMUKsp
 QQIrv/w3/eZ2IDKrZrsrNG8EztB74JJHQWCETXHsJ4uHG511VwAhhHL0oipKAwDoig==
X-Gm-Gg: AR+sD11mLGroCDUnkHFvUmkstCfdhCEKDzhuoRFJR7VUVO4GRmzPGuLfFgtHVFjIq/0
 ZpkW5oKMYq7nJ0qs1NOPjkhyPQoWMMEF4d3P7/+oapw1+nDZmAygNliNjo0eVGI3qzaapDuZJQ/
 hmoUAAjLD4BMobHLAeMWmLXf4xUMrhvThU7VhM0SqgMw1lHgkrewV6w7sg4MAYBrQB1DnDtZyH7
 oAOZg5YpivWbfg24Kj2kRMUVuubYXjigLOzEAkmp1O8NYu/RKveVLztvUb96MEKC/Mrfmaa8rx/
 ApFXTAaz9fj3gYyNKNRWJ5cum6MgBytMybeKf5lia2o6njKjXhwM9ZTKOFGzDtSgwwKPoehDwHf
 XMMbfG1vJJmYtWpvE+WYVoYDoOHrOeU6D9ZKywlYv4mX3K3XBgoBGwh+yuny8qEdwJQXsIGc8bu
 oPYGwmuqVZD9nb+U7SQpMZBHucLe07NFSpn8NnhCJNkSDUHgx2pbBqeME8WXsZh01Ub+Egsz3Io
 FoHbwPWFUFSQEg=
X-Received: by 2002:a05:600c:4f0e:b0:49b:9433:ea44 with SMTP id
 5b1f17b1804b1-49cdc40ff56mr223649635e9.4.1788284888802; 
 Tue, 01 Sep 2026 10:48:08 -0700 (PDT)
Received: from horizon ([217.155.46.38]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47885b1sm2369225e9.14.2026.09.01.10.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:48:08 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>, Will Deacon <will@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Sean Rhodes <sean@starlabs.systems>, Huacai Chen <chenhuacai@kernel.org>,
 Chen-Yu Tsai <wenst@chromium.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
 Yidi Lin <yidilin@google.com>, Kees Cook <kees@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 chrome-platform@lists.linux.dev,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
Subject: [PATCH v14 0/5] coreboot CFR firmware attributes
Date: Tue,  1 Sep 2026 18:48:01 +0100
Message-ID: <cover.1788284852.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Changes in v14:
- Rebase on current upstream master after Linux 7.3-rc1, preserving the
  intervening coreboot table bounds and CBMEM no-map changes.
- Drop the standalone include-order cleanup. Replace the affected relative
  includes directly in the firmware attributes helper move, as requested by
  Tzung-Bi.
- Split the DRM coreboot framebuffer dependency update from the firmware
  directory and Kconfig rename so it can receive a DRM Acked-by separately.
- Keep the CFR driver and its runtime behavior unchanged from v13.

Changes in v13:
- Rebase on current upstream master.
- Restore the CONFIG_GOOGLE_* to CONFIG_COREBOOT_* renames for generic
  coreboot firmware symbols, with the old names kept as transitional
  symbols.
  Julius clarified that the symbol names are part of the directory rename
  cleanup and should describe coreboot rather than Google. Update the
  matching Kconfig dependencies and Makefile gates to use the new symbols.
- Split the arm64 defconfig symbol update into a separate final patch, as
  requested by Krzysztof and Julius, instead of folding it into the rename.
- Move the COREBOOT FIRMWARE DRIVERS MAINTAINERS entry to its alphabetical
  position.
- Make the CFR APM_CNT runtime-apply dependency explicit with HAS_IOPORT
  instead of using an x86-only runtime branch.

Changes in v12:
- Temporarily kept the existing CONFIG_GOOGLE_* symbols and dropped the
  arm64 defconfig update after review feedback against the user-visible
  config rename. v13 supersedes this with transitional symbols and a split
  defconfig patch.
- Free invalid enum labels before returning an error from CFR enum parsing.

Changes in v11:
- Keep the scoped cleanup in the CFR driver, but use explicit goto cleanup
  for the nested sysfs group registration path.

Changes in v10:
- Rename generic firmware Kconfig symbols from CONFIG_GOOGLE_* to
  CONFIG_COREBOOT_* and keep the old names as transitional symbols, as
  suggested by Julius.
- Update arm64 defconfig and DRM coreboot framebuffer dependencies for the
  new symbols. In v13, the arm64 defconfig update is split into its own
  patch; in v14, the DRM dependency is split into its own patch.
- Address the nested cleanup-path review on CFR attribute registration.

Changes in v9:
- Add the missing kstrtox.h include used by kstrtou32().
- Use a single kobject rollback path when setting registration fails.
- Split a few helper locals for readability, including the pending reboot
  device lookup and enum-value population.
- Avoid an intermediate void pointer cast while parsing numeric CFR
  options.
- Check the possible-values buffer length before computing each label
  length.

Changes in v8:
- Add a preparatory include-order cleanup before moving the firmware
  attributes class helper. This is superseded by the direct replacements in
  v14.
- Add direct includes for __packed and container_of(), use scoped cleanup
  for EFI names and the driver mutex, and document the efivar lock
  requirement on private helpers.
- Replace the duplicated CFR record walkers with one checked iterator that
  distinguishes malformed input from the end of a record list.
- Validate enum entries before accessing them and propagate malformed child
  records instead of treating them as absent.
- Restore the EFI variable after a failed runtime apply without retrying
  the failed firmware operation, and only emit a change event when the new
  EFI value remains stored.
- Document the possible-values size limit and why CFR entries without a
  usable runtime EFI variable are skipped.

Changes in v7:
- Validate the CFR payload checksum and use bounded record walks. Propagate
  malformed input and transient probe failures instead of silently dropping
  settings.
- Make EFI writes transactional, serialize EFI reads and writes, and expose
  settings read-only when EFI writes are unavailable. Preserve
  `pending_reboot` when rollback cannot fully restore a setting.
- Propagate suppressed, dependency-gated, read-only and inactive form
  state, and bound form nesting.
- Preserve APM token zero and reject enumerations whose values cannot fit
  in the sysfs output buffer.

Earlier revisions:
- Move the driver from platform/x86 to drivers/firmware/coreboot and split
  out the firmware-attributes helper move and google-to-coreboot directory
  rename, following Julius's review.
- Keep coreboot bus internals and CFR records private, avoid rewriting EFI
  variables when the requested value is already active, and store driver
  data on the class device instead of in a file-global pointer.
- Use the coreboot-specific device ID header, explicit helper includes,
  scoped resource cleanup and device-managed driver state in response to
  the initial reviews.

Tested on a Star Labs Byte with firmware 26.07: runtime APM_CNT apply was
verified with power_led, and reboot-needed behavior was verified with
debug_level.

Sean Rhodes (5):
  firmware: Move firmware attributes class helper
  firmware: Rename google firmware directory to coreboot
  drm/sysfb: Update coreboot framebuffer Kconfig symbol
  firmware: coreboot: Add CFR firmware attributes driver
  arm64: defconfig: Update coreboot firmware symbols

 MAINTAINERS                                   |   34 +-
 arch/arm64/configs/defconfig                  |    6 +-
 drivers/firmware/Kconfig                      |    5 +-
 drivers/firmware/Makefile                     |    3 +-
 drivers/firmware/{google => coreboot}/Kconfig |   89 +-
 drivers/firmware/coreboot/Makefile            |   15 +
 drivers/firmware/{google => coreboot}/cbmem.c |    0
 drivers/firmware/coreboot/coreboot-cfr.c      | 1204 +++++++++++++++++
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
 .../x86/dell/dell-wmi-sysman/sysman.c         |    2 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  |    2 +-
 drivers/platform/x86/lenovo/think-lmi.c       |    2 +-
 drivers/platform/x86/lenovo/wmi-other.c       |    2 +-
 drivers/platform/x86/samsung-galaxybook.c     |    2 +-
 .../linux/firmware_attributes.h               |    6 +-
 31 files changed, 1337 insertions(+), 66 deletions(-)
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

