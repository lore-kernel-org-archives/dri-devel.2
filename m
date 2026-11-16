Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13D606A330
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKTm7uGA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E626210EEFB;
	Mon, 16 Nov 2026 10:32:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F72C10EEFF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7752043C6F;
 Mon, 16 Nov 2026 10:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9991F000C5;
 Mon, 16 Nov 2026 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825147;
 bh=TxegQ8MfZ/xke2FKW0DQaeQU1vqdAJQ08fQOgfdaOtM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cKTm7uGAFDoTWO+FjFT1/rm9kJP/CLjk9DSJtI7p5j0GsnFOskGDBcqFAJU3w921c
 DWf8QEOO7MbNM8YAHDfUt/5f9vzDlfUtYmy9BBsGpeWjC0VW7kQOvJ37+1YKy14q/e
 uLVlIQbWNeCGaMXwLeNPvDjIUxpeOFse6kI2PAfCVQvzotJjEnV7XkQzsyO4Q0OBvx
 SjQOZkdmKuzIjD8L1bNCrnUHyjMElimjomlgrv6ymdAJrzbFzuc0ENBG2mz1C6TzGU
 rpwbeMYk58zi3ut6xerkpVBuvymChl2hs1vJ6se+mRfYoqywx8lfHEIPZhEInExZtY
 y79QUzn2tghcw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:44 +0100
Subject: [PATCH v2 28/64] drm/st7571: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-28-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=mripard@kernel.org;
 h=from:subject:message-id; bh=z9a+Sl597ePhxJ3NE6QeXi7MrnMM3t6AUmHP+RUKPbk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bvvkzIzbY7q1Vrc38D9bFF+ribVLXLvVWl+jMwF/v
 4XGsyl3TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInc/cNYpxHic6D014Zfiau3
 Vd5m29Twg2OP5KuPTF07O1ZnblnSnf3O+fAa3dcb0k7Oe3wm4WvPBsaGjRu37LxT/qT01r+etEO
 vf4kUbBHd1xp8buJl3ori57/TLqxiZCm9svLVruiFJREu5+u9AQ==
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
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
index 608d38eab0fc..2d82fb78587d 100644
--- a/drivers/gpu/drm/sitronix/st7571.c
+++ b/drivers/gpu/drm/sitronix/st7571.c
@@ -865,11 +865,13 @@ struct st7571_device *st7571_probe(struct device *dev,
 	if (ret < 0) {
 		dev_err(st7571->dev, "Failed to initialize connector\n");
 		return ERR_PTR(ret);
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		dev_err(st7571->dev, "Failed to register DRM device\n");
 		return ERR_PTR(ret);

-- 
2.56.1

