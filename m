Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B9C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF7010EAB1;
	Wed, 14 Oct 2026 17:28:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8B010FEBD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC8DE4381C;
 Wed, 14 Oct 2026 17:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2161F000C4;
 Wed, 14 Oct 2026 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998897;
 bh=0N/DsPBMKLiq4dzEVbv+VJMx/uS1iS1VCReOO61ovgI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=U4XZqEWguunk1zMhtXx9RPE2alXoh0QrQ/f/jYC9ivtlxh2T99I6NiFlAWbRWEAZV
 Z36JcX27iDyCPMcDP8y3ip03bYG7IZOA7Q4yCrqP9r7SmL8nR9BfeyzuARaiNpcSHg
 u/AqXrdwggES7aYEqSgs0ikfqZEcWDbNXL0Eg6gTuFwdY46Oi6hSKGmG8wn92TaEWw
 8PviLHrtomDvyr9nx9KI7AAoTJSH2PVWUn6mg1rXzM7R+k2AauRqsNAVZED0+3NusE
 +4foijysvf+6jfEdavkkuuWcphp/uk9yIHKN2Oh17j6MSsvFR6wOzhH2g0iDgshuFL
 5lqyYK0DPzKaQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:41 +0200
Subject: [PATCH 18/75] drm/bridge: tc358767: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-18-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Av+L9kbdG+Tiz2KX/9uO3Z1m+fCUMiB22HmsM8TDgkk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndwcp6ae8lfTasOnMkkMVWx8XJytYvnK5WH7QLEJXf
 oZ+yrSajqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRS36MDY8nvslomnbx6vXv
 N1+eCfu6zTt1QVXwAb8ZTKWvPFtYd230X+F9+g2T8oJL/czV06Y+/cDY8HLhlT+KfrcO8yjzvzu
 +++SXKhOWh3sF3sl3Cms836k+qUfl5GPl3kT9PM2C+ROTpaNXAQA=
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

The bridge: tc358767 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 51f4baa62a53..5ea6d3726bee 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1794,11 +1794,11 @@ tc_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs tc_connector_funcs = {
 	.detect = tc_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int tc_dpi_bridge_attach(struct drm_bridge *bridge,

-- 
2.55.0

