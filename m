Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BBDC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4E410F8CF;
	Fri, 25 Sep 2026 07:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mi3DgTrA";
	dkim-atps=neutral
Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com
 [74.125.224.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0311810F16C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:07:19 +0000 (UTC)
Received: by mail-yx2-f42.google.com with SMTP id
 956f58d0204a3-6729c4030f0so1343182d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194039; x=1790798839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SiHJ4k1HZVmizz1HUvNw+RWE7k7KrIF+LVqXP7p65LI=;
 b=Mi3DgTrAUnwVJyHnYWXUIplLs5Fc0x3ZurlZsjtt65S72PNP45d6OvN7pqirYZPLDz
 ETTkDpRmEchLc7vMaXC3zTMAm/qYzDShkyZFVIKaLz16VgeFwztqQiFHtb80+Fgxzpvg
 WWNrQoKO2l1ccJrT3brIdN6JCjqKq6jEakbfmbanHweyUdw/3zumrR4rkzbozVZBIS5+
 zud4kXq+y9EpfSF7PxxTIrFhy+ALULkfjbfcXrvWtwUrJkCTddcqepWSEU0j6+A31Mug
 TaC4NOHZctwpl3Y2eDYjQWfuR/fX6tKeaWpxLiMvWrJN5ozIDTjYshbpLnxKN3n62AmE
 zW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194039; x=1790798839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SiHJ4k1HZVmizz1HUvNw+RWE7k7KrIF+LVqXP7p65LI=;
 b=wgMvKShPtT1DVu1e+gJ07zdsb23q//YS+/+Mduf0DYK0laBsa8ee9AxEFpK/6iJYQ0
 1TvHXdRLCmF9ZvE0YvHo5yYY6D/QcpdveQzLgVo+p3KgSTV5aFhwNmPHvSQnC/N+1m6O
 p3DkQyzUrMp5KP/AFkSpbXlkMOTX78FPem03PVZf3vp+RLhv3H2/fGn+0VxXVCCEhzYk
 yNj48kd5Km8lgvx8q1VxGOFw2+xNWfbvF1Y4Rtf4ogqcAdZ8WAjBno/NYb2OlH5QL4IP
 jLfsFrTV/L6jV2cZIgTJLLvkI7IScANFvIFYhU3GBxnlVoWijdEwsfMGcT1pXQPqSpXU
 L+NA==
X-Gm-Message-State: AFuF++k+RaKNIykECY9bZq8/eFqccLezfdSphq7YM2P6dVdisPnzdIu1
 p+yA8MrqWhMSZun9BVxZ7kkps8Ta9duiWo7q3ZaTmmfCoV+dxKs6sk6u6P1j0Efw
X-Gm-Gg: AYBFou0Jyzqef8K/N3I5By9H5Ixh6KRvzIQNkdVPjGoWA/AVc8O02x/WRQPyQCRl0T+
 uBIKVbwv21zB3qzCVqDrBhls6rolrPhu5muFdxTK8Tfz0R2eODZGR3RwJJvTVAcfVhA9th/1VnZ
 NQdKXgXtXQ3S2O0j0RCP7xUnAx1BYcN7dLccrFqMktR6i/xDo4T8eBi0wCDRadqux19V/l4zsZo
 UCS4eWu8a+o2IoSEtnM0pOt5B9Qs/kDeED5tJt5o6atghw/orT2uD5GhE9Nf8rOl3TQq6YTif7u
 PfolNZE2w/BDNGpy07VZGm6Fxr0UFRv+7Mn2GA+A/HXbDlr1nDlFBQHE1Cbojgpflljf2jffEVb
 lueoJjZbxoUt/a0pq6iRwefVsl0sAe+CHwI5e2OkJZR7PDHVXRWMK41QqNVngQLh3siaOjyMHaR
 a1ILa3bwELS5S4q21IyzHa30A7j1JHbyUffrRVhVguuJg6PkeAag6JZhzDiJrQaH4mqh5eooJ7W
 KvjVFN0XA==
X-Received: by 2002:a05:690e:814:20b0:672:b676:c1ce with SMTP id
 956f58d0204a3-672ed228e6bmr187635d50.9.1790194038864; 
 Wed, 23 Sep 2026 13:07:18 -0700 (PDT)
Received: from DESKTOP-TLFH1MG ([76.255.203.42])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d80bea23sm1221915d50.10.2026.09.23.13.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:07:18 -0700 (PDT)
From: Jonathan Frazin <frazinjonathan@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kamlesh.gurudasani@gmail.com,
 lanzano.alex@gmail.com, phil@raspberrypi.com, linux-kernel@vger.kernel.org,
 Jonathan Frazin <frazinjonathan@gmail.com>
Subject: [PATCH v2 0/2] drm/mipi-dbi: display a cropped region of an oversized
 framebuffer
Date: Wed, 23 Sep 2026 14:57:10 -0500
Message-ID: <20260923195713.88-1-frazinjonathan@gmail.com>
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

Tested on hardware: ILI9341 and ST7789V (through panel-mipi-dbi), both 240x320 - an oversized framebuffer is accepted and a non-zero-offset panel-sized window scans out correctly; a panel-sized framebuffer is unchanged. HX8357D was tested during the downstream review by Dave Stevenson (Cc'd). ili9486, mi0283qt and ili9163 are build-tested only.

Both patches have been carried in the Raspberry Pi kernel (rpi-7.2.y) and in use there: https://github.com/raspberrypi/linux/pull/7589

Applies to current mainline / drm-misc-next; the touched files are identical there.

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

 drivers/gpu/drm/drm_mipi_dbi.c        | 33 +++++++++++++++++++++++----
 drivers/gpu/drm/tiny/hx8357d.c        |  8 +++++--
 drivers/gpu/drm/tiny/ili9163.c        |  8 +++++--
 drivers/gpu/drm/tiny/ili9341.c        |  8 +++++--
 drivers/gpu/drm/tiny/ili9486.c        |  8 +++++--
 drivers/gpu/drm/tiny/mi0283qt.c       |  8 +++++--
 drivers/gpu/drm/tiny/panel-mipi-dbi.c |  8 +++++--
 7 files changed, 64 insertions(+), 17 deletions(-)

--
2.53.0
