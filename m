Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFCFC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F5D10E1DF;
	Mon,  6 Jul 2026 02:28:23 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90B910E1DF
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:28:22 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-TD34GxnyONi2v6UbQoH1xA-1; Sun,
 05 Jul 2026 22:28:18 -0400
X-MC-Unique: TD34GxnyONi2v6UbQoH1xA-1
X-Mimecast-MFC-AGG-ID: TD34GxnyONi2v6UbQoH1xA_1783304897
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A3C61956075; Mon,  6 Jul 2026 02:28:17 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E021A175F; Mon,  6 Jul 2026 02:28:14 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: dakr@kernel.org
Subject: [PATCH] nouveau/instmem: use iomapping interface for instmem handling
 (v2)
Date: Mon,  6 Jul 2026 12:28:12 +1000
Message-ID: <20260706022812.834677-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bd5pu8q7uwogcFhib75_52v2oHIaZcq0s6wpVz6yYeA_1783304897
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

This avoids constant need to ioremap when instobjs move at least
on 64-bit systems.

This create the io mapping on first use, because creating it at init
time causes a resource mapping error, because nouveau hasn't kicked
simpledrm off the hardware yet, but ioremap_wc the whole BAR causes
an overlap with BOOTFB/simpledrm. I think the resource system could
do better here, but it's easier to just delay creating the mapping
until first use.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 .../nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c    |  1 +
 .../drm/nouveau/nvkm/subdev/instmem/nv50.c    | 38 +++++++++++++++----
 .../drm/nouveau/nvkm/subdev/instmem/priv.h    |  1 +
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c b/drive=
rs/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
index 700cea5def35..f128330f30d7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
@@ -297,6 +297,7 @@ r535_fbsr =3D {
 static void *
 r535_instmem_dtor(struct nvkm_instmem *imem)
 {
+=09nv50_instmem_dtor(imem);
 =09kfree(imem->func);
 =09return imem;
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers/g=
pu/drm/nouveau/nvkm/subdev/instmem/nv50.c
index 6fbaa1e5876d..7314650f6d23 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
@@ -30,10 +30,14 @@
 #include <subdev/gsp.h>
 #include <subdev/mmu.h>
=20
+#include <linux/io-mapping.h>
+
 struct nv50_instmem {
 =09struct nvkm_instmem base;
 =09u64 addr;
=20
+=09struct io_mapping iomap;
+
 =09/* Mappings that can be evicted when BAR2 space has been exhausted. */
 =09struct list_head lru;
 };
@@ -124,7 +128,6 @@ nv50_instobj_kmap(struct nv50_instobj *iobj, struct nvk=
m_vmm *vmm)
 =09struct nv50_instobj *eobj;
 =09struct nvkm_memory *memory =3D &iobj->base.memory;
 =09struct nvkm_subdev *subdev =3D &imem->base.subdev;
-=09struct nvkm_device *device =3D subdev->device;
 =09struct nvkm_vma *bar =3D NULL, *ebar;
 =09u64 size =3D nvkm_memory_size(memory);
 =09void *emap;
@@ -155,7 +158,7 @@ nv50_instobj_kmap(struct nv50_instobj *iobj, struct nvk=
m_vmm *vmm)
 =09=09mutex_unlock(&imem->base.mutex);
 =09=09if (!eobj)
 =09=09=09break;
-=09=09iounmap(emap);
+=09=09io_mapping_unmap(emap);
 =09=09nvkm_vmm_put(vmm, &ebar);
 =09}
=20
@@ -172,8 +175,7 @@ nv50_instobj_kmap(struct nv50_instobj *iobj, struct nvk=
m_vmm *vmm)
=20
 =09/* Make the mapping visible to the host. */
 =09iobj->bar =3D bar;
-=09iobj->map =3D ioremap_wc(device->func->resource_addr(device, NVKM_BAR2_=
INST) +
-=09=09=09       (u32)iobj->bar->addr, size);
+=09iobj->map =3D io_mapping_map_wc(&imem->iomap, (u32)iobj->bar->addr, siz=
e);
 =09if (!iobj->map) {
 =09=09nvkm_warn(subdev, "PRAMIN ioremap failed\n");
 =09=09nvkm_vmm_put(vmm, &iobj->bar);
@@ -188,6 +190,17 @@ nv50_instobj_map(struct nvkm_memory *memory, u64 offse=
t, struct nvkm_vmm *vmm,
 =09return nvkm_memory_map(memory, offset, vmm, vma, argv, argc);
 }
=20
+static void
+check_io_mapping(struct nv50_instmem *imem)
+{
+=09if (imem->iomap.size =3D=3D 0) {
+=09=09struct nvkm_device *device =3D imem->base.subdev.device;
+=09=09io_mapping_init_wc(&imem->iomap,
+=09=09=09=09   device->func->resource_addr(device, NVKM_BAR2_INST),
+=09=09=09=09   device->func->resource_size(device, NVKM_BAR2_INST));
+=09}
+}
+
 static void
 nv50_instobj_release(struct nvkm_memory *memory)
 {
@@ -239,7 +252,9 @@ nv50_instobj_acquire(struct nvkm_memory *memory)
=20
 =09/* Attempt to get a direct CPU mapping of the object. */
 =09if ((vmm =3D nvkm_bar_bar2_vmm(imem->subdev.device))) {
-=09=09if (!iobj->map)
+
+=09=09check_io_mapping(iobj->imem);
+=09=09if (!iobj->map && iobj->imem->iomap.size)
 =09=09=09nv50_instobj_kmap(iobj, vmm);
 =09=09map =3D iobj->map;
 =09}
@@ -277,6 +292,7 @@ nv50_instobj_boot(struct nvkm_memory *memory, struct nv=
km_vmm *vmm)
 =09=09iobj->lru.next =3D NULL;
 =09}
=20
+=09check_io_mapping(iobj->imem);
 =09nv50_instobj_kmap(iobj, vmm);
 =09nvkm_instmem_boot(imem);
 =09mutex_unlock(&imem->mutex);
@@ -330,7 +346,7 @@ nv50_instobj_dtor(struct nvkm_memory *memory)
=20
 =09if (map) {
 =09=09struct nvkm_vmm *vmm =3D nvkm_bar_bar2_vmm(imem->subdev.device);
-=09=09iounmap(map);
+=09=09io_mapping_unmap(map);
 =09=09if (likely(vmm)) /* Can be NULL during BAR destructor. */
 =09=09=09nvkm_vmm_put(vmm, &bar);
 =09}
@@ -406,10 +422,13 @@ nv50_instmem_fini(struct nvkm_instmem *base)
 =09nv50_instmem(base)->addr =3D ~0ULL;
 }
=20
-static void *
+void *
 nv50_instmem_dtor(struct nvkm_instmem *base)
 {
-=09return nv50_instmem(base);
+=09struct nv50_instmem *imem =3D nv50_instmem(base);
+
+=09io_mapping_fini(&imem->iomap);
+=09return imem;
 }
=20
 static const struct nvkm_instmem_func
@@ -433,8 +452,11 @@ nv50_instmem_new_(const struct nvkm_instmem_func *func=
,
=20
 =09if (!(imem =3D kzalloc_obj(*imem)))
 =09=09return -ENOMEM;
+
+
 =09nvkm_instmem_ctor(func, device, type, inst, &imem->base);
 =09INIT_LIST_HEAD(&imem->lru);
+
 =09*pimem =3D &imem->base;
 =09return 0;
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h b/drivers/g=
pu/drm/nouveau/nvkm/subdev/instmem/priv.h
index 87bbdd786eaa..b423f01f5fcd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h
@@ -26,6 +26,7 @@ int nv50_instobj_new(struct nvkm_instmem *, u32 size, u32=
 align, bool zero,
 =09=09     struct nvkm_memory **);
 int nv50_instobj_wrap(struct nvkm_instmem *, struct nvkm_memory *vram,
 =09=09      struct nvkm_memory **bar2);
+void *nv50_instmem_dtor(struct nvkm_instmem *base);
=20
 void nvkm_instmem_ctor(const struct nvkm_instmem_func *, struct nvkm_devic=
e *,
 =09=09       enum nvkm_subdev_type, int, struct nvkm_instmem *);
--=20
2.54.0

