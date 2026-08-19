Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA7EC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5557610EDDF;
	Wed, 19 Aug 2026 11:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BGCsEYOn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8850610EDDF;
 Wed, 19 Aug 2026 11:13:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2629441877;
 Wed, 19 Aug 2026 11:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563DE1F000E9;
 Wed, 19 Aug 2026 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138038;
 bh=bQyqNlGMHs5nqRBvTyCHF4lb3YR4KkTOTMsXe9kCyF0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BGCsEYOn81tBrY1UAuwJPJt6DHak8hlYVqtIQn9kK+XfwP9NNZoWiGPWt8Y6CJ0mf
 aSaXnn954tgP7kNpPIUApnKo+YnQuVOE/boQHJ10tG961xJXMk79Ucf0tggmXo2xbn
 809bsxLLS/LFhksxZf0u6wgtg0NFdPvYWHWNqfMN7IrZw9NIJhkii6doF8An/21493
 UUPJ1BtCQssFtTj7QgZi7nA11WAFV+Qvyg4N0Knyh5qUH5K+aF0VhC/rHO16tCAJj2
 4ieNSiVHyfftnDQCDimOUmmt+Cs2/XErtMhltP3pCaw7u5m4IRRrcM9osw9a7glLsw
 rtaPa0bYAalag==
Date: Wed, 19 Aug 2026 12:13:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: DRI <dri-devel@lists.freedesktop.org>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Fixes tags need work in the drm-intel tree
Message-ID: <1f884bfe-f8be-45fe-97d6-a64547b1bf6d@sirena.org.uk>
References: <aoR9bznCkJHwK4DY@sirena.org.uk>
 <178712337932.24680.17671628229026350089@jlahtine-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0iMeaOiPWA95IxHH"
Content-Disposition: inline
In-Reply-To: <178712337932.24680.17671628229026350089@jlahtine-mobl>
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


--0iMeaOiPWA95IxHH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 10:09:39AM +0300, Joonas Lahtinen wrote:

> You may want to include the repository name in the body of the message,
> not just title. The full repo name would help, too.

It's whatever the tree is called in -next; I think the general hope is
that if you have included a tree that is -next you'll be aware of what
it is.  As a reminder the trees I currently have you (amost others) as a
contact for are:

   drm-intel-fixes:
       https://gitlab.freedesktop.org/drm/i915/kernel.git for-linux-next-fixes

   drm-intel:
       https://gitlab.freedesktop.org/drm/i915/kernel.git for-linux-next

> As there's no drm-intel tree, one would assume drm-intel-next, the
> below commit is not there. Seems to be from drm-misc-next.

> It seems to also be drm-intel-next-fixes tree which has been reset to
> equal drm/drm-next to prepare for -next-fixes PRs.

> Maybe you want to only send the notification once per unique HEAD
> (ignoring merges)? That'd then target the original commit and
> any cherry-picks.

That's what happens currently, these notifications are generated based
on checks done on the new non-mainline commits that appear in your tree
each day.

Are you sure this isn't something that you've picked up in one of your
inter-tree DRM merges?  There's a general pattern of DRM trees sending
unadressed issues to their upstream and being slow with sending the
fixes, then the same issue appearing in all the other DRM trees as you
the various DRM branches cross merge with each other.  For Fixes stuff
that's just going to happen unfortunately given that you don't rebase.
The common case here is that downstreams are sending things to their
upstreams, in general it is useful for the upstream maintainers to get
notified about issues.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--0iMeaOiPWA95IxHH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqFj/EACgkQJNaLcl1U
h9DM2Af9FgJW5i0Z0Hu16HAqh/sx9HUY4QHlpumj3HjmsVNADXw5lOSB4LpqsrXR
6AOrrvKuY3Z1g3bEwmgYnXwXo66fQRbkXnAsqxtkAVnpZCBwiHL2RZtiFJk8dlNL
Tc2Ap0OMM/ndC77gshvMPnhGwbPos2hqd+FNDnHL7HSf+JEdeLTLEmsTyCoihI8E
Ia6B0a7N+kgGE9zh/m+lZ1RSzhkRhx8I8LwIZEI5MtzdVStlW0cEs9+QyKctS1kz
XmTEcsMMYufkMkb9d1Z4XuO4ltJgm2hjmNCy0tm11IE+5LHGF9QKUnshQF43tuCo
89gwCxX2Jj8TH5bYnB6SMqdBmAt6qQ==
=eTpw
-----END PGP SIGNATURE-----

--0iMeaOiPWA95IxHH--
