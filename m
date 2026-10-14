Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E5CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB0010FE9C;
	Wed, 14 Oct 2026 17:28:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65F810FECC
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A79560229;
 Wed, 14 Oct 2026 17:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760EC1F000C4;
 Wed, 14 Oct 2026 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998876;
 bh=DN3Onc1402nE6x9hfT7lWqrilwD/XTBAqtHGtU9GcFQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dFY1dpTv7CvA/d+XYQUvMHCTmXhlxpn8ZNgLYbObdyZGD5q6APhvEjMBDmSVoBut+
 SKMHfx92eHpvdPlPXPWmNT2RyYahQksqgZAa9GSxTksS7rfkLS81M11/aDM26Ki4ZB
 laqm2+SO0wc/f7PCkOMtqZHoPGb4H10aOFB0MH67f0e5M9QPn1rF+X6ADvmGt+h4jA
 HQFY0vzqk9yEZ88Lx7mQejFVNfKJUIIfpONLfqVP7wNjgU9L93QFFYVP0stKmNmuFq
 QgLsp7e5qPcL0dmEtimyDn+Q8SjfhwIFerfeibagBHMARrttUG9AG2aygH9l8Vu8ua
 Qm7LTDLpDyYGA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:35 +0200
Subject: [PATCH 12/75] drm/bridge: megachips: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-12-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Peter Senna Tschudin <peter.senna@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QRlM7H2SezP+s5hm5Y0KNgmx+KktLMElNYig7VWQZWY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd/t//Peg7urKww7LVjb+ObKceeLGnex3Lt9QkTikO
 3MV24ZIsY6pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwkeZGxhruqob+t6djXoV/
 zZumMuvWoga91/l+H7r++VulxlvIWgpt9P1dlKAgpLdzPucPnk9mTIwNDbMvv/wik3vL++lOtdP
 32+3V/2Wx/6p6cTw3dvHk2C+fr5Y8MF8QoffROuL8Zpt1+9mLAQ==
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

The bridge: megachips connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Ian Ray <ian.ray@gehealthcare.com>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Peter Senna Tschudin <peter.senna@gmail.com>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 4d244e6d4ed9..9153bf629fd1 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -147,11 +147,11 @@ static enum drm_connector_status ge_b850v3_lvds_detect(struct drm_connector *con
 
 static const struct drm_connector_funcs ge_b850v3_lvds_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = ge_b850v3_lvds_detect,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int ge_b850v3_lvds_create_connector(struct drm_bridge *bridge)

-- 
2.55.0

