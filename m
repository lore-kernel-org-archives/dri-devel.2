Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1AECD4F25
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0428710E151;
	Sat, 16 May 2026 11:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQDUTufn";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BC810E18C
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:45 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so4171735e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929604; x=1779534404; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gz4+cZA8LSphozrVyKGbCKvf5hEOiKCi+FAiUdVKJ/A=;
 b=QQDUTufnDMql245Mab5z/+pjFEEfGfP3+Ht9Gap0b2gp3523FSOhkaYLQZ1bCTVYXZ
 FyCoELK/TnLxVrddscqDwXnoYV+K48lUAEhSSVrEPKK1Jn02p7AyZOOZ97gPS8ms4asI
 sKgQH3x5MRGT+B3kns8gFW+SX3GKnIWWIBqLxUdo0PEOWomsPr1t/Zew8ciZFlZcD0Ds
 p9E7VuVgZCGP7DFCvaX2Fiq0+ZGG0orDGdwy/uBX8R7YZJc2K3mVpqb7Zpy0u/vjLPLT
 00GnIIdc0RJUwmJRH+P/l+KchYe2siRNDAgwFdnrVNEzy7YhwVT5l3N4I2ftvG1e2PV9
 Io9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929604; x=1779534404;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gz4+cZA8LSphozrVyKGbCKvf5hEOiKCi+FAiUdVKJ/A=;
 b=r899x48H6/RSb7qkE3hg/4nAXk32qeQHU/f7BSomi5RFwSX+je5uOeLDbmEm0lFWHg
 en8c5JzqwlMiyH1CFEbHk4dlpgmwkaiUxMDeMOhkKn8Dq8sbMBtLgLNlRhON4TY7xAvK
 MyvOUpx6mADEW2a0sXqopSan0ODp+3wPoefp+sMyiG/5oBr3GhJUnzId6eccn2q+EZaX
 Pyxn47UkkXr8FowlaQZvi82R0pkOOHS1cRpcmMKx0IYpIObccry2tsr1fnNobGyP33+j
 M3olmgWFfIyzAzOowOF3trrgpOlUJRy0WP/9OxYckfwI3hVN013RRxaP/O9fpM1yJ7py
 SJsg==
X-Gm-Message-State: AOJu0YwvtxtM7+SeV+ajqGmWD5Q8HJ2qDYL3WBUehpdKlAmuBr1ACZJA
 TaQKibR28rA5Fh99mj8qyV1GubasEHD7v0TcGpgPE4r3Tv8psnftNtDH
X-Gm-Gg: Acq92OHEjXjqDvued+YxlD7mpCXvE2YqXPFMhMNTHo9Y9g0jQPGxYx4WLTQg1Ov1rY8
 4Hkukn29bOIv4C6F3KBgJDaxK9aLvJF2E+qujq/zdSBOEYOWNzBTClEtShbQE/mPuFU9mpaZTnt
 erV+BBu1Hr7BcEwF1w2bxC4Okcv2nDQZMGXYqiZNh4hC0byxQYw2B6C4Dl62qrbJ74uC+w3BzyP
 hxysi+1PfUOdcjYO+MvGcPFHSgJkuG4lVC5B4Q+tLy3Dm0dMNcplwApKesEmvJklJBKAf4DMuft
 JC9mwCXRq02aBPHT3tw5uxYP159YCpIrfp2O6r7FMQtioZxubPVnkcBEH7bl/HiaUqXdlu6OwVd
 er/mc2l3i2LN20rG6uA4wpA9hx3ktj9UCiMZ4pOJpg9+wkgR1ADGS+cg6bzPps2NAgUE6y4Ept3
 K/Pqs5sY0zgYAs+Z+mAG4cF5WCSaY3CjZPfR3kBHw2/LbGgNfHy8cKYgIaJ7GjwxBLOy1eoXxFe
 5IMrkp6HTcsIHrG3w==
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48fe63253f3mr102196835e9.21.1778929604120; 
 Sat, 16 May 2026 04:06:44 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:43 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Subject: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
