Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776F606D82B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKLlcrpe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F91B11278F;
	Thu,  5 Nov 2026 15:33:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28ECA11279D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12A8941B42;
 Thu,  5 Nov 2026 15:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722201F000C1;
 Thu,  5 Nov 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892777;
 bh=nYmUc5HHKOvJ3khet2z/xu/L+H2nnfDpRrmSbLfBf4A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cKLlcrpe90tBodbZjTqCd3tYE7Hgomj/P3H5qIek9Rjl6mWkG9+WVk261674yAL9e
 TOal2LgqeL+MWR6Ud/axSnpQ0foiAPmrIfJ1mtbPqLEgL638lZLxyiMV5grrM3XwgH
 f2Jxcw+GEA27cAnS71eRMMHaEzXL22IjZeOIph9mBiGw9WsTt77Qlh8I4m/H8Y/JIf
 vC3SL+VNpS31Y5CdkAImpJvOILgivuPVCtpSdoff2xto46zOxaeRdf/n92pfkySIBm
 zU6jDa23WZtnIJ5YEsw3bzwKPmvHXdvUxntzTM2wV8LdjfPznewOQrml/45xa5zLT1
 YZnS+TRpCkE3A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:54 +0100
Subject: [PATCH RESEND 45/83] drm/sti: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-45-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2BPz/+S0a3SXdINLiumfWpXRtegQo08rLl0+EQr48fc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnzUvN45c2PkpsmGNdwM5zrZmmR36bDLx7afODF3X
 o9QGtPEjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRl/KM9bHyZttta5vav/Be
 dnjL8Jd5W/lfu0UKjI6sLuIBRQGTf84r2HFnhVT0mpg1Ez0yDl/awFifbqWw7XnZSZeGnN9TX66
 5MOW5ZctMA49lgrWpp9dm1jRaS58tPBr7+0NiwAPjebeOVacBAA==
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
Cc: Alain Volmat <alain.volmat@foss.st.com>
Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/gpu/drm/sti/sti_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index d02d71866f2a..0ca6c6b41f18 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -203,5 +203,7 @@ static int sti_bind(struct device *dev)
 		goto err_cleanup;
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret)
+		goto err_unregister;
 
 	drm_client_setup(ddev, NULL);
@@ -209,4 +211,6 @@ static int sti_bind(struct device *dev)
 	return 0;
 
+err_unregister:
+	drm_dev_unregister(ddev);
 err_cleanup:
 	sti_cleanup(ddev);

-- 
2.55.0

