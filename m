Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43A606B2FD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGcQR9dU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9CF10E5B2;
	Fri, 13 Nov 2026 16:07:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E6010E5B2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:07:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 436424468F;
 Fri, 13 Nov 2026 16:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907C11F000C4;
 Fri, 13 Nov 2026 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586050;
 bh=/iBZ3u+sNud50YlXfWvfxW62MEuwhiNCJBVGnC56KF4=;
 h=Date:From:To:Cc:Subject;
 b=RGcQR9dUVmiN8xHiKqCXSM6O0/04yS0laMKHgkPxY6To+sLl6f/CKxLidDdActjG9
 66pI6lZBDzvfRYEpMPlDD+d1/JGOlsrPj4sm/JYP+Icv+e6dUNt5VIHdwMVqKYWrVP
 8YlWBXvS7ZrxTztCpyGHovPkhtnBDE3lZwNyr2gB4boV8FIO5/z1XNvfBJ9G8OWgIB
 1AnDxFkvxEP7Gz28lPr9Z1t9n+6XLENc6EaogmMLddUyDsUZDtmDaC6dibpy7RQgnt
 Gqx0p7FPYG1CEcQ3reCqSXWuBlDHWsvmzy/sYiWqP1PYHtrt2fqY4zH1tnzj0Gxn9D
 I5eazJ1P3RsoQ==
Date: Fri, 13 Nov 2026 16:07:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jia Wang <wangjia@ultrarisc.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: linux-next: manual merge of the drm tree with the riscv-dt tree
Message-ID: <avc1vpWDQ7V0vcRc@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p0NG34qYnRspDe7C"
Content-Disposition: inline
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--p0NG34qYnRspDe7C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  Documentation/devicetree/bindings/vendor-prefixes.yaml

between commit:

  f61b65abc9f41 ("dt-bindings: vendor-prefixes: Add shenrongda")

=66rom the riscv-dt tree and commit:

  b55dbe9011975 ("dt-bindings: vendor-prefixes: Add Shen Chao Optoelectroni=
cs")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Documentation/devicetree/bindings/vendor-prefixes.yaml
index bc1e6361c6941,7602034374d7f..0000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@@ -1529,8 -1527,8 +1531,10 @@@ patternProperties
      description: SGX Sensortech
    "^sharp,.*":
      description: Sharp Corporation
+   "^shenchao,.*":
+     description: Shen Chao Optoelectronics (Shenzhen) Co., Ltd.
 +  "^shenrongda,.*":
 +    description: Shenzhen Rongda Computer Co., Ltd.
    "^shift,.*":
      description: SHIFT GmbH
    "^shimafuji,.*":

--p0NG34qYnRspDe7C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr3Nb0ACgkQJNaLcl1U
h9DpCAf/Y4xT/0dtJqVo4aavEu2ovzUloscVMTC/Ca8dMaMH63hgW+5e4LKUSjjL
csc8BTOu1qwzelIVG9L+odvu36Wh4XjNK5cOKTExT15+HFkQdEVUazm0ROTqlr1P
N9W4sg2nj6XjvMYfW5WJnRpsNEEU0gnxMn9twIy+e6FdZq0xBbLioTmDKezN5mfn
4ouTgPv2WW2g/iaB/YP5nTBMBeiBQpIRzI28vh0tVqXizTwOgkZXQUajvYGVHxMN
xX92QbvU6oIcC4TbXbXzTVGvgdvvodHeAQhQbZjRG3dI8t9hYjMYlQ4sU3pZgLDU
AwhZMLFQFleeDMwdckFwuN+VfTSDGQ==
=/IPF
-----END PGP SIGNATURE-----

--p0NG34qYnRspDe7C--
