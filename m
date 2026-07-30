Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39958C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1EF10EE36;
	Thu, 30 Jul 2026 08:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UTc1q0/2";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B2010EE36
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:37:24 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-81f36179d72so29028267b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785400643; cv=none;
 d=google.com; s=arc-20260327;
 b=OG43jGRJCMofF4SAI++57ce0Xo5904Dmktat6AkFSpKdtwaZ+wLFa5v6oOWIWCGlD9
 giyIJc0Bld85yiXSrGo6MWxVpsLCJ1gPdbMyUKiE7cLFKomHnXhFr7JOkAkwimdecY8T
 xs0/ilGM7M7qQMy1rE8jXgI6m3+pEUKcf9k8xrKnMhgK5Qbge58JmSXEfQr2xoN98KHC
 0TFA4UOqWjYhbis5DGd0jx8Vew1HJIfnSf/8V59H53I70K+z6skAWR88zHEZj93q+ZWB
 /gTvGAe/hP2r7NONJ0vXaSTJV3l5hYwly5WZae6i8R8A8NHU3jQbThMIdSGAQUmlilfP
 8/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W45gP6xH7PfQckM+Q3lwy6aIcxf+8fEMzg4xhSYRh+Q=;
 fh=Ch36rivnJv4rkqDp1yBu08bQJv+XbTkqVanE2+uFdJs=;
 b=PMmtSrzPjzzCSVkW7JH39cPaSZL4ytxOBPKi3yw+2Acc8Z0iNl/MzFPoSDoEKNwVxc
 Gh7t6UOkKnA73KkXxsrXNEiKC7jfBPXUoPauOlHiHngEzqyFwLtOfj7RlwwjxGHrTfHT
 UM/EjzenFs6DJfZKNCUcf/2mlLVLXyzWa4sfrQoCRECWPgzDxj0qIfjhANlC04olAdkZ
 ///9G4zLHczc8oqXnLfrw3PXWMBDMbJx07Tz5PrD3WCH2iWZVg9nD4lc2gNbzf32AdkA
 DqnB2fR/h7ba/puwgbMA2e9z3GmD/QabkYCC3OwmOI9ns4l183o/SoNYYk+NYyQbSXxz
 aM6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785400643; x=1786005443;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W45gP6xH7PfQckM+Q3lwy6aIcxf+8fEMzg4xhSYRh+Q=;
 b=UTc1q0/2gfvTqPZ82Z0xGz3YoGQvQRlOtK6gQhUlDlJM+LK1obSC/vU8I0R9OXOeL5
 OriSg4UX2PJRFTUUipaGVHEhGnUmfK2upg8ZihBaYbx3gcXdm7xv+AptzqADMF8JTbLD
 7Bd+rzMtodJEiAK5qcqoj4NInUfqWzEauTJ7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785400643; x=1786005443;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W45gP6xH7PfQckM+Q3lwy6aIcxf+8fEMzg4xhSYRh+Q=;
 b=hvf3An7CB5WIBGzD/hTDHdm82AGw/kwhpAzJORlehuAPk21Au2QJb4GDLjDsCtkIoG
 VC2whRGD1GW93odWpu6s8b7BFa6GF7aezDooicNjH47W/EYNqeLEio22QDYR+vSB6c6y
 itM/OdBlovc0RCBk+5VUaQ1XkhdTWnVnf5SUbXBitZ7RS9Bj845hKfWBeIcTXm6RWL6u
 idvtCiVk7mRTtJY8fne32D5RMW6rtxjhJeQGtEf8imuKC+p3+of+RMOaTPJA5whRMtiL
 SYbIgBFKYSBlgS6zHx1Sn3aG/1x7PMvr43j5ZSNkOV25wyGF34kaWgJAPCuHyKW/k/Fq
 dMeA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrM1J7MLAx9iqUG2eO/wwmCXIxn+CrSZd/4u9Oei5vFHhqrsz27H2uY58mBZciPw95vPq17oaZSpxY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQ3Le4iBvr8Yu4wHe1EcyhgZjtRuixW2ekmhCe9AuLqZee4/8i
 ny236UMYc1SjrnyxamEzuAKVYlYPrMo1IomZDa4gUD6U9XeBGuxnDNsOJKuLxw8WaJZ3+SEIZl6
 hOY1hUN3Sj6OCHc6fMJyf0D2TJ0mKmaZ/1lvsVCI6
