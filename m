Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E913606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVkoQkOR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B1610E1E0;
	Fri, 27 Nov 2026 15:16:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EDC112B8F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:15:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF73F61944;
 Fri, 27 Nov 2026 15:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03441F000C1;
 Fri, 27 Nov 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795792551;
 bh=L7x9V0qToZLTEdQ1HTTT73t/Q+ZD1b9oW87mogqiW6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lVkoQkOR93S7ZE9fd/E5RRAwJ8ohzAh0VHqUV0b1lmipwx6N3Xv5CNTEmGqOgUOer
 yT4Izv+ARbJQ0VTlfZMwT5LSZC+sZicKnMuhbDi20hu4/rrWJJg5jFJUCF5UdA0lP4
 UKryk6CSbzrfV/qyguKiHJFINJ6LFt4ef/N0NKaq3ti4MyAmlsHOcJIPQ5yOJxz4na
 7YJOQmbGARFCtyH1sMd6uvM8XidBqYBoMug1cH/Fi7rKUSicWlUpfbUqAaQ6z75TgC
 6Gd8BHQkRY2Y0MVU25/hxw36RDfZ8pTPDhWQqobr8hlS8PfTx1VAsJ6TO94ddGO9Cm
 JXsEP8RUkad/A==
Date: Fri, 27 Nov 2026 16:15:48 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] drm/tests: edid: Fix conformity for 1080p+4K
 YUV420 200MHz EDID
Message-ID: <awmdNUS9uM6h4lfK@houat>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-13-20e8a33a2286@collabora.com>
 <awRgyldN6JaiisFJ@houat>
 <6f58183d-1bde-4b6d-b09c-094c97732609@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="mmlvv6fbggntzvkb"
Content-Disposition: inline
In-Reply-To: <6f58183d-1bde-4b6d-b09c-094c97732609@collabora.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--mmlvv6fbggntzvkb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 13/25] drm/tests: edid: Fix conformity for 1080p+4K
 YUV420 200MHz EDID
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 10:08:36PM +0200, Cristian Ciocaltea wrote:
> On 11/23/26 5:51 PM, Maxime Ripard wrote:
> > On Sat, Nov 14, 2026 at 08:03:37PM +0200, Cristian Ciocaltea wrote:
> >> The test EDID added by commit 58fe1d78605e ("drm/tests: hdmi: Provide
> >> EDID supporting 4K@30Hz with YUV420 only") fails 'edid-decode --check'
> >> (v1.33.0) with the following issues:
> >>
> >>   Warnings:
> >>
> >>   Block 1, CTA-861 Extension Block:
> >>     IT Video Formats are overscanned by default, but normally this sho=
uld be underscanned.
> >>     YCbCr 4:2:0 Video Data Block: Some YCbCr 4:2:0 timings are invalid=
 for HDMI 2.1
> >>       (which requires an RGB timings pixel rate >=3D 590 MHz).
> >>   EDID:
> >>     Base EDID: Some timings are out of range of the Monitor Ranges:
> >>       Maximum Clock: 297.000 MHz (Monitor: 170.000 MHz)
> >>     CTA-861: Multiple native progressive timings are defined.
> >>
> >>   Failures:
> >>
> >>   Block 0, Base EDID:
> >>     Vendor & Product Identification: EDID 1.3 does not support week 0x=
ff.
> >>   Block 1, CTA-861 Extension Block:
> >>     Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8: Max TMDS ra=
te is > 0 and <=3D 340 or > 600.
> >>     YCbCr 4:2:0 Capability Map Data Block: Empty Capability Map.
> >>     YCbCr 4:2:0 Video Data Block: YCbCr 4:2:0-only VIC 95 is also a re=
gular VIC.
> >>     Missing VCDB, needed for Set Selectable RGB Quantization to avoid =
interop issues.
> >>   EDID:
> >>     CTA-861: The maximum HDMI TMDS clock is 200000 kHz, but one or mor=
e video timings go up to 297000 kHz.
> >>
>=20
> [...]
>=20
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> >=20
> > I've been collecting descriptions of these EDIDs here:
> > https://github.com/mripard/redid/tree/main/edid-generator/samples
> >=20
> > If you ever have the chance or the motivation, it would be great to
> > submit a sample for this one.
>=20
> Oh, nice, you have a tool!  Just had a quick look at
> https://github.com/mripard/redid/blob/main/redid/README.md - are YCbCr 4:=
2:0
> Video and Capability Map Data blocks not yet supported?

Yeah, I don't have it working yet. It shouldn't be too hard though

> Regardless, I will give it a try and share the sample.
>=20
> FWIW, I initially used wxedid to generate basic EDIDs, then resorted to m=
anual
> hex editing for the more advanced stuff, which was always painful.  Havin=
g a
> proper tool for that would help a lot.

Yeah, it's exactly why I built it in the first place :)

Maxime

--mmlvv6fbggntzvkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawmenQAKCRAnX84Zoj2+
dpfQAX4wsb2lnYHbG40/44TQTR7iiCWSOGV4bBz3fdjmMy4x8zGvL6S7Tv09UZZd
3V6m0nUBf2ImpwvgVPhX8YvZpXpLjw0rn8jsbJaCv0K3kwHxN2HGAODw+m26XajW
EExa4DJ/Vw==
=i46e
-----END PGP SIGNATURE-----

--mmlvv6fbggntzvkb--
