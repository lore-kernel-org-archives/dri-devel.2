Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB42606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imw78RQV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3431910E9F8;
	Tue, 20 Oct 2026 09:52:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3953B10F467;
 Tue, 20 Oct 2026 09:52:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51FB660136;
 Tue, 20 Oct 2026 09:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD991F000C6;
 Tue, 20 Oct 2026 09:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792489964;
 bh=zYRM9MtNeNslk7QcIWF7t4sAkiaD9Q9bb18oY5zf+m8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=imw78RQVyqxXyXIfVMuonDQMs/i7Eb+6b7LC3lr+cWorJbzGr1bDbd73vaSghnnQ2
 FKM0pBrRWWAOucPFcZKWr6F3/GmwgTFkKoEaH4uCHjJrUx1hzQTnnWk6JQgF7FXsp/
 fSPOlqDeYM+2EnX7JBjLcrxuzsgg5K0TblULfj80ku/rtH1NxTfux4364HakOKuglt
 /sMQEWaJx289+o6e+bZAq4UQgjz5nT8QC/34D1NbzZQ0dde4u1EW9hJDDucAa8eHJy
 TAxWKafkTwtosxh5nc5w/Wepu6I5eqOXnN2M/CmASSuoN3e1eLuEGdjjQc5WWtmn4h
 dRN+hczysa6kQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id A2BF11AC57D0; Tue, 20 Oct 2026 10:52:41 +0100 (BST)
Date: Tue, 20 Oct 2026 10:52:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Devin Wittmayer <lucid_duck@justthetip.ca>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 luyuantao <luyuantao@kylinos.cn>, Simona Vetter <simona.vetter@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <atc56cq8Vhz_2M_o@sirena.co.uk>
References: <atZBBqj4ON6kYWSK@sirena.co.uk>
 <20261019190959.799653-1-lucid_duck@justthetip.ca>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gZRriHLnrYvZPd15"
Content-Disposition: inline
In-Reply-To: <20261019190959.799653-1-lucid_duck@justthetip.ca>
X-Cookie: You buttered your bread, now lie in it.
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--gZRriHLnrYvZPd15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2026 at 12:09:59PM -0700, Devin Wittmayer wrote:
> On Mon, Oct 19, 2026 at 05:10:46PM +0100, Mark Brown wrote:
> > This obviously isn't the right merge, it drops the fixes.

> Two of those fixes are mine, so I had a go at it. The code that draws
> the panic screen was moved into drm_panic_helper.c in drm-next, so two of
> the three need to move with it. The third one, for the panic screen
> setting, made it through your merge fine. Today's drm-tip has the same
> gap.

Yes, quite - the move causes issues with tracking conflict resolutions
unfortunately since it doesn't show up at all to git's idea of a
conflict.

--gZRriHLnrYvZPd15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatc56QAKCRAv73Ows9A4
iRULAQCs9sAS3y+L+3JqxLeJygjCnoKRmyMdvhZ/rwLzPaBMeQEAy5JzFJn9OBZj
dK3aiCovcvVy7LSBbSTfBsMZ++Kw3w0=
=64z8
-----END PGP SIGNATURE-----

--gZRriHLnrYvZPd15--
