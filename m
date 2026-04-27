Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328B1FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8177810E0BF;
	Mon, 27 Apr 2026 19:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="VaiZ0EuM";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DB110E0BF
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 19:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Rb4LC4RoKjMwkAoMYkZMORsdxxUBkkBcuhhkQcQ9qHU=; b=VaiZ0EuMs/V/UpaUqhIxQT4kOQ
 m2fmNRxLnBGy786PBF2Z0XkvBMAdhyEjrVoKui6GQ8giNSHAgxOJ65AnNm08rjG9ZcemAVGmlbYo/
 x0vLZwJUF06BH6iWuyebP6piC19SdZ3GLQlXRGSEATGAP7cM7uguCYD7l8bg82hup8QcS5AT6NLAK
 O1rudfGXB/blSVVheseL8grFMm70H+C1ElnAg1J4VOHI1ueOm2U+FYROlQkL8Vzg77Rlg4y8VwKlq
 IekUEQ9uAOQ5SFiBYkhiDulThCYOT1lPRHpbX2efjvngHBt09pilTEDB+hXdcnKs1SbNOdXWus5zo
 4MNyAfbg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v5 05/10] drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC
 scrambling and high TMDS clock ratio support
Date: Mon, 27 Apr 2026 21:09:09 +0200
Message-ID: <890451008.0ifERbkFSE@phil>
In-Reply-To: <d3b5239b-e3d9-4d81-9220-d6057d670ff3@collabora.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <3826043.PYKUYFuaPT@phil>
 <d3b5239b-e3d9-4d81-9220-d6057d670ff3@collabora.com>
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

Am Montag, 27. April 2026, 18:39:44 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Cristian Ciocaltea:
> Hello Heiko,
>=20
> Thanks for the quick reviews!
>=20
> On 4/27/26 1:49 PM, Heiko Stuebner wrote:
> > Am Sonntag, 26. April 2026, 02:20:17 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Cristian Ciocaltea:
> >> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) by adding SCDC management
> >> for the high TMDS clock ratio and scrambling, required when the TMDS
> >> character rate exceeds the 340 MHz HDMI 1.4b limit.
> >>
> >> A periodic work item monitors the sink's scrambling status to recover
> >> from sink-side resets.  On hotplug detect, if SCDC scrambling state is
> >> out of sync with the driver, trigger a CRTC reset to re-establish the
> >> link.
> >>
> >> Reject modes requiring TMDS rates above 600 MHz, as those fall in the
> >> HDMI 2.1 FRL domain which is not supported. In no_hpd configurations,
> >> further restrict to 340 MHz since SCDC requires a connected sink.
> >>
> >> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
> >> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 188 ++++++++++++++++++=
++++++---
> >>  1 file changed, 172 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gp=
u/drm/bridge/synopsys/dw-hdmi-qp.c
> >> index d649a1cf07f5..c482a8e7da25 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> >> @@ -2,6 +2,7 @@
> >>  /*
> >>   * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
> >>   * Copyright (c) 2024 Collabora Ltd.
> >> + * Copyright (c) 2025 Amazon.com, Inc. or its affiliates.
> >=20
> > I have no real clue about the inner workings of hdmi, but that line
> > does make me curious, because no part of the patch authorship does
> > mention Amazon ;-) .
>=20
> That was intentional: although the code was written by Collabora, the cop=
yright
> belongs to Amazon.

They selected a nice chip then :-D


> > Also I think "or it's affiliates" might be way too broad, because this
> > can be essentially everyone. So noone in the future will know who to
> > ask on copyright questions.
> >=20
> > Similarly when _somebody_ comes forward with "I hold a copyright on thi=
s"
> > no-one could verify this claim as well.
> >=20
> > I somehow expect _one_ entity being specified, not possibly hundreds.
>=20
> Hmm, I followed the wording already used elsewhere in the kernel tree:
>=20
> $ git grep 'Copyright.*Amazon.*affiliates' | wc -l
> 93
>=20
> There appears to be only a single instance that omits =E2=80=9Caffiliates=
=E2=80=9D:
>=20
> $ git grep 'Copyright.*Amazon' | grep -v affiliates
> drivers/power/supply/max14656_charger_detector.c: * Copyright (C) Amazon =
Technologies Inc. All rights reserved.
>=20
> Which was added nearly ten years ago, so I=E2=80=99m not sure it makes se=
nse to adopt
> that form now.
>=20
> Actually, this seems to be fairly common among other vendors as well:
>=20
> $ git grep 'Copyright.*affiliates' | wc -l
> 1014

okay then ... if that is already used a lot, and nobody else complained
then it should be fine I guess :-) .

It just sounded strange to me when reading that earlier.


Thanks a lot for digging those stats up
Heiko


