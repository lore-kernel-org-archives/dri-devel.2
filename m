Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF3CCA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6462010E1B3;
	Wed, 30 Sep 2026 21:36:50 +0000 (UTC)
X-Greylist: delayed 884 seconds by postgrey-1.36 at gabe;
 Wed, 30 Sep 2026 21:36:49 UTC
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2642F10F4F0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 21:36:49 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-IvSqCvZWNxSmw-KlnwCdBA-1; Wed,
 30 Sep 2026 17:22:02 -0400
X-MC-Unique: IvSqCvZWNxSmw-KlnwCdBA-1
X-Mimecast-MFC-AGG-ID: IvSqCvZWNxSmw-KlnwCdBA_1790803321
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B13D8195FDCC; Wed, 30 Sep 2026 21:22:01 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.53])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 826A5180056E; Wed, 30 Sep 2026 21:21:56 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, Woody Suwalski <terraluna977@gmail.com>,
 Lyude Paul <lyude@redhat.com>
Subject: [PATCH] nouveau: check gsp->rm as well as gsp pointer before gcx ready
Date: Thu,  1 Oct 2026 07:21:51 +1000
Message-ID: <20260930212151.3926202-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Of5foB7NQ5SLM8JBG69-ZJ-koMj5II0Z_qNP-oT6-xM_1790803321
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
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

In turing systems where gsp exists, but can end up not being used,
we need to add a second check.

Fixes: cb4c7603678c ("drm/nouveau/gsp/r570: Add support for INTERNAL_GCX_EN=
TRY_PREREQUISITE")
Reported-by: Woody Suwalski <terraluna977@gmail.com>
Tested-by: Woody Suwalski <terraluna977@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/device/user.c
index f78e6b9b4292..b841d66f8bb3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
@@ -201,7 +201,7 @@ nvkm_udevice_gcx_ready(struct nvkm_udevice *udev, void =
*data, u32 size)
 =09} *args =3D data;
 =09int ret =3D -ENOSYS;
=20
-=09if (!gsp) {
+=09if (!gsp || !gsp->rm) {
 =09=09args->v0.ready =3D NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
 =09=09return 0;
 =09}
--=20
2.55.0

