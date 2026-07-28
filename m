Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D55BC54F55
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAB110E7C8;
	Tue, 28 Jul 2026 07:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="btWkWtu9";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304D110E52A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:29:28 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7eb42a2f5feso1540871a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 23:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785220167; cv=none;
 d=google.com; s=arc-20260327;
 b=Dpt2fBz3X2/nuC73W8hx66LgPuY6PDpLPvKOkGHqKm8COBCSQ077DMKqA2/lryBmAn
 rJSJL0BDOi4RJhwb+Ost3LQ/Jgj/iXHYD2szp9EtuME7dBj9v01pVqZA2FNLsSeKp6xG
 CcAWXAH2wLsORw/c7xh4N+ZDY4jslvkWJ3yftjr6bDaO9/8ZjlMW8FTRNXZfHgXPiuMV
 ojSGzd6FcR6koVyunuKl38CjTs7j6HOjajpCx26cwPcQGdp0mZu//pkk1D1fbg5MUu8O
 KqboNdX7xtsGiX8h9B16XEIKLPkB+CqRVcWOlO4iFDApax/xNrI7UZRh5/Xz7KAJwflU
 9v4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xFX8bthatWsOvIJRpA2ZT87HmNwZf+toNO8iYTHN9Ec=;
 fh=EakUZLV7DFXswNWdCZ5w+u88o0pAmhSi9b3AFgd07qU=;
 b=goTmmRl9sy7a5zW4amj0PVoKmOa5MALkcPXGxu2eZxiY/gx7WvzvQzKbDIRfjJy+qe
 HaTUwsPDIw9v9WAupLrBQveSXHlZoAyZifMUGynAwnARYJN1mqr/gY1JPeTUkgiWum1p
 XXGL+gcn8aic76/NK94V9h/jd4ODN1uQGgfbwoBELg4cZvlyu/yUV8YIr5NfC6PVoLS5
 tlRBhuICEfPKdhpTEF9c/0iU9/ccxHw3SdZOMN6T+CPGpBn/b0qNTubW5QMadMVaswL4
 aeiflfWhw6aOgKIE5ASqJNLe6FEyCRFmNC8AC1nFa6CMoh3/dxZPXNyRCjeOql0jQNnY
 Mfdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785220167; x=1785824967; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xFX8bthatWsOvIJRpA2ZT87HmNwZf+toNO8iYTHN9Ec=;
 b=btWkWtu92vbMeRoC98AW4CVaoJpfmGkGBMgZeYBVftp7ZUL6cqjVa6T8pKb3Tn7bGH
 /dv4SmX+PWMjagpRhNMSNBGWCvZqqBC6AgZ8QOULpJ2IM20bpzE6GRhFgZ7VLY0vXCLf
 3vkPPH2rVmeWIKSCNFZR9z6YkDcIHg83vq4yAh26JYQ09moiq91zPmm0VCWlKweovcxu
 k9IQH9VgFT2W88hi6paoSnF8b2KgRyK/9hNUsNiFQOhr6JbxR9pM+Lj3b6aqGsHNqpXO
 aaeShsiPcFAbkQ6+ITmXo+qm1EcsS5UKRbQGOwSZZnEotkmtZgQwDFeAgtwD8LcwSXz3
 XKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785220167; x=1785824967;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xFX8bthatWsOvIJRpA2ZT87HmNwZf+toNO8iYTHN9Ec=;
 b=EI4yrlfLhUUxio44rGi/unC6xpCPuBf2tierZBnzpdWUFr93pPczJJP6EDE8nzlglg
 ZXYUQCy4HP/ys9MDF37QiXvutdY4fijrQKVQMbgp896i88QZmk+tOeFtcFZ2M0OC7PG8
 toqGY/8CvUJZMtDO5sCGOwnRkCy+NP9bAv4qaj0oVJEt1HI4RQs4yzSYN0fCn8dvItVV
 Mhv6xt7bCeofWshG1C9gC646Ozqb3NLEpvC0NQeyeuq4imfcqsGx85EPKytFCO8QIbC1
 E9SVroRHNH3MO8G7aQ4fXX/RAwPGEXRL7WUyg0JtYweBLYHBsQ71A8SCSeYNk3EsIyZs
 AqVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKY38Ht76w4GeyUXY9SigqCIu7iQmn0Np5LikpFOb2pqZOg/32cRfnNBOyTIIU79YjzVbaoYH+05k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGUy/vtJbWDhNbJ64623AG4vP3+kUe3C2/qStmx/3R9PSQFwxB
 QZ2jnuLT0osIW0NpyODePqFhvVhULPf/BqWYuUsRlFPeqKiyqI1CC6oo1lqKYXaQlgOgTUfJXBJ
 vfRQJ5rScUAmpwSCpDI/HXls83DDyxUM=
