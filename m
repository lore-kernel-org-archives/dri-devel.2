Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF912C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A4B10F882;
	Fri, 10 Jul 2026 12:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NplBuogt";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E8C10F86B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:03:47 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so844010f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783685025; x=1784289825; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hksPX1U2TBlTextUaSByNI1aeIBAxfzf3b6cw/OY5vY=;
 b=NplBuogt8bSAPEuAb77jfOVj/DEH5IYq2dd2YkQRPkGlU9f1lusHfYeSTukzOUU6bB
 VHFAG5EUWXBcooW5NkqNlVs9LIQheLmtjNM2mwhIPKhPxpF2t2HxHYxhtRsGmTtIDoL4
 j7wBz+fpU0BD6GHdEI/cf6kFJ7Ecev9kQUD41ReSRLc59hwn+w+U1pN3qGD+bpzYdts2
 W/2gOMT2VFpqrtdp3VnGe4AV9ByCwRM4qksi8TMhDMUQ+m/jW2uGb8t/4g55Bjj6GlBj
 9n7kxdAlndwzrxvB35oD4ozaWCbzStYHOwfURkrPflaG/NkjizWf9i1wD0qDI2DC7a17
 4WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783685025; x=1784289825;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hksPX1U2TBlTextUaSByNI1aeIBAxfzf3b6cw/OY5vY=;
 b=MX1T5Ay45fk1I/MZiLaCxJ2TYFecM7c9gKzGb8WjbcoAoTZlSGrkQB8CIjCHpgXekQ
 06CXw3Hk6LEsjA3v9hA/ccTeZwmDDheDKMtl2KBQ7bd9EKhQRONKAsUorCWcmcmZTwBj
 DQXuLKiHrFkL3YEb8aVxeNk3tBCnPfBUAYmpL5+nF2WvTlcgq+beCMqxHy50JGI6n2ZO
 9gbI9kvtS/smrji6H9p23+qsP/5/FJCS04ONdhgBYfZg8vxhOvTHvY8LaeSfN2FRlBdU
 s8jWwymCb89utf59w8rqti/1rdIeowuFQO2L+5tVUHOICmtDDQVhrAnrVJQF5HM01WS5
 Z0tQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGDhu6ejaSqZTwGOD59DtLR9kQ0UHyWAJw/LYfu7d/jW/ERYOLStVQ2HsUL5rs+dFBjHXEO2J93J8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUKKjUO/s8wj8pJ2qywyCaffSICd8QJoRYGcfjUnpZ1hmnshwO
 KPDJv9T+aqfguPdnxFffGwDP+aMGJRSJzfOieYgIYdM8lGj/r8SXuBuU
X-Gm-Gg: AfdE7clIVAlAgKQ6sph52C0Q4Dn4na9yvd8hiMwc4lyLP80lWDfTMg4fRFHNMduZDQT
 oEuY/KoBFF9lPcAiYJjCtK1F3B2ESNrFDaTp+tyJ+lYwW9KMjcWcZNPaahJzD61hPFBlgiZ5PLt
 U2yLdQMpQDZBqKynPGTdP8EuJ0mezhlhld7/TVm8lQZGrVAdK55zbLEOBLnNUmg+ZwtM3byFACX
 JrGpLelt+ylNw9z3WiX9F2DEuv0HiC0n/cQa1+AEMGlZLhX6UBRyePIWUZglpNDHHggbgfe8QqX
 dTCZySLF58Eh1XejyujxEbxkxELuOzoAxFZC7IzWzRKVlDHHJdUORvpb+CaThc/2KDN1Kmejb2R
 qyPq6W04E9O7mengAfBdUaPU1WgIuh+1WoEiVlNFzb7gQS4z8w91zOs7fBxVd83wb9/HbJ+spb1
 eFwadatK4L+o5kI+JJroQajItzZ901qjzi26BrTqlazVs8gCBLcajGQj5NtBBneDwoDHgH7E1mE
 cfx1AwMLVSX+bTia4X6YalZ+qOQvU0/+w==
X-Received: by 2002:a05:6000:2007:b0:460:1301:dec6 with SMTP id
 ffacd0b85a97d-47df0715673mr12782183f8f.10.1783685025316; 
 Fri, 10 Jul 2026 05:03:45 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at.
 [62.178.82.42]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm59637487f8f.13.2026.07.10.05.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 05:03:44 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH v3 0/2] drm/etnaviv: Add GPU reset counters for robustness
Date: Fri, 10 Jul 2026 14:03:41 +0200
Message-Id: <20260710-etnaviv-reset-notification-v3-0-7a145c8a1d01@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQqDMBCF4atI1k1JokbtqvcoXYzpRAdaU5IQW
 sS7NwqFduPyfzDfzCygJwzsVMzMY6JAbspRHgpmRpgG5HTLzZRQWjSi5RgnSJS4x4CRTy6SJQM
 xn/FelI2sS5AAPcvA06Ol14ZfrrlHCtH59/YryXX9st0emyQXXFdGy6bqdFe3ZxrgTnA07sFWN
 6kfS4pdS2WrE8Zib6xSoP6sZVk+pcmaIxEBAAA=
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
Changes in v3:
- Update the reset counters and read them back under the GPU lock, so
  the RESET_QUERY ioctl cannot run between the two updates and report
  an innocent reset to the guilty context (Lucas).
- Link to v2: https://lore.kernel.org/r/20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com

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

 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 46 ++++++++++++++++++++++++++--
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        | 12 ++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  5 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h        |  2 ++
 drivers/gpu/drm/etnaviv/etnaviv_sched.c      |  5 +++
 include/uapi/drm/etnaviv_drm.h               | 19 +++++++++++-
 6 files changed, 85 insertions(+), 4 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260708-etnaviv-reset-notification-b037153a1aab

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

