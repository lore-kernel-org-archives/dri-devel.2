Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F905606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbkNi7X/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E651128AA;
	Fri, 30 Oct 2026 15:15:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8D810E5C2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23B09601EE;
 Fri, 30 Oct 2026 15:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8A31F000C1;
 Fri, 30 Oct 2026 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373262;
 bh=MaZpJx+Qe/72/3oMNa6zHNkc2W0kYMQAgnH7D8dXdck=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TbkNi7X/RbA7YO/CpBWydYf7xxx/Pk7vQKpugrWO2uRO7plb48LQii+Zcn0gLRkeF
 7473Nr3EKl57AGA4G/9IfYLv/ehRhm3yHVej1IehS7hmSBPMBPryYGDgv7QHcMKmD1
 TpDGQRXLltopW19OjM+1pCMfM+ttU4AFvVvBCTW7fbR5cZ4I+psD6GXvovIA/G2qe1
 3ooS7tgZBSEwfvvJhGnFAWCgo6vHy9aQEu/tLEi+PKe2tw4fUPDDGa8QE+0SB1t6o/
 J90P7dzJa0MyR6tLKP4+nn7kG5JYBGNGzmoXcizZo/ygESVqdM9770fXp0EFN1YBaS
 neCtQJb80j7PQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:38 +0100
Subject: [PATCH v3 08/37] drm/bridge: tc358767: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-8-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aU9tnOdAllgNbAZMQbuOGMrrYY65gktz9LK7WwgSGzk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtijI8bOqfNnPvLDGuS6ZScruQQhLnPbr0rMc5YGrj
 jLtXpTWMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbyPISxPrTH8My7+0bc1yKE
 r6l/23PmkHTrRJZS8YQZ7T8n5U5+c89LK3UZu6RSZOPziC0cMcfqGRsmPGIJjZUM5Tz+f9uCMj7
 X6CmLCpxOvFo2d9qE0GX7rvF3F3xhWfDHsVj4Me/5PVz/yyQA
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

The bridge: tc358767 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 51f4baa62a53..5ea6d3726bee 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1797,5 +1797,5 @@ static const struct drm_connector_funcs tc_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

