Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E2BC54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24B210E8DA;
	Tue, 28 Jul 2026 13:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TRBGj56B";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B67F10E7FF
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:47:28 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so2000801a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 00:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785224847; cv=none;
 d=google.com; s=arc-20260327;
 b=GnQHu4PXiwnytQyoF9DDldqNpOtce5s4e8H9CEial3PhUYWvQBis7/XHDtRQUcD0Nd
 1P1RP6+0tmcabWqXstjbO9zjGBENNtiYJEdZ2HCZotFUbNkhBeJlm1DzAh8K641YtTdA
 sfcsgBIehQ3u72DkyV5K+Cd7qJ7kUZOMDu5qktcVEPNCOf7v/ICJKoiOysaGG6Qz7ncc
 a3el/7Ik4nQMNEYlp3lRlIF/0FOMAW3dMsioObOZ5JJ6WlEuE5gLZeaY4p+9IrYXhkJf
 UWSftWrlHnAP9PYlIDhhP0+HBmFti2ta0k2H/+b2I8Uek93CQ69HvcbZTCbHqUSSK3ew
 G87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GvSDrArFihkcvCKtXqCukbCZkd2fZ5Ks67ZlmWgjtZU=;
 fh=Rk5pWT8g+eVw4Vs1bKby7TTQDuDfyy8r/jS7qAaHdlk=;
 b=cukqXPao14I71F0AsFc7xrqb1uT1bQIsZxx1vwIwV6ncdgw02ymFl2R3fJ4YU9bkIh
 YK6wkhVEFnUOmGwNZ7WH+SBhrcimR0RQydSFwB7l2iQcv8AENdxvOBuYwr3J5R7tZ4Nk
 DWXam5nobGFVCLfqve8OlLG5z/1py3R9/4lTfPulV5wdQRBKnyNEEuEExz6TneLp7kvb
 WMKmxPVi+Jdsp8L6UAsBfCDWGGrJhOQRiK1f7dz1coktRQczPaYOO3yj+mMO05hc/Ald
 d5k3hh0XdXZyNBNYohw1FX544BS3amx1bGzq9wb/521jLJowJR9tIB7ibTUKATn0d9qm
 +M4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785224847; x=1785829647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GvSDrArFihkcvCKtXqCukbCZkd2fZ5Ks67ZlmWgjtZU=;
 b=TRBGj56BWyEm2RX7BmoT6QZ/E7TLF4gqiF4V3b6NR+aL4zBxugHZKGppD/7JOLszZH
 g9Msmm6RKMOM/4GIJl7K7rn3iQlUJnDExG8k+aKd9D/lM+ZR9QSmTc63sgX04eweOIW7
 wJNA3Vkp1LcO87if1PEMJJtEFmKkaG0QtNcF0hCxumE0bnvv/8hQMVb4pELjo5n8v7gg
 U3MEh0krK0LJ4sY/KlgfpmvHjaXjrLrMRdYPPdTpn2ppv5QI4LQcSAoCaUSiHObA1Imo
 MBv5v5Ihp4LqiKE1MAulkA02LowGklle1d4KxmnPt5r3jO2ij2VWv8XMqx4PDRtWE2s/
 Rp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224847; x=1785829647;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GvSDrArFihkcvCKtXqCukbCZkd2fZ5Ks67ZlmWgjtZU=;
 b=s+VC66oRNSuwuZOAJopdi4zFvPV6tNXj7CST7o+13ZQinEdkdh3omPs9jhLgunHSXf
 3m+ITCxIVE7sGCuowV676LY0QgchZPpreTkmzq7M9ts4Celg0BPG3ertGGBHjtytdUDL
 wjvM77f970lLitJ6uGBXCreHYgy7LG4BZXHUqqJMKD+/JmOUXRIZBUPl82CrnmwgfKIa
 eY+iw5NHu1O98EicESFM+TPsfN5G8w7fXHeCfyNWVO0baRQqg8EABsyJAA5fHzTcecKt
 9mJKwDvu3ZNsfP36xbvN1yIq2hUCOlHPESm6ydjd8BmO0L4/vNkGG4y3rG1xz+69ZelV
 LZxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNk5J0kjSgJtAMHqv/vQJqw4r8pv5lpZ5nMCyAx6QFf1shX4rrRpoJW9ELd6G3RYvBeOL1LJEfUQw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxq2oFGKMHNiMAy71i9wPe333q2YRtI/ruyugsSCyTpIvrgGx4M
 hVmBYc4gTw4Bbvtjz86B9czkpd1YfMEZShuAy4edoUw8i/Ef7ei4cTJ4jPbO6nDL6ID0to2+GVD
 L8GRJUHIVEJRUdPAvD5XfLF4FP+99nok=
