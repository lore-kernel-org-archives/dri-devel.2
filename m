Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49460606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoiBfjfu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2511125C0;
	Thu, 22 Oct 2026 12:36:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D32A1125AF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 258A142270;
 Thu, 22 Oct 2026 12:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CD01F000C1;
 Thu, 22 Oct 2026 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672567;
 bh=fNm5+flbrBqQcNWSSyhis7PdZMeGfhw0BY62tVE625k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NoiBfjfuC+JRikz1046BnCw5YgkEmctk8CyoTPZwv19qA5F9/CgNIVD+QxUdJojcr
 eDDnQJNWrxx/dyXR3xxHnL2iMlE0IzDIpDdRCMhFtSkwKeFunTdeW3/w0qhkdGTl5Y
 A5BHFOwyZJ/x1qaphyb9e4LXV2SPS+dMPYqA9+4I5LdONrXjEW0k0UBhIEK9AcesLp
 AmfScFHTpmm6ljucuV1bj69h3jbhq6VJ+H6wEbXKg3GgWpcpPzxOkYr5X5yyMISBfN
 MQNLSuhKzl7ZljUD/797x7mpK0ZrLEbheFY5Bu4+ir2AadaMAe/7GwRlnxcQTituhl
 NDMQBGwk70e2w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:38 +0200
Subject: [PATCH v2 39/59] drm/udl: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-39-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PqN6JmcCjOawNx2gsX6rADvchHrp1VpCf/6mKqVvV4I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOZd1LO26NoQ/tun1aUz6u+xZ+EP4mZY8fiFlPOcu
 s5zTqerYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkRRRjw5O7YnJuvq+2LPrQ
 0v7O1P5cytHtEg9S/5z8YOn1aWUNv5R3uahp6gI5iZ3zv/bsP3vyP2PD3o0eExOOOm0Kyzvf+D5
 Qtn338czvp6LTZovucA+vbTNutBZguPa4073G4cojI52DIm8A
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

The udl connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/udl/udl_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index dee085406ac2..d8a617e2d2ea 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -452,7 +452,7 @@ static const struct drm_connector_helper_funcs udl_connector_helper_funcs = {
 
 static const struct drm_connector_funcs udl_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

