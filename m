Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAF606A320
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUiUc12R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6325112588;
	Thu, 22 Oct 2026 12:34:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741F11125A3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:34:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D2D340856;
 Thu, 22 Oct 2026 12:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B857F1F000C1;
 Thu, 22 Oct 2026 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672474;
 bh=vvMGgw/UWhNKnumvNPruPbXwq4kySYagxa1PP16pCSo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JUiUc12R4Fib+NF4GuMqFXJYDxD6NbbR8c3gSmJkk0co+M9+akcrzb4lcouy+EW9N
 Jof17vNXezCyBcFyf60NQVO+eJmtDYS6PUJwaqq3A59iaaJQlxAxFcm0NXtp4hQz8D
 f9UGFSlAmL38olcdbd2Frq4v/QN6dlO8azuNxgmsPfYT57t3yNhbm7souTDP/Ad8Y+
 AQ0ioHknzEFPG12fxLC1H78JHa9i6BeXMZi+LPzvRryQiwjn/i42MWDqF3h4JJRWzS
 vBIwd+/qaWLbqaxAOfQaSGUtSLfHCF2JjKQMHB9xaMW678YH4ik//Za5N6CXwjUlAL
 RUWNG4MLzd4rg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:12 +0200
Subject: [PATCH v2 13/59] drm/bridge: synopsys: dw-hdmi: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-13-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zB5zZb7uDUftvtyXTWfW3BgB2emc2ZjNXn3zpV0OD20=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mCave55bsyviVU3HieuVtSLbPDtWv/y8otXL+u2ai
 W/sXoYc7pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATabRjrM/7/2pnNW/oVJ9D
 hZeV3jxjVpTLE8urf/zHInjuIhNTrc3PD/BNPV9W5swbEyfX8O60C2PDe5YrvUILj3ys31Cz9+J
 mwU1yG/beVRM7fVT6IyfH0b0R0Zybv36ZxRDtsLizN1KNc/ltAA==
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

The bridge: synopsys: dw-hdmi connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 937d61c42b58..917cf764c9c5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2570,5 +2570,5 @@ static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
 	.destroy = drm_connector_cleanup,
 	.force = dw_hdmi_connector_force,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

