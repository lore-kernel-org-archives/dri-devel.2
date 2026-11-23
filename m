Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE170606A330
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=As8kJMj+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DDF10EBAC;
	Mon, 23 Nov 2026 09:30:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39E710EB95;
 Mon, 23 Nov 2026 09:30:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77C1E401CD;
 Mon, 23 Nov 2026 09:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA18D1F000C6;
 Mon, 23 Nov 2026 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795426208;
 bh=t4U+ldndWXYiv8sPaqw7sW8lRoYP2EKLyk9iA28Ai0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=As8kJMj+D8cbkW8Y/3kujuVU1nEpni9qbmetR+F67FjFi1i4FzY669m04DvTtv34D
 UbK5WYzNqTLHFOhddaows9iinulzDzs3W1gbRicH15wJk4Sx2OfqqNeZ1ioz4qf2tq
 ov0eF2fzTnjETRuOG0oq9efrzqt6n0queknW/xs0rQkX81Nv5DPQUlAVAAHb0ki86W
 3d/Luz4ygugGwnOK/3H/ylIIwNyMIzA4DxBn6ST57ruH06dt/80YWoS5Sr/iwD6g9g
 URV/h6w6UyBt5NKjCq+K8CAW3CtjH8Abng0oU+GOzwHDQq6tjYJfMk8m3QICP2l/2l
 t3zg+q93JTJ7A==
Date: Mon, 23 Nov 2026 10:30:05 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
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
Message-ID: <awQGSuf2UJjItcO0@houat>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
 <awB4Qe83u0l0XPKA@intel.com>
 <8713bae1-9782-41d4-b09c-f14031203e88@amd.com>
 <awPvoLCDeq1YFLE_@houat> <awPzsMWZ7e0i6i54@intel.com>
 <awP0nasqAc4pAeMR@houat> <awP8hAy3Gim4eNxz@intel.com>
 <awQAlSSks2We5h2z@houat> <awQENQN5SswJRtWw@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="krfptbljx3eyphdm"
Content-Disposition: inline
In-Reply-To: <awQENQN5SswJRtWw@intel.com>
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


--krfptbljx3eyphdm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 01/12] drm: add connector LUMINANCE property
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 11:15:33AM +0200, Ville Syrj=E4l=E4 wrote:
> On Mon, Nov 23, 2026 at 10:03:50AM +0100, Maxime Ripard wrote:
> > On Mon, Nov 23, 2026 at 10:42:44AM +0200, Ville Syrj=E4l=E4 wrote:
> > > On Mon, Nov 23, 2026 at 09:10:17AM +0100, Maxime Ripard wrote:
> > > > On Mon, Nov 23, 2026 at 10:05:04AM +0200, Ville Syrj=E4l=E4 wrote:
> > > > > On Mon, Nov 23, 2026 at 08:50:29AM +0100, Maxime Ripard wrote:
> > > > > > On Fri, Nov 20, 2026 at 11:19:13AM -0600, Mario Limonciello wro=
te:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 11/20/26 10:41, Ville Syrj=E4l=E4 wrote:
> > > > > > > > On Thu, Nov 19, 2026 at 05:27:28PM -0600, Mario Limonciello=
 wrote:
