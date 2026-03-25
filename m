Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696B7FEA82F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86F110E816;
	Wed, 25 Mar 2026 08:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q/hji/hI";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CF310E816
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:09:00 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5a27eb8311bso4654460e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 01:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774426139; cv=none;
 d=google.com; s=arc-20240605;
 b=A4LkUE+2+q7N8basGPBZok/iym2V1GEwJv+rlCqO572ACFUFMi7UqRYpkP06dfslmz
 A4xCa4YQ2S/OHMLJBucIzjAUMBSoIdfUMEnkwXpr6Pxr6eaU2Aw3OXMSnba8vcSqxm2m
 lW6YG57fAMJm+SZ7zKgc5f7R+GqWfkMDzLbh5ugxBYSce01hflIioHT2dMlPSMubrbBq
 bNAqDT66Fe0VAjJy64BEaG3EyiogK6ddvdkLIMhoM/e8X4XQ6jAoeMZ7mB5K2l4krlCO
 cXlj3pFsq91bC16CP6MoQFY8Wl9Xtunlyiyq0j03m+bitsDWI/PfS+zGRD6tfywVr4Tk
 LNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g0KgYtYkqUP59BqGGG61EV18AeUer+TehEbvZYdIpWI=;
 fh=R3c8EIy21+YsyJg1F9N/SMkYySdkrnHmraOcHaHF8yo=;
 b=WshMunywJCoAvCGoCdnTEzvqxsttZK1vNGBFRFUJ78obMWPcCCRd8f+3KVtSLRhSA8
 2jDw72F+XYNpoXGrxcUutBl+uRw7GTj0XPtCxU8Qg3dZdria9vXBac19EPJtoh/TZzhu
 WEFz7oP2X0bY3OWTg4+TAVufwjspOhrvTMJ9NoVB/6Pohi68F0fpxzqDSeAkoi8kUA0X
 Fyvj7klc61edqu0yWmrtkb8Uniz5bgAw3suvCC0V2h4vIBPBL57CjiiLWmpkntvRbklc
 PJwn/bGO40LZ7OCMljh0QVuAyBnNK0ntuIp0Ey+yWJloyfRM3pg/J3ZN/UkqAYy2nGZS
 GPrA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774426139; x=1775030939;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0KgYtYkqUP59BqGGG61EV18AeUer+TehEbvZYdIpWI=;
 b=Q/hji/hIVQ08UQptQv3+oD3shMjUVFbJRiw4ZI6c7kTQH5q+z1OZpz7fknMUK0+3+p
 oqehZz00fKMDEhf0bkUoOeRiG7Ov143ln94DylO8CfWRZZKA9k2G7sbn/d18np+3VIlP
 ryEX8K4SLW+333ocpsBeFCUhUA70efI1GukSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774426139; x=1775030939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g0KgYtYkqUP59BqGGG61EV18AeUer+TehEbvZYdIpWI=;
 b=KlE04dW7kBTQoXgBO0HKLhfNfUyheT9ld1VLr/HJVBF+rLVkAaOoBwxiV9mMEFYYip
 Rkts8o8w/HQwPL1eLKL/Bi0AcsxpRDe6Ts3CkMFxSZ3VYqhKIarGUfXzUHZOdsR81k61
 wrgBdwOqU9DyxccBTcWdcN8RfkX0nA8MgnBKsZ9UUATIeKpoN0Q7RKoMgsszG5inZnjc
 /ruEYoIr1opieYJWVLLOF9YAib9HbW1MlQwTX6wwSLUl6XBTPEpTpLs+WOpDRaWRpgKg
 1DVfqMhkJfdAUMc8vkGVJCKHmYQp+iSxVOWXxAS3lKfd0xHhihkoX1HQX4O7yiQ0BNr2
 kc6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS5L4URkXRVbn0ujA0RO099oN+E/qmH5AcBTee6ttkrXAGsjETqdcZPMvcS436cYQvmqeys7rjWIg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqOZWx9iIepoMUc7OUQeor3jYohwTBYA5RAvxhaEk9wK5adQGS
 a8aax7LtmrI8apuhrIK7rSrJK5o37zkW0KFEDAFcNsSXdw+2Il/8tMzAyAbCl/FrJ9sPsUCW9C8
 kUAUVigvLfSxqHzwOAuvulD1NUhOo5rcIyChmdTMp
X-Gm-Gg: ATEYQzz9wBhk80T6LeSUHExGOACc8ka2z6i4V6ADnafH9H1UUeCeR5Sf8zAbCW92Qzk
 Oi9Ar8/FXudL58STIJJ0gNfP4BH+Qqn8/iN+WENnYZw+yileFufrNgfyo1IhsqTZ1gWs/j0fnCc
 aAqaVAEgIN6P7I0NhxDKAifkIKxDrH2HD7o/HcdfE0/ybOH9uQKO38bc13htqqKlSNy8R6zpYz1
 g0X9KRveG3H7MKQh8jg1DAkGmmVvu51zyjlI9tGE8SBmluH/YsTgwqR4kdS4hXPQNby+AsDGM+T
 uwuFKK0mXES0U539Bi3cQcWcXO25DgJIcXl0
