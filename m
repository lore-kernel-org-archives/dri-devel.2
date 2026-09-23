Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A848CC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FC410F933;
	Fri, 25 Sep 2026 07:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TdqfDPK0";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5557710F1C4
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:59:00 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 00721157ae682-85d43ac6072so25111277b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790197139; x=1790801939; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LFuywSZ0HejhAW2U3ki+Jb3nu+U7WqN5bFOUzp+xE1s=;
 b=TdqfDPK0Be5VxBNmTDVlWxjOU8BdE4+kKU/JgQHUHUjuk/qJX4spq5QPAazgpOuSvV
 N9/89F4pb3h19XicDviaBPR1ERuU4H9Q7NYsuwMHLMXy1i2PZ3ahHWVlw+rxVSLf2+6z
 f4iHudc2MxSnlwkJzi1oR9Z8C9kpHAzu9CXvSkWFyGHRAj1uszGKeQQ20dIVKKKPk+bE
 iBzdZ6AXHprzEbSS/do8lRI5YvjWTHTlhGnXUcvSjiIDWFs8tY2Y9u9MXF0mshu6X+7l
 /Skt+iu1W/j9V6ZhT4eFKfsYkLA6tlY7qnN8ATihyRPF2TwFtzPJsU3Q55i1bI9zLANh
 tkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197139; x=1790801939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LFuywSZ0HejhAW2U3ki+Jb3nu+U7WqN5bFOUzp+xE1s=;
 b=lOm+BLW97nZHZqkreI8N+NbXvWzTVcG4Evlxl3S8rrFdFHQ1wqNhzRRCr93K7u/zlo
 H+Y+cl1+OBMU5d+NUAUs2kagtTU514EI2sr/CV8XxOOg0V0mcERlDX35v4pgBG876EM4
 A+G+XH5RinZOy6+rCru2bVDsCevdnD5VwVc34aCuzfisWCeDfsrutNVB+PQDjIx7DvZ9
 jcfUBIQHZtT3um2LhC20ZX8Dcj/wPVt8e+WMwXdye1NA3kLzUBEEBvJtsjEyuwtWYxZ/
 e1tW9bnBOqdcPXtBBE+DZxEo8AkbUeBvPzvErFW4yw/U67HdtBSSbGQZktDND04lCsIQ
 uG8w==
X-Gm-Message-State: AFuF++lzLKX4xagJbu2ZnW7oL/JQyQZrVPM0BuKibTi9eRe82uwl69mH
 HgBiVhpUAQicUA6+tjaf/1JezF4VShsV3tNP4TJWNz9CRL/Tipp/DLSZexex06Ko
X-Gm-Gg: AYBFou0c8xyrpc/2gXB75nbA750zFI/16aP9L1Wvz1V0DLP6fMtEX78Wep86GkkGMoa
 0Gzrb8CcteMPs9HNIAsHzwpYUNYMmka2vJCKLuWuojmqBoCBfXgSJUXywi9nJIARvS0wPTqfuvM
 aOtvLYGyVfgUr9ly/XuP3bOVy/e7f7j34XlyJKTiUxlV2j/5BDtIwII4kiNUqC5i4WYSL2LzGLL
 ujv6sL/B1CRvYzRztZVmbRM8RGgAjOFlrTJ9phQY2CNmHaHFxMgsZiUgNWUC0g5kD2F8qn7JCdl
 FsGEFClPqS0NIKawmJZ/mh+oAy6wNQS7u45SWNsa0wEKrgBydv1tuKLsQxHu0CfEQ3NbHFeptCd
 heCRlVhvNGd2VCQgT9fO8bvQBgCLHIPmXgCLr6VLxiKLGENqQRdy4uV1LjV5AHPKhQtiDARu3d/
 /E4lAzCf0QKnMfdOtBAvbP5WeDWW0srxuj49jDsnTY/pQQUucTiVAK/qzfVm4BcAk6jmssiwaPH
 CHdmfN1Xw==
X-Received: by 2002:a05:690c:ec5:b0:884:b55c:312 with SMTP id
 00721157ae682-8a648ec512fmr3446857b3.16.1790197139130; 
 Wed, 23 Sep 2026 13:58:59 -0700 (PDT)
Received: from DESKTOP-TLFH1MG ([76.255.203.42])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a65270b1e2sm1073467b3.41.2026.09.23.13.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:58:58 -0700 (PDT)
From: Jonathan Frazin <frazinjonathan@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kamlesh.gurudasani@gmail.com,
 lanzano.alex@gmail.com, phil@raspberrypi.com, linux-kernel@vger.kernel.org,
 Jonathan Frazin <frazinjonathan@gmail.com>
Subject: [PATCH v3 0/2] drm/mipi-dbi: display a cropped region of an oversized
 framebuffer
