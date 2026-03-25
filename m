Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432BEFEA835
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 09:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C72C10E846;
	Wed, 25 Mar 2026 09:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hneuZNOI";
	dkim-atps=neutral
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA75E10E846
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:18:10 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-38bf85e4810so17391941fa.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774430289; cv=none;
 d=google.com; s=arc-20240605;
 b=hZRcqBcVBG0Q80JrHYdLcadWLx4+ivzbN29TiFGQzS+7GoGfQPicx7ITkaS29SCSBB
 8/A2E9TAj1a+ouyyCthotfXagPbFDHtgiraNvfcfbqPlGeoaelb8EDEuwVCe4mPPD/er
 jh+Ar35Di6up7GbgUg5KXOgrkHv/Vr6LQ4xaJWyxbQuQvYZPyu2EwOqExe0gvEZSRK/T
 SmFeqZujq/NGs8WKEUeyEXc0jDZhM5S0uKgbTcRWHMVM6pVn8r62sZ1nEdubhEdNhyZH
 a86VQZUJJO6WWrwr6Dn8H7BPNQQVTTTvTtsz2/E+oYloL7PcMRp+PF9jDW2C1j3/ZEdj
 C4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JlhSXELYE8vgX7qqunsSd6qJxJ59KW296nfLjRCFqek=;
 fh=V9nXTCUomklJ8VoL/OssHLXdfDlTKD/qThH1ln64Rys=;
 b=VDAoNOcdgBVaivXhaO2s0YGnEiRBUFQPkUTFtiuXwnz2Nau0TRfxMuw+EmIo0LqC3+
 em3OfOOuZhGVilMvio7fbszRRA61iAZLXJ8CmP3blGm/kipxOvghluaWrUgLHsOp37fJ
 ZDa4CS7TJDdx3sLj9fagHQuTm9VpHQtgDwhJ/HUhzq+Uh6ncaFoRSfB/1bEf53et7NvP
 RnuHozk3rDOQsZgs/Prm0Ii0BXKtQuR/46DSvmdeu35Sx+ehww7mb85aRc5JRcmpZ9Ag
 daqZXQJJq8FMyA50FSG0ALPoaFYFpajFTTuJAfohgqY+evUmzSjz/A/7jvimVAtd2zHt
 8M3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774430289; x=1775035089;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlhSXELYE8vgX7qqunsSd6qJxJ59KW296nfLjRCFqek=;
 b=hneuZNOIx996kzPoXKwI2D43SJohWQfiM1h+p8N0Rszwmy9s8xG2rDdu/1cHpxB/BZ
 AlC9LpmSFdSHY6ow+q5uhiiVaAQUMQVCsiUmlDAHul2WXDM6fAGnN/NR0L9cbd4RJdbO
 diIa2aoOhFU5YfGeEk499FgKW1IBGG4y93cJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774430289; x=1775035089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JlhSXELYE8vgX7qqunsSd6qJxJ59KW296nfLjRCFqek=;
 b=UXQqnor0rG/yYw2l2cmfeZXphLHeHFMRIf+FM8UZI2EF9kdOn5G/UoptwtSBsEFWvT
 dStizuJDPfzXNDcGJqGWNK5GyPiOECRi2i5KnbP5ReBdHFkRx336kShZ8npIRMzz7mQa
 klh6OMq/oVdIyg42tHz5PQOK0soeLMXJ1MyZT0BOaAm3UGV7Flfzm10PDlQSYni1BFj1
 6vcCHktwXMwy9nBF0NZlFaIre4Qtz6tuNoaeWE/dkHNI3XbpY6sRwUEEkO/GmYuntYbz
 isPOK7Dkus3HL2/3q8xfC8MnTRdD81Uaqew5Y2xqbJQmNWth2N1fz6ZZcPaSYYBL3BK7
 1+cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXArdlAs2UP1eCKX9cTJCRHDavyOYtR/rIChD56yQyFOElRBtXuCBuYoVxZVS2mTRaF7wRlCjcKnEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWXt0d/eKUgaE8e/rPl/TqU53mRuhdgFa217u9FLynp+Cpy3qs
 qYG2LQHuLQ5gl8hbrSNMG5HpByh+QPhkZRlE6Ed6OOLVnOtPzvs+VGjvQJVvuYzVssnWf3zjQcS
 X82CBtOtfpSGrgrepbVOO/WSMMH508q3/NCNVqxnr
