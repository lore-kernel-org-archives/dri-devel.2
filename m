Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6FACC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BB610FED0;
	Wed, 14 Oct 2026 17:29:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D39510FEFF
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E53AB60229;
 Wed, 14 Oct 2026 17:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FA71F000C4;
 Wed, 14 Oct 2026 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998966;
 bh=3KY8KzpunUhXh9p0gufy23Wksfi/dgRlXKl7dBKli0k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=R0CAVHi/rbRnWB61VIWaHClzch+OoWURh34K0ezOrjVS+7IkKoq69NQRuOQtfgbAR
 Aea3nLQ19aduFFjAM07U1CyGecW9kzY1R52dJeP2KLdgAItKQ1BaBfP6Qrc3/uvd1v
 NPRUYPwallJYFdJXxZ/fTJjYzawL0H6wJ0FEB1I0BeWEwMq0JUVemH1Fbzr3vLCZqn
 e7YFkkO0Yq48iYtaO3+QSqN/IB2UsjITAQ/MhdYsSFqUwRgBFWPe27BIA53sZfAoMc
 lBG0DKzFceXG/qg5jwpagUzEWkmaP08adChI6ByjmM6onAZCyWA7s4D3Pn5jKP/9wq
 kqE6N8NplL43g==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:00 +0200
Subject: [PATCH 37/75] drm/stm: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-37-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CdabbJSt8HO8EmPDHnb/bAg2tFQR7S+7ZlTy6FfH0po=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd0fdmhqgoqj6Wdma2Z7PPvzVtPLwQ8+UHrRvV/G0D
 bvmt3Fvx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjI3BWMDYc8a4yO61oqJ71g
 m9603e/8J5OqH+3zI1Tey31enK8woWNvd+4C2+RbtV6HT3gFSFjIMdaHzPz/53uF0PuC9fcStqZ
 N2Xlt8VY5g3m+9y9Ft08QqeS+x74k9Nu65Vt5WuymiFhoNYkAAA==
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

The stm connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Philippe Cornu <philippe.cornu@foss.st.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>
---
 drivers/gpu/drm/stm/lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
index 1072dbe7bd6a..e72a64f14f47 100644
--- a/drivers/gpu/drm/stm/lvds.c
+++ b/drivers/gpu/drm/stm/lvds.c
@@ -927,11 +927,11 @@ static const struct drm_connector_helper_funcs lvds_conn_helper_funcs = {
 	.get_modes = lvds_connector_get_modes,
 	.atomic_check = lvds_connector_atomic_check,
 };
 
 static const struct drm_connector_funcs lvds_conn_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

