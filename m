Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E96C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD4010E63B;
	Wed, 29 Jul 2026 03:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i+0gdeR7";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD94910E642
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:32:28 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-6626b5ace23so2572065d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 20:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785295947; cv=none;
 d=google.com; s=arc-20260327;
 b=HPlT13nc5a92wWeu3zbNuChYpgDr3DQIjhTX1ydDA3xC6JPk1GB5/CPLYjVQ28+U/L
 wDj7rFrOpsqfuLWUPpzYy4OcIQcMZCJxHWxr7oWn7xelWgFT9g5o+zpUqkCnh7+06qvK
 wvsDeyYGMvMEcEMQA28NTOZ0jrtpyHA/y8oJzDx5xZlQEFRXfemikr370dXajtN++SSZ
 FqcwmXece97NAeEe8qBHG16LqJ2yR5jQXLejZVpMn+XqCkckuQvgDdoKUflU57Zr9hvJ
 C3I/epsoN0UXRb7nOBT3MWQn1IUJaDqb2l+cJ1aAM7uDg1JpLI94T8yiS5S+1gAdIzU/
 z3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YphEsPuwfO2GAZ8oScDaP5O5VSQEM8qtQtqlvFzmOwc=;
 fh=KLOlEJRlYF2z7gOwCXdm6kv/y1uhdD+mv3B4Mxv4udQ=;
 b=PO/vkBS/9s6HRkQIN/d4NI9u48ddCxhfenkyvJWE+jCxiIImXyvn8i5QaRApLoBV1w
 7TsSIgmiB3KvIlEJe3V1i4rMbtSiTlsKyKRF1C3qCeq2M4bdfpyPzmUezDH+WBhwaBLR
 xf4HmG4Ag830Ey4R0Qabg9DPrqm0lpXJrzNGKuNlfhZ0gtPKqTVpuHMTdKdKbWJsI9s0
 4iNM4/IhgkA5KJKH2pQtg5AeQeAXIe1FS+oOWrOggxMBTIGikjpHa13UmG002W+4Ms/A
 oHiQuk6f/BMlvWcu8hyeQlXdcJu5oHQKCTo664Zz3xguU2AsRCCl40tM3U/qIQtOcT8x
 7CjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785295947; x=1785900747;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YphEsPuwfO2GAZ8oScDaP5O5VSQEM8qtQtqlvFzmOwc=;
 b=i+0gdeR7L+kDKjD7pZGUm5QFnQYdIBHC2RrmGvyD0z4jWsUvR1w12XTrnCXwwsT6Dk
 7tni2+PIM+paKCM0GHr4AHpru7dY/bhEnsiCBBUsIHWLEkGtvau9FcSaDEtm1yCa/QCi
 MBe2ic16w0R7Mt5WU6NIZEzO6hXnZ9ltjjvXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785295947; x=1785900747;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YphEsPuwfO2GAZ8oScDaP5O5VSQEM8qtQtqlvFzmOwc=;
 b=Ns0NI2bVfBDJgAD+m4VNrYPZlULaVBMX5hPAkYMutYpuGTeE4ykyDkBVgNQGi3F+0B
 krIdXRMU5LtCqjnepItLNGsqD9fv+3ezb46z0P1dzxYEBQtnb88iFft/r9T614NahxJ4
 ttyG69v6LCRKPJm2GMT/6D119WcVz6d3lnxbFvowl4J21wWXEcn5eIXYgKMJ9SDUFMiB
 GfqaYYVSObzxeNRSSXV/oa5rWbL0q/yRHC4Gzkzo5iVsjgpD+FejezYwsJs97xxBbZyq
 gpUZh/Oks6B93qC0QenBSa3RXDbDH8HA5Y5e4l66RbPfLsSSAzkKYcP+gHJEpJ9ZS4HP
 Oo9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoP5BdOXVpXefUxxUznddfaDv1LMtTK5qw5e5dxS4Ntu63rzqkXPxLujn/tuvW7Wx9RoUho0kYzSBg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHuu/Ah0lq1YboFb4I/GnkeLYzfasOisEDEWiNCuIGYQsY3IvO
 4Y0axVLNrzL/CNPx00x1IiAomrkhLQqgxi6blzLti0MUmOtEm1hfiPY/4bds+5JahgRyAiUYumG
 mkcyR/5MYwyCiU7VO3amPbnwNIvGKh5LZmaUzj2EG
X-Gm-Gg: AR+sD12F288GgFIpN/X3W3qL6jxWwx9zKHhTkyri20Z6JYV1vwBOltfE9iw+LXou9+w
 MBhd5mlTuIhpntxTorgP74Pv4joURGxvDLUEPm2QV5Kjm3+JbN5EFbGeEF6a5acZho0RUQY28L4
 iKG1vLD/XW2fCrEg333TW1IxFoCTekLAeHc5BK3ejnKGoxYi6k4VRqsuqLzkcCm55/4bLlWTQ5z
 /B4n4kDhKzGfZ3FC4M+YedmsEFOdzlIZifBo7krdh4fkf4mHhslaUrL7rpJK4TWbbgX7x+Nc8aH
 e9Vk2tjTYsEkM5OF1s3xZF+cp8PWZPSr4YZDuUq3XtwodPdgxWNzIV0MmAXXHW/f9GqiEutHm0U
 =
