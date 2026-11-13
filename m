Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D22606A333
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw52aLDl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3667A10EC44;
	Fri, 13 Nov 2026 16:07:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E1C10EC44
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:07:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B10E43FA8;
 Fri, 13 Nov 2026 16:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939921F000C4;
 Fri, 13 Nov 2026 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586070;
 bh=dYkEEdeg1kuJ6T8sulWWVkfmuaqyMuS1ahtUXthJEgM=;
 h=Date:From:To:Cc:Subject;
 b=Pw52aLDlSCNlPGTzbefEJRmKWS8D0a9f0FfwjZzynjXAXW5mL2CW5LTkS0Sk825u6
 YH7YP38uABwZOGku+N/QHtV6Se2ahz6Ujn6g39VW8OhBpoUVKwW8F3qjJ1aYL6zh5I
 c+Fu2iIsUeAwSXk7pIL7Uvm/jvhL7EApY21beFHOQ6NDlr6eyQ2v1PG+vAni69WR1I
 yhZxWofkEswwueFTchjHSHuZ6W+/U5bre/EVHb4TdSDlYdhlGPP3kExb2sorpJflNH
 2xKLeDbneqAcC9UpzfV4Yt5fnucndnWTqmrgtf51qcSq+PBV0Q9wwu9v28ymBJTXsH
 8pdvQcLgIVenw==
Date: Fri, 13 Nov 2026 16:07:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>, David Rosca <david.rosca@amd.com>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Prike Liang <Prike.Liang@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm-fixes tree
Message-ID: <avc10k-hNT64kqd_@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yxRd7ZU63ybmArMW"
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


--yxRd7ZU63ybmArMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c