X-Gm-Gg: AR+sD13Gc0TUfxJjf2zjMTViuHQaCs3AWtElhIexeX8FN6rSAWhDfjkK+3BCimUdSeb
 GuexPQwYb0AZD+Z+qUIbLUQszX/f4blopSX3lXZaV3K0EXU03rx8iTSGn7SawU/Ou0Di3ea3HG+
 AW8h7gQVhuNCZebEa1FfAQ/Ee6xxMktq3VwmxKg80VszEXpbIP0AdGG2hyakSFjust+IKRgKN6o
 MMeoNS3l0VjXYuruDZr+D9QmjlbF7NdLigVpmwCpjUVy2OOLeRyaIm2WXkyi/UACF7F/5o9TIHD
 4moyHJ7vM+olYzRQTo4uh8iviQGzVw==
X-Received: by 2002:a05:6830:7309:b0:7e9:adef:4fd4 with SMTP id
 46e09a7af769-7effef66a20mr1250145a34.11.1785224847196; Tue, 28 Jul 2026
 00:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260727091555.1023910-1-wenst@chromium.org>
 <CA+m4KrCkk_p213=JVVcuxjvO2tCREw7_mL596xu-RWJ0Dz3p5w@mail.gmail.com>
 <CAGXv+5HXf9U6CdMudVkrWL_62jktW6jYQvtrjAFGc=+UnoKQXA@mail.gmail.com>
In-Reply-To: <CAGXv+5HXf9U6CdMudVkrWL_62jktW6jYQvtrjAFGc=+UnoKQXA@mail.gmail.com>
From: YoungJoon Lee <getfeus@gmail.com>
Date: Tue, 28 Jul 2026 16:47:16 +0900
X-Gm-Features: AUfX_mxyx2qeDVnTVSDo_LY0bWU_51Hewgc7AQz54UsBBlH4uRRKFFV95aTgqR8
Message-ID: <CA+m4KrCnZQW4WqTrKwCAvnwh2YCmObMmvtjdc=HDy5N+RiGm=Q@mail.gmail.com>
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
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:00:37 +0000
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

Hello ChenYu,

Thank you for the clarification.

I understand that the "vgpu" regulator entry is unrelated, and I will
exclude it from further investigation.

I also noticed an important issue with my earlier "clean boot" test:
although I had not manually started vulkaninfo, the system was still
booting the graphical target, so GDM/GNOME had already accessed the
PowerVR Vulkan driver.

I repeated the test in a true console-only environment. In that case,
the PowerVR driver and firmware initialized successfully and the GPU
remained alive until I manually ran vulkaninfo. The GPU was then reported
lost approximately two seconds after vulkaninfo entered the
vkCreateDevice path.

However, this was still tested on Linux 7.1.3 with the MT8173 v3 series
applied. I will rebuild and retest on top of next-20260727 as you
requested before drawing further conclusions.

Thank you,

YoungJoon Lee

