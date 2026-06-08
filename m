Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85C7CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B88110F426;
	Mon,  8 Jun 2026 14:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EwCsxTGn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6E810F426
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:04:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECC6541738;
 Mon,  8 Jun 2026 14:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582121F00898;
 Mon,  8 Jun 2026 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780927480;
 bh=YzXEY+QME7Drg3ANHA5+1O70COZoy6++FTXF2gCXf2w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EwCsxTGni2jw4w6ZxN2s4lk+aJCdkUs3h567ZxrelQLG1u4OJVeSqEsuBVo/Fr4Ba
 rkdps6zz9CTD9Zeaz2F2XmJy9uBfg+90Eicyl0tskMCV3Be5w/+H5puhF2Anpdlr2j
 /ae4dJ6Qgn3asGFH7Hp5wcgrTYuMKNEnCy29wr6Lo64PZXSr34LZAbBhN7Pf9vUtZZ
 jeCEEyzac/bofh/Tzu8NDd4eAydKANDVNiOD6ICMIuoSvi23OWJKhprOLZ9b48IhtY
 edx8ze2oUvpREKe7SBnfnm5i3ID2KJ1pTRwynJm1GHh7RkOvcJ8NV5ZTwPw/euUEWH
 UgPJzLeNjtneA==
Date: Mon, 8 Jun 2026 16:04:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Natalie Vock <natalie.vock@gmx.de>, 
 Eric Chanudet <echanude@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, 
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
Message-ID: <20260608-rational-cuscus-of-enhancement-eecbfa@houat>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
 <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
 <20260608-glorious-fluorescent-salamander-93daec@houat>
 <15bab7c9-0857-40b9-963b-9923c0e7392c@lankhorst.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="44pqtk3cwl47v2we"
Content-Disposition: inline
In-Reply-To: <15bab7c9-0857-40b9-963b-9923c0e7392c@lankhorst.se>
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


--44pqtk3cwl47v2we
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
MIME-Version: 1.0

On Mon, Jun 08, 2026 at 03:13:56PM +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> On 6/8/26 14:42, Maxime Ripard wrote:
> > On Sat, Jun 06, 2026 at 11:44:10PM +0200, Maarten Lankhorst wrote:
> >> Hey,
> >>
> >> On 6/6/26 18:31, Natalie Vock wrote:
> >>> On 6/6/26 00:44, Eric Chanudet wrote:
> >>>> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> >>>> dmem.low files.>
> >>>> This changes the UAPI that otherwise accepted multiple lines for set=
ting
> >>>> multiple entries in one write. No existing user is known to rely on
> >>>> writing multiple regions in a single write.
> >>>
> >>> Ugh, shoot.
> >>>
> >>> For dmem.low specifically, there already are some userspace thingies =
floating around that may write more than one region/value pairs.
> >>>
> >>> These thingies all depend on that one patchset for dmemcg protection =
that I should really get around to merging[1]. Since the userspace utilitie=
s depend on not-yet-merged patches, they sort of have to expect stuff chang=
ing under their belts, so I wouldn't really consider those users a blocker =
by necessity.
> >>>
> >>> As I see it, we could go down one of two paths:
> >>> 1. We go ahead with the patch as proposed, and I make sure that the u=
sers I know of adapt. Could be a bit icky wrt. "do not break userspace" rul=
es, but since the already use non-merged UAPIs in one place, you can argue =
that these users kind of have to expect breakage.
> >>> 2. We use the old handling allowing multiple lines for dmem.min and d=
mem.low only. This preserves compatibility but uglifies the code by quite a=
 bit.
> >>>
> >>> All things considered, I think I personally would prefer going with 1=
=2E and taking the patch as proposed and just having one codepath handling =
every limit file. Just highlighting this so we don't do it on accident.
> >>>
> >>> [1] https://patchwork.freedesktop.org/series/163183/
> >>>
> >>
> >> I prefer option 1 as well, but would like an ack from one of the core =
cgroup maintainers too,
> >> and what Maxime's opinion on this as well.
> >=20
> > Option 1 works for me too if doable
> >=20
> > Maxime
>=20
>=20
> I see this as an acked-by?
>=20
> I'll commit this patch to drm-misc-next if so.
>=20
> Fortunately it may not even break those scripts in the typical case
> where only 1 region is registered, eg the most common laptop/desktop
> case.

Natalie had a bunch of comments afaik, so I was expecting a v2, but if
you intend to merge it as is, you can add it if you want.

Maxime

--44pqtk3cwl47v2we
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaibL7QAKCRAnX84Zoj2+
dheeAYCNOYNwu6vtvfr6+oGxHjIg7iVjIzEMEOlZFZlUZkQxiFXytzEiVsuMvKWd
IGFxwf8Bf0I1+MUeg5BHtyLRGmUKCFTkxAOovbpUDc8nsISIUCX1R5lXD2do1N8I
V3vO/k+zdA==
=RxhS
-----END PGP SIGNATURE-----

--44pqtk3cwl47v2we--
