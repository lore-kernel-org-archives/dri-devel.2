Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED60606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRHakerR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D861127AB;
	Thu,  5 Nov 2026 15:33:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E208E1127AB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6704D60A68;
 Thu,  5 Nov 2026 15:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EEB1F00919;
 Thu,  5 Nov 2026 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892813;
 bh=yCwijjsyAWFdmPKIjGcA+2TMWQz5YghxOfNDB0VTr0w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TRHakerRuyWIiCYkdRD1nQ7/S52g+4cIQkJhUthPs3lFbcLY0zOvDVP+Lau+bSarW
 h4WaCOFQ+aUqE6vnt6jThFS3KUkUB2XK5gOn5bwjvFpM610ftt0fYMdcInIsNgb+cW
 IX36M6ycdaMai1QTnMIwQ2dFbDdI0ICp1KOLXxHXbrHmrlQURoBz0oCoUq1aqAA5j6
 SawtOfvwJW6CENN18lCdeyJLYxymBezz9WHHAMfa7oIE7xtg2JXCaNqQDFh9crt8qK
 FQXb7DYllLnM0CfHbRgYrZw2/tQUUTy/CzzPtfYYySzVqvhw65CYT9Q3H3QU4jJU/Z
 42UCAObL33Azw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:04 +0100
Subject: [PATCH RESEND 55/83] drm/tests: drm_atomic_test: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-55-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OyiP4McIXbbTt2z/cj1ezDohOB/hx0ehYNaDaCa2YvU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnwV63LeJGbvMHdP6uN/OZM+3uAVCXCU/VR0niNPp
 t78l5FUx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIXwJjQ+++DZFex6+s5/Jy
 3NZ8uObIJNEr3Q+bNIO87nZu55aKnHpjc8nrJ+7P9ufI+Yn1xCWnMzY8Yu1wutLDtlfY7na8uNK
 pX1ViismVB83Yrk7+mv3+4NOZk7LOxRY3Lygokdv6YHn5ia0A
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

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_atomic_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/tests/drm_atomic_test.c
index 541a0062f143..5e156d09e56f 100644
--- a/drivers/gpu/drm/tests/drm_atomic_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_test.c
@@ -87,5 +87,7 @@ static struct drm_atomic_test_priv *create_device(struct kunit *test)
 	drm_connector_attach_encoder(connector, enc);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return priv;

-- 
2.55.0

