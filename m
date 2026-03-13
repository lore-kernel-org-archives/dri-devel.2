Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F5F106FD9B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38BA10EB25;
	Fri, 13 Mar 2026 08:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ab9S3arQ";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF9910E0B7
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:32:46 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124a7216c9cso44156c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 23:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773383566; x=1773988366; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fl4H23Ge0Zsyj8n566Pf+v0tahs4AEuuruZIdW3bY9s=;
 b=ab9S3arQFgx/5gHxJ15EuVNTbg4eHHkZ/TeB3xLxAtqc+obx+eoHqAy6qoNiaUsip6
 17nzeXEwPqpnW7mW5XXTXdeTNGmmT48iNDMQdVOaZ/rFIlT8ztex3zRiwczhpd//WHCu
 YLO+usaVAPA19DwdWCeCYn85wnMramr5TRi2bvh0LebnBR5RZ94WFz4iW5FOdRTz60Ei
 3a31Zyt70lN/uNFPoDVOWnF8ExWCUntw21ZbpLDFCXVtllr/NWEtAIFktbCmmQoYNq6k
 bZ6UNgVt85ZfEI/k5LSChQ3WmB0tAFFovtGcbTYCXGo84iFlfLlGH9IfztE1L9HnjDrQ
 hi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383566; x=1773988366;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fl4H23Ge0Zsyj8n566Pf+v0tahs4AEuuruZIdW3bY9s=;
 b=TT5iwPdfg9CurTU8CakyQvTNJ0iSknN8Hm74GOQvgOUmoAeuQNtBdJrsC/zv/qgX2c
 A2XB7OPj9p7p/NwgMT8VuKjO/2N/qKAgAM06u2+knLj9wKmdpx5wRCXkk6PgQuCAQ6/j
 KCFGp+tsLTUZOz33BnEIa/wRZtw1qzSYWYFxuJc31pZz8chxG6aw79zKDlLoyEiAAi6t
 1RK/fXuI+PvhaD+VABerYOSHEE4IU/f6qtzSpO1TiY5EMzMfarJVGlSssnhs38+c+w27
 V+xLpLXnRVbZJymIIRitZmM9Jchq4/Lu94YHuo9p/Tu/FzN0iBQ1ovEP/lQcExG8zVlb
 YN6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4G4reLrppzQnWx+9dL086G80AqoMQZ+vIxTY0trZqEFGjCRUQvWa4mG42zB20jlpXYeXQ+5dpuek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3qgJN3r0eOcTcZklH1i6CMYDmlizsMVWeoS4XwujtqbGvYqQ6
 3MUwlFkXdtPDCx9YSCx3LJyynGZI7hbUWVx4Ci6mOxwMAU8bi6L7zUj7
X-Gm-Gg: ATEYQzwovRVeF+LPcByWscvotYEYFaeNZMkB5xeaNGhJo9t3N4XPx/1mczPNrobz75F
 q7YXB6p5BEsUw0VmZKvXkpxexMPtYZnqWGlNHOGVwG0NtGmAfQ2T0ttezjQDoEIgQ6lX3T9TehJ
 pkGimJZID/ZrxPxjij80/STot7GC6dbw0un7Y5aIzlfGKhxEDDUZvldTtA2qmwlcjAovje+r7M+
 1v8udir9RDoTSiwraaEYLYU09zHZffoHkP/uk14j0Wvx63B4Nsijmzg25WRmpD+ESe+WUjQp2Nm
 gJjQqg0NQwVFS3iQa3iYPaiGw4dRZxND0Okw5E/nFY2bn6zta3xX2FE/9Pu5l8/B/dnEeKZfwva
 5qdaVZIWdok0Ne3ziFNq3VjkfBMwOrZHhvGJhB60QnB3NBqIyWb3jix4nzVZtHFkz8Ojk4ZK4Cy
 7iFVMQEFI1b5gXqMJRtWU4
X-Received: by 2002:a05:7022:f8c:b0:128:d81e:adb7 with SMTP id
 a92af1059eb24-128f3c6740emr553076c88.0.1773383565553; 
 Thu, 12 Mar 2026 23:32:45 -0700 (PDT)
Received: from hobbes ([2600:70ff:f864:0:caf6:9140:4157:1e66])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128f62b2100sm1049160c88.8.2026.03.12.23.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 23:32:44 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:32:40 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] drm/nouveau: fix misleading indentation
Message-ID: <6c1d96782664e4f491f23e8c73545fe4d8b9533a.1773383224.git.joeypabalinas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k7ogklrer7rk7odl"
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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


--k7ogklrer7rk7odl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] drm/nouveau: fix misleading indentation
MIME-Version: 1.0

Fix misleading indentation in if/else statements.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 49 ++++++++++++-------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouv=
eau/nouveau_abi16.c
index f9201f2e73a339a10b..3da75aa136d04faf3b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -425,14 +425,14 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
=20
 	if (device->info.family >=3D NV_DEVICE_INFO_V0_TESLA)
 		init->pushbuf_domains =3D NOUVEAU_GEM_DOMAIN_VRAM |
 					NOUVEAU_GEM_DOMAIN_GART;
 	else