X-Gm-Gg: AR+sD11FAbCOt01H+lAH+uMQF9euYujcmKLy9QSEyl9MoSCb7S0P/51SDhN1dlSdGSC
 wGagCaB/hekgZLWWc1U8VpoT0j08FoxY/ZAomVNyy+SJ1HW3vmA0wKzH1IKJw0mewj1igufgKqd
 qRtcXRD4CM/AVspJ6ToKvSM4S/z/Kaf1Ld42NMnhsCNeK/iZWBCA2HTiorrv2NvsyzrmJLG8Gra
 +QaaMw1uh8tkbZztD7b+LK2g3dWdzYYchloYD4rsbKJyvZ/MgqKy3MCdnzKwmSo930Vh6OwIFi+
 xhmkX6VZ+iLBNW8UpPs=
X-Received: by 2002:a05:6830:67d5:b0:7e9:b4cf:683a with SMTP id
 46e09a7af769-7efff073fcamr714504a34.26.1785220166999; Mon, 27 Jul 2026
 23:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260727091555.1023910-1-wenst@chromium.org>
 <CA+m4KrCkk_p213=JVVcuxjvO2tCREw7_mL596xu-RWJ0Dz3p5w@mail.gmail.com>
In-Reply-To: <CA+m4KrCkk_p213=JVVcuxjvO2tCREw7_mL596xu-RWJ0Dz3p5w@mail.gmail.com>
From: YoungJoon Lee <getfeus@gmail.com>
Date: Tue, 28 Jul 2026 15:29:12 +0900
X-Gm-Features: AUfX_mz3O1zrsPa-7WIfg6xlEr6_-GsvV0PXqP_1Vgrh1Mtk_4OUM3iE6QtlIxg
Message-ID: <CA+m4KrDRARp+qA3cTQG8sb=GtksFMdSjzCKmw1467HakFdiHmg@mail.gmail.com>
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

I am testing the upstream Mesa PowerVR Vulkan driver and Linux PowerVR
DRM driver on a Google Elm Chromebook with a MediaTek MT8173 SoC and a
PowerVR Rogue GX6250 GPU.

I can reliably reproduce a GPU device loss and permanent process hang
using vulkaninfo in a clean console-only environment, without GNOME,
GDM, Mutter, or another graphics application running.

System information:

Device: Google Elm Chromebook
SoC: MediaTek MT8173
GPU: PowerVR Rogue GX6250
Architecture: aarch64
Distribution: Arch Linux ARM
Kernel: Linux 7.1.3-stb-cbm-pvr-v3
Mesa: 26.1.5
Firmware: powervr/rogue_4.40.2.51_v1.fw
Kernel parameter: powervr.exp_hw_support=3D1
Vulkan ICD: /usr/share/vulkan/icd.d/powervr_mesa_icd.json
Vulkan library: /usr/lib/libvulkan_powervr_mesa.so

The kernel driver and firmware initially load successfully:

powervr 13000000.gpu: [drm] Running on unknown hardware; expect issues.
powervr 13000000.gpu: [drm] loaded firmware powervr/rogue_4.40.2.51_v1.fw
powervr 13000000.gpu: [drm] FW version v1.0 (build 6476056 OS)
[drm] Initialized powervr 1.0.0 for 13000000.gpu on minor 1

I then run:

