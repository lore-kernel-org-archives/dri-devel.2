Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8392EC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240F510E5B9;
	Wed, 19 Aug 2026 06:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="ulEUdwAJ";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6844B10E2E7
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:23:16 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-66c7a743cf8so541973d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787001795; cv=none;
 d=google.com; s=arc-20260327;
 b=Hs69dkdkuGNaBnXZJZjP7MAJlNjJ6sxzi30+gecq1iqi3k2wmXM6hrSZUyu+RPr/i7
 Ye22pIA+YL8T0lzyzFZvO7DIzgUkXTfndmZTlR16fF2r5V6pX/Tlim/8q5UEA3SuValF
 3GUPhpdmR22s7FCsuiGkGZypSnMk+Vol5qZ+Sxa/A8Fs8ETdhUxp4/fT51t1CKSVH2K/
 q03UBCUNOvyiakMKmEFNhzvkBmQ2cC73nnhxoqvLkY8kQZfCyVIc3WanJdlJ7K2nDvXh
 TqL59d7ApK+2ZsRENeC914YcArs7t8ZVKBmNzHpuFpypmU7C/T21MR7vlf+3bYeMxXuJ
 Fa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=+5PLKuMouYLJfuABukE9BfK1nd1YWhR9ndsRk8oKsV0=;
 fh=JlrZFvMJTWvMueyOC/xZ1tHU+7Bf2vz3Um9HT8tOgiA=;
 b=UVyXNgRGNmY/0dFfa6n7YBHewO94SGhEH1kGWWhowld9leC3Giq9simC4UGNXA0nIe
 se0MItjljPzZsTjw8+JA97HQDDUPRFcuklkP8szWn+YQnrf+bYTZwAS2MAVTJDAmv2NT
 aW5OfsA2nXmK8Ob3IlVP2YRu8edcUoMOcBwd+KqFxDmLHLGJ0pcWttHlK644HqPhVGad
 ioAi5vtKjhtQAovtSA+u3vlYAdBGbJo6TkJYxHKh3F8o/ttfJW/r1zDxCzz18O+f2RCp
 DwY+vMbZJN817GuSMU0MdpL0b5nEcczZJvtHw8Fs6HYEWSD1IsStqnC2XManb3282j95
 sjvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1787001795;
 x=1787606595; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+5PLKuMouYLJfuABukE9BfK1nd1YWhR9ndsRk8oKsV0=;
 b=ulEUdwAJfX5r5aqQ06ubdBv7drR6AjZn1p/ML+ExZoZHmWHYl8JoDBcS30Z6lI1Pv1
 fHU4lDJjTugIyHLpiGfxBDPl+nCLr9r/sTBinRvmhqUKcFKEF55E9k+GofuM3aJ6qMjg
 GF6JO/SLbelnHb0//o6XZe0zBTboKxPjOAO4REAH5WJrFaP5QfDWnxnipnVLhitBS+t/
 nN6vt8gQcz+QIgS2O4Zn82xPji57etrjTAgWJQQL6UVWdHZ/lTsGR5PK46eQNUrv5+3m
 Nk9aDR9OSAviyICGZ3tmbWZ+WWobyxrPcXCXNJxhD1bw7du1NR7KDCd/Zca/ehvJv3ET
 X+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787001795; x=1787606595;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+5PLKuMouYLJfuABukE9BfK1nd1YWhR9ndsRk8oKsV0=;
 b=QizF78kMyBLktYgIoL/Dmgb31jR41xN0HSxwMS5NtYbjzaADFZ5MH0TFtwZ+9hGO0M
 0r1DOM5NYUWvZcRGvGO/zBRWH+lOJhP2D6e0zPvIhyRnFRrhojBjlRfGvmxD9CpQx5v+
 OZJWzkJ+kr1l8deScorZTiP7oLJKn13SWJQtoCi8ZlTv6ivBX0GZ7pj6N5gup177Xl6t
 4lyl26ieFNFmPnaHDA8JgLqIcKX7pHdDUTHereU+bDUB9drA7PA7mshd7R8xLCy/mJ4m
 01aoALko4pofBH4a0dUp28TJzWNbhob9AQXjQOxMvl0BYPa0v2v4qgwq5gYrch+AMA6H
 OEgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRcYIXWamV6K5Gb+LIzypQrWJ65K76p38ZtRwrOQBSZCceb9lTC7uKdQmmZbOf+JpdTxtnkzNvWb8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdKEnlCfjsX1OPWZXOyVwYKVSv+1f/gQcmSDgF9UA4CrzTjbRF
 apFGeOyGj9aUdnNzdiqLDE5T8HG+jV7FdGFkYt3YpSyCeqcFdokAIH1o1vXc6aMJA3JdddEnoUt
 o02HPUjSixI/uSTfRTlLfokVxHJx1UUkmrf/NqQD9
