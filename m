Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB78C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2676110E834;
	Mon, 13 Jul 2026 07:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZOZVCVrE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9316510E818
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:11:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4E676136B;
 Mon, 13 Jul 2026 07:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD691F000E9;
 Mon, 13 Jul 2026 07:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783926714;
 bh=V0SQazfmiiDid/ub71XMFNMwikO65Q1xOsWBI2MU7TE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZOZVCVrEFOzlje9n34CxwxIMMkQDMJJG7xi422dkfRoOhhJE7rnttLW/PDJe9fFMm
 CLVwZGKMH9F7caqiWLGKEfL5VudHkzazNc8RH8af3newjz1bZfPte9CpHU/gLtLBIJ
 nZqvUhoXLHwYZWnfDvilLdQ+KAaJja8+E2kQaETYxd38pJUphNksur326xvX9ddmly
 gn5jxm5qn/mguix6GWiVoPafDZrt2pjyUW1riQCmC0JfehlxyglKZ4HnGBIAQUhuqc
 qmGwOblBkZCR9b/sgSpLxgYtgRQH5xmmvfU6cg7CmKQ0RL0L+9PKbytdQ3pq4TVlYI
 Gg1NFhbBbvHMA==
Date: Mon, 13 Jul 2026 09:11:52 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>,
 Jonas =?utf-8?B?w4VkYWhs?= <jadahl@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, 
 Simon Ser <contact@emersion.fr>, Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
Message-ID: <20260713-amphibian-fair-sponge-f3de96@houat>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
 <fd3b9da8-6ccc-4730-b8ff-08cfcfa286a9@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="6kmo46d4vwwqliwk"
Content-Disposition: inline
In-Reply-To: <fd3b9da8-6ccc-4730-b8ff-08cfcfa286a9@mailbox.org>
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


--6kmo46d4vwwqliwk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
MIME-Version: 1.0

Hi Michel,

On Fri, Jul 10, 2026 at 07:01:29PM +0200, Michel D=E4nzer wrote:
> On 7/8/26 18:08, Maxime Ripard wrote:
> >=20
> > Userspace currently has no atomic way to bring a display pipeline back
> > to a pristine state. A compositor that wants to start from a known
> > baseline must explicitly set every property on every KMS object to its
> > default value, which requires tracking which properties exist and what
> > their defaults are. This is fragile and must be updated every time a
> > new property is added to the kernel.
> >=20
> > This series introduces a new DRM_MODE_ATOMIC_RESET flag for the
> > atomic ioctl. When set, the kernel fills the commit with default
> > states for all KMS objects before applying the properties supplied in
> > the request. Properties not explicitly included remain at their
> > defaults (CRTCs inactive, planes disabled, connectors unbound, and so
> > on). This allows userspace to describe the desired end state
> > declaratively, without having to care about the current state or the
> > full set of properties.
>=20
> Nice!
>=20
>=20
> > Patch 8 wires it all up by adding DRM_MODE_ATOMIC_RESET to the atomic
> > ioctl.
>=20
> The new flag should be accompanied by a new DRM_CAP_* cap, so user
> space knows when the new flag is valid.

Ack.

> > This series is untested and relies on all drivers implementing the
> > atomic_create_state hook, which is not yet the case. The conversion
> > is actively in progress but not complete, so this will not work as-is
> > today.
>=20
> As discussed on IRC, the new cap could be made conditional on the
> atomic_create_state hook being available. That would allow this series
> to land before all in-tree drivers are converted. (As a bonus, it
> would also avoid issues with out-of-tree drivers which might not
> support the atomic_create_state hook)

My initial reaction when we discussed it on IRC was that the conversion
=66rom reset to atomic_create_state is going to remove reset, so by the
time it's merged, an out-of-tree driver that wouldn't implement
atomic_create_state would not compile.

That being said, I just remembered that i915 implements neither, so it's
a good thing to have indeed.

Maxime

--6kmo46d4vwwqliwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCalSPtwAKCRAnX84Zoj2+
djsqAYDBFbu/FMTGy1QenpQD+E7YhaAoi5SxA0OuHErTcZqv3X0HqP5JMSNX0uOk
gBPgyOABgNFgIIK7MVoeYkzBt2SSRjufnKDEdTrpHJqeByuoVYUxIllgGp/45f8y
pperuBwGZw==
=2ZXg
-----END PGP SIGNATURE-----

--6kmo46d4vwwqliwk--
