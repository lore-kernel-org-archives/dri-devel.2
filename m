Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C878EC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292F610EE04;
	Wed, 19 Aug 2026 12:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UzJHiCbq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B9510EE04;
 Wed, 19 Aug 2026 12:12:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7883240085;
 Wed, 19 Aug 2026 12:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79AE1F000E9;
 Wed, 19 Aug 2026 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787141563;
 bh=C/OCnBh2+Bwi09gb9qHRbFFL6oQmAq5hReVyPfFAbCA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UzJHiCbqOjtKEPHcE/yhg6Mt7X5Hwf2ERYrbg+8xW+xp+ZT9WpKFa0l9OOwaPvbi1
 FbErRLzdHyUBHtHoGeK/20UTYqbzG8+48ZUXHNfvEhGgVvsVy/J56RXdvF0ii2164H
 zNIqfUrsjN5vPR4PNHGwCz/Ef+i3y2vnK5mLZyAqY5/2ll38V0mIp48kHq4HoRpEZ7
 SgJj8qofWxMB0+Br/Om43JSOksEX6hweEN3EmhA/7kQENrHV0qU3IHsiJ1ynI8LG26
 FsA3yW1qiXrAnR9n3TISVHHi3+IbKD8MPp4IcVl27EOjpSCAYpEGBaGrL0pEAdgo89
 jAi/zQwm+TKog==
Date: Wed, 19 Aug 2026 13:12:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: Re: Unexpected files in the drm-intel tree
Message-ID: <07e2d455-ae76-46aa-821a-a455118c60d4@sirena.org.uk>
References: <aoR9fNYRhmWDNJtz@sirena.org.uk>
 <cbd77031f484d0c044666c4fc11fd3ef273459bb@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G3zcZBlb/+C9HnFm"
Content-Disposition: inline
In-Reply-To: <cbd77031f484d0c044666c4fc11fd3ef273459bb@intel.com>
X-Cookie: Allow 6 to 8 weeks for delivery.
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


--G3zcZBlb/+C9HnFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 12:31:07PM +0300, Jani Nikula wrote:
> On Tue, 18 Aug 2026, Mark Brown <broonie@kernel.org> wrote:

> > Commit

> >   ac3baea883dab ("drm/panel: find_panel_by_fwnode() return a counted reference")

> > added this unexpected file:

> >  drivers/gpu/drm/drm_panel.c.orig

> So this has been reported before for drm-misc [1] and drm-xe [2] trees,
> and has been fixed in the drm-misc tree by commit 651b0bd0922b
> ("drm/panel: remove accidentally committed .orig file").

> Similar to what Joonas said in [3], this should really only be reported
> once for the tree *and* branch where it originated. There's not a lot of
> value in reporting again whenever something gets merged somewhere else.

There's no database of issues here, the check that's being done is based
purely on the new commits and diffstat that just appeared when we fetched
the tree.  Deduplicating things is in general a depresssingly hard
problem even for basic stuff (eg, is this a new issue or a recurrance of
an old issue?), and the much more common case is that there's downstream
trees sending problematic commits to their upstreams which the upstreams
would like to know about.  DRM is quite unusual in the amount of
sideways merging that goes on between parallel trees, and can also be on
the higher side for the length of time issues get left for once they've
been merged into other trees.

What I would have hoped would have happened here is that whichever tree
originally had the issue would have fixed it before they sent it to be
merged elsewhere, then it wouldn't pop up in all the other trees, or if
the original issue already got merged then a fix would be sent promptly
before other trees start picking things up.  In this case it looks like
-next first saw this on July 21st and the fix wasn't posted until 10th
August (then applied on the 11th) so there was unfortunately plenty of
time for things to propagate around.

--G3zcZBlb/+C9HnFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqFnbYACgkQJNaLcl1U
h9C7iAf6AgNJhQWTkBsSQw4F+7KObOf+iJAyNGSkX6TUOXpmUvGy4Vr1zUCG1OJV
NtSctTaq1X8BzQibvSyclAA/oGrVjzs3JfST1D81jqZRqZT4+OwCmnhpMyn6CXYh
s7hY5FmHRLaREqf4Q8mrAJ+d18YMSg0kYqFIllPGRDX6F7erkAe8hEB0pHL9Q6+/
Qe3zz78PtU+GZMSF+ySBFVC3i/wmtO+rLEH9n/2YWFT+DMqGMxsLiY7CRUqHxGXY
SsecaPhoR0Rh5o37Zu1S844oJlKOHYc22DQaeywEEuhG8H+FiqzxzTp/0ym/zQqE
FvF63lygNB3OwigjdGan5Sm/lRtWPQ==
=/bmt
-----END PGP SIGNATURE-----

--G3zcZBlb/+C9HnFm--