X-Gm-Gg: AR+sD11vLOuUlBhq0xTAC4skXxsv6723CwO4rS518G8UcVXsF6q2kP47YkyEB9skDNe
 6V2EcY+0rnMsyOjrEQ7SGU8k7XX9xnT7IZzKIgpgK0kCt8D2q937zjOsNlVMkPv4BCl+S8MmJLm
 kfcp8p6/Q63WwwypFx0+JvXAW4c3bYQU8D4pMhuu6i10EcSnGUbCd0SvHssJaIgKWDYN96ZM8pj
 F6+gR+s4srOV4AUWGqZm8Pxtr0I82SC+O5LeBEOMtQuuqKtgJbpoVofsD8V8T0CDVljfUI2q/ka
 MQCZS+Hv8Wq5m7Wq5ufqnRpmHp5WOLNE1DQQ+LSTrUX1UOmluEMmAb8VQtvOtelw5IYXVMvz
X-Received: by 2002:a53:e648:0:b0:668:8d0:20c with SMTP id
 956f58d0204a3-66cbc402e78mr562185d50.20.1787001795207; 
 Mon, 17 Aug 2026 14:23:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 17 Aug 2026 14:23:14 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 17 Aug 2026 14:23:14 -0700
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Mon, 17 Aug 2026 14:23:14 -0700
X-Gm-Features: AcwNN1UEW_I4KbJipIcXlINKvUbDivRmFcqfha0Y1blx7Hp6TaEGXKNcQwcXyPM
Message-ID: <CABtds-0YAuFxEOUREOCOB2HErVp8h+dkhMwTj2ZrQqh_dGHMTw@mail.gmail.com>
Subject: [PATCH v13 0/5] coreboot CFR firmware attributes
To: chrome-platform@lists.linux.dev
Cc: corentin.chary@gmail.com, luke@ljones.dev, denis.benato@linux.dev, 
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com, prasanth.ksr@dell.com, 
 jorge.lopez2@hp.com, mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com, 
 josh@joshuagrisham.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 florian.fainelli@broadcom.com, chenhuacai@kernel.org, mst@redhat.com, 
 wenst@chromium.org, tzungbi@kernel.org, briannorris@chromium.org, 
 jwerner@chromium.org, tzimmermann@suse.de, javierm@redhat.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, krzysztof.kozlowski@oss.qualcomm.com, andersson@kernel.org, 
 geert@linux-m68k.org, dmitry.baryshkov@oss.qualcomm.com, arnd@arndb.de, 
 ebiggers@kernel.org, luca.weiss@fairphone.com, michal.simek@amd.com, 
 sven@kernel.org, u.kleine-koenig@baylibre.com, bhelgaas@google.com, 
 dakr@kernel.org, o-takashi@sakamocchi.jp, titouan.ameline@gmail.com, 
 kees@kernel.org, dri-devel@lists.freedesktop.org, oliver@liuxiaozhen.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Changes in v13:
