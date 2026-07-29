Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F1BC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC3510EAE8;
	Wed, 29 Jul 2026 08:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="DXX8gM62";
	dkim-atps=neutral
X-Greylist: delayed 902 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jul 2026 08:00:36 UTC
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B20D10EAE8;
 Wed, 29 Jul 2026 08:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785311114; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KeH9ESSQbkOBPQSq6a9IAIcS3Hn8flTvgOPsw54MKd/lC2jAfdGqAimB7w54vMlGD8MgRaSOLc7nd7PCtFTlllQ+YspPslMBIkEjd3NvCaJWTI/Dd9n2q6+ubeWMxCS/w7FHoj8igr/E/oLqa+XCT+6meoB8RIpkuWyDAjOu1eY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785311114;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JaaieODsRb6Lc7SUCSr8MRmoUKj2SJFAYLU+HoPNc3Y=; 
 b=lZaXrq7i0JwzQgKp7qLUTHvB8jof5v+YYpey9so8xWf4s/KJtdWZqFKK6nTQQgPnYdWiPaJiobp7fdiNKobmqV0P9lBeYpgtgw2AARX9poeOMiY2UcIVbtAtZXk2Ae6aSlV5FnY88RxnI43nUDQecRmCn3E+ELQ05mu3vak4F2U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785311114; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=JaaieODsRb6Lc7SUCSr8MRmoUKj2SJFAYLU+HoPNc3Y=;
 b=DXX8gM62AQirtbTTYWg7N7OqrM8NvXsqyEsgGOPz49r9E8jB1uyNbnuOkdp2wtaI
 UqFktPBDR6KIfMO5cnCZc9cQtZlvr2PQ78xDd7YWvF0rwp7ppOqGigLItxitGpTmhM+
 tJzzTc3N12gfvQg/eZaWpHnnMEi/9DiJo0fEeNrHDpv+2CbAs5HHIOL0n/2//rWg9LG
 C33qtbfKp3u937bJ3WSNwQse+tLTOtVW7Ws9ch4m5puAaOAsGsXSwluX/MG8VintGOC
 9fJd4ctgQDZ0MSKSR0ih5vaCKaOtkyxW6m0P12VBfhk+PUsnpsNOFcTe+nPdn79mXER
 fLPii357OQ==
Received: by mx.zohomail.com with SMTPS id 1785311111169533.3619402746466;
 Wed, 29 Jul 2026 00:45:11 -0700 (PDT)
Message-ID: <69c607523343f9f1841697e70c1fbe019a24fdba.camel@icenowy.me>
Subject: Re: [PATCH v3 0/5] powervr: MT8173 GPU support
From: Icenowy Zheng <uwu@icenowy.me>
To: YoungJoon Lee <getfeus@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Alessio Belle
 <alessio.belle@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, 	imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Wed, 29 Jul 2026 15:45:03 +0800
In-Reply-To: <CA+m4KrDRARp+qA3cTQG8sb=GtksFMdSjzCKmw1467HakFdiHmg@mail.gmail.com>
References: <20260727091555.1023910-1-wenst@chromium.org>
 <CA+m4KrCkk_p213=JVVcuxjvO2tCREw7_mL596xu-RWJ0Dz3p5w@mail.gmail.com>
 <CA+m4KrDRARp+qA3cTQG8sb=GtksFMdSjzCKmw1467HakFdiHmg@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-07-28=E4=BA=8C=E7=9A=84 15:29 +0900=EF=BC=8CYoungJoon Lee=E5=
