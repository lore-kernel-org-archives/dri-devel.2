Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D85E99052
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24B710E8E9;
	Fri, 10 Apr 2026 08:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="saeM88dG";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE32810E8E9;
 Fri, 10 Apr 2026 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775808815; x=1776413615; i=natalie.vock@gmx.de;
 bh=Vn1UGNBs1QyV7pxaDRuQ2btI1igmoxTSy+0hWWgfu/8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=saeM88dGWOGznfPCtMwzTLIK60jaBjvemVrw6BvMnzYxaSl5/h0bg3twx22VeUUz
 J0mYxKaWMRMQfLlUSVxxKmpTWUy6H/XcNXYCmAh9low7bTE+qoGHLhsmUFINDg1QO
 iiY1SF+Chfb1eez8fA4d88C+6r/oYQV/qFgW2TKRH5RFrkausD8OGhuV/SW2GLXd8
 mFGBy3dUyFR3YaO5HcJnMKIfT4PE+UwnpvxU3WhHLQcGCCddF5EB8rm9Z4JFV752c
 TNq8XSziBnog0yULwEDIJ1X/wORpF8QQJ/G5AWK8RIiH8EJjoOhjRfec0ZYnbVewo
 iQ5SE81KhyRT4d+ulQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzjt-1vw0qV3siH-00UJx7; Fri, 10
 Apr 2026 10:13:35 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau: Wire up dmem cgroups
Date: Fri, 10 Apr 2026 10:13:22 +0200
Message-ID: <20260410081322.5577-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nz7T+bG1UobiYQlCbJ7EJ2UUyAb0CMBG4HG9VTf4za5vcqoX0yZ
 kw4TcswMnPCzjSVz/MyZ72tkI7t4MP3JaejWWB5ilo5ejDNssz2ApUORC+GqXG/b591ndJW
 JD3AVoM32ps2VXJPM778LKf7Ytjr0+dEVL+TpGabdrQj/5lNoObnMjZt0lnSw4JRPOVHuOp
 2E4mGlCB4tSy0rGY8t5Tw==
UI-OutboundReport: notjunk:1;M01:P0:g95ZQpXfjXc=;UmA5WVCoxJbJMMcIL995pr6s4gc
 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
 Mc8MxbtORXOQ+Nhb/lbSWtUzE9lRvrylQ==
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

Userspace can now make use of memory protection via dmem cgroups. Let
nouveau benefit from this as well by registering the vram region with
the dmem cgroup controller.

This patch adapts the approach amdgpu and Xe have taken for enabling
dmem cgroups.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/nouveau/nouveau_ttm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouve=
au/nouveau_ttm.c
index ad01f922aa86a..860bca7e3ce28 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -188,6 +188,11 @@ nouveau_ttm_init_vram(struct nouveau_drm *drm)
=20
 		man->func =3D &nouveau_vram_manager;
=20
+		man->cg =3D drmm_cgroup_register_region(drm->dev, "vram",
+						      drm->gem.vram_available);
+		if (IS_ERR(man->cg))
+			return PTR_ERR(man->cg);
+
 		ttm_resource_manager_init(man, &drm->ttm.bdev,
 					  drm->gem.vram_available >> PAGE_SHIFT);
 		ttm_set_driver_manager(&drm->ttm.bdev, TTM_PL_VRAM, man);
=2D-=20
2.53.0

