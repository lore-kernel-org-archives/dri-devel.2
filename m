Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6CE606A33E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9xgt9wx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13677112769;
	Thu,  5 Nov 2026 15:31:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0B4112769
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C388A43CBB;
 Thu,  5 Nov 2026 15:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA5E1F00A17;
 Thu,  5 Nov 2026 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892671;
 bh=VpzTf44uanY82JK5gvkIQ8PHjT9V0UkQpItWXOxArwQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=U9xgt9wxphPkAOQgwdIc5hEcxo981ESwIJtUr8qCybOHBu/MSOcREOzhMTNEWoop1
 wGoM405Vql0vxNnKCrDEQXS9Fs7EQFZ4TxOLX5XzI2AA4lVIfB8aZPn69FF4lluWe1
 /0R8Ctan3Up0OqIhIxWxq3+ZpVe56HauiRiwcbxfGtXr0jH3AGYPtlvlDVD8167g9R
 48f/esr+g9R9NcFmBeRkBDcbFi4E3dFPvfLmOnXuOBOUqj40AeKS3Pv1BjZ9J5qdM1
 NSTsx3cg9NDPglsgEPghsQ0YWCPn1qfHuSX2QeYyFORk655JvqG/KVlOZ1RKi2J3Cg
 KtWdIqaUk9vcA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:25 +0100
Subject: [PATCH RESEND 16/83] drm/hyperv: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-16-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NEEQ2MFcdUzJbtJIPNNe+JcYh9p147t0lW/gPI3Zxuw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjzJyuedIVFiFB+/szb2n5jXlJmPuP84OWakvKqXN
 H65KHNtx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI/03Ghl8dk2xYFzTNYau/
 Lb909fW0zIeFW/Oq7/7Q8Uo7IcnB++JG8LzjdioChiIFQku3CnVsYqxTyPN90WmRXMtq6XjGoPz
 9Lhn1uRIFsfe/sxhOVai+9rZcYN+GrWs/WuqtEonKFl/x6woA
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index da399cb951a5..64715cc8bdee 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -337,6 +337,4 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv)
 		return ret;
 
-	drm_mode_config_reset(dev);
-
-	return 0;
+	return drm_mode_config_create_initial_state(dev);
 }

-- 
2.55.0

