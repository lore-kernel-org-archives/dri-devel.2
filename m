Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE742C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3077810EA08;
	Tue, 25 Aug 2026 12:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ea7lV9U4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA85910E9FD;
 Tue, 25 Aug 2026 12:13:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DCCF435EE;
 Tue, 25 Aug 2026 12:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6621F000E9;
 Tue, 25 Aug 2026 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660039;
 bh=po14Aw8c554DizVs6FCmQTxU2TzseN2FKQN91g7xicQ=;
 h=Date:From:To:Cc:Subject;
 b=Ea7lV9U4gBuDtiMak+5xZcykwdkkjZwuGf3tl88qdruw1FQjtY9CWqSo7Ie2UonEs
 mBenG7xtvpg0xLAxBAJ6nSNSaQowTq+EgicdwGMizrtckWw5tZLtafB5A6tv7aUaqL
 VNhVqJGZwV8TKlHVu+Cx657kNKB8jPI2OXZI65SFwK3ECaoRi92Ga9qEdCW27yglHS
 WFkSG2HA1aVFGrTc9f53fmWfH163Pg4B74hmGKscbWBkXGjPDAXHiyIbkRh7w6A7R3
 LcsuA7rJGFGwGIOB2llntYKwPB82MmxkFLeLSI69LLfQBvAbFbwk2ZopgWLlm5o4sB
 +2AOT8c9HGe2w==
Date: Tue, 25 Aug 2026 13:13:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: linux-next: manual merge of the drm-misc-fixes tree with the origin
 tree
Message-ID: <ao2HAsn4xc5PYNZY@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ysEuOZ4LWzJOIpcL"
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


--ysEuOZ4LWzJOIpcL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc-fixes tree got a conflict in:

  drivers/accel/ethosu/ethosu_drv.c

between commit:

  17cdb54644e7d ("accel: ethosu: Add performance counter support")

=66rom the origin tree and commit:

  7ab64476a610f ("accel/ethosu: check MMIO mapping errors in probe")

=66rom the drm-misc-fixes tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/accel/ethosu/ethosu_drv.c
index d121fb0d77328,b2901eb8a7a03..0000000000000
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@@ -356,7 -342,8 +356,9 @@@ static int ethosu_probe(struct platform
  	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
 =20
  	ethosudev->regs =3D devm_platform_ioremap_resource(pdev, 0);
 +	ethosudev->pmu_regs =3D ethosudev->regs;
+ 	if (IS_ERR(ethosudev->regs))
+ 		return PTR_ERR(ethosudev->regs);
 =20
  	ethosudev->num_clks =3D devm_clk_bulk_get_all(&pdev->dev, &ethosudev->cl=
ks);
  	if (ethosudev->num_clks < 0)

--ysEuOZ4LWzJOIpcL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqNhwIACgkQJNaLcl1U
h9D9pwf+JO0cbi+V8LVHLOfhkjV3CqrbyEu2p2wrBfdLitHygC2bX3ytfw3w02IQ
cVgpfQ+6Z3AUrTcKnptVeZvJbNz34GgIMaDY6Mq4nfwygA9/QYHno6YMHO/R8aQF
A3ER87pHwUSkzBlSUYYLWBL2qonSneLCtxtDAAaBcyX8rFvyjAGmkiK6fO1fqw5Y
XqWKd1XfF2dpNtaUiVRuYLfHHBcvxoix9++ZF4jX333FdF+NKsiMugkPnNFPGYLU
zvEVh8ES4wianHVJF6iVP+aYSwu3kEoqk5EBPA9ST15jH8ON0lkZZqisQHBXff1Z
/mTjSRHkza/MV4LHLt9X656yj6N3pQ==
=LRNV
-----END PGP SIGNATURE-----

--ysEuOZ4LWzJOIpcL--