Date: Sat, 16 May 2026 13:06:03 +0200
Message-Id: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Mz3az8opIM3eLKvOT8pCzdFJMUY3OTZItkM8MkJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAM1IAHdxAAAA
X-Change-ID: 20260516-jorth-syncobj-d4d374c8c61b
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 ju.orth@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=3472;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=xGLM080fZDT6fjgKMdHlzv2Fg/jga2+0PO1niQABJfY=;
 b=zo0vZL9hPQu19bKw29wiQABC4vBPxw410iM5DsRWLuc6m/S5L7nGm9ePhoRvAq++IQEZPRF8E
 59xKe6ltBezDBB645EtSqjyATdjsklrspEITvGiRK0KsaSfJfdtER39
X-Developer-Key: i=ju.orth@gmail.com; a=ed25519;
 pk=uM2SS4lelkuIoYHc7v9N9bgBZ3hS632zJS2xjRJLPLI=
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

This series adds a new device /dev/syncobj that can be used to create
and manipulate DRM syncobjs. Previously, these operations required the
use of a DRM device and the device needed to support the DRIVER_SYNCOBJ
and DRIVER_SYNCOBJ_TIMELINE features.

There are several issues with the existing API:

- Syncobjs are the only explicit sync mechanism available on wayland.
  Most compositors do not use GPU waits. Instead, they use the
  DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to perform a CPU wait. Being tied to
  DRM devices means that compositors cannot consistently offer this
  feature even though no device-specific logic is involved.
- llvmpipe currently cannot offer syncobj interop because it does not
  have access to a DRM device. This means that applications using
  llvmpipe cannot present images before they have finished rendering,
  despite llvmpipe using threaded rendering.
- Clients that do not use the Vulkan WSI need to manually probe /dev/dri
  for devices that support the syncobj ioctls in order to use the
  wayland syncobj protocol.
- Similarly, clients that want to use screen capture have no equivalent
  to the WSI and are therefore forced into that path.
- Having to keep a DRM device open has potentially negative interactions
  with GPU hotplug.
- Having to translate between syncobj FDs and handles is troublesome in
  the compositor usecase since syncobjs come and go frequently and need
  to be cleaned up when clients disconnect.

/dev/syncobj solves these issues by providing all syncobj ioctls under a
consistent path that is not tied to any DRM device. It also operates
directly on file descriptors instead of syncobj handles.

The series starts with a number of small refactorings in drm_syncobj.c
to make its functionality available outside of the file and without the
need for drm_file/handle pairs.

The last commit adds the /dev/syncobj module. I've added it as a misc
device but maybe this should instead live somewhere under gpu/drm.

An application using the new interface can be found at [1].

[1]: https://github.com/mahkoh/jay/pull/947

---
Julian Orth (12):
      drm/syncobj: add drm_syncobj_from_fd
      drm/syncobj: add drm_syncobj_fence_lookup
      drm/syncobj: make drm_syncobj_array_wait_timeout public
      drm/syncobj: add drm_syncobj_register_eventfd
      drm/syncobj: have transfer functions accept drm_syncobj directly
      drm/syncobj: add drm_syncobj_transfer
      drm/syncobj: add drm_syncobj_timeline_signal
      drm/syncobj: add drm_syncobj_query
      drm/syncobj: fix resource leak in drm_syncobj_import_sync_file_fence
      drm/syncobj: add drm_syncobj_import_sync_file
      drm/syncobj: add drm_syncobj_export_sync_file
      misc/syncobj: add new device

 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 drivers/gpu/drm/drm_syncobj.c                      | 374 ++++++++++++++-----
 drivers/misc/Kconfig                               |  10 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/syncobj.c                             | 404 +++++++++++++++++++++
 include/drm/drm_syncobj.h                          |  21 ++
 include/uapi/linux/syncobj.h                       |  75 ++++
 7 files changed, 795 insertions(+), 91 deletions(-)
---
base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
change-id: 20260516-jorth-syncobj-d4d374c8c61b

Best regards,
--  
Julian Orth <ju.orth@gmail.com>

