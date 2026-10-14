Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A3DCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4965C10FEF0;
	Wed, 14 Oct 2026 17:30:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1663310FECC
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 88E7260229;
 Wed, 14 Oct 2026 17:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F241F000C4;
 Wed, 14 Oct 2026 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999003;
 bh=uUWyKVR5UpnfG2STldJEM87C9NSZ89/C0vcGYyNYL7I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Wc969+TR5yQtiUekZNTGO7a1vz40xi4XQwtGaH6NyZ4FZiI3g8kRXFLJ4zrzQrA+u
 eXKM1L6GF7lSm+WYNs5kJKGErBVWDX1Y16+hubexqwEq1FeuxiL775U8SXkXZuzJ5S
 aRfvwWObfBpSt624eT10DSAKSGQ7ilWQYLYGQ5Ta3jZOyVYmTPoegQZWAA+RDND7f/
 H0TMhSNcUQtL770Nlsw7hJ7UTSH0yb+81nmLOXCyUDCxHhWOav+EszAkXbnJCTdnwN
 BctrRboZsA5MN/qtuOOl7bXsNqFm2V2HE/wzhXg9Py1QoR3nKYidWL3/m/LZXoFIec
 NkKhgTTGYArww==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:10 +0200
Subject: [PATCH 47/75] drm/tiny: repaper: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-47-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=mripard@kernel.org;
 h=from:subject:message-id; bh=65zX1gwANuQTZ1tF70ldFBiyF4SRKP2Je+q52vqnkEY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8fPO/a0OMxBRtikp6j/mH1RmGb1Ay+RGkHXruzqV
 TMLvGI7prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwESsTjM2nGCI9/e1WfT71owT
 e5y33t/Sfzw+qq/x2obPJxdNXvxpQ5PY70U97F+L9f5ffpkp8CvmPGPDmafn7r66LhDjXP3xzR4
 vZukZRoWPAzx/+J5g+3yu4WGLpQh774pr1xyNxQOs3dyYRTYAAA==
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

The tiny: repaper connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alex Lanzano <lanzano.alex@gmail.com>
---
 drivers/gpu/drm/tiny/repaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 82c99d86656f..08daee20f584 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -924,11 +924,11 @@ static int repaper_connector_get_modes(struct drm_connector *connector)
 static const struct drm_connector_helper_funcs repaper_connector_hfuncs = {
 	.get_modes = repaper_connector_get_modes,
 };
 
 static const struct drm_connector_funcs repaper_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

