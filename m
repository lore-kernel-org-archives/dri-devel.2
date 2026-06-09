Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EBBCD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4486810E3AC;
	Tue,  9 Jun 2026 13:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="fGRTfiv1";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA8710E3AC
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1781010507; x=1781269707;
 bh=2sa4wOLRIHBZ9Y7S/f2NIEiumvRib5LLdRrVcq1CSzQ=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fGRTfiv1saw4RenM7Shq2nllNHOHmFDoXMo8h90v3lhy3CmTo6MMkrgIX7OvuouVt
 kiq/KNAZ2Yks5ICpbg8dChGZvZP9fj5jPo5MhiyDvtHu1tAXmSsa8gKe2YrGGH30vK
 El8szvtUtHRL+Tr79tFynu/QH01aAkbbXtkIm88krFeV6IOaWwMdCxb8Wgn+kEIzRs
 loU9YTsO1Kj3L0imGp1LCwEsJHUModd9dmINbalO6lNS0RsibtyyvbMRZMuiSvyEdR
 vCxQ+QV+29cRPxsBBJCvTguVSKX3sw5YElbvagQcwTPZOGkE9+ufYr3vDVVFq9rHp6
 VR0SUVDsbJwlQ==
Date: Tue, 09 Jun 2026 13:08:19 +0000
To: dri-devel@lists.freedesktop.org
From: =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Cc: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Subject: [PATCH v2] drm/arm/malidp: use clk_bulk API in runtime PM resume and
 suspend
Message-ID: <20260609130812.1065699-1-kaneko.dev@pm.me>
Feedback-ID: 165279626:user:proton
X-Pm-Message-ID: 0b6f3898ca755098f674000a975b24da7237cca6
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

malidp_runtime_pm_resume() calls clk_prepare_enable() three times
without checking the return value. If any clock fails to enable, the
driver silently proceeds with unclocked hardware, leading to undefined
behavior.

Convert both the resume and suspend paths to use the clk_bulk API:
clk_bulk_prepare_enable() in resume checks the return value and rolls
back any successfully enabled clocks on failure;
clk_bulk_disable_unprepare() in suspend keeps the two paths symmetric.

This issue was found by code review without access to Mali DP hardware.

Signed-off-by: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>
---
Changes in v2:
  - Also convert malidp_runtime_pm_suspend() to clk_bulk_disable_unprepare(=
)
    to make both paths truly symmetric (Liviu Dudau)
  - Drop the incorrect claim about existing clk_bulk usage in the suspend
    path from the commit message (Liviu Dudau)

 drivers/gpu/drm/arm/malidp_drv.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index b765f6c9eea4..90e7f14aacec 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -670,6 +670,11 @@ static int malidp_runtime_pm_suspend(struct device *de=
v)
 =09struct drm_device *drm =3D dev_get_drvdata(dev);
 =09struct malidp_drm *malidp =3D drm_to_malidp(drm);
 =09struct malidp_hw_device *hwdev =3D malidp->dev;
+=09struct clk_bulk_data clks[] =3D {
+=09=09{ .clk =3D hwdev->pclk },
+=09=09{ .clk =3D hwdev->aclk },
+=09=09{ .clk =3D hwdev->mclk },
+=09};
=20
 =09/* we can only suspend if the hardware is in config mode */
 =09WARN_ON(!hwdev->hw->in_config_mode(hwdev));
@@ -677,9 +682,7 @@ static int malidp_runtime_pm_suspend(struct device *dev=
)
 =09malidp_se_irq_fini(hwdev);
 =09malidp_de_irq_fini(hwdev);
 =09hwdev->pm_suspended =3D true;
-=09clk_disable_unprepare(hwdev->mclk);
-=09clk_disable_unprepare(hwdev->aclk);
-=09clk_disable_unprepare(hwdev->pclk);
+=09clk_bulk_disable_unprepare(ARRAY_SIZE(clks), clks);
=20
 =09return 0;
 }
@@ -689,10 +692,17 @@ static int malidp_runtime_pm_resume(struct device *de=
v)
 =09struct drm_device *drm =3D dev_get_drvdata(dev);
 =09struct malidp_drm *malidp =3D drm_to_malidp(drm);
 =09struct malidp_hw_device *hwdev =3D malidp->dev;
+=09struct clk_bulk_data clks[] =3D {
+=09=09{ .clk =3D hwdev->pclk },
+=09=09{ .clk =3D hwdev->aclk },
+=09=09{ .clk =3D hwdev->mclk },
+=09};
+=09int err;
+
+=09err =3D clk_bulk_prepare_enable(ARRAY_SIZE(clks), clks);
+=09if (err)
+=09=09return err;
=20
-=09clk_prepare_enable(hwdev->pclk);
-=09clk_prepare_enable(hwdev->aclk);
-=09clk_prepare_enable(hwdev->mclk);
 =09hwdev->pm_suspended =3D false;
 =09malidp_de_irq_hw_init(hwdev);
 =09malidp_se_irq_hw_init(hwdev);
--=20
2.54.0