X-Gm-Gg: AR+sD11vlz2fTbHud/rwSm70ycwUK9JN3trKy9yGlDokuu05ayyFc+cKAHc4IYG55k/
 I/5zI5GxSptj1IJWHUbIE2+FptM6k30h8llXvUmwQJgzoRIG/H8mCtbkLblHqPT2NQGlOzrLQuE
 Q2jb8helJnXgOwQauh6HFs3nHMt82N43hkiS2+rz8rbTZddCuWD41SHg+mcbaQoT5tZfrcubS+d
 Hd9hCbojS1zqewovsnzEYulK1y4BlTWRaRrW8L/FYNk3+dIEnXgSqW3xrVMTBUmdnZJ1P2f0W79
 N24nh2uR1MdDdZQL8PmJvN9aEPaKMQdJ+zRAlmwQsfOTT9p+tnv1CETl+8y+0/693ZwAPuPN5wg
 =
X-Received: by 2002:a05:690c:ecb:b0:814:608a:a2f7 with SMTP id
 00721157ae682-81fb89bd682mr11853577b3.25.1785400643037; Thu, 30 Jul 2026
 01:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
 <CAGb2v67VRhy_xzkdwUAYhzM_sWzoXyfZ3rYSHYLYaxuve9H17w@mail.gmail.com>
 <a0ae9525-9288-4d13-a080-9cb3d965d536@collabora.com>
 <CA+m4KrAvATV9qMMN9h+tKcPdrHRp7-jFJ0-Jq3DeCZLi3Z6RsA@mail.gmail.com>
 <CAGXv+5G8zPGb3SUwnzuutCF_U=+NKB4VQBsu+the6nLUqM-RDg@mail.gmail.com>
 <CA+m4KrDQ0tf0ffx9ttARBF-5sDZUz5bF0Apu3-M=wr=psYLogg@mail.gmail.com>
 <CA+m4KrCZdQb7=+7wJDH0H8KZgDzWkB1CtB2jEbEnRUxu9OJybA@mail.gmail.com>
In-Reply-To: <CA+m4KrCZdQb7=+7wJDH0H8KZgDzWkB1CtB2jEbEnRUxu9OJybA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 30 Jul 2026 16:37:12 +0800
X-Gm-Features: AUfX_mz9ndgpKU1aVx4ZJqOpOdAsme5iiSGANxBR0WVL0ps6zyho2cMcn1ou8yE
Message-ID: <CAGXv+5HcwgmEEmhtTU5TpexxRVwDXC-ggdtOViLdmThT7FjB+g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
To: YoungJoon Lee <getfeus@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 wens@kernel.org, 
 Brian Masney <bmasney@redhat.com>, Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 29, 2026 at 5:35=E2=80=AFPM YoungJoon Lee <getfeus@gmail.com> w=
rote:
>
> Hi Chen-Yu,
>
> A follow-up to my previous email.
>
> The official v1.1 firmware did fix the original "GPU device lost"
> problem.
>
> The following now works correctly:
>
>     PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vulkaninfo --summary
>
> The driver initializes successfully and detects the PowerVR Rogue
> GX6250.
>
> However, while testing actual rendering, I found another issue which
> appears to be unrelated to the firmware.
>
> Kernel:
>
>     Linux 7.2.0-rc5-next-20260727-stb-cbm-next-pvr-v4+
>
> Board:
>
>     Google Elm (Acer Chromebook R13 / MT8173)
>
> Mesa:
>
>     mesa 26.1.5
>     vulkan-powervr 26.1.5
>
> Firmware:
>
>     rogue_4.40.2.51_v1.fw
>     FW version v1.1 (build 6976702 OS)
>
> Kernel command line:
>
>     powervr.exp_hw_support=3D1
>
> Test command:
>
>     PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 glmark2-es2-drm
>
> Renderer:
>
>     GL_RENDERER:
>     zink Vulkan 1.2
>     (PowerVR Rogue GX6250)
>
> The benchmark progresses normally:
>
>     build (VBO off)          212 FPS
>     build (VBO on)           216 FPS
>     texture nearest          174 FPS
>     texture linear           173 FPS
>     texture mipmap           174 FPS
>     shading gouraud          165 FPS
>     shading blinn-phong      135 FPS
>     shading phong             99 FPS
>
> It consistently hangs at:
>
>     shading=3Dcel
>
> Immediately afterwards the kernel reports:
>
>     refcount_t: underflow; use-after-free
>
> The first warning is:
>
>     pvr_free_list_put()
>       -> pvr_hwrt_dataset_release()
>       -> pvr_hwrt_dataset_put()
>       -> pvr_ioctl_destroy_hwrt_dataset()
>
> followed by:
>
>     refcount_warn_saturate()
>
> Shortly afterwards another kernel Oops occurs:
>
>     Unable to handle kernel NULL pointer dereference
>
> The second backtrace shows:
>
>     pvr_gem_object_create()
>       -> pvr_fw_object_create()
>       -> pvr_hwrt_dataset_create()
>       -> pvr_ioctl_create_hwrt_dataset()
>
> The glmark2 process remains as:
>
>     glmark2-es2-drm <defunct>

