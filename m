Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BD7CA5FDB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57DA10F72A;
	Thu,  1 Oct 2026 16:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AyBRM0S7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA6110E1D7;
 Thu,  1 Oct 2026 16:20:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5114A6021D;
 Thu,  1 Oct 2026 16:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83F71F000FF;
 Thu,  1 Oct 2026 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790871604;
 bh=YGKr/SmuxZ7lbHUFYUsGJWDpH3lQoWWa24vfRF2g4s8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AyBRM0S7D7AlzzDUo8vQX8uscair+HS6FLwWWjKTlvWcbvdgv6SaQK0MdNS7d/KUn
 lUlVPlu9ls5uuG0dQOG5IJy/N/cFg99qY8D0qc6IZXECZs9S7aDZtDnY9G4mK+uBgt
 uZZMKd9oF34ckDVYfZxW1iUlx7ng0lTip2BEXOyds9ncfHXqw1rKHS1XyZoJ4EKMON
 jvuFdw66PgF86YmNfKmvNzUvqzEn/UfSVdMO1fUywyeGHzT6zKVO7LWAzIKnetLy2C
 sOlbG31LdnUMsn+paZTomifftmfPl7ZxRYCtjY7+RjJSuUedXMPxJiZD0R4xwlEnWY
 umiQ79JA2JRTA==
Date: Thu, 1 Oct 2026 18:20:00 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, 
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
Message-ID: <ar6H4EDbX1upOL-r@houat>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
 <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de>
 <arJ0huW356NjqpGR@houat>
 <8727cba2-aa4d-4480-9b76-a9dedc57d8ee@suse.de>
 <ar6ElW7Wg5m6A-1m@houat>
 <acf55259-f4b4-42bb-b16c-e5bb79cbecbb@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="4q6r2uxpkkffhl3z"
Content-Disposition: inline
In-Reply-To: <acf55259-f4b4-42bb-b16c-e5bb79cbecbb@amd.com>
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


--4q6r2uxpkkffhl3z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 11:10:52AM -0500, Mario Limonciello wrote:
>=20
>=20
> On 10/1/26 11:06, Maxime Ripard wrote:
> > On Wed, Sep 23, 2026 at 08:39:33AM +0200, Thomas Zimmermann wrote:
> > > Am 22.09.26 um 14:35 schrieb Maxime Ripard:
> > > > On Tue, Sep 22, 2026 at 02:23:17PM +0200, Thomas Zimmermann wrote:
> > > > > Hi
> > > > >=20
> > > > > Am 22.09.26 um 14:16 schrieb Maxime Ripard:
> > > > > > On Tue, Sep 22, 2026 at 06:41:32AM -0500, Mario Limonciello wro=
te:
> > > > > > > On 9/22/26 03:33, Javier Martinez Canillas wrote:
> > > > > > > > Hello Mario,
> > > > > > > >=20
> > > > > > > > On Tue, Sep 8, 2026 at 6:41=E2=80=AFAM Mario Limonciello
> > > > > > > > <mario.limonciello@amd.com> wrote:
> > > > > > > > > At Display Next Hackfest 2026 we reviewed progress moving=
 brightness
