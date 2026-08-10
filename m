Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEFBC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA88810E81A;
	Mon, 10 Aug 2026 12:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="oVuXl0fd";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7F710E7F9
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 12:08:56 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c2020421077so276887566b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 05:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786363735; cv=none;
 d=google.com; s=arc-20260327;
 b=ciAaSiaeccbI6M+4gjF1Vcn34DB5fKFf4e+JgNLjZGVporB5A1OAi3Ss1q6u0CzRxn
 X1ioYwUU4T1o7+D2axPa1G0OWU0G2QhESbSDeMMTEKBQhMwISsQwg6l/ts9vrcB9qxxC
 A3xlacCqTRrpcWuf8WQjaM9HGwn9T4TfMNvkBBm/Cp2UCSLGFPM+yo9HbqEndD+MpSc/
 /jF+W6cBRvp3mJctSArAqmfAIW5cYM15SrsalCGmkqVkZQlOZ7Bg6Fv6W4BYqsDu07WT
 wip8DGbFgML+rU+XSd8dTtM32OuGteMcuZQxzDatR19REfzh1z3TpRfalEd+aR4yBPox
 ZBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qQpWbJttwi61w+33UaX9aual3LIjiZRDlQt6M32wCuQ=;
 fh=slZHH2q4nJa94L09A2GKiXxhhJhOqwHJmpNmnNrTduU=;
 b=SHVR7cvTnMh38TvKdRW953XFt4kMdAg2wePVVMbqvaRj969Q3s8pwRMWGCp87ZKj0+
 m3ATMDWlvANC/xX3xqf0tbCVqCFGF+il9GT00UM1MIR+pZ7zv7Q0pml5Eq3NQmNeZg5S
 6/9B5UJBt0zAI3TqObgYKX5ZPKtqC/t0GKhJYD4YxgWmNKHR0AE9cEbyXj0dN74eJ4w/
 LKG8U99vXnSZDBzWKfLA7eKounYkvhkG+EOf1gfPdowuHZ40amyCakjEGdFfsJmvrAT3
 bd4oviUtVhVYzYPV85m2DSYChHu3yrWqqQAvnLr3D2IUp9sc+mbD+6QCAdSliqh1ywVT
 KPfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1786363735; x=1786968535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qQpWbJttwi61w+33UaX9aual3LIjiZRDlQt6M32wCuQ=;
 b=oVuXl0fdTdEMySZp/12lUnr/urBzDsDJnG/6GuoHbjRbgSOGRicUHsKn9vH6BZcekt
 0rU79cFm5b27747mkBzjE8EPvi32jMrBCY/Vm9YIHVQQP6Gs2WJuPtaFzoaR+/CY1VDD
 SOMv/pLhbNMT1wGnvFRUTmeEAoOvd3oubRyWHOb+PCKhrLpQFZh1U814Z9MCMive3bLH
 M6t3Vj0BKHE8eFxz9hBwDoySwGlsBhYx4fErbDexQGMTmrdqSMffq+akyOXBJb8VNUNh
 RtrwnT+jv6TrUS9brtbIZtR9dgX1D1TN/M344Udcl0v13wcoBVO8rLAxFyIHNNGS+dDs
 av7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786363735; x=1786968535;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qQpWbJttwi61w+33UaX9aual3LIjiZRDlQt6M32wCuQ=;
 b=LBjy4dUU8nv+qEdni03ylG34xKgDKS2gAZtqLIOxAj2vljlu1pFOIFocBQHCeExjJ0
 AXje8GJmwq5SdjDN5ga2EHsTWgKJog8WHsgzZoOGbhzXbTg1s97o3+bktVARcBVarevm
 zVeahKy8/i3rOw4AhtHdnUlvp9ICLtr+jecTzOi+0fw1VXihjfZimomBMuNk8+PoVTV+
 udEVQIOK/z4bR+qTGuQM5WjuSRn5MQBHqraCil7va9mbSqyEX8OYdUvWO3XprpZW2c6a
 Fat2lRKC+5sT260E4k/GUWvfuiNP1jvTLB1ZeMDcmRVGJmdGipg9l2AY+mJ6toEOc+Y6
 zB+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBGUmid1FbV6x7Au7yXQpq//jQwr0IGW9VSniMId1kCgMUZ6MCNBzmE7bhLzFOJYyjBiqaeLb2Xh0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCUQ8YLyZj0K0e/rTqTspsJQgpdM9gLIPXx5lp0UbTFUek7BgZ
 PvPZwlbILJISXi7A77c0lpfmeyN+TmPAKgLEYc/IEO9UV09v2/7S9fQIBc/6fur2+OMA95yRs+R
 Vb9ANFHa5hdma88hQghaycqomgxoKUDdrThAWi17UWQ==