> > > > > > > > > Panel brightness is a property of a display, and thus of =
a DRM
> > > > > > > > > connector. Add an atomic per-connector LUMINANCE range pr=
operty so
> > > > > > > > > compositors can manage relative panel luminance together =
with the rest
> > > > > > > > > of the display state.
> > > > > > > > >=20
> > > > > > > > > Keep the core backend-agnostic. Drivers create the proper=
ty with their
> > > > > > > > > hardware range and implement connector helper callbacks t=
o set luminance
> > > > > > > > > or disable panel emission. The atomic helpers sequence th=
ose callbacks
> > > > > > > > > around pipeline enable and disable, including luminance-o=
nly commits.
> > > > > > > > > The panel is left lit when the pipeline enters self refre=
sh, and the
> > > > > > > > > luminance is only reprogrammed when it changes or a modes=
et enables the
> > > > > > > > > pipeline.
> > > > > > > > >=20
> > > > > > > > > The stored property value is independent of display power=
=2E A commit made
> > > > > > > > > while the connector is inactive is retained and applied o=
n the next
> > > > > > > > > enable; disabling the pipeline does not overwrite it.
> > > > > > > > >=20
> > > > > > > > > LUMINANCE values are relative, driver-defined levels rath=
er than
> > > > > > > > > absolute luminance in cd/m^2. The interface supports emis=
sive panels as
> > > > > > > > > well as panels with a separate backlight.
> > > > > > > > >=20
> > > > > > > > > Keep the interface behind a default-off DRM_LUMINANCE opt=
ion. Migrated
> > > > > > > > > drivers retain their legacy backlight class ABI unless th=
e new interface
> > > > > > > > > is explicitly selected, allowing the DRM UAPI and legacy =
compatibility
> > > > > > > > > policy to remain separate.
> > > > > > > > >=20
> > > > > > > > > Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> > > > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.c=
om>
> > > > > > > > > ---
> > > > > > > > > v11:
> > > > > > > > >   * Don't call .disable_luminance when the CRTC enters se=
lf refresh (Sashiko)
> > > > > > > > >   * Only call .set_luminance when the luminance changes o=
r on a modeset
> > > > > > > > >     that isn't a self refresh exit (Leo Li, Sashiko)
> > > > > > > > >   * Fix the .set_luminance self refresh documentation
> > > > > > > > > v10:
> > > > > > > > >   * Add tag
> > > > > > > > > ---
> > > > > > > > >   drivers/gpu/drm/Kconfig                    | 14 +++++
> > > > > > > > >   drivers/gpu/drm/drm_atomic_helper.c        | 98 +++++++=
++++++++++++++++++++++-
> > > > > > > > >   drivers/gpu/drm/drm_atomic_state_helper.c  |  7 +++
> > > > > > > > >   drivers/gpu/drm/drm_atomic_uapi.c          |  5 ++
> > > > > > > > >   drivers/gpu/drm/drm_connector.c            | 57 +++++++=
++++++++++
> > > > > > > > >   drivers/gpu/drm/tests/drm_connector_test.c | 28 +++++++=
++
> > > > > > > > >   include/drm/drm_atomic_helper.h            |  3 +
> > > > > > > > >   include/drm/drm_connector.h                | 16 +++++
> > > > > > > > >   include/drm/drm_modeset_helper_vtables.h   | 28 +++++++=
++
> > > > > > > > >   9 files changed, 255 insertions(+), 1 deletion(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kc=
onfig
> > > > > > > > > index 61111d50b1c65..1bbe2c2d7c76f 100644
> > > > > > > > > --- a/drivers/gpu/drm/Kconfig
> > > > > > > > > +++ b/drivers/gpu/drm/Kconfig
> > > > > > > > > @@ -33,6 +33,20 @@ endmenu
> > > > > > > > >   if DRM
> > > > > > > > > +config DRM_LUMINANCE
> > > > > > > > > +	bool "DRM connector luminance support"
> > > > > > > > > +	help
> > > > > > > > > +	  Expose relative luminance as an atomic DRM connector =
property. Values
> > > > > > > > > +	  are driver-defined levels rather than absolute lumina=
nce in cd/m^2.
> > > > > > > > > +	  Drivers provide connector helper callbacks to program=
 their hardware;
> > > > > > > > > +	  the DRM core does not depend on a particular backend.
> > > > > > > > > +
> > > > > > > > > +	  Drivers migrated to this interface will use it instea=
d of registering
> > > > > > > > > +	  a legacy backlight class device. Leave this disabled =
to preserve the
> > > > > > > > > +	  de-facto userspace ABI in /sys/class/backlight.
> > > > > > > >=20
> > > > > > > > I don't think this will fly if it breaks the backlight clas=
s interface.
> > > > > > > > No one can actually enable this outside of some niche embed=
ded use
> > > > > > > > cases where backwards compatibility is not an issue. I thin=
k what
> > > > > > > > you need is a generic backlight class implementation on top=
 of this.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > The idea with this was:
> > > > > > > 1) to get the series landed
> > > > > > > 2) let compositors merge solutions around it.
> > > > > > > 3) Then add backwards compatibility to kernel so we can flip =
the Kconfig
> > > > > > > default.
> > > > > >=20
> > > > > > I said this a few times already, but we keep having those discu=
ssions
> > > > > > while the backlight sysfs handling is far from being the main p=
oint. You
> > > > > > should *really* consider adding support for the luminance prope=
rty for
> > > > > > something that isn't tied to that interface (like DDC/CI for HD=
MI), and
> > > > > > treat the sysfs API as a sysfs series.
> > > > > >=20
> > > > > > It looks like people just have conflicting opinions on this par=
ticular
> > > > > > part that isn't going to solve itself easily. You should not tr=
eat this
> > > > > > sysfs discussion as a blocker for the infrastructure work.
> > > > >=20
> > > > > You want to be sure backwards compatibility with the backlight
> > > > > class is a solvable problem before you land *anything*. Otherwise
> > > > > you might just paint yourself into a corner with no way out.
> > > >=20
> > > > I disagree. The luminance property is more useful than *just* for
> > > > backlights but is also useful for HDMI, DP, and MIPI-DSI that would=
 all
> > > > use it.
> > >=20
> > > DSI and eDP are all over the place when it comes how backlight
> > > is implemented, so very much would not all use it. Some HDMI and
> > > external DP displays might have DDC/CI support, so I'll give you
> > > those.
> > > =20
> > > > If that's the corner we paint ourselves into, it's still a pretty n=
ice
> > > > corner.
> > >=20
> > > Separate APIs for different outputs on different drivers is just
> > > a bad idea. Every userspace implementation will have to support
> > > all of them until the end of the world.
> >=20
> > I agree, but then there's an easy answer: don't enable it on drivers
> > that would expose it on both APIs. We do have a lot of drivers where
> > there's just no backlight involved and would greatly benefit from these,
> > and without the history of i915 or amdgpu to deal with.
>=20
> It's not the history of the drivers you need to worry about. It's
> the history of userspace that actually matters. All existing
> userspace expects a working backlight class interface. And if you
> don't care about userspace compatibility then we're very much
> back in the "only usable in niche embedded use cases" or "only
> usable on external displays" territories.

Depending on what your perspective is, fastboot was "only usable in
niche i915 use cases" just like color management for amdgpu or leases
were. Let's not be judgemental and / or dismiss others use cases.

If some established driver like, say, vc4 that only has external
displays can pave the way for everyone else to use them eventually, how
is it a downside that it's only usable on external displays?

And even if it's still usable by less established drivers, slow-rolling
it into more drivers, fixing the bugs, rough edges, etc. while
consolidating the code still has a lot of value. Just like it had for
color management or fastboot.

Maxime

--krfptbljx3eyphdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawQHnQAKCRAnX84Zoj2+
dv/IAX9eEMFvOITWTZmbmaZRs5cttfIv53qo1lTfjicUHXYndBi+lFMhUfQkVVAu
QasRx0cBgJfCcGl18yTL+HrxkoGnsNUdtOCnuw4m8Ib6T9gnf+Fb2mCiowaup437
90mwIf/Gpw==
=oDlh
-----END PGP SIGNATURE-----

--krfptbljx3eyphdm--
