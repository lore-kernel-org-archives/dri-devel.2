Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA00C106F313
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC8D10E9E8;
	Thu, 26 Mar 2026 09:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QIau6ry+";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F06910E960
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:43:18 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c766a95a72dso586802a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774518198; x=1775122998;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8lf5f+G0S/Ym9PSzIEzaYi3iHD/hBsSPQKrLmQgNjdI=;
 b=QIau6ry+q3qlxNDL0hSUQ/cDB843TeMKQCB7F7NhHdxwFC1xFKZLYQeV3OxzN1dKdB
 +3PuqJ9tQZO22Z5GvVH4v/YaUe4qrGzAJ6TlZ5Z/YLrlVAJVT5wEY5Gf78MQ4BiYoHEd
 vzErWBc0X/WdQ+M9W6B7yrsqKD6t7ZP6Rrm6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774518198; x=1775122998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lf5f+G0S/Ym9PSzIEzaYi3iHD/hBsSPQKrLmQgNjdI=;
 b=o2QFq5CFgKl3p/Gep2PHtiJI5/MJ+lS7eunYeYE1m9bRb7pM87qtlGny6gKrEFEhhI
 92V+8AkLn7fBAqHSsebJJRGzkO3+ngu7mmTrJadyOq0B27c2L/Ykhuj4ABHIhkEcKLpA
 phAeUVuXon5vqzNJidbipvxfx9XqRWXt7eFRUFRmJcOphsOgV2mjiaSWL9Lo/vLxSE8m
 42po7y8/pi1ZMARue6eo+T3cG+CiOmJfPgGAxd7RGDbxr9Jx0i0zmSlWhMyh0DNRRA5L
 AE2viUXUd2nspV3FE7tMYG6wZOts+jGchc7/OebEq20ma4gvi5XF+5okEt956YJscSoP
 IVUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKv9gV+VoVqnEJLAfN0sbJutAap1cnmQGBhNlqaE5wwZBsvOx90IZ9GKgzk3gdTa0KsN8wykfKgdY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLPUWhjFmAkETtnn4utQchVZYo6qgJCqPBNdh18BO/cN3l0jOz
 35jQDoKrVflHBKZO6IDbmYEuX7ovU0T5nCLpr9eW8VkiBIioGz0eCXS6MbGW8GWBig==
X-Gm-Gg: ATEYQzzyP/KmcNN0lfLctDwjBipw4rCFVz5hbyPsbnrD3v2jOnzpBFw+5qz7nZ8zslj
 SE6d54tGEcs6X8hyr/JFvs1wfXacDV+L5FbcgrBRMKb7PIwzsUHYJ34pg6qYmxfYTb2tHo5Oeaw
 5ckR6HfZUtysxRn/7UJYnSb0qdGwjbSU1iWy97MuYrRP6M5crwKfpnVEa9REcvcTjAZC8NmOsyj
 o7uLh9yZG3VtiX6FAbxe99VzdEyfjpgtJKqb+Qzm8iioWBrPSKz031RhEd8La3uF3TUePOnt93x
 6h/PqImKuC4PnVl45vmHx8N660qh7+OhtUS6oVUfUrCmijk5qIg930jHyb0GPsGcEdpwhSah3gL
 oaT1osaljICpMbOJcRetYVJE8xIdyYWlX2vYA6JFUxgTSoxUdExxANEr3e7KXETWgHfT33z0mMx
 GWmPXmqB122cahoC+N8mNGEC6t3J/QagIEy8eeLt7x4GcSHAhQKFV3rLeoLgfwrZRMgnQRf9u/M
 LZKRZdxx3JdYxHu+T0=
X-Received: by 2002:a05:6a20:258a:b0:39b:862e:634d with SMTP id
 adf61e73a8af0-39c4ad52456mr7291868637.39.1774518197965; 
 Thu, 26 Mar 2026 02:43:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76737f28fasm1673312a12.7.2026.03.26.02.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:43:17 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/exynos: Random cleanups
Date: Thu, 26 Mar 2026 17:43:02 +0800
Message-ID: <20260326094308.1161335-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
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

Hi,

Here are some cleanups for the exynos drm driver. This was done as part
of the conversion of the driver to GEM DMA helpers. These patches have
no dependency, unlike the actual conversion, so I am sending them
separately for inclusion now.

Please take a look.


Thanks
ChenYu

Chen-Yu Tsai (4):
  drm/exynos: Internalize exynos_drm_gem_free_object()
  drm/exynos: Use DRM core dedicated DMA device tracking facility
  drm/exynos: Drop exynos_drm_gem.size field
  drm/exynos: Drop MAX_FB_BUFFER in favor of DRM_FORMAT_MAX_PLANES

 drivers/gpu/drm/exynos/exynos_drm_dma.c | 11 +++---
 drivers/gpu/drm/exynos/exynos_drm_drv.c |  1 -
 drivers/gpu/drm/exynos/exynos_drm_drv.h |  9 -----
 drivers/gpu/drm/exynos/exynos_drm_fb.c  |  6 +--
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 13 ++++---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 50 +++++++++++--------------
 drivers/gpu/drm/exynos/exynos_drm_gem.h |  8 ----
 drivers/gpu/drm/exynos/exynos_drm_ipp.c |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.h |  4 +-
 9 files changed, 41 insertions(+), 63 deletions(-)

-- 
2.53.0.1018.g2bb0e51243-goog

