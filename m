Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A0DCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8370610F363;
	Wed, 30 Sep 2026 12:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RVrAHEmC";
	dkim-atps=neutral
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636D210F1DE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:59:17 +0000 (UTC)
Received: by mail-pz2-f37.google.com with SMTP id
 41be03b00d2f7-cc7c9c2df74so371012a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751557; x=1791356357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mx0iaoPR7zXZchCwtDWxvwWQjv0it6r14y9G6mnX/DE=;
 b=RVrAHEmC7vSSjwIe12GS5Qaer5fgMW/OdpGrJ2kBCvQxGCCYtjdmTCTVfqYRjvQNQn
 YSmokPRIOgkxN9CgygAGmPJCTTNoGb+REUWBGOhisIDtxanFsqAms/uhD2p2air1XquM
 EDXsBns6xtAXKBPopm/0P5Y/ivj0pmONqtH1/JTsZZHb12zObmuiZ4Kdoo6+kPWBOBT8
 gAEKFrlGdK1HuvKS/ns8iBGn6uiwVhlx2mGDbipmIiJBQYAEjoMx7pJ3gkMmCjRYjYPo
 NiIJSxdMGkUG/nQ38KbGKWYShH8laEAWyru3m136bIhFal12YW1XrvH6Oqiz0H5BwJAW
 hcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751557; x=1791356357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mx0iaoPR7zXZchCwtDWxvwWQjv0it6r14y9G6mnX/DE=;
 b=taLHa8SGVtQLJb+UZ8tgHlKlYf7fq1M6zZIoKKZBccEFHnblogiX/mACS3Rl8XuwIv
 lWSbdu9XgXKunqV2xaSxrfY6GaQX6qRI3Zj8dutoPzKHEf8WN4qgptSH1wI4PF1GFyTo
 Z5CvW5IJIVqyXIZpNO0jAP+cdLg3IANaRI7WaSeE7ikwKYm8gukV2IOG7zQZ4/YyWL6T
 oII+LlzlGlMrN3v/6QrDDPGtHZZTr3BV/VfJpaH3Ja5P5kWYvyFNELVc7BsZMnhy2MGj
 56iZKC0baXoDkSudpbudesfUCJBBcjw0umKP/i/poYLhmwszYsU1IByiCDZEcdtppZ0O
 yZSA==
X-Gm-Message-State: AFq9FYIORLXH+3/mGj26FMnTyHGKHDjj6g0TEDl89KRdjf3wNR8VPDpJ
 gUZk5EXBKdJO8hu5A/jdobJoRgnNvk0q1t7VMs1Eymsb6jmUGFGVHiOAhVUJDBJb
X-Gm-Gg: AYBFou1kyEaj9Bw9mMb/LZeYYbs7lx2ULDiTKJXk/5Aerc3a0+WIyRxbO1LJFvnfi0E
 5kcnhU2bP8K/+goecL+v6V5onemjkibsHcLsJWYwndQFpljr8ZeQ0GL4fw66haRfozvrO2K/j2A
 WXz6a2avAkaG3kyTOuXJyhmHRmuGT+rVuLoqnsxcf/GWljENL53RoIRBJ8FM4FI16juzbfOf3uF
 moOP/db2DzjjdRMDIPlJf2w9tQHq7G7Rmv3DH0JUHJarxmrFAR7i38fWUiI0U2ARa05lMoy87KQ
 NTmTdtpZdyuFxKBbcYQ0a6ue4jole5ZHj9iVyVhY4FOvXP91FSU5meqOC1/+Tx5OD+Nv17aVsbl
 EZsCcxTOz6kjcwV9LR6DxlGgTzQ3dJiUaupgJNBpoJ2BpvEloQbfS0ubN9P/1cJLUL+gyd/nKMv
 l651bPEkWKPeZGCP6u+7tLqx9R1h4A6UPUZ7IoKmfYK95YtyUZf2pMGsugxd32UMcSrRetbTjml
 i2rHC3qunyF+oeFxKwwwkXjfO/ch9xKC/wJJ8MJJAFWNnIAF2E+7wWvQ8eXEHhXLWMMUnmm8mYO
 Ie0s5bSnXA==
X-Received: by 2002:a17:90a:dfc8:b0:3a4:b3a4:e7a6 with SMTP id
 98e67ed59e1d1-3a4d276b9bamr261177a91.11.1790751556720; 
 Tue, 29 Sep 2026 23:59:16 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:59:16 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 0/5] drm/gud: fix probe validation, shadow_buf UAF,
 and bulk_len divide-by-zero
Date: Wed, 30 Sep 2026 06:59:09 +0000
Message-ID: <20260930065914.393939-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

This patch series addresses multiple memory safety, concurrency, and
validation bugs in drivers/gpu/drm/gud/:

- Patch 1 moves display descriptor validation in gud_probe() to after
  drmm_mode_config_init() and field assignments, preventing unconditional
  probe failure (-EINVAL) on non-DMA USB display devices.
- Patch 2 aligns both x1 and x2 coordinates to block_width in
  gud_flush_damage(), keeping rectangle width aligned for compressed
  block display formats.
- Patch 3 flushes pending background work (flush_work(&gdrm->work)) prior
  to freeing gdrm->shadow_buf on framebuffer resize, eliminating the
  Use-After-Free (UAF) race between queue_damage and gud_flush_work().
- Patch 4 guards lines = gdrm->bulk_len / pitch against zero pitch or
  lines in gud_flush_damage(), preventing divide-by-zero in DIV_ROUND_UP().
- Patch 5 resets damage state on vcalloc() ENOMEM failure in
  gud_fb_queue_damage(), preventing damage height underflow in subsequent
  flushes.

All 5 patches have been dynamically verified in QEMU against Linux 7.3.0-rc3
with KASAN enabled; detailed test methods and outcomes are documented in
each commit body.

Changes in v2:
- Split single monolithic patch into 5 distinct, single-purpose patches
  as requested by maintainers and reviewers.
- Included QEMU test methods, expected vs unfixed behaviors, and KASAN trace
  details in commit bodies.

Hui Peng (5):
  drm/gud: Fix probe failure on non-DMA devices by moving descriptor check
  drm/gud: Align both x1 and x2 to block_width in gud_flush_damage()
  drm/gud: Prevent shadow_buf UAF by flushing work before reallocating
  drm/gud: Fix bulk_len divide-by-zero in gud_flush_damage()
  drm/gud: Reset damage state on vcalloc ENOMEM failure

 drivers/gpu/drm/gud/gud_drv.c  |  6 ++++++
 drivers/gpu/drm/gud/gud_pipe.c | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.47.3