env
PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1
VK_DRIVER_FILES=3D/usr/share/vulkan/icd.d/powervr_mesa_icd.json
VK_LOADER_DEBUG=3Dall
LD_BIND_NOW=3D1
vulkaninfo --summary

The Vulkan loader successfully detects the physical device:

Original order:
[0] PowerVR Rogue GX6250
Sorted order:
[0] PowerVR Rogue GX6250

It then reaches the device-creation path:

vkCreateDevice layer callstack setup to:
<Application>
||
<Loader>
||
<Device>
Using "PowerVR Rogue GX6250" with driver:
"/usr/lib/libvulkan_powervr_mesa.so"

Immediately afterward, Mesa prints:

MESA: warning: pvr_arch_job_context.c:73:
FINISHME: Missing reset support for brn51764

MESA: warning: pvr_arch_job_context.c:76:
FINISHME: Missing reset support for brn58839

MESA: warning: pvr_arch_job_context.c:523:
FINISHME: Missing support for brn62269

MESA: warning: pvr_arch_border.c:244:
FINISHME: Devices without tpu_border_colour_enhanced require entries
for compressed formats to be stored in the table pre-compressed.

Approximately two seconds after starting vulkaninfo, the kernel reports:

powervr 13000000.gpu: [drm] ERROR GPU device lost

vulkaninfo does not return. It remains in uninterruptible sleep:

PID PPID STAT WCHAN CMD
526 434 Dl+ synchronize_srcu vulkaninfo --summary

/proc/526/status:
State: D (disk sleep)

/proc/526/wchan:
__synchronize_srcu

The current syscall is ioctl, and vulkaninfo is the only process
holding /dev/dri/renderD128.

The blocked process has this kernel stack:

__synchronize_srcu
synchronize_srcu
drm_dev_unplug
pvr_power_reset
pvr_mmu_flush_exec
pvr_mmu_op_context_destroy
pvr_vm_bind_op_fini
pvr_vm_unmap_obj_locked
pvr_vm_unmap
pvr_ioctl_vm_unmap
drm_ioctl_kernel
drm_ioctl
__arm64_sys_ioctl
invoke_syscall
el0_svc_common
do_el0_svc
el0_svc

The observed sequence is therefore:

The PowerVR kernel driver and firmware initialize successfully.
vkCreateInstance succeeds.
Physical-device enumeration succeeds and reports the GX6250.
Execution reaches vkCreateDevice.
The kernel reports GPU device lost.
The process enters the PVR VM-unmap/reset cleanup path.
It hangs indefinitely in drm_dev_unplug -> synchronize_srcu.

This appears to expose two related issues:

GPU device loss during Vulkan device creation.
A permanent kernel hang in the device-loss cleanup/reset path.

I am not assuming that the FINISHME messages for brn51764, brn58839,
brn62269, or the border-colour path are necessarily the direct cause.
I included them because they are the final Mesa messages printed
immediately before the failure.

Could you please advise whether the GX6250 hardware revision used by
MT8173 is expected to work with the current experimental driver, and
whether this should primarily be reported against Mesa, the Linux
PowerVR DRM driver, or both?

I can provide the complete logs or run a minimal Vulkan reproducer
that separately records vkCreateInstance, vkEnumeratePhysicalDevices,
and vkCreateDevice if that would be useful.

Best regards,

YoungJoon Lee

