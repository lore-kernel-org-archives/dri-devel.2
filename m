Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7819C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E2810EC08;
	Wed, 29 Jul 2026 13:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UVsR1any";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A0310E5C1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 00:08:53 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4a483a552efso154253b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 17:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785283733; cv=none;
 d=google.com; s=arc-20260327;
 b=nnx8rQMKCMkSbUrUHuxHkbL7dHNhuqPHStQMg2tb4yLYMi8Y5ZwQBDfREI5rTdzUHO
 QK/kSfMYyvaXwCy6nE23DEWY8X707qxJfRoCE1p2CiYbR0SnLPj0yncDapc6YCdNjeaF
 UHPyV6hyAgH818yFxcBZJveOIRv5DqhDKZAdv5batFe8WdqDFqBcS9dXl0hGTqQrGNeY
 Zqh/tl85FYkbh5mFkB6xAOjS/uOTiqYPHk9BxvWKJf/a7uRZ6T9xfQ1kLVT3LAgRlkia
 nYw4gNEgSXDeGqUBCpLn8EcA9PTQ9MLODRkApBledYgG3wnMeZdL9aknUJN5QB7oZQLj
 D+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kyoFypV4ziVMyYM4rNHMecvIB5wpcxkRGbJyRri9dnY=;
 fh=2GSsj6U+YlAxKattHGJucl6BDfOlKX/jgHZCzdjooMU=;
 b=mK5kY3sD9GOKwRMoN/d2pXrae4a0mz8N43KhrDMy2Lgcq9Rh9ydMosso5XHlRI/VfT
 xXIQhVvXgJuJpzp8PeohFFtmovdY/F6Fet6lMUyAkcpEdJ9C2uWR7TlkadA1UAtJxKjt
 25+PmXTP8RnYUKbYgMd0ywPGZPi2KFBLpGcVSIz4usA3YlYAYVwyMVsuNq76/71h09+m
 zqxwZjjBgI3E+h5zsxwxZ8RDcftGB1J7RDdKKOIfqvDPzLBlj19awIrZaA5D/+AjDMPL
 rbu5FsAWZYpqZ5CuFdTVQrmz6GxwezhYhUle3tTZ/AzeC2Tlv7TWd07hPY/FDgQGMwgi
 K8xA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785283733; x=1785888533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kyoFypV4ziVMyYM4rNHMecvIB5wpcxkRGbJyRri9dnY=;
 b=UVsR1any3H9cEgq7QuPZg5ik+sXGfJ0+dBiGqTT/CN/K4umsoVrmvgWAXl1TzMFT8z
 sQ3NyVQOIiFl3oQDGAzUVfym9No4/nAXV20bIKzoNj/UGz48rMU5bcxubnQPu9JuQNhd
 V5XUynaa9NGl9WLZK/nwypt1wVO3zoNtf/NoY54x8pJyTB/0UwRSdSgqLYc1gudDQ9L9
 tm2irhZR/vT0OzwcO5MW9aLJ9eF0Cq11tpxlNewzOxZbR87HHGA3ChMSwdMGesddLL94
 S+vdgW9gwUffeOlE9WpDfuBtrBrUzUpStakfhN0CbBqU/El6B6YvYxWdEVI1HZuIbVfK
 2aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785283733; x=1785888533;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kyoFypV4ziVMyYM4rNHMecvIB5wpcxkRGbJyRri9dnY=;
 b=DytEtr/HBq93HhZhRv7pAot4SnECrW++dqQkwpG2zaUwFoQWa9eh1hNfPLHXaJ8jf1
 9QW1Gc1LaMHpnBwb4FAMZYGTjPIONLIfkw4flJ8iqYdEDB7mrIDxfR/sH7uJNhkrpmX7
 ZI15iz94ZTLXQiDKpse+94nMrHEce69Dja4iC1s+4++5KJKXH+DLnWkj7S/H6EhVVSGe
 mNgQH/UQwLc6rihZkorv46OyWoeDEgPqk2dWS516KFkI4aOKberFZnc322or9AKJog+s
 67tJZKzmbNbbJP9SKw30EkHOQiaFJv0LD1N9n3o4SdlpLVachmu4cuRFDwq82eFZVidU
 2Xtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPpQ0X/LBCRXA+UDNOF27f25EIZJCuBDPEkZIiuqvsC+UQCLJpLiBZn8PrgnOxKkQSra86lV38wj4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2Z+zCABNVURvpOQOnQipEMsxo1hvIe1IHSeg/JPHKGmtoEMVe
 VFUKsyssRgEtdnoSKaZulnvH3R9u3r4ENAJ3lvIJKgHFO5TxJTDH/V/3+uBs72ht+BlSqM+ayGG
 CuqD/hloTn96Wn4NZP+W4iHE6m0marOU=
