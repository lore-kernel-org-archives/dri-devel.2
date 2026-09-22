Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8A1C98306
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C3E10ECA9;
	Tue, 22 Sep 2026 12:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="he9VcILG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1483F10ECA4;
 Tue, 22 Sep 2026 12:35:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A42A940D65;
 Tue, 22 Sep 2026 12:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B331F000FF;
 Tue, 22 Sep 2026 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790080532;
 bh=S3cL58T1PySwvHM7yYfD83o55hu0YlN8sd9oqJkR+5Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=he9VcILGtw4iCvSgoGjWy3p9ij5THpqbhsGJlx5Ev+Ex/LIy4og0X5LW0/Ndp4VBt
 zipxsKj2H01rYy86e1iXaFp8Q/S1ObdVDP4Z+jybXTQVibldGwLphK7aZZ5Y6RDWLc
 CGeGUljpY7VEVZ/gx0ml4hGizDFq0BNHHffWKFCkj3YCzPjZsRTRBT8MXJdOcUz4a6
 XErVTPeMOaPSkZAOjVd8Ai2TJ8mV10rFRfJDLvKS9YbZPHJPf/bQR3YWMVS4OjcQB9
 NNqYjm1hy9HqtiWzUCV+8WmrbEcB0UFFPDWRSy7ALbN8rr2pSgwrn6ogAiifp5uipj
 V0f+Vt6euk/qg==
Date: Tue, 22 Sep 2026 14:35:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
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
Message-ID: <arJ0huW356NjqpGR@houat>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
 <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="aphxvy3mdbvxymga"
Content-Disposition: inline
In-Reply-To: <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de>
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


--aphxvy3mdbvxymga
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 02:23:17PM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 22.09.26 um 14:16 schrieb Maxime Ripard:
> > On Tue, Sep 22, 2026 at 06:41:32AM -0500, Mario Limonciello wrote:
> > >=20
> > > On 9/22/26 03:33, Javier Martinez Canillas wrote:
> > > > Hello Mario,
> > > >=20
> > > > On Tue, Sep 8, 2026 at 6:41=E2=80=AFAM Mario Limonciello
> > > > <mario.limonciello@amd.com> wrote:
> > > > > At Display Next Hackfest 2026 we reviewed progress moving brightn=
ess
> > > > > control into the DRM connector properties.
> > > > >=20
> > > > > There is a range LUMINANCE property that will default to 0->0.
> > > > > Once a driver attaches a backlight it will be updated to 1->max.
> > > > > If the panel supports the minimum backlight turning off the displ=
ay
> > > > > the range can later be updated to 0->max instead of 1->max.
> > > > >=20
> > > > > The legacy sysfs interface is synchronized with the DRM connector.
> > > > > When a compositor using this feature is loaded, sysfs writes are =
disabled
> > > > > to prevent legacy tools from going out of sync with the composito=
r.
> > > > >=20
> > > > I don't think I agree with the direction of this series. The main
> > > > issue for me is that if the sysfs interface is disabled, then I don=
't
> > > > understand the value of doing all the hops between the DRM and
> > > > backlight subsystems...
> > > The reason for all the hops is that users can switch between composit=
ors
> > > that support this and don't.  If you're in a compositor that supports=
 it
> > > that compositor will want to affirm it's in control.  If you're in a
> > > compositor without support then you should still have a way to change
> > > things, and that's what the sysfs interface exists for.
> > Couldn't we make a sysfs write trigger an atomic commit then? That way,
> > it would always go through the atomic commit path, no matter whether
> > you're on a "legacy" compositor or not.
> >=20
> > It would also somewhat untangle the uapi from the backlight subsystem,
> > because it's only really relevant for panels. For all the other use
> > cases, you might want to control the brightness but you have no matching
> > backlight device.
>=20
> I suggested to treat these backlight changes like display-hotplug events.
> When it happens, we'd send a uevent to user space, so it can update its
> internal state.=C2=A0 Such an event could then come from any source besid=
es
> backlight's sysfs.=C2=A0 =C2=A0Compositors could also implement policies =
that are
> currently implicit in this series, such as brightness of 0 means "display
> off".=C2=A0 This is likely something a compositor should track.
>=20
> Would that work?

It probably would, but it would create a precedent I'm not really
familiar with. Hotplug events are kind of separate because it really is
a hardware event most of the time: you get an interrupt, and report it
to userspace. And it's largely outside of the properties space (except
maybe for things like edid).

If we start having the argument that a property changing must trigger a
uevent, then it means that we can expect *any* property to do so, and
"the compositor needs to be in control of it" can apply to many, like
color formats, positions, tiling, etc.

It would be a much saner design to put it behind DRM_MASTER, and
deprecate the sysfs interface entirely.

Maxime

--aphxvy3mdbvxymga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarJ2DwAKCRAnX84Zoj2+
dmeOAX4rOUubD98Ry5IKU/TpA134hAFav7UZzPVSp35hLz9sC3+xpRafxbKuTWcr
R37oo2cBfiUHt8bOOeHaOxxd/E9WM5PjM/+QhvfRqb/T72CoZjfPCN1zhYZEDNfx
Tu7d8Iqs1w==
=5sv1
-----END PGP SIGNATURE-----

--aphxvy3mdbvxymga--
