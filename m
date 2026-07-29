Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A228DC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F8D10E1FF;
	Wed, 29 Jul 2026 04:17:31 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D8310E1FF
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:17:20 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-XlZbwSr5MaaWpz6LXqycQA-1; Wed,
 29 Jul 2026 00:17:16 -0400
X-MC-Unique: XlZbwSr5MaaWpz6LXqycQA-1
X-Mimecast-MFC-AGG-ID: XlZbwSr5MaaWpz6LXqycQA_1785298635
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7D8C18004D4; Wed, 29 Jul 2026 04:17:15 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64A801800480; Wed, 29 Jul 2026 04:17:12 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org,
	dakr@kernel.org
Subject: [PATCH 5/6] nouveau/gsp: add some more fields to r570 system info
Date: Wed, 29 Jul 2026 14:15:29 +1000
Message-ID: <20260729041653.3985549-6-airlied@gmail.com>
In-Reply-To: <20260729041653.3985549-1-airlied@gmail.com>
References: <20260729041653.3985549-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VK2D-E4qJXieoBG7RGjKmJbr1LgAAFkA1ZiVOYbJShI_1785298635
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

This just adds the pci io bar, link cap and os page size to the r570.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/include/nvkm/core/device.h  |  2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c    | 13 +++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c   |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/device.h b/drivers/g=
pu/drm/nouveau/include/nvkm/core/device.h
index 954a89d43bad..68b2d8a0b78c 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/device.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/device.h
@@ -86,6 +86,7 @@ enum nvkm_bar_id {
 =09NVKM_BAR0_PRI,
 =09NVKM_BAR1_FB,
 =09NVKM_BAR2_INST,
+=09NVKM_BAR3_IO,
 };
=20
 struct nvkm_device_func {
@@ -99,6 +100,7 @@ struct nvkm_device_func {
 =09resource_size_t (*resource_addr)(struct nvkm_device *, enum nvkm_bar_id=
);
 =09resource_size_t (*resource_size)(struct nvkm_device *, enum nvkm_bar_id=
);
 =09bool cpu_coherent;
+=09int (*link_cap)(struct nvkm_device *, u32 *lnk_cap);
 };
=20
 struct nvkm_device_quirk {
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/device/pci.c
index 248623b91e29..7cfa21d9abaa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
@@ -1576,6 +1576,10 @@ nvkm_device_pci_resource_idx(struct nvkm_device_pci =
*pdev, enum nvkm_bar_id bar)
 =09if (bar =3D=3D NVKM_BAR2_INST)
 =09=09return idx;
=20
+=09idx +=3D (pci_resource_flags(pdev->pdev, idx) & IORESOURCE_MEM_64) ? 2 =
: 1;
+=09if (bar =3D=3D NVKM_BAR3_IO)
+=09=09return idx;
+
 =09WARN_ON(1);
 =09return -1;
 }
@@ -1628,6 +1632,14 @@ nvkm_device_pci_preinit(struct nvkm_device *device)
 =09return 0;
 }
=20
+static int
+nvkm_device_pci_link_cap(struct nvkm_device *device, u32 *lnk_cap)
+{
+=09struct nvkm_device_pci *pdev =3D nvkm_device_pci(device);
+
+=09return pcie_capability_read_dword(pdev->pdev, PCI_EXP_LNKCAP, lnk_cap);
+}
+
 static void *
 nvkm_device_pci_dtor(struct nvkm_device *device)
 {
@@ -1646,6 +1658,7 @@ nvkm_device_pci_func =3D {
 =09.resource_addr =3D nvkm_device_pci_resource_addr,
 =09.resource_size =3D nvkm_device_pci_resource_size,
 =09.cpu_coherent =3D !IS_ENABLED(CONFIG_ARM),
+=09.link_cap =3D nvkm_device_pci_link_cap,
 };
=20
 int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index d9786830153d..857eda1e7439 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -165,6 +165,7 @@ r570_gsp_set_system_info(struct nvkm_gsp *gsp)
 =09info->gpuPhysAddr =3D device->func->resource_addr(device, NVKM_BAR0_PRI=
);
 =09info->gpuPhysFbAddr =3D device->func->resource_addr(device, NVKM_BAR1_F=
B);
 =09info->gpuPhysInstAddr =3D device->func->resource_addr(device, NVKM_BAR2=
_INST);
+=09info->gpuPhysIoAddr =3D device->func->resource_addr(device, NVKM_BAR3_I=
O);
 =09info->nvDomainBusDeviceFunc =3D pci_dev_id(pdev);
 =09info->maxUserVa =3D TASK_SIZE;
 =09info->pciConfigMirrorBase =3D device->pci->func->cfg.addr;
@@ -175,6 +176,10 @@ r570_gsp_set_system_info(struct nvkm_gsp *gsp)
 =09r570_gsp_acpi_info(gsp, &info->acpiMethodData);
 =09info->bIsPrimary =3D video_is_primary_device(device->dev);
 =09info->bPreserveVideoMemoryAllocations =3D false;
+=09info->hostPageSize =3D PAGE_SIZE;
+
+=09if (device->func->link_cap)
+=09=09device->func->link_cap(device, &info->pcieConfigReg.linkCap);
=20
 =09return nvkm_gsp_rpc_wr(gsp, info, NVKM_GSP_RPC_REPLY_NOSEQ);
 }
--=20
2.55.0

