Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E5C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2343F10EC82;
	Tue, 22 Sep 2026 12:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J9BrPANg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C46310EC82;
 Tue, 22 Sep 2026 12:16:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C95B60DF7;
 Tue, 22 Sep 2026 12:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344941F000FF;
 Tue, 22 Sep 2026 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790079391;
 bh=wFKgmThc37/WLmBFYUHY1bxEhAWR1QO0X6AW0mvtgCc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J9BrPANgAu6ASZVesjOJ5VaN1CVDXPa9HlhArGOgPlNcLAag3UxS7c1BzG5UA4WsY
 wcI1ONC2lSsrTkDMHceGaAyeaFQYwEgBjCI+r+wNW9gMowsJjmQIuG68uZlaRY6HKN
 MdNBy9+u7r9vaLoAw9Kc8uaRbmWVc3K16Qd4F/qMr6LibbZmNAshU6/V9HvtfsCtlM
 uuDNeOg/c8zyww1RsTshpCjIMSomLfqok84f6Q085BlD/dSlXFUhU3eRKqMRc9hBv3
 N5u3lB3MccftgwHBjmpI97PGfywJUn4Kipcwag2Mibrt78dYgpMSlf/YTJIJNfk+FX
 b6KzJqzYbijbA==
Date: Tue, 22 Sep 2026 14:16:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
Message-ID: <arJwOSq6-oSywTK6@houat>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="5lb7fldev2bfc7fs"
Content-Disposition: inline
In-Reply-To: <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
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


--5lb7fldev2bfc7fs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 06:41:32AM -0500, Mario Limonciello wrote:
>=20
>=20
> On 9/22/26 03:33, Javier Martinez Canillas wrote:
> > Hello Mario,
> >=20
> > On Tue, Sep 8, 2026 at 6:41=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >=20
> > > At Display Next Hackfest 2026 we reviewed progress moving brightness
> > > control into the DRM connector properties.
> > >=20
> > > There is a range LUMINANCE property that will default to 0->0.
> > > Once a driver attaches a backlight it will be updated to 1->max.
> > > If the panel supports the minimum backlight turning off the display
> > > the range can later be updated to 0->max instead of 1->max.
> > >=20
> > > The legacy sysfs interface is synchronized with the DRM connector.
> > > When a compositor using this feature is loaded, sysfs writes are disa=
bled
> > > to prevent legacy tools from going out of sync with the compositor.
> > >=20
> >=20
> > I don't think I agree with the direction of this series. The main
> > issue for me is that if the sysfs interface is disabled, then I don't
> > understand the value of doing all the hops between the DRM and
> > backlight subsystems...
>=20
> The reason for all the hops is that users can switch between compositors
> that support this and don't.  If you're in a compositor that supports it
> that compositor will want to affirm it's in control.  If you're in a
> compositor without support then you should still have a way to change
> things, and that's what the sysfs interface exists for.

Couldn't we make a sysfs write trigger an atomic commit then? That way,
it would always go through the atomic commit path, no matter whether
you're on a "legacy" compositor or not.

It would also somewhat untangle the uapi from the backlight subsystem,
because it's only really relevant for panels. For all the other use
cases, you might want to control the brightness but you have no matching
backlight device.

> > IMO when a driver sets the DRIVER_CONNECTOR_LUMINANCE feature and the
> > client advertise the DRM_CLIENT_CAP_LUMINANCE capability, then the DRM
> > driver should be in full control of the brightness control and not go
> > through the backlight subsystem at all.
>=20
> OK but so let's say I start at 100% brightness.  I open up Kwin, I change
> the luminance property to 0%.  Let's pretend that backlight subsystem
> doesn't get updated.
>=20
> Then I log into Xorg + Xfce.  The luminance property should be left at 0%,
> the brightness subsystem is 100%.

Make backlight read the current property then.

The way I see it, you're trying to untangle multiple issues at once, and
I'm not sure it's the best strategy here. I'd start with the luminance
property itself that wouldn't involve the backlight framework itself
(DDC/CI or MIPI-DCS sound like obvious candidates here), and once it's
in, I would figure out the relationship between backlight and that property.

Maxime

--5lb7fldev2bfc7fs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarJxlAAKCRAnX84Zoj2+
dh71AX9ZyMKS8LP70Gd+k878qeHmm87a9k0p0dEK3+a8XsSKPZyhRXAiyejTfFXW
Pq0xG20BgLZA9iv4OGIoi7s8LDC++1HLpxyy3hnYKIkAxXp7k6BYRkT5to4Mnwtp
aKlGsYwXwA==
=ZtaM
-----END PGP SIGNATURE-----

--5lb7fldev2bfc7fs--