=86=99=E9=81=93=EF=BC=9A
> Hello,
>=20
> I am testing the upstream Mesa PowerVR Vulkan driver and Linux
> PowerVR
> DRM driver on a Google Elm Chromebook with a MediaTek MT8173 SoC and
> a
> PowerVR Rogue GX6250 GPU.
>=20
> I can reliably reproduce a GPU device loss and permanent process hang
> using vulkaninfo in a clean console-only environment, without GNOME,
> GDM, Mutter, or another graphics application running.
>=20
> System information:
>=20
> Device: Google Elm Chromebook
> SoC: MediaTek MT8173
> GPU: PowerVR Rogue GX6250
> Architecture: aarch64
> Distribution: Arch Linux ARM
> Kernel: Linux 7.1.3-stb-cbm-pvr-v3
> Mesa: 26.1.5
> Firmware: powervr/rogue_4.40.2.51_v1.fw
> Kernel parameter: powervr.exp_hw_support=3D1
> Vulkan ICD: /usr/share/vulkan/icd.d/powervr_mesa_icd.json
> Vulkan library: /usr/lib/libvulkan_powervr_mesa.so
>=20
> The kernel driver and firmware initially load successfully:
>=20
> powervr 13000000.gpu: [drm] Running on unknown hardware; expect
> issues.
> powervr 13000000.gpu: [drm] loaded firmware
> powervr/rogue_4.40.2.51_v1.fw
> powervr 13000000.gpu: [drm] FW version v1.0 (build 6476056 OS)
> [drm] Initialized powervr 1.0.0 for 13000000.gpu on minor 1
>=20
> I then run:
>=20
> env
> PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1
> VK_DRIVER_FILES=3D/usr/share/vulkan/icd.d/powervr_mesa_icd.json
> VK_LOADER_DEBUG=3Dall
> LD_BIND_NOW=3D1
> vulkaninfo --summary
>=20
> The Vulkan loader successfully detects the physical device:
>=20
> Original order:
> [0] PowerVR Rogue GX6250
> Sorted order:
> [0] PowerVR Rogue GX6250
>=20
> It then reaches the device-creation path:
>=20
> vkCreateDevice layer callstack setup to:
> <Application>
> > >=20
> <Loader>
> > >=20
> <Device>
> Using "PowerVR Rogue GX6250" with driver:
> "/usr/lib/libvulkan_powervr_mesa.so"
>=20
> Immediately afterward, Mesa prints:
>=20
> MESA: warning: pvr_arch_job_context.c:73:
> FINISHME: Missing reset support for brn51764
>=20
> MESA: warning: pvr_arch_job_context.c:76:
> FINISHME: Missing reset support for brn58839
>=20
> MESA: warning: pvr_arch_job_context.c:523:
> FINISHME: Missing support for brn62269
>=20
> MESA: warning: pvr_arch_border.c:244:
> FINISHME: Devices without tpu_border_colour_enhanced require entries
> for compressed formats to be stored in the table pre-compressed.
>=20
> Approximately two seconds after starting vulkaninfo, the kernel
> reports:
>=20
> powervr 13000000.gpu: [drm] ERROR GPU device lost

I remember seeing this because of the runtime power management of
drm/imagination is broken on GX6250.

Could you set the power/control file in the device's sysfs to "on"
(instead of the default "auto") to disable runpm and re-check? I
remember that another error may appear in such case but the GPU won't
be lost.

(However I am on vacation and my MT8173 machine isn't with me so I
cannot provide more information.)

Thanks,
Icenowy

