Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7A606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3bBpSfq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33D711277D;
	Thu,  5 Nov 2026 15:31:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D69811277D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA37660416;
 Thu,  5 Nov 2026 15:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB941F000C1;
 Thu,  5 Nov 2026 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892693;
 bh=s9rn1LkKNo5IXTOTlmdXquj0FVx/2gKURS6OQVVX7dI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=f3bBpSfqlsg7Q1pP1IynYZxR7Q42BeZwFpuC5uav88fNSv19PiP4xW3Zys9GsM8EX
 KWFVPQoTAvjacwUSXdPn4Uc4lLpHLAJXWnLRylYDY1r5pc3WA+1ynX3oYArwOvDBsD
 UYyhwnkka04j0rNh0GI0vAvTfGDsmwBwaqwsLxSLysQI77ooZ88q369FGM7onE/nBL
 IFFAlKOxVrv+GD1LSagYaoDEoeKCy3rDrMrgCKwc8N/VwFsoLxxOMBXQbjSi8BEciX
 aYEA4Ogdlqee6bA3OibMRrbVE8YG+QkwIoPilkp9sYsBVHxsbwjydk5iFmhqLXtNmR
 jINaVaxa0UMzg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:31 +0100
Subject: [PATCH RESEND 22/83] drm/logicvc: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-22-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Paul Kocialkowski <paulk@sys-base.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=mripard@kernel.org;
 h=from:subject:message-id; bh=soVS9mt/NxBvR6HuwPnc/5nJQXN7K+fEDZR+AQnuVac=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjy/dP7zzba5Jhsr/zs9vvb3p5fZ26NzRaO/uj+v/
 WcTVmKd2TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmwtTH2LB17pftjdH1v4V3
 rilUZznNIjzt05zOialO21QntP50ucT4mtH2+xTOOYsWbH2Qc0pzTitjnZHKjRvXLZpYl80tkr7
 77s0/D02WZL3TU9M75Lu+vpzbN01EcN+s7l5ni57pvyOOyvbvBQA=
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
Cc: Paul Kocialkowski <paulk@sys-base.io>
---
 drivers/gpu/drm/logicvc/logicvc_mode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_mode.c b/drivers/gpu/drm/logicvc/logicvc_mode.c
index 3cf04b70bd27..15503f96743f 100644
--- a/drivers/gpu/drm/logicvc/logicvc_mode.c
+++ b/drivers/gpu/drm/logicvc/logicvc_mode.c
@@ -62,5 +62,7 @@ int logicvc_mode_init(struct logicvc_drm *logicvc)
 	mode_config->funcs = &logicvc_mode_config_funcs;
 
-	drm_mode_config_reset(drm_dev);
+	ret = drm_mode_config_create_initial_state(drm_dev);
+	if (ret)
+		return ret;
 
 	drm_kms_helper_poll_init(drm_dev);

-- 
2.55.0

