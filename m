Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A8CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 12:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414CD10F0A6;
	Thu, 28 May 2026 12:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T3XmokJC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E529310F0A6
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:01:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 374C860123;
 Thu, 28 May 2026 12:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A0A1F000E9;
 Thu, 28 May 2026 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779969691;
 bh=41DrVZ4xS7vhXVEgxGgxSNJ1PMDaMkbDls2BuQg9ydM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=T3XmokJC8kLStgVwqlglA/5Bsw+rFxERoxPBiSoVO8bZIms8ozh4thDeTAyFwitst
 UIGIp0ohUitgCRsC8k7yEfP8GrI/6E6gYoxG0tE4qjW3eeeopRe2dLOlzgaBKPTSP7
 /tdsUmlrCPR61I7xb/S+Y65x5DzbnZgKdJpw7u2lYfmTjRzwNhe64OGGIg9Qs1bYCY
 gAgHkRIJAl5oJYfsVCjTubthS5zOj+vHtPu96WbgVk7NxNVxxy+GPrVbLirWbBasCQ
 u+sJwul5IiLAT0QbVvFx10KwnGbLHDxwVBOIx0/xjU5ErZMtTdX7Gs6bs5dRYFQRVT
 z5TRbnhQvHF5A==
Date: Thu, 28 May 2026 14:01:29 +0200
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
Message-ID: <20260528-solemn-chowchow-of-psychology-cc0ae4@houat>
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
 <20260527-flawless-chowchow-of-fruition-edbe8a@houat>
 <496facc4-60bc-4646-b426-30e7ac545d9f@oss.qualcomm.com>
 <20260527-armored-spiked-jacamar-0bb19e@houat>
 <4f34c957-817d-45fe-ac13-02b98e77f010@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ojuvfkqckxhkyq4k"
Content-Disposition: inline
In-Reply-To: <4f34c957-817d-45fe-ac13-02b98e77f010@oss.qualcomm.com>
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


--ojuvfkqckxhkyq4k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
MIME-Version: 1.0

On Wed, May 27, 2026 at 05:09:39PM +0200, Hans de Goede wrote:
> Hi Maxime,
>=20
> On 27-May-26 14:48, Maxime Ripard wrote:
> > On Wed, May 27, 2026 at 02:21:50PM +0200, Hans de Goede wrote:
> >>>> clk_prepare_enable() is fine, the clocks are already on so no
> >>>> ordering worries and it ensures that the clocks and their parents ca=
nnot
> >>>> get turned off by incrementing their enable, prepare and protect cou=
nts.
> >>>>
> >>>> clk_disable_unprepare() is a problem though since it actually turns =
the
> >>>> clocks off. Instead something is needed which only decrements those =
counts.
> >>>>
> >>>> This series introduces a new clk-core function called
> >>>> __clk_disable_unprepare_counts_only() (1) which does just that. Pref=
ixed
> >>>> with '__' to indicate that normally drivers should not use this.
> >>>>
> >>>> Michael, Stephen sorry for needing to add a new clk-core function fo=
r this,
> >>>> but I see no other way of solving this (2)(3). The changes are not t=
hat
> >>>> big / not too bad.
> >>>>
> >>>> I've also considered making __clk_disable_unprepare_counts_only() im=
plement
> >>>> all the logic itself instead of adding the extra parameter to
> >>>> clk_core_unprepare() and clk_core_disable() but that leads in duplic=
ating
> >>>> quite a bit of logic (4) so this seems better.
> >>>>
> >>>> The other 2 patches just replace the clk_disable_unprepare() calls in
> >>>> the simple[fb|drm] driver with the new helper.
> >>>>
> >>>> This series fixes the display not coming up after switching to the m=
sm
> >>>> driver when a simple-framebuffer node with clocks listed is used.
> >>>>
> >>>> 1) I'm open to changing the name, this is the best I could come up w=
ith.
> >>>>
> >>>> 2) One option considered was detaching the simple-framebuffer driver=
 later,
