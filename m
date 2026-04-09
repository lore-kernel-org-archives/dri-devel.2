Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2D5F31E24
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B842010E816;
	Thu,  9 Apr 2026 15:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hTZ1zhKv";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5326410E816;
 Thu,  9 Apr 2026 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775747116;
 bh=njEfQhSNjU32s17L2d4TAimuJampYgAZWfO8+3FgIoA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=hTZ1zhKvuqpF4WA7yeUShw0AQafg6qSyyoj1LVuAW8twVDdBZb4kLLQG0HokwNvBB
 cgzS/yOaQWylFOntQMVK5pYhiJKxyLu+uFbOnIFOKQ6dcg96kxEYGoR+S2+A+Hghpx
 cNyiBOtfhDtkdYMuHeGOFaBmL9IwhATW4oQ9ebx5MLxrhNEKODmXm1OY955a4plcck
 fF1xH+Mm3w54CyU1giWpiQcT10a+WcBLGA4MjQpvzGT5RrpK5XRkRJnHxnqjWl1bSz
 REoWqczT1RtFbA4bDMMPnQ35vk3pyCh2RuB2OdlV+jfUJ4CVX2/j+7NXzzvb0/MMm7
 QOVEdEuZ66cSg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: nicolas)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2744017E137E;
 Thu,  9 Apr 2026 17:05:14 +0200 (CEST)
Message-ID: <b02fc0752b7c4b567e3628ffada1317cb2967610.camel@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>, Pekka Paalanen
 <pekka.paalanen@collabora.com>, Michel =?ISO-8859-1?Q?D=E4nzer?=
 <michel.daenzer@mailbox.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Leo Li	 <sunpeng.li@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, Alex Deucher	 <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Ville
 =?ISO-8859-1?Q?Syrj=E4l=E4?=	 <ville.syrjala@linux.intel.com>, Daniel Stone
 <daniels@collabora.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	amd-gfx@lists.freedesktop.org,
 kernel@collabora.com, Derek Foreman	 <derek.foreman@collabora.com>, Marius
 Vlad <marius.vlad@collabora.com>
Date: Thu, 09 Apr 2026 11:05:12 -0400
In-Reply-To: <7461820c-e3ab-40f5-98d2-9878e60ba2ad@amd.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <20260326155305.736b4e64@fluorite>
 <7461820c-e3ab-40f5-98d2-9878e60ba2ad@amd.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-JnhPg60M+5/DW5fs4JwT"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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


--=-JnhPg60M+5/DW5fs4JwT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 30 mars 2026 =C3=A0 15:01 -0400, Harry Wentland a =C3=A9crit=C2=A0=
:
>=20
>=20
> On 2026-03-26 09:53, Pekka Paalanen wrote:
> > Hi Michel,
> >=20
> > I have some opinions as well.
> >=20
> > On Tue, 24 Mar 2026 17:44:21 +0100
> > Michel D=C3=A4nzer <michel.daenzer@mailbox.org> wrote:
> >=20
> > > Per my previous posts, my concerns are:
> > >=20
> > > * The meaning of the "link bpc" property value isn't defined well
> > > enough vs things like dithering or DSC, which will likely result in
> > > compositors / users overestimating what value they need / want,
> > > resulting in compositors spuriously rejecting configurations which
> > > would work perfectly fine, and/or spurious issue reports.
> >=20
> > That is ok. Compositors need to understand what the numbers mean, how
> > reliable they are, and act accordingly. Knowing the lower bound for
> > link precision is already useful as it guarantees a minimum precision.
> > It is up to the compositors to decide how they communicate this.
> >=20
> > Or course, assuming lossy compression is not too lossy. Maybe
> > lossy compression should be forbidden by default unless explicitly
> > enabled by userspace?
> >=20
>=20
> I disagree. While technically lossy, DSC is perceptually lossless, at
> least according to the designers of DSC. If I'm not mistaken this is
> all based on extensive studies.
>=20
> The decision to enable DSC or not has an impact on the power consumption
> of the HW, in ways that are often nuanced. Userspace has no way to know
> or understand these nuances. This should be in control of the driver.

Just my two cent, I can imagine HDMI to be used as a transport between two =
live
post-production modules. In such a use case, the driver may be programmed t=
o
save power, while in practice the user wants absolutly now loss, since thes=
e
adds up like the photocopy of the photocopy, and the studied "virtually los=
s-
less" effect is now gone.

>=20
> At most I could see a "never do DSC or dither" toggle, if one is really
> concerned about this, but I don't realistically see use-cases where this
> would improve user experience, even for users that care about color work
> and correctness.

But an opt-out solution works too.

Nicolas

>=20
> The YCbCr420 case is different. We probably want a way for userspace to
> understand that half 3/4 of chroma values are being tossed out. This
> would be significant for RGB content but insignificant for YCbCr420
> content.
>=20
> Harry
>=20
> > > With my compositor developer hat on, what I'd want to know is
> > > something like: "How many bits of information can be passed over the
> > > link, allowing the display to present it in a way which can be
> > > perceived by the user?" With dithering or DSC, that would be a higher
> > > value than the physical link bpc.
> >=20
> > Sure, but this is not that. This is only a part of that. You would
> > also want to know what the monitor does with the signal, the depth of
> > the data path to the panel, and so on. I'm sure those are completely
> > off-topic for a KMS property.
> >=20
> > The kernel driver won't know how acceptable temporal dithering, spatial
> > dithering or lossy compression are, so I don't think it should be
> > deciding how many bits of precision they add or subtract. Exactly this
> > makes the link bpc property a well-defined fact rather than an estimate=
.
> >=20
> > The documentation of 'link bpc' could be more explicit about this.
> >=20
> > >=20
> > > * There's no clear use case.
> > >=20
> > > This is generally a requirement for new KMS UAPI.
> > >=20
> > > The practical usefulness of the corresponding weston MR is dubious
> > > per the concern above.
> >=20
> > I think the example of RGB 10 bpc to be degraded to YCbCr 10 bpc rather
> > than RGB 8 bpc is an excellent use case. I had another use case in
> > https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850#not=
e_3115686
> >=20
> > Mario Kleiner had excellent cases as well.
> >=20
> > Maybe these just need to be spelled more clearly in the commit message.
> >=20
> > > > That the link-bpc property does not consider DSC and dithering?
> > > > Two things which the max-bpc property also does not consider?=C2=A0=
=20
> > >=20
> > > It's not (as much of) an issue with the "max bpc" property because
> > > it's just an upper limit, the driver is free to use a lower effective
> > > bpc.
> >=20
> > FWIW, 'max bpc' is a workaround for faulty sink devices that claim to
> > handle a depth but silently misbehave. This is also why I called for a
> > "desired bpc" setting in the Weston MR, to not confuse with the "max
> > bpc" setting.
> >=20
> >=20
> > Thanks,
> > pq

--=-JnhPg60M+5/DW5fs4JwT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCadfAKAAKCRDZQZRRKWBy
9GuYAP0TQ2ZEHIOZc5bf+TaJ3FJJnaVmOiVergJCUzBZhoQxrQEAu5ujoGzDRDg5
DraF15z7cxvva5nk3+PLjGP9pUTpGAM=
=65gq
-----END PGP SIGNATURE-----

--=-JnhPg60M+5/DW5fs4JwT--
