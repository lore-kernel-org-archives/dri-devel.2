Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A209606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/HES7Fk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA7B1128B2;
	Fri, 30 Oct 2026 15:15:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED16B10E58D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55EE46025A;
 Fri, 30 Oct 2026 15:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CC61F000C1;
 Fri, 30 Oct 2026 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373306;
 bh=VC6Ubx2Z4OeuToc4z7H41lWwx7+ZCeULXWrvV7SNq9g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=T/HES7Fk2Fxfh42of4YVOE3dOnWNds4bGUBkOQ8C8H8AV/+cYay+YHdv8SbRX6S+c
 mW/qsjszckQOxBJ47ngpd/4dn3KfRP47CMR4th66/s3lYn67u2WzzqHhUbYpg+1EY9
 aM33Hc3sAakLKryRf9dmzrXOEeOPScF3SusNTXqaC2feqip03HpFGL3j8YEzSrhvQ2
 TbkvMN6sOKVBVaJnEdNMGMNaQ0cK2CrRXJcmuQrPtrDQ0vwt7bo7s7Ck0kOwKmrTrg
 BGtl4Wp6PIh9m/8TwrA9DTIpw1TotiIAegLZYKT03MTsdQJ8KSs9v8ea4bRCWDurNB
 IvhWO9/OaAaZg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:50 +0100
Subject: [PATCH v3 20/37] drm/tests: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-20-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3731; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pZijsfE/ijrigKtK0Mj5UtabEIxo4Hd8uaJ4sqhlkHY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtqideR9enxO5Z8F9YfNdSz9bM9kWHjKKfKutfW6RV
 M2/sDV5HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiD1YzNkz+2+5Ut+vMX23V
 i9NPW3dY9/eLTV4x9/Z2XefYhDROQ76WiQoTTuq9C2dZ9MpENM/wCGPDRs00tVuP+dxKpmR+6Nr
 blnJDsSqlfOncKxuLfrcvUhI86iNmOD9U8emJU8fCuc89flUEAA==
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

