Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA8CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2468E10E42D;
	Mon, 15 Jun 2026 15:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cpgWb9/6";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B8DF10E42D
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:47:04 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-46015dc517aso2886794f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781538423; x=1782143223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjI9RSrMpeF9kl7KVlAoFqnYJfNf7P3l6mHXMFpoLdk=;
 b=cpgWb9/6SiH00ecd68Cy0ws+KIfPtRFYmQojBiuT3DS4yeHBDlXu86K0V+pyHNzNKu
 lrFa6HCyjk5eb6IPyzHIf934Y3dA68Y/XGcY7jlbKsFlN5Gj2OXihYBHYOPiJnb+5wJH
 TCsRGaEaMIma4FwlEJLtm5DcaZJsjbgHLeijLvRUUWQ0EmV3ZOVe57vmv1TASvmlhCnP
 ksNb+ulQXN3g4b+OBRCIPz35XgIcH4wTbvQ51Wck0oYYWl9JpP207TzSiw1GZR9zJr7x
 a85/B1CXYovXF6oIHz+xJoTpvkqG9BQIJS/eYHHeua/Vd0FHypxJGBBWSKp18y2PEM+J
 qHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781538423; x=1782143223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KjI9RSrMpeF9kl7KVlAoFqnYJfNf7P3l6mHXMFpoLdk=;
 b=SqsjmkQt77aMS09qilX8yuHoVljkczQSMOVoz+ZcQplMqCBkiODMK9QZge2yzOw/hi
 uCfjmZVZvIu0S3fMIOv9bjSt2/wohvZpzWDmi3ET4rB+Q98dEDaqzV/yLLaUwfQ4EX2K
 Ek9xredbx2UUHbbqdiTLd63ChMzJZfmiCP0pDRfCXtkinC2bfMg91bJktfruLyKPUqzl
 CU/aC0LMRTTwGkFRmWW5igm0T2eyPDSlBEcfUuZsSVSTMvrEiPTAMM+nLBNjzVVqOFG9
 lQNQoe9OZMi417qfUa5T6RRkY++pNzYBq+xptK24mgGNue/kFjbnBTm0Zvu3YZlK1cJl
 t4Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iDGOzDF+jeTff6ojsx7H8ucbVXOzyqp11suaLjFE8w5sWirA77CK/n2zDrsO9NAmk+ENbOQNANRM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtxrAWKXvVkbPAFhG1m2MCkTMMiUu6Gv+GjrqWJYzPm6UFBWWw
 uWkaQ+iWEs2GWH7Ivj5Ped92yGJ1fxihQoiwEWAwD1JzNHigyIl6X+kT
X-Gm-Gg: Acq92OF8CP+7v5QuyARjQ+UiZS6Luut39jGQJvLiUgj0lfS8b/7/6wHCfEUxQJhrYvh
 wkmRlQNt0g9DewKHMm5IK6h7Cu6b1x7kwo6EekwzhxUqBY6JCPeDsbMm7ezh93Y09sDKphGtxD0
 v0Eh73ZSb0cwDeLiKPHMKEuv9MJ5SCw+BwjU9bKr9XIxaZMfuVdenTQ6x/njRJHm8sXJduDworW
 zu3sH0grNz80TnmWI3sPn9aPWBIhWVNalMMl40RIZw47oBmNHVf8CugkcH2PkPJyAuRd2NzfgRm
 rH9ZxM3dYV6xGxspPVf6NcGOGinBfNkPCD/hW988nMq3mO0o7fNJWRuV+WJCTQIAwjSthPEEtHT
 BgTvB9GbAedOjPobc7yrpNm2PE8uh2f2vz/sJjBeIHiWVZToO7VzeDYysmBMpPIEgY5shKMul51
 8q436Mzn4rs4ipX9hMpWMn/bf7cfa7nhYQ872pJDXZ7W+u+ED0yqnIUzRmUjjFRZls1e87HqUBw
 7TrnEb+4wL2cU/xDGloelwCVtyam/jhuq//kw==
X-Received: by 2002:a05:6000:1acb:b0:460:1bf8:c981 with SMTP id
 ffacd0b85a97d-4606da57c41mr20753889f8f.5.1781538422504; 
 Mon, 15 Jun 2026 08:47:02 -0700 (PDT)
