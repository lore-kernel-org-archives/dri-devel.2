Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78B9C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C4010F525;
	Fri, 11 Sep 2026 07:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kXng8RmY";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350B110E1D0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 18:50:57 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-8200b55dc47so96301977b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789066256; x=1789671056; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Rfwhxk1A76QniOAI6EKL6UVagwZS9SNuRHfI/gzEVs=;
 b=kXng8RmYvxuhFsdevzvE876F6IDKHAZB/HZ31oPEnYRXl5In2EhqUQ9ZY+ALcGgL3k
 HK8b2X+dbKoDCKokWuIzziNswr3gLeGFEkhLXjFk9yonNKz+pzc5HiQY1Tb8ooB9UEIg
 VIgnHY+BLFsT5iK6f/I5uvkNhmv3KjUTGVDMm0y5Cy6ed68eMX9fbDTtV18fRcLfCA0F
 aRnijjS6arw3+QSJHxWs4eYEs29ppun6IIdv7+5NYNHQT7wVC9S2S9elVwuqtmfaFloG
 6tgFWxs1W1gAmndxs9lVhpXKOq/NQY3qMNHq0QInIQHIGKaPygOsE5AeBE5/yAMw0i8J
 wfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789066256; x=1789671056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Rfwhxk1A76QniOAI6EKL6UVagwZS9SNuRHfI/gzEVs=;
 b=h6jMLBZQxUTsoDrPswMDU+HVFYWGeRRukeNr7/UtUuqciwrSwtuchgzAS/FMyOI1Ee
 DFfuXYVy7TTu53PyhGb0mqZEHEwjUBEuUa+qi1nrwDqHLjgvHnMIenNIe7xx5L92Xe5O
 wqzJfhx0ya7OPyyu5hLq+yS9c9SpTtdxZooDV6BkfPFfaRqSgZ4GftGxD5HaDBrcVvKu
 yZMeQWQVWfKVqLWg4upmhNXgwSeefbnDpKFqRlJCtMMt8C3d+Lx+wZm+ehBqoKhLA9Y9
 dGgrHdgBsZUalXBqNORqQ00B42Yp7OM4DL4J6LccI9F84WR/O7saw+MscKRMT7JRVt5h
 7ALg==
X-Gm-Message-State: AFuF++k/2KRZO91xQqlgARz+zW69wT3IcZAniSKmSRJ4GofnYgxn0nTR
 h9jnUOlE11/TMXT9rE95nev6+DumrK1dPm2tZO5uoh82MLmpWaS7HfCIx2Nv8Kqz
X-Gm-Gg: AYBFou3NOchjafb25Kn0leXUcug9LgOVdbLuRPSUs3gS+divkqbxZWZN64tbP24PxEz
 R83gL5OMJHJZUmJ5Qz4JdcjDE7M+R4aDf0KAaUYR/XUF2qKqNRf8i3eufVxNbVBN6fenjJ0jxmk
 ztXRvAIR8BwAQvM/T9sjiqqqin71gMHUu/uIsslSc62hvNrfes2TI7I4JJw6WcEKu2vnL0Q1Zkp
 heSw8rlZ7aIBbzxw+BDyFQT9ZEIyoB9j2rh/LztVnUzFWuj9DihsDwBmCozvg4T/2MHSpikqv7R
 dAsizOd2EVhN96o0K8l8wzzGTusn3wVNVpQQ/l9LObpFanqGM1X1CCDyNTflH0uVcwldiDT573t
 wLIhlSB4rpiewwgkko1WAiO/H3VuoCDWDjBgVF7OpcT2+cEk3PVNe5kIAyp/LCF4Px4Ik/EpCx9
 pAsVgguaFiCF+6K51wH8z+gb01oN8FmOn8/0w/DEnJzGsaHYmn8QTpFZtWK3cTXK7HEnl2sdLQi
 2TJqg1JSzDC4ajdGVyG