X-Received: by 2002:a05:690c:250a:b0:81d:455b:5fdc with SMTP id
 00721157ae682-81fa7a235edmr3133467b3.28.1785295947414; Tue, 28 Jul 2026
 20:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
 <CAGb2v67VRhy_xzkdwUAYhzM_sWzoXyfZ3rYSHYLYaxuve9H17w@mail.gmail.com>
 <a0ae9525-9288-4d13-a080-9cb3d965d536@collabora.com>
 <CA+m4KrAvATV9qMMN9h+tKcPdrHRp7-jFJ0-Jq3DeCZLi3Z6RsA@mail.gmail.com>
In-Reply-To: <CA+m4KrAvATV9qMMN9h+tKcPdrHRp7-jFJ0-Jq3DeCZLi3Z6RsA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 29 Jul 2026 11:32:16 +0800
X-Gm-Features: AUfX_my7lXKe9Z2oOqmBCydrADFp6DxbpdPpz-KqJ25BL6ZYGxlwr20b-0pppV8
Message-ID: <CAGXv+5G8zPGb3SUwnzuutCF_U=+NKB4VQBsu+the6nLUqM-RDg@mail.gmail.com>
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

On Wed, Jul 29, 2026 at 8:08=E2=80=AFAM YoungJoon Lee <getfeus@gmail.com> w=
rote:
>
> Hi Chen-Yu,
>
> Thank you for posting the v4 series.
>
> I tested the complete v4 series on my MT8173 Chromebook, but I am
> seeing a GPU device loss as soon as Mesa initializes the Vulkan device.
>
> My current setup is:
>
>   Board: Google Elm / Acer Chromebook R13 (CB5-312T)
>   Kernel:
>     linux-next next-20260727
>     commit: 33d6e5134c70446eddafbb3fd5ad088e848a7ad6
>     (next-20260727-5-g33d6e5134c70)
>
>   Kernel release: 7.2.0-rc5-next-20260727-stb-cbm-next-pvr-v4+
>
>   Mesa: 26.1.5
>   vulkan-powervr: 26.1.5
>   Firmware:
>     rogue_4.40.2.51_v1.fw
>     SHA256:
>     f44b7056992fb4057c987dcd7073468bec628aa56cb9815b1162f1cb7c1d73f2

My firmware blob is different from yours:

powervr 13000000.gpu: [drm] loaded firmware powervr/rogue_4.40.2.51_v1.fw
powervr 13000000.gpu: [drm] FW version v1.0 (build 6503725 OS)

SHA256: 1456504351bd041f0bf96667403ad32460fc7b807c09858df1f083e207323e4a

Funny thing is neither of ours match the official firmware blobs released
by Imagination [1].

The latest version is "FW version v1.1 (build 6976702 OS)" with
SHA256: e6bf10aaf442798fd81df9b9122e7e85900aafe77fcbec34b426af435c2b1c44

This version also works for me.

The "initial version" is "FW version v1.0 (build 6734358 OS)" with
SHA256: baa227de4f297b7c0928c6535d15affd80aa9c5f528d2d5dc4b764ad050d22f2

And this version also works.

It seems your firmware build is even older than mine. I suggest you
update it and try again?

[1] https://gitlab.freedesktop.org/imagination/linux-firmware/-/blob/powerv=
r/powervr/rogue_4.40.2.51_v1.fw


> All five patches applied cleanly. The PowerVR driver probes, loads the
> firmware, and creates the DRM render node successfully.
>
> However, when I run the following from an SSH session without GDM or
> another graphical session running:
>
>   PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vulkaninfo --summary
>
> Mesa prints the expected GX6250 warnings:
>
>   Missing reset support for brn51764
>   Missing reset support for brn58839
>   Missing support for brn62269
>
> The command then hangs, and the kernel reports:
>
>   powervr 13000000.gpu: [drm] *ERROR* GPU device lost
>
> There are no additional timeout, MMU fault, firmware, clock, or runtime
> PM messages immediately before the device-lost message.
>
> I originally also observed the same failure when GDM started GNOME
> Shell, but reproducing it with vulkaninfo from a non-graphical SSH
> session indicates that this is not specific to Mutter or GNOME.
>
> Since your cover letter reports that vkmark and glmark2-es2-drm work
> with Mesa 26.1.5, I suspect that there may be a difference in the
> kernel configuration or another part of the test environment.
>
> Could you please share the following details from your working setup?
>
>   1. The exact Chromebook board/model used for testing

The codename is "telesu", which is basically a hana in a different case.

>   2. The exact kernel base commit

I have a whole bunch of patches on top of next-20260727, but none
that should affect this.

>   3. The kernel configuration, or at least the relevant DRM, PM,
>      generic power-domain, IOMMU, and MediaTek clock options

All relevant options are built-in.

