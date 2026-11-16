Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7E606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kn7fvMXv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB1C510EF1F;
	Mon, 16 Nov 2026 10:33:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD6810EEBB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8ACB40308;
 Mon, 16 Nov 2026 10:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0576C1F000C4;
 Mon, 16 Nov 2026 10:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825211;
 bh=C27U9GfSzwfsNtR7NFsU+o56F+t5m0UtWcNbV1Zp9R8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kn7fvMXvz7sEmhQAb/RjunyZwg5HH+3Yd0qHWBGwnmleEcf0HQ4s4c4uCM2DtXzS7
 ynKIEfgManZLk5Zo0HJBwRoLFU/JfS5mwkiFsimuLG0S+aLKos95NJOhbj+y2yQthE
 r8xa0Ig0hq/J5j47GFJn5FPq5CZKQ0NvcoyMt7F1YlDMd9tKzRdTFCj8p8eN0wtun3
 7FRQm78cNOkkUuKof+8At2dQQ/Ap7peEuO/3cVjvH9f7hJrjHHBWyXcoFx2bEnBAl1
 vsi2FAkVwQ64o1+IHMy2XfBhuJYr5Be/9KjGo3GVKrJAV90g2ALDg2kTz8jAOJfoi3
 I/xCSXutohDAA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:04 +0100
Subject: [PATCH v2 48/64] drm/hx8357d: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-48-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=mripard@kernel.org;
 h=from:subject:message-id; bh=d9+Zkbqf5LRmP6zuSJCpdjzp9PzNH8IH8kGJ5+Gr7T0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bodefDDr/vXEUPmjsZr9h3wybrf9cp0Qsf+DVWTGj
 ZvWj1JdO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE0m8zNqx7whGc/9C/l+nU
 8ctB6p4nD2//rpqq2XXX/+WS7v0O4XP+eBz0XmLGulFg0eKmg2K3PzJWMpo0i+hfiH5g4f4ksYP
 zgmZM6DlprbdiT2yt/YKntQQ1nn1/VeDMjvtHmsoLa7SDGf8DAA==
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
 drivers/gpu/drm/tiny/hx8357d.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index f942a8d09ff2..fe2fc76e2b3f 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -358,11 +358,13 @@ static int hx8357d_probe(struct spi_device *spi)
 
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

