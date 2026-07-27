Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FC4C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39FB10E7DD;
	Tue, 28 Jul 2026 07:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QaRG6ZdR";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D06A10E46E
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:49:11 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4896ae35be9so1193400b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785167351; cv=none;
 d=google.com; s=arc-20260327;
 b=sEdO43RLzx3W0jAvmuY+qKEl8iOMSffYVhWItDT0TfuCb+cQS7zpKGIne3k/MRt410
 gGGAnkzs2z2Pv3ux28R6TUDhCmHeWtBqpB63rGSBkmDrepExseH6W+hXx9TTEtLwupD5
 OqUt9NOzSg6INAFCIoGP3ywIKn8no8jS7sjeC8jcop6hLA7qThfCzC26Jnlq5F9QbNWw
 NbyZBP0N/mWzTtXJO3D4rFWgYbXFSpA18B3Yhg9VuxXl8K1TRaZVsJXmy/kHw/e8ppPo
 bjQrFGaQCDyURS3+o+cSvUoqxr5nnLPkxfTLs+nJ9h1n8JezMT5P98S+zWuVm+l6IdpW
 AaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1j2/Vmhav9hp+xwE98aMBcISKaxMX/xLgtMgIxAU990=;
 fh=AttT2BmjPE4JCRfTkub+JFRhNsFU3A849TQfUrz7IDc=;
 b=s3cKJbPT5tbWJ6IiVIa2q4oEVJ8aptfzNiFn+sjn/nLO4qLS8xpexZBqXtn9fWWOTW
 FoxHbwumOzT4fLvCQe5B0E6i4ofjm3xSJnymq8gf9+9RVL7y0ULlyxAgWGmkgl6klxR1
 GP6uAFXdJG7Ul6l1b5a5O6MDnu4fX4aEJohDr86V7q2O86Ccra8YbM4Rx5zgiJc9pG4n
 oZYToVbSClLKcStkFXZquvwV2XNG5FFZr5/hvZmWstSKVph8fg8IOkEkYDAZmwuZeCuT
 uwBi6aHSsm4j8eAuxbv0hoaEaQURi2ThWVnFftZ0YFSjEuusWICTYtBF5/1F92VVUVA2
 yDrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785167351; x=1785772151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1j2/Vmhav9hp+xwE98aMBcISKaxMX/xLgtMgIxAU990=;
 b=QaRG6ZdRHc5xZoMbsUyHdVRatqhI1tpw9mih4V1mcvDzyAH3MGGmRWmYkfH89hdZ55
 ShG+GorcowwHw2gbxJXSjnDJcmGk5hsKg/xA/paHF4WFHBPf6gPZNHAVRVMIsql1wCdh
 nIYigwHjAbrwsBlm5+POoOeHdIRcnb+SQrqINrvutc7EG52XyUdvS7gnsEDT54afwdTx
 yYH1QK2zh3aTXDU13yEfurmIORxlI5t/BEEXx6uCzHQLcdxxuyGgbdQPV7STFV2sRxVi
 Kw/zuxGRlXk1eUkS7kaV6rcFzDFNoHwAIawJENXu5ssxMGV9uAlp5OsoG/N206v5dAh5
 6+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167351; x=1785772151;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1j2/Vmhav9hp+xwE98aMBcISKaxMX/xLgtMgIxAU990=;
 b=MuspEk9m2CAAKwXZKIjrdDqNU61xDNA3ShXCzuJ69lz+DIeBI6ViRS+OfCVbZ14sYe
 +iPpDsJisvCvByucMRNKtWAATV6tUOAUvUAwS3ElFx5+YdeBdIj3zT3ZPWIoYwp+leSE
 BRslc+Y2qLcd+j019sQNFyKExg6NLE5d6LY8zu9Do+hhuaaugofZayjKHYbR+fwZI6cI
 MZkNvnWQSb7M5Sa5VVuOCGd8ElBwNsugaceP6WZDfQg8Q4MVwvUDvZTiNiVrpWxaiYdj
 pMkK3FupJ8I7gOJUd6n1JQ/0QMQY2JzQ2TLEUgOtdPaYNxhdPVdlpJrFAyk6AgIamj2/
 Ayzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcqZCGaErsVssRljMEX0UlehSzbAX1a6wJ7B9oaNLJJjb/+HpnmVIvdM7iG0d80Ws9+QGR+HwBgHI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvgyPkzEeyDMtueHHIP64TQCe1SMRpXE/RXLTJCPw8WzjDwEjG
 VC0/bxy9LFeTF5kXL8S9b58Fmz47z5FpVhPtRS3+SOoh8l23uxwPpRbBq4vdEZuHklr75HKGBM3
 yDWOZKOyaZedE7sFExfh/yoY1T19LLT4=
