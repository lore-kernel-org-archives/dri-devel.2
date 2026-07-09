Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A6EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C6110E6D6;
	Thu,  9 Jul 2026 14:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YEhMmHg0";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B28C10E6D6
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:57:57 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so8109715e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783609076; x=1784213876; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2uYvJ99V7OcwcA873bLOHoWJoXNW9jnVzYVBsOqs+A8=;
 b=YEhMmHg0FXh3JhLNRafGQqXZaahx6HhpOgWWUUq4y1KJQwDu/oV0S0kRBV2/8ri9Ws
 N5J2dIzRenKvkyOJbIva9Cpoc24txB5F6Snylrff20Sgh8z8ecO5/d2HdnCAzpJ6PBsW
 Cf21xnNBQJG6TOXAwq3I62aH0SdAmvFpEVSC4mhOvt6d1OyySAw5o7heZrB1MPHGJI8V
 JUV6gEErOCQc1R4ZV/AGZgXg18h8qfnKEGSn7SLw+g8DZpxExeVtJelGyXumnq4tHxPD
 LRGVSrPCWTS0EtgnqeNE5q9tffd+S9JGyYGnKH7VM3ElyBCmDigTtcBv0z/h4JeZzNj1
 Yh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609076; x=1784213876;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2uYvJ99V7OcwcA873bLOHoWJoXNW9jnVzYVBsOqs+A8=;
 b=g3VfMUwBbQq7wkTkcp7u0uZ7rdjfTK419qY5uBypvpSpWvmKItz9/4F8Buq0i2UuDc
 uNNWzCUBh+fMtlPL9ZMQULjGRhCCafeAn8dA4DOFwNXN6BsdtS+M8xpWa9T3a1ak+Uyl
 8XuNQuBuHWuNRayAgteuf7H95WkvcA0U2KI3+TPkOpUY4S1/BakQUx86i39ptWJVy3lj
 3yaJfR6KpSn/AhQ+BVH4x9RmvlMmGio/2xAZFHuTpGowyzN2Ru2mJnpPksSbQkAK6ClB
 Vx6nqkUOYpDDxtsuykSJarOxRoinFNX3nGNavFyAMZidKnAEDCMQ8wpAbq60Wrmg6lq6
 HL/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPk7rX1ey+uNbqt8IdEQKaOQd2np1cCUM1IPlWBEcyPRt4Olh9CNzy92SH3ukH2IcGkwEIlhKVRRQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpstpCFkxAPHYNKLAPDoSCW5iygov9pkFGGXNEgh0Fmy0XXIjl
 qiDccr5ayoXObLt8Kx+6Xf92fTY0FKxZVrAU8W4CMy+jzRcKtcm5FHvL
X-Gm-Gg: AfdE7ck0CuyWff8d8AqIxJADk5FoOuCsyrwP/fDUJxQ3RZ1lsVktIofadtDxhGLsvjd
 mFsyCtlOosO4fnv5t7fLmJrS0+TyEvyUw17rr+VOswmu0b3cRsXsRXXWNGO1RuOZZTdUIpZiq4R
 0DdqL9nTn6tvZ4ssgu4hhxvd/ya3pkV+9DNwc6KSnTWMRPcogHZ6sSNeMl3beTURWEKkk8Z6kZv
 GPiYQrDF670fnXXkHf7bmBmeYjbOzwrCFi8qckJAMUB+kOUIzloLFEamZXij9n5ESis8m79YBSh
 D+0f1V3aMFK0hJVcEQifQyCoNDnT5afknpbs05nF9VQoel77pKm8JjEpJ/M1nKIeRWrrFnGpQoJ
 H+Ab2Jk+izSYBHuaeTtzLrrZ//vPNGP+iBjO0kKJ/Bu/P6Mr5FJhAzoHdQrdeKCoJW1XKnbkIvP
 Aq1gg0ysCmqGtEvj06zeEPaYgrMeQxQjUw8cfsmSiJ/VTPXsXgs1FEM1FCjvckCkhwbCO7CjsTe
 Iugn/uUF4tPmt5MHUvfGtJMO27Vj1dzUw==
X-Received: by 2002:a05:600c:8709:b0:493:e4ce:acd0 with SMTP id
 5b1f17b1804b1-493ec667544mr34169015e9.1.1783609075884; 
 Thu, 09 Jul 2026 07:57:55 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at.
 [62.178.82.42]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a572c3sm162226435e9.1.2026.07.09.07.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:57:55 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 0/2] drm/etnaviv: Add GPU reset counters for robustness
Date: Thu, 09 Jul 2026 16:57:44 +0200
Message-Id: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBvQpB+6SrQYbarZWKhIIN09a
 fkt3isQOQhHmJsCgbNEuXyFbhtwJ/mDUbZq6FQ3qFFNyMlTloyBIyf0V5JdHKWaoVVm1L0hTWS
 hDu7Auzz/fFnf9wMshI8ebAAAAA==
X-Change-ID: 20260708-etnaviv-reset-notification-b037153a1aab
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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

The OpenGL robustness extensions (GL_KHR_robustness) and Vulkan
(VK_ERROR_DEVICE_LOST) let an application detect a GPU reset and check
whether its own context caused it, so it can throw away the broken
context and build a new one. etnaviv already resets the GPU after a
hang, but userspace has no way to learn about it.

This series adds two counters, exposed through GET_PARAM, following the
model already used by msm and v3d:

- ETNAVIV_PARAM_GLOBAL_RESET_COUNTER counts every reset of a GPU core.
- ETNAVIV_PARAM_CONTEXT_RESET_COUNTER counts only the resets the
  calling context was guilty of.

Userspace samples both values and compares them later: if the context
counter moved the context was guilty, if only the global counter moved
the context was an innocent victim. That is all that is needed to
implement glGetGraphicsResetStatus() and Vulkan device loss.

The global counter is kept per GPU core and not per device, so a hang
on one pipe does not look like an innocent reset to contexts that only
use another pipe.

The first patch is preparation: the counters are updated from the
scheduler timeout worker, which can race with the DRM file being
closed, so struct etnaviv_file_private becomes reference counted and
every submit holds a reference.

Link to the Mesa MR implementing the userspace side:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/42826

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
Christian Gmeiner (2):
      drm/etnaviv: Reference count struct etnaviv_file_private
      drm/etnaviv: Add GPU reset counters

 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 22 +++++++++++++++++++---
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        | 12 ++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  5 ++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c        | 12 +++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h        |  6 +++++-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c      |  3 +++
 include/uapi/drm/etnaviv_drm.h               |  2 ++
 7 files changed, 56 insertions(+), 6 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260708-etnaviv-reset-notification-b037153a1aab

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

