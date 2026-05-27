Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92749CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 12:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6C910E7B1;
	Wed, 27 May 2026 12:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Aeva639t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDD710E7B1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:48:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7FF6600BB;
 Wed, 27 May 2026 12:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34AA1F000E9;
 Wed, 27 May 2026 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779886111;
 bh=LeF8K1xqorIXJChfv3Pk+hYMvvkdRA8TxlyqfuR9Qp0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Aeva639tIDZSmxsPM9nT6oAFbfyTXXiigvfj/oVj9B72igEU7hm3KO7Uhh4tsVOQ4
 Pq+r1rpeBjXw8GKIuNybJ2P66gyLEAi5tk7pYgLwLRqPOeea4F8+Mzl3l4LXRIcYNB
 zJ8vzxSaMFt7NolsYEi9FuFPCXfW5R+L+GPCuBU9MqTuBZfgQiSmB7nZeR65XN7H+V
 uUnAJl7aAH4S+aUqApP8CJ7Wp0Z2T3Ycobpg3HeWFVlfabR87sLHVZzxBvoXQeaMYg
 h8M7oNpDQ1hZF8aeq+vBC7XcWRnaVJr+zY6D8teYG5Z3omPFW48/CmLnUhB4xsgthD
 ThSmebN02rMbw==
Date: Wed, 27 May 2026 14:48:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
Message-ID: <20260527-armored-spiked-jacamar-0bb19e@houat>
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
 <20260527-flawless-chowchow-of-fruition-edbe8a@houat>
 <496facc4-60bc-4646-b426-30e7ac545d9f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ymi3fo6ezsefbz5n"
Content-Disposition: inline
In-Reply-To: <496facc4-60bc-4646-b426-30e7ac545d9f@oss.qualcomm.com>
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


--ymi3fo6ezsefbz5n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
MIME-Version: 1.0

On Wed, May 27, 2026 at 02:21:50PM +0200, Hans de Goede wrote:
> >> clk_prepare_enable() is fine, the clocks are already on so no
> >> ordering worries and it ensures that the clocks and their parents cann=
ot
> >> get turned off by incrementing their enable, prepare and protect count=
s.
> >>
> >> clk_disable_unprepare() is a problem though since it actually turns the
> >> clocks off. Instead something is needed which only decrements those co=
unts.
> >>
> >> This series introduces a new clk-core function called
> >> __clk_disable_unprepare_counts_only() (1) which does just that. Prefix=
ed
> >> with '__' to indicate that normally drivers should not use this.
> >>
> >> Michael, Stephen sorry for needing to add a new clk-core function for =
this,
> >> but I see no other way of solving this (2)(3). The changes are not that
> >> big / not too bad.
> >>
> >> I've also considered making __clk_disable_unprepare_counts_only() impl=
ement
> >> all the logic itself instead of adding the extra parameter to
> >> clk_core_unprepare() and clk_core_disable() but that leads in duplicat=
ing
> >> quite a bit of logic (4) so this seems better.
> >>
> >> The other 2 patches just replace the clk_disable_unprepare() calls in
> >> the simple[fb|drm] driver with the new helper.
> >>
> >> This series fixes the display not coming up after switching to the msm
> >> driver when a simple-framebuffer node with clocks listed is used.
> >>
> >> 1) I'm open to changing the name, this is the best I could come up wit=
h.
> >>
> >> 2) One option considered was detaching the simple-framebuffer driver l=
ater,
> >>    after the real display driver has had a chance to claim the clocks.=
 But
> >>    this won't work in cases where the real display driver picks differ=
ent
> >>    parent clocks then the boot firmware did and needs to reparent cloc=
ks.
> >>
> >>    Basically the goal is for things to behave as if the simple-framebu=
ffer
> >>    driver was not there at all, because that leaves the hw in the state
> >>    the real display driver expects.
> >=20
> > So I know it's not really what you had in mind, but if you are only
> > concerned about the transition from the bootloader to the DRM driver,
> > then I think supporting the following work would help:
> >=20
> > https://lore.kernel.org/r/20260423-drm-state-readout-v2-0-8549f87cb978@=
kernel.org
> >=20
> > With that series, we can build the initial KMS state from the hardware
> > state, which means that if you were to change the resolution at boot, it
> > would be executed just like any mode change in KMS.
>=20
> Hmm, so your suggestion would be to have the initial KMS driver probe()
> only do a read back without touching anything. Then claim clks matching
> the read back config and then only release the simple* driver and thus
> the clocks after this?

Almost. Part of the call to drm_mode_config_create_initial_state() if
needed to make it grab its resources. See atomic_install_state in that
series. So probe wouldn't have anything more to do.

> That is certainly an interesting proposal but IMHO almost orthogonal
> to this one (1).

Why do you think it's orthogonal? It would completely fix your problem.

> Even if it may fix the issue in the end, it seems that that work is
> still quite a way from going upstream

It's likely to be merged in the next few weeks.

> and even then initially it only potentially fixes this for the TIDSS
> driver since that solution needs a lot of per driver work.

I mean, yeah, but the good thing is that you only have one driver to
care about, right?

> Where as my proposed fix here is much simpler and fixes the issue
> for all drivers in one go.

At the expense of exposing an unsafe function for only a single user and
usecase.

Maxime

--ymi3fo6ezsefbz5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCahboHAAKCRAnX84Zoj2+
dtx3AYDjU1eNIR6nWTN4Gf6INqlGbmMEfGww4g/lSNuzj96nTz3Tqr+gM6X6h4U0
77KX96EBf29d4m+QaVyOV2L9+B0CxJ778OJtF9REEDQuHYeIH6ZdbKdS+tDqXnNm
PiggXzVJFg==
=OCZ7
-----END PGP SIGNATURE-----

--ymi3fo6ezsefbz5n--
