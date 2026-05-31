Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7812CD6E52
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5331112B73;
	Sun, 31 May 2026 13:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="HqymL6be";
	dkim-atps=neutral
X-Greylist: delayed 1846 seconds by postgrey-1.36 at gabe;
 Sun, 31 May 2026 05:30:02 UTC
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12E1112A8E
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 05:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780205400; x=1780464600;
 bh=y+Rd6zvqkwrqjAizGqlbkG9mnJN2pGkEAObVFttlXKI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=HqymL6beCPtG/nP4R53yrJFjpMcvxNfDuSr4tqo5rrFugMwzDSLNEE5Ss+GXbwF2b
 m5QoACvuwa16fzdTLl2QIEpxXnPEHXRnea3+iQnJcN1PcFFm9A2UUnbH1ekuGf3L0Q
 qfqaPocV4XfrhtJrMAPNl8PeYuKb2wINfLisA3L8+PaLnjt5GMI5igkoxY3zzIXmGJ
 JzSg4p1pREaglyHMk1j1+aLgAxkE3Ea3qj5ZZcfHxrdcfmsjF8SHKqxncS9Gl2L+BO
 Xcy2YGj4s2dcEq0tdd6WFYWHiS+rVb1llWoznE0middxG/o51DqSYYjmhfRO9CTLKc
 7/yDCb6NGbL1g==
Date: Sun, 31 May 2026 05:29:57 +0000
To: dri-devel@lists.freedesktop.org
From: =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Cc: liviu.dudau@arm.com, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Subject: [PATCH 1/2] drm/arm/malidp: fix ignored clk_prepare_enable() in
 runtime PM resume
Message-ID: <20260531052945.65117-1-kaneko.dev@pm.me>
Feedback-ID: 165279626:user:proton
X-Pm-Message-ID: dd3d2b66cdc978b6573d4b1c8767eb81d41835fb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

Use clk_bulk_prepare_enable() which atomically enables all clocks and
automatically rolls back successfully enabled clocks on failure. This
is consistent with how the suspend path already uses
clk_bulk_disable_unprepare() in malidp_runtime_pm_suspend().

This issue was found by code review without access to Mali DP hardware.

Signed-off-by: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>
---
 drivers/gpu/drm/arm/malidp_drv.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index b765f6c9eea4..1e4336c3a2fa 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -689,10 +689,17 @@ static int malidp_runtime_pm_resume(struct device *de=
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