I think this is more related to the unsupported nature of the GX6250,
and not specific to MT8173. Maybe someone else on the Imagination or
DRM mailing lists has a better idea of what's going on.


ChenYu

> The system is otherwise still reachable through SSH.
>
> I collected additional diagnostics, including:
>
>     - complete dmesg
>     - complete kernel journal
>     - kernel configuration
>     - PowerVR module information
>     - userspace package versions
>     - process/thread state
>     - runtime PM state
>     - running Device Tree
>
> I can send any of these if they would help.
>
> Also, please disregard my previous Tested-by tag for now, since this
> rendering issue was discovered afterwards.
>
> Thank you again for your help.
>
> Best regards,
>
> YoungJoon Lee
>
> 2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 13:38 YoungJoon Lee <getfeu=
s@gmail.com>:
> >
> > Hi Chen-Yu,
> >
> > Thank you. Updating the firmware fixed the issue.
> >
> > I replaced my previous firmware blob with the official v1.1 firmware:
> >
> >   FW version v1.1 (build 6976702 OS)
> >
> >   SHA256:
> >   e6bf10aaf442798fd81df9b9122e7e85900aafe77fcbec34b426af435c2b1c44
> >
> > After rebooting, the driver loaded the new firmware successfully:
> >
> >   powervr 13000000.gpu: [drm] loaded firmware
> >   powervr/rogue_4.40.2.51_v1.fw
> >   powervr 13000000.gpu: [drm] FW version v1.1
> >   (build 6976702 OS)
> >
> > I then ran:
> >
> >   PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vulkaninfo --summary
> >
> > This now completes successfully and detects the PowerVR Rogue GX6250.
> > The previous "GPU device lost" error no longer occurs.
> >
> > So the issue was caused by the older, non-official firmware blob I was
> > using, rather than the v4 kernel series or my kernel configuration.
> >
> > Thank you for pointing this out, and sorry for the noise.
> >
> > Tested-by: YoungJoon Lee <getfeus@gmail.com>
> >
> > Best regards,
> > YoungJoon
> >
> > 2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 12:32 Chen-Yu Tsai <wenst=
@chromium.org>:
> > >
> > > On Wed, Jul 29, 2026 at 8:08=E2=80=AFAM YoungJoon Lee <getfeus@gmail.=
com> wrote:
> > > >
> > > > Hi Chen-Yu,
> > > >
> > > > Thank you for posting the v4 series.
> > > >
> > > > I tested the complete v4 series on my MT8173 Chromebook, but I am
> > > > seeing a GPU device loss as soon as Mesa initializes the Vulkan dev=
ice.
> > > >
> > > > My current setup is:
> > > >
> > > >   Board: Google Elm / Acer Chromebook R13 (CB5-312T)
> > > >   Kernel:
> > > >     linux-next next-20260727
> > > >     commit: 33d6e5134c70446eddafbb3fd5ad088e848a7ad6
> > > >     (next-20260727-5-g33d6e5134c70)
> > > >
> > > >   Kernel release: 7.2.0-rc5-next-20260727-stb-cbm-next-pvr-v4+
> > > >
> > > >   Mesa: 26.1.5
> > > >   vulkan-powervr: 26.1.5
> > > >   Firmware:
> > > >     rogue_4.40.2.51_v1.fw
> > > >     SHA256:
> > > >     f44b7056992fb4057c987dcd7073468bec628aa56cb9815b1162f1cb7c1d73f=
2
> > >
> > > My firmware blob is different from yours:
> > >
> > > powervr 13000000.gpu: [drm] loaded firmware powervr/rogue_4.40.2.51_v=
1.fw
> > > powervr 13000000.gpu: [drm] FW version v1.0 (build 6503725 OS)
> > >
> > > SHA256: 1456504351bd041f0bf96667403ad32460fc7b807c09858df1f083e207323=
e4a
> > >
> > > Funny thing is neither of ours match the official firmware blobs rele=
ased
> > > by Imagination [1].
> > >
> > > The latest version is "FW version v1.1 (build 6976702 OS)" with
> > > SHA256: e6bf10aaf442798fd81df9b9122e7e85900aafe77fcbec34b426af435c2b1=
c44
> > >
> > > This version also works for me.
> > >
> > > The "initial version" is "FW version v1.0 (build 6734358 OS)" with
> > > SHA256: baa227de4f297b7c0928c6535d15affd80aa9c5f528d2d5dc4b764ad050d2=
2f2
> > >
> > > And this version also works.
> > >
> > > It seems your firmware build is even older than mine. I suggest you
> > > update it and try again?
> > >
> > > [1] https://gitlab.freedesktop.org/imagination/linux-firmware/-/blob/=
powervr/powervr/rogue_4.40.2.51_v1.fw
> > >
> > >
> > > > All five patches applied cleanly. The PowerVR driver probes, loads =
the
> > > > firmware, and creates the DRM render node successfully.
> > > >
> > > > However, when I run the following from an SSH session without GDM o=
r
> > > > another graphical session running:
> > > >
> > > >   PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vulkaninfo --summary
> > > >
> > > > Mesa prints the expected GX6250 warnings:
> > > >
> > > >   Missing reset support for brn51764
> > > >   Missing reset support for brn58839
> > > >   Missing support for brn62269
> > > >
> > > > The command then hangs, and the kernel reports:
> > > >
> > > >   powervr 13000000.gpu: [drm] *ERROR* GPU device lost
> > > >
> > > > There are no additional timeout, MMU fault, firmware, clock, or run=
time
> > > > PM messages immediately before the device-lost message.
> > > >
> > > > I originally also observed the same failure when GDM started GNOME
> > > > Shell, but reproducing it with vulkaninfo from a non-graphical SSH
> > > > session indicates that this is not specific to Mutter or GNOME.
> > > >
> > > > Since your cover letter reports that vkmark and glmark2-es2-drm wor=
k
> > > > with Mesa 26.1.5, I suspect that there may be a difference in the
> > > > kernel configuration or another part of the test environment.
> > > >
> > > > Could you please share the following details from your working setu=
p?
> > > >
> > > >   1. The exact Chromebook board/model used for testing
> > >
> > > The codename is "telesu", which is basically a hana in a different ca=
se.
> > >
> > > >   2. The exact kernel base commit
> > >
> > > I have a whole bunch of patches on top of next-20260727, but none
> > > that should affect this.
> > >
> > > >   3. The kernel configuration, or at least the relevant DRM, PM,
> > > >      generic power-domain, IOMMU, and MediaTek clock options
> > >
> > > All relevant options are built-in.
> > >
> > > >   4. Whether CONFIG_DRM_POWERVR was built-in or built as a module
> > >
> > > Module.
> > >
> > > >   5. The firmware SHA256
> > >
> > > See above.
> > >
> > > >   6. The kernel command line and bootloader used
> > >
> > > Chromebook's builtin bootloader.
> > >
> > > cmdline:
> > >
> > >     cros_secure root=3DPARTUUID=3D824526A4-24EE-344D-85A2-20630C42D31=
A
> > >     console=3Dtty0 console=3DttyS0,115200n8 earlycon ro text drm.debu=
g=3D0x106
> > >     panic=3D30 rootwait log_buf_len=3D1M no_console_suspend
> > >
> > > AFAICT nothing special.
> > >
> > > >   7. Whether `vulkaninfo --summary` also completes successfully
> > > >
> > > > My current relevant configuration includes:
> > > >
> > > > CONFIG_PM_SLEEP=3Dy
> > > > CONFIG_PM=3Dy
> > > > CONFIG_PM_GENERIC_DOMAINS=3Dy
> > > > CONFIG_MODULES=3Dy
> > > > CONFIG_DMA_SHARED_BUFFER=3Dy
> > > > CONFIG_DRM_POWERVR=3Dm
> > > > CONFIG_DRM_MEDIATEK=3Dy
> > > > CONFIG_SYNC_FILE=3Dy
> > > > CONFIG_COMMON_CLK_MT8173_MFGTOP=3Dy
> > > > CONFIG_IOMMU_SUPPORT=3Dy
> > > > CONFIG_ARM_SMMU=3Dy
> > > > CONFIG_MTK_IOMMU=3Dy
> > > >
> > > > I would be happy to test additional patches or provide any further
> > > > logs, kernel configuration, or debugging information if that would
> > > > help.
> > >
> > > As mentioned above, please try updating your firmware blob. Your
> > > version is even older than mine, and neither of ours is the "official=
"
> > > release.
> > >
> > >
> > > Thanks
> > > ChenYu
> > >
> > >
> > > > Thanks,
> > > > YoungJoon Lee
> > > >
> > > > 2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 0:28 AngeloGioacchino=
 Del Regno
