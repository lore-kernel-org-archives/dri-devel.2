Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE489606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWXN9KUx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5493C1127CB;
	Thu,  5 Nov 2026 15:35:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1479A1127D3
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:35:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87324600AA;
 Thu,  5 Nov 2026 15:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69891F000C1;
 Thu,  5 Nov 2026 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892907;
 bh=AJeiCVvfyY85JAhDoKltpPkEwHIu9FS3xRtZcbwnbsQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PWXN9KUx8k/OrtQgrcBV0sjpuHPyoyPqFZKYrowa2VUeoo3vN8yVC5j9yeC0nP0Kr
 vrOCs8kliXi9shn2mw3TlF8aalK9x6kX41v2nD/tHFMVBUnYGdJwrTaH3xadtD7wuy
 yXvYpMFl17FhxtrShmxWkZnZt8UTTK4k2M7nsDwiIiUTe/hPHLw4wXVrpkVIey3n0j
 wu3Z0cIjchJm4f7flzybm2tbzNHtqm++G58uM0ADUvu4XymNTkJ16ZDaySYUmscnlH
 CikC559z8shfYB+xWOaMU86nNhxpGClUc0aNv1PdSR9+gqnPpoZXt6R0n82WR9PMBN
 cbiPw2jxC38gw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:30 +0100
Subject: [PATCH RESEND 81/83] drm/vmwgfx: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-81-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3HSecBXAHqR/GgaZcMa4oKww89pG6n1ygaunSqC7gMc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjKc7s/ib9xzUufKx/3JEX3pVT0aD1aaTJs0b3+Pf
 fcs84qijqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR8ibGhveqPd97Zv1n7UrQ
 dElJn55zZP6OXDnP8NOZrV3N58qm6H6X7L24peNt+9qNkTppFjKtjPUBxc9WezYzPEm4m7mFd3k
 gh271aaUXehEailurWhlbfG4kn7n3IuDi2ak3wrPyo7NtIgE=
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
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  | 4 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 4 +---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 4 +---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index 0dea09cc29a7..93d755b81887 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -568,5 +568,7 @@ int vmw_kms_ldu_init_display(struct vmw_private *dev_priv)
 	dev_priv->active_display_unit = vmw_du_legacy;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err_free;
 
 	return 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index 39d58fc392bf..82fe7db26633 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -940,7 +940,5 @@ int vmw_kms_sou_init_display(struct vmw_private *dev_priv)
 	dev_priv->active_display_unit = vmw_du_screen_object;
 
-	drm_mode_config_reset(dev);
-
-	return 0;
+	return drm_mode_config_create_initial_state(dev);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index b505f8ba3e83..80defd735813 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1709,6 +1709,4 @@ int vmw_kms_stdu_init_display(struct vmw_private *dev_priv)
 	}
 
-	drm_mode_config_reset(dev);
-
-	return 0;
+	return drm_mode_config_create_initial_state(dev);
 }

-- 
2.55.0

