Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A48C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E94F10EC9E;
	Tue, 22 Sep 2026 12:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oOP4PATQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C3910EC9E;
 Tue, 22 Sep 2026 12:26:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A63960E01;
 Tue, 22 Sep 2026 12:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5FF1F00893;
 Tue, 22 Sep 2026 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790079989;
 bh=w4aB76axzrssB4npu/BeQaYm/BiVjUcaP5/wHU05wIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oOP4PATQtOWLwfCRcNrV+ErBdPhCe0qOiUsaZ74yWQ5QyQirZR3g1WaQVlOsVKub3
 87fdI3cbBIr5jTuTOgNgYI6PU15TyWiZxB6fS67QJQxIQzP88UAoZKb34cVxlFt2sh
 rynm1VjwmLyJXKSjzxQQuQiiYHJ18DPjYJFAeWZYklsh9879Vp+LUE2a8Fi5mhCh9I
 3yFkTGLvdtRs8havX9NUbr3sq78a3GQKfq+Xlhd+jv9Eh4PPg1FR/gptquI4Y6bZUj
 EEOSIhRudxNGZ3zwZfOzyaIquxdkYsAyjyzwj+UDCmQIsBQBAzAtaJOv81YalH9V2C
 SF6e0tiUjLXVQ==
Date: Tue, 22 Sep 2026 14:26:26 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, 
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>, 
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>, 
 Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
Message-ID: <arJzqMwgppZBSUNY@houat>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
 <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
 <CAFOAJEdFPrwHZV5y1E_u_Wd6oE_viPsPztxYW6PRZHJ-zdPFMQ@mail.gmail.com>
 <ff86caeb-4388-4660-b3c0-ddc42bc274e3@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="bdt3dgaj2va4yx7w"
Content-Disposition: inline
In-Reply-To: <ff86caeb-4388-4660-b3c0-ddc42bc274e3@amd.com>
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


--bdt3dgaj2va4yx7w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 06:34:51AM -0500, Mario Limonciello wrote:
>=20
>=20
> On 9/22/26 03:49, Javier Martinez Canillas wrote:
> > On Tue, Sep 22, 2026 at 10:24=E2=80=AFAM Thomas Zimmermann <tzimmermann=
@suse.de> wrote:
> > >=20
> > > Hi Mario
> > >=20
> > > Am 08.09.26 um 06:40 schrieb Mario Limonciello:
> > > > So far backlights have only been controlled via sysfs. However, sys=
fs is
> > > > not a proper user-space API for runtime modifications, and never was
> > > > intended to provide such. The DRM drivers are now prepared to provi=
de
> > > > such a backlight link so user-space can control backlight via DRM
> > > > connector properties. This allows us to employ the same access-mana=
gement
> > > > we use for mode-setting.
> > > >=20
> > > > This patch adds a few kernel-internal backlight helpers so we can m=
odify
> > > > backlights from within DRM, a brightness-changed notification, and a
> > > > per-device takeover count so that legacy sysfs writes can be inhibi=
ted
> > > > (-EBUSY) while a luminance-aware DRM client is in control.
> > > >=20
> > > > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> > > >=20
> >=20
> > [...]
> >=20
> > > > @@ -150,6 +153,13 @@ static ssize_t bl_power_store(struct device *d=
ev, struct device_attribute *attr,
> > > >        struct backlight_device *bd =3D to_backlight_device(dev);
> > > >        unsigned long power, old_power;
> > > >=20
> > > > +     /* A luminance-aware DRM client has taken over this backlight=
; the
> > > > +      * legacy sysfs interface is disabled until the last such cli=
ent
> > > > +      * goes away.
> > > > +      */
> > > > +     if (atomic_read(&bd->drm_takeover) > 0)
> > > > +             return -EBUSY;
> > > > +
> > > >        rc =3D kstrtoul(buf, 0, &power);
> > > >        if (rc)
> > > >                return rc;
> > > > @@ -214,6 +224,13 @@ static ssize_t brightness_store(struct device =
*dev,
> > > >        struct backlight_device *bd =3D to_backlight_device(dev);
> > > >        unsigned long brightness;
> > > >=20
> > > > +     /* A luminance-aware DRM client has taken over this backlight=
; the
> > > > +      * legacy sysfs interface is disabled until the last such cli=
ent
> > > > +      * goes away.
> > > > +      */
> > > > +     if (atomic_read(&bd->drm_takeover) > 0)
> > > > +             return -EBUSY;
> > >=20
> > > Can you really do that?  AFAIU sysfs is now a de-facto uapi for backl=
ights.
> >=20
> > And regardless if this can be done or not, I belive that would be
> > better if this is something that drivers decide to do and just return
> > -EBUSY from their struct backlight_ops..update_status.
> >=20
> > Ideally the sysfs interface should continue to be work as Thomas said
> > and a write could trigger a mode set for example, but I don't know if
> > that is feasible to do due locking.
> >=20
>=20
> Well the problem ends up being that something can change brightness behind
> the compositor's back if you leave sysfs available.
>=20
> The whole design here is to put the compositor in control.  For example if
> compositor wants to enforce brightness to be a certain value when certain
> content is being displayed.

I don't see how you can solve this. The sysfs interface already shows
this behaviour, so it's not a regression or anything. That being said,
one way to mitigate this would be to consider the sysfs backlight
interface as legacy and disable it by default.

Maxime

--bdt3dgaj2va4yx7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarJz8QAKCRAnX84Zoj2+
dkofAX4jmz48Pf2VeV3XBte3Y5RIW41vw7fQ5QCOGbuxcy7REtrl9RTPaghzVMPI
/hzLeKsBfjjWyB3buiex+nTYyGhTk3eQPnlKaHo96IMb38tNqHa0QE65EB0dH+g7
3l2ltyf1uA==
=i0A9
-----END PGP SIGNATURE-----

--bdt3dgaj2va4yx7w--
