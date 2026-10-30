Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F87606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdsNVrRH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F8211289E;
	Fri, 30 Oct 2026 15:14:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFA710E2B8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6300F601EE;
 Fri, 30 Oct 2026 15:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D0F1F00A02;
 Fri, 30 Oct 2026 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373270;
 bh=V9JdUToXpwcJKdq6BiiMTbXmUQ3RR1TQStfOk7P4s88=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cdsNVrRHt0gOY7u+FUR1aZYYRDlOBh2ROS15WekBnt/MygTw0Ra+WU7enL1EQSED5
 aYnNruEroMcwqNSrk0LpLtXVfBy+ve+yeOMFGEsLuQz3EAzUcd34FvTVd7Ksy5W8qN
 AigqM7vt+YZm+9Z+W2H5ZVyGhbSrTiwJ26x9eKQncYiGg9ITcQACTvkyztYGOXcbAt
 o5nYCDxIqnaS7d4jVktj8eYO14FBBxOtUuI1zybsxIWTdvzpk6kX8qLNtVbaQsHEbn
 hYKyQ/sOOH0a5X0s1/FdUkffOXQQzj7vJRp0rpT9lP3YpKgqk42uJEinWbdITNLMHN
 ZFUf0PdfAZrQw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:40 +0100
Subject: [PATCH v3 10/37] drm/bridge: ti-tfp410: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-10-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gKAl+iCAfHdOmiMnFl3H4aWeEYJ1PamXE9t9RAZ2f3c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtigG/Mismn9m9d4fzjN2mSl5JzEeEOg59v5Wgnm8d
 /g5+9gZHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiryUZa+UTn5XXa7xnYWFt
 OvEudVbivGun8pc1BSdx31ztsq6v+cn+A95SOhcf5OosXbT5iabVH8Y63ZWywjNvTT+UJH/8Q8p
 e65vBO9+d+rZcRLLf6PYUxtrDqR/jtAPNvv+84P5/zUWH/Xm2AA==
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
@@ -96,5 +96,5 @@ static const struct drm_connector_funcs tfp410_con_funcs = {
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

