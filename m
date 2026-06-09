Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C40ECD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A507D10E59C;
	Tue,  9 Jun 2026 17:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="garQTrC7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8504910E59C
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:54:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A8BE602CC;
 Tue,  9 Jun 2026 17:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882961F00893;
 Tue,  9 Jun 2026 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781027640;
 bh=0McuGGXEia9/oIlWap16WeUugt/Io6Z9vQ/TAHGe7oI=;
 h=Date:From:To:Cc:Subject;
 b=garQTrC7AgQ6Ab3cOkzGYzAVp+OuSKzzv+TD+WcCcgZgHSIUpGhGVo4jxODyl8ywj
 cWnemXvHloKFxv+jC+ox3uZQG3zFWZT/jS3ySv+HMyhTfJLIMsPv56+OZ2CcJ+diW/
 VFAFZar3y7WrtiQ8ZLJFPa3HWq7Yp8uwCsTo1Nk/bnBSV8aygDzZ2b5D7zZcIvB5fy
 A1Q89GX61KtVoLvwzf3mYut+UAJHq0zw+Zr/yf4Htss9Teo7hoJO/NXS+i28GAxrJO
 8xozR4NhuamGwA1w7gSKh/OSB0m42YX/Renr5BI6XdRLJ0XwlE3fycJZRGhFF/74hj
 +/sEEGMFjETuQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id D61411AC56B7; Tue, 09 Jun 2026 18:53:58 +0100 (BST)
Date: Tue, 9 Jun 2026 18:53:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Honglei Huang <honghuan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <aihTNsriYpFrZuOk@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z3Whxefj/6MdmGsK"
Content-Disposition: inline
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


--Z3Whxefj/6MdmGsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c

between commits:

  962d684b5dc074 ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
  1c824497d8acd3 ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_in=
validate_gfx")
  58bafc666c484b ("drm/amdgpu: fix waiting for all submissions for userptrs=
")

=66rom the origin tree and commits:

  c08972f555945c ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
  b6444d1bcbc34f ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_in=
validate_gfx")
  91250893cbaa25 ("drm/amdgpu: fix waiting for all submissions for userptrs=
")
  342981fff32802 ("drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_page=
s")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index e452444b33b08b,99bc9ad67d5b83..00000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@@ -174,7 -174,6 +174,6 @@@ int amdgpu_hmm_range_get_pages(struct m
  	const u64 max_bytes =3D SZ_2G;
 =20
  	struct hmm_range *hmm_range =3D &range->hmm_range;
- 	unsigned long timeout;
  	unsigned long *pfns;
  	unsigned long end;
  	int r;
@@@ -201,15 -200,9 +200,9 @@@
  		pr_debug("hmm range: start =3D 0x%lx, end =3D 0x%lx",
  			hmm_range->start, hmm_range->end);
 =20
- 		timeout =3D jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-=20
- retry:
  		r =3D hmm_range_fault(hmm_range);
- 		if (unlikely(r)) {
- 			if (r =3D=3D -EBUSY && !time_after(jiffies, timeout))
- 				goto retry;
+ 		if (unlikely(r))
  			goto out_free_pfns;
- 		}
 =20
  		if (hmm_range->end =3D=3D end)
  			break;

--Z3Whxefj/6MdmGsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmooUzYACgkQJNaLcl1U
h9Bu+wf/SgksNt+h2UBxXgvkd70xP7QergI0aV+ZNjSY/bPreFPvIiwqVyztRrf8
Uigr6S+2JdGWg8qV5zWxNq7FqqbrXSamu5rHdwlFe/84TZ+MJVFQSccSIT2+lFko
c+1ZWHAdkFZkBHHtiQ4tdm52QOO80zoFvIR5K3aFUGuw0yWyZIp8S+c3EsDzHPUk
9SsnDkatnSKtdPH7bL8z1hNH0Jye1MosNPmjhETcsZowvF1jmLC0/yLlkYUdmCuK
5EWCElXb5/lVOgA5EdWDfezQQPI7DD5SJ7/pBqesacUebMSFR32yhrnONDSVe8IM
Ck5sdNAYdpv/EmGItyH2dkcQhyMNDw==
=n97q
-----END PGP SIGNATURE-----

--Z3Whxefj/6MdmGsK--
