Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922F606A339
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIbHfDoQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DB8112794;
	Thu,  5 Nov 2026 15:33:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E7111279F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF6D6600AA;
 Thu,  5 Nov 2026 15:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25311F00A02;
 Thu,  5 Nov 2026 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892809;
 bh=525MIyMDNB8fafolQ2ATdl1g51E+PeAOopyIe+wdKcM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nIbHfDoQKBcqUyXgplsKZtvAe38AxbQDCtllYjuy2hL5AG3loxPB4FVgM0VqLixTO
 rBdiNr26fHdtN/zEppixDm2hYHjY/55vPBdO+EiC8OGXkgPa5ocyfOmpcJ1OxiJBET
 enQ/uQKO0aeSM98KhIzhLCAoQDMMrAVimPdqskdN748udaKmqAs59EiAOX1rUhsSQZ
 Owz7/4fasQukhHAtyCEzl0eXiw2HCuilwFVsMTKwRRn4ylaCofb7Y3m3SZkezKFRq6
 vSPt/6s1nrxFLHmrdHafnLNsGOvkQYr0nLQxpzOomr8sTxPFKizud9t60VU3PScYgU
 hMN4JHmBFeaUA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:03 +0100
Subject: [PATCH RESEND 54/83] drm/tests: drm_atomic_state_test: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-54-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6v2wB1ge3iwo17/8oNPh+VljZJYKZjGbin3d1dgcXYU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnx9nb/ubMKc6mNzfhcrb/sg7HstedOeruXzdcX9N
 AyutBya2TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmUjiHsWGfpPuzJewCVdo3
 mLL+JlXXs03bO1P+3HSHLr5QtSaOF8fMmQyE7h5b6Xj59aReQ8U6D8aG3xxLTGRn3po4MX9+XV3
 ul7K5d+SnxP69dNw6esa9Ir9FwW+z/i84+aPul/m/aZ+mu8UuAwA=
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
 drivers/gpu/drm/tests/drm_atomic_commit_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index 6ccb001f6264..97f60ce68b3e 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -135,5 +135,7 @@ drm_atomic_test_init_drm_components(struct kunit *test, bool has_connectors)
 
 done:
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return priv;

-- 
2.55.0