>=20
> vulkaninfo does not return. It remains in uninterruptible sleep:
>=20
> PID PPID STAT WCHAN CMD
> 526 434 Dl+ synchronize_srcu vulkaninfo --summary
>=20
> /proc/526/status:
> State: D (disk sleep)
>=20
> /proc/526/wchan:
> __synchronize_srcu
>=20
> The current syscall is ioctl, and vulkaninfo is the only process
> holding /dev/dri/renderD128.
>=20
> The blocked process has this kernel stack:
>=20
> __synchronize_srcu
> synchronize_srcu
> drm_dev_unplug
> pvr_power_reset
> pvr_mmu_flush_exec
> pvr_mmu_op_context_destroy
> pvr_vm_bind_op_fini
> pvr_vm_unmap_obj_locked
> pvr_vm_unmap
> pvr_ioctl_vm_unmap
> drm_ioctl_kernel
> drm_ioctl
> __arm64_sys_ioctl
> invoke_syscall
> el0_svc_common
> do_el0_svc
> el0_svc
>=20
> The observed sequence is therefore:
>=20
> The PowerVR kernel driver and firmware initialize successfully.
> vkCreateInstance succeeds.
> Physical-device enumeration succeeds and reports the GX6250.
> Execution reaches vkCreateDevice.
> The kernel reports GPU device lost.
> The process enters the PVR VM-unmap/reset cleanup path.
> It hangs indefinitely in drm_dev_unplug -> synchronize_srcu.
>=20
> This appears to expose two related issues:
>=20
> GPU device loss during Vulkan device creation.
> A permanent kernel hang in the device-loss cleanup/reset path.
>=20
> I am not assuming that the FINISHME messages for brn51764, brn58839,
> brn62269, or the border-colour path are necessarily the direct cause.
> I included them because they are the final Mesa messages printed
> immediately before the failure.
>=20
> Could you please advise whether the GX6250 hardware revision used by
> MT8173 is expected to work with the current experimental driver, and
> whether this should primarily be reported against Mesa, the Linux
> PowerVR DRM driver, or both?
>=20
> I can provide the complete logs or run a minimal Vulkan reproducer
> that separately records vkCreateInstance, vkEnumeratePhysicalDevices,
> and vkCreateDevice if that would be useful.
>=20
> Best regards,
>=20
> YoungJoon Lee
>=20
> 2026=E5=B9=B47=E6=9C=8828=E6=97=A5(=E7=81=AB) 0:48 YoungJoon Lee <getfeus=
@gmail.com>:
> >=20
> > Hello,
> >=20
> > I tested patches 1/5 through 5/5 from the MT8173 PowerVR v3 series
> > on
> > an Acer Chromebook R13 (Google Elm), which uses an MT8173 SoC and a
> > PowerVR Rogue GX6250 GPU with BVNC 4.40.2.51.
> >=20
> > For clarity, I applied the five actual patches numbered 1/5 through
> > 5/5. The 0/5 cover letter itself was not applied.
> >=20
> > Kernel:
> > =C2=A0 Linux 7.1.3-stb-cbm-pvr-v3
> >=20
> > Relevant kernel configuration:
> > =C2=A0 CONFIG_DRM_POWERVR=3Dm
> > =C2=A0 CONFIG_COMMON_CLK_MT8173_MFGTOP=3Dy
> >=20
> > Kernel command line:
> > =C2=A0 powervr.exp_hw_support=3D1
> >=20
> > Firmware:
> > =C2=A0 powervr/rogue_4.40.2.51_v1.fw
> >=20
> > The driver probes successfully, loads the firmware, and initializes
> > the
> > DRM device:
> >=20
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 6.110569] powervr 13000000.gpu:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [drm] Running on unknown hardware; expect issue=
s.
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 6.117454] powervr 13000000.gpu:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [drm] loaded firmware
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 powervr/rogue_4.40.2.51_v1.fw
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 6.118010] powervr 13000000.gpu:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [drm] FW version v1.0 (build 6476056 OS)
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 6.122992] [drm] Initialized powervr 1.0.0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for 13000000.gpu on minor 1
> >=20
> > The following DRM device nodes are created:
> >=20
> > =C2=A0 /dev/dri/card0
> > =C2=A0 /dev/dri/card1
> > =C2=A0 /dev/dri/renderD128
> >=20
> > However, on a clean boot, without manually running vulkaninfo,
> > vkcube,
> > or another Vulkan application, the driver reports that the GPU has
> > been
> > lost approximately six seconds after DRM initialization:
> >=20
> > =C2=A0 [=C2=A0=C2=A0 12.084078] powervr 13000000.gpu:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [drm] *ERROR* GPU device lost
> >=20
> > The relevant boot sequence is therefore:
> >=20
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 6.110569] PowerVR probe begins
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 6.117454] Firmware is loaded
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 6.118010] Firmware version is reported
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 6.122992] DRM initialization completes
> > =C2=A0 [=C2=A0=C2=A0 12.084078] GPU device lost
> >=20
> > The unused-regulator shutdown occurs considerably later:
> >=20
> > =C2=A0 [=C2=A0=C2=A0 31.712124] vgpu: disabling
> >=20
> > Therefore, the later "vgpu: disabling" message does not appear to
> > be
> > the immediate cause of the device loss. The GPU is reported lost
> > about
> > 20 seconds before that regulator shutdown message.
> >=20
> > After the failure, regulator_summary reports:
> >=20
> > =C2=A0 vgpu=C2=A0 0=C2=A0 0=C2=A0 0=C2=A0 normal=C2=A0 1000mV=C2=A0 0mA=
=C2=A0 700mV=C2=A0 1350mV
> >=20
> > This output was collected after the GPU had already been reported
> > lost,
> > so I do not know whether the regulator state was different during
> > probe
> > or immediately before the failure.
> >=20
> > The PowerVR-related clocks appear enabled in clk_summary:
> >=20
> > =C2=A0 mfg_26m=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26000000 Hz
> >=20
> > =C2=A0 mem_mfg_in_sel
> > =C2=A0=C2=A0=C2=A0 rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 455000000 =
Hz
> > =C2=A0=C2=A0=C2=A0 enable:=C2=A0=C2=A0=C2=A0=C2=A0 1
> > =C2=A0=C2=A0=C2=A0 prepare:=C2=A0=C2=A0=C2=A0 1
> >=20
> > =C2=A0 mfg_mem
> > =C2=A0=C2=A0=C2=A0 rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 455000000 =
Hz
> > =C2=A0=C2=A0=C2=A0 enable:=C2=A0=C2=A0=C2=A0=C2=A0 1
> > =C2=A0=C2=A0=C2=A0 prepare:=C2=A0=C2=A0=C2=A0 1
> > =C2=A0=C2=A0=C2=A0 consumer:=C2=A0=C2=A0 13000000.gpu
> > =C2=A0=C2=A0=C2=A0 clock name: mem
> >=20
> > =C2=A0 mfg_sel
> > =C2=A0=C2=A0=C2=A0 rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 455000000 =
Hz
> > =C2=A0=C2=A0=C2=A0 enable:=C2=A0=C2=A0=C2=A0=C2=A0 1
> > =C2=A0=C2=A0=C2=A0 prepare:=C2=A0=C2=A0=C2=A0 1
> >=20
> > =C2=A0 mfg_g3d
> > =C2=A0=C2=A0=C2=A0 rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 455000000 =
Hz
> > =C2=A0=C2=A0=C2=A0 enable:=C2=A0=C2=A0=C2=A0=C2=A0 1
> > =C2=A0=C2=A0=C2=A0 prepare:=C2=A0=C2=A0=C2=A0 1
> > =C2=A0=C2=A0=C2=A0 consumer:=C2=A0=C2=A0 13000000.gpu
> > =C2=A0=C2=A0=C2=A0 clock name: core
> >=20
> > =C2=A0 axi_mfg_in_sel
> > =C2=A0=C2=A0=C2=A0 rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 208000000 =
Hz
> > =C2=A0=C2=A0=C2=A0 enable:=C2=A0=C2=A0=C2=A0=C2=A0 2
> > =C2=A0=C2=A0=C2=A0 prepare:=C2=A0=C2=A0=C2=A0 2
> > =C2=A0=C2=A0=C2=A0 consumer:=C2=A0=C2=A0 power-domain@7
> >=20
> > =C2=A0 mfg_axi
> > =C2=A0=C2=A0=C2=A0 rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 208000000 =
Hz
> > =C2=A0=C2=A0=C2=A0 enable:=C2=A0=C2=A0=C2=A0=C2=A0 1
> > =C2=A0=C2=A0=C2=A0 prepare:=C2=A0=C2=A0=C2=A0 1
> > =C2=A0=C2=A0=C2=A0 consumer:=C2=A0=C2=A0 13000000.gpu
> > =C2=A0=C2=A0=C2=A0 clock name: sys
> >=20
> > I also installed Mesa 26.1.5 and vulkan-powervr 26.1.5 and tested
> > the
> > Vulkan ICD with:
> >=20
> > =C2=A0 PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 \
> > =C2=A0 VK_DRIVER_FILES=3D/usr/share/vulkan/icd.d/powervr_mesa_icd.json =
\
> > =C2=A0 vulkaninfo --summary
> >=20
> > The PowerVR ICD was found and loaded. Before hanging, Mesa printed:
> >=20
> > =C2=A0 WARNING: powervr is not a conformant Vulkan implementation,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 testing us=
e only.
> >=20
> > =C2=A0 FINISHME: Missing reset support for brn51764
> > =C2=A0 FINISHME: Missing reset support for brn58839
> > =C2=A0 FINISHME: Missing support for brn62269
> > =C2=A0 FINISHME: Devices without tpu_border_colour_enhanced require
> > entries
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
compressed formats to be stored in the table
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pre-=
compressed.
> >=20
> > The vulkaninfo process then remained in uninterruptible sleep:
> >=20
> > =C2=A0 PID=C2=A0=C2=A0 STAT=C2=A0 WCHAN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 COMMAND
> > =C2=A0 3244=C2=A0 Dl+=C2=A0=C2=A0 synchronize_srcu=C2=A0 vulkaninfo --s=
ummary
> >=20
> > It could not be terminated normally while in that state, and a
> > reboot
> > was required.
> >=20
> > However, the clean-boot log shows that "GPU device lost" occurs
> > even
> > without starting vulkaninfo manually. The vulkaninfo hang may
> > therefore
> > be a consequence of the GPU already being in the lost state, rather
> > than
> > the original cause of the failure.
> >=20
> > At this point, the following parts appear to work:
> >=20
> > =C2=A0 - MT8173 GPU device-tree node probing
> > =C2=A0 - MFGTOP clock registration
> > =C2=A0 - PowerVR kernel module probing
> > =C2=A0 - Firmware loading
> > =C2=A0 - Firmware version reporting
> > =C2=A0 - DRM device initialization
> > =C2=A0 - Creation of card1 and renderD128
> >=20
> > The remaining problem is that the GPU becomes lost approximately
> > six
> > seconds after initialization.
> >=20
> > Could this be related to an interrupt not being delivered, firmware
> > heartbeat handling, reset sequencing, runtime PM, a missing
> > regulator
> > consumer relationship, or another MT8173-specific power-domain
> > requirement?
> >=20
> > Please let me know which additional kernel debug options, DRM debug
> > settings, tracepoints, interrupt statistics, register dumps, or
> > test
> > patches would be useful. I have physical access to the device and
> > can
> > build and test further kernel changes.
> >=20
> > Thank you for working on MT8173 support.
> >=20
> > Best regards,
> > YoungJoon Lee
> >=20
> > 2026=E5=B9=B47=E6=9C=8827=E6=97=A5(=E6=9C=88) 18:16 Chen-Yu Tsai <wenst=
@chromium.org>:
> > >=20
> > > Hi everyone,
> > >=20
> > > This is v3 of my MT8173 PowerVR GPU support series.
> > >=20
> > > I got another inquiry on the status of this patch series, so I
> > > thought
> > > I'd dig it out, fix all the issues and send another version.
> > >=20
> > > This time around Mesa was ready for basic testing, using both
> > > vulkanmark
> > > and glmark2-es2-drm (with Zink). Details below.
> > >=20
> > > Changes since v2 (all in the clk driver patch):
> > > - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> > > =C2=A0 - Needed since the driver implements PM domains using the
> > > generic PM
> > > =C2=A0=C2=A0=C2=A0 domain library, which also depends on PM
> > > =C2=A0 - Fixes build breakage (kernel test robot)
> > > - Fixed "RST_DELAY_CNT" name (Brian)
> > > - Dropped unused mfg_desc (Brian)
> > > - Added check of clk_prepare_enable()'s return value in
> > > =C2=A0 clk_mt8173_mfgtop_power_on() (Brian)
> > > - Saved error value for return in IS_ERR(data->clk_26m) branch
> > > =C2=A0 (Dan Carpenter / kernel test robot w/ smatch)
> > >=20
> > > Changes since v1:
> > > - Adapted to changed DT bindings
> > > - Dropped driver change
> > > - Use same power domain for "a" and "b" GPU power domains
> > >=20
> > >=20
> > > This series enables the PowerVR GPU found in the MT8173 SoC,
> > > found in
> > > some Chromebooks.
> > >=20
> > > This version is different from the initial powervr driver
> > > submission [1]
> > > in that it splits out the GPU glue layer support out of the
> > > powervr
> > > driver and into a separate clock and power domain driver. The
> > > glue code
> > > is otherwise the same, and also the same as found in the ChromeOS
> > > kernels, with some extra comments and macro names added where
> > > possible.
> > >=20
> > > Patch 1 adds a binding for the glue layer, called mfgtop. The
> > > glue layer
> > > contains clock and power controls for the GPU.
> > >=20
> > > Patch 2 adds a driver for the glue layer, implemented as a clock
> > > driver
> > > that also provides power domains.
> > >=20
> > > Patch 3 adds an entry for the MT8173 GPU and 6XT series to the
> > > PowerVR
> > > binding.
> > >=20
> > > Patch 4 corrects the clock for the GPU (called MFG) power domain.
> > >=20
> > > Patch 5 adds device nodes for the GPU and glue layer to the
> > > MT8173 dtsi
> > > file.
> > >=20
> > > The kernel driver successfully probes the hardware and loads the
> > > "rogue_4.40.2.51_v1.fw" firmware provided by Imagination
> > > Technologies [2].
> > > The "exp_hw_support" module parameter needs to be set for the
> > > driver to
> > > probe successfully.
> > >=20
> > > This was tested with Mesa 26.1.5 from Debian Forky. With this
> > > version
> > > vkmark and glmark2-es2 (over Zink) both run fine. Mesa spits out
> > > a bunch
> > > of warnings since the GX6250 core is not officially supported.
> > >=20
> > > =C2=A0=C2=A0=C2=A0 # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vkmark
> > > =C2=A0=C2=A0=C2=A0 WARNING: powervr is not a conformant Vulkan implem=
entation,
> > > testing use only.
> > > =C2=A0=C2=A0=C2=A0 WARNING: powervr is not a conformant Vulkan implem=
entation,
> > > testing use only.
> > > =C2=A0=C2=A0=C2=A0 MESA: warning:
> > > ../src/imagination/vulkan/pvr_arch_job_context.c:73: FINISHME:
> > > Missing reset support for brn51764
> > > =C2=A0=C2=A0=C2=A0 MESA: warning:
> > > ../src/imagination/vulkan/pvr_arch_job_context.c:76: FINISHME:
> > > Missing reset support for brn58839
> > > =C2=A0=C2=A0=C2=A0 MESA: warning:
> > > ../src/imagination/vulkan/pvr_arch_job_context.c:523: FINISHME:
> > > Missing support for brn62269
> > > =C2=A0=C2=A0=C2=A0 MESA: warning:
> > > ../src/imagination/vulkan/pvr_arch_border.c:244: FINISHME:
> > > Devices without tpu_border_colour_enhanced require entries for
> > > compressed formats to be stored in the table pre-compressed.
> > > =C2=A0=C2=A0=C2=A0 WARNING: powervr is not a conformant Vulkan implem=
entation,
> > > testing use only.
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vkmark 2025.01
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Vendor ID:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x1010
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device ID:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x6250
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device Name:=C2=A0=C2=A0=
=C2=A0 PowerVR Rogue GX6250
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Driver Version: 109056005
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device UUID:=C2=A0=C2=A0=
=C2=A0 d04cd6f3a25fd4900f89c151bccfdfcf
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0 [vertex] device-local=3Dtrue: FPS: 251 FrameTime: =
3.984 ms
> > > =C2=A0=C2=A0=C2=A0 [vertex] device-local=3Dfalse: FPS: 220 FrameTime:=
 4.545 ms
