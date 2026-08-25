Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BBBC5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 03:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6F510E0CF;
	Tue, 25 Aug 2026 03:06:32 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1568110E0CF
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 03:06:30 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-3KWmiD9-N9Wxc32ViemdXw-1; Mon,
 24 Aug 2026 23:06:28 -0400
X-MC-Unique: 3KWmiD9-N9Wxc32ViemdXw-1
X-Mimecast-MFC-AGG-ID: 3KWmiD9-N9Wxc32ViemdXw_1787627187
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE8D6193E8CA; Tue, 25 Aug 2026 03:06:21 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B66B1955F08; Tue, 25 Aug 2026 03:06:18 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org,
	dakr@kernel.org
Subject: [PATCH] nouveau/instmem: handle iomapping already existing
Date: Tue, 25 Aug 2026 13:06:15 +1000
Message-ID: <20260825030615.3464436-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wssBf8Dx596OXkDNLkegcFhguMcOBin_JjO5rX13CUs_1787627187
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

Turns out sashiko was right, and I should protect this properly

Fixes: 34e27b90552a ("nouveau/instmem: use iomapping interface for instmem =
handling")
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers/g=
pu/drm/nouveau/nvkm/subdev/instmem/nv50.c
index f4489efc94a7..22b0fde6ba34 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
@@ -195,6 +195,9 @@ check_io_mapping(struct nv50_instmem *imem)
 {
 =09struct nvkm_device *device =3D imem->base.subdev.device;
=20
+=09if (imem->iomap.size)
+=09=09return true;
+
 =09return io_mapping_init_wc(&imem->iomap,
 =09=09=09=09  device->func->resource_addr(device, NVKM_BAR2_INST),
 =09=09=09=09  device->func->resource_size(device, NVKM_BAR2_INST)) !=3D NU=
LL;
--=20
2.55.0

