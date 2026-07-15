Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BBEC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F179710E4C7;
	Wed, 15 Jul 2026 19:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="zb9QXW1X";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4F110E23B
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=hL1GS79qzyM0ipi8jemKvD9nfesfcOl399h19NOhaM8=; b=zb9QXW1XMG4YfPtNV3RG+62Zmd
 v8UvwL/ktHs4FtJ/TP0zlhZleTu7M3ckwlhFjD4fw+uytYiKG7LFVdi6L8rfGJpoUn9NXkCz66pN8
 /qJeCo+4hjVSn+09UJwGZkBRxCikUAhVFdv/Y9jHZhsRA7jr9+/oTwWrn4fM7+AzWXr5cTmo4EQlr
 fPpdq9Hyo1NSmaiNWEznadQPhH77OjmmymXNzamcUS3zD+zTNqb3owWxhn+mkg5Tv/Pndg4MN0jc+
 XA/8uJNplYQGHCcxu061mq29I4T0soEHVGDgIqoMeWlNxc6tMpWJkAUf+VeOvTW/IHgHRScOlzpOk
 uLO0XDIg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, yubing.zhang@rock-chips.com
Subject: Re: [PATCH v3 08/10] drm/rockchip: dw_dp: Add runtime PM support
Date: Wed, 15 Jul 2026 21:30:27 +0200
Message-ID: <2301403.NgBsaNRSFp@phil>
In-Reply-To: <alfV1691ZgZ6KylX@venus>
References: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
 <CANbgqATR-V0rRGfzj0hdJ2hsJex-iWzHMwD1L4vavTi2Jd79Kw@mail.gmail.com>
 <alfV1691ZgZ6KylX@venus>
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

Am Mittwoch, 15. Juli 2026, 21:00:12 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Sebastian Reichel:
> Hello Andy,
>=20
> On Tue, Jul 14, 2026 at 06:08:06PM +0800, Andy Yan wrote:
> > > @@ -58,6 +59,8 @@ static void dw_dp_rockchip_hpd_sw_sel(void *data, b=
ool
> > > force_hpd_from_sw)
> > >
> > >         dp->hpd_sel =3D force_hpd_from_sw;
> > >
> > > +       ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> >=20
> > This can triger  HPD irq for USB-C DP AltMode, but for a standard
> > DP port, this is no way to acquire runtime, so there will no irq
> > when plug in.
>=20
> Right. I don't have any RK3588 or RK3576 system exposing a DP
> connector directly. This this is non-trivial to test for me :/
>=20
> I see the following options:
>=20
> 1. Only enable runtime PM when running in USB-C mode
> 2. Mux the HPD pin as GPIO to support waking up with the controller
>    being suspended; either remux when the controller is awake or use
>    the same mechanism as USB-C to do software based HPD on top of the
>    GPIO (which would allow using any GPIO as HPD).
> 3. Have a poll function, which wakes up the controller regularly to
>    check the status
>=20
> I consider going for option 1 for now, which allows option 2 to be
> implemented as a follow up. Mostly to avoid that the series becomes
> as big and messy as the USBDP PHY series became.

I'd agree with that solution.
I think we can all agree that option 3 is baaaad :-) .

So with 1, functionality keeps working, and then someone can put the
special HPD handling on top later - the Rock-5-ITX does expose the DP1
(on a hdmi port)


Heiko


