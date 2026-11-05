Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03E606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwAdfuRw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417F31127CA;
	Thu,  5 Nov 2026 15:34:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 760411127DA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F81E4077A;
 Thu,  5 Nov 2026 15:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C170D1F000C1;
 Thu,  5 Nov 2026 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892885;
 bh=SDrjXMdJeb26KkyO9w+a5K5He8Db/y/BKZCfmuXgQdM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HwAdfuRww33L9Q2DrzrkpGtfXZPplzniP39AClU7x20YUvI6/66gNnoOuiGZAuigO
 MilZ9AoSDRWYdWW4wC2uElNfOeQVnCNBIce8QDXdbV+3/cgnmt0QhIwIcmqErIUqWb
 KwgY3DLl+KniQii3WtkLH2iFzevUKhsMOhO9rs4m5QwSsoV1Fv1ZnHKTTDmnJFz7QA
 xjvLWGp4GUvUzfiVz2IHAd4Uvlk8y/o/cgjiLxsefxu7QfMTvf3/65W0+ezeyKbe9Q
 ZnQ+iUbv8x53XowGw4PvJmlXWZ9tCUafaxgsdU/crf4TmqVUyt7PhGDdRI7zsSCITx
 VLIf02lvXPH8g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:24 +0100
Subject: [PATCH RESEND 75/83] drm/udl: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-75-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/ZgHbbZm4v79lhM/An39QBd1YmtqCfqor/FTAycak0Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvzTXdG7S3Yls91v8Q2Pv15n/jA7983viLcRyrOE5
 9+xCfzh2zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmYnuEsU4r1WqPwm5LaX9L
 qagb8//MufzKof/L0l+ffqdvephg+VpFKanvW8vrq4xHX9VvPv43yIyx4dQL+7LeibxTrteYxJ5
 N2iIssyyvQi78dIRGBdMLL3Ue1sNnNVhzfoaufO/PvTU0T1AMAA==
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
Cc: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/udl/udl_modeset.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index d8a617e2d2ea..02138457a97b 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -541,5 +541,7 @@ int udl_modeset_init(struct udl_device *udl)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 	drmm_kms_helper_poll_init(dev);
 

-- 
2.55.0

