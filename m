Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6795EC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C4789613;
	Mon, 17 Aug 2026 07:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BAG8YZ9T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46196898F0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:27:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E47F600AE;
 Mon, 17 Aug 2026 07:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F101F000E9;
 Mon, 17 Aug 2026 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786951623;
 bh=sWuJzYTV6+aCAtr11d8N7ZjT/WOZ3Cg9QHdseH39gl8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BAG8YZ9T8tuUssFTi2ulRx6xrLDcC9ni/b8hH34swERrV6HGJeB5d22blczHOtgvG
 eM53ZsesMfQYD3wSSGGq0edFgf7MGiYL46wE2ubQ1yx8RTEKsHW43eMAP25S/aoviJ
 LPlLbR8VaRwU3zsGIufGFbLZqvwBmNC5WyU6NOqnh+3x6cVI/i+5bxeT1eSF2vVfXa
 l3oEecAgubWIo5TvffNJkRJP2Je1Znm7dZQU7qPevgVJtlz//cCQvpePk40fhgQIfa
 C5J/3VnXJKFqDemZ3JQCpCch6hF2ZP/ZLYrBlMvgunKDvd470t1xoUDa/hfFV3a+g1
 X6uGCn/E+TUIA==
Date: Mon, 17 Aug 2026 09:27:00 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Yashas D <y-d@ti.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 u-kumar1@ti.com, 
 devarsht@ti.com, s-jain1@ti.com, d-mittal@ti.com, b-padhi@ti.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: retrain DP link directly
 on cable replug
Message-ID: <20260817-enlightened-dodo-of-satiation-cfd4b0@houat>
References: <20260814120304.887993-1-y-d@ti.com>
 <20260814120304.887993-3-y-d@ti.com>
 <CAD=FV=XVoWvfD33Y16UOMZsz_fsOpnxeGK0izEKc-iCbR++J2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="3gyq6cf45szc6omf"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XVoWvfD33Y16UOMZsz_fsOpnxeGK0izEKc-iCbR++J2g@mail.gmail.com>
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


--3gyq6cf45szc6omf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: retrain DP link directly
 on cable replug
MIME-Version: 1.0

On Fri, Aug 14, 2026 at 10:14:42AM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Fri, Aug 14, 2026 at 5:04=E2=80=AFAM Yashas D <y-d@ti.com> wrote:
> >
> > When a cable is replugged while the upstream display pipeline is still
> > active (e.g. a compositor holds the CRTC), the bridge can retrain the
> > DP link and re-enable the video stream directly from the HPD interrupt
> > work handler without requiring a full DRM atomic commit. This allows
> > applications to recover display output after a cable replug.
> >
> > Signed-off-by: Yashas D <y-d@ti.com>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 215 +++++++++++++++++++++-----
> >  1 file changed, 179 insertions(+), 36 deletions(-)
>=20
> There's a lot of code here and Sashiko has a bunch of feedback [1].
> I'm not personally very familiar with the HPD flows. I'll probably
> skip reviewing this until Sashiko is reasonably happy or until you
> explain why Sashiko is confused.
>=20
> FWIW, just from the patch description, I'd also question if this is
> really a good idea. If we get an unplug / replug, we could get an
> entirely new display plugged in. This is really something that's OK
> without needing to handle things?

The expectation is that the output should remain the same unless
userspace decides on a modeset. So, we should send the hotplug event,
and reenable the output as is.

I'm not sure if there's only link-training in DP's case, but for HDMI we
have a similar issue with the scrambling setup that gets reset by the
unplug/replug cycle.

The easier thing to do in that case is to create a new empty commit and
disable/enable the whole display chain starting with the CRTC, since it
doesn't create a new path to test. We have
drm_atomic_helper_reset_crtc() and drm_bridge_helper_reset_crtc() to do
just that.

Maxime

--3gyq6cf45szc6omf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaoK3vQAKCRAnX84Zoj2+
dgJVAYCXyD3EbL2Ke5uPexdVLW+Ir0JVuebL8p76DncL8N701PQwZlWxjLk0kor9
bJkEyYgBf1UbZlcQrXwLIA0yeoIC21+XFDwFkFWvs62b7/mSbtDtDqg/lfebMMCl
0qc6DjHCEw==
=FvpB
-----END PGP SIGNATURE-----

--3gyq6cf45szc6omf--
