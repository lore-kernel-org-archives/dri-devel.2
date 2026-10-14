Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D35DCC6B2E
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E6C10F8C1;
	Wed, 14 Oct 2026 17:27:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9759B10EAA4;
 Wed, 14 Oct 2026 17:27:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59B5C43668;
 Wed, 14 Oct 2026 17:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41481F000C4;
 Wed, 14 Oct 2026 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998843;
 bh=Z77raOHnqV6l/14mfdZOW87avEK2DF1tEdDVPN0Dlwo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YqYz4CEhcPp3xTroEv7M33xax6DhqJNbLKKwM4b3iO1D/FJlxrX1lYkAZ5r/lcPrZ
 beetUw7//09qoi0wqSPrEY22o9nbmcPXHf5J0wtQu4lVN3zE0E9i2G/Xo+XRBNtDE+
 Xy5ImEdDcodNwvNoKGst+uT1hjr9hVqXiKrq727/jzMb3NlRscUWYbpDtiomgE4XQY
 RIDLYR/7jMrgnWiP9s5psrCzSX4K3Tu/kKII2IHR7FJ5UkkSVEy85NNvF3TJMX6Wfi
 85gTGg/kJWnzzKz+50un/TPngPyuSMY1HHshTbR+NPBiFgbuPILDz41KnHeZ1U+lGz
 2/jETPi0QetmQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:26 +0200
Subject: [PATCH 03/75] drm/amdgpu: vkms: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-3-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=mripard@kernel.org;
 h=from:subject:message-id; bh=V6Vk1ZfTBH9pj/ZDdF0lbZasKlnVH3+TGRdqtx6YrtE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd3sbLNOWzwsqvsH3Zd/PjYaSQg9XZdm/ORdY8qssR
 ffs5sCqjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARm7eMDfOYOrX2fSw5/v/M
 rQknxFjze1ieJB3ju3ybhdVhjV52v9fGrw8blhVLNTp3bmHqn99yhbFOyTBew7rQQrdPz9U+uNX
 utcB9bzUeB57qOL+/ngf6FmnuVYnv/KbA/b/W+uSFtol7UgE=
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

The amdgpu: vkms connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 5c5fdbec93c2..5c7e2172a372 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -84,11 +84,11 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 }
 
 static const struct drm_connector_funcs amdgpu_vkms_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int amdgpu_vkms_conn_get_modes(struct drm_connector *connector)

-- 
2.55.0

