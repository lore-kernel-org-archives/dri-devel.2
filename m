Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18315606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqA7PPKR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4881127BF;
	Thu,  5 Nov 2026 15:34:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B151127BF
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43A4B41639;
 Thu,  5 Nov 2026 15:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42A81F00919;
 Thu,  5 Nov 2026 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892867;
 bh=Xt4hH4VoJ4/rVxmRxT2pBfw/m2jWZwNB6NG13qdmg7Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mqA7PPKRiXOYL53BeoybGFlr0PBEbyazxZKR3RNd3Bq20CcregjBXvnc4q58m4rSI
 7eWZDmEdrL/qdy43Hk5lTM4GKRKj8ycIqE8EARBDLe7IxdlA68e9U9aGH5vI8MX4zw
 83Mx17DxYzjlzl/Lx2z0YEdlVZ5rEVxW4FMqWpO6c0FLKpubCHw7GHzP6CmupCeaD+
 UUGlqvQ8Sm3rQQyACKRFdLbFgzLiRK2lrmXaYQDMm7pNbq4d/OIyOD0gyoxNw+VM0+
 shDKtqeH+FtPkR8/+T8iJNFcl38Mwih5us2ojF68Xe+LU8W/BmE2hGe4vnOgcav4U0
 IQx5kZvy96mwg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:19 +0100
Subject: [PATCH RESEND 70/83] drm/panel-mipi-dbi: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-70-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aRgQBInOZGzWlWVWIlTeTlVh2d9tT8DErrpEZJSOczM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvzZ0zI3gV+Al1sw97703Iu7DO10NSZen7B8Qc61N
 79czlnadExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJONsyNrx3PD3jq0rH46hS
 w7m9py8uko/1v/bU9xvrX4HPx5Y7n47l7O1f9OdHe1yBSuS97Q16hYwNE4/4zNq558jXVwvD08/
 yfLzx1nqXkeMVK/+oDeXVV36XrDm8rOrzzwc620wXtoi/tbqrDQA=
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
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 60cd65cae41d..c900b1366723 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -491,5 +491,7 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

