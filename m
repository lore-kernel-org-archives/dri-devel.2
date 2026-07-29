Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BC4C54F5C
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CE710E3F8;
	Wed, 29 Jul 2026 04:17:14 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EED10E1D7
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:17:08 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-c0uzq2W3NtiK7h-s5VS0Og-1; Wed,
 29 Jul 2026 00:17:04 -0400
X-MC-Unique: c0uzq2W3NtiK7h-s5VS0Og-1
X-Mimecast-MFC-AGG-ID: c0uzq2W3NtiK7h-s5VS0Og_1785298623
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 130BC180044D; Wed, 29 Jul 2026 04:17:03 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAEBE18004AD; Wed, 29 Jul 2026 04:17:00 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org,
	dakr@kernel.org
Subject: [PATCH 1/6] nouveau/gsp: refactor libos entry handling for r535.
Date: Wed, 29 Jul 2026 14:15:25 +1000
Message-ID: <20260729041653.3985549-2-airlied@gmail.com>
In-Reply-To: <20260729041653.3985549-1-airlied@gmail.com>
References: <20260729041653.3985549-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jTI-yYmic_iGeOc5buKYza-REUEwx2CaV5sOqmkJgYQ_1785298623
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
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

From: Dave Airlie <airlied@redhat.com>

This just refactors the libos entries that are the same pattern,
allocate + fill out entry.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 49 ++++++++++---------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index f544afa12b6b..f4f4142ec8d0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1470,6 +1470,28 @@ static void create_pte_array(u64 *ptes, dma_addr_t a=
ddr, size_t size)
 =09=09ptes[i] =3D (u64)addr + (i << GSP_PAGE_SHIFT);
 }
=20
+static int
+gsp_fill_libos_entry(struct nvkm_gsp *gsp,
+=09=09     LibosMemoryRegionInitArgument *arg,
+=09=09     size_t size,
+=09=09     struct nvkm_gsp_mem *mem,
+=09=09     const char *name)
+{
+=09int ret;
+
+=09ret =3D nvkm_gsp_mem_ctor(gsp, size, mem);
+=09if (ret)
+=09=09return ret;
+
+=09arg->id8  =3D r535_gsp_libos_id8(name);
+=09arg->pa   =3D mem->addr;
+=09arg->size =3D mem->size;
+=09arg->kind =3D LIBOS_MEMORY_REGION_CONTIGUOUS;
+=09arg->loc  =3D LIBOS_MEMORY_REGION_LOC_SYSMEM;
+=09create_pte_array(mem->data + sizeof(u64), mem->addr, mem->size);
+=09return 0;
+}
+
 /**
  * r535_gsp_libos_init() -- create the libos arguments structure
  * @gsp: gsp pointer
@@ -1516,39 +1538,18 @@ r535_gsp_libos_init(struct nvkm_gsp *gsp)
=20
 =09args =3D gsp->libos.data;
=20
-=09ret =3D nvkm_gsp_mem_ctor(gsp, 0x10000, &gsp->loginit);
+=09ret =3D gsp_fill_libos_entry(gsp, &args[0], 0x10000, &gsp->loginit, "LO=
GINIT");
 =09if (ret)
 =09=09return ret;
=20
-=09args[0].id8  =3D r535_gsp_libos_id8("LOGINIT");
-=09args[0].pa   =3D gsp->loginit.addr;
-=09args[0].size =3D gsp->loginit.size;
-=09args[0].kind =3D LIBOS_MEMORY_REGION_CONTIGUOUS;
-=09args[0].loc  =3D LIBOS_MEMORY_REGION_LOC_SYSMEM;
-=09create_pte_array(gsp->loginit.data + sizeof(u64), gsp->loginit.addr, gs=
p->loginit.size);
-
-=09ret =3D nvkm_gsp_mem_ctor(gsp, 0x10000, &gsp->logintr);
+=09ret =3D gsp_fill_libos_entry(gsp, &args[1], 0x10000, &gsp->logintr, "LO=
GINTR");
 =09if (ret)
 =09=09return ret;
=20
-=09args[1].id8  =3D r535_gsp_libos_id8("LOGINTR");
-=09args[1].pa   =3D gsp->logintr.addr;
-=09args[1].size =3D gsp->logintr.size;
-=09args[1].kind =3D LIBOS_MEMORY_REGION_CONTIGUOUS;
-=09args[1].loc  =3D LIBOS_MEMORY_REGION_LOC_SYSMEM;
-=09create_pte_array(gsp->logintr.data + sizeof(u64), gsp->logintr.addr, gs=
p->logintr.size);
-
-=09ret =3D nvkm_gsp_mem_ctor(gsp, 0x10000, &gsp->logrm);
+=09ret =3D gsp_fill_libos_entry(gsp, &args[2], 0x10000, &gsp->logrm, "LOGR=
M");
 =09if (ret)
 =09=09return ret;
=20
-=09args[2].id8  =3D r535_gsp_libos_id8("LOGRM");
-=09args[2].pa   =3D gsp->logrm.addr;
-=09args[2].size =3D gsp->logrm.size;
-=09args[2].kind =3D LIBOS_MEMORY_REGION_CONTIGUOUS;
-=09args[2].loc  =3D LIBOS_MEMORY_REGION_LOC_SYSMEM;
-=09create_pte_array(gsp->logrm.data + sizeof(u64), gsp->logrm.addr, gsp->l=
ogrm.size);
-
 =09ret =3D r535_gsp_rmargs_init(gsp, false);
 =09if (ret)
 =09=09return ret;
--=20
2.55.0