X-Gm-Gg: AR+sD13euEJI1Hi6Vte7wXkWVljH34q2vYMUY7pxCSvQrZBrIk5oJfnT61ZG9iVQGZa
 bOB1scu9UBJyLr+tv0yWIPpXlfW2Na8L6YyjwKbB4r+WvlwyUX6D/ZTetbcKFRchGBSlu0eOiq7
 5JwYPqPIuVWVGRQlLgCsai2ktkh/j+TxjFQAnq7Sf2Y+qgptrUjS+P9PSF+3ewPndPAeKVeoELX
 UWzYETI1be+45s8hroPDmNlaGwMYlihe51vjf6FsLEWmk1VMOG/C4DVXd8WxO6IfiKWCT0wQr2a
 qe2IZiTr8jwtKudMWMXVfCcZYo5+aSmZ7t3TKRui1xbd5fjWh5of0Yq/sv7HR0738nsHwkFMV4L
 o
X-Received: by 2002:a17:907:728b:b0:c1c:4858:251a with SMTP id
 a640c23a62f3a-c20c6782f60mr50310366b.8.1786363735166; Mon, 10 Aug 2026
 05:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20767137.geO5KgaWL5@diego>
In-Reply-To: <20767137.geO5KgaWL5@diego>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 10 Aug 2026 16:08:36 +0400
X-Gm-Features: AUfX_mzk8t-Db9KtlR_l-8Y27DWWGagvh3frNOmzayIZmNSq8DatjvUHckrxFLI
Message-ID: <CAKTNdwFPhVrjb4iVpN19f0Nw+MA_BxXLOLs4V50fuyf+_rbEPg@mail.gmail.com>
Subject: Re: [PATCH v11 00/21] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, Sashiko <sashiko-bot@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

Hi Heiko,

On Mon, Aug 10, 2026 at 3:49=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Hi Sebastian,
>
> Am Donnerstag, 6. August 2026, 19:02:06 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Sebastian Reichel:
> > This patch series updates the Synopsys Designware DisplayPort bridge
> > together with the only existing user: The Rockchip RK3576/RK3588:
> >
> >  1. Follow-up bridges (PHY, USB-C connector)
> >     This is needed to get USB-C DP AltMode working; I've followed
> >     the Qualcomm driver as reference
> >
> >  2. Runtime PM
> >     The initial driver has been upstreamed without RPM; add it to
> >     avoid wasting power when nothing is plugged
> >
> >  3. Audio
> >     The initial driver has been upstreamed without audio support;
> >     this adds all missing bits for audio with single stream transport
> >
> > To properly make use of the bridge code the following USBDP PHY series
> > is also needed:
> >
> > https://lore.kernel.org/all/20260714-rockchip-usbdp-cleanup-v13-0-6cb3e=
769d4c5@collabora.com/
>
> I've now had time to test both series (dw-dp + usbdp) :-)
>
> - On my 1080p display I get nice output
> - On my 4K display I get "some" output after increasing the ACLK_VOP to
>   750MHz - although the output itself is garbled. Before there was no
>   output at all

One more thing likely to go wrong on an otherwise unpatched kernel is
dclk. Could you please check what pixel clock your 4K display mode
wants? I bet it's not the 1188 MHz the default PLL configuration
provides.

When my colleagues and I tested a previous iteration of these on over
half a dozen Type-C monitors we could get our hands on, I had to patch
a whole bunch of PLL rates [1] into the table, and reparent the video
port clock driving the DP output to an otherwise unused system PLL
with fractional capability (VPLL in case of RK3576). I'm not yet
trying to upstream those rate changes though, because our prototype
board, which we were testing those on, had signal integrity issues on
two out of four DP pairs, so they need additional testing.

In my experience, any dclk more than 0.1% off the rate required by the
display mode is very likely to produce a blank screen on DP.

Garbled output sounds more like an artifact of an overclocked VOP2 though.

[1] https://github.com/flipperdevices/flipper-linux-kernel/commit/a4c8ce773=
b069672f0dd4ecb79711bc7d3319b38

Best regards,
Alexey
