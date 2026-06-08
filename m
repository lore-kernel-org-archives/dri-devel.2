Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2216CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E19110F340;
	Mon,  8 Jun 2026 12:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RxCqkpfD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19EFF10E348
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 12:42:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED1DF40E53;
 Mon,  8 Jun 2026 12:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A9F1F00893;
 Mon,  8 Jun 2026 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780922540;
 bh=vLaVLICk2oe4ISqtVdPrHK0C9aAoO37wlzmXljjTcj8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RxCqkpfDbtZTmk/0sYjPbrwF/SlaRm/qRYvBpg7H0oHhCack+QaVRI+puOmv3YAxz
 FcAWmyoJRRyHlzp6rhpXpc+puLtL01HKZF9Ogv0Un9tfUHoWK+bkMTQrKLbr+k1nKR
 ezptbklHPxfXeqoTp50RpkmwSnypd/DUiJGkH7RIzbDUXmk/oLnsKoFOU3xHd2K3Ke
 LtDhEbhXaFbN4dzPJHSyLhCT9yti39m2KBXStxAB4H+T/Djq4mLfKzGOOmUOs+6wVP
 8l+uYl4FGhKkMNJARfp0h4tz+weRpPHOOZ/ltRinrAql+Tw9Qq/mI5lN04ChLa9+Ye
 1O++vPssIJiMA==
Date: Mon, 8 Jun 2026 14:42:18 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Natalie Vock <natalie.vock@gmx.de>, 
 Eric Chanudet <echanude@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, 
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
Message-ID: <20260608-glorious-fluorescent-salamander-93daec@houat>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
 <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="yiowilux2t2cndhw"
Content-Disposition: inline
In-Reply-To: <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
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


--yiowilux2t2cndhw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
MIME-Version: 1.0

On Sat, Jun 06, 2026 at 11:44:10PM +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> On 6/6/26 18:31, Natalie Vock wrote:
> > On 6/6/26 00:44, Eric Chanudet wrote:
> >> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> >> dmem.low files.>
> >> This changes the UAPI that otherwise accepted multiple lines for setti=
ng
> >> multiple entries in one write. No existing user is known to rely on
> >> writing multiple regions in a single write.
> >=20
> > Ugh, shoot.
> >=20
> > For dmem.low specifically, there already are some userspace thingies fl=
oating around that may write more than one region/value pairs.
> >=20
> > These thingies all depend on that one patchset for dmemcg protection th=
at I should really get around to merging[1]. Since the userspace utilities =
depend on not-yet-merged patches, they sort of have to expect stuff changin=
g under their belts, so I wouldn't really consider those users a blocker by=
 necessity.
> >=20
> > As I see it, we could go down one of two paths:
> > 1. We go ahead with the patch as proposed, and I make sure that the use=
rs I know of adapt. Could be a bit icky wrt. "do not break userspace" rules=
, but since the already use non-merged UAPIs in one place, you can argue th=
at these users kind of have to expect breakage.
> > 2. We use the old handling allowing multiple lines for dmem.min and dme=
m.low only. This preserves compatibility but uglifies the code by quite a b=
it.
> >=20
> > All things considered, I think I personally would prefer going with 1. =
and taking the patch as proposed and just having one codepath handling ever=
y limit file. Just highlighting this so we don't do it on accident.
> >=20
> > [1] https://patchwork.freedesktop.org/series/163183/
> >=20
>=20
> I prefer option 1 as well, but would like an ack from one of the core cgr=
oup maintainers too,
> and what Maxime's opinion on this as well.

Option 1 works for me too if doable

Maxime

--yiowilux2t2cndhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaia4qQAKCRAnX84Zoj2+
din2AYCvqKvH/o7VpqQLqfHK9E3iomJjqu4qZHf9t4cZBA2j3r33qyhweWWRiqFh
ZSIh91cBgJmqTLmBkpwO0jzWVfoU4+3DYvBPepU6Qh/cFc65rF7hZPAcicvpRpDO
cWm6LjUb1g==
=OpIe
-----END PGP SIGNATURE-----

--yiowilux2t2cndhw--