-	if (chan->chan->push.buffer->bo.resource->mem_type =3D=3D TTM_PL_VRAM)
-		init->pushbuf_domains =3D NOUVEAU_GEM_DOMAIN_VRAM;
-	else
-		init->pushbuf_domains =3D NOUVEAU_GEM_DOMAIN_GART;
+		if (chan->chan->push.buffer->bo.resource->mem_type =3D=3D TTM_PL_VRAM)
+			init->pushbuf_domains =3D NOUVEAU_GEM_DOMAIN_VRAM;
+		else
+			init->pushbuf_domains =3D NOUVEAU_GEM_DOMAIN_GART;
=20
 	if (device->info.family < NV_DEVICE_INFO_V0_CELSIUS) {
 		init->subchan[0].handle =3D 0x00000000;
 		init->subchan[0].grclass =3D 0x0000;
 		init->subchan[1].handle =3D chan->chan->nvsw.handle;
@@ -579,21 +579,20 @@ nouveau_abi16_ioctl_grobj_alloc(ABI16_IOCTL_ARGS)
 				oclass =3D sclass[i].oclass;
 				break;
 			}
 		}
 	} else
-	if ((init->class & 0x00ff) =3D=3D 0x00b3) { /* msppp */
-		/* msppp: compatibility with incorrect version exposure */
-		for (i =3D 0; i < ret; i++) {
-			if ((sclass[i].oclass & 0x00ff) =3D=3D 0x00b3) {
-				oclass =3D sclass[i].oclass;
-				break;
+		if ((init->class & 0x00ff) =3D=3D 0x00b3) { /* msppp */
+			/* msppp: compatibility with incorrect version exposure */
+			for (i =3D 0; i < ret; i++) {
+				if ((sclass[i].oclass & 0x00ff) =3D=3D 0x00b3) {
+					oclass =3D sclass[i].oclass;
+					break;
+				}
 			}
-		}
-	} else {
-		oclass =3D init->class;
-	}
+		} else
+			oclass =3D init->class;
=20
 	nvif_object_sclass_put(&sclass);
 	if (!oclass)
 		return nouveau_abi16_put(abi16, -EINVAL);
=20
@@ -652,21 +651,21 @@ nouveau_abi16_ioctl_notifierobj_alloc(ABI16_IOCTL_ARG=
S)
 		args.target =3D NV_DMA_V0_TARGET_VM;
 		args.access =3D NV_DMA_V0_ACCESS_VM;
 		args.start +=3D chan->ntfy_vma->addr;
 		args.limit +=3D chan->ntfy_vma->addr;
 	} else
-	if (drm->agp.bridge) {
-		args.target =3D NV_DMA_V0_TARGET_AGP;
-		args.access =3D NV_DMA_V0_ACCESS_RDWR;
-		args.start +=3D drm->agp.base + chan->ntfy->offset;
-		args.limit +=3D drm->agp.base + chan->ntfy->offset;
-	} else {
-		args.target =3D NV_DMA_V0_TARGET_VM;
-		args.access =3D NV_DMA_V0_ACCESS_RDWR;
-		args.start +=3D chan->ntfy->offset;
-		args.limit +=3D chan->ntfy->offset;
-	}
+		if (drm->agp.bridge) {
+			args.target =3D NV_DMA_V0_TARGET_AGP;
+			args.access =3D NV_DMA_V0_ACCESS_RDWR;
+			args.start +=3D drm->agp.base + chan->ntfy->offset;
+			args.limit +=3D drm->agp.base + chan->ntfy->offset;
+		} else {
+			args.target =3D NV_DMA_V0_TARGET_VM;
+			args.access =3D NV_DMA_V0_ACCESS_RDWR;
+			args.start +=3D chan->ntfy->offset;
+			args.limit +=3D chan->ntfy->offset;
+		}
=20
 	ret =3D nvif_object_ctor(&chan->chan->user, "abi16Ntfy", info->handle,
 			       NV_DMA_IN_MEMORY, &args, sizeof(args),
 			       &ntfy->object);
 	if (ret)
--=20
Cheers,
Joey Pabalinas


--k7ogklrer7rk7odl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmmzr4gbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEKqB7vQk8aMCkVAQAJ148g2qWIqsAEqEqSkt
vAyVkxh4eqEF7hSJoRAD8zp1a3mMxjmZYwDzC3fvlEeyrTjcKSGU4ec28O+Ruu0L
sHng+ludg4a426Ofe4hLSeRC9HTQKpEvtC0+y3C8JIOdXfInRTZrccGU8/goyY9z
zVaVBBdLnpIXNc+2FxMdj9nrujZCd1uTGL+XOL1pxC6rjVgT5W5x/MKEGaLiK98X
m1CSsIH7I+g71nt/3XvFVkPwawHtlj6QFEJwSEOjTRcS1vpZcGr+nUiM1XXi0CKY
oJtmeOsYX7sTgOhKDml9LHxgeRu+J8iGcHOA6poke00bSB1pdvXYzOc3x/2lLZbW
tRk139aRXeNUUZznN+tCtyOScZQXPUJpis0b+0izliM5GtAPJIugnd/wjpKRg86z
EYIiPfY6AoDeQKCCvuTmoZqRIGm1naT4uUEkFAZc54GOFA4utFR7WXxGZ2T0RrZq
7Z1ntYwW8VCEKmVJxmYcXz/hUiDKe4ZRBPcwUagDW3WE4zmHXaFUOf6Fv8azgyCZ
INtvtUqn6N2WEc+IleKK1IzyqJjyq+OyZzSqyCofbq+WycCyLeSBaO4xWr/Fd5qu
S2KZf9GaCgUTlk9QD2qamVwANkRdkxZRUnH/UKyOKNdOciPIm/BGjhVEsPtXtiU9
BbCHq7coMN8hinzZLCdoi1it
=7+J+
-----END PGP SIGNATURE-----

--k7ogklrer7rk7odl--