X-Gm-Gg: ATEYQzxxAIOPEdwQBDL+PzLg8Q9OL/zyTQYsV0MEpmJjmKFyDNmdSl6sTpQGUgXoxyN
 r1X04gpCAF0Eoqzu5WdLshC4f6wB7+jp1EyRw8ghE8386VWVSWVja2u8IUMb9LB82CyK2gGL1Iz
 AFKaJeeeAqfCdL16+QvDqgpqh27+YXaFNN3Av3m2LWgract6j7J+0xPA5Fsmrbf1vREXsNquwKT
 6qeVjCyeS0+2Px2JcdefIbqhuhrrUXJhZBJvAfcwYveUfGXz8ArhtDhJiHZEkCzum7ZKnm7RztK
 wgD2ec1YCC+LykOVRvKV3vn9HoHsJdVq506D
X-Received: by 2002:a05:6512:1252:b0:5a2:8718:b322 with SMTP id
 2adb3069b0e04-5a29b97cb53mr1236317e87.15.1774430289060; Wed, 25 Mar 2026
 02:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260325071951.544031-1-wenst@chromium.org>
 <93c1d325461cc0ffad890d64870de680506338c4.camel@icenowy.me>
 <CAGXv+5FL2rs35V4F0bwq-a4ccvFaWKcr1cuKxT6sfTj9h+d6iA@mail.gmail.com>
 <0739597b7a9c162525c10d82c3993e37af1c8a75.camel@icenowy.me>
 <cb75a09ecc88972503f5ade8e1807122c48d8ac8.camel@icenowy.me>
In-Reply-To: <cb75a09ecc88972503f5ade8e1807122c48d8ac8.camel@icenowy.me>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 25 Mar 2026 17:17:57 +0800
X-Gm-Features: AQROBzAB2xsA--d1NrWuC5hnkU-nq8sFhsGVW2irjP7zw26EVL5TptjCi0fi-9g
Message-ID: <CAGXv+5EbFv5bybX4bkXOSiPZm4fG-dQy19dfUXJ6C8RE_tk6Cw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] powervr: MT8173 GPU support
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Mar 25, 2026 at 4:42=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> =E5=9C=A8 2026-03-25=E4=B8=89=E7=9A=84 16:30 +0800=EF=BC=8CIcenowy Zheng=
=E5=86=99=E9=81=93=EF=BC=9A
> > =E5=9C=A8 2026-03-25=E4=B8=89=E7=9A=84 16:08 +0800=EF=BC=8CChen-Yu Tsai=
=E5=86=99=E9=81=93=EF=BC=9A
> > > On Wed, Mar 25, 2026 at 4:04=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me=
>
> > > wrote:
> > > >
> > > > =E5=9C=A8 2026-03-25=E4=B8=89=E7=9A=84 15:19 +0800=EF=BC=8CChen-Yu =
Tsai=E5=86=99=E9=81=93=EF=BC=9A
> > > > > Hi everyone,
> > > > >
> > > > > This is v2 of my MT8173 PowerVR GPU support series.
> > > > >
> > > > > Changes since v1:
> > > > > - Adapted to changed DT bindings
> > > > > - Dropped driver change
> > > > > - Use same power domain for "a" and "b" GPU power domains
> > > > >
> > > > > This update was requested by Icenowy.
> > > > >
> > > > >
> > > > > This series enables the PowerVR GPU found in the MT8173 SoC,
> > > > > found in
> > > > > some Chromebooks.
> > > > >
> > > > > This version is different from the initial powervr driver
> > > > > submission
> > > > > [1]
> > > > > in that it splits out the GPU glue layer support out of the
> > > > > powervr
> > > > > driver and into a separate clock and power domain driver. The
> > > > > glue
> > > > > code
> > > > > is otherwise the same, and also the same as found in the
> > > > > ChromeOS
> > > > > kernels, with some extra comments and macro names added where
> > > > > possible.
> > > > >
> > > > > Patch 1 adds a binding for the glue layer, called mfgtop. The
> > > > > glue
> > > > > layer
> > > > > contains clock and power controls for the GPU.
> > > > >
> > > > > Patch 2 adds a driver for the glue layer.
> > > > >
> > > > > Patch 3 adds an entry for the MT8173 GPU and 6XT series to the
> > > > > PowerVR
> > > > > binding.
> > > > >
> > > > > Patch 4 adds an entry for the PowerVR 6XT series GPU to the
> > > > > driver.
> > > > >
> > > > > Patch 5 corrects the clock for the GPU (called MFG) power
> > > > > domain.
> > > > >
> > > > > Patch 6 adds device nodes for the GPU and glue layer to the
> > > > > MT8173
> > > > > dtsi
> > > > > file.
> > > > >
> > > > > Patch 2 and 6 depend on patch 1 to build. I suppose some common
> > > > > immutable tree would be needed from the MediaTek maintainers.
> > > > >
> > > > > The kernel driver successfully probes the hardware and loads
> > > > > the
> > > > > "rogue_4.40.2.51_v1.fw" firmware provided by Imagination
> > > > > Technologies
> > > > > [2].
> > > > > Userspace was tested with Mesa 24.0.8 from Debian Trixie
> > > > > rebuilt
> > > > > with
> > > > > the powervr vulkan driver enabled. `vulkaninfo` gives some
> > > > > information
> > > > > about the GPU (attached at the end), but running the `triangle`
> > > > > example
> > > > > from the Sascha Willems demos [3] with -DUSE_D2D_WSI=3DON as
> > > > > recommended [4]
> > > > > failed with:
> > > > >
> > > > >     Can't find a display and a display mode!
> > > >
> > > > I think when using D2D the demos want width and height to be
> > > > explicitly
> > > > specified, otherwise it seems to hardcode 1280x720.
> > > >
> > > > If you're using an elm, could you try to add `-w 1920 -h 1080` or
> > > > for
> > > > hana `-w 1366 -h 768` ?
> > >
> > > I only did the basic `vulkaninfo` test this time around. To do
> > > anything
> > > interesting probably requires the Mesa 26.1 release.
> > >
> > >     PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 \
> > >         vkmark --winsys kms -D b81f54f8568deb0fb70a6a1ed845b65d
> > >
> > > just reports "Error: Device specified by uuid is not available"
> >
> > I am very sorry to tell you that, when I run Sascha's demo with Mesa
> > main, I got GPU lost immediately...
> >
> > ```
> > [  441.509433] powervr 13000000.gpu: [drm] *ERROR* GPU device lost
> > ```
>
> Sidenote: I think this is some power domain management issue, because I
> saw the kernel saying `vgpu: disabling` , which shouldn't happen if the
> GPU is active?

