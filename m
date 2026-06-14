Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8AACD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 14:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B9E10E057;
	Sun, 14 Jun 2026 14:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MaldF1My";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475BD10E057
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 14:08:10 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4600ddc4017so1778116f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781446089; x=1782050889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZ6sLuNEBwb2pkhd5qu/rn+wBwxOy1DXeVTlXK6rZDU=;
 b=MaldF1MyWGd5Bk8EYT6SaMOb9n80GVhIDwIlOmX+IznCvT4FQaYE1ILhxusjvgU9R6
 RbO3WlaibS6bgAMNNXnOMqQTEvIB2OjYBGkkI4fjRbtdUrMMjs+bNcXWi3BMfE2igqRb
 bUxGkRi+WxcZJcrlvoOyWK3vGThzYay+p+kdnu9GJOiRz8f8BwCGEnffOz8SX4ZDNUkU
 nY2wRqSm9dmVwpIRXmFXkPAxIn2cOTSScAnwAsWtnRvxPMixqP4R27cj+0QkFvN5o3In
 dG2o4r2DX23uI1ZY50CetZU7lCllcL+UdEii4vH88n9lrKyuftxzpy29/dNHTzYFbXU4
 24Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781446089; x=1782050889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vZ6sLuNEBwb2pkhd5qu/rn+wBwxOy1DXeVTlXK6rZDU=;
 b=LeNDxLdCtp/rjMbdQBiH+T9/cQR3+HfnDHQNQfp6QQmBKDxWh9uHR3nVhvjDvhyjk/
 C8yhJlhwS+kNn4ZRtidW8Lslv5Esuvtxdn4LMU6o1V43b1NZQeJY1Gd0+PoClYhphqWP
 GFzoScU6BGz2wnoteTAkTsiWkZZwp1I2AmHxqB8JMf/3RNUsdJG5JoBYulaxxzDbHZP/
 JTC3KYTsjFvgxdI9Lfp/ImOtD6oBHz4AhpYS+HsPhnxWjc5aNz/vaKkGJWvRoIyzcRgF
 UJZGUnf8RPDDxDuB3LfqVPhr1cJ1mQF7I4Fw+8Pvvz0bJisIekeIbjMFNHFgH2L81tpU
 E4CA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/irTkQ7XzQ5yPNmRvMrRncSTPIk6i7jfGxrCvMfjf8srH4ZUuUDTO68CrBbQ2qGctJ2z8C2aBGAxQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0tS+9CVfgwJwUgyzDFiohUT//U862X8AEiBiaMmr2cd2kgi3W
 J4SGwQUjmvFCXd5KzNtPFcffmRIZpXqUo9w+/TsFriF34+76epkUs/lB
X-Gm-Gg: Acq92OEOFfOAmfWwTzvF9LJvMYq8rSumogWQNahYMWRMiA1z0eOWbkrlqBL00Ym/gfo
 iE4RKsLa/FVK/1UFxMVBR9AXYywskNl/jsghdHDHOZin3IlUYUcTzzEflKGgRWqeFIL9KcMzRdk
 4gT8TbedkwlSyP2nXc4Cmpphx3WKH4KFiP6kSeOQW4bD0nAX16t096OlH5ICnic3gZmBPIB3bNh
 hWfI37nVRIBacVtKDiNC9ELzSW1fvexLCogNm20Ml85FUI/VwfqXdbtP62Qtxdo3uyupyxnQwWa
 p7AykBvbs3obh7+kTLfeaeeYNpv17rSoNqicO+EhNzpdG0Ykb6r6kKpT8oLrVxCDmpYZj1jf38F
 pn1vOdDvxBDrviib6MZk8f4lAtAzuIX7KqvPnb2rUBjrF5dApEx7XM1TXDlFPBPmujLGUjPkgN8
 Gf4Vkq2GdPYZ8FjJ84Bu3sze3HiG/ox2JACZx7bUeQwuKk
X-Received: by 2002:a05:6000:984:b0:460:3234:293d with SMTP id
 ffacd0b85a97d-4606dbce8a5mr14655307f8f.40.1781446086390; 
 Sun, 14 Jun 2026 07:08:06 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f450sm27152837f8f.10.2026.06.14.07.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 07:08:05 -0700 (PDT)
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
Date: Sun, 14 Jun 2026 16:08:04 +0200
Message-ID: <nIKN_benRn2Bk8SDZrkMCA@gmail.com>
In-Reply-To: <032c1099-40ab-470e-8cc3-af6d3cad22d4@kernel.org>
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
 <ahNuuaVlDl0KvOSj@home.wens.tw>
 <032c1099-40ab-470e-8cc3-af6d3cad22d4@kernel.org>
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

Dne ponedeljek, 25. maj 2026 ob 14:10:38 Srednjeevropski poletni =C4=8Das j=
e Krzysztof Kozlowski napisal(a):
> On 24/05/2026 23:33, Chen-Yu Tsai wrote:
> > Hi,
> >=20
> > (resent from new email)
> >=20
> > On Thu, May 14, 2026 at 2:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On Sat, May 09, 2026 at 09:00:14PM +0200, Jernej Skrabec wrote:
> >>> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> >>>
> >>> As it turns out, current H616 DE33 binding was written based on
> >>> incomplete understanding of DE33 design. Namely, planes are shared
> >>> resource and not tied to specific mixer, which was the case for previ=
ous
> >>> generations of Display Engine (DE3 and earlier).
> >>>
> >>> This means that current DE33 binding doesn't properly reflect HW and
> >>> using it would mean that second mixer (used for second display output)
> >>> can't be supported.
> >>>
> >>> Remove layer register space, which will be represented with additional
> >>> node, and replace it with phandle, which will point to that new, shar=
ed
> >>> node. That way, all mixers can share same layers.
> >>>
> >>> There is no user of this binding yet, so changes can be made safely,
> >>> without breaking any backward compatibility.
> >>
> >> There is user. git grep gives me:
> >> drivers/gpu/drm/sun4i/sun8i_mixer.c
> >>
> >> which means this is a released ABI. As I understood, the old code was
> >=20
> > We held off on merging the DT changes so that we could rework this.
> > I can't find the actual request though. It was probably over IRC.
> >=20
> >> working fine but just did not support all use cases. Why this cannot be
> >> kept backwards compatible?
> >=20
> > AFAIK the "planes" block is shared between two display mixers. As the
> > commit message explains, this prevents using the second mixer, since
> > only one of them can claim and map the register space. And on the H700
> > (which is the same die as the H616 discussed here but with more exposed
> > interfaces), there could actually be a use case for the second mixer.
>=20
> It explains why you want to make the changes but not why you cannot keep
> it backwards compatible.

I guess it can be backward compatible, but I don't think it makes sense.
Yes, original driver implemented original DT bindings, but there is no node
which uses that binding. If there is no user of that, why would driver
need to support it nevertheless? Supporting only actually used DT binding
allows for better code architecture, as there is no need to support second,
unused path. It also simplifies testing, since developer doesn't need to
test both paths if code is changed in that area.

Best regards,
Jernej

Best regards,
Jernej


