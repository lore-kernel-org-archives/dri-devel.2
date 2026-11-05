Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B8606A33E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f49uVw1k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4212112772;
	Thu,  5 Nov 2026 15:31:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FB211277B
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3207740B37;
 Thu,  5 Nov 2026 15:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE651F000C1;
 Thu,  5 Nov 2026 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892668;
 bh=/SOw4P4t+HIgwV9F9O5DLg/hJecTT5lm5QNjH5YPwJ8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=f49uVw1k2C6oLVPkoMWShEYuC+L81scMuxMyjF29r7OR19nqPO26Uoook3hJt+5v8
 n8LZR2PVPSXmJGEwCVRH3amnocQDoYkyNsCPeqrbcuQ5pglhtRUbuRsN2Eb3kTSp5q
 kNSxKBnfZK9Gta4HPEGSRdEOcgWMZV0iEEMyK+Z2nY/MjnKDSRqguwFspTnC9tkDwj
 a6PZ6CWDHORCFwx9xZSStVPdisNLhvBHof/i+CnDKdLkj6lmUUPlQdf95zdF/0lxMk
 wkFZUS69jT7uu+CTFWS1PGiekTY0mD+UcrMEGU14gj2eBvQNegFGKgHb0YSc/Sr57Y
 vhvwNXrTByexg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:24 +0100
Subject: [PATCH RESEND 15/83] drm/hisilicon/kirin: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-15-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 John Stultz <jstultz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=mripard@kernel.org;
 h=from:subject:message-id; bh=b56/ijKN0j3NZq0isHwgM9USbq0fa4d9jiKCRpLdVIE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjyZlvQ64Kzew0OTMtODDxmaP22MsrqU3iotnn15M
 k/zoj9iHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi5jmMDcdlPq02umG7P3B+
 XdW2oKXiP58UiDr9bKj68Ic7Q0kx5L5J8DZTNv31Im6711hWi0v3M1az/XEyW+gkyfym5u1119P
 yCnuftj+zf7Bz/YxjYv8ziufu+mJ9ry82KW694OYVlkIbk4UB
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
Cc: John Stultz <jstultz@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Yongqin Liu <yongqin.liu@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 8a11c2df5b88..85c814b6f05e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -188,6 +188,8 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	}
 
-	/* reset all the states of crtc/plane/encoder/connector */
-	drm_mode_config_reset(dev);
+	/* Create all the states of crtc/plane/encoder/connector */
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err_unbind_all;
 
 	/* init kms poll for handling hpd */

-- 
2.55.0

