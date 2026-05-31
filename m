Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C504FCD6E5F
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC9D9112B79;
	Sun, 31 May 2026 14:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="FbxOMPIP";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5D0112A90
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 05:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780205406; x=1780464606;
 bh=FREyGfEkZwp/eiF+nf2+e3tagGyUid2YcD0QWCvs2J8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FbxOMPIPIoCq2Sga77+4gLpGGBTnW90cdCIb7S547XGFpMBPYvLT7s6hDjkAB42pY
 pgEDzskiepip3sxl4MuHnKF+WV1VJ96aL9743dWbm0zsV0lFvdlL9HFDle4SUZfRUF
 qcO2iSAQJqsoYErzS80v3vXKrwpel+5Hf6WKNnCdOpo5PSquiqdO0vXGdVjBBV0rWA
 TyacxLQ2Q9WvOc8enmhhOsYpvUvw+akpSYH6YqJvRCIxNDz5pTDxfrlkYPbzqjktMk
 9LbujSO/0cV4d4gzU0ZePbqdcIenQSkP1sFJRRVtlGcmoNjBZeczWhPjN+hpCFSbak
 oscUJ9qBmlhow==
Date: Sun, 31 May 2026 05:30:02 +0000
To: dri-devel@lists.freedesktop.org
From: =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Cc: liviu.dudau@arm.com, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Subject: [PATCH 2/2] drm/arm/komeda: fix ignored clk_prepare_enable() return
 value in resume
Message-ID: <20260531052945.65117-2-kaneko.dev@pm.me>
In-Reply-To: <20260531052945.65117-1-kaneko.dev@pm.me>
References: <20260531052945.65117-1-kaneko.dev@pm.me>
Feedback-ID: 165279626:user:proton
X-Pm-Message-ID: d8c93e45b1a28835a390ed888eb45bfb4ae7b22e
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

komeda_dev_resume() calls clk_prepare_enable() without checking the
return value. If the clock fails to enable, the function returns 0
(success) while IRQs are enabled and IOMMU is connected on potentially
unclocked hardware, causing undefined behavior on resume.

Propagate the error from clk_prepare_enable() and return early on
failure to prevent hardware access without a valid clock.

This issue was found by code review without access to Komeda hardware.

Signed-off-by: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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
--=20
2.54.0


