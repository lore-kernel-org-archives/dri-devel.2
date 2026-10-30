Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D422606A323
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyhPB8i/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970A811288E;
	Fri, 30 Oct 2026 15:14:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B65910E268;
 Fri, 30 Oct 2026 15:13:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63F50444F1;
 Fri, 30 Oct 2026 15:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9081F000C1;
 Fri, 30 Oct 2026 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373237;
 bh=9ogwlBrpLxDPajZrvnwywUMbAgdpoJgJp0rNjgX9xsc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MyhPB8i/kphv775vwOpBZKfjdShp9GgwqV+YTtsQv3s3+Th1WuEdG55Pn4/OXwvV7
 N1fKw24j5a5fnf2IBO6Px16DfeJv9T26qw3Xi8KmAb2mjcKzP1uPW1TCuD5NXZlBaO
 G8h134cWjqNE7/K67+XvmBIhBpqBjhCHLcGdDIFxe2J9m9dQqAFpo0flmlPEROozPw
 riE+3GOsQlf59jxWQQJsJduBrs/KqkwCvr9y2wLL0YOgnrWlYyco8QuaTBMofccfXf
 1OkM5HSxVKA0hLa+u2bIfX88wc2EH5rT6Ee6CBVt8hO+MVeZyzq/u45hiQhq+OG1zK
 ErqnxLAomM/Cw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:31 +0100
Subject: [PATCH v3 01/37] drm/amdgpu: vkms: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-1-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=mripard@kernel.org;
 h=from:subject:message-id; bh=C3A2KXrhKWnaGWQAOhBNY0R+SHtfrEw+fVf5cVYEOYM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtsiaHmzMD+mvjlD9Wvf0gXhr50IJc6PLDSu5XrYt/
 bMzq2x9x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIqi1jrVyAPVepUg6HWqln
 iIeIlsmNRu0Hwjd/rn2/mPvMk8kBpquUxKalFzh43LXfsYP5gdkRxoYLWdsiFgdk8M36w5Su8Pj
 fb+fNctpz1xqlnFlS9LZBQDO9nqNYIGp3wE8jxy8FWz4V9QIA
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
@@ -87,5 +87,5 @@ static const struct drm_connector_funcs amdgpu_vkms_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

