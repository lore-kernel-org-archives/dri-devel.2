Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9D606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUtaZIbn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 226691125B0;
	Thu, 22 Oct 2026 12:35:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62A41125B1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 338E960204;
 Thu, 22 Oct 2026 12:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F821F000C3;
 Thu, 22 Oct 2026 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672516;
 bh=pqRaDNkqe8f9DtVE2NaN+rUHO44z9/zJgN4TZ+ld/iM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eUtaZIbnkUXhnVC4Ws7ez0/YxKJiImmGRJtU9091SUhxEc5k+vLvl7Bk3zedUEPK+
 AUtZokcpgolPvJNPuKYqbSyQ2sZfyzt807Exmu9y8lx0fdqanXQeX4b5tkb/WgUfPY
 FRtCdhekuH2nIgog24D7DORIxg6tyG5BUG0PZYphwiTAMSUyslADYp922j+gX3bC+v
 9Dx59HWyNRAg+IVX2B1zlkRew9qjvX/+ZEbpW7LA/GsaZ/oqBK7Hbm1uKvR7VuztSi
 LXUcO3nnFr19JuL9YLP8hYEWs8T6vl3ndp0OctOyUfJVoPcFoWEwwf5PGn/QelrKuZ
 YHyWufcrW0Hnw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:24 +0200
Subject: [PATCH v2 25/59] drm/renesas: shmobile: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-25-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NR1FxXJ00EdI29wZavF73nbKd5XofyB0ipeWrDAqHjQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mGZ4qs0VX7no/xnlw+c7Pd693Vq+5aCXo9LmopVHF
 9uF3ilr7pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATUfFhbOgz5O4K7kvkfVbZ
 o569Ocn76Tl9tUtd6VNWRj1x+av0Z3Nb/PfObdNb9fg+sqVUN0wtZqzPWOrzYXePqplteNWPnAI
 /7xu7sxPmX2jX+/powVr1t7KcCiJnL4nyKbZJcmafKbHOfAsA
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

The renesas: shmobile connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 51bae2008cc6..d1a3e17f5bb1 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -528,7 +528,7 @@ static void shmob_drm_connector_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = shmob_drm_connector_destroy,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

