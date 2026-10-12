Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D482CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E44710E1B1;
	Mon, 12 Oct 2026 15:59:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9603B10E1B1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:59:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8C2D601FB;
 Mon, 12 Oct 2026 15:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EA21F0089B;
 Mon, 12 Oct 2026 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791820781;
 bh=BDRvqqZfo/phUQFJtkCaQB6PTdv+TDTlvf9qWVda4V0=;
 h=Date:From:To:Cc:Subject;
 b=ghY60TObteGrPY8SCpcdXGlgOKmNZwQdzZo3WINUrpIRpPai6GZWsNBhhj7n0QED4
 LpzoqHUosOcGqWgH7UeB/8QzzdjnRI8KLNNR3BBduxIVYezIz01GM9BHmF3Y+GvTFU
 2uzPVNj7iJOBLg2t+ISt+fQJq3quYb0hDfPoE8i/dCQBaCnfR4aSNN+RmuGTsQ2AlO
 SoOC9CpCP4ftbmpI/zrBbR4DOcApAP/ebhgfX/KGvor9D2Bj8NdwAl3OTf7THq1fxR
 Det2apOY3rpMv8NY/uZR2PfNqope3h/nKRLhfBlLCRsYxT1LFU906wa+Qf3N3WSzDx
 Q+bKvMqcjvBhg==
Date: Mon, 12 Oct 2026 16:59:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>
Subject: linux-next: manual merge of the drm tree with the qcom tree
Message-ID: <as0D5rnMA-26-LDk@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/pXuEVpPPVC4nohe"
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


--/pXuEVpPPVC4nohe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/firmware/qcom/Kconfig

between commits:

  618aedff70fbe ("firmware: QCOM interfaces should depend on ARCH_QCOM")
  50508d3e0abd8 ("firmware: qcom: scm: Hide QCOM_SCM instead of depending o=
n ARCH_QCOM")

=66rom the qcom tree and commit:

  8fecd3194de33 ("firmware: QCOM interfaces should depend on ARCH_QCOM")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/firmware/qcom/Kconfig
index 3ad22f8fc3e5f,691db0ded8e8c..0000000000000
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@@ -26,7 -26,8 +26,7 @@@ config QCOM_PAS_TE
  	  by the firmware TEE implementation as the backend.
 =20
  config QCOM_SCM
 -	tristate "Qualcomm PAS SCM interface driver"
 -	depends on ARCH_QCOM || COMPILE_TEST
 +	tristate "Qualcomm PAS SCM interface driver" if ARCH_QCOM || COMPILE_TEST
  	select QCOM_PAS
  	select QCOM_TZMEM
  	default y if ARCH_QCOM
@@@ -35,17 -36,33 +35,17 @@@ config QCOM_TZME
  	tristate
  	select GENERIC_ALLOCATOR
 =20
 -choice
 -	prompt "TrustZone interface memory allocator mode"
 -	depends on QCOM_TZMEM
 -	default QCOM_TZMEM_MODE_GENERIC
 -	help
 -	  Selects the mode of the memory allocator providing memory buffers of
 -	  suitable format for sharing with the TrustZone. If in doubt, select
 -	  'Generic'.
 -
 -config QCOM_TZMEM_MODE_GENERIC
 -	bool "Generic"
 -	help
 -	  Use the generic allocator mode. The memory is page-aligned, non-cachab=
le
 -	  and physically contiguous.
 -
  config QCOM_TZMEM_MODE_SHMBRIDGE
 -	bool "SHM Bridge"
 +	bool "TrustZone interface memory allocator: SHM Bridge"
 +	depends on QCOM_TZMEM
  	help
 -	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
 -	  in the 'Generic' allocator but is also explicitly marked as an SHM Bri=
dge
 -	  buffer.
 +	  Use Qualcomm Shared Memory Bridge as memory allocator. The memory has =
the
 +	  same alignment as in the 'Generic' allocator, which is used when this =
option
 +	  is disabled, but is also explicitly marked as an SHM Bridge buffer.
 =20
  	  With this selected, all buffers passed to the TrustZone must be alloca=
ted
  	  using the TZMem allocator or else the TrustZone will refuse to use the=
m.
 =20
 -endchoice
 -
  config QCOM_QSEECOM
  	bool "Qualcomm QSEECOM interface driver"
  	depends on QCOM_SCM=3Dy

--/pXuEVpPPVC4nohe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrNA+UACgkQJNaLcl1U
h9AwJgf/ZvVFQ1nmqe1NDSrVI/iaov6vIXJxvdi2XSNrsQC7PsA9N+IW1de+d6G3
4ggnKhfg9tu3V1kgyUqqEP69hysFOY4GicfkvTAnWppmNLM6rXi6NbXMcZ+KtdMA
jEM78CGA1sGzfWUhJd+GAZKFlhwgWR5wj6MEODDUXU05MeQFho8ZpIsfyllKTFIv
zI5jMT/kK5BvGWZJvD9jTKGJrfBTFxn0Tj+9YLNVCemqlqb1EAk4+IvnVRzXdeRK
H/FyYqwX+0TjYIpu1YsX7jgrXwQbztoT9kdLoLa2sEPqgyO+t/2ldW7aHvufZELb
HWRo48RWsYSa5kjr2NNEqlJjkaEl3w==
=/Mxj
-----END PGP SIGNATURE-----

--/pXuEVpPPVC4nohe--
