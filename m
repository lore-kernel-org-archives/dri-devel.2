Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2DBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A41F10E603;
	Wed,  8 Jul 2026 15:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sIDjgkZh";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0900F10E603
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:22:09 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so4411466b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783524127; x=1784128927; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dT/4FqiNAEmcewp+PxajT6kJ3w+dqpjt8gG4B1wnCug=;
 b=sIDjgkZhmUyYhBEpZhe1hyUv4d/PqzU4eOuUp7hA6SAizmifZSbJXWWvRYIK1TA9XP
 SOHIwogVC8KxH69SxVjGIOUa7NFDWUjkuufjQeZZHQibLJtVogocnQ7rsX6Ld1tmYBFd
 uNrfRyC2ex84zT4c/4XucfNFUS08SF6amgvh6F3/Mpn0rWAL4R/8R2kRzQQ8TM8PdxpT
 J+KasHDcpmyvROSNf7HxqGmqlKVES6CKdhsy+onfE3pcavq7m2IHiU02r+PE2FZlkUHn
 qFHZTcN8YksxaDbU7dUXxm87IqxNr5xmlgi1G3ASiycG5ZNd8HM7CZTb0/l4Q+2bghDp
 t1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524127; x=1784128927;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dT/4FqiNAEmcewp+PxajT6kJ3w+dqpjt8gG4B1wnCug=;
 b=JawI6hbHPIFUu/zV90Fzxsp8IqgIeGrErDcWgV0499dO8Zf2klGXEnsWr0gyYMYxJJ
 JlQ+BUCTkPZ+IiHeSa/SrJAvMOvXEz7Ns91PkuQbEqUgZiWcpiEPIP9BMBwmYjgSRSCn
 Foxki8rAJoz25ZRF9ei6ovO/9B9ZRsIrIVCtf/ob9SSBjaxS0Sq4VfOBD9fRxjUQx7pJ
 a1GSHZgQMojdlcBHBnEuV/0TRchMaYPeb5YH5z0bStum0JRzXKz7w+cuCdYyF0dQ8z0B
 Ei50m+Ca83La8KDhUEplYytnNqALHxE/f1Tj0bBkc7gNgZeMgrsn0j75jSdUY0PpW09B
 g5/g==
X-Gm-Message-State: AOJu0Ywd2WkVj+r9egyzC9rfYqzfATNulKf5O9Qg//zs7lRd1deYHweW
 IYKFAoP0B4pmSSuWI0tlBPGfFFmcnTGyjI1/yJhUIL3T+EqhQG0E0MMV5JFp0iQWzeo=
X-Gm-Gg: AfdE7cnSSkk3k2mG1j5oxmOFmuk5HcMj4XI5ZuERpXfhJpcNhX20bONS936niWZZIE7
 28iPvzY4pQYBKzJZmWyggGzHlK+Vol3ivEcidfECB6AmuzkyrdKXO6GKAoO7FUDEGpzwsrvNuqs
 EipDAiEQmA8dj3CgE67ZKgqp8enbactv4MAOPuRa8QNrJf1HwGUh5nmZLmxalqslDwnZrEfefXs
 t3WQSySKJ6rNX/cT/jt2I9OT0y9jvcchHZlaqsSJU/C235GeWD027kAdDWJX7gu7zdEXB7diUWq
 WLjkzXgaGcod6jCLBAsqBDG/s0aEkWjpgIoimF82R3ukjqTMfylrmDW0DS80PjaZ7TbjwdaZbSM
 ONHSrgMm5or73AvDFYI3MsAuFRKb70tAom1XXT51HTXO2NAtlt3c3KOIEItGx8gfKOCZaGS81zD
 jh15J1lf5ved1QDlA2cj7rDqjAuqH0C6ctTOxXcQ7zNtdltqKx3EAD5uWGYuOEtOk8le2Y6XHpL
 ZPGKi0=
X-Received: by 2002:a17:907:70b:b0:c12:6280:33c9 with SMTP id
 a640c23a62f3a-c15ce011b1dmr171223266b.28.1783524127378; 
 Wed, 08 Jul 2026 08:22:07 -0700 (PDT)
Received: from puffmais2.c.googlers.com
 (181.179.204.35.bc.googleusercontent.com. [35.204.179.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15beb53b86sm213932966b.25.2026.07.08.08.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:22:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] drm/drm_crtc: dma_fence_ops fixes
Date: Wed, 08 Jul 2026 16:22:04 +0100
Message-Id: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABxrTmoC/32NWwrCMBBFt1Lm20heJuKX+5BSYpq2A9rIpIZKy
 d6NXYCf53AfG6RAGBJcmg0oZEwY5wry0ICf3DwGhn1lkFwabsSZPXB+r6ynZ+dp8d2Aq2RSOev
 VSTstJNTmi0L1++qtrTxhWiJ99pMsfvb/XhZMMM9VsPauzKD0taYcxWOkEdpSyhd3oVZ5twAAA
 A==
X-Change-ID: 20260618-linux-drm_crtc_fix2-23a7c354a412
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
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

Hi,

These patches fix two issues in the drm/drm_crtc driver. Initially I
was hitting the BUG_ON() in a scenario as explained in the commit
message of what is now the second patch in this series. For the reasons
outlines there, the BUG_ON() should just be removed.

After posting, sashiko.dev noticed another issue, that was previously
masked by the now-removed BUG_ON(). Since we can't have a loud BUG() be
replaced with silent data corruption or worse, I've also added a patch
to address this issue highlighted by sashiko.dev. I believe its
observation and analysis to be correct.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- add new patch 1 to address sashiko observation
- original patch 1 becomes patch 2
- patch 2:
  - don't turn fence_to_crtc() into macro (Jani, Philipp)
  - update commit message to include reference to deprecated use of BUG
- Link to v1: https://lore.kernel.org/r/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org

---
André Draszik (2):
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
      drm/drm_crtc: fix race with dma_fence_signal() in ::get_driver_name()

 drivers/gpu/drm/drm_crtc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260618-linux-drm_crtc_fix2-23a7c354a412

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

