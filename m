Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F7DD35157
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A2110EA51;
	Wed,  1 Apr 2026 08:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rqJKg0V1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6356C10EA51
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:06:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A936600AD;
 Wed,  1 Apr 2026 08:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F8CC2BC9E;
 Wed,  1 Apr 2026 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775030764;
 bh=vCdXcNhvfsQLq7T5BRej3phIPgo6NGFMKQMcuPzGOwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rqJKg0V1L04Q3f38fKKOlIWP+9kJ7b9nPh/7SkiTWIFS5HV2ZmN4WBl1p7IWmMdpj
 ozbqsG5VzM4xt9qwCtV8Lcg0Lfv31XkuUWJxO6UuEAB9rT+kyqIeAUdBi0Iqc2r9M2
 XzMoJo+T19GRNpNB+5UA4Ies9Bfdt2aZwaeIVXQDscP+OmcNYEoKkV9SedZ+6L8IKQ
 CT3KK/ci1Vi7Lxa+YgcOcm3UkKdiaKDm9Nkw9G8IuFcGnagw1P/upc0jH57Cd7O4eE
 8iCQYg380dUf5Xpo3W4aBb1l4T6efuIN4USC1acqxTznac7+2CtR8tyh5Jxrf68iUW
 tdo8P/vvB+4dg==
Date: Wed, 1 Apr 2026 10:06:01 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2 1/2] drm: Rename drm_atomic_state
Message-ID: <20260401-imperial-tan-emu-0a1ab4@houat>
References: <20260331-drm-drm-atomic-update-v2-0-7e8fe6ddcd32@kernel.org>
 <20260331-drm-drm-atomic-update-v2-1-7e8fe6ddcd32@kernel.org>
 <316d8ab8-78d0-4169-9264-e4da5424b5d6@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="cii5lvz5tahfk45i"
Content-Disposition: inline
In-Reply-To: <316d8ab8-78d0-4169-9264-e4da5424b5d6@suse.de>
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


--cii5lvz5tahfk45i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] drm: Rename drm_atomic_state
MIME-Version: 1.0

Hi Thomas,

On Wed, Apr 01, 2026 at 08:05:12AM +0200, Thomas Zimmermann wrote:
> Am 31.03.26 um 16:41 schrieb Maxime Ripard:
> > The KMS framework uses two slightly different definitions for the state
> > concept. For a given object (plane, CRTC, encoder, etc., so
> > drm_$OBJECT_state), the state is the entire state of that object.
> > However, at the device level, drm_atomic_state refers to a state update
> > for a limited number of objects.
> >=20
> > Thus, drm_atomic_state isn't the entire device state, but only the full
> > state of some objects in that device. This has been an endless source of
> > confusion and thus bugs.
> >=20
> > We can rename drm_atomic_state to drm_atomic_commit to make it less
> > confusing.
>=20
> Nit: The subject should already spell out the new name.
>=20
> >=20
> > This patch was created using:
> >=20
> > rg -l drm_atomic_state | \
> > 	xargs sed -i 's/drm_atomic_state/drm_atomic_commit/g; s/drm_atomic_com=
mit_helper/drm_atomic_state_helper/g'
> > mv drivers/gpu/drm/tests/drm_atomic_state_test.c drivers/gpu/drm/tests/=
drm_atomic_commit_test.c
>=20
> We now have many places that read like "struct drm_atomic_commit *state',
> which mixes up terminology. Is there a way of transforming this
> automatically to use 'commit' for the variable's name?

I know what you're saying, but it would be much more intrusive and I'm
not sure I feel comfortable doing it in one go. I had a try this morning
to come up with a coccinelle script and it looks like it chokes up a bit
on it too.

I'm sure we could blame my coccinelle skills, but how about we do this
driver by driver later on? I can do it if you want me to, and we don't
really need to have that one big commit, it can be split into smaller
units that would be easier to test and merge.

Maxime

--cii5lvz5tahfk45i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaczR6AAKCRAnX84Zoj2+
diwJAX4uy/nV3NPKiK3qmQeMnzfxOpb6SoFRToie/uY1bnwzT4DvI1PBDpupJ2b7
1TPui7YBf0tYnfE8f570AUNIYHDpDbX7FlYZwmcTtk0dNFPKYel3cDoxReDbmNAk
0gu5asfI9w==
=BLVN
-----END PGP SIGNATURE-----

--cii5lvz5tahfk45i--
