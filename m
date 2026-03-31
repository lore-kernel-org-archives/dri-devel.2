Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA27109B462
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A7710ECEB;
	Tue, 31 Mar 2026 12:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="emxMwI0+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA84A10ECEB;
 Tue, 31 Mar 2026 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774961434;
 bh=oREllgdlfbfpIp5Y6YnMV05PtOcfTYZL5LRm1aMZnDI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=emxMwI0+fcT/y4EZFCnPVGCvj1eja+fzxtpN7sCK6gRQgj1QV+kXGbGiWJU3w34En
 XkRFvh5o6YbR7RxW8rMsjcbiLBvtgaRAKlZlvOLG4pHBzrD6L02ct3YHeSoWdCxpb4
 WebuUHRdetYu7PPqUneG6zbHf2flzW9e2pagywC7VDU3klWxnBUk2kkszHXYMJw45T
 vGTaxLdG9yo0JgnQr6oaM0L3x3lBD+8OkyMSui5IVLC6WMQ+i6A9WRrC+ZWHy83hBT
 riS8HysVwVjTtvZaCLj+jJt35Dp9WhXwH3FS2oYs1GBDMusygnD566PeGJ2OeZwW/x
 eOBbmRZWOPvkQ==
Received: from fluorite (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9009717E635E;
 Tue, 31 Mar 2026 14:50:33 +0200 (CEST)
Date: Tue, 31 Mar 2026 15:50:28 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>, Nicolas
 Frattaroli <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Leo Li <sunpeng.li@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Ville
 =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Stone
 <daniels@collabora.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, Marius
 Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Message-ID: <20260331155028.71246d7a@fluorite>
In-Reply-To: <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
 <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_ERm8b1qVzt21ZDPt=dxNzl";
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

--Sig_/_ERm8b1qVzt21ZDPt=dxNzl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2026 14:52:23 -0400
Harry Wentland <harry.wentland@amd.com> wrote:

> On 2026-03-30 12:57, Michel D=C3=A4nzer wrote:
> > On 3/26/26 13:17, Nicolas Frattaroli wrote: =20
> >> On Tuesday, 24 March 2026 17:44:21 Central European Standard Time you =
wrote: =20
> >>> On 3/24/26 16:25, Nicolas Frattaroli wrote: =20
> >>>> On Monday, 23 March 2026 18:27:41 Central European Standard Time Mic=
hel D=C3=A4nzer wrote: =20
> >>>>> On 3/23/26 17:55, Nicolas Frattaroli wrote: =20
> >>>>>>
> >>>>>> "Someone might not understand its purpose" is, in my eyes, not a v=
alid reason to
> >>>>>> not have this property, [...] =20
> >>>>> Per my previous posts, that's not my concern. =20
> >>>>
> >>>> Then what is your concern? =20
> >>>
> >>> Per my previous posts, my concerns are:
> >>>
> >>> * The meaning of the "link bpc" property value isn't defined well
> >>> enough vs things like dithering or DSC, which will likely result in
> >>> compositors / users overestimating what value they need / want,
> >>> resulting in compositors spuriously rejecting configurations which=20
> >>> would work perfectly fine, and/or spurious issue reports. =20
> >>
> >> Dithering and DSC are supposed to be transparent, no? =20
> >=20
> > Not really, no. They achieve higher "effective" (as perceived by
> > the user) bpc using a lower physical bpc.
> >=20
> >  =20
> >> If a link bpc is 10 but DSC is on so it's 9 on the wire, it's
> >> still 10 bits. =20
> >=20
> > If DSC encodes user-perceived 10 bpc at a lower physical bpc, and
> > the "link bpc" property reports 10, that would satisfy my concern
> > for DSC.=20
>=20
> Conceptually I would understand DSC to not effect the reported bpc, so
> a 10bpc output bpc would be reported as 10bpc via the property, but
> DSC would compress that down to a lower value on the wire.
>=20
> Dithering wouldn't do that. An 8bpc output would be reported as 8bpc
> even if dithering makes it perceptually look like 10bpc.

That seems quite arbitrary, but ok, that could work.

> I can understand the challenge of how to intelligently use it to
> report anything back to users. I could see some compositors being happy
> to use the bpc alone, while others might want to know dithering and/or
> DSC state (compression ratio?) as well.

People who care about the picture quality down to these levels will
likely want to know and learn about these techniques. They may also
want to explicitly control them.

In time, when these have been used enough in the wild, compositor
developers will learn what makes a difference and what does not, so
they will adjust their reporting to end users. The most important thing
for the kernel is it offer an unambiguous and stable UAPI for these.

Policy belongs in userspace.


Thanks,
pq

--Sig_/_ERm8b1qVzt21ZDPt=dxNzl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmnLwxQACgkQI1/ltBGq
qqcVpQ/9EzCUUVoXzoqtv0Te7DymPfdrQ3EYXhTMNbi+Gqgg0X9Q2C4HKh4Gtf9B
kcKNHHycOOevHJ0tx5mJtWavaIAx/T6T/AozxoJVTLix9iXskVTsvECMzZfkFqdT
lp6rNk6Tu7qwCk3R2fdO0IF2+YvFo5aMOyrsd3Pp/3QOCJTDUTdY/6Tnpe8xguCV
0qePOlftVd7nreh0XnxyizcWLfFuCBl7NuiiV2nrdiDyQjXNBNB9V/CQFFrZ61Wu
tjBXbNH2GZY46pXPKtYNragKtZiKqYVo3Lh8xwMoy6Bu6ZlmcCxPJhEDFiDxnwpS
oW66reFady2GyaTUaTE6N6Y05YvS0/ncOiP9cnuQCPq0gw92w8p6FH1ZNeg1iZ1Q
hRfwvNeuFfZQPPhRl72bHOR7zmvIaOSfzOPrhlUz/A3Z6AXmGxgEqqF1AOhg2a5H
wJ+ZzWdEzNUeYaC81TZZtEY5GpEyj2tMqb3Rqa6QnLHvzjxptTLXq7aQDw1Z2sEI
OIUdQP2l2l+Q6xY4e5r0sCvqq9WxXGYBzvuQ7/iaBsDzu819LLwcsfDNbL348DiW
CyHFF3lNyqJczs0hfMnTp1vOQtAfIAjyEuUBGG0I1iZgUg5KnT8ymRdd4yY3TlvE
1ExoqtbXj9qNMKE6P20XZ4alkDdSoGTxLRBVpQ6JMM+JVbYEjr4=
=Ijsv
-----END PGP SIGNATURE-----

--Sig_/_ERm8b1qVzt21ZDPt=dxNzl--