> > > =C2=A0=C2=A0=C2=A0 [texture] anisotropy=3D0:^C FPS: 223 FrameTime: 4.=
484 ms
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 vkmark Score: 231
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > =C2=A0=C2=A0=C2=A0 # PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 glmark2-es=
2-drm
> > > =C2=A0=C2=A0=C2=A0 WARNING: powervr is not a conformant Vulkan implem=
entation,
> > > testing use only.
> > > =C2=A0=C2=A0=C2=A0 MESA: warning:
> > > ../src/imagination/vulkan/pvr_arch_job_context.c:73: FINISHME:
> > > Missing reset support for brn51764
> > > =C2=A0=C2=A0=C2=A0 MESA: warning:
> > > ../src/imagination/vulkan/pvr_arch_job_context.c:76: FINISHME:
> > > Missing reset support for brn58839
> > > =C2=A0=C2=A0=C2=A0 MESA: warning:
> > > ../src/imagination/vulkan/pvr_arch_job_context.c:523: FINISHME:
> > > Missing support for brn62269
> > > =C2=A0=C2=A0=C2=A0 MESA: warning:
> > > ../src/imagination/vulkan/pvr_arch_border.c:244: FINISHME:
> > > Devices without tpu_border_colour_enhanced require entries for
> > > compressed formats to be stored in the table pre-compressed.
> > > =C2=A0=C2=A0=C2=A0 Warning: DRM_CAP_ASYNC_PAGE_FLIP not supported, fa=
lling back
> > > to 'mailbox' mode for SwapInterval(0).
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 glmark2 2023.01
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OpenGL Information
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GL_VENDOR:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Mesa
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GL_RENDERER:=C2=A0=C2=A0=
=C2=A0 zink Vulkan 1.2(PowerVR Rogue GX6250
> > > (IMAGINATION_OPEN_SOURCE_MESA))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GL_VERSION:=C2=A0=C2=A0=C2=
=A0=C2=A0 OpenGL ES 2.0 Mesa 26.1.5-1
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Surface Config: buf=3D32 r=
=3D8 g=3D8 b=3D8 a=3D8 depth=3D24 stencil=3D0
> > > samples=3D0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Surface Size:=C2=A0=C2=A0 =
1366x768 fullscreen
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0 [build] use-vbo=3Dfalse: FPS: 49 FrameTime: 20.473=
 ms