X-Gm-Gg: AR+sD12smGDkEMZdAYuoimrv4hFqrJU1SBC9hRuYSfLqlG1CH45fR6CXgfs6T1XXGDe
 Jyyq/qvFUusvE3nk0tSJMO79jqAq6izuDpvw+MnghFROqXgpPVoGXmKrldtc05n8b8JDkgHI12w
 eWavCVHYjzRLQgnyMTBgl9Y+0/EJQSHKjeX4+YzSaepCbpM9TpxNcjTVfq6x7/WRlJv8k46MMEE
 q/esJAuX7KEWYs7IqnzThpxQejwDec0Aw7Lv2F27suT8Z+eeRGvhCXbzWdf0A+RyIUMTqKaZJqg
 U7az1jC0sxTkSINIRLhlsPavSo4dlwciMsNk9BELhSI49lka4Mdh/WR5e/4Japob6LLdQqRS3XZ
 1jrkd+PInokzozw==
X-Received: by 2002:a05:6808:220f:b0:496:2b3:ae71 with SMTP id
 5614622812f47-4ad5b9cb9dfmr3003896b6e.18.1785283732989; Tue, 28 Jul 2026
 17:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
 <CAGb2v67VRhy_xzkdwUAYhzM_sWzoXyfZ3rYSHYLYaxuve9H17w@mail.gmail.com>
 <a0ae9525-9288-4d13-a080-9cb3d965d536@collabora.com>
In-Reply-To: <a0ae9525-9288-4d13-a080-9cb3d965d536@collabora.com>
From: YoungJoon Lee <getfeus@gmail.com>
Date: Wed, 29 Jul 2026 09:08:40 +0900
X-Gm-Features: AUfX_mxJyiSm31bWY5a0snpvZu7asEtmvztGs1v4_zBGPb9VpXQsQKFqM4tmGnM
Message-ID: <CA+m4KrAvATV9qMMN9h+tKcPdrHRp7-jFJ0-Jq3DeCZLi3Z6RsA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: wens@kernel.org, Brian Masney <bmasney@redhat.com>,
 Chen-Yu Tsai <wenst@chromium.org>, 
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
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
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:49:47 +0000
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

Hi Chen-Yu,

Thank you for posting the v4 series.

I tested the complete v4 series on my MT8173 Chromebook, but I am
seeing a GPU device loss as soon as Mesa initializes the Vulkan device.

My current setup is:

  Board: Google Elm / Acer Chromebook R13 (CB5-312T)
  Kernel:
    linux-next next-20260727
    commit: 33d6e5134c70446eddafbb3fd5ad088e848a7ad6
    (next-20260727-5-g33d6e5134c70)

  Kernel release: 7.2.0-rc5-next-20260727-stb-cbm-next-pvr-v4+

  Mesa: 26.1.5
  vulkan-powervr: 26.1.5
  Firmware:
    rogue_4.40.2.51_v1.fw
    SHA256:
    f44b7056992fb4057c987dcd7073468bec628aa56cb9815b1162f1cb7c1d73f2

All five patches applied cleanly. The PowerVR driver probes, loads the
firmware, and creates the DRM render node successfully.

However, when I run the following from an SSH session without GDM or
another graphical session running:

  PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 vulkaninfo --summary

Mesa prints the expected GX6250 warnings:

  Missing reset support for brn51764
  Missing reset support for brn58839
  Missing support for brn62269

The command then hangs, and the kernel reports:

  powervr 13000000.gpu: [drm] *ERROR* GPU device lost

There are no additional timeout, MMU fault, firmware, clock, or runtime
PM messages immediately before the device-lost message.

I originally also observed the same failure when GDM started GNOME
Shell, but reproducing it with vulkaninfo from a non-graphical SSH
session indicates that this is not specific to Mutter or GNOME.

Since your cover letter reports that vkmark and glmark2-es2-drm work
with Mesa 26.1.5, I suspect that there may be a difference in the
kernel configuration or another part of the test environment.