between commits:

  87a841d8c0b71 ("drm/amdgpu: Fix VCE buffer size check for DPB and input s=
urface")
  e23621a91bb59 ("drm/amdgpu/vce: don't allocate a scheduler fence in the d=
irect IB test")
  c3fed6272bb47 ("drm/amdgpu: guard VCE/UVD sched entity teardown on failed=
 probe")

=66rom the drm-fixes tree and commits:

  98a9958c22deb ("drm/amdgpu: Allow VCE SEI command in IB")
  24c0be8ac3ef2 ("drm/amdgpu: Fix VCE buffer size check for DPB and input s=
urface")
  b229fdd689c8b ("drm/amdgpu: Allow multiple VCE create commands with same =
handle")
  5349075eac146 ("drm/amdgpu: Use feedback buffer for VCE destroy message")
  995905389d93b ("drm/amdgpu/vce: don't allocate a scheduler fence in the d=
irect IB test")

=66rom the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.c
index 11f8fe98aac46..e2cdd5a46aa24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -559,7 +559,9 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_rin=
g *ring, uint32_t handle,
 	const unsigned int ib_size_dw =3D 1024;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	struct amdgpu_ib ib_msg;
 	struct dma_fence *f =3D NULL;
+	uint64_t addr;
 	int i, r;
=20
 	r =3D amdgpu_job_alloc_with_ib(ring->adev,
@@ -573,7 +575,17 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ri=
ng *ring, uint32_t handle,
 	if (r)
 		return r;
=20
+	memset(&ib_msg, 0, sizeof(ib_msg));
+	/* only one gpu page is needed, alloc +1 page to make addr aligned. */
+	r =3D amdgpu_ib_get(ring->adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+			  direct ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
+			  &ib_msg);
+	if (r)
+		goto err;
+
 	ib =3D &job->ibs[0];
+	/* let addr point to page boundary */
+	addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);
=20
 	/* stitch together an VCE destroy msg */
 	ib->length_dw =3D 0;
@@ -587,9 +599,15 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ri=
ng *ring, uint32_t handle,
 	ib->ptr[ib->length_dw++] =3D 0x00000001; /* destroy session */
 	ib->ptr[ib->length_dw++] =3D 0x00000000;
 	ib->ptr[ib->length_dw++] =3D 0x00000000;
-	ib->ptr[ib->length_dw++] =3D 0xffffffff; /* feedback is not needed, set t=
o 0xffffffff and firmware will not output feedback */
+	ib->ptr[ib->length_dw++] =3D 0xffffffff;
 	ib->ptr[ib->length_dw++] =3D 0x00000000;
=20
+	ib->ptr[ib->length_dw++] =3D 0x00000014; /* len */
+	ib->ptr[ib->length_dw++] =3D 0x05000005; /* feedback buffer */
+	ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
+	ib->ptr[ib->length_dw++] =3D addr;
+	ib->ptr[ib->length_dw++] =3D 0x00000001;
+
 	ib->ptr[ib->length_dw++] =3D 0x00000008; /* len */
 	ib->ptr[ib->length_dw++] =3D 0x02000001; /* destroy cmd */
=20
@@ -600,6 +618,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_rin=
g *ring, uint32_t handle,
 		r =3D amdgpu_job_submit_direct(job, ring, &f);
 	else
 		f =3D amdgpu_job_submit(job);
+	amdgpu_ib_free(&ib_msg, f);
 	if (r)
 		goto err;
=20
@@ -771,6 +790,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 {
 	unsigned int fb_idx =3D 0, bs_idx =3D 0;
 	int session_idx =3D -1;
+	uint32_t img_size[AMDGPU_MAX_VCE_HANDLES];
 	uint32_t destroyed =3D 0;
 	uint32_t created =3D 0;
 	uint32_t allocated =3D 0;
@@ -862,7 +882,15 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *=
p,
 				r =3D session_idx;
 				goto out;
 			}
-			size =3D &p->adev->vce.img_size[session_idx];
+			/*
+			 * Stage the image size locally and only commit it once
+			 * the whole IB is valid, otherwise a failed create
+			 * could change the size of a live session.
+			 */
+			if (!(created & (1 << session_idx)))
+				img_size[session_idx] =3D
+					p->adev->vce.img_size[session_idx];
+			size =3D &img_size[session_idx];
 			break;
=20
 		case 0x00000002: /* task info */
@@ -875,11 +903,6 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *=
p,
 			if (destroyed & (1 << session_idx)) {
 				destroyed &=3D ~(1 << session_idx);
 				allocated |=3D 1 << session_idx;
-
-			} else if (!(allocated & (1 << session_idx))) {
-				DRM_ERROR("Handle already in use!\n");
-				r =3D -EINVAL;
-				goto out;
 			}
=20
 			luma_pitch =3D amdgpu_ib_get_value(ib, idx + 8);
@@ -904,6 +927,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 		case 0x04000007: /* motion estimation */
 		case 0x04000008: /* rdo */
 		case 0x04000009: /* vui */
+		case 0x0400000d: /* sei */
 		case 0x05000002: /* auxiliary buffer */
 		case 0x05000009: /* clock table */
 			break;
@@ -1006,7 +1030,12 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser=
 *p,
=20
 out:
 	if (!r) {
-		/* No error, free all destroyed handle slots */
+		/* No error, commit the image size of created sessions */
+		for (i =3D 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
+			if (created & (1 << i))
+				p->adev->vce.img_size[i] =3D img_size[i];
+
+		/* and free all destroyed handle slots */
 		tmp =3D destroyed;
 	} else {
 		/* Error during parsing, free all allocated handle slots */
@@ -1064,11 +1093,6 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_par=
ser *p,
 			if (destroyed & (1 << session_idx)) {
 				destroyed &=3D ~(1 << session_idx);
 				allocated |=3D 1 << session_idx;
-
-			} else if (!(allocated & (1 << session_idx))) {
-				DRM_ERROR("Handle already in use!\n");
-				r =3D -EINVAL;
-				goto out;
 			}
=20
 			break;

--yxRd7ZU63ybmArMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr3NdEACgkQJNaLcl1U
h9CKVQf7BbtcX5YhPuMneNK46QQl3JYgDQ3JeYGXSM+LV56cATRP8FgNzOWhWdAF
zVYDK6ryM3hHFeTlbE5BFV1g6o2V0j7+QshMxuqYheqNAkNCuTnkmWAvZdf5ZMEq
G3FKl4nm/rUzyzkuDKsM13lEBnRzk8C3n0YHbqi/UmgHe66SixDjVa4HTSHDidXB
xrXloTqn//7lTPX6alOIVe9bE0gM8kaNwKUN01Y7QBNcipcLJJfWfg9H0ysHHSWz
1MgzAZA2uz95mki2n6jQGSYxmDJRnXENi+mb8LZ4tEbimWwyA8susQffy1/ep/iU
7onkdD0Lwxw9Zm8K0flkTHA4Iy8gSQ==
=nKon
-----END PGP SIGNATURE-----

--yxRd7ZU63ybmArMW--
