Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37970606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A14/lvRr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3777810EE6A;
	Mon, 16 Nov 2026 10:34:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F5D10EF13
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CE5061228;
 Mon, 16 Nov 2026 10:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7859F1F000C8;
 Mon, 16 Nov 2026 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825199;
 bh=O9tnOqdSJKJorwhQt67Bk9dqMdBv+eKJrfFZOZuAqgQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=A14/lvRrsjkeHfUBGgUDEf9keO10WN0j+VCaO5mxwpipBGCsrMDr6x+b0u8eSTCFa
 3Uyu5E4Jb983rJOB5j8PGEiiYqC2uw00o89jOUn5xqw0KHl/4us9ItxDKw3/iZ9932
 KO8a6AlekoQCQoaXp0ScyCqId4dM4FW1azzMHyHWWhyrZi3y9ts8TcSCMk4FsOSRJB
 72pMZEAWtf991zkVVYGnjhReYhmXWd9e7kuzWlJDf9xml4JaGmYDKX2+wvnuUPAgfM
 nldrF3jUG/0y77NxVdXH8b3h6Og4k+zxHwhtsEaxJ3bPuafu+VWBpBimlvkKtkQgOJ
 wfinEYrXFWOew==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:00 +0100
Subject: [PATCH v2 44/64] drm/arcpgu: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-44-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alexey Brodkin <abrodkin@synopsys.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Y4yZTlq/SA2BAkSr9bLOys8GpPYv4aNi/tuHWcHcs14=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bgcHbv1/alHM96m+PaxzVQW16mQYo7ijNk2VjA5K6
 wqtsOLrmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABPRespY7xhS5L8kvls+5r64
 ctTZSKvXrLvev3XJvLDzTIuR+ue7bKKvlnI5nD/1Q2WrrFPc5SPzGOuM7qpZyV0+pjDNbQLL2+C
 Xr2KuJb4U50h5efvUlW3yitdW3jky8/TMnK02rN4228sqTkYBAA==
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
Cc: Alexey Brodkin <abrodkin@synopsys.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 32f6e98ba9c5..08747a98ff3b 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -414,11 +414,13 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 		ret = drm_connector_attach_encoder(connector, encoder);
 		if (ret)
 			return ret;
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 	drm_kms_helper_poll_init(drm);
 
 	platform_set_drvdata(pdev, drm);
 	return 0;
 }

-- 
2.56.1