X-Gm-Gg: AR+sD11AQdSRG9YRb7+lEEXMhdpu6uEFPdv77IJ8PZ16CmGuyeHcfci7IbqGEsIxlFV
 KyqgHQG7uPwqs+0i8g68nkourqpPHZ0AUnIJLIRcboupJt3c0yZ3VB76WpvNrI3D27K2Cu7CkNV
 s48GtiYw6jcihr3puWD8xfiorRDTUkRMH12PZucjFKnuOaOJALzBMwzNFDNGETPVGH181RzoFji
 HVYJO8kY2Nw7WVu8alZ+uTbDAtYI7LwAad0ZpBSeZrnVuKxbyqnSaj7YWepNxqWBtl7vb6NRrwM
 iCIJtoA9AJvb4Jsadt0=
X-Received: by 2002:a05:6808:bd6:b0:489:5d05:552c with SMTP id
 5614622812f47-4ab6a057c69mr7313742b6e.18.1785167350906; Mon, 27 Jul 2026
 08:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260727091555.1023910-1-wenst@chromium.org>
In-Reply-To: <20260727091555.1023910-1-wenst@chromium.org>
From: YoungJoon Lee <getfeus@gmail.com>
Date: Tue, 28 Jul 2026 00:48:57 +0900
X-Gm-Features: AUfX_mzZIAlliZ6SyEB3Z-mqC0yAJJDeNAn1Qi3wrTwtKld-OCTs0GYYwDDse00
Message-ID: <CA+m4KrCkk_p213=JVVcuxjvO2tCREw7_mL596xu-RWJ0Dz3p5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] powervr: MT8173 GPU support
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

Hello,

I tested patches 1/5 through 5/5 from the MT8173 PowerVR v3 series on
an Acer Chromebook R13 (Google Elm), which uses an MT8173 SoC and a
PowerVR Rogue GX6250 GPU with BVNC 4.40.2.51.

For clarity, I applied the five actual patches numbered 1/5 through
5/5. The 0/5 cover letter itself was not applied.

Kernel:
  Linux 7.1.3-stb-cbm-pvr-v3

Relevant kernel configuration:
  CONFIG_DRM_POWERVR=3Dm
  CONFIG_COMMON_CLK_MT8173_MFGTOP=3Dy

Kernel command line:
  powervr.exp_hw_support=3D1

Firmware:
  powervr/rogue_4.40.2.51_v1.fw

The driver probes successfully, loads the firmware, and initializes the
DRM device:

  [    6.110569] powervr 13000000.gpu:
                 [drm] Running on unknown hardware; expect issues.
  [    6.117454] powervr 13000000.gpu:
                 [drm] loaded firmware
                 powervr/rogue_4.40.2.51_v1.fw
  [    6.118010] powervr 13000000.gpu:
                 [drm] FW version v1.0 (build 6476056 OS)
  [    6.122992] [drm] Initialized powervr 1.0.0
                 for 13000000.gpu on minor 1

The following DRM device nodes are created:

  /dev/dri/card0
  /dev/dri/card1
  /dev/dri/renderD128

However, on a clean boot, without manually running vulkaninfo, vkcube,
or another Vulkan application, the driver reports that the GPU has been
lost approximately six seconds after DRM initialization:

  [   12.084078] powervr 13000000.gpu:
                [drm] *ERROR* GPU device lost

The relevant boot sequence is therefore:

  [    6.110569] PowerVR probe begins
  [    6.117454] Firmware is loaded
  [    6.118010] Firmware version is reported
  [    6.122992] DRM initialization completes
  [   12.084078] GPU device lost

The unused-regulator shutdown occurs considerably later:

  [   31.712124] vgpu: disabling

Therefore, the later "vgpu: disabling" message does not appear to be
the immediate cause of the device loss. The GPU is reported lost about
20 seconds before that regulator shutdown message.

After the failure, regulator_summary reports:

  vgpu  0  0  0  normal  1000mV  0mA  700mV  1350mV

This output was collected after the GPU had already been reported lost,
so I do not know whether the regulator state was different during probe
or immediately before the failure.

