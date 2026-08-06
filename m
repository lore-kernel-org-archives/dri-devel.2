Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76F3C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8CA710F35A;
	Fri,  7 Aug 2026 06:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="vpvR0zft";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC86710F2C1
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:27:32 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-6680ae2031fso2689098d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 13:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786048051; cv=none;
 d=google.com; s=arc-20260327;
 b=T8emKt+SC7D49UCg3bxa9hIrIyhuMERlUoIAWG80tP/lKd2B0p5pkmCwIClNjETSPE
 xC/vUZ4ILAR8jaQEXRMkgYKWzWWRjBRLy+PVfZ7YY1Ipovo4wD/NR6kK45lvSaChrm0O
 59ULgmYPHErrNOvQ6BE6uqxDyqNc5nX2zfdWHl2pVj755e/V1uXRI9jKwxhX8L+BKZTu
 2ywYQyvHed9eP/aFh82UJvoLNFtinMilTuSrnlMmIauuUlT6zJWs0psm0tKmA9ZZt0If
 hGX6R7xQuX1nXZMPdbaCeyXY8Fnep3T0rZ0CSYZheUgRJCKKjwWn7Zfz2GpFxPz863Rd
 sMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=mUkz9z81fXtboTnN6qDHx4c3BdpFoqvqeB7Oo3Ns4+8=;
 fh=Q2nON03LbQ/yTDxk9QvlgC6IzC2zMsb4IaFSmf7ry6A=;
 b=A5mW9DrMrydHMgq1Eg2QJok/njjcwXs9V1WZB6u6swEwJaRmg4bU749JuLC+Z+IcmQ
 z4/nlZD6XR7LDnJtDklyPEbM30rO5qhMqOIHtul+D3QXBrBGBZ9VCtEjen0j1voQ59kn
 fgNYEhaABGxI8DBEhrG0jqttriP5wuoN+clHFbo1ZkISzPxaOChlJjzJLPRh3PBzqWmv
 /4wZdSH1TGWEBZlfMYexSJDbD7NWpXxYc/tLkAgI2Rx74nuWerXYdyHY6tjW8nOHDmTH
 a1cHRHMvPe1SLAWVYo2xuszoOgBbCgfAXCGEZLv2/Cxk39plqbFjDDKacNQ7xbW1BZTl
 MJxw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1786048051;
 x=1786652851; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mUkz9z81fXtboTnN6qDHx4c3BdpFoqvqeB7Oo3Ns4+8=;
 b=vpvR0zft3LN7nXiPvEtgX/bUGp4zlD2Pu5ueWZpv9otbuX3hiJZ/OjC2DqiISakAj/
 get1rMBRFwr5eHsnKtbFuIqFDWzEgdm+PPLyTYFVhFPC0D3LtBuzo++bWyKblmFghRmx
 uvveRw4uo7CVWCDgTA09jykNFFzXjh08xIKmlFyHSswPCY4o7SMtCzk1gMdsgtrRRgZ8
 l4ivaXuO8nQ72l83LWGMGnHw59MXCvwoAWFGlqpvSJUg04S+6YqG1g5AyXJT4YqDPsqa
 itagJyBR50zXhRueAH29yVGXYQi7z5LjwVRlRDFWg8f3ECQjF8Ed4rVzcV8PLeK54sQY
 Q89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048051; x=1786652851;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mUkz9z81fXtboTnN6qDHx4c3BdpFoqvqeB7Oo3Ns4+8=;
 b=nwN5RZ1lDUfEu/midV0Qwq6RisvUQqPrrEs+/Z58/bShFSnhWrAn6UX7W2hyeie9ki
 yvZ2Jrulah8MQQf/ESJPBnRNQZOAA1YIY22Hk1Z5GBOKJr5Vx+2qkjTq88rt3gl7pONL
 gtju6TWr7zMeyqGi0sG6vvXrSrYTHCg7WlZaiAYBb7IhITNTLRSd0eR5zPKUK0EhnI0o
 gBknfL0RWyOSCXr3gpsbe2k++8Sh8L3CwUWauyCLLfBQsVtIUH4M8hDZMJKclHU0vyZr
 o8Hq3ppdmuBGh57B/NXD5+uWUf59M6/0IsKNvKjNXP0vRa+Nj8ABPmmeOK5SKwTr6yez
 lFiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbiL5sPjlb554F+i8f3ZXkaBi3M5ZXsnwKWPUWDGeoVYQoUCAhiWL7McYA2tWSrkw69S5ZC7ewpXE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxjl3n0C2ViGliaPQGeOvmhpXVfmPGwKfHFAXWX71Su5ciTaQIG
 R5Xr4xgTKxgJBnXEcZfDudjrx5eIH/LoAhDoNvuBHN3bNU5YGMNYBGGzr6m4ueenlvnM4t9b1M/
 wYgrM/HKJo84F6BrlXjdvwXy5HJyztJpI7wHUcF7+