> > > =C2=A0=C2=A0=C2=A0 [build] use-vbo=3Dtrue: FPS: 45 FrameTime: 22.660 =
ms
> > > =C2=A0=C2=A0=C2=A0 [texture] texture-filter=3Dnearest: FPS: 45 FrameT=
ime: 22.642
> > > ms
> > > =C2=A0=C2=A0=C2=A0 [texture] texture-filter=3Dlinear:^C FPS: 50 Frame=
Time: 20.172
> > > ms
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 glmark2 Score: 46
> > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > >=20
> > > Please have a look.
> > >=20
> > > Thanks
> > > ChenYu
> > >=20
> > > [1]
> > > https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.walke=
r@imgtec.com/
> > > [2]
> > > https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powe=
rvr
> > >=20
> > > Chen-Yu Tsai (5):
> > > =C2=A0 dt-bindings: clock: mediatek: Add mt8173 mfgtop
> > > =C2=A0 clk: mediatek: Add mt8173-mfgtop driver
> > > =C2=A0 dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
> > > =C2=A0 arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
> > > =C2=A0 arm64: dts: mediatek: mt8173: Add GPU device nodes
> > >=20
> > > =C2=A0.../clock/mediatek,mt8173-mfgtop.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 70 +++++
> > > =C2=A0.../bindings/gpu/img,powervr-rogue.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0arch/arm64/boot/dts/mediatek/mt8173.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 33 ++-
> > > =C2=A0drivers/clk/mediatek/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 10 +
> > > =C2=A0drivers/clk/mediatek/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> > > =C2=A0drivers/clk/mediatek/clk-mt8173-mfgtop.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 241
> > > ++++++++++++++++++
> > > =C2=A0include/dt-bindings/clock/mt8173-clk.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> > > =C2=A07 files changed, 362 insertions(+), 1 deletion(-)
> > > =C2=A0create mode 100644
> > > Documentation/devicetree/bindings/clock/mediatek,mt8173-
> > > mfgtop.yaml
> > > =C2=A0create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c
> > >=20
> > > --
> > > 2.55.0.229.g6434b31f56-goog
> > >=20
