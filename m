Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0BEC61DBE
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B83A88CFA;
	Thu, 27 Aug 2026 01:50:51 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C10610E023
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 01:50:50 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-O8H2j3s-Pfen7cCOp754PA-1; Wed,
 26 Aug 2026 21:50:45 -0400
X-MC-Unique: O8H2j3s-Pfen7cCOp754PA-1
X-Mimecast-MFC-AGG-ID: O8H2j3s-Pfen7cCOp754PA_1787795445
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEAD91831341; Thu, 27 Aug 2026 01:50:44 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.85])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0227219560AB; Thu, 27 Aug 2026 01:50:41 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org,
	dakr@kernel.org
Subject: [PATCH] nouveau/connector: set no zero sized all displayport on
 nouveau
Date: Thu, 27 Aug 2026 11:50:38 +1000
Message-ID: <20260827015038.3483865-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Eh3eX3pYGZc56-JRoYIMCdydL4Q-JbINW59r0sCysO0_1787795445
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

I'm seeing failures on Turing with some monitors, let just
not bother with zero sized on any nvidia GPU.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/=
nouveau/nouveau_connector.c
index b0b0ad9a0c24..9b9c9ea2bce1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1404,8 +1404,7 @@ nouveau_connector_create(struct drm_device *dev, int =
index)
 =09=09nv_connector->aux.drm_dev =3D dev;
 =09=09nv_connector->aux.transfer =3D nouveau_connector_aux_xfer;
 =09=09nv_connector->aux.name =3D connector->name;
-=09=09if (disp->disp.object.oclass >=3D GB202_DISP)
-=09=09=09nv_connector->aux.no_zero_sized =3D true;
+=09=09nv_connector->aux.no_zero_sized =3D true;
 =09=09drm_dp_aux_init(&nv_connector->aux);
 =09=09break;
 =09default:
--=20
2.54.0

