Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DA8CD98D2
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 02:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1527210E590;
	Fri, 12 Jun 2026 02:13:19 +0000 (UTC)
X-Greylist: delayed 369 seconds by postgrey-1.36 at gabe;
 Fri, 12 Jun 2026 02:13:17 UTC
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3199A10E590
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 02:13:17 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-_MzuU9R0OF6NQ44H7H7Otg-1; Thu,
 11 Jun 2026 22:07:04 -0400
X-MC-Unique: _MzuU9R0OF6NQ44H7H7Otg-1
X-Mimecast-MFC-AGG-ID: _MzuU9R0OF6NQ44H7H7Otg_1781230024
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAD5119560AD; Fri, 12 Jun 2026 02:07:03 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.94])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5983530001A7; Fri, 12 Jun 2026 02:07:00 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: dakr@kernel.org
Subject: [PATCH] nouveau/gem: reserve the bo in the info ioctl around the vma
 lookup
Date: Fri, 12 Jun 2026 12:06:58 +1000
Message-ID: <20260612020658.3176270-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z479l1sKg8zwFWwYdpbIKLvWZ7P0gLBI6A_S40GO-UY_1781230024
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

In the non-uvmm path, there could be a race between the info lookup
finding the vma, and the gem close path closing the vma leading
to a use-after-free.

Spotted with the help of Opus 4.6.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouvea=
u/nouveau_gem.c
index 20dba02d6175b..c5a24dff4b69b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -313,11 +313,20 @@ nouveau_gem_info(struct drm_file *file_priv, struct d=
rm_gem_object *gem,
 =09rep->offset =3D nvbo->offset;
 =09if (vmm->vmm.object.oclass >=3D NVIF_CLASS_VMM_NV50 &&
 =09    !nouveau_cli_uvmm(cli)) {
+=09=09int ret;
+
+=09=09ret =3D ttm_bo_reserve(&nvbo->bo, false, false, NULL);
+=09=09if (ret)
+=09=09=09return ret;
+
 =09=09vma =3D nouveau_vma_find(nvbo, vmm);
-=09=09if (!vma)
+=09=09if (!vma) {
+=09=09=09ttm_bo_unreserve(&nvbo->bo);
 =09=09=09return -EINVAL;
+=09=09}
=20
 =09=09rep->offset =3D vma->addr;
+=09=09ttm_bo_unreserve(&nvbo->bo);
 =09} else
 =09=09rep->offset =3D 0;
=20
--=20
2.54.0

