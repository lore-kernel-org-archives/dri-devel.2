Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252A6C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3915110E538;
	Thu,  3 Sep 2026 21:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="rHE/PaMW";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB9810E538
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Jn4fU7y77lECs7I6hTxfYjF0J9XYYojKqt6y7PNxEWI=; b=rHE/PaMWwEQJHJqpiFRbjAmxov
 H82kIeKRs6/bXHDWJZNT8gfDziefluhXSWk/oBJu/qlFwhCD18Nh3jpgb1kEi3igslJvIgl1cVTk7
 k6xcPxk3f5gGof/gUfxFZanoLSh3VrFmtnqabn2OiJU17+yWOjWEWXQCJzz1YHRtZ5qp3riHreGUR
 8ZN0ET0Xg6UWBWpKSjcmvW+Y0SfufXtWdVP+Ii/P3x6FlRnQuwKECbRrqu3Z0o/cljfeES/ZLghaM
 kx5hpxb3paAjFaq4DWpgMgIamX8cTLBzKYtnJNsCeQVBmsfi5qdrutLeYpQliXhI+HmjGSsnNPHBW
 /li1+feA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Johan Jonker <jbx6244@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?SMO8c2V5aW4=?= BIYIK <boogiepop@gmx.com>
Subject: Re: [PATCH v2] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
Date: Thu, 03 Sep 2026 23:09:38 +0200
Message-ID: <4592222.hdfAi7Kttb@diego>
In-Reply-To: <afde7cfa-bd1e-40d2-9315-d3d88abb7606@gmail.com>
References: <20260824-drm-v2-1-7f9273c6020b@gmail.com>
 <2814844.6tgchFWduM@diego>
 <afde7cfa-bd1e-40d2-9315-d3d88abb7606@gmail.com>
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

Am Donnerstag, 3. September 2026, 22:44:57 Mitteleurop=C3=A4ische Sommerzei=
t schrieb Johan Jonker:
> On 9/3/26 17:12, Heiko St=C3=BCbner wrote:
> > Am Montag, 24. August 2026, 12:21:19 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Johan Jonker via B4 Relay:
> >> From: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
> >>
> >> The function devm_drm_bridge_alloc() is the new API for allocating DRM=
 bridges.
> >> This conversion was missed during the initial conversion of all bridge=
s to
> >> the new API.
> >>
> >> Signed-off-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>  drivers/gpu/drm/rockchip/rk3066_hdmi.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/=
rockchip/rk3066_hdmi.c
> >> index f28d6a883e09..39c65ee07caa 100644
> >> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> >> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> >> @@ -703,7 +703,6 @@ rk3066_hdmi_register(struct drm_device *drm, struc=
t rk3066_hdmi *hdmi)
> >>  			 DRM_MODE_ENCODER_TMDS, NULL);
> >> =20
>=20
> >>  	hdmi->bridge.driver_private =3D hdmi;
>=20
> Can this be removed?
> See link/comment below.

that is what I meant. bridge.container holds the same information and
bridge.private_data is not used in the rk3066_hdmi driver at all.

So if some future function needs to access the struct rk3066_hdmi it can
do so via the container field.


> and hdmi->bridge.funcs are redundant by this change?
>=20
> Not redundant, just funcs are attached in a common function __devm_drm_br=
idge_alloc()

that's exactly wat I meant. As they are attached already in the common
function, there is no need to do it _again_ in rk3066_hdmi_register()

>=20
> Please advise what changes are needed?
> RK3066_hdmi is broken since somewhere 2025-05.

So both should be dropped.

Heiko


