Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22751606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ1eW2Qw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C5211289D;
	Fri, 30 Oct 2026 15:14:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCD210E5C2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 490726062F;
 Fri, 30 Oct 2026 15:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE5A1F00A2E;
 Fri, 30 Oct 2026 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373241;
 bh=i35Qm+qMMyurhBoKLlGURfbkNeXYO7YQcls/ZdewMAA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aQ1eW2QwoyoVSnaVE8DmfQzEZL66jIKBp54hDMn8w45mWJDp4EZrs9X7cfownTzf/
 iArcf2RpsdXK1e1cnstwTS7UX8bDil68y09HzYqdM0zrzAqZzsVs91rX7grF5HkUOZ
 UDGZFw9nCGbsmcSS+uh/CpkLetQKbmY08Q3xbShUIfqQ3tiFdvXSCjvd3pTfZi7o9s
 bFKMJzabGvvxunitff/zcQT9L9Jx6PU1XYbv9TFMDWxNKvVonq2RWvQjNvCG9f5Wwk
 x6G9275A9gENMB1GZ/AzRHG7EunUZiqMWohnXiq6L3CtgtVzyHcP4Ez48MiFq0xrB3
 04lwCaIOB6XzQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:32 +0100
Subject: [PATCH v3 02/37] drm/bridge: analogix-anx6345: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-2-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iUJnLivR/qesp1K52yMGXmVxSDwm0/09r/ESAXOB1GU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtsipOZxsEhV+VaUj5vkgaL2igPGGH0F6Gc+6j1Wfy
 7oxqSSyYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzErZ2x3vFJUX/A6zXpfEfn
 pPDZHXC64yjxdXrY86aqTzqm8XWWKQ+3B4TJ9kzft53/xjOVRNt/jDV8beK5Ly5NYhM0Pu/rXn3
 B4e38TtdP821YzoUdtY0S8TzJ6e9r8eHMZjMB3wVHctJ7TgMA
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

The bridge: analogix-anx6345 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 407834a03b63..0cff9ff0265a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -484,5 +484,5 @@ static const struct drm_connector_funcs anx6345_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = anx6345_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

