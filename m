Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D752CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18A6112B59;
	Sun, 31 May 2026 13:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bgfInvxP";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0DA110E0E0
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 07:36:22 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-842358aaf36so153044b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780212982; x=1780817782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n4UPEtYv85DDTxdGxZ3GOa4tyKg7+fMqKk+6YoXF2Fw=;
 b=bgfInvxPOTabSjS4pUSJUVOZr0J/MxjE9apN8GJ8ys0ECmoA+u+E5iQSQILzK4fyRA
 i3XLqM17z06VfkIilne/r5xIukF3SjtT2WEAcfldJRcBVfTgTDdXfID87OZzYQ7keuii
 9D4XeEFS5B4cp67q1xPAFh9pcD+mrYF0wbFJGPEIkoxUxJbSxgSmhU+FOsMQozjpxfmB
 Au7nl9A4YqisUKwTyZYeLC+suPDqQmIyaRvhwV7MAonkIMfXFkfNSpEfO8vZPEEioN1/
 UN1BjVsBwGFY1rAAcB9SUyoH6Ln8zcF6Z5hutnyBLw+Qrb98m8RhyvuxAhvYYFqWTPVw
 xyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780212982; x=1780817782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4UPEtYv85DDTxdGxZ3GOa4tyKg7+fMqKk+6YoXF2Fw=;
 b=GlzUacydu3xjeUs3L+g56wfSWEe1GJs+0Y/w4/NNZwyJJIrxoN37vWvgrtrdxJPgd+
 3PDBCGNKrlkUjfNgpZjmob8RgdPK2SoDv592s2eyAbe/kVYy+Rbru9g+b5dEXTtFe87w
 eszFsWE9ceCNIvXWiqi7GGhEx65I3OvhiwViNQwVbd5lCKRMbYEfNnYul4KCgkTMejRa
 /kVSOIMjSZnjrQ+dI4wHQA39/SV9d1y5AoMaPiRCLIDD589FLAN9jIXWPuNrRJb/Sur7
 kfE80gqYoKLrCrvTpeADpNnDxnWIK0qFYQzZWKZjw+AwgtglDvHOdE2dD9s/ykLdaywi
 sliw==
X-Gm-Message-State: AOJu0YwOaljnT20zTD4wfrr7ixxN2Zc9yhQ9pHvDXh5ohU2aUXafn8tl
 oj812g711gWg8VavT1V2iAKtez3S1kUJxWtKwkllueiKKAyieOThQIk+R4GfLO+v
X-Gm-Gg: Acq92OEiyuQ97UBeRt9rmjVBmMMCDIky4RbWL4mjkI9c5ASqPMvdo+FPb9/v/Yh/L6b
 8e6U3Dyskn9OPbCM9OI1xpYtyEzW3jfpTl/YMoBNr7cg4m/72/lJipQNia1DT454/ptMgpAGMqT
 57oiPS2am2zp0+zLae+FFgQlgHryfKPJV6jaeY6Q1cY6RvM4H7RpkSRkDyuPwP5OaFwhlS2VxRy
 t6lavM3e0qApUSI4+Jcke2Lq3LPx975BymBrBBI/lI0facm09JZx7XUxXDvLtU5UzBe5Gp61Dda
 sKQPGJzZPldbk80uvfVmAvqTyoTlt21AVlkifS2S/9Q15p0Q/fGctPzuWxpDyHgTPVQzRZoUOzB
 9pi2rGt33VVC3OVMvvZKKDJNWFy6JQY/w0mQl6zRuoEfz3ej77S+MaqNU8HRVUscBx2jWhZZmO3
 rDzlv/V5bvKKIL6c+AE6oOd4mMIwt+XM0EaG0srjZBpg==
X-Received: by 2002:a05:6a00:1d15:b0:835:3d5e:1dd3 with SMTP id
 d2e1a72fcca58-8422579f2c6mr6160781b3a.42.1780212982185; 
 Sun, 31 May 2026 00:36:22 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8422e712309sm3760709b3a.59.2026.05.31.00.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 00:36:21 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, stefan@agner.ch, alison.wang@nxp.com,
 jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 0/6] drm: Open-code drm_simple_encoder_init() in several
 drivers
Date: Sun, 31 May 2026 13:05:26 +0530
Message-Id: <20260531073532.8609-1-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

drm_simple_encoder_init() is a thin wrapper around drm_encoder_init()
that provides a simple destroy-only encoder funcs struct. This series
removes the dependency on drm_simple_kms_helper in six drivers by
open-coding the encoder initialization directly.

Each patch adds a static drm_encoder_funcs struct with a destroy
callback and replaces drm_simple_encoder_init() with drm_encoder_init().
The drm_simple_kms_helper.h include is removed where it is no longer
needed.

Drivers converted in this series:
- fsl-dcu
- tidss
- virtio
- meson (encoder_cvbs, encoder_hdmi, encoder_dsi)

Naman Arora (6):
  drm/fsl-dcu: Open-code drm_simple_encoder_init()
  drm/tidss: Open-code drm_simple_encoder_init()
  drm/virtio: Open-code drm_simple_encoder_init()
  drm/meson: Open-code drm_simple_encoder_init() in encoder_cvbs
  drm/meson: Open-code drm_simple_encoder_init() in encoder_hdmi
  drm/meson: Open-code drm_simple_encoder_init() in encoder_dsi

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c  | 10 +++++++---
 drivers/gpu/drm/meson/meson_encoder_cvbs.c | 10 +++++++---
 drivers/gpu/drm/meson/meson_encoder_dsi.c  | 10 +++++++---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 10 +++++++---
 drivers/gpu/drm/tidss/tidss_encoder.c      | 10 +++++++---
 drivers/gpu/drm/virtio/virtgpu_display.c   |  8 ++++++--
 6 files changed, 41 insertions(+), 17 deletions(-)

-- 
2.20.1