2026=E5=B9=B47=E6=9C=8828=E6=97=A5(=E7=81=AB) 0:48 YoungJoon Lee <getfeus@g=
mail.com>:
>
> Hello,
>
> I tested patches 1/5 through 5/5 from the MT8173 PowerVR v3 series on
> an Acer Chromebook R13 (Google Elm), which uses an MT8173 SoC and a
> PowerVR Rogue GX6250 GPU with BVNC 4.40.2.51.
>
> For clarity, I applied the five actual patches numbered 1/5 through
> 5/5. The 0/5 cover letter itself was not applied.
>
> Kernel:
>   Linux 7.1.3-stb-cbm-pvr-v3
>
> Relevant kernel configuration:
>   CONFIG_DRM_POWERVR=3Dm
>   CONFIG_COMMON_CLK_MT8173_MFGTOP=3Dy
>
> Kernel command line:
>   powervr.exp_hw_support=3D1
>
> Firmware:
>   powervr/rogue_4.40.2.51_v1.fw
>
> The driver probes successfully, loads the firmware, and initializes the
> DRM device:
>
>   [    6.110569] powervr 13000000.gpu:
>                  [drm] Running on unknown hardware; expect issues.
>   [    6.117454] powervr 13000000.gpu:
>                  [drm] loaded firmware
>                  powervr/rogue_4.40.2.51_v1.fw
>   [    6.118010] powervr 13000000.gpu:
>                  [drm] FW version v1.0 (build 6476056 OS)
>   [    6.122992] [drm] Initialized powervr 1.0.0
>                  for 13000000.gpu on minor 1
>
> The following DRM device nodes are created:
>
>   /dev/dri/card0
>   /dev/dri/card1
>   /dev/dri/renderD128
>
> However, on a clean boot, without manually running vulkaninfo, vkcube,
> or another Vulkan application, the driver reports that the GPU has been
> lost approximately six seconds after DRM initialization:
>
>   [   12.084078] powervr 13000000.gpu:
>                 [drm] *ERROR* GPU device lost
>
> The relevant boot sequence is therefore:
>
>   [    6.110569] PowerVR probe begins
>   [    6.117454] Firmware is loaded
>   [    6.118010] Firmware version is reported
>   [    6.122992] DRM initialization completes
>   [   12.084078] GPU device lost
>
> The unused-regulator shutdown occurs considerably later:
>
>   [   31.712124] vgpu: disabling
>
> Therefore, the later "vgpu: disabling" message does not appear to be
> the immediate cause of the device loss. The GPU is reported lost about
> 20 seconds before that regulator shutdown message.
>
> After the failure, regulator_summary reports:
>
>   vgpu  0  0  0  normal  1000mV  0mA  700mV  1350mV
>
> This output was collected after the GPU had already been reported lost,
> so I do not know whether the regulator state was different during probe
> or immediately before the failure.
>
> The PowerVR-related clocks appear enabled in clk_summary:
>
>   mfg_26m       26000000 Hz
>
>   mem_mfg_in_sel
>     rate:       455000000 Hz
>     enable:     1
>     prepare:    1
>
>   mfg_mem
>     rate:       455000000 Hz
>     enable:     1
>     prepare:    1
>     consumer:   13000000.gpu
>     clock name: mem
>
>   mfg_sel
>     rate:       455000000 Hz
>     enable:     1
>     prepare:    1
>
>   mfg_g3d
>     rate:       455000000 Hz
>     enable:     1
>     prepare:    1
>     consumer:   13000000.gpu
>     clock name: core
>
>   axi_mfg_in_sel
>     rate:       208000000 Hz
>     enable:     2
>     prepare:    2
>     consumer:   power-domain@7
>
>   mfg_axi
>     rate:       208000000 Hz
>     enable:     1
>     prepare:    1
>     consumer:   13000000.gpu
>     clock name: sys
>
> I also installed Mesa 26.1.5 and vulkan-powervr 26.1.5 and tested the
> Vulkan ICD with:
>
>   PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 \
>   VK_DRIVER_FILES=3D/usr/share/vulkan/icd.d/powervr_mesa_icd.json \
>   vulkaninfo --summary
>
> The PowerVR ICD was found and loaded. Before hanging, Mesa printed:
>
>   WARNING: powervr is not a conformant Vulkan implementation,
>            testing use only.
>
>   FINISHME: Missing reset support for brn51764
>   FINISHME: Missing reset support for brn58839
>   FINISHME: Missing support for brn62269
>   FINISHME: Devices without tpu_border_colour_enhanced require entries
>             for compressed formats to be stored in the table
>             pre-compressed.
>
> The vulkaninfo process then remained in uninterruptible sleep:
>
>   PID   STAT  WCHAN             COMMAND
>   3244  Dl+   synchronize_srcu  vulkaninfo --summary
>
> It could not be terminated normally while in that state, and a reboot
> was required.
>
> However, the clean-boot log shows that "GPU device lost" occurs even
> without starting vulkaninfo manually. The vulkaninfo hang may therefore
> be a consequence of the GPU already being in the lost state, rather than
> the original cause of the failure.
>
> At this point, the following parts appear to work:
>
>   - MT8173 GPU device-tree node probing
>   - MFGTOP clock registration
>   - PowerVR kernel module probing
>   - Firmware loading
>   - Firmware version reporting
>   - DRM device initialization
>   - Creation of card1 and renderD128
>
> The remaining problem is that the GPU becomes lost approximately six
> seconds after initialization.
>
> Could this be related to an interrupt not being delivered, firmware
> heartbeat handling, reset sequencing, runtime PM, a missing regulator
> consumer relationship, or another MT8173-specific power-domain
> requirement?
>
> Please let me know which additional kernel debug options, DRM debug
> settings, tracepoints, interrupt statistics, register dumps, or test
> patches would be useful. I have physical access to the device and can
> build and test further kernel changes.
>
> Thank you for working on MT8173 support.
>
> Best regards,
> YoungJoon Lee
>
> 2026=E5=B9=B47=E6=9C=8827=E6=97=A5(=E6=9C=88) 18:16 Chen-Yu Tsai <wenst@c=
hromium.org>:
> >
> > Hi everyone,
> >
> > This is v3 of my MT8173 PowerVR GPU support series.
> >
> > I got another inquiry on the status of this patch series, so I thought
> > I'd dig it out, fix all the issues and send another version.
> >
> > This time around Mesa was ready for basic testing, using both vulkanmar=
k
> > and glmark2-es2-drm (with Zink). Details below.
> >
> > Changes since v2 (all in the clk driver patch):
> > - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> >   - Needed since the driver implements PM domains using the generic PM
> >     domain library, which also depends on PM
> >   - Fixes build breakage (kernel test robot)
> > - Fixed "RST_DELAY_CNT" name (Brian)
> > - Dropped unused mfg_desc (Brian)
> > - Added check of clk_prepare_enable()'s return value in
> >   clk_mt8173_mfgtop_power_on() (Brian)
> > - Saved error value for return in IS_ERR(data->clk_26m) branch
> >   (Dan Carpenter / kernel test robot w/ smatch)
> >
> > Changes since v1:
> > - Adapted to changed DT bindings
> > - Dropped driver change
> > - Use same power domain for "a" and "b" GPU power domains
> >
> >
> > This series enables the PowerVR GPU found in the MT8173 SoC, found in
> > some Chromebooks.
> >
> > This version is different from the initial powervr driver submission [1=
]
> > in that it splits out the GPU glue layer support out of the powervr
> > driver and into a separate clock and power domain driver. The glue code
> > is otherwise the same, and also the same as found in the ChromeOS
> > kernels, with some extra comments and macro names added where possible.
> >
> > Patch 1 adds a binding for the glue layer, called mfgtop. The glue laye=
r
> > contains clock and power controls for the GPU.
> >
> > Patch 2 adds a driver for the glue layer, implemented as a clock driver
> > that also provides power domains.
> >
> > Patch 3 adds an entry for the MT8173 GPU and 6XT series to the PowerVR
> > binding.
> >
> > Patch 4 corrects the clock for the GPU (called MFG) power domain.
> >
> > Patch 5 adds device nodes for the GPU and glue layer to the MT8173 dtsi
> > file.
> >
> > The kernel driver successfully probes the hardware and loads the
> > "rogue_4.40.2.51_v1.fw" firmware provided by Imagination Technologies [=
2].
> > The "exp_hw_support" module parameter needs to be set for the driver to
> > probe successfully.
> >
> > This was tested with Mesa 26.1.5 from Debian Forky. With this version
> > vkmark and glmark2-es2 (over Zink) both run fine. Mesa spits out a bunc=
h
> > of warnings since the GX6250 core is not officially supported.
> >
> >     # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vkmark
> >     WARNING: powervr is not a conformant Vulkan implementation, testing=
 use only.