>   4. Whether CONFIG_DRM_POWERVR was built-in or built as a module

Module.

>   5. The firmware SHA256

See above.

>   6. The kernel command line and bootloader used

Chromebook's builtin bootloader.

cmdline:

    cros_secure root=3DPARTUUID=3D824526A4-24EE-344D-85A2-20630C42D31A
    console=3Dtty0 console=3DttyS0,115200n8 earlycon ro text drm.debug=3D0x=
106
    panic=3D30 rootwait log_buf_len=3D1M no_console_suspend

AFAICT nothing special.

>   7. Whether `vulkaninfo --summary` also completes successfully
>
> My current relevant configuration includes:
>
> CONFIG_PM_SLEEP=3Dy
> CONFIG_PM=3Dy
> CONFIG_PM_GENERIC_DOMAINS=3Dy
> CONFIG_MODULES=3Dy
> CONFIG_DMA_SHARED_BUFFER=3Dy
> CONFIG_DRM_POWERVR=3Dm
> CONFIG_DRM_MEDIATEK=3Dy
> CONFIG_SYNC_FILE=3Dy
> CONFIG_COMMON_CLK_MT8173_MFGTOP=3Dy
> CONFIG_IOMMU_SUPPORT=3Dy
> CONFIG_ARM_SMMU=3Dy
> CONFIG_MTK_IOMMU=3Dy
>
> I would be happy to test additional patches or provide any further
> logs, kernel configuration, or debugging information if that would
> help.

As mentioned above, please try updating your firmware blob. Your
version is even older than mine, and neither of ours is the "official"
release.


Thanks
ChenYu


> Thanks,
> YoungJoon Lee
>
> 2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 0:28 AngeloGioacchino Del R=
egno
> <angelogioacchino.delregno@collabora.com>:
> >
> > On 7/28/26 16:44, Chen-Yu Tsai wrote:
> > > On Tue, Jul 28, 2026 at 10:33=E2=80=AFPM AngeloGioacchino Del Regno
> > > <angelogioacchino.delregno@collabora.com> wrote:
> > >>
> > >> On 7/28/26 15:13, Chen-Yu Tsai wrote:
> > >>> On Tue, Jul 28, 2026 at 9:10=E2=80=AFPM Brian Masney <bmasney@redha=
t.com> wrote:
> > >>>>
> > >>>> Hi Chen-Yu,
> > >>>>
> > >>>> On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> > >>>>> Hi everyone,
> > >>>>>
> > >>>>> This is v4 of my MT8173 PowerVR GPU support series.
> > >>>>>
> > >>>>> This time around Mesa was ready for basic testing, using both vul=
kanmark
> > >>>>> and glmark2-es2-drm (with Zink). Details below.
> > >>>>>
> > >>>>> Changes since v3 (all in the clk driver patch):
> > >>>>> - Changed pm_runtime_put() to pm_runtime_put_sync()
> > >>>>> - Added missing of_node_put() in remove function
> > >>>>>
> > >>>>> Changes since v2 (all in the clk driver patch):
> > >>>>> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> > >>>>>     - Needed since the driver implements PM domains using the gen=
eric PM
> > >>>>>       domain library, which also depends on PM
> > >>>>>     - Fixes build breakage (kernel test robot)
> > >>>>> - Fixed "RST_DELAY_CNT" name (Brian)
> > >>>>> - Dropped unused mfg_desc (Brian)
> > >>>>> - Added check of clk_prepare_enable()'s return value in
> > >>>>>     clk_mt8173_mfgtop_power_on() (Brian)
> > >>>>> - Saved error value for return in IS_ERR(data->clk_26m) branch
> > >>>>>     (Dan Carpenter / kernel test robot w/ smatch)
> > >>>>>
> > >>>>> Changes since v1:
> > >>>>> - Adapted to changed DT bindings
> > >>>>> - Dropped driver change
> > >>>>> - Use same power domain for "a" and "b" GPU power domains
> > >>>>>
> > >>>>>
> > >>>>> This series enables the PowerVR GPU found in the MT8173 SoC, foun=
d in
> > >>>>> some Chromebooks.
> > >>>>
> > >>>> I'm making a pull for Stephen for the clk changes. Should patches =
1,2,4
> > >>>> go through the clk tree? Patches 3,5 go through the DRM tree?
> > >>>
> > >>> Only patches 1 and 2 should go through the clock tree.
> > >>>
> > >>> Patch 3, 4, 5 can all go through the soc tree if Angelo wants to pi=
ck up
> > >>> DT binding patches. Otherwise I can push patch 3 through drm-misc.
> > >>>
> > >>
> > >> Not sure if I can really take the DRM bindings patch through soc.
> > >>
> > >> I will take the devicetree ones exactly right now, even though it's =
going to
> > >> give warnings.
> > >>
> > >> I trust that you'll make the binding get into linux-next before it's=
 too late.
> > >
> > > Rob beat me to it. :D
> >
> > Love it!
> >
> > Thanks Rob :-D
> >
> > Cheers,
> > Angelo
