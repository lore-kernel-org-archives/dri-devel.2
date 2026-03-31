Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E3E1061B3F
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0FC10EB4E;
	Tue, 31 Mar 2026 12:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FS6kXAmF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37BCB10EB4E;
 Tue, 31 Mar 2026 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774960691;
 bh=S0CKoNmtiR80EiXI1XqQCW2Q8QkoknvLl0vsGXaPoFk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FS6kXAmFfYfAZ4FCoHYbUM3HJGh6s0riKivkg8zLsr1VMSNQ9VLSKc75pjbP9MR5v
 nkHoZPifWHHmj0FJR9D5/AIRqaj8+itdeM+nZUbXudWOsG22T9gha0aERXKIZqlRDf
 vYGlSTY7m+WyiWyqz9+W0/31WZpWXVpL6x1TQyDinpkCrCPM5MBHmr3+XUyA5gfxgz
 b5t+Y86+LqIeQhP7L5aPf41abHNIaRiYehEF0yP/di5My0EerhJXjkNQ76rhxIuzpJ
 vX/J+EuLyHMbAMGueXNmaVLvd8VQX8PJZrjO5x4rJsfN0d0CUfZOD3cBDbEJU2Rj05
 VX60VIMcZ7k+g==
Received: from fluorite (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2255317E62F0;
 Tue, 31 Mar 2026 14:38:10 +0200 (CEST)
Date: Tue, 31 Mar 2026 15:38:05 +0300
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
Message-ID: <20260331153805.376486e2@fluorite>
In-Reply-To: <47325395-3790-4cb4-8efd-84a3d8ddb80c@mailbox.org>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <20260326155305.736b4e64@fluorite>
 <47325395-3790-4cb4-8efd-84a3d8ddb80c@mailbox.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5fH5pBa3XUnIzyJWR4ys.0y";
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

--Sig_/5fH5pBa3XUnIzyJWR4ys.0y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2026 10:01:59 +0200
Michel D=C3=A4nzer <michel.daenzer@mailbox.org> wrote:

> On 3/26/26 14:53, Pekka Paalanen wrote:
> > On Tue, 24 Mar 2026 17:44:21 +0100
> > Michel D=C3=A4nzer <michel.daenzer@mailbox.org> wrote:
> >  =20
> >> Per my previous posts, my concerns are:
> >>
> >> * The meaning of the "link bpc" property value isn't defined well
> >> enough vs things like dithering or DSC, which will likely result in
> >> compositors / users overestimating what value they need / want,
> >> resulting in compositors spuriously rejecting configurations which
> >> would work perfectly fine, and/or spurious issue reports. =20
> >=20
> > That is ok. Compositors need to understand what the numbers mean, how
> > reliable they are, and act accordingly. Knowing the lower bound for
> > link precision is already useful as it guarantees a minimum precision. =
=20
>=20
> I don't disagree, this needs to be made clear in the documentation
> though, if not reflected in the property name itself.
>=20
>=20
> >> * There's no clear use case.
> >>
> >> This is generally a requirement for new KMS UAPI.
> >>
> >> The practical usefulness of the corresponding weston MR is dubious
> >> per the concern above. =20
> >=20
> > I think the example of RGB 10 bpc to be degraded to YCbCr 10 bpc
> > rather than RGB 8 bpc is an excellent use case. =20
>=20
> This series and the corresponding Weston MR aren't enough to address
> that use case though, are they? All they achieve is logging a
> potentially misleading warning.
>=20
> It might make sense to combine this series and the Weston MR with
> whatever else is needed for that use case.

What do you believe is missing?

Informing the user that the display quality may not be as expected is
the point. Weston does not have any other kind of UI atm. than printing
to the log.

> > I had another use case in
> > https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850#not=
e_3115686 =20
>=20
> That would need to take dithering into account as well?

Yes, dithering could be an adverse effect or not sufficient. Hence the
'link bpc' property should not consider any kind of dithering, to be on
the safe side. I fully expect dithering to become explicitly
controllable, as policy belongs in userspace.

The point of dithering is to adjust the stimuli on screen, that is, to
make a visible difference on dithered vs. not. Maintaining a display
profile valid requires keeping the stimuli response as it was during
profiling. Therefore turning dithering on or off would invalidate the
profile in cases where dithering is useful.

> > Mario Kleiner had excellent cases as well. =20
>=20
> I raised unanswered questions on those.
>=20
>=20
> >>> That the link-bpc property does not consider DSC and dithering?
> >>> Two things which the max-bpc property also does not consider?   =20
> >>
> >> It's not (as much of) an issue with the "max bpc" property because
> >> it's just an upper limit, the driver is free to use a lower effective
> >> bpc. =20
> >=20
> > FWIW, 'max bpc' is a workaround for faulty sink devices that claim to
> > handle a depth but silently misbehave. =20
>=20
> That's not the only use case (in fact I'm not sure I'd heard of this
> before). E.g. it can also be used in cases where some HW bottleneck
> prevents using maximum refresh rate at maximum bpc for all displays,
> to explicitly choose which display(s) to limit bpc for, allowing max
> bpc for the rest.

That was what I came to understand when some years I dug into the
history to figure out why 'max bpc' was added initially. What you say
is another good use case considering the state of the UAPI which offers
no direct control.


Thanks,
pq

--Sig_/5fH5pBa3XUnIzyJWR4ys.0y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmnLwC0ACgkQI1/ltBGq
qqfVXQ/9GC3+5m0LDoPDR3e0HJxVDkFaEOVQ4gD+YdmBsiFxD4pPBs/bSE5ExufZ
h2jZTsnoD5isn+VMWqNb3CptrwXgGPm+9gNoa07Fkml1Wft4t4nW6+cz8vBO1sV1
Hi4U87R3Rn2rzyCYdmVch2HXjUV209g3fZP3WSytgjx7p9RlQjXfesjruFdUGUtl
bDFdW7wQdCPWuTVoqNr/dd8NsUVFHmveOuGuBbnJUmjc24APBm0ss4rA9RdpyaOu
NGraJAj14lsrqI///WUhWxEF03KdEor+kqsiBFogrOp0kEIlHQt5pVSbHV28BNhQ
HpOrAcoSnAtLQJlsn6qYgDATUe9z5rKcn6/AwPhhItZ4zutDTlUHOE7yjMnlEZKa
S5CoNg031OrrTp3RDT4M+1tEacLpNeag+dBcDu95k9q4jAwnPAXMS/knvCAmKCd2
wtoxkc3Vdo6hjqApAXYNzqiGv9B55K1SP3UjraX9QgPARb7ukkxpdpbFK3VRRW3T
EVu+Vx77zrHYKaJc+7WE4A3c1+KwcuXSaEn2Q3JXaJeDxycgf0En/sXMbantxGta
fy5IMk3ZQ5z/VL0CgcMLf0elcRFUj0vuRc+cevXm4gJwIrYfGNQvAUE1noFxnEiV
ytMNIARJ+EY7eJNWwMju/T+ErntDVED5OFOjl9fR474prWtqSNY=
=2fLs
-----END PGP SIGNATURE-----

--Sig_/5fH5pBa3XUnIzyJWR4ys.0y--