- Rebase on current upstream master.
- Restore the CONFIG_GOOGLE_* to CONFIG_COREBOOT_* renames for generic
  coreboot firmware symbols, with the old names kept as transitional symbols.
  Julius clarified that the symbol names are part of the directory rename
  cleanup and should describe coreboot rather than Google. Update the matching
  Kconfig dependencies and Makefile gates to use the new symbols.
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
- Keep the scoped cleanup in the CFR driver, but use explicit goto cleanup for
  the nested sysfs group registration path.

Changes in v10:
- Rename generic firmware Kconfig symbols from CONFIG_GOOGLE_* to
  CONFIG_COREBOOT_* and keep the old names as transitional symbols, as
  suggested by Julius.
- Update arm64 defconfig and DRM coreboot framebuffer dependencies for the new
  symbols. In v13, the arm64 defconfig update is split into its own patch.
- Address the nested cleanup-path review on CFR attribute registration.

Changes in v9:
- Add the missing kstrtox.h include used by kstrtou32().
- Use a single kobject rollback path when setting registration fails.
- Split a few helper locals for readability, including the pending reboot
  device lookup and enum-value population.
- Avoid an intermediate void pointer cast while parsing numeric CFR options.
- Check the possible-values buffer length before computing each label length.

Changes in v8:
- Add a preparatory include-order cleanup before moving the firmware attributes
  class helper.
- Add direct includes for __packed and container_of(), use scoped cleanup for
  EFI names and the driver mutex, and document the efivar lock requirement on
  private helpers.
- Replace the duplicated CFR record walkers with one checked iterator that
  distinguishes malformed input from the end of a record list.
- Validate enum entries before accessing them and propagate malformed child
  records instead of treating them as absent.
- Restore the EFI variable after a failed runtime apply without retrying the
  failed firmware operation, and only emit a change event when the new EFI value
  remains stored.
- Document the possible-values size limit and why CFR entries without a usable
  runtime EFI variable are skipped.

Tested on a Star Labs Byte with firmware 26.07: runtime APM_CNT apply was
verified with power_led, and reboot-needed behavior was verified with
debug_level.

Sean Rhodes (5):
  platform/x86: Sort firmware attributes class includes
  firmware: Move firmware attributes class helper
  firmware: Rename google firmware directory to coreboot
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
 .../x86/dell/dell-wmi-sysman/sysman.c         |    9 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  |    9 +-
 drivers/platform/x86/lenovo/think-lmi.c       |    5 +-
 drivers/platform/x86/lenovo/wmi-other.c       |    2 +-
 drivers/platform/x86/samsung-galaxybook.c     |    3 +-
 .../linux/firmware_attributes.h               |    6 +-
 31 files changed, 1348 insertions(+), 73 deletions(-)
 rename drivers/firmware/{google => coreboot}/Kconfig (57%)
 create mode 100644 drivers/firmware/coreboot/Makefile
 rename drivers/firmware/{google => coreboot}/cbmem.c (100%)
 create mode 100644 drivers/firmware/coreboot/coreboot-cfr.c
 rename drivers/firmware/{google => coreboot}/coreboot_table.c (100%)
 rename drivers/firmware/{google => corebot}/coreboot_table.h (100%)
 rename drivers/firmware/{google => corebot}/framebuffer-coreboot.c (100%)
 rename drivers/firmware/{google => corebot}/gsmi.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole-coreboot.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole-x86-legacy.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole.h (82%)
 rename drivers/firmware/{google => corebot}/vpd.c (100%)
 rename drivers/firmware/{google => coreboot}/vpd_decode.c (100%)
 rename drivers/firmware/{google => coreboot}/vpd_decode.h (100%)
 rename drivers/{platform/x86 => firmware}/firmware_attributes_class.c (94%)
 delete mode 100644 drivers/firmware/google/Makefile
 rename drivers/platform/x86/firmware_attributes_class.h =>
include/linux/firmware_attributes.h (60%)

-- 
2.53.0
