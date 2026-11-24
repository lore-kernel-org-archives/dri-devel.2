Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9684606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUOea5E+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391DC10E783;
	Tue, 24 Nov 2026 12:28:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D41810E673
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:28:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF1C760A51;
 Tue, 24 Nov 2026 12:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B8F1F000C0;
 Tue, 24 Nov 2026 12:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523300;
 bh=7f25TEck76ebYpJm5NjThDprII1eST8kyyN/uz7hOMk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hUOea5E+EnY04+GXTcwAcuvUeyyQYd7bKb0HSjYJb31QGxbJded6V6p8tmGviKVN0
 UYeArEXuldYLX2Gh6+3cF04HMrd6Gt6Ri800IfKZADTWC5KuQ9St3vQwbYBeZ+adta
 VwL+UzzZqhJxOGz1rC5Rlgmrn+7c0sHc0yqd8fcIC425nnLMUwPMstA7vWyN0CorNj
 SHSPUMr+L/dlcICUAQuGxt9vk4QJt34U0UDd8avEsRvvbFqxy9GMeuxgXbqGK0/H8r
 nOE93sXHj6hqMbRyn2XB68J2cevy8u+5siLQs9w5W5cWVU6mDqSlC9AtGubpnLfGYG
 IDBW83yhljHGQ==
Date: Tue, 24 Nov 2026 13:28:17 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Brian Masney <bmasney@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 15/42] drm/atomic_sro: Add atomic state readout
 infrastructure
Message-ID: <awWAd4GbeBziItCE@houat>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-15-a67c2b45b8ec@kernel.org>
 <898d050d-9c19-4706-b1b2-ff3e23d68efe@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="5qb6piljzpylluk3"
Content-Disposition: inline
In-Reply-To: <898d050d-9c19-4706-b1b2-ff3e23d68efe@rock-chips.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--5qb6piljzpylluk3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 15/42] drm/atomic_sro: Add atomic state readout
 infrastructure
MIME-Version: 1.0

Hi Chaoyi,

On Tue, Nov 24, 2026 at 11:54:03AM +0800, Chaoyi Chen wrote:
> Hi Maxime,
>=20
> For a long time, we have implemented something similar through our own
> hack. Thank you very much for this series.

I'm glad it's useful :)

> Please see below:
>=20
> On 11/20/2026 8:55 PM, Maxime Ripard wrote:
> > In order to enable drivers to read their initial state from the
> > hardware, each KMS object needs a hook to fill a pre-allocated state
> > from the hardware registers.
> >=20
> > Introduce the atomic_sro_readout_state hook in every KMS object funcs
> > vtable: drm_crtc_funcs, drm_plane_funcs, drm_connector_funcs,
> > drm_bridge_funcs, and drm_private_state_funcs.
> >=20
> > Also introduce the drm_mode_config_funcs.atomic_sro_readout_state and
> > drm_mode_config_helper_funcs.atomic_sro_build_state hooks, which are the
> > top-level entry points for drivers and helpers respectively.
> >=20
> > The states read out aren't the current states of the objects yet, so
> > they also need to be installed. Introduce the
> > drm_mode_config_helper_funcs.atomic_sro_install_state hook to install a
> > whole drm_atomic_sro_state, and an optional atomic_sro_install_state
> > hook in drm_crtc_funcs, drm_plane_funcs, drm_connector_funcs and
> > drm_private_state_funcs. The latter is called before the state of an
> > object is replaced, so that drivers can acquire the resources needed to
> > keep the hardware state active.
> >=20
> > Finally, add drm_atomic_sro_can_readout() to verify that all objects on
> > a device implement the readout hook, and wire it into
> > drm_atomic_sro_device_can_readout().
> >=20
> > Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
>=20
> [...]
>=20
> > +
> > +	/**
> > +	 * @atomic_sro_install_state:
> > +	 *
> > +	 * This optional hook is called when a state read out from
> > +	 * hardware is about to be installed as the plane's current
> > +	 * state.
> > +	 *
> > +	 * It allows drivers to acquire the resources needed to keep
> > +	 * the current hardware state active, such as power domains,
> > +	 * clocks, or interrupts.
> > +	 *
> > +	 * This hook cannot fail. It is called by the
> > +	 * &drm_mode_config_helper_funcs.atomic_sro_install_state
> > +	 * implementation, which is part of the hardware state readout
> > +	 * initialization sequence.
> > +	 */
> > +	void (*atomic_sro_install_state)(struct drm_plane *plane,
> > +					 struct drm_plane_state *plane_state);
> > +
>=20
> Due to the presence of clk_disable_unused(), the relevant clk is likely
> to be disabled prematurely, which may cause symptoms such as a black
> screen.=20
>=20
> How does atomic_sro_install_state() ensure that it is called early enough,
> thereby enabling the driver to turn on the corresponding clock?
>=20
> Or is this something that driver implementers need to consider, and should
> the DRM core provide some kind of helper? Thank you.

I guess you have mainly three options, depending on what your preferred
setup is:

- If your display driver is compiled as a built-in, it's a non-issue
  since the read-out will have been done before clk_disable_unused()
  runs.

- The typical "distro" setup is that simpledrm will be builtin, grab the
  clock, we'll then load the driver as a module, do the readout, call
  install_state to get a clock reference and then drop simpledrm and its
  clock reference.

  In such a case, you always have a prepare / enable count > 1 so the
  clock never gets disabled by clk_disable_unused().

- If you don't want to have simpledrm but have the display driver as a
  module, and thus need to keep the clock running even though
  clk_disable_unused runs, I guess your best bet is to look into the
  sync_state Brian has been working on:
  https://lore.kernel.org/linux-clk/20260626-clk-sync-state-v1-0-4156d8196d=
c8@redhat.com/

Maxime

--5qb6piljzpylluk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawWC2gAKCRAnX84Zoj2+
dmNNAYDETTcwpBzXsFQu/myrdWIzvQOZdlY9N3xUE8+iBL2lEDAVDNNx29wRpC16
miFLcoUBewUypu8WCEJyHbmu1LKXgf6DS1GAm/gBdAuaMUXlOAfzt9eInDNHrLz7
GmCxiTMsAQ==
=E+w8
-----END PGP SIGNATURE-----

--5qb6piljzpylluk3--