> >     WARNING: powervr is not a conformant Vulkan implementation, testing=
 use only.
> >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:73:=
 FINISHME: Missing reset support for brn51764
> >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:76:=
 FINISHME: Missing reset support for brn58839
> >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:523=
: FINISHME: Missing support for brn62269
> >     MESA: warning: ../src/imagination/vulkan/pvr_arch_border.c:244: FIN=
ISHME: Devices without tpu_border_colour_enhanced require entries for compr=
essed formats to be stored in the table pre-compressed.
> >     WARNING: powervr is not a conformant Vulkan implementation, testing=
 use only.
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >         vkmark 2025.01
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >         Vendor ID:      0x1010
> >         Device ID:      0x6250
> >         Device Name:    PowerVR Rogue GX6250
> >         Driver Version: 109056005
> >         Device UUID:    d04cd6f3a25fd4900f89c151bccfdfcf
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >     [vertex] device-local=3Dtrue: FPS: 251 FrameTime: 3.984 ms
> >     [vertex] device-local=3Dfalse: FPS: 220 FrameTime: 4.545 ms
> >     [texture] anisotropy=3D0:^C FPS: 223 FrameTime: 4.484 ms
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >                                        vkmark Score: 231
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >     # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 glmark2-es2-drm
> >     WARNING: powervr is not a conformant Vulkan implementation, testing=
 use only.
