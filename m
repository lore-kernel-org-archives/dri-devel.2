Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6315A10F995C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 17:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A9210E086;
	Wed,  8 Apr 2026 17:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aoE7Q98k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB0B10E086
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 17:26:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F0F55600AD;
 Wed,  8 Apr 2026 17:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4CAC19421;
 Wed,  8 Apr 2026 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775669168;
 bh=9uE9HoVnp7JPCgpbGLmdshO3VOOSJvutMUsufBuWIAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aoE7Q98kw7DjSv5SYx/PLWyb6TT0oSh1ghhcqb4tJaqcg/sGmOosuc6vi3CEPHfwo
 1XIqNSj9Moa6vJOVg+BAVOu9D1MC+EV1R/ZdtNxonT6LRIxFp5MHJeJd7G3seoNT/l
 pfDsmpfLMwr+6Gz0wkZpaVLFNMucxkgAW08pkFtpdje8F/RY+Jcu9Mw0MzY7MDjKxm
 coOSjVOu4OxXzZm6Fw39VnyEQrRcPFrg/efdq6AgeldOekHj+i4oAiu3GesgA9E26P
 0kBL/CnTSw6YuI+O3Fg3qUc2a08lxiKppLtS8jYCUBIQThFs32eLo9fxl3Zk4pfwzF
 7BTydDsgC4WXg==
Date: Wed, 8 Apr 2026 18:26:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <efa647ef-17e8-432e-9560-a1f0435c0975@sirena.org.uk>
References: <ab1XClKfaCMYzg5-@sirena.org.uk> <20260320163902.24571f5d@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WQm+T1p8jBQqMjN4"
Content-Disposition: inline
In-Reply-To: <20260320163902.24571f5d@fedora>
X-Cookie: Often things ARE as bad as they seem!
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


--WQm+T1p8jBQqMjN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2026 at 04:39:02PM +0100, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

> I have a slightly different conflict resolution (it's the one we currently
> have in drm-tip[1]).

> [1]https://gitlab.freedesktop.org/drm/tip

Sorry, this got buried and won't be relevant any more - for future
reference if you could send an incremental patch on top of the merge
that was there that is much easier for me to ingest.  Merges are
remembered with git rerere and then fixed up with patches on top of that
if needed.

--WQm+T1p8jBQqMjN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnWj6sACgkQJNaLcl1U
h9B8Ugf/W/NswsqRYP/fIpPyS0ZHEnIyiBZeuqT/CPQ2wdGeRmHYlNQZyTFhIt5U
1VDOlPt9HiU7YKOd2zYHn/98sVctneh35/UOBS9csLxWZc8W5v7/yMuSoVXlYMuC
i1zZPC/BsfFIELwCMbEZ/CE/sJsfOkQknYmKmF9B7xdDv1mbMgvzrjlbr4tdvNSF
yMWlv4WmiF+honLQ37uNsEpYbYZ7mVAqgJwTtjP5/RO6RtQPBlEc1x2qrE0f4zWV
k6GuPEAWI5DRRVBcO/k6seEJrzB/WO8aqA23SkbcFEj1Q2zR7NLkBueRJwqPw9uy
nX1yxlCYcTrQtKIE084kPldmYpBWiQ==
=TMGS
-----END PGP SIGNATURE-----

--WQm+T1p8jBQqMjN4--
