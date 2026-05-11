Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D13CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 07:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FB310E439;
	Mon, 11 May 2026 07:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvpmMK3P";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A3C10E13F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:45:58 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5a8d1f43432so652197e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778485556; x=1779090356; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hQSj4yb9M7hPwSpBxDj8hHK3jRimcbsKCK5DUSyRAe0=;
 b=WvpmMK3PiVK+YQl2pRugEDHOLvafHKy5osQKUa5oCiFAFmcuAXqrJsUHCZixEua8Qy
 H9iscJjMdmkqDkXdw/8CltJMpeWXH8UZYBpjAfyXgLNhH2Bw2B1l4s2KRJF6ldayYhEA
 XxDR3M22DZaxhWysKsnOxmnDQClIDpmZ09qkLGnBftI0NBW7DOBx64wnuRHKP1y/sfst
 EZykW7kBxCRLkGxiUfR88A0y4Hkx1qvbQdX+QdaV42sWFLo9mfPBDcOeR3pfONbqagy9
 yP6rnUzzsQB/O1+GAX8rdHbd0yyr8xUY7RFpw2GPl9HYUvO/YEv/QcD4kPlHbvWIHwOI
 sa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778485556; x=1779090356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQSj4yb9M7hPwSpBxDj8hHK3jRimcbsKCK5DUSyRAe0=;
 b=ErZVmcTqi83NxHHSb8r/ZgqIDOHE2xdoG7i8FtC9aLn/BzeEyd/culmijo4xBCdiuf
 kEgZ7ZgBW27CqYF9vbfFuWyZvxxIPa4fc5GSipo077jXonu/R0UE8UL8ySdtwTpVsmQS
 EklMOENFDQIKdHoo3YOwONEblyscjeSr1vanqfykhxOlXin6wf7+HbD6wGAgKf+8HI88
 Aq/UMPaC2F6okyKRkIcWUO5ON/kOyczfOXYZT1WPiUyvLLnzbPUNqdq8PDzw+0WEnGgg
 bQzaGkCS85VoJa1qX4ZFtbRj0OEBtyYN3FlHEBUuTaK0O5QmTBzBuAKmvW+tP3Nzaml2
 uGjQ==
X-Gm-Message-State: AOJu0YxY1Dymc1QIriyrcEwHyIcWVgDHSwtB0CY3lAuF/uLwOr61lYBb
 3hZTl6+Z6CTLTBsXcYqJRKbf5CSuR7qDBApqwADUGHgsfkJ6dcY6t295
X-Gm-Gg: Acq92OHkcstROhnkIed7P3StYvSf94OO8tXAgBFW4ZKVu5B1Giwy9ZVYhFJPL/etl/Q
 If4kRoB0fZzut3IDOFNrUBhPvNNsIe4wCP5VN1rzFMydozDkxZ489dstplt9/0F/dqy8WtDjcH3
 2+jaEaOt5ry7JVxXH8FLozo92ThNXrBMu/tTpkfmkVtT18q+sEcFS7DYCopImBiAae8nM1sptLS
 5mFHd28PuAo7JyoOTRLz0yK4Scxg3EN0ZMFSsZPBkBrNkgyd+imFq5cz5CN1g17Nx/rktSNvI/z
 sSuTqoabxF4sYQZn4LnkU6loaiZ/BxUuYWl5LBrMZ794T2ogNAPga15QaquSC/EttCR2EEAWER/
 60lvci9qcMlOXiNN9pKwG7NxqgFfgdCsFcZ8QGd7I3bZ8OGDeAIhMErDJxa1L1Unl39Vpy3g8WE
 rD8XUpjHvvqVGy
X-Received: by 2002:a05:6512:308b:b0:5a8:89c5:2bee with SMTP id
 2adb3069b0e04-5a889c52ce3mr9201102e87.39.1778485556237; 
 Mon, 11 May 2026 00:45:56 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a952705asm2404394e87.32.2026.05.11.00.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 00:45:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2 RESEND] gpu/drm: tegra: add DSI support for
 Tegra20/Tegra30
Date: Mon, 11 May 2026 10:45:35 +0300
Message-ID: <20260511074538.24563-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Tegra20/Tegra30 DSI is quite similar to Tegra114+ apart MIPI calibration
logic and clocks. With a few minor tweaks, existing tegra DSI driver
should work on Tegra20/Tegra30 devices just fine. Tested on
Motorola Atrix 4G (T20) and ASUS VivoTab RT TF600T (T30).

This patchset depends on Tegra20/Tegra30 CSI bringup since both share
MIPI calibration logic. Ideally these patches should be picked after
CSI bringup but they will not break anything even if picked before
CSI patches.

---
Changes in v2:
- removed all MIPI calibration, it is handled within CSI bringup
- added per-soc structures into of_match
- added fix for hang caused by register access with uninited hw

Changes in v3:
- switched from version DSI to boolean flags
- added comment regarding Tegra30 clock configuration
- commits were picked:
  "clk: tegra20: reparent dsi clock to pll_d_out0"
  "ARM: tegra: adjust DSI nodes for Tegra20/Tegra30"
- commit adapted to recent DSI changes:
  "gpu/drm: tegra: dsi: move prepare function at the top of encoder
    enable" > "gpu/drm: tegra: dsi: re-add clear enable register if
    DSI was powered by bootloader"

Changes in v4:
- switched to device_get_match_data and added check
- added comment regarding Tegra124+ quirk
- adjusted commit titles and message formatting
---

Svyatoslav Ryhel (2):
  drm/tegra: dsi: add support for Tegra20/Tegra30
  drm/tegra: dsi: re-add clear enable register if DSI was powered by
    bootloader

 drivers/gpu/drm/tegra/drm.c |   2 +
 drivers/gpu/drm/tegra/dsi.c | 126 +++++++++++++++++++++++++++---------
 drivers/gpu/drm/tegra/dsi.h |  10 +++
 3 files changed, 107 insertions(+), 31 deletions(-)

-- 
2.51.0

