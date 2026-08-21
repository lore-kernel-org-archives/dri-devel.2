Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2429C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C79710EFC2;
	Fri, 21 Aug 2026 14:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WNsqChvK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410B910EEA5
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5B8161126;
 Fri, 21 Aug 2026 14:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80071F00A3A;
 Fri, 21 Aug 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323196;
 bh=vwnAEYpwnVf9kRbx5zVsYtCfKPaGkSnBnVHLjG7vsXA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WNsqChvKGW0zIr1YVG7j6eyf2ZkiT8rNf79fGasPuXphKJ1Vy1IA3xki1wTodTO87
 0HO0huzvAzpRcohFfk0hqQsdBv54pZ8KadrnNXBd9e2MlKagoU0t0pT0q6vKcK+C9Q
 thuCmYd3F2NAbT2/1WAfWEhtkDlGZxFDL/OtBP4EjpFAhs8nUherbuqtR0lX58dBDQ
 ikg/Fz7wRIdBrAaplLH/8ST7Rr6Muo07G7c8OPin9uyTG8B2I87uE9zo1hGfYEBbZc
 LHzJ3v0u9LNk1VKp+7CPj5LHmqTu9f1rXCvBgA6dZmefKw2MK32Iq9krVE0SLirf1c
 pxygjGS4pzaxg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:50 +0200
Subject: [PATCH 14/70] drm/kmb: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-14-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dQPeSckzrG40EQm8BE124mC2uQTO2lSD03+gAqhFwos=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSX/P6sf+XyAVx3GFO0jQyLV66sGJ55Z/npZWbHV7Z
 VP4VuvQjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARyWeM9dn9MQ7pSdqrMzkY
 17hPXTD7TeWO3Qpn8hP/dAlYHay4UfRLNCF/7eqr1sq/HTcffejkxFhnfLtpbl+fUeDRP7Hduen
 /X/y9Jpapn+vK/nWyf/x/C/svdn/OxqZoOG588uL5JcPFfnoA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The kmb crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
---
 drivers/gpu/drm/kmb/kmb_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/kmb/kmb_crtc.c b/drivers/gpu/drm/kmb/kmb_crtc.c
index 1dcdc55b0069..06cf5ad60b81 100644
--- a/drivers/gpu/drm/kmb/kmb_crtc.c
+++ b/drivers/gpu/drm/kmb/kmb_crtc.c
@@ -56,11 +56,11 @@ static void kmb_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static const struct drm_crtc_funcs kmb_crtc_funcs = {
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank = kmb_crtc_enable_vblank,
 	.disable_vblank = kmb_crtc_disable_vblank,
 };

-- 
2.55.0

