Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036D1CA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A05E10F7A4;
	Fri,  2 Oct 2026 08:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T5qtcth1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE76710E550;
 Fri,  2 Oct 2026 08:01:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC62C60A6A;
 Fri,  2 Oct 2026 08:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5861F000FF;
 Fri,  2 Oct 2026 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790928095;
 bh=OiI2CrL5LsATFPM1dzJgWFi+YFJyChOFa6BXjvOU70w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=T5qtcth1ix3Jxh7beQCLBDe2ttpW8KWGOJA4/OmbC+VawEMUrlIDi8eFCAIOpzyYn
 ATcYRV96XnF4Jz/E6g/5hIYBOg5Q8/k0MhR9rYYC6EYWJhivrF1rHV1aLN+gHetU2V
 Gtw1EvycmztSfDVwUBkJhO2MDDyjgQpFEJtL0P84i67FJvpIIB4iFSLevVrox0ujyu
 qifvvaJBot3TJ1SXJrdj21AKIyJUBObjDIMDCrVm2vwtptlwSPdDTzvz0O3O+G2d/P
 hMjjM5LNvhQNRHsvjq7iC93t3wWXW6F9gZG8wwMeijF3cC73esqyChJnnqPzpsn3F5
 vzs4bT05PbKqA==
Date: Fri, 2 Oct 2026 10:01:32 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 Xaver Hugl <xaver.hugl@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
Message-ID: <ar9kxYB3OnjBVVX2@houat>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
 <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de>
 <arJ0huW356NjqpGR@houat>
 <CAFZQkGz9O8dZfmxEC5Fcpa2mRHXde+FFwu4JVz3fvKTzHT49LQ@mail.gmail.com>
 <ar6GxMRwcsTX8IaF@houat>
 <d0889653-e835-4a22-b385-85cb19ee13a0@amd.com>
 <xlv1fqypfjib.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="d34c72siclxx27dt"
Content-Disposition: inline
In-Reply-To: <xlv1fqypfjib.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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


--d34c72siclxx27dt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 06:55:24PM +0200, Javier Martinez Canillas wrote:
> Mario Limonciello <mario.limonciello@amd.com> writes:
> > On 10/1/26 11:18, Maxime Ripard wrote:
> >> On Wed, Sep 23, 2026 at 10:07:16AM +0200, Xaver Hugl wrote:
> >>>> Couldn't we make a sysfs write trigger an atomic commit then? That w=
ay,
> >>>> it would always go through the atomic commit path, no matter whether
> >>>> you're on a "legacy" compositor or not.
> >>>
> >>> That could cause stutter.
> >>=20
> >> Is it really that bad? I mean, it would be only in scenarios where the
> >> legacy API is being used and I would expect it to become the standard
> >> pretty fast anyway, no?
> >>=20
> >>>> It probably would, but it would create a precedent I'm not really
> >>>> familiar with. Hotplug events are kind of separate because it really=
 is
> >>>> a hardware event most of the time: you get an interrupt, and report =
it
> >>>> to userspace. And it's largely outside of the properties space (exce=
pt
> >>>> maybe for things like edid).
> >>>
> >>> If there's any property changes, userspace does need to be notified
> >>> about it. Whether the change is caused by hardware or software doesn't
> >>> matter.
> >>=20
> >> Yeah, it turns out we already have a precedent for this for HDCP so it=
's
> >> not too bad I guess.
> >>=20
> >>>> If we start having the argument that a property changing must trigge=
r a
> >>>> uevent, then it means that we can expect *any* property to do so
> >>> For anything modified outside of the compositor's control, yes.
> >>>
> >>> The client cap avoids needing uevents for the luminance property
> >>> though, since backlight control is exclusive to DRM if the compositor
> >>> supports it.
> >>>
> >>>> "the compositor needs to be in control of it" can apply to many, like
> >>>> color formats, positions, tiling, etc.
> >>>
> >>> If there were other APIs that desktops relied on for controlling color
> >>> formats and similar, we would indeed also need a client cap for those
> >>> things, until definitely all software is ported away from the old API.
> >>=20
> >> I really think this series should be split. We obviously need to addre=
ss
> >> this, but it's kind of decoupled from the UAPI itself, and is only
> >> relevant for a small subset of its usage. And yet it's all we talk
> >> about. It'll be easier to merge in chunks and decoupling the legacy API
> >> handling from the new uapi.
> >>=20
> >> Maxime
> >
> > How would you feel about a (temporary) Kconfig that lets you pick which=
=20
> > API to support?  This would effectively mean that we can get the new=20
> > UAPI integrated without worrying about implications for the legacy API.
> >
> > We can then get compositors all lined up to use the the new API and the=
n=20
> > bikeshed the compat between the two to let us drop the Kconfig.
> >
>=20
> That is indeed a very good idea IMO. Just depends on !BACKLIGHT_CLASS_DEV=
ICE
> and ensure that no existing user of the sysfs get affected by this new AP=
I.

Yep, sounds great
Maxime

--d34c72siclxx27dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar9k2wAKCRAnX84Zoj2+
dhHOAX91ShFb3ZXlF29hQ+e2dsrfAU7fjLODCan8r3DR9iaToUQDjeeLfNrIdaof
fsCpatoBf3XayWPqOca76BgUHVGtrP5Z5v1pKagbD4f+y98pi/EqrCEiyZUpnw90
lFvppDdGEQ==
=MnZk
-----END PGP SIGNATURE-----

--d34c72siclxx27dt--