X-Received: by 2002:a05:690c:e3c8:b0:883:2240:7df1 with SMTP id
 00721157ae682-884b2eb25c0mr4391407b3.48.1789066255746; 
 Thu, 10 Sep 2026 11:50:55 -0700 (PDT)
Received: from DESKTOP-TLFH1MG ([76.255.203.42])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-88486086a50sm3291707b3.17.2026.09.10.11.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:50:55 -0700 (PDT)
From: Jonathan Frazin <frazinjonathan@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>, linux-kernel@vger.kernel.org,
 Jonathan Frazin <frazinjonathan@gmail.com>
Subject: [PATCH v1 0/2] drm/mipi-dbi: display a cropped region of an oversized
 framebuffer
Date: Thu, 10 Sep 2026 13:48:55 -0500
Message-ID: <20260910185030.870-1-frazinjonathan@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

A drm/tiny MIPI DBI panel can currently only scan out a framebuffer that
is exactly panel-sized, always from the origin. This series lets a client
allocate a larger framebuffer and choose the displayed region via the
plane source rectangle - a crop / pan with no scaling.

Motivation: feeding hardware-decoded video to a small SPI panel. The
video decoder emits a fixed frame size; being able to point the panel at
a panel-sized window of that buffer avoids a full-frame CPU copy on every
flush and lets userspace pan/centre the image.

Patch 1 is the actual fix - mipi_dbi_fb_dirty() addressed the controller
in framebuffer coordinates, which is only correct while src_x/src_y are
zero. It now subtracts the plane source origin.

Patch 2 raises mode_config.max_width/height (pinned to the panel size) on
the six drm/tiny drivers that flush through the shared
drm_mipi_dbi_plane_helper_atomic_update(). ili9225 is excluded - it has
its own flush path that does not carry the source offset.

Open question for patch 2: the six drivers each set the limits identically
in their probe. This could instead be a shared helper (or folded into
drm_mipi_dbi_dev_init / the DRM_MIPI_DBI_MODE_CONFIG_* macros) so future
drivers get it for free. Happy to respin that way if preferred - the
per-driver form is what is shown here because it is the smaller diff and
easier to review a first pass.

The min_width/min_height, the fixed mode, the connector and the
mode-sized transfer buffer are all unchanged, and
drm_mipi_dbi_plane_helper_atomic_check() still enforces DRM_PLANE_NO_SCALING
and no repositioning, so the flushed rectangle stays bounded by the panel
regardless of the framebuffer dimensions.

Tested on hardware: ILI9341 and ST7789V (through panel-mipi-dbi), both
240x320 - an oversized framebuffer is accepted and a non-zero-offset
panel-sized window scans out correctly; a panel-sized framebuffer is
unchanged. HX8357D was tested during the downstream review by Dave
Stevenson (Cc'd). ili9486, mi0283qt and ili9163 are build-tested only.

Both patches have been carried in the Raspberry Pi kernel (rpi-7.2.y) and
in use there:
https://github.com/raspberrypi/linux/pull/7589

Applies to current mainline / drm-misc-next; the touched files are
identical there.

Jonathan Frazin (2):
  drm/mipi-dbi: honour the plane source offset when flushing
  drm/tiny: allow a framebuffer larger than the panel on MIPI DBI
    drivers

 drivers/gpu/drm/drm_mipi_dbi.c        | 14 +++++++++++---
 drivers/gpu/drm/tiny/hx8357d.c        |  8 ++++++--
 drivers/gpu/drm/tiny/ili9163.c        |  8 ++++++--
 drivers/gpu/drm/tiny/ili9341.c        |  8 ++++++--
 drivers/gpu/drm/tiny/ili9486.c        |  8 ++++++--
 drivers/gpu/drm/tiny/mi0283qt.c       |  8 ++++++--
 drivers/gpu/drm/tiny/panel-mipi-dbi.c |  8 ++++++--
 7 files changed, 47 insertions(+), 15 deletions(-)

-- 
2.53.0