> > > > > > > > > control into the DRM connector properties.
> > > > > > > > >=20
> > > > > > > > > There is a range LUMINANCE property that will default to =
0->0.
> > > > > > > > > Once a driver attaches a backlight it will be updated to =
1->max.
> > > > > > > > > If the panel supports the minimum backlight turning off t=
he display
> > > > > > > > > the range can later be updated to 0->max instead of 1->ma=
x.
> > > > > > > > >=20
> > > > > > > > > The legacy sysfs interface is synchronized with the DRM c=
onnector.
> > > > > > > > > When a compositor using this feature is loaded, sysfs wri=
tes are disabled
> > > > > > > > > to prevent legacy tools from going out of sync with the c=
ompositor.
> > > > > > > > >=20
> > > > > > > > I don't think I agree with the direction of this series. Th=
e main
> > > > > > > > issue for me is that if the sysfs interface is disabled, th=
en I don't
> > > > > > > > understand the value of doing all the hops between the DRM =
and
> > > > > > > > backlight subsystems...
> > > > > > > The reason for all the hops is that users can switch between =
compositors
> > > > > > > that support this and don't.  If you're in a compositor that =
supports it
> > > > > > > that compositor will want to affirm it's in control.  If you'=
re in a
> > > > > > > compositor without support then you should still have a way t=
o change
> > > > > > > things, and that's what the sysfs interface exists for.
> > > > > > Couldn't we make a sysfs write trigger an atomic commit then? T=
hat way,
> > > > > > it would always go through the atomic commit path, no matter wh=
ether
> > > > > > you're on a "legacy" compositor or not.
> > > > > >=20
> > > > > > It would also somewhat untangle the uapi from the backlight sub=
system,
> > > > > > because it's only really relevant for panels. For all the other=
 use
> > > > > > cases, you might want to control the brightness but you have no=
 matching
> > > > > > backlight device.
> > > > > I suggested to treat these backlight changes like display-hotplug=
 events.
> > > > > When it happens, we'd send a uevent to user space, so it can upda=
te its
> > > > > internal state.=C2=A0 Such an event could then come from any sour=
ce besides
> > > > > backlight's sysfs.=C2=A0 =C2=A0Compositors could also implement p=
olicies that are
> > > > > currently implicit in this series, such as brightness of 0 means =
"display
> > > > > off".=C2=A0 This is likely something a compositor should track.
> > > > >=20
> > > > > Would that work?
> > > > It probably would, but it would create a precedent I'm not really
> > > > familiar with. Hotplug events are kind of separate because it reall=
y is
> > > > a hardware event most of the time: you get an interrupt, and report=
 it
> > > > to userspace. And it's largely outside of the properties space (exc=
ept
> > > > maybe for things like edid).
> > > >=20
> > > > If we start having the argument that a property changing must trigg=
er a
> > > > uevent, then it means that we can expect *any* property to do so, a=
nd
> > > > "the compositor needs to be in control of it" can apply to many, li=
ke
> > > > color formats, positions, tiling, etc.
> > >=20
> > > I'd explicitly not treat this like a change to the DRM property. More=
 like
> > > as if the user pressed a hardware button. The property update only co=
mes
> > > later from what ever the compositor does with the event.
> >=20
> > I don't think that would work unfortunately, because then that means
> > that any system that used to rely on sysfs but wouldn't handle that new
> > event (however it is sent) would effectively have a regression.
> >=20
> > That being said, it does look like we already notify userspace on
> > property change for HPCD, so maybe it's not too bad.
>
> Earlier iterations of my development of the series had a userspace
> notification.  It was very heavy.  The problem is that your DE may change=
 a
> brightness in a slider and try to smooth it out and then that turns into
> hundreds of calls to notify userspace.
>=20
> It was heavy enough that it lagged on a beefy system.  I don't think this
> direction makes sense unless it was rate limited.

I was talking about it specifically for the legacy sysfs API. The main
API kind of guarantees that the compositor is in charge anyway, so
there's no need to notify anyone.

And if it's still a concern, then yes, I guess we can rate limit it, or
add hysteresis.

Maxime

--4q6r2uxpkkffhl3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar6IMAAKCRAnX84Zoj2+
dgcIAX9yqcg9vLctYEnOZKKh/yP2VllOuQ48aVwBYIkz6iIDniQL2sqec48JBNO4
bd5TmGABewUr+2a5TWgH71gDg4nUpfNqhCfeZiRo1siwqNiZm2AJsZdbHwKgXNsH
JKGnQpcJwA==
=Aozc
-----END PGP SIGNATURE-----

--4q6r2uxpkkffhl3z--
