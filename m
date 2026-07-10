Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FD1C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E302610E15E;
	Fri, 10 Jul 2026 09:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g2VD1UWv";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E6110E15F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:00:52 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so642079f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783674050; x=1784278850; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qt+LaAqPvwUm1y0oFk6gJUAvHbxtXN/0WfCUetMYAYg=;
 b=g2VD1UWvcRb57VaW8DWcRhBPji921dHMiPluDGy80h2N9PTR3LtY/dw2crSyM8FViH
 9K9cPIQjm8YXYk7p7qxXs0q+/iedUbyMMeygLM0VqHCiahSIFUl0qBxemkgFIQUWgeNM
 2sQ7nW8NFsfi3FDX1R/NGU3emH7Zk63AckXQIoyOZghWcto6yDyr9vhvnIk2PE0nybZp
 SDAZmGM3yUTbZySsNB8tmMQ+lBblzMP7zyexh1pRBS/Zj31GOpp6rtMogIxc6Qh0YdRc
 4lcA4ecIQDlP2s6oPJX0rEm90K7YIgChER+GJufvNfyMESfdmx3tr2a0R7p4aJjz4Y1k
 hSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783674050; x=1784278850;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qt+LaAqPvwUm1y0oFk6gJUAvHbxtXN/0WfCUetMYAYg=;
 b=pyBHK/e7BBo47pzmkKPbUMzb0kS+NYCdq71n3UajzEQ3LO1IQd6MOTcpBWf6bZEP+x
 ZqAWYB5NVn/UUvV9q+AwfZRCgL3nLpoEU7hKBLmAdCyVJeieRHKiq+Lcl1dkfVorYN3x
 x5BLEv8FfTXlk6JsJt4cGcNzMGTpIqyrpIsUWj7KF0m06CdKhMrZDKhwI/gIJirJJEsI
 /mpZdbVqNT9gmtmE3WAvH4v99Twh7ZHkD/gtp8KNajdZXuZbXy6d0A5SGnhDBTlBJCXt
 W0awXiB4yB9ryyTMtDH/U7sonaPhtdEawNzHevPbCZlsOKv6Clhri4RThjMlAW4OxwxT
 aovA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpo4PuQexsaKEz6pB2F52NMC3lGYvOQb0gywpIxEwpH42zh0hyEWXc5PqdHfbiZa6X/bEpZrb65KT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYqsBL5EG3uFxTAP+rwPknjp7LTK2190Kj05BV7zQqyVz4Wh4t
 i7zF+wuqODDrcx2S6F6oiFuoenPu9fTGIFTES/wWwOCwy6Wc3maX8xpw
X-Gm-Gg: AfdE7clu/6zKa8il7RpWe5tRgk+D0M4WuYrzvjxWTak0Ieik339oQW5QIzOCrgNV7Gq
 y8OppaflbQ2zjMYyCnWyZNoGTs9wFbR7sfHs8n++Dt5ixEZY4ZdIT7exkMrwDttaKHm2tjoQ9Wr
 299FS8HZTyI8Vaqvtzald7OASMl3UVQtA6v8VlmS+KZY3MZtZtKs8OYPD9GPP4uqVFu1dVbNG7n
 JnQG81VR3CvMYshv+s6n+EemAL9XlldI114IC5VmhDfmTqooUrn2dwh1nBxIm5tFwftagtPqoul
 v6uaxo/VxlHOdGjU6oMmn8nx8bp+RCt6u1pgmfKWq7IwSMtpvKD5sBfyfqIPQnapct9bR4i4f2k
 dFCACZ3VXXhWB3UjKoM8x7LQOLzeEFTE1rVq5k0/BqqzGq25JchMjmyH8rXH1lBt6WdV77y4NSo
 Eg4vu1tcBYXtzP7QpDcAx2RUAjvViilhGCeq/Q7ychPZUndHvzL22BXV4mAOoEzCbAC2dA7r87p
 lH0OCQGr3l9Cff7VgN0Ip+O0c6OHzC6Xg==
X-Received: by 2002:a5d:588a:0:b0:475:cd6f:721e with SMTP id
 ffacd0b85a97d-47df07a2965mr11282514f8f.44.1783674049819; 
 Fri, 10 Jul 2026 02:00:49 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at.
 [62.178.82.42]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm59386076f8f.22.2026.07.10.02.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 02:00:48 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH v2 0/2] drm/etnaviv: Add GPU reset counters for robustness
Date: Fri, 10 Jul 2026 11:00:45 +0200
Message-Id: <20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQrCMBCG4auUrB1J+pO2rryHdDGN03ZAk5KEo
 JTe3Vhw6/L9YJ7ZRCDPFMSl2ISnxIGdzVGeCmEWtDMB33OLUpZatrIDihYTJ/AUKIJ1kSc2GPM
 ZjLJqVVOhQhxFBlZPE78O/DbkXjhE59/Hr6S+64/t/7FJgQRdG63autd90115xgfj2binGPZ9/
 wBudgQ0xQAAAA==
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

This series adds two counters and a RESET_QUERY ioctl that returns both
in one call:

- a global counter that counts every reset of a GPU core.
- a context counter that only counts the resets the calling context was
  guilty of.

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
Changes in v2:
- Replace the two GET_PARAM values with a dedicated RESET_QUERY ioctl
  that returns both counters in one call. The ioctl has a flags field
  that must be zero for now, so the query can later be extended to name
  a specific context once a DRM file can hold more than one context
  (Lucas).
- Make the reset counters plain u32 instead of atomics (Lucas).
- Use __u32 for the ioctl counter fields to match the internal
  counters, following i915 GET_RESET_STATS.
- Link to v1: https://lore.kernel.org/r/20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com

---
Christian Gmeiner (2):
      drm/etnaviv: Reference count struct etnaviv_file_private
      drm/etnaviv: Add GPU reset counters

 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 44 ++++++++++++++++++++++++++--
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        | 12 ++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  5 +++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h        |  2 ++
 drivers/gpu/drm/etnaviv/etnaviv_sched.c      |  3 ++
 include/uapi/drm/etnaviv_drm.h               | 19 +++++++++++-
 6 files changed, 81 insertions(+), 4 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260708-etnaviv-reset-notification-b037153a1aab

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

