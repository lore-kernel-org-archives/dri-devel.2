Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46EDFEA830
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C8010E801;
	Wed, 25 Mar 2026 07:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JZd6dp6O";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A81610E7FD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:58:24 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2aecefc7503so47295025ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774425504; x=1775030304;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fzYr866Y+nhDeVzwxBplwIhb3zjPYVx7VrTJzl9KpOQ=;
 b=JZd6dp6OWcSOjPgHodAKazcJmViQV7DughvE0m+iqNayzboZLBQP0phNgkxJh6Krnb
 OuuAbKTF3CvnLuEDDYK+vxEcj71znegNmUFngpauJRbCWk32E/v645/URzu/8Ya+Jv+V
 DuduG/zgVY7hiocYs7l7A7XuuSMQJeNELQ5t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774425504; x=1775030304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzYr866Y+nhDeVzwxBplwIhb3zjPYVx7VrTJzl9KpOQ=;
 b=j8iPjL02Rv0j2Hxq/jx8sO9aJ3uaxgCcOl37fW1N8skcTGvrj+ZhnS6RYAKX7OZPj3
 S0uEAcYJGSpqyWKDeEo+HmgjLI9FIjIUvjP4RK94lOOAMmAQpOxzajH1nHaaaQpbnpHE
 fYenj8UZThaZijiD2qAIdtXdfbXwcNbwlu/3IHVnuXOn3NtrFKm+6ArVcYY8sfycEVaZ
 FcMU2JVNMvygi1B2CqxltCqqlWySWzK0YHdIJ2GNm65yz6DYHaergezuFWBB03+NnD95
 k7qCduoXJniXq2ievS+HvVesnnZMNEuuCDLOTaJ4DW4f/46Ep3FJnFtfSpoONJZSEbN+
 MP4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhSWujVn0d2Y3n47yo1F0WFTLJKjMl0ui+a3zUe6IPML5gqZ6lSX0ypwKdqen2m01lJMIRn43ikt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZSipZnpbQ4kiB8xu3yArrrBr1Tjg4FVpO07mTgB6TZc2xqK+j
 CdIvH9JXqyINi7dWyhIH40PicOoChr5sKgogmtVcu4Wt5Quk382KR3htOrbfmjJ9vg==
X-Gm-Gg: ATEYQzzOsKF4W8FKynC0J8Moj7zxCPWG+0UGzb4ZWFbmJoH1QTZMDPuwLOawJpwTuCk
 adzUcKn4/8gfvZ63G/BuM5IcgF7860K5YGwPXkMigkIk9X7MJT/9/phWdlNPg0cPzEuVYmVD/bU
 Z6ABGgBq33bkQipDNwyuv43lOQuf0NggIswhhog/+QAU3+yeHtAvDJxBNh25QSHLzF/loF2SfBB
 WYi1gEEL/A5SxjFSOrYp0KtlQrbuaLitlDKcvKHXNyBzRUaKl9LYlZCV6m0QHUwB4F/3NMwKdYM
 H3ijc13K6ghilrAZ2M0fma5wXRnq747sopK02+1y91mxP813visdI4o0k5T6bbce4Z3XthZzt6C
 WTg65t7Duq6TYZ+kR1hIps81UNibekR2326uHElwRYvvKuQNKObkBBlcbYG8aCAUtSrte3SFqox
 sBgN6YCMfZ3vVkRc7TQc6173QV6rgIOaJ8KU1L6/aBLtkJF9MwppDLFiwzj8hQT1zWN+I/Zm4m+
 mCQleM=
X-Received: by 2002:a17:903:37c3:b0:2b0:5aab:c40a with SMTP id
 d9443c01a7336-2b0b0af4c01mr28590075ad.31.1774425503648; 
 Wed, 25 Mar 2026 00:58:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:7ff0:bee3:7d45:eab])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366c3f7sm219682465ad.60.2026.03.25.00.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:58:23 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Icenowy Zheng <icenowy@aosc.io>,
 Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] powervr: MT8173 GPU support
Date: Wed, 25 Mar 2026 15:19:44 +0800
Message-ID: <20260325071951.544031-1-wenst@chromium.org>
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

Hi everyone,

This is v2 of my MT8173 PowerVR GPU support series.

Changes since v1:
- Adapted to changed DT bindings
- Dropped driver change
- Use same power domain for "a" and "b" GPU power domains

This update was requested by Icenowy.


This series enables the PowerVR GPU found in the MT8173 SoC, found in
some Chromebooks.

This version is different from the initial powervr driver submission [1]
in that it splits out the GPU glue layer support out of the powervr
driver and into a separate clock and power domain driver. The glue code
is otherwise the same, and also the same as found in the ChromeOS
kernels, with some extra comments and macro names added where possible.

Patch 1 adds a binding for the glue layer, called mfgtop. The glue layer
contains clock and power controls for the GPU.

Patch 2 adds a driver for the glue layer.

Patch 3 adds an entry for the MT8173 GPU and 6XT series to the PowerVR
binding.

Patch 4 adds an entry for the PowerVR 6XT series GPU to the driver.

Patch 5 corrects the clock for the GPU (called MFG) power domain.

Patch 6 adds device nodes for the GPU and glue layer to the MT8173 dtsi
file.

Patch 2 and 6 depend on patch 1 to build. I suppose some common
immutable tree would be needed from the MediaTek maintainers.

The kernel driver successfully probes the hardware and loads the
"rogue_4.40.2.51_v1.fw" firmware provided by Imagination Technologies [2].
Userspace was tested with Mesa 24.0.8 from Debian Trixie rebuilt with
the powervr vulkan driver enabled. `vulkaninfo` gives some information
about the GPU (attached at the end), but running the `triangle` example
from the Sascha Willems demos [3] with -DUSE_D2D_WSI=ON as recommended [4]
failed with:

    Can't find a display and a display mode!

Same program worked correctly on a BeaglePlay and displayed a color
gradient triangle. Not sure what went wrong here.

Anyway, please have a look and test.


Thanks
ChenYu

[1] https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.walker@imgtec.com/
[2] https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powervr
[3] https://github.com/SaschaWillems/Vulkan
[4] https://lore.kernel.org/dri-devel/f2b2671e-5acc-4dec-9c2e-3c9cd2e1f19e@imgtec.com/

Chen-Yu Tsai (5):
  dt-bindings: clock: mediatek: Add mt8173 mfgtop
  clk: mediatek: Add mt8173-mfgtop driver
  dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
  arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
  arm64: dts: mediatek: mt8173: Add GPU device nodes

 .../clock/mediatek,mt8173-mfgtop.yaml         |  70 +++++
 .../bindings/gpu/img,powervr-rogue.yaml       |   1 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  33 ++-
 drivers/clk/mediatek/Kconfig                  |   9 +
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-mt8173-mfgtop.c      | 243 ++++++++++++++++++
 include/dt-bindings/clock/mt8173-clk.h        |   7 +
 7 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c

-- 
2.53.0.1018.g2bb0e51243-goog

