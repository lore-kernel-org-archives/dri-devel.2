Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ECDCCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6DF1127B7;
	Fri, 16 Oct 2026 11:46:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DE91127B7
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=0xf9aqDEB2ABb/PUaNcWQ+D8Pgss+XS8jNScelABQvc=; b=wwlo6iHZCJAUeOFDpzHHQ37CHT
 utNFt53Nbnz0vB2LQNSwuV/fzBTLIPmlwPr27mVmZtCgNk7RFhO0D04ecYNRAm4kzay40ZdjONpWT
 dmczjPfCoRQyFOgQOAjBKBvLS1rfmbGDeNBoCKDdXO1gpKgJi37q10cwwDM+PbdTpCUu2t0ZBc88d
 UFEVQH2YhPy6Bh5NiHTKoYk2HYdfMpLozrAewFwbOIrP1AOih195/PUXsiX/MJxkQWV06igSTa0o5
 eVkaYULwETuyawXTNcJx8nErl6dbn1xtJBjy+kmj97tO9cA+gKq7URZWaEPjtjP6UV/Z2uvowyXt/
 KtMysznQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Huseyin BIYIK <boogiepop@gmx.com>, Johan Jonker <jbx6244@yandex.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm: devm_drm_bridge_alloc() conversion and cleanup
Date: Fri, 16 Oct 2026 13:45:22 +0200
Message-ID: <2372538.iZASKD2KPV@diego>
In-Reply-To: <d1f0369c-ff43-4b76-9092-5c638b132f15@yandex.com>
References: <20261001-bridge-alloc-conv-v1-0-f0a1fe040a86@collabora.com>
 <179213353665.3058528.14437637653539699061.b4-ty@b4>
 <d1f0369c-ff43-4b76-9092-5c638b132f15@yandex.com>
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

Hi Johan,

Am Freitag, 16. Oktober 2026, 10:11:19 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Johan Jonker:
> If any decency or Code of Conduct left in the DRM group then also credit =
the original author.
> Also remove driver_private.

after letting that stew in my mind over a lunch break:

=2D yes, your patch was earlier
=2D yes, I should've gotten around to it earlier - I am sorry about that
=2D so yes, this got mishandled

Nevertheless, this in no way justifies attacking the "drm-group", which
consists of a big number of individuals (most of which had no contact with
either variant of the patch at all) on a personal level :-( .

The change itself of moving to devm_drm_bridge_alloc, also is somewhat
straight-forward  that two different people could easily just create the
same change separately, as we saw here.


Heiko


> =3D=3D=3D
>=20
> [PATCH v3] drm/rockchip: rk3066_hdmi: convert to devm_drm_bridge_alloc() =
API
> https://lore.kernel.org/linux-rockchip/20260904-drm-v3-1-5b36532a3b72@gma=
il.com/ =20
>=20
> [PATCH v2] drm/rockchip: rk3066_hdmi: convert to devm_drm_bridge_alloc() =
API
> https://lore.kernel.org/linux-rockchip/20260824-drm-v2-1-7f9273c6020b@gma=
il.com/
>=20
> https://lore.kernel.org/linux-rockchip/dea8a038-577b-45da-bff3-703e9099b7=
e1@gmail.com/
> [PATCH v1] drm/rockchip: rk3066_hdmi: convert to devm_drm_bridge_alloc() =
API
>=20
> On 10/16/26 08:52, Luca Ceresoli wrote:
> >=20
> > On Thu, 01 Oct 2026 11:25:10 +0300, Cristian Ciocaltea wrote:
> >> Bridge drivers are expected to allocate their private data via
> >> devm_drm_bridge_alloc(), which also initializes the embedded struct
> >> drm_bridge, including its funcs pointer.  Most drivers were converted =
by
> >> commit 9c399719cfb9 ("drm: convert many bridge drivers from
> >> devm_kzalloc() to devm_drm_bridge_alloc() API"), but a couple of
> >> leftovers remain.
> >>
> >> [...]
> >=20
> > Applied, thanks!
> >=20
> > [1/2] drm/rockchip: rk3066_hdmi: Convert to devm_drm_bridge_alloc() API
> >       commit: 5c0cdbee4fa4a621f871d6dc825e759db08a1a4a
> > [2/2] drm/bridge: lontium-lt8713sx: Drop redundant bridge funcs assignm=
ent
> >       commit: 382c1e8ba409d1611cd256dccebdfa828c832bb1
> >=20
> > Best regards,
>=20
>=20




