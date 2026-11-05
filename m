Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58030606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdZA6Cwp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13871127E2;
	Thu,  5 Nov 2026 15:40:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4062F1127E2
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:40:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6616A60254;
 Thu,  5 Nov 2026 15:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9731F000C1;
 Thu,  5 Nov 2026 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793893201;
 bh=St2VIjUqMCzkp1fgH9QTlQvm7NZAWdcab/NsK6PnDTo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WdZA6Cwp/pdHxuHm5GEmFazTTa0g6nBFEymt5FEy64XZVs8xm3W4GFcLHmvjI+GdX
 tJ6sVrOGjL7bXM5K+Roz5Dm9CxAYZ9WHk4gvLydGOhgY6e+LofU+Aflyne+I84ZF8i
 o53F7lo0/K/F+CGHnKsGqTUosYS8eDet7onyyQd4K6glZqvhoIs2bZe3lqISMAUN67
 vy1s83bn5QGl+/xFYj7WhG24bWmAEzpZb5ltZwJpbZoAmR7i4igFjUI70SrrBn0Bqj
 WMZaao/B8zrz2fbLWrcd+wXYE3mdkegHXZDBWqmyLcotDcGSAeMOMDsNSzU41pRtqx
 xI0eF65Gh1eTA==
Date: Thu, 5 Nov 2026 16:39:57 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Jocelyn Falempe <jfalempe@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>
Subject: Re: [PATCH v7 00/34] drm: Implement state readout support
Message-ID: <auyhJE31Gl4TeGKB@houat>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <843607fc-45fc-47c5-9d20-6feced20a43f@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="uywhhqe65eg53vrt"
Content-Disposition: inline
In-Reply-To: <843607fc-45fc-47c5-9d20-6feced20a43f@ideasonboard.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--uywhhqe65eg53vrt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 00/34] drm: Implement state readout support
MIME-Version: 1.0

Hi Tomi,

On Thu, Oct 29, 2026 at 05:20:23PM +0200, Tomi Valkeinen wrote:
> On 29/10/2026 09:33, Maxime Ripard wrote:
> > Hi,
> >=20
> > Here's a series that implement what i915 calls "fastboot", ie,
> > initializing the initial KMS state from the hardware state at boot, to
> > skip the first modeset if the firmware already set up the display.
> >=20
> > This series creates the infrastructure in KMS to create that state by
> > relying on driver specific hooks. It also implements some infrastructure
> > to check during non-blocking commits that the readout helpers work
> > properly by reading out the state that was just committed and comparing
> > it to what was supposed to be committed.
> >=20
> > This relies on another set of driver hooks to compare the entities
> > states, with helpers providing the default implementation.
> >=20
> > It then implements the readout support in the TIDSS driver, and was
> > tested with the SK-AM62 board. This board in particular is pretty
> > interesting, since it relies on an DPI to HDMI bridge, and uses the
> > drm_bridge_connector infrastructure.
> >=20
> > So the readout works with the current state of the art on embedded-ish
> > platforms.
> >=20
> > Unlike the earlier RFCs, it now works fine: the state is picked up
> > properly, doesn't trigger a modeset if what was programmed is the one
> > the first modeset tries to pick as well, will switch properly if it
> > isn't, etc.
>
> Sorry that I haven't had time to properly test and work on this. Here's s=
ome
> quick feedback.
>=20
> Do you have a branch you use to test this, with additional patches? If so,
> could you always push that somewhere when posting the series (and mention=
 it
> in the cover letter).

I'm going to fix that in the next version, everything is posted now so
b4 will be able to pick all the dependencies up.

> Not directly related to this series, but the series doesn't compile as
> modules, as drm_atomic_helper_colorop_create_state() is missing an export.
>=20
> In an earlier version you had "drm/tidss: Switch to
> drm_mode_config_create_initial_state()". Isn't that still needed? Without
> it, the boot SRO is not done at all (which made me think you have additio=
nal
> patches in a local branch).

Both will be fixed in the next version.

