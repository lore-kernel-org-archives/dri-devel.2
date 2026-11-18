Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47221606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcu3Bcft
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A450510FA73;
	Wed, 18 Nov 2026 10:10:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5B410FA83
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:10:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D716F60D39;
 Wed, 18 Nov 2026 10:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA661F000C5;
 Wed, 18 Nov 2026 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794996602;
 bh=DoMckYoKdu7Z9ax/XsuTtFpypLo4z5isA4l1uBoyPYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gcu3Bcftn6dAHbkxIin/4uGPQ01m/VYqdmXFHCvmE6NsWRLnt4SYdeAeQyWrdgZnn
 g/whzo/7xzBvGFK3hK9ejuxPvEV/GBu+RZoBbVGSPCe5UpkXriugdncw0zoZULHhZk
 CFyGPe1E527/xv5Sji4r6US7rxKbgRsrdbIALviDEpaVraq+kiotiVXyM/LRjCyiUr
 NlGvmw64cWWr6rMXfVl6jHDtaUZEBajyK8QpoU8vSBnxr7qjsUthGOLbRuDZGIHpn9
 FulghWf14wMKHWSF8T0nwoCFVkoDss6kdaP5c7uIGxC5GLvyO9lYUQqXQeuvob+wWB
 tVrcle0oQXzvQ==
Date: Wed, 18 Nov 2026 11:09:59 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Henry Zhang <henryzhang62@gmail.com>
Cc: dave.stevenson@raspberrypi.com, mcanal@igalia.com, 
 kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: dsi: Allocate the encoder per DRM device
Message-ID: <av11cTfEuyFJW5h8@houat>
References: <20261117205902.1293962-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="v3jyya4i3brhq7hu"
Content-Disposition: inline
In-Reply-To: <20261117205902.1293962-1-henryzhang62@gmail.com>
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


--v3jyya4i3brhq7hu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/vc4: dsi: Allocate the encoder per DRM device
MIME-Version: 1.0

On Tue, Nov 17, 2026 at 12:59:02PM -0800, Henry Zhang wrote:
> The DSI encoder is embedded in struct vc4_dsi, which lives as long as
> the DSI platform device

That's not true.

It's allocated with devm_drm_bridge_alloc() that will *not* free it in
remove but give away its reference there.

We have another reference taken in vc4_dsi_bind, that is only given up
through a drm-managed action and thus will only be freed when the DRM
device is destroyed.

> but it is initialised with drmm_encoder_init() and so is only cleaned
> up when the DRM device is released. The DRM device can outlive the
> unbind of the vc4 components: unloading the DSI panel driver detaches
> from the DSI host, which deletes the DSI component and unbinds the
> whole vc4 DRM device, but a compositor that keeps the DRM device open
> keeps it alive.

All vc4 components should be tied to the DRM device lifetime so that's
not generally correct either. Something might have snuck back in though.

Also, generally speaking, unloading panel drivers is unsupported at this
point. It's a work in progress, but requires more changes to be safe.

> If the panel driver is loaded again before that, the new DRM device
> binds the DSI component and calls drmm_encoder_init() on the encoder
> that is still on the old DRM device's encoder list. The old device's
> release later cleans it up from under the new one. On a Raspberry Pi 4
> with a 6.18-based kernel, closing the old DRM device then gave:
>=20
>   WARNING: drivers/gpu/drm/drm_encoder.c:214 at drmm_encoder_alloc_releas=
e+0x30/0x40 [drm]
>   Call trace: drmm_encoder_alloc_release <- drm_dev_put <- drm_gem_dmabuf=
_release <- __fput
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
0000000000008
>   pc : drm_mode_config_cleanup+0x5c/0x2f0 [drm]
>   Call trace: drm_mode_config_cleanup <- drm_managed_release <- drm_dev_p=
ut

This is surprising though. I'd like to see a detailed analysis of what's
actually going on on mainline because it doesn't look right.

Maxime

--v3jyya4i3brhq7hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCav15cgAKCRAnX84Zoj2+
dgkVAYCHfb/2RGAae3Uu+c4hKs/QDoJBDl+iVe0Ls2NpAt7zm/YwOA1ybguZLADC
NznXLdwBgPsqmB8ZJZA+22TcKbrrv5w5u43mkIGlccrWm53UEOn4mgi3pjqUaUNJ
VXr5yrCipA==
=2beH
-----END PGP SIGNATURE-----

--v3jyya4i3brhq7hu--
