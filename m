Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E3DC55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 06:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BF210E05D;
	Sun,  2 Aug 2026 06:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E5V325uT";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC2910E05D
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 06:10:44 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso1313433a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 23:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785651044; x=1786255844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vji7wKx6xE1l/WWcvsYGR+bhlFDcfVWGe0tEz1c5YfY=;
 b=E5V325uTryCqQ/+GobCUif1xyvmVxgaIpWy5V6BNBXt98VuLzOFc5PHBj0zH3qhhMG
 1yPjuO2n7luBu7HUeLaU/XJslGroiT72+g1u1kV6yH+OSEotQHJHCdep1RnUxfMAGY2U
 DbHTIGeNm5wZbQ+HGoC+66FV6FEr1vWaHL+qxnZMSeJ0fR3XUgUFq2g5y2bfgobjxLCh
 or4lXKK4qmuiUKeBlqNr47iqd6u3hQkj13Dt8tDYOpFOdtdWvRQXabgyFy4pBd2qKYrV
 YqrEu5eglYkWZtfb4Wzxu4YOnLNHvZNZXGdXlceYY3vWNO6jl6uTFU9/xJ7bD44WysVf
 Mkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785651044; x=1786255844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vji7wKx6xE1l/WWcvsYGR+bhlFDcfVWGe0tEz1c5YfY=;
 b=Au78iBTJlvZaDnq0d//puzCTOEXNkBzTurrkbSrhp2/vv4pUtDJuSiLBchp5zmn9Ox
 aDmy00Oo7ty3cCWGAX4rl3jbFIjT8tVA37AdjIwfXJ+/CxqSFDZfaQGD0NrPJC7CSHpE
 ih+3C1nroUKVhar9FGMN1/advO9iB42sJXgnl81iKju07o5SHYw2X0Qxtasjoibbjs6l
 Oz8/X5ltJKmEmzF67vxoDhXyLv/4cbMs/4MX4qEh7hygfzn3FAzq9w4SsPIwFrL5cfC1
 pelvCQPD8VuogJGycDqM0uFb0Ukc/nKGgYX1+K72EjlQpUSVKTF4vAXsLXhOYKrn9++E
 g+Lw==
X-Gm-Message-State: AOJu0YxWht3El+9/C//G0z5i3L1xYDx5dG5eYZMIMTp/ae95vdBZr0kF
 MBLfGr/NkLwgjUQY/qEpJq8asnbsMARsDACZOkmI6z/nZVHUEEPkg9g/
X-Gm-Gg: AR+sD12/L39omAofJTwNfB2LpcE6CO89uPD8gq8iiV9I2e/Q/LE0617nkv9pkze8HuL
 zBEIOzfsta6XZfI3eopEm7jR9vt5Sy/dhO2DlJ7hEnU+HN24RHWEa3n9bzVkBBCylYxMxKIW3RK
 bmtPN588FzY3sYVaZzPq8EOtVjJekK74PzHY2vmoJzAiX92wQfvnmnmYJ74v8mp0ygHnr/NF8X8
 GhLVrx1uh6q4SAa/8t0ATZmnnVQtw3vdsgFGFFobiBmRMJbh8jocVgdtV8IexPcbPUoyAKX7LrR
 7zhq9Pggf2tNn3dQWqy6CQd3PB+4eIQ+wwa4EaTsa622DWaJgYpI2pODjJ4UI+M+wyRz5GEIM8G
 v8BNB+2aQw7XUsvVyJURUocRG+vshmRYz9tY0uSWIWHZiIbxcYvYrHnFUwVOvdXR2884lG0AOq+
 riaKTp15U0cW91CAEkLkNqNsy60Ln268+kokE8Z/J9URA16hroe9bY/srhiTvqlcjadi7Miqr6D
 d0TL3iEqP4utsS9gi0DGF2DjJM2MCdnzma82OV6GhzcjrGINCCAVxp8u5GJA/iw
X-Received: by 2002:a17:90a:e7c4:b0:38e:9279:468c with SMTP id
 98e67ed59e1d1-38fbc4d976dmr5437191a91.25.1785651043549; 
 Sat, 01 Aug 2026 23:10:43 -0700 (PDT)
Received: from daeinki-virtual-machine.localdomain ([58.124.60.88])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2f65459sm2564706a91.6.2026.08.01.23.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 23:10:43 -0700 (PDT)
From: Inki Dae <inki.dae@samsung.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org
Subject: [GIT PULL] exynos-drm-next
Date: Sun,  2 Aug 2026 15:10:39 +0900
Message-Id: <20260802061039.73544-1-inki.dae@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Hi Dave and Daniel,

  This PR brings an encoder cleanup series for Exynos DRM along with a
  refcounting fix for the HDMI DDC adapter.

  Major changes are:
      - drop the deprecated DRM simple KMS helper dependency and initialize
        the encoders directly,
      - handle the drm_encoder_init() return code so that a failure no longer
        goes unnoticed or leads to cleanup of an uninitialized encoder,
      - take a module reference to the DDC i2c adapter so that unloading the
        adapter driver while in use fails gracefully instead of blocking
        uninterruptibly.

Please kindly let me know if there is any problem.

Thanks,
Inki Dae

The following changes since commit 82cb10c8bc506a4d2093e0e59672fd307f549d38:

  Merge tag 'drm-xe-next-2026-07-30' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2026-08-01 07:06:36 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos tags/exynos-drm-next-for-v7.3

for you to fetch changes up to 99b1947ba2f82b30c0a4ef3e457eacc31d1b0220:

  drm/exynos: hdmi: take i2c adapter module reference (2026-08-02 14:54:06 +0900)

----------------------------------------------------------------
  Cleanup and modernization for Exynos encoders
  - Remove dependency on deprecated DRM simple KMS helpers
    . Replaces drm_simple_encoder_init() with drm_encoder_init() across dp,
      dpi, dsi, vidi and hdmi.
    . Adds per-driver drm_encoder_funcs with .destroy = drm_encoder_cleanup,
      removing the intermediate layer between the drivers and atomic modesetting.
  - Add error handling to drm_encoder_init()
    . Checks the return code at every call site instead of ignoring it.
    . Prevents silent encoder creation failures and drm_encoder_cleanup() on an
      uninitialized encoder.

  Bug fix for Exynos HDMI DDC adapter refcounting
  - Take an i2c adapter module reference
    . Switches to of_get_i2c_adapter_by_node() / i2c_put_adapter() so the
      adapter module reference is held while the DDC bus is in use.
    . Makes an unload attempt fail gracefully with -EBUSY instead of blocking
      uninterruptibly in i2c_del_adapter().

----------------------------------------------------------------
Diogo Silva (2):
      drm/exynos: Remove dependency on DRM simple helpers
      drm/exynos: Add error handling to drm_encoder_init()

Johan Hovold (1):
      drm/exynos: hdmi: take i2c adapter module reference

 drivers/gpu/drm/exynos/exynos_dp.c       | 13 +++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 14 ++++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 11 +++++++++--
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 14 ++++++++++++--
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 20 +++++++++++++++-----
 5 files changed, 59 insertions(+), 13 deletions(-)
