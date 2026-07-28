Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97575C54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21FB10E548;
	Tue, 28 Jul 2026 09:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FGGSGNbg";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18CA10E54E
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:18:17 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so43657075ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785230297; x=1785835097;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5I1AY9BLhfuJBpnfRkSYDGG1aWX86nocKReaece+rOM=;
 b=FGGSGNbgTnhpNTasFTD6unXDzaRvuLPEGvqcvkNEp0A4M7Y/zvN37PcSNKGNXg+n5P
 KSy6LbBGTJcLsAxMKYR23E89LRVA8O5k5biVrCqAgyUAyLhX6icw7BrfzfnlMS3+8aGS
 0DDUwFcQihNJ079ldk10ZKJENgol10/LgfVdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785230297; x=1785835097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5I1AY9BLhfuJBpnfRkSYDGG1aWX86nocKReaece+rOM=;
 b=eIUjvVhKRnN8K1kqsEk+qxpfU2oji1pnuq9LObyKj5o6gdQ42xeBmbnILRx/h10hgO
 4VtSqw3MsyzY/QBS1NZxq1Vi/qUQ53b/7KRdJy0Ymy11Tf4cehwvvNUIyuAJGJ/8Kt/B
 ciV+FH3pp4qf1Db2lnZQG+zKwckBwP9/o4oKT05hSdkvPZOjm4fea+S7xEaXHyRfjG5M
 tGA+Wlm0lKtsWFUSnNVWiHE/ZaNWaI4zywKogPJzHAcJMGyH5mk479Fa1odA1SqGnKrd
 Hdtkzqt9uei509inEOliqdQoYKCXW7XfXzE/mztSc56vjOY53aMn8334eBQBpsUwOdvi
 irJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTUfabzu1/+cq9RZasjWO4eL6yPRLcJsIMHnhCrbLHZ9ZGynRTCYUpM4jOqtjJVeGUci5Obl9RgqU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3JdmkziA4BhUkIimS2IRxfwwzrKLrXzVeu/v1+UgmVtUrAgzJ
 WqFUSSPSx1M7MgUXIuIqOLpdw6N2aZwk7x4mRqH4HXFiUIt2bRQcQUk3U9AxDRHoKQ==
X-Gm-Gg: AR+sD12bn/adbTOgRRgXYtqlHQzZcJByy/0CpWL4DlLZSgkz4mrasDRfs2nzWHjbHmm
 0fP1Oz2kIgBunDW8NKSeNQskVTz+mDeIGVXTFP2nGo/TMOr5FpNAf/WIEQxjWwACPGzLGqkkevd
 ZSxR17j0+ulQn9bmRb4ac6guqlVbsCbaouPEKzQxSB1xiBrLwDJh8/cEQpVXU6EApoEjuessxxu
 bq4vUFDRFYRczSLft/YecS+IAjubRBUz742rl7DvefraH6eWDp9jHPxB6h+MG3sN+h6uG0aLsZ+
 hN0lMjp2KGHQG3/H4XDhRPEV8rrISKXmdAbC2XksG24aoDTacuenpNOEDinlpjyvwl+mmm6Gfwn
 bBX3Nr9QlnBkTaacsvfJlJgKyeiQ7yMYNspwV2RwlewMdN8J0mpQRYVPfS6IIyBg+5n++IESjeq
 5fVYBMdwq7BHxew8O/JF6RQ/C/du0f1CkDlCwtJMagLc+LuBVlfwruU1E5H4s=
X-Received: by 2002:a17:902:e945:b0:2cf:477f:57c5 with SMTP id
 d9443c01a7336-2d015ac708bmr18332045ad.1.1785230297072; 
 Tue, 28 Jul 2026 02:18:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:c85f:b2bb:a077:d544])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81dcc1sm48616965ad.84.2026.07.28.02.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 02:18:16 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, YoungJoon Lee <getfeus@gmail.com>
Subject: [PATCH v4 0/5] powervr: MT8173 GPU support
Date: Tue, 28 Jul 2026 17:17:58 +0800
Message-ID: <20260728091804.382753-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
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

This is v4 of my MT8173 PowerVR GPU support series.

This time around Mesa was ready for basic testing, using both vulkanmark
and glmark2-es2-drm (with Zink). Details below.

Changes since v3 (all in the clk driver patch):
- Changed pm_runtime_put() to pm_runtime_put_sync()
- Added missing of_node_put() in remove function

Changes since v2 (all in the clk driver patch):
- Made COMMON_CLK_MT8173_MFGTOP depend on PM
  - Needed since the driver implements PM domains using the generic PM
    domain library, which also depends on PM
  - Fixes build breakage (kernel test robot)
- Fixed "RST_DELAY_CNT" name (Brian)
- Dropped unused mfg_desc (Brian)
- Added check of clk_prepare_enable()'s return value in
  clk_mt8173_mfgtop_power_on() (Brian)
- Saved error value for return in IS_ERR(data->clk_26m) branch
  (Dan Carpenter / kernel test robot w/ smatch)

