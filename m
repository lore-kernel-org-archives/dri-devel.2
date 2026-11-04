Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A8606A33E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w3aAYkEr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF3A10FC91;
	Wed,  4 Nov 2026 15:17:30 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EF210FCA3
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:17:24 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8a06b436dffso361024b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 07:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793805444; x=1794410244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YCwuNqbXFThsF/oOnYgkmcQH2aDoasiuuCBabyMEHPw=;
 b=w3aAYkEr30L8tcaD75b5rehYQXuFiqsvmZ0sUIxB5T82V18chGQ/ETOeFyMmQF0Dp1
 IxVqFM9ll8rr0nSeXMYkOdcw9y+TiIBqFKm5n12p2pD8HbMs7JnMlHNMdPy3plqeqzhg
 Hb6OvEZ8NpqcCLn1ni6TIpsNpSGwY0tCy2a5ot9EE0cgE+95V15vaE5vULiz16N6tmfC
 SmrcTKDRoR2yQsCbdFV/sYGrRJkjw7L20lRC4sfXkAjikJIBSA5sl6W0daT62rHkkbX5
 tKyDFOr7y9YZF/wTZkfAwdBcjqWTl2Fmuw9t2wAV2Ze+BoFQs7y8Uczn2LeBtw5z8eSS
 3Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793805444; x=1794410244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YCwuNqbXFThsF/oOnYgkmcQH2aDoasiuuCBabyMEHPw=;
 b=XTyfWSfBbYlQUrZaV0qpPWDDJpI6J4z1zFwf0CIEeG1LeSxB4raOUH/PSh0P5lFcYh
 3GQMAGPO5RnooM0f0vD1DcZZdq9MzaVvi5GbrlBRYKC4shj4rCmLFYxNlpvzwp8sLLNQ
 wLiZe0jOrVh5xbME2Y1W37x117LQIiU2i7LUPz8FU+GWwAm+WdKf+7CKRyNZjGqtmccn
 iHUqlDZdjwtSxpyxZlizPnls8lBwCGNDwp3rVOrBpRV/yIeiwhdtYoxTRni9TufzMGEm
 f/uMPP5sRcGxMfoBRYaybgnZsr7NmMJiWwwer1Y+Vk9a3617kExO+9p26bPZN4A0q6WL
 plXQ==
X-Gm-Message-State: APuU4Z9Dv/stoNOCmvxPv8lBFShM4VlehB51xmQE5tFMZgyfbx4qBo1J
 UIzk2jJ9zR+ENjQpZCEVsnRwhLCKKx0rOBpbBuLa96uSNDEE01cw/CGUUzBlrg==
X-Gm-Gg: AYBFou23s29ILFWpyofsn3INE8Ee/Ew+ME7hTU/hfIxvuJzxXJdLfLl+aTwwarYwCyV
 WtMaUVJLmmaWsg5NhoW2lLykHEX6WeyLYy9FUntbvTOMs7XsUq+0/kQ2RQlkHdPySJmBmpIB7E4
 qk/XulmuxU9RWrE5U2AT6bjIM3Sgafy+PxQ9QPr0/5TctSiMx7qU8sjOsXYv4jrUt4tt80whwdj
 Egw/GyThGlWv1D+qNE4A6f/yL7eoIgG3leWs4uvL8M/MIWccJLcohDltQaWWDc2cfjzejGqbGHw
 fNZQ8IUJM3nTNspzYrPtzGeILlz8Y0HlFQ5gXDZLevC0aSKIJlHXoIhSRoVrwrZJswpcIY9lVE2
 gCkwdjY+3reU8YSC42j3tUo/SkRJjfQPFIF1Qy7MjQ6HwLE9c2AWgWJiNwuigqwzNwfciAT0oV3
 Ow9AWguHHHnS8KQxf5gpxGMKD6sA9KeCY8lRt/Pt6nigBauMVlKXsehid+whcdyf3uEGFXzoTFx
 iq+pbDuxXNLpYB3PTRcK5UtLdu5469OebBgmzh0cOLPhC8VtWYnPFg1OHlnf8z1GPhvO+AvU3u/
 zVWs1qmHHkaywYloWl2JcJ1rw7eEXQiXu0ri/YXaTxX9c4TYNJ9UXKkEpKlgz2Lq1bDbozwgvcP
 TSBVW
X-Received: by 2002:a05:6a00:988:b0:882:bba:8791 with SMTP id
 d2e1a72fcca58-8a9bf71bbd3mr14165214b3a.34.1793805443632; 
 Wed, 04 Nov 2026 07:17:23 -0800 (PST)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:65cc:625f:9c43:1e88])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8b097fdf9bdsm1110555b3a.7.2026.11.04.07.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:17:23 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jie Feng <hjf3108@gmail.com>
Subject: [PATCH v2 0/4] drm: Add MacroSilicon MS912x/MS913x USB display support
Date: Wed,  4 Nov 2026 23:16:46 +0800
Message-ID: <20261104151652.59135-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jie Feng <hjf3108@gmail.com>

This series adds a DRM/KMS driver for MacroSilicon MS912x/MS913x
USB display adapters. These chips are commonly found in low-cost
USB to HDMI/VGA adapters.

Chip support:
- MS9120 to MS9125 (USB 2)
- MS9132 and MS9133 (USB 3)

The four patches add:
  1. XRGB8888-to-UYVY conversion helper.
  2. Register access and connector support.
  3. Atomic modesetting and USB framebuffer transfers.
  4. Kconfig, Makefile and MAINTAINERS integration.

The custom-timing support is based on MacroSilicon's GPLv2 Linux
driver.

Tested on USB to composite, VGA and HDMI adapters, covering both
USB 2 and USB 3 devices.

Changelog v2:
- Reject custom timings with odd active widths for packed UYVY output.
- Mark only one timing as preferred
- Keep rects for UYVY conversion even width

Ho Jie Feng (4):
  drm/format-helper: Add XRGB8888 to UYVY conversion
  drm/ms91xx: Add register access and connector support
  drm/ms91xx: Add atomic modesetting and USB framebuffer transfers
  drm/ms91xx: Add Kconfig and Makefile integration

 MAINTAINERS                               |   7 +
 drivers/gpu/drm/Kconfig                   |   1 +
 drivers/gpu/drm/Makefile                  |   1 +
 drivers/gpu/drm/drm_format_helper.c       |  50 ++
 drivers/gpu/drm/drm_format_internal.h     |  19 +
 drivers/gpu/drm/ms91xx/Kconfig            |  13 +
 drivers/gpu/drm/ms91xx/Makefile           |   9 +
 drivers/gpu/drm/ms91xx/ms91xx.h           | 221 +++++++++
 drivers/gpu/drm/ms91xx/ms91xx_connector.c | 267 +++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_drv.c       | 528 ++++++++++++++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_registers.c | 393 ++++++++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_transfer.c  | 222 +++++++++
 include/drm/drm_format_helper.h           |   4 +
 13 files changed, 1735 insertions(+)
 create mode 100644 drivers/gpu/drm/ms91xx/Kconfig
 create mode 100644 drivers/gpu/drm/ms91xx/Makefile
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx.h
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_connector.c
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_drv.c
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_registers.c
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_transfer.c


base-commit: 476d658928af91f5ccb455957be60763d8b00fd3
-- 
2.55.0