The PowerVR-related clocks appear enabled in clk_summary:

  mfg_26m       26000000 Hz

  mem_mfg_in_sel
    rate:       455000000 Hz
    enable:     1
    prepare:    1

  mfg_mem
    rate:       455000000 Hz
    enable:     1
    prepare:    1
    consumer:   13000000.gpu
    clock name: mem

  mfg_sel
    rate:       455000000 Hz
    enable:     1
    prepare:    1

  mfg_g3d
    rate:       455000000 Hz
    enable:     1
    prepare:    1
    consumer:   13000000.gpu
    clock name: core

  axi_mfg_in_sel
    rate:       208000000 Hz
    enable:     2
    prepare:    2
    consumer:   power-domain@7

  mfg_axi
    rate:       208000000 Hz
    enable:     1
    prepare:    1
    consumer:   13000000.gpu
    clock name: sys

I also installed Mesa 26.1.5 and vulkan-powervr 26.1.5 and tested the
Vulkan ICD with:

  PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 \
  VK_DRIVER_FILES=3D/usr/share/vulkan/icd.d/powervr_mesa_icd.json \
  vulkaninfo --summary

The PowerVR ICD was found and loaded. Before hanging, Mesa printed:

  WARNING: powervr is not a conformant Vulkan implementation,
           testing use only.

  FINISHME: Missing reset support for brn51764
  FINISHME: Missing reset support for brn58839
  FINISHME: Missing support for brn62269
  FINISHME: Devices without tpu_border_colour_enhanced require entries
            for compressed formats to be stored in the table
            pre-compressed.

The vulkaninfo process then remained in uninterruptible sleep:

  PID   STAT  WCHAN             COMMAND
  3244  Dl+   synchronize_srcu  vulkaninfo --summary

It could not be terminated normally while in that state, and a reboot
was required.

However, the clean-boot log shows that "GPU device lost" occurs even
without starting vulkaninfo manually. The vulkaninfo hang may therefore
be a consequence of the GPU already being in the lost state, rather than
the original cause of the failure.

At this point, the following parts appear to work:

  - MT8173 GPU device-tree node probing
  - MFGTOP clock registration
  - PowerVR kernel module probing
  - Firmware loading
  - Firmware version reporting
  - DRM device initialization
  - Creation of card1 and renderD128

The remaining problem is that the GPU becomes lost approximately six
seconds after initialization.

Could this be related to an interrupt not being delivered, firmware
heartbeat handling, reset sequencing, runtime PM, a missing regulator
consumer relationship, or another MT8173-specific power-domain
requirement?

Please let me know which additional kernel debug options, DRM debug
settings, tracepoints, interrupt statistics, register dumps, or test
patches would be useful. I have physical access to the device and can
build and test further kernel changes.

Thank you for working on MT8173 support.

Best regards,
YoungJoon Lee