X-Gm-Gg: AR+sD10obMMvLd3Dzug+gDU3BWu5Eq3GjrHncuitZJ0g1I42s+y8/ELxG/QWnt9zXY6
 HEDBnr24HVfxG5juy0gVxksigTo1mk7xi1SvrGLgk9jl5/mtuEnnZUWnU0hIz/6tRCQKz1cjI7N
 2UVCUYG6LD1LWmZ+dYmRXNJGThvUe9syjDLKZ2pQRk5pCjfoMJwdKzfffrp7gZ1lfVycLG5dGm+
 CwemzDPJPInKMvTFh7yvdwKFGymDbaxx6glTSUkrMcD0uO8fQjPdV3m0dAgV6sLVeNQEPNTY0q4
 O0eqgndcwdIKWzTZlpphoCqjaQPK9K4Cbv6akU3W3urGFqfEFC9XYPNT+kLIhjhLt0AbRTCFUVh
 ijfzGMVCM
X-Received: by 2002:a53:cd49:0:b0:664:dbfc:e46d with SMTP id
 956f58d0204a3-66ac2fafb9cmr2208972d50.35.1786048050724; Thu, 06 Aug 2026
 13:27:30 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 6 Aug 2026 15:27:30 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 6 Aug 2026 15:27:29 -0500
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 6 Aug 2026 15:27:29 -0500
X-Gm-Features: AUfX_mzAUIcTps50AuX9XV0cmoM9F8eoNkrO6qV8e69hoMZI6prHfv4r-rievDE
Message-ID: <CABtds-2VsrCtqniHX=znRP-bzpWFTCYDK_Bb3xUgjyVj8Z80Nw@mail.gmail.com>
Subject: [PATCH v12 0/4] coreboot CFR firmware attributes
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
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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

Changes in v12:
- Drop the v10 CONFIG_GOOGLE_* to CONFIG_COREBOOT_* renames after review
  feedback that the user-visible config churn is not justified.
- Drop the arm64 defconfig update and DRM coreboot framebuffer dependency
  update that only followed from the CONFIG symbol rename.
- Keep the directory rename, but preserve the existing CONFIG_GOOGLE_* symbols.
  CONFIG_COREBOOT_CFR remains the new symbol for the new CFR driver.
- Free invalid enum labels before returning an error from CFR enum parsing.

Changes in v11:
- Keep the scoped cleanup in the CFR driver, but use explicit goto cleanup for
  the nested sysfs group registration path.

Changes in v10:
- Renamed generic firmware Kconfig symbols from CONFIG_GOOGLE_* to
  CONFIG_COREBOOT_* and kept the old names as transitional symbols, as
  suggested by Julius. This was dropped again in v12.
- Updated arm64 defconfig and DRM coreboot framebuffer dependencies for the new
  symbols. These updates were dropped again in v12.
- Addressed the nested cleanup-path review on CFR attribute registration.

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

Sean Rhodes (4):
  platform/x86: Sort firmware attributes class includes
  firmware: Move firmware attributes class helper
  firmware: Rename google firmware directory to coreboot
  firmware: coreboot: Add CFR firmware attributes driver

 MAINTAINERS                                   |   18 +-
 drivers/firmware/Kconfig                      |    5 +-
 drivers/firmware/Makefile                     |    3 +-
 drivers/firmware/{google => coreboot}/Kconfig |   20 +-
 .../firmware/{google => coreboot}/Makefile    |    1 +
 drivers/firmware/{google => coreboot}/cbmem.c |    0
 drivers/firmware/coreboot/coreboot-cfr.c      | 1208 +++++++++++++++++
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
 drivers/platform/x86/Kconfig                  |    3 -
 drivers/platform/x86/Makefile                 |    2 -
 drivers/platform/x86/asus-armoury.c           |    2 +-
 .../x86/dell/dell-wmi-sysman/sysman.c         |    9 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  |    9 +-
 drivers/platform/x86/lenovo/think-lmi.c       |    5 +-
 drivers/platform/x86/lenovo/wmi-other.c       |    2 +-
 drivers/platform/x86/samsung-galaxybook.c     |    3 +-
 .../linux/firmware_attributes.h               |    6 +-
 28 files changed, 1272 insertions(+), 32 deletions(-)
 rename drivers/firmware/{google => coreboot}/Kconfig (82%)
 rename drivers/firmware/{google => coreboot}/Makefile (92%)
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
 rename drivers/platform/x86/firmware_attributes_class.h =>
include/linux/firmware_attributes.h (60%)