> I think you have AM62-SK board without the OLDI display. Even without it,
> you can see what happens when OLDI is enabled by loading the
> k3-am625-sk-microtips-mf101hie-panel.dtbo overlay. You won't see anything
> displayed, of course, but otherwise it should load and work fine, and HDMI
> should continue working.

I'll give it a try, thanks for the pointer.

> I've done some testing, and there are quite a lot of combinations to try
> out:
>=20
> 1) u-boot enables nothing, HDMI, OLDI or HDMI+OLDI, 2) OLDI dtbo loaded or
> not (i.e. kernel see HDMI or HDMI+OLDI), 3) drm.atomic_readout set to 0 or
> 1, 4) a display pipeline's drivers (e.g. OLDI here) missing SRO support, =
but
> other pipelines have SRO, 5) the first use from the userspace is HDMI, OL=
DI
> or both, 6) with and without the drm_mode_config_create_initial_state().
>=20
> So... It's quite a lot of combinations there, and laborious to test. I ha=
ve
> some hack fixes in my local branch, and I'll try to find the time to
> organize them a bit so that I can share them.
>
> But here are a few observations:
>=20
> 1)
>=20
> Setup: No display in u-boot. OLDI dtbo not loaded. Only the
> drm_atomic_helper_colorop_create_state() fixup applied. Afaics behavior h=
ere
> should be exactly as before the series, as SRO is not enabled for tidss.
>=20
> If I enable HDMI after boot, I get:
>=20
> [   38.203024] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in mode_blob blobs don't match
> [   38.203067] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and
> Readout CRTC state don't match
> [  104.468776] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in connector_mask expected 1, got 0
> [  104.468897] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in encoder_mask expected 1, got 0
> [  104.468976] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in mode_blob blobs don't match
> [  104.469047] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and
> Readout CRTC state don't match
>=20
> If I do load OLDI dtbo or set atomic_readout=3D0, I don't see those, as S=
RO
> support gets disabled. My understanding of this issue is that the operati=
on
> overall is fine, but the state comparison doesn't work quite right.

Yes, it's correct. It should be fixed in the next version.

> 2)
>=20
> Setup: HDMI+OLDI in u-boot. OLDI dtbo loaded. Only the
> drm_atomic_helper_colorop_create_state() fixup applied.
>=20
> Enabling both displays after boot gives a sync lost flood and broken disp=
lay
> output.
>=20
> I think the issue here is that tidss does not reset the HW anymore (even =
if
> we don't call drm_mode_config_create_initial_state()), and the driver
> doesn't fully rewrite all the relevant DSS registers (or doesn't do it in=
 a
> correct sequence, as it doesn't expect the VPs to be enabled at this poin=
t).

This should also be fixed in the next version.

> 3)
>=20
> Setup: No display in u-boot. OLDI dtbo loaded.
> drm_mode_config_create_initial_state() applied. So here we have HDMI
> pipeline, where drivers have SRO support, and OLDI, where they don't.
>=20
> Loading the modules gives:
>=20
> [   43.086356] tidss 30200000.dss: [drm] Device doesn't support hardware
> state readout.

That part is expected because of the missing OLDI readout support. I can
*try* to come up with an OLDI readout implementation, but I won't be
able to test it.

> [   43.086417] tidss 30200000.dss: Failed to set DSS PM to active
> [   43.086429] tidss 30200000.dss: [drm] Couldn't reset dispc
>=20
> Otherwise the displays seem to work ok.

That part is not expected though, and should be fixed in the next
version too.

> 4)
>=20
> As 3) but HDMI+OLDI enabled at u-boot.
>=20
> Same outputs at module load time. Using the displays break badly, probably
> because the driver doesn't re-program the registers fully.

Yeah, that's what I would assume too.

> 5)
>=20
> Setup: HDMI u-boot. OLDI dtbo not loaded.
> drm_mode_config_create_initial_state() applied. I think this is the setup
> you have been using.
>=20
> No extra prints when loading modules. Running "kmstest -c hdmi" works fin=
e,
> but prints:
>=20
> [   62.464207] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in mode_blob blobs don't match
> [   62.464252] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and
> Readout CRTC state don't match

This is fixed in the next version

