Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33541CDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772E710E37F;
	Fri, 26 Jun 2026 12:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NiiKt4F+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D20A10E399
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:46:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03AE3436B3;
 Fri, 26 Jun 2026 12:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638C01F000E9;
 Fri, 26 Jun 2026 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782478003;
 bh=fP2BM5siPysCREjfmNXTR/AxtHEbdVc8M5zdwdMP+mk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NiiKt4F+FD/xr4ICI51VvWflhjUH201ZGxa4dXz5iiGpggTXlyRUeAEBpU4bFkG7h
 Y16rYAzZyT3r6wXl83K3BfFQY3el38xkXteaSudkhkQSUreTxcwg6rm8vjncEdNT9b
 6pd4eR1ofgNdscUQ2uGqwoaQSWZWXgwZdYvXLFJ+/QxJLoaYL+dPAGeAw18D/J8q4f
 emR3NPxczJIXQFq4eRJjgQ71hNBq5nNHsXADJdHso6mcdeDGahZ4MyqhMVFMOlcHnC
 aSrUG8rOJBFeY+EpwxrZVdaDXdsB30aB8cnpEZTQER8/k1ChsAYecSMAnrfeDn5giZ
 aA8Zh1BOaXgCQ==
Date: Fri, 26 Jun 2026 14:46:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Brian Masney <bmasney@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Helge Deller <deller@gmx.de>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
Message-ID: <20260626-elegant-remarkable-chipmunk-31dbed@houat>
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
 <ahd4XgTo3KZqGS9M@redhat.com>
 <66a76d9f-fe04-4a72-b6fe-42c2922fe9d9@oss.qualcomm.com>
 <20260528-sloth-of-delightful-chaos-1f02dc@houat>
 <4b09bd91-9a08-407a-9b01-216dd4d7aae0@oss.qualcomm.com>
 <20260624-ultramarine-beetle-of-vastness-acd51e@houat>
 <7c91795c-f8bf-429b-b588-f7e96d97b1a1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="by3ip33exiefhb24"
Content-Disposition: inline
In-Reply-To: <7c91795c-f8bf-429b-b588-f7e96d97b1a1@oss.qualcomm.com>
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


--by3ip33exiefhb24
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
MIME-Version: 1.0

