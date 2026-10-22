Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80A606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIVrQXBB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07991125B8;
	Thu, 22 Oct 2026 12:35:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1172B1125AF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 891E060200;
 Thu, 22 Oct 2026 12:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B425A1F000C1;
 Thu, 22 Oct 2026 12:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672538;
 bh=VC6Ubx2Z4OeuToc4z7H41lWwx7+ZCeULXWrvV7SNq9g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kIVrQXBBEagPxN04fzjq3JWdeTnl4GD00/fgJdh4ofhuBhE7EL8zp/vd0EZKMK2br
 baL51IhIolmH274/MLZzMTR9NCXoW1nQ6nY0Ajsj5tKKDG9N2nIrEZJp6tJCwEkhgw
 GIvxtuk5pqWwP9f+heU/42cATm7bSwUdmHRJVUXqL8Gi7rDtLk33BzKLomiGYVQKzQ
 RM8+0yj1eVk8q/mwVJvE8NecylbUFmgEe+erYZzQ4NVv6xE4cvv1qoYWr1EBl1Wmge
 +lG0I/V9GDE+hbXazTtS91wZSRrAthaTyk0BrBxJVaLrFsZEAyuGC15DccO19HjoT5
 v17oS7CVQ/Pbw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:30 +0200
Subject: [PATCH v2 31/59] drm/tests: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-31-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3731; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pZijsfE/ijrigKtK0Mj5UtabEIxo4Hd8uaJ4sqhlkHY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mGZ3J+yfKNatd8Di0reXKf43Pi3vshNc+Ttmx1ZOn
 qXFohXJHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiE+QZG14sfe98LetPgFGb
 Q1yYp0TTqplT9gkkz7ixRYdrW/xby6fTHFkPveNr4Pye2PeooKlmFWPDr1CFprb4+cfschweiU4
 2tO+/yhwrMPdD+uY4ox6pymyX4iovm2PzHJ3+TN//LtlvvxkA
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

The tests connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_atomic_commit_test.c | 2 +-
 drivers/gpu/drm/tests/drm_atomic_test.c        | 2 +-
 drivers/gpu/drm/tests/drm_connector_test.c     | 4 ++--
 drivers/gpu/drm/tests/drm_probe_helper_test.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index ff69bade19b8..6ccb001f6264 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -52,7 +52,7 @@ static const struct drm_encoder_helper_funcs drm_atomic_test_encoder_funcs = {
 
 static const struct drm_connector_funcs dummy_connector_funcs = {
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
 };
 
diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/tests/drm_atomic_test.c
index ea91bec6569e..541a0062f143 100644
--- a/drivers/gpu/drm/tests/drm_atomic_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_test.c
@@ -24,7 +24,7 @@ static const struct drm_connector_helper_funcs drm_atomic_init_connector_helper_
 
 static const struct drm_connector_funcs drm_atomic_init_connector_funcs = {
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
 };
 
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 3368aedd4e66..2856294bafda 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -49,7 +49,7 @@ static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs = {
 
 static const struct drm_connector_funcs dummy_funcs = {
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
 };
 
@@ -203,7 +203,7 @@ static struct kunit_suite drmm_connector_init_test_suite = {
 
 static const struct drm_connector_funcs dummy_dynamic_init_funcs = {
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
 	.destroy		= drm_connector_cleanup,
 };
diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/drm/tests/drm_probe_helper_test.c
index db0e4f5df275..ebc0392585e7 100644
--- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
@@ -26,7 +26,7 @@ static const struct drm_connector_helper_funcs drm_probe_helper_connector_helper
 
 static const struct drm_connector_funcs drm_probe_helper_connector_funcs = {
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
 };
 

-- 
2.55.0

