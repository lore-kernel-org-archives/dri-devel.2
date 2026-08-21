Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC390C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32BD10F048;
	Fri, 21 Aug 2026 14:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gEc8adUa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7E010EE68
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 94C766187A;
 Fri, 21 Aug 2026 14:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54351F000E9;
 Fri, 21 Aug 2026 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323172;
 bh=zzvDspyI5SSSaOIE3wrSNo0ErTfvxI0bYhxWh0CVZFo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gEc8adUaAAQK+961UC6GfkX+wpoJFY/gDKwjPYY1lQdNGPh7JfCV8VIAriLdeUYyo
 4N/O8fRbjcSNZOzQ80WKOGdJjTUAe+8zCtXpWzkefkbuFFqBOFpSwK+PbJ+7hH+U6U
 Se7beK71yk/NnhBTbVkBWWq+yHQRbk/4fj2kaM2KKV+jjxeqmRO8j2/rcqLpjFCBPw
 vgvRehqYUsxqMJFs4/XvMWq/eMI3tn8eG1opUWDMDrhqBwXBYlX2XEQBj9Oc/2cZln
 VvT0ajyi1lYjJxoojWtDv85/Qk2C24sZNcH8OUEato5i6I2uRjvw+uuDlDaK2qFxJB
 hGXBImJ0wgf8g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:40 +0200
Subject: [PATCH 04/70] drm/armada: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-4-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Russell King <linux@armlinux.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iB9o4mMVQPa6YQ6jIkhNL951eDS1+BeY3/GKj5V/tqE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdST+/y+kuNIyuErVifLkwtH7xHIanJvK2XY/WXHmZb
 OFn7dHWMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbi68JYH1+SEsXbaSrhunNV
 hET+vP3aL64uPxI3Meq6/7rMhVn3qk5qVWyS791dEuK8PPn35rnnGOuDG6Yl+VQvXdNysSrxTGQ
 Ux2+zM9drmrdXxC1SDL68v3XHj58uXLq2q223rngTLa7S0AoA
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

The armada crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/gpu/drm/armada/armada_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 5e006212fea0..d349beaa2990 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -815,11 +815,11 @@ static void armada_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 	armada_drm_crtc_disable_irq(dcrtc, VSYNC_IRQ_ENA);
 	spin_unlock_irqrestore(&dcrtc->irq_lock, flags);
 }
 
 static const struct drm_crtc_funcs armada_crtc_funcs = {
-	.reset		= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.cursor_set	= armada_drm_crtc_cursor_set,
 	.cursor_move	= armada_drm_crtc_cursor_move,
 	.destroy	= armada_drm_crtc_destroy,
 	.set_config	= drm_atomic_helper_set_config,
 	.page_flip	= drm_atomic_helper_page_flip,

-- 
2.55.0

