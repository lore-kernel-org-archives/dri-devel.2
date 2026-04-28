Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0449BFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9FF010EF2C;
	Wed, 29 Apr 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="aNrmgChc";
	dkim-atps=neutral
X-Greylist: delayed 314 seconds by postgrey-1.36 at gabe;
 Tue, 28 Apr 2026 19:09:19 UTC
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net
 [178.154.239.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EADB410E377;
 Tue, 28 Apr 2026 19:09:19 +0000 (UTC)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
 by forward203a.mail.yandex.net (Yandex) with ESMTPS id 9F2A9869C3;
 Tue, 28 Apr 2026 22:04:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1d:6281:0:640:c935:0])
 by forward103a.mail.yandex.net (Yandex) with ESMTPS id 52E1F806AD;
 Tue, 28 Apr 2026 22:04:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id i3f98gObjmI0-kMIkEECX; 
 Tue, 28 Apr 2026 22:04:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1777403041; bh=tr9ncHDLQsp/htwG5JIQTALMzIL3/WgOspiEBUJqEko=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=aNrmgChc8Uj4xd9AlRNV1rVyvXv1Hfj3u7RQtuXI6XNxd+/rZZ1L8vTcz1MPo4b+U
 cvOBt3o6gp8fam6uxhWXtahexc2YMgVue1Rg4ewLQRSFlwO0MbiEHYuSHHTDfgkDJU
 MmPzkwJv8XBbR0r9rUou8K1BsQfy0C9webtLwmG4=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon/rs780: prevent division by zero in refresh rate
 calculation
Date: Tue, 28 Apr 2026 22:03:18 +0300
Message-ID: <20260428190318.34413-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

drm_mode_vrefresh() may return zero when mode clock is zero even if
htotal and vtotal are non-zero. Current code checks only htotal and
vtotal, allowing refresh_rate to become zero and subsequently causing
division by zero in rs780_program_at().

Fix by adding mode clock validation and fallback to default 60Hz in
rs780_get_pm_mode_parameters(). Add WARN_ON in rs780_program_at() to
catch such cases during development, ensuring safe fallback in all
scenarios.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/radeon/rs780_dpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/rs780_dpm.c b/drivers/gpu/drm/radeon/rs780_dpm.c
index 64bb4cafb8b5..fe45b7dac9f4 100644
--- a/drivers/gpu/drm/radeon/rs780_dpm.c
+++ b/drivers/gpu/drm/radeon/rs780_dpm.c
@@ -65,6 +65,8 @@ static void rs780_get_pm_mode_parameters(struct radeon_device *rdev)
 			pi->crtc_id = radeon_crtc->crtc_id;
 			if (crtc->mode.htotal && crtc->mode.vtotal)
 				pi->refresh_rate = drm_mode_vrefresh(&crtc->mode);
+				if (pi->refresh_rate == 0)
+					pi->refresh_rate = 60;
 			break;
 		}
 	}
@@ -363,6 +365,8 @@ static void rs780_program_at(struct radeon_device *rdev)
 {
 	struct igp_power_info *pi = rs780_get_pi(rdev);
 
+	WARN_ON(pi->refresh_rate == 0);
+
 	WREG32(FVTHROT_TARGET_REG, 30000000 / pi->refresh_rate);
 	WREG32(FVTHROT_CB1, 1000000 * 5 / pi->refresh_rate);
 	WREG32(FVTHROT_CB2, 1000000 * 10 / pi->refresh_rate);
-- 
2.43.0

