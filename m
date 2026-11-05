Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A66606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkNo4K6D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B80D1127D3;
	Thu,  5 Nov 2026 15:35:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C91751127D0
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:35:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D17143E2D;
 Thu,  5 Nov 2026 15:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025FE1F00919;
 Thu,  5 Nov 2026 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892914;
 bh=D1lPWoZgtascfff6oWyF9LVlDZE3615lrN3x2SVFNJ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fkNo4K6DpJrPgQzUPEdo2PL0l48fPnaGLx1tstml9MxHxzw/1NGDJBw8YicYDbNsg
 65wJ5eqFt8w+gY26BYoT1aaJokZBb2UjzxAHjF2qh8w27p9mWBYt4VGKVm+pnRlsKn
 TAaf5yKEFveib0JQ5AOd46GPncCzfxspJR4D5jWn/m/mVLq7/yM8ikAQFmJ31+10mw
 U1nz3xNjR01razA2tLuCDnLW0bDMEiCtVrFz911Lf3LM+Oz4SxG+uGLLNnISAG7kUq
 JYVQIibHA9VHemoWJfY4hz7BzxmeQWU0A78OfwVWlj9dPK683hsYiSR2fKLZv5f/eD
 /pHeRPhrgEQQw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:32 +0100
Subject: [PATCH RESEND 83/83] drm/xlnx: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-83-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Michal Simek <michal.simek@amd.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/wgPaiFnCNliiMqpteje8s1ldYDr3sRGXiSaVbLQ8Xs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjKWsDYJic4P9mjsqNkltqN7o3iZPnN3wYUbOpfr5
 HyeW7l3TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIkcX83YcGDqZ22zwKPtwWkn
 HxXWbM1Z+dvs9vSWojC/5o0PDS239feIXp1Z+C79GM/RR8bbMk+pMzYs+WTzd9/hp0b/c5l5fQS
 +RO6zP1bFZN6j5Tl954SiXuuWNy/MVXtfu0/dv7fmyqtz6U8A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index 5274bd3f9078..c123ded46f4c 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -525,6 +525,8 @@ int zynqmp_dpsub_drm_init(struct zynqmp_dpsub *dpsub)
 	drm_kms_helper_poll_init(drm);
 
-	/* Reset all components and register the DRM device. */
-	drm_mode_config_reset(drm);
+	/* Create the initial state and register the DRM device. */
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_poll_fini;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

