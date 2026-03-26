Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D08110A62D6
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1BFA10E1BC;
	Thu, 26 Mar 2026 13:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BMw/VYn4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F35E10E1BC;
 Thu, 26 Mar 2026 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774533190;
 bh=yG7YSDPLmI1ryww7nMsH23b6orKyZanWG826+VZw/cE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BMw/VYn4oxv3aU6wgZxmHGozzpgi0NrsodhdFLO5uWNDzh+eyrh8G5BE+aDLsxwnk
 H3Rd0mZ2ySLXKPTal8GWWnV9IvzLCVBUDNtfdlfNPI4LgrzqnUBKmP++XW1CgnSZ/w
 lGVXaBl7pAwtwT36tJ160IsaZ8PI6rmNyBVNhjkac8RRtlaAyTfHtNQuYUFGlMzDVm
 RfZyS/58ixjrzWBM4bHyjTR0X34ejynhdmv3NCpm5R/I/4l21tg1TlOiHxIx+vExir
 V3kH5ZLTvc96vwfQhhHQJiObrgq2QGDXDxyOhXz44xLrKjJJ7+ze1JTBFAmNQc28pA
 CdiZBHaAuOt1A==
Received: from fluorite (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 219AB17E609D;
 Thu, 26 Mar 2026 14:53:09 +0100 (CET)
Date: Thu, 26 Mar 2026 15:53:05 +0200
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Alex
 Deucher <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Ville =?UTF-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com, Derek Foreman
 <derek.foreman@collabora.com>, Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Message-ID: <20260326155305.736b4e64@fluorite>
In-Reply-To: <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eXQlGv.+Nh6qks6CpJaig2v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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

--Sig_/eXQlGv.+Nh6qks6CpJaig2v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michel,

I have some opinions as well.

On Tue, 24 Mar 2026 17:44:21 +0100
Michel D=C3=A4nzer <michel.daenzer@mailbox.org> wrote:

> Per my previous posts, my concerns are:
>=20
> * The meaning of the "link bpc" property value isn't defined well
> enough vs things like dithering or DSC, which will likely result in
> compositors / users overestimating what value they need / want,
> resulting in compositors spuriously rejecting configurations which
> would work perfectly fine, and/or spurious issue reports.

That is ok. Compositors need to understand what the numbers mean, how
reliable they are, and act accordingly. Knowing the lower bound for
link precision is already useful as it guarantees a minimum precision.
It is up to the compositors to decide how they communicate this.

Or course, assuming lossy compression is not too lossy. Maybe
lossy compression should be forbidden by default unless explicitly
enabled by userspace?

> With my compositor developer hat on, what I'd want to know is
> something like: "How many bits of information can be passed over the
> link, allowing the display to present it in a way which can be
> perceived by the user?" With dithering or DSC, that would be a higher
> value than the physical link bpc.

Sure, but this is not that. This is only a part of that. You would
also want to know what the monitor does with the signal, the depth of
the data path to the panel, and so on. I'm sure those are completely
off-topic for a KMS property.

The kernel driver won't know how acceptable temporal dithering, spatial
dithering or lossy compression are, so I don't think it should be
deciding how many bits of precision they add or subtract. Exactly this
makes the link bpc property a well-defined fact rather than an estimate.

The documentation of 'link bpc' could be more explicit about this.

>=20
> * There's no clear use case.
>=20
> This is generally a requirement for new KMS UAPI.
>=20
> The practical usefulness of the corresponding weston MR is dubious
> per the concern above.

I think the example of RGB 10 bpc to be degraded to YCbCr 10 bpc rather
than RGB 8 bpc is an excellent use case. I had another use case in
https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850#note_31=
15686

Mario Kleiner had excellent cases as well.

Maybe these just need to be spelled more clearly in the commit message.

> > That the link-bpc property does not consider DSC and dithering?
> > Two things which the max-bpc property also does not consider? =20
>=20
> It's not (as much of) an issue with the "max bpc" property because
> it's just an upper limit, the driver is free to use a lower effective
> bpc.

FWIW, 'max bpc' is a workaround for faulty sink devices that claim to
handle a depth but silently misbehave. This is also why I called for a
"desired bpc" setting in the Weston MR, to not confuse with the "max
bpc" setting.


Thanks,
pq

--Sig_/eXQlGv.+Nh6qks6CpJaig2v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmnFOkEACgkQI1/ltBGq
qqfIXA//digfbcOx5QZhTww+D1ISYChsBDXUVIx9U+SVRgSPxzltYE3A2e+P9nzq
RrhWxAQAOy9DtsbeRuxbEx5OtXXAmkVod77y0/wIqUvwbHcxgjXSfixjDm1af8Hy
oUamdknpQTDHRGgVUwickdaU+rvHf7+Bmru9kBmZ5yN0rQ7Sevq5rwUjygBsWEaH
HfAsQYew3RXEdCxj36NHXPFVY4DykAea3Llwhl0lhP3yz9T2ooR78D+c0u7hs+pL
kdad12pYDh4ADQho4Ny/qPyAnce007UZZ9nEHvZTM4ekmZnuiwJCRj8JPumt+wLV
q73W7gIAb+78Pevf9RP2UFL6Mf02A6l08HJqCW6cH1QzLrtmVGIO6a9rG6pWLEH5
sbyozItKH0/ZGWtCDz1iDRi9976DysvKt5GDUcZWxa3ZComOvvcau9HmeB9ECqA0
nend8VFUYp5ZVT7iyS4Srlm21ok57cgGInKtMBSCfdz7/3Lqz9ZOHRBWQZhMSTYU
8unNVp1U+qBfhaRuHPFDTGkjRRyX/PIHyquNHXAo3fL29DO72xge6vmamQph0Ugd
SvrkaEYp65BsB6PBZRe5/OifXlP17Br9tvnIwPXnyxhhHzwD2Pqx+/Q4og5fneiO
tHFt428SwUwVAAyqwVMfJk3iYaIQXyOxWdxx/WwKY9TV1a5TvLs=
=VXjn
-----END PGP SIGNATURE-----

--Sig_/eXQlGv.+Nh6qks6CpJaig2v--