Changes since v1:
- Adapted to changed DT bindings
- Dropped driver change
- Use same power domain for "a" and "b" GPU power domains


This series enables the PowerVR GPU found in the MT8173 SoC, found in
some Chromebooks.

This version is different from the initial powervr driver submission [1]
in that it splits out the GPU glue layer support out of the powervr
driver and into a separate clock and power domain driver. The glue code
is otherwise the same, and also the same as found in the ChromeOS
kernels, with some extra comments and macro names added where possible.

Patch 1 adds a binding for the glue layer, called mfgtop. The glue layer
contains clock and power controls for the GPU.

Patch 2 adds a driver for the glue layer, implemented as a clock driver
that also provides power domains.

Patch 3 adds an entry for the MT8173 GPU and 6XT series to the PowerVR
binding.

Patch 4 corrects the clock for the GPU (called MFG) power domain.

Patch 5 adds device nodes for the GPU and glue layer to the MT8173 dtsi
file.

The kernel driver successfully probes the hardware and loads the
"rogue_4.40.2.51_v1.fw" firmware provided by Imagination Technologies [2].
The "exp_hw_support" module parameter needs to be set for the driver to
probe successfully.

This was tested with Mesa 26.1.5 from Debian Forky. With this version
vkmark and glmark2-es2 (over Zink) both run fine. Mesa spits out a bunch
of warnings since the GX6250 core is not officially supported.

    # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=1 vkmark
    WARNING: powervr is not a conformant Vulkan implementation, testing use only.
    WARNING: powervr is not a conformant Vulkan implementation, testing use only.
    MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:73: FINISHME: Missing reset support for brn51764
    MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:76: FINISHME: Missing reset support for brn58839
    MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:523: FINISHME: Missing support for brn62269
    MESA: warning: ../src/imagination/vulkan/pvr_arch_border.c:244: FINISHME: Devices without tpu_border_colour_enhanced require entries for compressed formats to be stored in the table pre-compressed.
    WARNING: powervr is not a conformant Vulkan implementation, testing use only.
    =======================================================
	vkmark 2025.01
    =======================================================
	Vendor ID:      0x1010
	Device ID:      0x6250
	Device Name:    PowerVR Rogue GX6250
	Driver Version: 109056005
	Device UUID:    d04cd6f3a25fd4900f89c151bccfdfcf
    =======================================================
    [vertex] device-local=true: FPS: 251 FrameTime: 3.984 ms
    [vertex] device-local=false: FPS: 220 FrameTime: 4.545 ms
    [texture] anisotropy=0:^C FPS: 223 FrameTime: 4.484 ms
    =======================================================
				       vkmark Score: 231
    =======================================================

    # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=1 glmark2-es2-drm
    WARNING: powervr is not a conformant Vulkan implementation, testing use only.
    MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:73: FINISHME: Missing reset support for brn51764
    MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:76: FINISHME: Missing reset support for brn58839
    MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:523: FINISHME: Missing support for brn62269
    MESA: warning: ../src/imagination/vulkan/pvr_arch_border.c:244: FINISHME: Devices without tpu_border_colour_enhanced require entries for compressed formats to be stored in the table pre-compressed.
    Warning: DRM_CAP_ASYNC_PAGE_FLIP not supported, falling back to 'mailbox' mode for SwapInterval(0).
    =======================================================
	glmark2 2023.01
    =======================================================
	OpenGL Information
	GL_VENDOR:      Mesa
	GL_RENDERER:    zink Vulkan 1.2(PowerVR Rogue GX6250 (IMAGINATION_OPEN_SOURCE_MESA))
	GL_VERSION:     OpenGL ES 2.0 Mesa 26.1.5-1
	Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
	Surface Size:   1366x768 fullscreen
    =======================================================
    [build] use-vbo=false: FPS: 49 FrameTime: 20.473 ms
    [build] use-vbo=true: FPS: 45 FrameTime: 22.660 ms
    [texture] texture-filter=nearest: FPS: 45 FrameTime: 22.642 ms
    [texture] texture-filter=linear:^C FPS: 50 FrameTime: 20.172 ms
    =======================================================
				      glmark2 Score: 46
    =======================================================


Please have a look.

Thanks
ChenYu

[1] https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.walker@imgtec.com/
[2] https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powervr

Chen-Yu Tsai (5):
  dt-bindings: clock: mediatek: Add mt8173 mfgtop
  clk: mediatek: Add mt8173-mfgtop driver
  dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
  arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
  arm64: dts: mediatek: mt8173: Add GPU device nodes

 .../clock/mediatek,mt8173-mfgtop.yaml         |  70 +++++
 .../bindings/gpu/img,powervr-rogue.yaml       |   1 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  33 ++-
 drivers/clk/mediatek/Kconfig                  |  10 +
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-mt8173-mfgtop.c      | 242 ++++++++++++++++++
 include/dt-bindings/clock/mt8173-clk.h        |   7 +
 7 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c

-- 
2.55.0.229.g6434b31f56-goog