Could you please share the following details from your working setup?

  1. The exact Chromebook board/model used for testing
  2. The exact kernel base commit
  3. The kernel configuration, or at least the relevant DRM, PM,
     generic power-domain, IOMMU, and MediaTek clock options
  4. Whether CONFIG_DRM_POWERVR was built-in or built as a module
  5. The firmware SHA256
  6. The kernel command line and bootloader used
  7. Whether `vulkaninfo --summary` also completes successfully

My current relevant configuration includes:

CONFIG_PM_SLEEP=3Dy
CONFIG_PM=3Dy
CONFIG_PM_GENERIC_DOMAINS=3Dy
CONFIG_MODULES=3Dy
CONFIG_DMA_SHARED_BUFFER=3Dy
CONFIG_DRM_POWERVR=3Dm
CONFIG_DRM_MEDIATEK=3Dy
CONFIG_SYNC_FILE=3Dy
CONFIG_COMMON_CLK_MT8173_MFGTOP=3Dy
CONFIG_IOMMU_SUPPORT=3Dy
CONFIG_ARM_SMMU=3Dy
CONFIG_MTK_IOMMU=3Dy

I would be happy to test additional patches or provide any further
logs, kernel configuration, or debugging information if that would
help.

Thanks,
YoungJoon Lee

2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 0:28 AngeloGioacchino Del Reg=
no
<angelogioacchino.delregno@collabora.com>:
>
> On 7/28/26 16:44, Chen-Yu Tsai wrote:
> > On Tue, Jul 28, 2026 at 10:33=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> On 7/28/26 15:13, Chen-Yu Tsai wrote:
> >>> On Tue, Jul 28, 2026 at 9:10=E2=80=AFPM Brian Masney <bmasney@redhat.=
com> wrote:
> >>>>
> >>>> Hi Chen-Yu,
> >>>>
> >>>> On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> >>>>> Hi everyone,
> >>>>>
> >>>>> This is v4 of my MT8173 PowerVR GPU support series.
> >>>>>
> >>>>> This time around Mesa was ready for basic testing, using both vulka=
nmark
> >>>>> and glmark2-es2-drm (with Zink). Details below.
> >>>>>
> >>>>> Changes since v3 (all in the clk driver patch):
> >>>>> - Changed pm_runtime_put() to pm_runtime_put_sync()
> >>>>> - Added missing of_node_put() in remove function
> >>>>>
> >>>>> Changes since v2 (all in the clk driver patch):
> >>>>> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> >>>>>     - Needed since the driver implements PM domains using the gener=
ic PM
> >>>>>       domain library, which also depends on PM
> >>>>>     - Fixes build breakage (kernel test robot)
> >>>>> - Fixed "RST_DELAY_CNT" name (Brian)
> >>>>> - Dropped unused mfg_desc (Brian)
> >>>>> - Added check of clk_prepare_enable()'s return value in
> >>>>>     clk_mt8173_mfgtop_power_on() (Brian)
> >>>>> - Saved error value for return in IS_ERR(data->clk_26m) branch
> >>>>>     (Dan Carpenter / kernel test robot w/ smatch)
> >>>>>
> >>>>> Changes since v1:
> >>>>> - Adapted to changed DT bindings
> >>>>> - Dropped driver change
> >>>>> - Use same power domain for "a" and "b" GPU power domains
> >>>>>
> >>>>>
> >>>>> This series enables the PowerVR GPU found in the MT8173 SoC, found =
in
> >>>>> some Chromebooks.
> >>>>
> >>>> I'm making a pull for Stephen for the clk changes. Should patches 1,=
2,4
> >>>> go through the clk tree? Patches 3,5 go through the DRM tree?
> >>>
> >>> Only patches 1 and 2 should go through the clock tree.
> >>>
> >>> Patch 3, 4, 5 can all go through the soc tree if Angelo wants to pick=
 up
> >>> DT binding patches. Otherwise I can push patch 3 through drm-misc.
> >>>
> >>
> >> Not sure if I can really take the DRM bindings patch through soc.
> >>
> >> I will take the devicetree ones exactly right now, even though it's go=
ing to
> >> give warnings.
> >>
> >> I trust that you'll make the binding get into linux-next before it's t=
oo late.
> >
> > Rob beat me to it. :D
>
> Love it!
>
> Thanks Rob :-D
>
> Cheers,
> Angelo