On Wed, Jun 24, 2026 at 11:06:49AM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 24-Jun-26 10:53, Maxime Ripard wrote:
> > On Thu, May 28, 2026 at 03:02:09PM +0200, Hans de Goede wrote:
> >> On 28-May-26 2:08 PM, Maxime Ripard wrote:
> >>> On Thu, May 28, 2026 at 12:12:10PM +0200, Hans de Goede wrote:
> >>>> Hi Brian,
> >>>>
> >>>> On 28-May-26 1:03 AM, Brian Masney wrote:
> >>>>> Hi Hans,
> >>>>>
> >>>>> On Wed, May 27, 2026 at 11:48:08AM +0200, Hans de Goede wrote:
> >>>>>> 2) One option considered was detaching the simple-framebuffer driv=
er later,
> >>>>>>    after the real display driver has had a chance to claim the clo=
cks. But
> >>>>>>    this won't work in cases where the real display driver picks di=
fferent
> >>>>>>    parent clocks then the boot firmware did and needs to reparent =
clocks.
> >>>>>
> >>>>> Why won't that work in the case where different parent clocks are s=
elected?
> >>>>> I'll describe a scenario below.
> >>>>>
> >>>>>>
> >>>>>>    Basically the goal is for things to behave as if the simple-fra=
mebuffer
> >>>>>>    driver was not there at all, because that leaves the hw in the =
state
> >>>>>>    the real display driver expects.
> >>>>>
> >>>>> I think the deferred unbinding could have some potential here where
> >>>>> there is some kind of notification mechanism between simple-framebu=
ffer
> >>>>> and the real drm driver. So:
> >>>>>
> >>>>> - simple-framebuffer driver takes reference(s) to the clk(s).
> >>>>>
> >>>>> - real drm driver eventually loads, takes reference(s) to the neces=
sary
> >>>>>   clk(s).
> >>>>>
> >>>>> - real drm driver sends a notification to simple-framebuffer that i=
t's
> >>>>>   done, and has control.
> >>>>>
> >>>>> - simple-framebuffer can unbind and release its references to the c=
lks.
> >>>>>
> >>>>> No clks will be shutdown prematurely in this scenario.
> >>>>>
> >>>>> If the real drm driver needs a different parent, then presumably th=
ings
> >>>>> should be setup correctly, and simple-framebuffer can have the cloc=
ks
> >>>>> shut down when it calls clk_disable_unprepare().
> >>>>
> >>>> If the real drm driver needs a different parent, then how does it
> >>>> do the reparenting while the simple-framebuffer driver is holding
> >>>> a reference to the clock ?  In that case the clock might have
> >>>> a protected_count of non 0 (depends on the core-clk flags) and
> >>>> reparenting won't work.
> >>>
> >>> The only case where it should reparent you listed was that you might
> >>> need to pick up a different resolution. However, that can only be
> >>> enforced by an ioctl or a client.
> >>>
> >>> simplefb/drm is removed in msm_drm_kms_init. The device is published
> >>> drm_dev_register called right after msm_drm_kms_init, and the clients
> >>> are registered in msm_drm_kms_post_init, called after drm_dev_registe=
r.
> >>>
> >>> There's no way in the current msm architecture to have a modeset happ=
en
> >>> while the simpledrm driver is still active.
> >>
> >> Ok, new plan, please let me know what you think about this:
> >>
> >> 1. Add a new "disable" callback argument to
> >> devm_aperture_acquire_for_platform_device() and store this in
> >> struct aperture_range
> >>
> >> 2. Add a new aperture_disable_conflicting_devices() which
> >> calls the disable callback for matching devices.
> >>
> >> 3. Have the simple[fd|drm] drivers implement a disable callback
> >> which unregisters the drm dev and releases any claims on the
> >> aperture mem-region, while keeping clks, regulators, etc.
> >> enabled. And have them check if disable was called on remove()
> >> and if not do the disable() things on remove(0
> >>
> >> 4. Have msm call aperture_disable_conflicting_devices() where it
> >> now call aperture_remove_conflicting_devices() and call
> >> aperture_remove_conflicting_devices() at the point where it has
> >> claimed any clks it needs.
> >>
> >> Does this sound like something which would be acceptable ?
> >=20
> > Generally speaking, yes, but I'd also like to understand what you're
> > trying to fix exactly, because I don't see how it can be what you hinted
> > at before.
>=20
> The basic problem is that on handover from simpledrm -> msm
> the clocks get turned off, without fully shutting down the
> display pipeline first (since simpledrm does not know how).
>=20
> Then when msm later tries to re-enable things, the hw is
> in a confused state and we hit this error:
>=20
> [    2.980181] disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its c=
onfiguration.
> [    2.980272] WARNING: drivers/clk/qcom/clk-rcg2.c:136 at update_config+=
0xdc/0x100
>=20
> So we need a way to handover things to the msm driver
> without anything getting disabled by simpledrm in an
> uncontrolled (not following proper pwr-down seq) manner.
>=20
> The idea behind the 2 step simpledrm removal process is
> that on the first step drm_dev_unplug() gets called for
> the simpledrm device and any struct resource claim on
> the aperture gets released. While keeping all the clocks,
> regulators, etc. claims.
>
> Then msm can take things over and call the second step
> when it has taken everything over. On the second step
> simpeldrm will release its enable count ref on the clocks,
> etc. in question.

So I'm not really sure you need a hand-over, and you kind of rejected
doing a proper one anyway.

I see two issues there:
 - simpledrm doesn't safely disable its resources on QC SoCs

 - there's no way to claim the resources from simpledrm after the main
   drm driver is active.

And you're trying to work around the first one with the second one. The
second one is generic to me, so it shouldn't be an msm (or simpledrm)
specific solution.

The first one is SoC-specific, and fixing the second won't prevent
completely the first. If you unbind simpledrm while it's active, you'll
get the same issue, and you can't rely on the msm driver being always
there to cover for you.

So we need to fix both. We should discuss the second part with Thomas
really, but for the first one, simple-framebuffer having its own
compatible will allow you to trigger any coordinated poweroff sequence.

Maxime

--by3ip33exiefhb24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaj50qQAKCRAnX84Zoj2+
dojtAYCmeW3bzu+YkChvIKdC+nbW6MN2bPTAHpqM1GM0ZtbH0AKJtQh4UWvJueJq
TGdm2wsBf1swiWMaFoBi9UoEdVkB4y02Gcisr2W4HluPhEGwb2/bFOxt6x3RsQYy
Lnuh3GI3Wg==
=O0bd
-----END PGP SIGNATURE-----

--by3ip33exiefhb24--
