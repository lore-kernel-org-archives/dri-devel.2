Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DAECD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D606B10EE46;
	Thu, 11 Jun 2026 10:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BIgdN4GM";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C5410E500
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:44:56 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso3886654f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781109895; x=1781714695; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x0ZhyVKPYXfouIkDEL5h/2950Heo1BZVs//qWyHlTrY=;
 b=BIgdN4GMoRayzuRG4B+6DBgSB7VEIS5Ei5PnstkMNWFdRANM/qxnZmdJQLaQTKMdyX
 QqFr7RmgVRkVf4bO7IHcdJwa6iXnthCayD9bZ5IvDjDMvbB7yZGr1SE+8HTtwWWw4vpU
 JirXKHmrPk5G3aE31N5x4YbFftxwvfOMI14gSwiH1bKNinujKb1NJDtLe0hssXr0Parl
 i7fffX22LIDkTmDqYhwkeWyGau0BAGfooBJlMP145k6Yj95Ef2lsNaTABqGqZx2nkENi
 1naZA4ywGoKHS4YkfnoOYpMxrhFhcOoSVdrb4ZAzfwTuW/XY340lJ3fp9WbYKa5tbGk4
 uQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781109895; x=1781714695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0ZhyVKPYXfouIkDEL5h/2950Heo1BZVs//qWyHlTrY=;
 b=ZaCYaR+5GCfxSv2I1DC5EbuBRyu4vuVx8yiy0Wz8hj5h2XdX4HwbqONy+OZiIYB6TD
 6sIBpdQTA4Bt3eP+os5I8uHDuIT/myDjQvFmuaupdPD8myO4W0rTlV6nXylXaHxjkam0
 CSOqbBp9UlLJ9hme90EJmQ7f8dgfzF0man+mSgXJWgRsm1xgPbhykCYsKCnb1fOOQVxr
 UnTMRJ+jbrDH+9hCko7UTMWf7rT46JlnhrEgGiz107VBXsQefGmKaB2jGlCi00+sIF8v
 D62RaXG1PJqdxFDtctAA8ZQx6zHcwLHlQ51qrTJ83UBwYuztw59G1U56OcQ4b5TG0OsL
 RKzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ljOCIF65caghrHDGRIeMoH/eMuuGqN4CBMhIk+XAejbZchFd+0A40DVDx63P6/51iyy8AYT+/DBk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFT47DS2lfcOkHatqHtNhmHoEai1+yG0nniRm027XyI/YrF5Jx
 D0/PYRWmvVnnjwfqhX38lOpEG6UWUBjPl79oCa+wjTwJRRKZsQcWnvO2
X-Gm-Gg: Acq92OFWj8KJvFRUrLfXZvmoPbiSulBvwBb2Ri+Jz5GUuNQFjxIIgEiLItszGb427kK
 Mhf/hcA630AemVykwQr1JuttrCtvVUAHh8cKYB+6sRrcBc/0R/1pIb1f0gmouignPXZDbb7wT3N
 DJhWhbdi0LFse36tBSEq1Wt4ooVrhm2vVzBjuOB5PhpQWCFeImytPiDQYnszbDGucdG9KrxC2/H
 dbar/dlgYk/J1kRR4NSAyYb5fswD8xlGsmB11Ngs39VFS7LfinrZpf4ZkXDxy7Gq0g1f0yx0Rrm
 YOcZyC8JPbnPeziLmPNdkDH/qHaMuzcS333xeqPg+PvKyDFqDhds7LzJXBQbmQJujZgzw38474b
 lgl/EWu2tkxwPDvqCS9Qg0BDCmVV0gNeB0fLq2B+8ccTWQmkWzHWrFRuqXoy8gdRIWTfc96Lb/M
 HvABz3/SHUkIKA4CfXCwaikypAHewCRwtDkFheCaZ5
X-Received: by 2002:a5d:4b12:0:b0:45d:b14b:2409 with SMTP id
 ffacd0b85a97d-460302dcb6cmr29120193f8f.2.1781109894630; 
 Wed, 10 Jun 2026 09:44:54 -0700 (PDT)
Received: from anthony ([2a06:c701:9cfb:2900:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm61156733f8f.7.2026.06.10.09.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:44:53 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: javierm@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 0/2] drm: Add driver for the Solomon SSD1351 OLED controller
Date: Wed, 10 Jun 2026 19:44:26 +0300
Message-ID: <20260610164428.180091-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

This series adds a new DRM/KMS driver for the Solomon SSD1351, a 128x128
65k-color RGB OLED controller driven over a 4-wire SPI bus. The SSD1351
currently has no DRM driver; the only in-tree support is the legacy fbtft
fb_ssd1351.

The driver advertises XRGB8888 to userspace and converts to big-endian
RGB565 on flush via drm_fb_xrgb8888_to_rgb565be(), building on the GEM
SHMEM and atomic modeset/shadow-plane helpers with damage-clipped partial
updates.

The SSD1351 is implemented as a standalone driver rather than as part of
ssd130x. ssd130x converts XRGB8888 down to a packed <= 8bpp hardware
format (mono, grayscale, or 256-colour RGB332); the SSD1351 is driven in
its native 65k-colour RGB565 and does not fit that pixel pipeline.

For the record, the generic mipi_dbi helpers do not apply either: the
SSD1351 pixel path uses non-DCS opcodes (window 0x15/0x75 and write-RAM
0x5c rather than DCS 0x2a/0x2b/0x2c).

Smoke-tested on a Raspberry Pi 4 driving a 128x128 SSD1351 panel: the
display initialises and shows correct colours. The panel's sub-pixel
colour order is set in the controller's remap register, hardcoded to match
the tested module (as the ili9341/ili9163/mi0283qt tinydrm drivers do for
their panels).

Patch 1 adds the device tree binding; patch 2 adds the driver together
with the Kconfig/Makefile glue and a MAINTAINERS entry.

Amit Barzilai (2):
  dt-bindings: display: Add Solomon SSD1351 OLED controller
  drm/solomon: Add SSD1351 OLED display driver

 .../bindings/display/solomon,ssd1351.yaml     |  47 ++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/solomon/Kconfig               |  14 +
 drivers/gpu/drm/solomon/Makefile              |   1 +
 drivers/gpu/drm/solomon/ssd1351.c             | 556 ++++++++++++++++++
 5 files changed, 625 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
 create mode 100644 drivers/gpu/drm/solomon/ssd1351.c


base-commit: 83e8d8bbffa8161e94f3aeee4dd09a35062a78c8
-- 
2.54.0