2026=E5=B9=B47=E6=9C=8828=E6=97=A5(=E7=81=AB) 15:37 Chen-Yu Tsai <wenst@chr=
omium.org>:
>
> On Mon, Jul 27, 2026 at 11:49=E2=80=AFPM YoungJoon Lee <getfeus@gmail.com=
> wrote:
> >
> > Hello,
> >
> > I tested patches 1/5 through 5/5 from the MT8173 PowerVR v3 series on
> > an Acer Chromebook R13 (Google Elm), which uses an MT8173 SoC and a
> > PowerVR Rogue GX6250 GPU with BVNC 4.40.2.51.
> >
> > For clarity, I applied the five actual patches numbered 1/5 through
> > 5/5. The 0/5 cover letter itself was not applied.
> >
> > Kernel:
> >   Linux 7.1.3-stb-cbm-pvr-v3
>
> Please at least try linux-next. There's around 30 patches for powervr
> between v7.1 and next-20260727, 15 if you count from v7.1 to v7.2-rc1.
>
> > Relevant kernel configuration:
> >   CONFIG_DRM_POWERVR=3Dm
> >   CONFIG_COMMON_CLK_MT8173_MFGTOP=3Dy
> >
> > Kernel command line:
> >   powervr.exp_hw_support=3D1
> >
> > Firmware:
> >   powervr/rogue_4.40.2.51_v1.fw
> >
> > The driver probes successfully, loads the firmware, and initializes the
> > DRM device:
> >
> >   [    6.110569] powervr 13000000.gpu:
> >                  [drm] Running on unknown hardware; expect issues.
> >   [    6.117454] powervr 13000000.gpu:
> >                  [drm] loaded firmware
> >                  powervr/rogue_4.40.2.51_v1.fw
> >   [    6.118010] powervr 13000000.gpu:
> >                  [drm] FW version v1.0 (build 6476056 OS)
> >   [    6.122992] [drm] Initialized powervr 1.0.0
> >                  for 13000000.gpu on minor 1
> >
> > The following DRM device nodes are created:
> >
> >   /dev/dri/card0
> >   /dev/dri/card1
> >   /dev/dri/renderD128
> >
> > However, on a clean boot, without manually running vulkaninfo, vkcube,
> > or another Vulkan application, the driver reports that the GPU has been
> > lost approximately six seconds after DRM initialization:
> >
> >   [   12.084078] powervr 13000000.gpu:
> >                 [drm] *ERROR* GPU device lost
> >
> > The relevant boot sequence is therefore:
> >
> >   [    6.110569] PowerVR probe begins
> >   [    6.117454] Firmware is loaded
> >   [    6.118010] Firmware version is reported
> >   [    6.122992] DRM initialization completes
> >   [   12.084078] GPU device lost
> >
> > The unused-regulator shutdown occurs considerably later:
> >
> >   [   31.712124] vgpu: disabling
> >
> > Therefore, the later "vgpu: disabling" message does not appear to be
> > the immediate cause of the device loss. The GPU is reported lost about
> > 20 seconds before that regulator shutdown message.
> >
> > After the failure, regulator_summary reports:
> >
> >   vgpu  0  0  0  normal  1000mV  0mA  700mV  1350mV
>
> This is unrelated. This regulator output is _really_ unused. "vgpu" is
> just the default name on the PMIC.
>
>
> > This output was collected after the GPU had already been reported lost,
> > so I do not know whether the regulator state was different during probe
> > or immediately before the failure.
> >
> > The PowerVR-related clocks appear enabled in clk_summary:
> >
> >   mfg_26m       26000000 Hz
> >
> >   mem_mfg_in_sel
> >     rate:       455000000 Hz
> >     enable:     1
> >     prepare:    1
> >
> >   mfg_mem
> >     rate:       455000000 Hz
> >     enable:     1
> >     prepare:    1
> >     consumer:   13000000.gpu
> >     clock name: mem
> >
> >   mfg_sel
> >     rate:       455000000 Hz
> >     enable:     1
> >     prepare:    1
> >
> >   mfg_g3d
> >     rate:       455000000 Hz
> >     enable:     1
> >     prepare:    1
> >     consumer:   13000000.gpu
> >     clock name: core
> >
> >   axi_mfg_in_sel
> >     rate:       208000000 Hz
> >     enable:     2
> >     prepare:    2
> >     consumer:   power-domain@7
> >
> >   mfg_axi
> >     rate:       208000000 Hz
> >     enable:     1
> >     prepare:    1
> >     consumer:   13000000.gpu
> >     clock name: sys
> >
> > I also installed Mesa 26.1.5 and vulkan-powervr 26.1.5 and tested the
> > Vulkan ICD with:
> >
> >   PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 \
> >   VK_DRIVER_FILES=3D/usr/share/vulkan/icd.d/powervr_mesa_icd.json \
> >   vulkaninfo --summary
> >
> > The PowerVR ICD was found and loaded. Before hanging, Mesa printed:
> >
> >   WARNING: powervr is not a conformant Vulkan implementation,
> >            testing use only.
> >
> >   FINISHME: Missing reset support for brn51764
> >   FINISHME: Missing reset support for brn58839
> >   FINISHME: Missing support for brn62269
> >   FINISHME: Devices without tpu_border_colour_enhanced require entries
> >             for compressed formats to be stored in the table
> >             pre-compressed.
> >
> > The vulkaninfo process then remained in uninterruptible sleep:
> >
> >   PID   STAT  WCHAN             COMMAND
> >   3244  Dl+   synchronize_srcu  vulkaninfo --summary
> >
> > It could not be terminated normally while in that state, and a reboot
> > was required.
> >
> > However, the clean-boot log shows that "GPU device lost" occurs even
> > without starting vulkaninfo manually. The vulkaninfo hang may therefore
> > be a consequence of the GPU already being in the lost state, rather tha=
n
> > the original cause of the failure.
> >
> > At this point, the following parts appear to work:
> >
> >   - MT8173 GPU device-tree node probing
> >   - MFGTOP clock registration
> >   - PowerVR kernel module probing
> >   - Firmware loading
> >   - Firmware version reporting
> >   - DRM device initialization
> >   - Creation of card1 and renderD128
> >
> > The remaining problem is that the GPU becomes lost approximately six
> > seconds after initialization.
>
> Sorry. I'm not seeing this on my device. I'm running the patches on
> top of next-20260727 this round.
>
>
> ChenYu
>
> > Could this be related to an interrupt not being delivered, firmware
> > heartbeat handling, reset sequencing, runtime PM, a missing regulator
> > consumer relationship, or another MT8173-specific power-domain
> > requirement?
> >
> > Please let me know which additional kernel debug options, DRM debug
> > settings, tracepoints, interrupt statistics, register dumps, or test
> > patches would be useful. I have physical access to the device and can
> > build and test further kernel changes.
> >
> > Thank you for working on MT8173 support.
> >
> > Best regards,
> > YoungJoon Lee
> >
> > 2026=E5=B9=B47=E6=9C=8827=E6=97=A5(=E6=9C=88) 18:16 Chen-Yu Tsai <wenst=
@chromium.org>:
> > >
> > > Hi everyone,
> > >
> > > This is v3 of my MT8173 PowerVR GPU support series.
> > >
> > > I got another inquiry on the status of this patch series, so I though=
t
> > > I'd dig it out, fix all the issues and send another version.
> > >
> > > This time around Mesa was ready for basic testing, using both vulkanm=
ark
> > > and glmark2-es2-drm (with Zink). Details below.
> > >
> > > Changes since v2 (all in the clk driver patch):
> > > - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> > >   - Needed since the driver implements PM domains using the generic P=
M
> > >     domain library, which also depends on PM
> > >   - Fixes build breakage (kernel test robot)
> > > - Fixed "RST_DELAY_CNT" name (Brian)
> > > - Dropped unused mfg_desc (Brian)
> > > - Added check of clk_prepare_enable()'s return value in
> > >   clk_mt8173_mfgtop_power_on() (Brian)
> > > - Saved error value for return in IS_ERR(data->clk_26m) branch
> > >   (Dan Carpenter / kernel test robot w/ smatch)
> > >
> > > Changes since v1:
> > > - Adapted to changed DT bindings
> > > - Dropped driver change
> > > - Use same power domain for "a" and "b" GPU power domains
> > >
> > >
> > > This series enables the PowerVR GPU found in the MT8173 SoC, found in
> > > some Chromebooks.
> > >
> > > This version is different from the initial powervr driver submission =
[1]
> > > in that it splits out the GPU glue layer support out of the powervr
> > > driver and into a separate clock and power domain driver. The glue co=
de
> > > is otherwise the same, and also the same as found in the ChromeOS
> > > kernels, with some extra comments and macro names added where possibl=
e.
> > >
> > > Patch 1 adds a binding for the glue layer, called mfgtop. The glue la=
yer
> > > contains clock and power controls for the GPU.
> > >
> > > Patch 2 adds a driver for the glue layer, implemented as a clock driv=
er
> > > that also provides power domains.
> > >
> > > Patch 3 adds an entry for the MT8173 GPU and 6XT series to the PowerV=
R
> > > binding.
> > >
> > > Patch 4 corrects the clock for the GPU (called MFG) power domain.
> > >
> > > Patch 5 adds device nodes for the GPU and glue layer to the MT8173 dt=
si
> > > file.
> > >
> > > The kernel driver successfully probes the hardware and loads the
> > > "rogue_4.40.2.51_v1.fw" firmware provided by Imagination Technologies=
 [2].