Date: Wed, 23 Sep 2026 15:58:32 -0500
Message-ID: <20260923205835.3505-1-frazinjonathan@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

A drm/tiny MIPI DBI panel can currently only scan out a framebuffer that is exactly panel-sized, always from the origin. This series lets a client allocate a larger framebuffer and choose the displayed region via the plane source rectangle - a crop / pan with no scaling.

Motivation: feeding hardware-decoded video to a small SPI panel. The video decoder emits a fixed frame size; being able to point the panel at a panel-sized window of that buffer avoids a full-frame CPU copy on every flush and lets userspace pan/centre the image.

Patch 1 is the actual fix - mipi_dbi_fb_dirty() addressed the controller in framebuffer coordinates, which is only correct while src_x/src_y are zero. It now subtracts the plane source origin.

Patch 2 raises mode_config.max_width/height (pinned to the panel size) on the six drm/tiny drivers that flush through the shared drm_mipi_dbi_plane_helper_atomic_update(). ili9225 is excluded - it has its own flush path that does not carry the source offset.

Open question for patch 2: the six drivers each set the limits identically in their probe. This could instead be a shared helper (or folded into drm_mipi_dbi_dev_init / the DRM_MIPI_DBI_MODE_CONFIG_* macros) so future drivers get it for free. Happy to respin that way if preferred - the per-driver form is what is shown here because it is the smaller diff and easier to review a first pass.

The min_width/min_height, the fixed mode, the connector and the mode-sized transfer buffer are all unchanged, and drm_mipi_dbi_plane_helper_atomic_check() still enforces DRM_PLANE_NO_SCALING and no repositioning, so the flushed rectangle stays bounded by the panel regardless of the framebuffer dimensions.

Tested on hardware: ILI9341 and ST7789V (through panel-mipi-dbi), both 240x320 - an oversized framebuffer is accepted and a non-zero-offset panel-sized window scans out correctly; a panel-sized framebuffer is unchanged. HX8357D was tested during the downstream review by Dave Stevenson (Cc'd). ili9486, mi0283qt, ili9163 and st7735r are build-tested only.

Both patches have been carried in the Raspberry Pi kernel (rpi-7.2.y) and in use there: https://github.com/raspberrypi/linux/pull/7589. The v1/v2 heap-overflow fix (see below) has also been folded back into that downstream kernel: https://github.com/raspberrypi/linux/pull/7643.

Applies to current mainline / drm-misc-next; the touched files are identical there.

Changes since v2:
- Patch 1: a damage clip that lies entirely within the one-pixel sliver
  the v2 clamp cuts off collapses the clamped rectangle to zero width or
  height. That was still being passed to mipi_dbi_set_window_address(),
  producing an inverted (start past end) address window ahead of a
  zero-length write - undefined behaviour per the MIPI DCS spec. Skip
  the flush when the clamped rectangle is empty.
- Patch 2: st7735r also flushes through the shared
  drm_mipi_dbi_plane_helper_atomic_update() but was missed from the
  original list - it lives under drivers/gpu/drm/sitronix/ rather than
  drivers/gpu/drm/tiny/. Added it, and confirmed by grepping the whole
  tree for DRM_MIPI_DBI_PLANE_HELPER_FUNCS that no other driver shares
  this path. Thanks again to the automated review for catching both of
  these on v2.

Changes since v1:
- Patch 1: clamp the damage rectangle to the panel's fixed mode before
  using it, instead of trusting it to already be panel-sized. src_x/src_y
  are the plane source origin truncated to whole pixels, but the
  rectangle from drm_atomic_helper_damage_merged() is clipped against
  that origin's exact 16.16 fixed-point value - when the origin has a
  fractional part, the rectangle's far edge could land up to a pixel past
  where the truncated origin would place the panel's own width/height,
  overflowing the panel-sized tx_buf. Thanks to the automated review for
  catching this.
- Patch 2: unchanged.

Jonathan Frazin (2):
  drm/mipi-dbi: honour the plane source offset when flushing
  drm/tiny: allow a framebuffer larger than the panel on MIPI DBI
    drivers

 drivers/gpu/drm/drm_mipi_dbi.c        | 43 +++++++++++++++++++++++----
 drivers/gpu/drm/sitronix/st7735r.c    |  8 +++--
 drivers/gpu/drm/tiny/hx8357d.c        |  8 +++--
 drivers/gpu/drm/tiny/ili9163.c        |  8 +++--
 drivers/gpu/drm/tiny/ili9341.c        |  8 +++--
 drivers/gpu/drm/tiny/ili9486.c        |  8 +++--
 drivers/gpu/drm/tiny/mi0283qt.c       |  8 +++--
 drivers/gpu/drm/tiny/panel-mipi-dbi.c |  8 +++--
 8 files changed, 80 insertions(+), 19 deletions(-)

--
2.53.0
