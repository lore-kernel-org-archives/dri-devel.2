Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7BE606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN1nuO8u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45320112761;
	Thu,  5 Nov 2026 15:30:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D0C1125FA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A1B97439A8;
 Thu,  5 Nov 2026 15:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120081F00919;
 Thu,  5 Nov 2026 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892628;
 bh=vU3sYdXgaRja0if6xD36SsivS3eMUWznXPzuyNCbWow=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YN1nuO8uH2mT6XKJZnwYoaGLq/ScbTtetuqMlY03HS8WhJSUi7o5MVdVf8yQD8zwi
 XmGt52TQ2sr8ySstDzbZP9u+zzYXuLdJxuBpnJwPq22aWMqsz1dxCgudDm6XgdmPif
 5QepSdZp1ScyfTmDRqhKq+24rQ78hwB7qCmKTw7+YHk/53VYi0Yj32xKLuUs/kymak
 F2KpV+RHva0A/bSQIDofLUFBpeU06IeL+B+vpLoUV6tIFnvc4Ck8HUUJ6i5leZePcs
 ZKDAlt/AHvDB386c59SHdtOkVetr/z7bl1rIT+0Z0bCabHcng7i7HLm5hNoeyYepAb
 7TW/nr6ormZvg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:13 +0100
Subject: [PATCH RESEND 04/83] drm/komeda: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-4-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3nchJw0q1N9/BnW/w5ysD7bTFgFqvhG5c01i4QN6LMo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFtyfp7XBffOfdaeLOpzSdya42st/bOs6dW+SVlTO+
 T0Caq1XO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEnhow1oq/ig9TnC/hNkdh
 3celk9M/PrrUcezvFtkXl1Lnbtu789372a+1e6c4dgZqbO5u8lo8J4KxinlmfcirOtW8ibMMcy4
 s0V+0U3ux1y6pJYeLXWSeKmp8ErftrZpctyWHaebr5U+rpoXJAQA=
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
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index faa8b041373a..66854c6cc03f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -310,5 +310,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 		goto cleanup_mode_config;
 
-	drm_mode_config_reset(drm);
+	err = drm_mode_config_create_initial_state(drm);
+	if (err)
+		goto cleanup_mode_config;
 
 	err = devm_request_irq(drm->dev, mdev->irq,

-- 
2.55.0

