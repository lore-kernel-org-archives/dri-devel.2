Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F8606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njs1boZn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BB810EF24;
	Mon, 16 Nov 2026 10:34:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5532310EF19
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CCD75618E0;
 Mon, 16 Nov 2026 10:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077611F000C6;
 Mon, 16 Nov 2026 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825215;
 bh=6kj07tHK8APVSc4ygFf/Qp8AccZ5SoIKm30eWFODz9s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=njs1boZnEEZ7NQG/qGqgLxGO/1/rg7zqEVyJWq5zy7CS2dAHWaPjNVkh0iIFTADxM
 QqgfEGT9EP5Q++94R0UTMHhHaZ2a944tvFzwSk7MoyIdTXPLCEr+LyzHshpfgLAsXv
 JpG8A6QU1cBw3WonBuZ2Rjg9zIohCmtRzTSyUWXtJi/iYe1+AF2x15WlEo4AuQeqR+
 TY1/hFmyaBM/p6ZRoZgwKkxiJJPVpA0lvXME2OwsYgbyuM+/c5US0bhpBcfsnKeoyj
 dtZx86eplZI7IHjiXPHduBjlzf71WWdX0YS3YDQa6U18jczPnfQdoA4Yt2Zgad1CYf
 zAfp2u4F8s3Aw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:05 +0100
Subject: [PATCH v2 49/64] drm/ili9163: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-49-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2jJPsd5F+NzREi17LUAutLzYaO8r9a5wHstazY8GYcQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/boe6ZllfELcqem76r+8ir/0vN7vav4fdtGrzH1/fm
 3XZyWRvx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIombGhgd8b+0iVQuOtExl
 5Pbr15yorbuQXVn3m9bHtV/LVs8OcT55onrywRBje7OJTPU2InV3GBve3vqUUtLUuGqClMw89ep
 2zefbj1VPnq7n0Go1y/lHbKx7/PP71w8Gb8v5LzSBVfj81EAA
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
 drivers/gpu/drm/tiny/ili9163.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/ili9163.c b/drivers/gpu/drm/tiny/ili9163.c
index 8842424504e3..5b94626c2177 100644
--- a/drivers/gpu/drm/tiny/ili9163.c
+++ b/drivers/gpu/drm/tiny/ili9163.c
@@ -289,11 +289,13 @@ static int ili9163_probe(struct spi_device *spi)
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		return ret;
 

-- 
2.56.1

