Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD8606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHdINUqX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C3811278B;
	Thu,  5 Nov 2026 15:32:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65F311278D;
 Thu,  5 Nov 2026 15:32:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A81860A07;
 Thu,  5 Nov 2026 15:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B441F0093A;
 Thu,  5 Nov 2026 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892737;
 bh=/+2ONKaoV6IzTGGYYJW55T5A5jiTSV5R4wIry1IrHGM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WHdINUqXA+ytlBTNW2HcUWvF37mYNxOCxmppJlshV2Vy/K0MHPeW7os4SizfZAFZ5
 VFnJg9znLqG4fr85IKe58111czMMvjXB7KNtaf+pidFrYT6GDGH3hjTtedFHy9zVRe
 UAKvO1ineh++Nz9QgVBmifiER4ivZvNHiBmGhN0frkwGotynYmAl3HbwHLQ9WaV7gj
 i0gpCgneryA6L0EGBc0kVdc7+4oWFR+EOZw4zQC6mX5QimpcFpghT4X8KNiTaLp8NO
 j31UlsAoqH1x1vKcdHGRPwjURl/4QBlKhIvCoC+8QAjceR4GF0do0ZlIDn+ShXfTFO
 7wEcz/o8U5Wjw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:43 +0100
Subject: [PATCH RESEND 34/83] drm/qxl: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-34-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ldl6ijul3QdFV66wGmaDh7N43eVOWOlaVmdgUZ+Lwn0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrxhX2ecOfXSpkMmjh+rG/e6/a1Umau09ddizYAu1
 VK5I9IGHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAit08yNvwPOXxL68PjzTf9
 du/P2Hr/8NpMjaPzXz86yxa4avGqJc7GvlMPzNld7zDdcwv/r46/D+wYG/bmRKXmVXAEf/MPY5W
 3f/BtagLLVr3TE97e1+zw5vn+xqLxFFd8DPv8WaK/np7jeC5zEwA=
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
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 204c47d61373..7f719e200d31 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1313,6 +1313,5 @@ int qxl_modeset_init(struct qxl_device *qdev)
 		return ret;
 
-	drm_mode_config_reset(&qdev->ddev);
-	return 0;
+	return drm_mode_config_create_initial_state(&qdev->ddev);
 }
 

-- 
2.55.0