Received: from jernej-laptop.localnet (92-53-159-70.dynamic.telemach.net.
 [92.53.159.70]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c4240sm32724851f8f.27.2026.06.15.08.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 08:47:02 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc: samuel@sholland.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: display: allwinner: Split H616 DE33
 layer reg space
Date: Mon, 15 Jun 2026 17:47:00 +0200
Message-ID: <0r4us4OeRRWtJhxvps-bZw@gmail.com>
In-Reply-To: <86943057-f5b4-4fae-9172-45f13814494f@kernel.org>
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
 <nIKN_benRn2Bk8SDZrkMCA@gmail.com>
 <86943057-f5b4-4fae-9172-45f13814494f@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 15. junij 2026 ob 06:28:54 Srednjeevropski poletni =C4=8Das=
 je Krzysztof Kozlowski napisal(a):
> On 14/06/2026 16:08, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 25. maj 2026 ob 14:10:38 Srednjeevropski poletni =C4=8D=
as je Krzysztof Kozlowski napisal(a):
> >> On 24/05/2026 23:33, Chen-Yu Tsai wrote:
> >>> Hi,
> >>>
> >>> (resent from new email)
> >>>
> >>> On Thu, May 14, 2026 at 2:04=E2=80=AFPM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote:
> >>>>
> >>>> On Sat, May 09, 2026 at 09:00:14PM +0200, Jernej Skrabec wrote:
> >>>>> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> >>>>>
> >>>>> As it turns out, current H616 DE33 binding was written based on
> >>>>> incomplete understanding of DE33 design. Namely, planes are shared
> >>>>> resource and not tied to specific mixer, which was the case for pre=
vious
> >>>>> generations of Display Engine (DE3 and earlier).
> >>>>>
> >>>>> This means that current DE33 binding doesn't properly reflect HW and
> >>>>> using it would mean that second mixer (used for second display outp=
ut)
> >>>>> can't be supported.
> >>>>>
> >>>>> Remove layer register space, which will be represented with additio=
nal
> >>>>> node, and replace it with phandle, which will point to that new, sh=
ared
> >>>>> node. That way, all mixers can share same layers.
> >>>>>
> >>>>> There is no user of this binding yet, so changes can be made safely,
> >>>>> without breaking any backward compatibility.
> >>>>
> >>>> There is user. git grep gives me:
> >>>> drivers/gpu/drm/sun4i/sun8i_mixer.c
> >>>>
> >>>> which means this is a released ABI. As I understood, the old code was
> >>>
> >>> We held off on merging the DT changes so that we could rework this.
> >>> I can't find the actual request though. It was probably over IRC.
> >>>
> >>>> working fine but just did not support all use cases. Why this cannot=
 be
> >>>> kept backwards compatible?
> >>>
> >>> AFAIK the "planes" block is shared between two display mixers. As the
> >>> commit message explains, this prevents using the second mixer, since
> >>> only one of them can claim and map the register space. And on the H700
> >>> (which is the same die as the H616 discussed here but with more expos=
ed
> >>> interfaces), there could actually be a use case for the second mixer.
> >>
> >> It explains why you want to make the changes but not why you cannot ke=
ep
> >> it backwards compatible.
> >=20
> > I guess it can be backward compatible, but I don't think it makes sense.
> > Yes, original driver implemented original DT bindings, but there is no =
node
> > which uses that binding. If there is no user of that, why would driver
>=20
> Did you check all out of tree users of the ABI? All vendor kernels,
> forks and all of them for which the ABI was made for?

Since when do we care about out of tree users? I understand that drivers
must support old device tree files. Once they work, compatibility must
be carried forward. But that's not the case here.

In any case, vendor kernels have completely different DT structure. This
was developed independently from them. Take a look at [1] how BSP DT looks
like, specifically Display Engine node.

Of course there are some distros which grab WIP patches from mailing lists
soon after they are available. For example, I know that Armbian carried old
WIP patches which used old ABI. However, such distros generally don't care
about exact solution and ditch patches as soon as proper solution is merged
upstream or even when better WIP patches come around. DT files in such
distros get updated alongside kernel, they are not hidden in firmware.=20

Best regards,
Jernej

[1] https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-4.9-s=
un50iw9/arch/arm64/boot/dts/sunxi/sun50iw9p1.dtsi#L1315-L1339

>=20
> If there is no single downstream/out of tree kernel using this ABI, then
> of course you do not need to consider it. I don't know how would you
> prove that but I am open for suggestions.
>=20
> > need to support it nevertheless? Supporting only actually used DT bindi=
ng
> > allows for better code architecture, as there is no need to support sec=
ond,
> > unused path. It also simplifies testing, since developer doesn't need to
> > test both paths if code is changed in that area.
> >=20
> Best regards,
> Krzysztof
>=20




