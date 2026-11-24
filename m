Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDB606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWRih7ZI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CEE10ECA6;
	Tue, 24 Nov 2026 17:31:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9823810E283;
 Tue, 24 Nov 2026 17:31:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 313B643CC9;
 Tue, 24 Nov 2026 17:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E31F000D2;
 Tue, 24 Nov 2026 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795541507;
 bh=7BOhALOWGOqa/3ADOLPrCh1s8Dt3hRUkimSSK/0HERI=;
 h=Date:From:To:Cc:Subject;
 b=CWRih7ZIF7kmmLYjnUqs1I5+NWmHoabVwpVXiaDSH2n7FF2Pniz4L4N6P49FfAqrb
 2rOFHTXmeaS+RpROAhE1RwMt7SBMW+ILqbdK5XBjtksm89QTVioWb8FVMxCnY+BlA1
 bSG97On5ze9gUFTL8VrFdKXHpaYmd78EJibXp7+iX9pvF12eUheAENgxu7F7iRRE0R
 o+z4hE5xmbVPfdCd1jKZlissKF+MnP9ZkpdB4tpHgqLXXRCiu+Z83FeE9gHVgS6A5H
 4KFMhGQSaOTLKmAXNKSi+9P90GuBUg1ASqvavGMNaahFttlEc9jS4+BiJU3YfeABgT
 TSOfLrH/Py/gA==
Date: Tue, 24 Nov 2026 17:31:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <awXJ__-grexFFPb4@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xtez2l9DzSPawuop"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--xtez2l9DzSPawuop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:217:3: error=
: call to undeclared function 'dma_buf_unmap_attachment_unlocked'; ISO C99 =
and later do not support implicit function declarations [-Wimplicit-functio=
n-declaration]
  217 |                 dma_buf_unmap_attachment_unlocked(buffer->attach,
      |                 ^
/tmp/next/build/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:217:3: note:=
 did you mean 'dma_buf_unmap_sgt_unlocked'?
/tmp/next/build/include/linux/dma-buf.h:587:6: note: 'dma_buf_unmap_sgt_unl=
ocked' declared here
  587 | void dma_buf_unmap_sgt_unlocked(struct dma_buf_attachment *attach,
      |      ^
/tmp/next/build/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:438:8: error=
: call to undeclared function 'dma_buf_map_attachment_unlocked'; ISO C99 an=
d later do not support implicit function declarations [-Wimplicit-function-=
declaration]
  438 |         sgt =3D dma_buf_map_attachment_unlocked(attach, DMA_BIDIREC=
TIONAL);
      |               ^
/tmp/next/build/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:438:8: note:=
 did you mean 'dma_buf_map_sgt_unlocked'?
/tmp/next/build/include/linux/dma-buf.h:585:1: note: 'dma_buf_map_sgt_unloc=
ked' declared here
  585 | dma_buf_map_sgt_unlocked(struct dma_buf_attachment *attach,
      | ^
/tmp/next/build/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:438:6: error=
: incompatible integer to pointer conversion assigning to 'struct sg_table =
*' from 'int' [-Wint-conversion]
  438 |         sgt =3D dma_buf_map_attachment_unlocked(attach, DMA_BIDIREC=
TIONAL);
      |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
/tmp/next/build/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:553:3: error=
: call to undeclared function 'dma_buf_unmap_attachment_unlocked'; ISO C99 =
and later do not support implicit function declarations [-Wimplicit-functio=
n-declaration]
  553 |                 dma_buf_unmap_attachment_unlocked(attach, sgt,
      |                 ^

Caused by commit

   6e0a8f1a83473 (platform/raspberrypi: Add VideoCore shared memory support)

=66rom the broadcom tree.  I have applied Sasha's fixup below

=46rom 60cdd23176d1a7b222ba90427f07c6d10859b744 Mon Sep 17 00:00:00 2001
=46rom: Sasha Levin <sashal@kernel.org>
Date: Tue, 24 Nov 2026 09:56:52 -0500
Subject: [PATCH] linux-next: semantic conflict between the drm-misc and
 broadcom trees

Hi Mark,

The current drm-misc tree has a semantic conflict with the broadcom
tree that breaks the build:

  drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:217:3: error: call to unde=
clared function 'dma_buf_unmap_attachment_unlocked'
  drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:438:8: error: call to unde=
clared function 'dma_buf_map_attachment_unlocked'

77e0b2d2f4f3 ("treewide: Rename dma_buf_(un)map_attachment() to
dma_buf_(un)map_sgt()") in the drm-misc tree renames the functions, and
6e0a8f1a8347 ("platform/raspberrypi: Add VideoCore shared memory
support") in the broadcom tree adds a new user of the old names. It is
the only caller in next-20261123 that the rename doesn't cover.

The fix for the merge:

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c b/drivers/platf=
orm/raspberrypi/vc-sm-cma/vc_sm.c
index 2d9bb5f957a37..7ba6e1f2aa6aa 100644
--- a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
+++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
@@ -214,9 +214,8 @@ static void vc_sm_clean_up_dmabuf(struct vc_sm_buffer *=
buffer)
 {
 	/* Handle cleaning up imported dmabufs */
 	if (buffer->sgt) {
-		dma_buf_unmap_attachment_unlocked(buffer->attach,
-						  buffer->sgt,
-						  DMA_BIDIRECTIONAL);
+		dma_buf_unmap_sgt_unlocked(buffer->attach, buffer->sgt,
+					   DMA_BIDIRECTIONAL);
 		buffer->sgt =3D NULL;
 	}
 	if (buffer->attach) {
@@ -435,7 +434,7 @@ vc_sm_cma_import_dmabuf_internal(struct dma_buf *dma_bu=
f,
 		goto error;
 	}
=20
-	sgt =3D dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
+	sgt =3D dma_buf_map_sgt_unlocked(attach, DMA_BIDIRECTIONAL);
 	if (IS_ERR(sgt)) {
 		ret =3D PTR_ERR(sgt);
 		goto error;
@@ -550,8 +549,7 @@ vc_sm_cma_import_dmabuf_internal(struct dma_buf *dma_bu=
f,
 		free_kernel_id(import.kernel_id);
 	kfree(buffer);
 	if (sgt)
-		dma_buf_unmap_attachment_unlocked(attach, sgt,
-						  DMA_BIDIRECTIONAL);
+		dma_buf_unmap_sgt_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
 	if (attach)
 		dma_buf_detach(dma_buf, attach);
 	dma_buf_put(dma_buf);
--=20
2.47.3


--xtez2l9DzSPawuop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFyf4ACgkQJNaLcl1U
h9CmHwf/SU7/iyvVAAI4/nfDtLFEk+idA+aZ5ShlGYjspVTRPkRHcrSl93f1wzO/
4KDuuhiT9ARlSVOoGMiLuggffJOwOZOtFtB2+s4EDwaUnQBAp63/z/Rn1HGzGn8Y
kMQ2RL0LX+q+NyVeXFKEX/+3rJRvWT+fuQm0VYRXgqN2uqEHZnpuY+ck4zNzi7ng
Qptma2rKZDOCeb1jjHnxvYnoWRLG/l6qtohQRY80vkGl9FqCARS9m7ich8ZiSflb
2XoMMIH4V+b8l0a6FGVKVrCpMGDXIYbWFkM0bWwnTrsdseVQ146zDTSsGacajunu
mpRoMhSZDVx3nrjQtRi7FhpT5/2vww==
=q93P
-----END PGP SIGNATURE-----

--xtez2l9DzSPawuop--
