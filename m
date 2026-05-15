Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA9DCD4F51
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7680110E6D8;
	Mon, 18 May 2026 07:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="fuxr8e75";
	dkim-atps=neutral
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FE210E0F8
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1778846057; x=1779105257;
 bh=QxtCszucR2ecHDKXKl3lNVrCe53WJHoNtSwfDpYlT1s=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fuxr8e75e4VwA/0Wrmk6+ICrpk7vbCydAWdakFzZiJ6g23hsjclC2lg3G5z2tOb60
 K9t+ElkqTLPXhV9El7FEj0KT93fFHHGTlpzN08/0kF/rak3cUbOw56qhCJwUVkpeNX
 k4c90Op0e3Ie5lDUUXUxPKdddmn+xWG1KUFJhjgw5ThvSjPnfIcWHgpBcJ2mOLjLXm
 aYgOwLDDDdCEVvOQX/zoVnPs53nDvwa9fvzImMmzMzLvk/WYf7DrYm+Qz0KGWvruED
 YbmQff9wbXSm/O4Mt6i+haESNg5P8KlLyTYJQNgd9NnBJoIs7/JzEyQK8QIuFPq7+g
 c1NiU/kzaEgOQ==
Date: Fri, 15 May 2026 11:54:07 +0000
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org
From: Abhai Kollara <abhai@protonmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhai Kollara <abhai@protonmail.com>
Subject: [PATCH] accel/rocket: use dev_err_probe() for MMIO mapping errors
Message-ID: <20260515115335.4104438-1-abhai@protonmail.com>
Feedback-ID: 8137229:user:proton
X-Pm-Message-ID: 747d057083a37a9b5a7bd0c343887a96dda76bb1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

The reset and clock paths in rocket_core_init() already use
dev_err_probe(), but the three devm_platform_ioremap_resource_byname()
calls still open-code dev_err() followed by return PTR_ERR(). Convert
them for consistency. dev_err_probe() additionally silences the
-EPROBE_DEFER noise in dmesg and records the failure reason against
the device, where /sys/kernel/debug/devices_deferred can surface it.

Signed-off-by: Abhai Kollara <abhai@protonmail.com>
---
 drivers/accel/rocket/rocket_core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rock=
et_core.c
index b3b2fa9ba645..1b27a2c2f435 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -33,22 +33,19 @@ int rocket_core_init(struct rocket_core *core)
 =09=09return dev_err_probe(dev, err, "failed to get clocks for core %d\n",=
 core->index);
=20
 =09core->pc_iomem =3D devm_platform_ioremap_resource_byname(pdev, "pc");
-=09if (IS_ERR(core->pc_iomem)) {
-=09=09dev_err(dev, "couldn't find PC registers %ld\n", PTR_ERR(core->pc_io=
mem));
-=09=09return PTR_ERR(core->pc_iomem);
-=09}
+=09if (IS_ERR(core->pc_iomem))
+=09=09return dev_err_probe(dev, PTR_ERR(core->pc_iomem),
+=09=09=09=09     "couldn't find PC registers\n");
=20
 =09core->cna_iomem =3D devm_platform_ioremap_resource_byname(pdev, "cna");
-=09if (IS_ERR(core->cna_iomem)) {
-=09=09dev_err(dev, "couldn't find CNA registers %ld\n", PTR_ERR(core->cna_=
iomem));
-=09=09return PTR_ERR(core->cna_iomem);
-=09}
+=09if (IS_ERR(core->cna_iomem))
+=09=09return dev_err_probe(dev, PTR_ERR(core->cna_iomem),
+=09=09=09=09     "couldn't find CNA registers\n");
=20
 =09core->core_iomem =3D devm_platform_ioremap_resource_byname(pdev, "core"=
);
-=09if (IS_ERR(core->core_iomem)) {
-=09=09dev_err(dev, "couldn't find CORE registers %ld\n", PTR_ERR(core->cor=
e_iomem));
-=09=09return PTR_ERR(core->core_iomem);
-=09}
+=09if (IS_ERR(core->core_iomem))
+=09=09return dev_err_probe(dev, PTR_ERR(core->core_iomem),
+=09=09=09=09     "couldn't find CORE registers\n");
=20
 =09dma_set_max_seg_size(dev, UINT_MAX);
=20
--=20
2.43.0