> >>>>    after the real display driver has had a chance to claim the clock=
s. But
> >>>>    this won't work in cases where the real display driver picks diff=
erent
> >>>>    parent clocks then the boot firmware did and needs to reparent cl=
ocks.
> >>>>
> >>>>    Basically the goal is for things to behave as if the simple-frame=
buffer
> >>>>    driver was not there at all, because that leaves the hw in the st=
ate
> >>>>    the real display driver expects.
> >>>
> >>> So I know it's not really what you had in mind, but if you are only
> >>> concerned about the transition from the bootloader to the DRM driver,
> >>> then I think supporting the following work would help:
> >>>
> >>> https://lore.kernel.org/r/20260423-drm-state-readout-v2-0-8549f87cb97=
8@kernel.org
> >>>
> >>> With that series, we can build the initial KMS state from the hardware
> >>> state, which means that if you were to change the resolution at boot,=
 it
> >>> would be executed just like any mode change in KMS.
> >>
> >> Hmm, so your suggestion would be to have the initial KMS driver probe()
> >> only do a read back without touching anything. Then claim clks matching
> >> the read back config and then only release the simple* driver and thus
> >> the clocks after this?
> >=20
> > Almost. Part of the call to drm_mode_config_create_initial_state() if
> > needed to make it grab its resources. See atomic_install_state in that
> > series. So probe wouldn't have anything more to do.
> >=20
> >> That is certainly an interesting proposal but IMHO almost orthogonal
> >> to this one (1).
> >=20
> > Why do you think it's orthogonal?
> > It would completely fix your problem.
>=20
> AFAICT in its current version it does not contain a mechanism to
> delay the remove conflicting framebuffer call, so no it does not
> fix my problem.

The conflicting framebuffer is removed by drivers through an explicit
call to aperture_remove_all_conflicting_devices(). Just move that call
after the call to drm_mode_config_create_initial_state, there's nothing
to integrate.

> >> Even if it may fix the issue in the end, it seems that that work is
> >> still quite a way from going upstream
> >=20
> > It's likely to be merged in the next few weeks.
> >=20
> >> and even then initially it only potentially fixes this for the TIDSS
> >> driver since that solution needs a lot of per driver work.
> >=20
> > I mean, yeah, but the good thing is that you only have one driver to
> > care about, right?
>=20
> I would prefer my proposed KISS solution, which works everywhere, over
> your quite complex solution which requires complex per driver changes.
>=20
> When I was still working on:
>=20
> https://fedoraproject.org/wiki/Changes/FlickerFreeBoot
>=20
> I needed to constantly fix i915 fastset support and when I stopped
> fixing it due to -ENOTIME it pretty much was broken most of the time.
>=20
> Last time I check modern (Alderlake +) laptops never had working
> fastset support and there always is a visible most set on newer
> laptop models because of this.
>=20
> This state-readback stuff is quite complicated, as the list of
> known issues in your cover-letter shows.

It's kind of a bad faith argument. This list is 4 issues. One is getting
fixed in the next version, the other two are specific to tidss which you
don't care about.

> I wish you all the best with it, but I really do not see this as a
> good alternative for fixing the issues *this* series tries to address
> given the huge disparity in complexity between the 2 fixes.
>=20
> I'm also worried that the readback stuff is likely going to be fragile
> so might end up being disabled or automatically detect some issue and
> disable itself at which point we're back to having the original
> problem this series tries to fix.
>=20
> Also atm AFAIK there are no plans to add state readback support to
> msm and there are a lot of other higher priority items to work on.
>=20
> ###
>=20
> Anyways since your patch-series will not work for msm in its
> current state, I would still very much like to hear from the clock
> maintainers what they think of the approach suggested here.

I really don't get this argument either. Sure, it doesn't work for msm.
But the clock framework didn't have that unsafe function call either,
and yet you did the work to add it.

Maxime

--ojuvfkqckxhkyq4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCahgukgAKCRAnX84Zoj2+
dmPbAX9kzaVNfopFtItZV7bN6W6OTPHb5TksLkDo8ZT/Mn1fLV3o+Tpco8mLqNLr
KfJSRvoBf35JDMX2p9pZNDE+xIK8FSS13TguR1SqQA70p96NkUhuEXNLwold4Y2/
bqsqrKK8HA==
=mMoe
-----END PGP SIGNATURE-----

--ojuvfkqckxhkyq4k--
