Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2C606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWUkwc8h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA11E10E6BC;
	Mon, 23 Nov 2026 07:50:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B984810E625;
 Mon, 23 Nov 2026 07:50:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A936661171;
 Mon, 23 Nov 2026 07:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3121F000D0;
 Mon, 23 Nov 2026 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795420232;
 bh=hW5LFjgto4zGcWrQITLOCh/gfXE2BwATGzrU93D1tmw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bWUkwc8h5zrOfjM38QFrh4YfCPrGEa1xjM/ZB4Rlg8boHG/chwgaqRboSail5paH7
 Rm02dyDuVbOPtNGNxwShOSCPyhG8vO+Jz6Tnz9haqx9dlAnfTh/BO/QkXHhSpAMkWJ
 J2t1enp+8GuYoYanwH6pnKX7QfoV9kbKuJp6Cl9iHtoSFvw4BwCB91fKuynIcfzUWf
 7Q+KUuYx/6od6HffincKWQF3/pUsPt2FyuleFQu/4GVLX/Ysn27NJ1FbONBTWedIE5
 vI5c2UoYaAtz4sZJbYfx0sfORLyw2q+ApuzODsB9lkMQSLgeDJoF1qB93uUU0G/IWw
 RKxxLrdQY/LtA==
Date: Mon, 23 Nov 2026 08:50:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 01/12] drm: add connector LUMINANCE property
Message-ID: <awPvoLCDeq1YFLE_@houat>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
 <awB4Qe83u0l0XPKA@intel.com>
 <8713bae1-9782-41d4-b09c-f14031203e88@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="f5th5dlybbozo6fg"
Content-Disposition: inline
In-Reply-To: <8713bae1-9782-41d4-b09c-f14031203e88@amd.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--f5th5dlybbozo6fg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 01/12] drm: add connector LUMINANCE property
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 11:19:13AM -0600, Mario Limonciello wrote:
>=20
>=20
> On 11/20/26 10:41, Ville Syrj=E4l=E4 wrote:
> > On Thu, Nov 19, 2026 at 05:27:28PM -0600, Mario Limonciello wrote:
> > > Panel brightness is a property of a display, and thus of a DRM
> > > connector. Add an atomic per-connector LUMINANCE range property so
> > > compositors can manage relative panel luminance together with the rest
> > > of the display state.
> > >=20
> > > Keep the core backend-agnostic. Drivers create the property with their
> > > hardware range and implement connector helper callbacks to set lumina=
nce
> > > or disable panel emission. The atomic helpers sequence those callbacks
> > > around pipeline enable and disable, including luminance-only commits.
> > > The panel is left lit when the pipeline enters self refresh, and the
> > > luminance is only reprogrammed when it changes or a modeset enables t=
he
> > > pipeline.
> > >=20
> > > The stored property value is independent of display power. A commit m=
ade
> > > while the connector is inactive is retained and applied on the next
> > > enable; disabling the pipeline does not overwrite it.
> > >=20
> > > LUMINANCE values are relative, driver-defined levels rather than
> > > absolute luminance in cd/m^2. The interface supports emissive panels =
as
> > > well as panels with a separate backlight.
> > >=20
> > > Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
> > > drivers retain their legacy backlight class ABI unless the new interf=
ace
> > > is explicitly selected, allowing the DRM UAPI and legacy compatibility
> > > policy to remain separate.
> > >=20
> > > Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v11:
> > >   * Don't call .disable_luminance when the CRTC enters self refresh (=
Sashiko)
> > >   * Only call .set_luminance when the luminance changes or on a modes=
et
> > >     that isn't a self refresh exit (Leo Li, Sashiko)
> > >   * Fix the .set_luminance self refresh documentation
> > > v10:
> > >   * Add tag
> > > ---
> > >   drivers/gpu/drm/Kconfig                    | 14 +++++
> > >   drivers/gpu/drm/drm_atomic_helper.c        | 98 +++++++++++++++++++=
++++++++++-
> > >   drivers/gpu/drm/drm_atomic_state_helper.c  |  7 +++
> > >   drivers/gpu/drm/drm_atomic_uapi.c          |  5 ++
> > >   drivers/gpu/drm/drm_connector.c            | 57 +++++++++++++++++
> > >   drivers/gpu/drm/tests/drm_connector_test.c | 28 +++++++++
> > >   include/drm/drm_atomic_helper.h            |  3 +
> > >   include/drm/drm_connector.h                | 16 +++++
> > >   include/drm/drm_modeset_helper_vtables.h   | 28 +++++++++
> > >   9 files changed, 255 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > index 61111d50b1c65..1bbe2c2d7c76f 100644
> > > --- a/drivers/gpu/drm/Kconfig
> > > +++ b/drivers/gpu/drm/Kconfig
> > > @@ -33,6 +33,20 @@ endmenu
> > >   if DRM
> > > +config DRM_LUMINANCE
> > > +	bool "DRM connector luminance support"
> > > +	help
> > > +	  Expose relative luminance as an atomic DRM connector property. Va=
lues
> > > +	  are driver-defined levels rather than absolute luminance in cd/m^=
2.
> > > +	  Drivers provide connector helper callbacks to program their hardw=
are;
> > > +	  the DRM core does not depend on a particular backend.
> > > +
> > > +	  Drivers migrated to this interface will use it instead of registe=
ring
> > > +	  a legacy backlight class device. Leave this disabled to preserve =
the
> > > +	  de-facto userspace ABI in /sys/class/backlight.
> >=20
> > I don't think this will fly if it breaks the backlight class interface.
> > No one can actually enable this outside of some niche embedded use
> > cases where backwards compatibility is not an issue. I think what
> > you need is a generic backlight class implementation on top of this.
> >=20
>=20
> The idea with this was:
> 1) to get the series landed
> 2) let compositors merge solutions around it.
> 3) Then add backwards compatibility to kernel so we can flip the Kconfig
> default.

I said this a few times already, but we keep having those discussions
while the backlight sysfs handling is far from being the main point. You
should *really* consider adding support for the luminance property for
something that isn't tied to that interface (like DDC/CI for HDMI), and
treat the sysfs API as a sysfs series.

It looks like people just have conflicting opinions on this particular
part that isn't going to solve itself easily. You should not treat this
sysfs discussion as a blocker for the infrastructure work.

Maxime

--f5th5dlybbozo6fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawPwPgAKCRAnX84Zoj2+
dnFBAYCnCAp9+UqXJ6shOjSU/JBXcMLqthRNPDEucO0to0toZfgMF5ix/aeOWSwZ
6OZEl6wBgKgdWTeELQogArOKB+rPohQACkLuYR6pFKC55sKYy2QpZbzJvO482t0S
qZz1s/PTlg==
=JEii
-----END PGP SIGNATURE-----

--f5th5dlybbozo6fg--