AFAICT "vgpu" is the vgpu output from the primary PMIC. This one is unused.
The actual regulator supplying the GPU is from the secondary PMIC. The
rail is called VBUCKB...


ChenYu


> >
> > Icenowy
> >
> > >
> > > This is with Mesa 26.0.2 packages from Debian testing. At least now
> > > have the powervr vulkan driver enabled by default, so I don't have
> > > to rebuild the packages again.
> > >
> > >
> > > ChenYu
> > >
> > > > Thanks
> > > > Icenowy
> > > >
> > > > >
> > > > > Same program worked correctly on a BeaglePlay and displayed a
> > > > > color
> > > > > gradient triangle. Not sure what went wrong here.
> > > > >
> > > > > Anyway, please have a look and test.
> > > > >
> > > > >
> > > > > Thanks
> > > > > ChenYu
> > > > >
> > > > > [1]
> > > > > https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.w=
alker@imgtec.com/
> > > > > [2]
> > > > > https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/=
powervr
> > > > > [3] https://github.com/SaschaWillems/Vulkan
> > > > > [4]
> > > > > https://lore.kernel.org/dri-devel/f2b2671e-5acc-4dec-9c2e-3c9cd2e=
1f19e@imgtec.com/
> > > > >
> > > > > Chen-Yu Tsai (5):
> > > > >   dt-bindings: clock: mediatek: Add mt8173 mfgtop
> > > > >   clk: mediatek: Add mt8173-mfgtop driver
> > > > >   dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
> > > > >   arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain
> > > > > clock
> > > > >   arm64: dts: mediatek: mt8173: Add GPU device nodes
> > > > >
> > > > >  .../clock/mediatek,mt8173-mfgtop.yaml         |  70 +++++
> > > > >  .../bindings/gpu/img,powervr-rogue.yaml       |   1 +
> > > > >  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  33 ++-
> > > > >  drivers/clk/mediatek/Kconfig                  |   9 +
> > > > >  drivers/clk/mediatek/Makefile                 |   1 +
> > > > >  drivers/clk/mediatek/clk-mt8173-mfgtop.c      | 243
> > > > > ++++++++++++++++++
> > > > >  include/dt-bindings/clock/mt8173-clk.h        |   7 +
> > > > >  7 files changed, 363 insertions(+), 1 deletion(-)
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/clock/mediatek,mt8173-
> > > > > mfgtop.yaml
> > > > >  create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c
