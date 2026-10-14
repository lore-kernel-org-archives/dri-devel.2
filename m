Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC9FC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 679FD10FEC0;
	Wed, 14 Oct 2026 17:28:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC8710FEA7
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FDB760230;
 Wed, 14 Oct 2026 17:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCE41F000C4;
 Wed, 14 Oct 2026 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998905;
 bh=j0Y+LBL1XMKqi0qKSB2Y0cc9vUXp4v7BWbzgSCOTmIo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Hh8Lj5ztZRW5PnngkEH1D2prM5rvh98XrSRITrlUsYPDm85fhAzPwUVFcezK/36jy
 drcY4luw0D/5rZO+53fb/NGo9xohZt3nLGFZtJHVSJG7QDUzqpYM6YsTJRlmvLUkUU
 SAHol/VQVdAMRhDaGRrEYUmKVrUc1YoR6VIjJ+jnAQ1MoZuYNtx/1PHHH2tBRRLBi2
 phc5s/yrpueX3U8edyGytvqgy6M5kvIkiN7HFfbUK7RgA/m2HNZPHldmGYSP+2Diqj
 RmaCNIPUpqguitOX/1wukVmp+yn0+bB9ue6rCL6wdh89KzsAQVAlkZWXkgEL5ho0gx
 Ljjql2X8LkmBg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:43 +0200
Subject: [PATCH 20/75] drm/bridge: ti-tfp410: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-20-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+2tziWkBRzXnAmt2jFb196QhVernhjm49+04gIk07bg=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrPu1OipUur/masYjkiQQJGj9AP2E4fREM5YERIPFopIqxdJ
 IiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrPu1MACgkQJ1/OGaI9vnYfcAF/Z0wJ
 kx75ZlT1WvPsSNqk5E4kopyj8zNLBcPrSfRo+WVM6YwRO44BcmxP1Dx99UYqAYDlD3SLCWOTteg
 Sm6mqLyuvpdp7fJ0TYvZXu4tLdpZa+Mvr396CG5K54twf6HwK5OE=
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

The bridge: ti-tfp410 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 629ff7095e87..64a3d64e1f7b 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -93,11 +93,11 @@ tfp410_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs tfp410_con_funcs = {
 	.detect			= tfp410_connector_detect,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
 static void tfp410_hpd_work_func(struct work_struct *work)

-- 
2.55.0

