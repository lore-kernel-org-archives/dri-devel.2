Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EFAC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ADCD10E313;
	Fri, 21 Aug 2026 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EzAwTeuz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE6010E313
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1359661126;
 Fri, 21 Aug 2026 14:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4247F1F000E9;
 Fri, 21 Aug 2026 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323186;
 bh=re1eb35ZdS1svUjOnqsfFM5fIy5wYJs2GS7KkwlgjzE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EzAwTeuzdJPbkSjPGP26/swSCzlkVRWxSRD0+/TKaqH7rfrtsPgYVCWtgiOJaNNvD
 92k5wdY9zwZZKKvBhAS38YgrJ7B1o5rOoJQk6lgx4Tc6MbB4g3P38H5sQGpNh/dEnm
 wMsGRfHsDw//TuoBStTap96OaBo08qC1hJdw4Qj8pcCwchSkXYYztHK6Sij5kj/ubV
 JDvJDxpyPbVrhIYpinbKG+5kg8XFy2QxV0PzfWdWarTQr7rEPgFmRqw3Ht5UL8P7OH
 Ugeuk3xmbrwIPNpFb8wdVqkmhEABIH8JYwubfgLYk9wdC1DpYjnk56ZpoXCRJzHxtm
 XrtfvqFceaT1g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:46 +0200
Subject: [PATCH 10/70] drm/hyperv: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-10-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ruXycmb3plf+6PWeu1i/vP/qvX3ZaYbws8zFBzAuWY8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSX+CvY+dS93+izW6+VbR0435+p+TZb6c9Xzbo+pv5
 XKurNmlYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEcR1jnUH5pahHN2ekTZ+8
 ziO8bMeLn+vSUir+/18SvVeY7WGxpmdN5S4W56uLTOeEMh5ey8E3hbHh3VypKs39qxUkLkzcKBL
 9zTf7qE7z3ois2EORE4V9Frvp+V6SuCZnU7nGYqbDnDlC58UB
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

The hyperv crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 1855749c1e41..3261e730c69d 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -124,11 +124,11 @@ static const struct drm_crtc_helper_funcs hv_drm_crtc_helper_funcs = {
 	.atomic_enable = hv_drm_crtc_helper_atomic_enable,
 	.atomic_disable = drm_crtc_vblank_atomic_disable,
 };
 
 static const struct drm_crtc_funcs hv_drm_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

