Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62B606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bk11m1zO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC4F10E43F;
	Mon, 16 Nov 2026 19:32:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96DE10E43F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:32:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9F07631A9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED391F000C4;
 Mon, 16 Nov 2026 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794857535;
 bh=kOrKPAbJH9s20JY2TmteragNHBys0sbDG1IryjvDSNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Bk11m1zOVoy9EBis9tMld1Db9e1O0ixuhDVGSG8Hg5fjd/eLfn19i1yf9jjKgkBXG
 3fPpjPHt4oLdpzaQ9ME3YBF0RtmKfQ5V/yFJ6hAHRcv4eYLV5CTaUe7WRiris4gGd9
 ctb/0hBB+LA+QJ3LCLsWuqzA2Bx9sTw6L6o+kFFRB8R63EMsetrb6/ng8m1j1h6rAG
 dOrZXhqA/PTePBI2bEwAAPa7CHj4/77k3zh41Yg6AZZZqvMSTMZZRS4hDNIEOB1XaA
 pQyk5UJMVnNG4WZSAeCR6yheJMzZd/afVbObE5gM44wAlJC95FgxQlw/mBlMjsV4Qk
 ymj09XLyavgeA==
Date: Mon, 16 Nov 2026 19:32:12 +0000
From: Mark Brown <broonie@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <21e60c06-3400-4a71-bdbb-aaec97cf0717@sirena.org.uk>
References: <avtUOSIWVojTuTvx@sirena.org.uk> <sashiko-outbox-217562@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wXXAko09Ayc7sQIx"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-217562@kernel.org>
X-Cookie: Madness takes its toll.
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--wXXAko09Ayc7sQIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2026 at 07:30:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issues to consider:
> - [High] drm/xe: missing Signed-off-by trailer and unresolved template
>   placeholders

This is not a patch submission, please fix your tooling.

--wXXAko09Ayc7sQIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr7WjsACgkQJNaLcl1U
h9DDoAf/copjfdLbXnLGeA1vBGLMg7FmtIB61eAhTO8qM9uEtTgZSQ/4YRwpKNqS
CnY5joPKiNj5LfexE96vxywxPWKm99SAZQGh98sxfWS/Omv2l7hf4wHzBWj++4e3
xNrHVmJ52p6MIgf1FaubhVbptvpZ78ydu2KV9dD0xWTcfxx6Sr9xq35nM8XGAtsO
6tDUPC53p78DR3YCQbDNP7rN/A6ZDbbbQAdX1S+/eRPsb8bJwF6P2i5QOJbYrqee
MOG016gsrVGa5C87u1x2G3+8FRYCVkSw43G5Q3aAIYPxqV0A4wvkHF+6uSRifjxN
vPAb7llG9c5A79GoqutLkQn1bki5pA==
=fw5d
-----END PGP SIGNATURE-----

--wXXAko09Ayc7sQIx--