X-Received: by 2002:a05:6512:2206:b0:5a2:7ddd:ec16 with SMTP id
 2adb3069b0e04-5a29b99baa7mr981433e87.40.1774426138566; Wed, 25 Mar 2026
 01:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260325071951.544031-1-wenst@chromium.org>
 <93c1d325461cc0ffad890d64870de680506338c4.camel@icenowy.me>
In-Reply-To: <93c1d325461cc0ffad890d64870de680506338c4.camel@icenowy.me>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 25 Mar 2026 16:08:47 +0800
X-Gm-Features: AQROBzAcEDSwfaWS447vAKoAeNwXBwZATTBP1wT6QXTz02f-QcFivNXEvPY79i4
Message-ID: <CAGXv+5FL2rs35V4F0bwq-a4ccvFaWKcr1cuKxT6sfTj9h+d6iA@mail.gmail.com>
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

On Wed, Mar 25, 2026 at 4:04=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> =E5=9C=A8 2026-03-25=E4=B8=89=E7=9A=84 15:19 +0800=EF=BC=8CChen-Yu Tsai=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi everyone,
> >
> > This is v2 of my MT8173 PowerVR GPU support series.
> >
> > Changes since v1:
> > - Adapted to changed DT bindings
> > - Dropped driver change
> > - Use same power domain for "a" and "b" GPU power domains
> >
> > This update was requested by Icenowy.
> >
> >
> > This series enables the PowerVR GPU found in the MT8173 SoC, found in
> > some Chromebooks.
> >
> > This version is different from the initial powervr driver submission
> > [1]
> > in that it splits out the GPU glue layer support out of the powervr
> > driver and into a separate clock and power domain driver. The glue
> > code
> > is otherwise the same, and also the same as found in the ChromeOS
> > kernels, with some extra comments and macro names added where
> > possible.
> >
> > Patch 1 adds a binding for the glue layer, called mfgtop. The glue
> > layer
> > contains clock and power controls for the GPU.
> >
> > Patch 2 adds a driver for the glue layer.
> >
> > Patch 3 adds an entry for the MT8173 GPU and 6XT series to the
> > PowerVR
> > binding.
> >
> > Patch 4 adds an entry for the PowerVR 6XT series GPU to the driver.
> >
> > Patch 5 corrects the clock for the GPU (called MFG) power domain.
> >
> > Patch 6 adds device nodes for the GPU and glue layer to the MT8173
> > dtsi
> > file.
> >
> > Patch 2 and 6 depend on patch 1 to build. I suppose some common
> > immutable tree would be needed from the MediaTek maintainers.
> >
> > The kernel driver successfully probes the hardware and loads the
> > "rogue_4.40.2.51_v1.fw" firmware provided by Imagination Technologies
> > [2].
> > Userspace was tested with Mesa 24.0.8 from Debian Trixie rebuilt with
> > the powervr vulkan driver enabled. `vulkaninfo` gives some
> > information
> > about the GPU (attached at the end), but running the `triangle`
> > example
> > from the Sascha Willems demos [3] with -DUSE_D2D_WSI=3DON as
> > recommended [4]
> > failed with:
> >
> >     Can't find a display and a display mode!
>
> I think when using D2D the demos want width and height to be explicitly
> specified, otherwise it seems to hardcode 1280x720.
>
> If you're using an elm, could you try to add `-w 1920 -h 1080` or for
> hana `-w 1366 -h 768` ?

I only did the basic `vulkaninfo` test this time around. To do anything
interesting probably requires the Mesa 26.1 release.

    PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 \
        vkmark --winsys kms -D b81f54f8568deb0fb70a6a1ed845b65d

just reports "Error: Device specified by uuid is not available"

This is with Mesa 26.0.2 packages from Debian testing. At least now
have the powervr vulkan driver enabled by default, so I don't have
to rebuild the packages again.


ChenYu

> Thanks
> Icenowy
>
> >
> > Same program worked correctly on a BeaglePlay and displayed a color
> > gradient triangle. Not sure what went wrong here.
> >
> > Anyway, please have a look and test.
> >
> >
> > Thanks
> > ChenYu
> >
> > [1]
> > https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.walker@=
imgtec.com/
> > [2]
> > https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powerv=
r
> > [3] https://github.com/SaschaWillems/Vulkan
> > [4]
> > https://lore.kernel.org/dri-devel/f2b2671e-5acc-4dec-9c2e-3c9cd2e1f19e@=
imgtec.com/
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
> >  drivers/clk/mediatek/Kconfig                  |   9 +
> >  drivers/clk/mediatek/Makefile                 |   1 +
> >  drivers/clk/mediatek/clk-mt8173-mfgtop.c      | 243
> > ++++++++++++++++++
> >  include/dt-bindings/clock/mt8173-clk.h        |   7 +
> >  7 files changed, 363 insertions(+), 1 deletion(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml
> >  create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c