> and when exiting kmstest:
>=20
> [   89.227700] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in connector_mask expected 1, got 0
> [   89.227820] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in encoder_mask expected 1, got 0
> [   89.227898] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in mode_blob blobs don't match
> [   89.227969] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and
> Readout CRTC state don't match

Ditto

> Running kmsblank gives:
>=20
> [  109.381641] tidss 30200000.dss: Timeout waiting for framedone on crtc 1

I'm not sure where this comes from, but it might be a interrupt / reset
issue that was fixed.

> [  109.387107] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in enable expected yes, got no
> [  109.387154] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in bus_format expected 0000100a, got 00000000
> [  109.387181] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration
> mismatch in bus_flags expected 00000046, got 00000000
> [  109.387205] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and
> Readout CRTC state don't match
> [  109.387227] tidss 30200000.dss: [drm] *ERROR* HDMI-A-1 configuration
> mismatch in crtc expected 00000000a0b1f61b, got 000000
> [  109.387255] tidss 30200000.dss: [drm] *ERROR* HDMI-A-1 configuration
> mismatch in best_encoder expected 000000002b9c6290, g0
> [  109.387286] tidss 30200000.dss: [drm] [CONNECTOR:44:HDMI-A-1] Committed
> and Readout connector state don't match
> [  109.387306] tidss 30200000.dss: [drm] *ERROR* bridge-30200000.dss
> configuration mismatch in input_bus_cfg.format expected 0
> [  109.387332] tidss 30200000.dss: [drm] *ERROR* bridge-30200000.dss
> configuration mismatch in input_bus_cfg.flags expected 00
> [  109.387356] tidss 30200000.dss: [drm] *ERROR* bridge-30200000.dss
> configuration mismatch in output_bus_cfg.format expected0
> [  109.387380] tidss 30200000.dss: [drm] *ERROR* bridge-30200000.dss
> configuration mismatch in output_bus_cfg.flags expected 0
> [  109.387403] tidss 30200000.dss: [drm] Committed and Readout private
> object state don't match
> [  109.387420] tidss 30200000.dss: [drm] *ERROR* bridge-1-003b configurat=
ion
> mismatch in input_bus_cfg.format expected 0000100
> [  109.387444] tidss 30200000.dss: [drm] *ERROR* bridge-1-003b configurat=
ion
> mismatch in input_bus_cfg.flags expected 00000040
> [  109.387467] tidss 30200000.dss: [drm] *ERROR* bridge-1-003b configurat=
ion
> mismatch in output_bus_cfg.format expected 000010
> [  109.387491] tidss 30200000.dss: [drm] Committed and Readout private
> object state don't match
> [  109.387507] tidss 30200000.dss: [drm] *ERROR* bridge-connector-hdmi
> configuration mismatch in input_bus_cfg.format expecte0
> [  109.387532] tidss 30200000.dss: [drm] *ERROR* bridge-connector-hdmi
> configuration mismatch in output_bus_cfg.format expect0
> [  109.387555] tidss 30200000.dss: [drm] Committed and Readout private
> object state don't match

This is fixed in the next version

> If I run kmsblank as the first thing after loading modules:
>=20
> [   23.508008] tidss 30200000.dss: [drm] drm_WARN_ON_ONCE(!fb->obj[plane])
> [   23.508210] WARNING: drivers/gpu/drm/drm_gem_framebuffer_helper.c:62 at
> drm_gem_fb_get_obj+0xa4/0x120 [drm_kms_helper], CP5

And that as well. I also tried to add unit tests for the setup that are
easily reproducable so hopefully it won't creep back in.

Thanks again for testing it thoroughly

Maxime

--uywhhqe65eg53vrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCauyjTQAKCRAnX84Zoj2+
djDxAYDVPnRGBZfj9au/4EvCoNy5HAaxwptCjok+KChziwWWg9GAssPsyA5Boi6Q
uMMiAAkBgK3f5V5iwHMm/U5SqwXJscE6zGwpd8y7FhJ4Rc/Y85YTta+9+AbihY4O
dmntM/0n2A==
=YOPf
-----END PGP SIGNATURE-----

--uywhhqe65eg53vrt--
