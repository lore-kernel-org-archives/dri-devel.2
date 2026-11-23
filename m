Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F1606A338
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.master header.b=mti1M8cY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DAB10F348;
	Tue, 24 Nov 2026 08:39:47 +0000 (UTC)
Received: from master.debian.org (master.debian.org [82.195.75.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382E910EFA1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.master;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description;
 bh=15VJKiwk2jeEgdaWn6BsC4rhPTrCLdQwZkJQeS6QumA=; b=mti1M8cYqzayYd2nLTzipH9r0v
 u/BJwlpjCZ3RrxMRJWyj7y/a2uy1hdxSn2Bi0B5G5znuFPYRuafKZT+43Ix3St8cUFGM6iYBTTWpH
 YBZz++fPOd056/F5JxgHOf3WgjPwan7v/7g8YrDpjg2iN/lLVwcArNT6k55p4bewoouQKW8JWK1oH
 ORQtdzh/lc/wypvuVJUyFF5ljV5LWiCdESkLt3p/xpvmLKzk29Ir3tjnWVQciIjBwH8Vrd8yzWJF6
 d0omWcg6fNAh/8iT8ONzPWesRJCqIhtjTUqaRTfGkAwto0dpOr9meQ8Dw5lqxISK22XIaYpXCiNJ5
 klO07oJw==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
 (envelope-from <ukleinek@master.debian.org>) id 1xVX1n-009iOp-18;
 Mon, 23 Nov 2026 16:36:27 +0000
Date: Mon, 23 Nov 2026 17:36:26 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Li Chen <me@linux.beauty>, Dave Airlie <airlied@redhat.com>
Cc: Marek Vasut <marex@nabladev.com>, dri-devel@lists.freedesktop.org, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Ole Carlsen <ole.carlsen@tutamail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 1146033@bugs.debian.org
Subject: Re: [PATCH] Revert "nouveau: pci: quiesce GPU on shutdown"
Message-ID: <awRoqijawLNEkKEE@monoceros>
References: <20261025213027.842978-1-marex@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y7gnwzapgxhtolu3"
Content-Disposition: inline
In-Reply-To: <20261025213027.842978-1-marex@nabladev.com>
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--y7gnwzapgxhtolu3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "nouveau: pci: quiesce GPU on shutdown"
MIME-Version: 1.0

Control: forwarded 1146033 https://lore.kernel.org/20261025213027.842978-1-=
marex@nabladev.com

#regzbot ^introduced: 310326bb7df4bba094a3fc60364c641c547fd923

Hello,

On Sun, Oct 25, 2026 at 10:30:06PM +0100, Marek Vasut wrote:
> This reverts commit 310326bb7df4bba094a3fc60364c641c547fd923.
>=20
> This breaks shutdown on ThinkPad W510, without the offending commit
> the system normally powers off, with the offending commit the system
> ends up spinning indefinitely and the CPU fan goes full throttle on
> shutdown.
>=20
> The behavior was already reported in debian bugtracker multiple times
> for various other computers too, and git bisect lands as this commit.
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1141969
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1146033
>=20
> I tested the revert with Linux 7.2.12 from debian unstable, not next
> or drm trees, mainly because it was easier with debian test-patches
> script on that machine.
>=20
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Quoting the documentation:

Try to fix regressions quickly once the culprit has been identified;
fixes for most regressions should be merged within two weeks.

In the meantime this report is more than 4 weeks old with no signal that
someone looks into it. :-\

Can someone with the problem test the following patch please?:

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouvea=
u/nouveau_drm.c
index 30311688618c..fd3518d4407e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1111,19 +1111,6 @@ nouveau_drm_shutdown(struct pci_dev *pdev)
 	ret =3D nouveau_do_suspend(drm, false);
 	if (ret)
 		NV_ERROR(drm, "shutdown suspend failed with: %d\n", ret);
-
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-	/*
-	 *  This is just to give the pci power transition time to settle
-	 *  before an immediate kexec jump. it=E2=80=99s mirroring the existing
-	 *  nouveau_pmops_suspend() behavior, which already does
-	 *  udelay(200) right after pci_set_power_state(..., pci_d3hot). In
-	 *  ->shutdown() we=E2=80=99re allowed to sleep, so I used usleep_range()
-	 *  instead of a busy-wait udelay().
-	 */
-	usleep_range(200, 400);
 }
=20
 static int

Bonus points to bisect further in that function (that is, readd lines if
the above patch fixes the issue or remove further lines from the end if
it doesn't).

Best regards
Uwe

--y7gnwzapgxhtolu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEa4cACgkQj4D7WH0S
/k6trggAjnMHkPrw6gikL+ajKxikytRp0RXIk3zAeYPXrTBcoAtW6gN+DcylS2Em
ZWH9/jLuNQcumkx8iTT1h7X9uibAOWmx0HjUmo1RZWPM6oxfS/L4jyABzWzvL2TT
dGV/uHk5NYjwkEFXA1XGsQSQqwi97thm8V6QPhWmBzdCDJnhhMSEi11mlqQgaduU
XsOUTgaflgq+Jce72o1t1HPA8sjiN7VNntiCYqVZAJE9pW0N6a37jxtc2jUpfy5T
MtZxtCrL/6X6fDosClmW+Xw0olY3xed/FfTiR6Mxh/v74VMmSnYqEyiiYvp3kywx
f+SPUJeIBdp5tcdoXlu1lMkKiwE3fQ==
=7OZK
-----END PGP SIGNATURE-----

--y7gnwzapgxhtolu3--
