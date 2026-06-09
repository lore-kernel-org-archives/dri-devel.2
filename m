Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EB0CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A201E10E38A;
	Tue,  9 Jun 2026 13:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="oURKiLXN";
	dkim-atps=neutral
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9164410E42C
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1781010520; x=1781269720;
 bh=oAH8n4TUpQKVbumCEYNF4xbVwouRSK120Xy1BQFPQ+c=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=oURKiLXNTKk7UQxvp+KfjAtYEQi3hRI9OfeWLkUYG1Er+0rx0YrMo6rUHD03h+LCp
 7WWeKDBXKvs6+39j0MjfPhGS7gcnp9xlGroXPMu2M0ANB8SWeSA/ZU9vgfqJhD3aEs
 2S/Adu7A7ByaQf9+2hgafUch4UdJ9hyKXbpb5RsbK0XnxL2hSN+7dQn4iXeVLlvQDt
 eSVOeizHNlr8R1vRSE9ndIAInmN6lMACtDTJ2afJLXWhpIGmFpU/caLbrILhR/fKbw
 BDnHc/xmAZEhsALm1VtcjB1vQ2jcg/YU9WWzGq+vo/ABb/n4m1W2ilxuMw272yFft/
 p29T45vT2dKwg==
Date: Tue, 09 Jun 2026 13:08:33 +0000
To: dri-devel@lists.freedesktop.org
From: =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Cc: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Subject: [PATCH v2] drm/arm/komeda: fix error handling for
 clk_prepare_enable() and callers
Message-ID: <20260609130828.1066038-1-kaneko.dev@pm.me>
Feedback-ID: 165279626:user:proton
X-Pm-Message-ID: 870eb1d6197bf1ecf2125d17162914c9906e3de1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

komeda_dev_resume() calls clk_prepare_enable() without checking the
return value. If the clock fails to enable, the function returns 0
(success) while IRQs are enabled and IOMMU is connected on potentially
unclocked hardware, causing undefined behavior on resume.

Propagate the error from clk_prepare_enable() and fix all call sites
in komeda_drv.c that previously ignored the return value of
komeda_dev_resume():

- komeda_platform_probe(): if resume fails, jump to err_destroy_mdev
  (skipping the suspend call, since the clock was never enabled)
- komeda_pm_resume(): propagate the error and skip
  drm_mode_config_helper_resume() on failure

This issue was found by code review without access to Komeda hardware.

Signed-off-by: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>
---
Changes in v2:
  - Fix all call sites in komeda_drv.c that ignored the return value of
    komeda_dev_resume() (Liviu Dudau)
  - In komeda_platform_probe(), use a new err_destroy_mdev label to skip
    the komeda_dev_suspend() call when resume itself failed
  - In komeda_pm_resume(), propagate the error from komeda_dev_resume()
    and skip drm_mode_config_helper_resume() on failure

 drivers/gpu/drm/arm/display/komeda/komeda_dev.c |  6 +++++-
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 14 +++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 5ba62e637a61..9aad1d1d28ec 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -313,7 +313,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
=20
 int komeda_dev_resume(struct komeda_dev *mdev)
 {
-=09clk_prepare_enable(mdev->aclk);
+=09int err;
+
+=09err =3D clk_prepare_enable(mdev->aclk);
+=09if (err)
+=09=09return err;
=20
 =09mdev->funcs->enable_irq(mdev);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index 4bb5f250e95e..67fffab018ae 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -74,8 +74,11 @@ static int komeda_platform_probe(struct platform_device =
*pdev)
 =09}
=20
 =09pm_runtime_enable(dev);
-=09if (!pm_runtime_enabled(dev))
-=09=09komeda_dev_resume(mdrv->mdev);
+=09if (!pm_runtime_enabled(dev)) {
+=09=09err =3D komeda_dev_resume(mdrv->mdev);
+=09=09if (err)
+=09=09=09goto err_destroy_mdev;
+=09}
=20
 =09mdrv->kms =3D komeda_kms_attach(mdrv->mdev);
 =09if (IS_ERR(mdrv->kms)) {
@@ -93,7 +96,7 @@ static int komeda_platform_probe(struct platform_device *=
pdev)
 =09=09pm_runtime_disable(dev);
 =09else
 =09=09komeda_dev_suspend(mdrv->mdev);
-
+err_destroy_mdev:
 =09komeda_dev_destroy(mdrv->mdev);
=20
 free_mdrv:
@@ -140,11 +143,12 @@ static int __maybe_unused komeda_pm_suspend(struct de=
vice *dev)
 static int __maybe_unused komeda_pm_resume(struct device *dev)
 {
 =09struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
+=09int err =3D 0;
=20
 =09if (!pm_runtime_status_suspended(dev))
-=09=09komeda_dev_resume(mdrv->mdev);
+=09=09err =3D komeda_dev_resume(mdrv->mdev);
=20
-=09return drm_mode_config_helper_resume(&mdrv->kms->base);
+=09return err ? err : drm_mode_config_helper_resume(&mdrv->kms->base);
 }
=20
 static const struct dev_pm_ops komeda_pm_ops =3D {
--=20
2.54.0


