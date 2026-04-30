Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210EAFF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED3110E8DC;
	Thu, 30 Apr 2026 17:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="SyR31FxA";
	dkim-atps=neutral
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [178.154.239.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B1A10E131;
 Thu, 30 Apr 2026 10:47:08 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1ba8:0:640:1638:0])
 by forward103b.mail.yandex.net (Yandex) with ESMTPS id 3A5B4C00A6;
 Thu, 30 Apr 2026 13:47:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id jkYvs17QISw0-3jKAYhKh; 
 Thu, 30 Apr 2026 13:47:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1777546025; bh=XK8fhHHhN8C7AZWTsdc+3Jx084S2B5DKpyixkH26TpE=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=SyR31FxAyv/4EHWsum+z02yw7yCr13aMdUa9TPXrbuHbygNGTdp6QrzMqTd8we5Mu
 SUe4CaILLmNu7I6IUPW0A27wzCxLK6xVASWklcIoiZOOk0HbER7JBLO/Nbmiw2isFI
 RKWYA3FObdjqE/vUnnJIo+edKMFKc72ATemCjjeE=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>, kernel test robot <lkp@intel.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon/rs780: prevent division by zero in refresh rate
 calculation
Date: Thu, 30 Apr 2026 13:46:25 +0300
Message-ID: <20260430104626.16230-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 17:06:40 +0000
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604300508.yXci8rey-lkp@intel.com/

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/radeon/rs780_dpm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/rs780_dpm.c b/drivers/gpu/drm/radeon/rs780_dpm.c
index 64bb4cafb8b5..8713f3fd6268 100644
--- a/drivers/gpu/drm/radeon/rs780_dpm.c
+++ b/drivers/gpu/drm/radeon/rs780_dpm.c
@@ -63,8 +63,11 @@ static void rs780_get_pm_mode_parameters(struct radeon_device *rdev)
 		if (crtc && crtc->enabled) {
 			radeon_crtc = to_radeon_crtc(crtc);
 			pi->crtc_id = radeon_crtc->crtc_id;
-			if (crtc->mode.htotal && crtc->mode.vtotal)
+			if (crtc->mode.htotal && crtc->mode.vtotal) {
 				pi->refresh_rate = drm_mode_vrefresh(&crtc->mode);
+				if (pi->refresh_rate == 0)
+					pi->refresh_rate = 60;
+			}
 			break;
 		}
 	}
@@ -363,6 +366,8 @@ static void rs780_program_at(struct radeon_device *rdev)
 {
 	struct igp_power_info *pi = rs780_get_pi(rdev);
 
+	WARN_ON(pi->refresh_rate == 0);
+
 	WREG32(FVTHROT_TARGET_REG, 30000000 / pi->refresh_rate);
 	WREG32(FVTHROT_CB1, 1000000 * 5 / pi->refresh_rate);
 	WREG32(FVTHROT_CB2, 1000000 * 10 / pi->refresh_rate);

base-commit: a5640267d6d35b89ebe6418da90a952a247215a5
-- 
2.43.0