> > > > <angelogioacchino.delregno@collabora.com>:
> > > > >
> > > > > On 7/28/26 16:44, Chen-Yu Tsai wrote:
> > > > > > On Tue, Jul 28, 2026 at 10:33=E2=80=AFPM AngeloGioacchino Del R=
egno
> > > > > > <angelogioacchino.delregno@collabora.com> wrote:
> > > > > >>
> > > > > >> On 7/28/26 15:13, Chen-Yu Tsai wrote:
> > > > > >>> On Tue, Jul 28, 2026 at 9:10=E2=80=AFPM Brian Masney <bmasney=
@redhat.com> wrote:
> > > > > >>>>
> > > > > >>>> Hi Chen-Yu,
> > > > > >>>>
> > > > > >>>> On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote=
:
> > > > > >>>>> Hi everyone,
> > > > > >>>>>
> > > > > >>>>> This is v4 of my MT8173 PowerVR GPU support series.
> > > > > >>>>>
> > > > > >>>>> This time around Mesa was ready for basic testing, using bo=
th vulkanmark
> > > > > >>>>> and glmark2-es2-drm (with Zink). Details below.
> > > > > >>>>>
> > > > > >>>>> Changes since v3 (all in the clk driver patch):
> > > > > >>>>> - Changed pm_runtime_put() to pm_runtime_put_sync()
> > > > > >>>>> - Added missing of_node_put() in remove function
> > > > > >>>>>
> > > > > >>>>> Changes since v2 (all in the clk driver patch):
> > > > > >>>>> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> > > > > >>>>>     - Needed since the driver implements PM domains using t=
he generic PM
> > > > > >>>>>       domain library, which also depends on PM
> > > > > >>>>>     - Fixes build breakage (kernel test robot)
> > > > > >>>>> - Fixed "RST_DELAY_CNT" name (Brian)
> > > > > >>>>> - Dropped unused mfg_desc (Brian)
> > > > > >>>>> - Added check of clk_prepare_enable()'s return value in
> > > > > >>>>>     clk_mt8173_mfgtop_power_on() (Brian)
> > > > > >>>>> - Saved error value for return in IS_ERR(data->clk_26m) bra=
nch
> > > > > >>>>>     (Dan Carpenter / kernel test robot w/ smatch)
> > > > > >>>>>
> > > > > >>>>> Changes since v1:
> > > > > >>>>> - Adapted to changed DT bindings
> > > > > >>>>> - Dropped driver change
> > > > > >>>>> - Use same power domain for "a" and "b" GPU power domains
> > > > > >>>>>
> > > > > >>>>>
> > > > > >>>>> This series enables the PowerVR GPU found in the MT8173 SoC=
, found in
> > > > > >>>>> some Chromebooks.
> > > > > >>>>
> > > > > >>>> I'm making a pull for Stephen for the clk changes. Should pa=
tches 1,2,4
> > > > > >>>> go through the clk tree? Patches 3,5 go through the DRM tree=
?
> > > > > >>>
> > > > > >>> Only patches 1 and 2 should go through the clock tree.
> > > > > >>>
> > > > > >>> Patch 3, 4, 5 can all go through the soc tree if Angelo wants=
 to pick up
> > > > > >>> DT binding patches. Otherwise I can push patch 3 through drm-=
misc.
> > > > > >>>
> > > > > >>
> > > > > >> Not sure if I can really take the DRM bindings patch through s=
oc.
> > > > > >>
> > > > > >> I will take the devicetree ones exactly right now, even though=
 it's going to
> > > > > >> give warnings.
> > > > > >>
> > > > > >> I trust that you'll make the binding get into linux-next befor=
e it's too late.
> > > > > >
> > > > > > Rob beat me to it. :D
> > > > >
> > > > > Love it!
> > > > >
> > > > > Thanks Rob :-D
> > > > >
> > > > > Cheers,
> > > > > Angelo
