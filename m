Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2844606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlGzKn4W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16BE01125A8;
	Thu, 22 Oct 2026 12:34:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC216112597
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:34:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9600A4451A;
 Thu, 22 Oct 2026 12:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21FF1F000C2;
 Thu, 22 Oct 2026 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672463;
 bh=NnI+paeLAWkx+tLnZL1j3RznF/EIlk0dhomKgq3LX1Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NlGzKn4Wor/WzkQlSU91lkcm4F7AaRsdq8kcNr6N0tvqWvhEWs2h7otXd5tYgv0jr
 dEidccOW18vF4Hnte9sYE5bAuegUYabMFF1LO7a3TMrLzc3Sz0CfcAZd+/90nz/xMD
 4e6503GjSmYoE6shagVAoXWjaz4AF4kgC1Iyy2H5qgy7dTGZe4yRFXab/af/SQzjNs
 ineGGxkHgAU9YcmRLVD/4miFFDKnma7jw69OtR+Ps5JpHmT+B5yvCjfLnR3nnVxdnR
 sPbzCU8yGcISNc6wwrJIK1ZWf+dn61QOLBPZxzWCMCTg4uin7e2GM8wlrO7ZGgCpIk
 ZJIC5wQxzjTKA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:09 +0200
Subject: [PATCH v2 10/59] drm/bridge: chrontel-ch7033: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-10-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9MXgui6M7Z1PskgFKn6ulSO9OdP1Kgev9gjKc6y4q4w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mCYqPbm0xVmwbF1fmPb/eWaxvxkzQwr6VGb4Z084x
 +Q9q/VVx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIYhdjrYS5e/h1LZZ85qeh
 bC8rD8653hZuaheVd/W4/BT+CI0L0UH7hJTm3tmxU505fiujgmoXY8OZz0k/Hu9IL7r5asl8lZR
 dScsvP1oecUzpihHjzMNr8mU/KbJIaZ7cHBLEHDZL7pvGipUA
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

The bridge: chrontel-ch7033 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 4bc64b2885f7..3d48b42c38a0 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -219,8 +219,8 @@ static enum drm_connector_status ch7033_connector_detect(
 
 static const struct drm_connector_funcs ch7033_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = ch7033_connector_detect,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