2026=E5=B9=B47=E6=9C=8827=E6=97=A5(=E6=9C=88) 18:16 Chen-Yu Tsai <wenst@chr=
omium.org>:
>
> Hi everyone,
>
> This is v3 of my MT8173 PowerVR GPU support series.
>
> I got another inquiry on the status of this patch series, so I thought
> I'd dig it out, fix all the issues and send another version.
>
> This time around Mesa was ready for basic testing, using both vulkanmark
> and glmark2-es2-drm (with Zink). Details below.
>
> Changes since v2 (all in the clk driver patch):
> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
>   - Needed since the driver implements PM domains using the generic PM
>     domain library, which also depends on PM
>   - Fixes build breakage (kernel test robot)
> - Fixed "RST_DELAY_CNT" name (Brian)
> - Dropped unused mfg_desc (Brian)
> - Added check of clk_prepare_enable()'s return value in
>   clk_mt8173_mfgtop_power_on() (Brian)
> - Saved error value for return in IS_ERR(data->clk_26m) branch
>   (Dan Carpenter / kernel test robot w/ smatch)
>
> Changes since v1:
> - Adapted to changed DT bindings
> - Dropped driver change
> - Use same power domain for "a" and "b" GPU power domains
>
>
> This series enables the PowerVR GPU found in the MT8173 SoC, found in
> some Chromebooks.
>
> This version is different from the initial powervr driver submission [1]
> in that it splits out the GPU glue layer support out of the powervr
> driver and into a separate clock and power domain driver. The glue code
> is otherwise the same, and also the same as found in the ChromeOS
> kernels, with some extra comments and macro names added where possible.
>
> Patch 1 adds a binding for the glue layer, called mfgtop. The glue layer
> contains clock and power controls for the GPU.
>
> Patch 2 adds a driver for the glue layer, implemented as a clock driver
> that also provides power domains.
>
> Patch 3 adds an entry for the MT8173 GPU and 6XT series to the PowerVR
> binding.
>
> Patch 4 corrects the clock for the GPU (called MFG) power domain.
>
> Patch 5 adds device nodes for the GPU and glue layer to the MT8173 dtsi
> file.
>
> The kernel driver successfully probes the hardware and loads the
> "rogue_4.40.2.51_v1.fw" firmware provided by Imagination Technologies [2]=
.
> The "exp_hw_support" module parameter needs to be set for the driver to
> probe successfully.
>
> This was tested with Mesa 26.1.5 from Debian Forky. With this version
> vkmark and glmark2-es2 (over Zink) both run fine. Mesa spits out a bunch
> of warnings since the GX6250 core is not officially supported.
>
>     # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vkmark
>     WARNING: powervr is not a conformant Vulkan implementation, testing u=
se only.
>     WARNING: powervr is not a conformant Vulkan implementation, testing u=
se only.
>     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:73: F=
INISHME: Missing reset support for brn51764
>     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:76: F=
INISHME: Missing reset support for brn58839
>     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:523: =
FINISHME: Missing support for brn62269
>     MESA: warning: ../src/imagination/vulkan/pvr_arch_border.c:244: FINIS=
HME: Devices without tpu_border_colour_enhanced require entries for compres=
sed formats to be stored in the table pre-compressed.
>     WARNING: powervr is not a conformant Vulkan implementation, testing u=
se only.
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>         vkmark 2025.01
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>         Vendor ID:      0x1010
>         Device ID:      0x6250
>         Device Name:    PowerVR Rogue GX6250
>         Driver Version: 109056005
>         Device UUID:    d04cd6f3a25fd4900f89c151bccfdfcf
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>     [vertex] device-local=3Dtrue: FPS: 251 FrameTime: 3.984 ms
>     [vertex] device-local=3Dfalse: FPS: 220 FrameTime: 4.545 ms
>     [texture] anisotropy=3D0:^C FPS: 223 FrameTime: 4.484 ms
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>                                        vkmark Score: 231
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>     # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 glmark2-es2-drm
>     WARNING: powervr is not a conformant Vulkan implementation, testing u=
se only.
>     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:73: F=
INISHME: Missing reset support for brn51764
>     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:76: F=
INISHME: Missing reset support for brn58839
>     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:523: =
FINISHME: Missing support for brn62269
>     MESA: warning: ../src/imagination/vulkan/pvr_arch_border.c:244: FINIS=
HME: Devices without tpu_border_colour_enhanced require entries for compres=
sed formats to be stored in the table pre-compressed.
>     Warning: DRM_CAP_ASYNC_PAGE_FLIP not supported, falling back to 'mail=
box' mode for SwapInterval(0).
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>         glmark2 2023.01
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>         OpenGL Information
>         GL_VENDOR:      Mesa
>         GL_RENDERER:    zink Vulkan 1.2(PowerVR Rogue GX6250 (IMAGINATION=
_OPEN_SOURCE_MESA))
>         GL_VERSION:     OpenGL ES 2.0 Mesa 26.1.5-1
>         Surface Config: buf=3D32 r=3D8 g=3D8 b=3D8 a=3D8 depth=3D24 stenc=
il=3D0 samples=3D0
>         Surface Size:   1366x768 fullscreen
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>     [build] use-vbo=3Dfalse: FPS: 49 FrameTime: 20.473 ms
>     [build] use-vbo=3Dtrue: FPS: 45 FrameTime: 22.660 ms
>     [texture] texture-filter=3Dnearest: FPS: 45 FrameTime: 22.642 ms
>     [texture] texture-filter=3Dlinear:^C FPS: 50 FrameTime: 20.172 ms
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>                                       glmark2 Score: 46
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>
> Please have a look.
>
> Thanks
> ChenYu
>
> [1] https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.walke=
r@imgtec.com/
> [2] https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powe=
rvr
>
> Chen-Yu Tsai (5):
>   dt-bindings: clock: mediatek: Add mt8173 mfgtop
>   clk: mediatek: Add mt8173-mfgtop driver
>   dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
>   arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
>   arm64: dts: mediatek: mt8173: Add GPU device nodes
>
>  .../clock/mediatek,mt8173-mfgtop.yaml         |  70 +++++
>  .../bindings/gpu/img,powervr-rogue.yaml       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  33 ++-
>  drivers/clk/mediatek/Kconfig                  |  10 +
>  drivers/clk/mediatek/Makefile                 |   1 +
>  drivers/clk/mediatek/clk-mt8173-mfgtop.c      | 241 ++++++++++++++++++
>  include/dt-bindings/clock/mt8173-clk.h        |   7 +
>  7 files changed, 362 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt81=
73-mfgtop.yaml
>  create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c
>
> --
> 2.55.0.229.g6434b31f56-goog
>
