Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5E8CA5FDD
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3277A10F714;
	Thu,  1 Oct 2026 16:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lm6I3OB+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B117F10F70A;
 Thu,  1 Oct 2026 16:06:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6004342A49;
 Thu,  1 Oct 2026 16:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A5D1F000FF;
 Thu,  1 Oct 2026 16:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790870778;
 bh=h84bDGijr6XtJ5sZv1vQuI0WtaMIwCu5WedQZywXQrM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lm6I3OB+TtBvrp8UNWdRkoCyohrCYfCXo1ZeVHfC81gSGwdA+DSYqJlgD4SAy7u3o
 ym/n90vM5jl0Uow9W9eI+bu2CnzgZNzLmWWtGkHbXmf0V5CF/jXGBPSLCJRd7PcacP
 mzUNWUamE/aNt7gYhWA15JPCpXa8VF5I7nzt5isYfHhPndhFrmYVM3eEC0xzTKq7FR
 TDidTJkvMm1O/jshZBcYWuJsk+qHGdHmKwE7e0TyTrRcA4S/hVnTVXd3dy+ErUMLeo
 ytGbMIGdOcaUHRNpOEw3mLdjE5Je3XLHaWxi3/3jIYVt6HU/RuCyfrOjHFddT8Do8r
 hHCDKHFNUs5oA==
Date: Thu, 1 Oct 2026 18:06:14 +0200
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
Message-ID: <ar6ElW7Wg5m6A-1m@houat>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
 <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de>
 <arJ0huW356NjqpGR@houat>
 <8727cba2-aa4d-4480-9b76-a9dedc57d8ee@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="7efl36kddwnyzj6m"
Content-Disposition: inline
In-Reply-To: <8727cba2-aa4d-4480-9b76-a9dedc57d8ee@suse.de>
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


--7efl36kddwnyzj6m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 08:39:33AM +0200, Thomas Zimmermann wrote:
> Am 22.09.26 um 14:35 schrieb Maxime Ripard:
> > On Tue, Sep 22, 2026 at 02:23:17PM +0200, Thomas Zimmermann wrote:
> > > Hi
> > >=20
> > > Am 22.09.26 um 14:16 schrieb Maxime Ripard:
> > > > On Tue, Sep 22, 2026 at 06:41:32AM -0500, Mario Limonciello wrote:
> > > > > On 9/22/26 03:33, Javier Martinez Canillas wrote:
> > > > > > Hello Mario,
> > > > > >=20
> > > > > > On Tue, Sep 8, 2026 at 6:41=E2=80=AFAM Mario Limonciello
> > > > > > <mario.limonciello@amd.com> wrote:
> > > > > > > At Display Next Hackfest 2026 we reviewed progress moving bri=
ghtness
> > > > > > > control into the DRM connector properties.
> > > > > > >=20
> > > > > > > There is a range LUMINANCE property that will default to 0->0.
> > > > > > > Once a driver attaches a backlight it will be updated to 1->m=
ax.
> > > > > > > If the panel supports the minimum backlight turning off the d=
isplay
> > > > > > > the range can later be updated to 0->max instead of 1->max.
> > > > > > >=20
> > > > > > > The legacy sysfs interface is synchronized with the DRM conne=
ctor.
> > > > > > > When a compositor using this feature is loaded, sysfs writes =
are disabled
> > > > > > > to prevent legacy tools from going out of sync with the compo=
sitor.
> > > > > > >=20
> > > > > > I don't think I agree with the direction of this series. The ma=
in
> > > > > > issue for me is that if the sysfs interface is disabled, then I=
 don't
> > > > > > understand the value of doing all the hops between the DRM and
> > > > > > backlight subsystems...
> > > > > The reason for all the hops is that users can switch between comp=
ositors
> > > > > that support this and don't.  If you're in a compositor that supp=
orts it
> > > > > that compositor will want to affirm it's in control.  If you're i=
n a
> > > > > compositor without support then you should still have a way to ch=
ange
> > > > > things, and that's what the sysfs interface exists for.
> > > > Couldn't we make a sysfs write trigger an atomic commit then? That =
way,
> > > > it would always go through the atomic commit path, no matter whether
> > > > you're on a "legacy" compositor or not.
> > > >=20
> > > > It would also somewhat untangle the uapi from the backlight subsyst=
em,
> > > > because it's only really relevant for panels. For all the other use
> > > > cases, you might want to control the brightness but you have no mat=
ching
> > > > backlight device.
> > > I suggested to treat these backlight changes like display-hotplug eve=
nts.
> > > When it happens, we'd send a uevent to user space, so it can update i=
ts
> > > internal state.=C2=A0 Such an event could then come from any source b=
esides
> > > backlight's sysfs.=C2=A0 =C2=A0Compositors could also implement polic=
ies that are
> > > currently implicit in this series, such as brightness of 0 means "dis=
play
> > > off".=C2=A0 This is likely something a compositor should track.
> > >=20
> > > Would that work?
> > It probably would, but it would create a precedent I'm not really
> > familiar with. Hotplug events are kind of separate because it really is
> > a hardware event most of the time: you get an interrupt, and report it
> > to userspace. And it's largely outside of the properties space (except
> > maybe for things like edid).
> >=20
> > If we start having the argument that a property changing must trigger a
> > uevent, then it means that we can expect *any* property to do so, and
> > "the compositor needs to be in control of it" can apply to many, like
> > color formats, positions, tiling, etc.
>=20
> I'd explicitly not treat this like a change to the DRM property. More like
> as if the user pressed a hardware button. The property update only comes
> later from what ever the compositor does with the event.

I don't think that would work unfortunately, because then that means
that any system that used to rely on sysfs but wouldn't handle that new
event (however it is sent) would effectively have a regression.

That being said, it does look like we already notify userspace on
property change for HPCD, so maybe it's not too bad.

Maxime

--7efl36kddwnyzj6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar6E8gAKCRAnX84Zoj2+
dlrIAX46V8/e/Kxw6JfRY2HmiAKQntwyIkzhsfQQCMH8FlfvJCGeO+wuRZ0cwwjI
7a/u8lIBgOW96iJdOsM8xE9lcmCdtLN8tIWhK7mbUwhe02B64JNmUhk1kyRp0mOy
IedT9d19ig==
=QGqo
-----END PGP SIGNATURE-----

--7efl36kddwnyzj6m--
