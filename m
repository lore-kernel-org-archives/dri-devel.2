Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2915BCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B3210FEF6;
	Wed, 14 Oct 2026 17:30:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1BC10FEF6
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 523B14195F;
 Wed, 14 Oct 2026 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB38D1F000C5;
 Wed, 14 Oct 2026 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999025;
 bh=8mMIUfz4k5k+M2RPe/46ua0O1hHzkH0OvznwvySKVAY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ovYXzWYewjTE9fHv5jyAPG37djax3xDrWWvCZehHM8zDACeiUFjlBzctJQ1biW0Ap
 FzmzztzvOjIP/AwKEIJkh3/+U1t7jq+6o9wFWmV/9gMd8HMqOAgctEfww42+6WvRaY
 HmmoOLJuatpSJgmqgtc8Nh4WR2BvIuK+DeyEPESx2VSXAf3xqWhpNIl5Oo7F9Ipcfx
 qXxbV74NWdRr3U0/2V/xkB48UC6JTydWUYc+RucivUxPX09wJnnJN5Gxo7uzJORCOW
 7T3kguMreU7ClytvaHDZYI3ksyAM4MUMt/K1YkU5iRkR5r4uPXS88pONL+vtxkI87P
 lafN62SPfOnzw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:16 +0200
Subject: [PATCH 53/75] drm/vkms: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-53-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IR1znQ3rbHW4l/fdaKGXV4s7O3ahK3TORIWUdPGsQO4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndyc2Him7p3ju1uI7OzZzvfv5JYnrsX5nqnbEwoQ37
 EtvWE9T6pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+ajMWF9hcfXR3OOXs1/u
 l8qeG8/g/f7cr3UfDyzsPVR2XlDftWi1S++eIx4MBbP3ycfyHDox6xJjw5InvZFbO7wCBJYlNn1
 Rrpyz9qnk1wQx9/m7xX9z5M5RbVNXW1rRMf/Gk8l1yuz/d3I4AAA=
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

The vkms connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index b0a6b212d3f4..57138027966f 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -35,11 +35,11 @@ static enum drm_connector_status vkms_connector_detect(struct drm_connector *con
 }
 
 static const struct drm_connector_funcs vkms_connector_funcs = {
 	.detect = vkms_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int vkms_conn_get_modes(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index ecf29a2c0c8e..858df1f89f66 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -24,11 +24,11 @@ static const u32 vkms_wb_formats[] = {
 	DRM_FORMAT_RGB565
 };
 
 static const struct drm_connector_funcs vkms_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int vkms_wb_atomic_check(struct drm_connector *connector,

-- 
2.55.0