> >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:73:=
 FINISHME: Missing reset support for brn51764
> >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:76:=
 FINISHME: Missing reset support for brn58839
> >     MESA: warning: ../src/imagination/vulkan/pvr_arch_job_context.c:523=
: FINISHME: Missing support for brn62269
> >     MESA: warning: ../src/imagination/vulkan/pvr_arch_border.c:244: FIN=
ISHME: Devices without tpu_border_colour_enhanced require entries for compr=
essed formats to be stored in the table pre-compressed.
> >     Warning: DRM_CAP_ASYNC_PAGE_FLIP not supported, falling back to 'ma=
ilbox' mode for SwapInterval(0).
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >         glmark2 2023.01
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >         OpenGL Information
> >         GL_VENDOR:      Mesa
> >         GL_RENDERER:    zink Vulkan 1.2(PowerVR Rogue GX6250 (IMAGINATI=
ON_OPEN_SOURCE_MESA))
> >         GL_VERSION:     OpenGL ES 2.0 Mesa 26.1.5-1
> >         Surface Config: buf=3D32 r=3D8 g=3D8 b=3D8 a=3D8 depth=3D24 ste=
ncil=3D0 samples=3D0
> >         Surface Size:   1366x768 fullscreen
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >     [build] use-vbo=3Dfalse: FPS: 49 FrameTime: 20.473 ms
> >     [build] use-vbo=3Dtrue: FPS: 45 FrameTime: 22.660 ms
> >     [texture] texture-filter=3Dnearest: FPS: 45 FrameTime: 22.642 ms
> >     [texture] texture-filter=3Dlinear:^C FPS: 50 FrameTime: 20.172 ms
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >                                       glmark2 Score: 46
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > Please have a look.
> >
> > Thanks
> > ChenYu
> >
> > [1] https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.wal=
ker@imgtec.com/
> > [2] https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/po=
wervr
> >
> > Chen-Yu Tsai (5):
> >   dt-bindings: clock: mediatek: Add mt8173 mfgtop
> >   clk: mediatek: Add mt8173-mfgtop driver
> >   dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
> >   arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
> >   arm64: dts: mediatek: mt8173: Add GPU device nodes
> >
> >  .../clock/mediatek,mt8173-mfgtop.yaml         |  70 +++++
> >  .../bindings/gpu/img,powervr-rogue.yaml       |   1 +
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  33 ++-
> >  drivers/clk/mediatek/Kconfig                  |  10 +
> >  drivers/clk/mediatek/Makefile                 |   1 +
> >  drivers/clk/mediatek/clk-mt8173-mfgtop.c      | 241 ++++++++++++++++++
> >  include/dt-bindings/clock/mt8173-clk.h        |   7 +
> >  7 files changed, 362 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt=
8173-mfgtop.yaml
> >  create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c
> >
> > --
> > 2.55.0.229.g6434b31f56-goog
> >