> > > The "exp_hw_support" module parameter needs to be set for the driver =
to
> > > probe successfully.
> > >
> > > This was tested with Mesa 26.1.5 from Debian Forky. With this version
> > > vkmark and glmark2-es2 (over Zink) both run fine. Mesa spits out a bu=
nch
> > > of warnings since the GX6250 core is not officially supported.
> > >
> > >     # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vkmark
> > >     WARNING: powervr is not a conformant Vulkan implementation, testi=
ng use only.
> > >     WARNING: powervr is not a conformant Vulkan implementation, testi=
ng use only.
> > >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:7=
3: FINISHME: Missing reset support for brn51764
> > >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:7=
6: FINISHME: Missing reset support for brn58839
> > >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:5=
23: FINISHME: Missing support for brn62269
> > >     MESA: warning: ../src/imagination/vulkan/pvr_arch_border.c:244: F=
INISHME: Devices without tpu_border_colour_enhanced require entries for com=
pressed formats to be stored in the table pre-compressed.
> > >     WARNING: powervr is not a conformant Vulkan implementation, testi=
ng use only.
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >         vkmark 2025.01
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >         Vendor ID:      0x1010
> > >         Device ID:      0x6250
> > >         Device Name:    PowerVR Rogue GX6250
> > >         Driver Version: 109056005
> > >         Device UUID:    d04cd6f3a25fd4900f89c151bccfdfcf
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >     [vertex] device-local=3Dtrue: FPS: 251 FrameTime: 3.984 ms
> > >     [vertex] device-local=3Dfalse: FPS: 220 FrameTime: 4.545 ms
> > >     [texture] anisotropy=3D0:^C FPS: 223 FrameTime: 4.484 ms
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >                                        vkmark Score: 231
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >     # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 glmark2-es2-drm
> > >     WARNING: powervr is not a conformant Vulkan implementation, testi=
ng use only.
> > >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:7=
3: FINISHME: Missing reset support for brn51764
> > >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:7=
6: FINISHME: Missing reset support for brn58839
> > >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:5=
23: FINISHME: Missing support for brn62269
> > >     MESA: warning: ../src/imagination/vulkan/pvr_arch_border.c:244: F=
INISHME: Devices without tpu_border_colour_enhanced require entries for com=
pressed formats to be stored in the table pre-compressed.
> > >     Warning: DRM_CAP_ASYNC_PAGE_FLIP not supported, falling back to '=
mailbox' mode for SwapInterval(0).
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >         glmark2 2023.01
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >         OpenGL Information
> > >         GL_VENDOR:      Mesa
> > >         GL_RENDERER:    zink Vulkan 1.2(PowerVR Rogue GX6250 (IMAGINA=
TION_OPEN_SOURCE_MESA))
> > >         GL_VERSION:     OpenGL ES 2.0 Mesa 26.1.5-1
> > >         Surface Config: buf=3D32 r=3D8 g=3D8 b=3D8 a=3D8 depth=3D24 s=
tencil=3D0 samples=3D0
> > >         Surface Size:   1366x768 fullscreen
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >     [build] use-vbo=3Dfalse: FPS: 49 FrameTime: 20.473 ms
> > >     [build] use-vbo=3Dtrue: FPS: 45 FrameTime: 22.660 ms
> > >     [texture] texture-filter=3Dnearest: FPS: 45 FrameTime: 22.642 ms
> > >     [texture] texture-filter=3Dlinear:^C FPS: 50 FrameTime: 20.172 ms
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >                                       glmark2 Score: 46
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >
> > > Please have a look.
> > >
> > > Thanks
> > > ChenYu
> > >
> > > [1] https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.w=
alker@imgtec.com/
> > > [2] https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/=
powervr
> > >
> > > Chen-Yu Tsai (5):
> > >   dt-bindings: clock: mediatek: Add mt8173 mfgtop
> > >   clk: mediatek: Add mt8173-mfgtop driver
> > >   dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
> > >   arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
> > >   arm64: dts: mediatek: mt8173: Add GPU device nodes
> > >
> > >  .../clock/mediatek,mt8173-mfgtop.yaml         |  70 +++++
> > >  .../bindings/gpu/img,powervr-rogue.yaml       |   1 +
> > >  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  33 ++-
> > >  drivers/clk/mediatek/Kconfig                  |  10 +
> > >  drivers/clk/mediatek/Makefile                 |   1 +
> > >  drivers/clk/mediatek/clk-mt8173-mfgtop.c      | 241 ++++++++++++++++=
++
> > >  include/dt-bindings/clock/mt8173-clk.h        |   7 +
> > >  7 files changed, 362 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,=
mt8173-mfgtop.yaml
> > >  create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c
> > >
> > > --
> > > 2.55.0.229.g6434b31f56-goog
> > >
