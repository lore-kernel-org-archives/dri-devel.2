Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CB606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUiwds9r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CA210EEFF;
	Mon, 16 Nov 2026 10:32:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B23E10EEFB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63F534029F;
 Mon, 16 Nov 2026 10:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CE71F000C4;
 Mon, 16 Nov 2026 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825144;
 bh=UiqA/72vV0eLt2JOrYnJjxfsQ9GQDGq4XgGDwaYkoQg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RUiwds9r3WJsvcDLyrkPX3yhjf/zMKSbelOl0Mbfg5JoOyVv4Ts1KwZRQl3IL9heC
 6yzWGu2Tsx3Uhlu7ObCtxib/eNuMMrjOX+BSnCOS5ap+C0uew0NG4zzt3lWTlb0KvI
 6HhE+01yAvkashPQph+IaSpngqFfdNreV1PhLjFw41TeBbU3NwhqIoEP0UdCxuPY8T
 iLsKbBk2LyydBb6W56UkRKLuOJOZw7ivKnEUjk8Z0ag/ZjlyNSo7YzJwnUX7+A501F
 bE2apvoxNM+El0YuFchNO5IMNaIcGyjso47VmKWShrZTj7n3F7KMpB8GBxMCUqmcvk
 lIbg9fEzg6+YQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:43 +0100
Subject: [PATCH v2 27/64] drm/shmobile: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-27-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EOEk9BgG10IJIz4F5/ozQl3/KFWIemPCQzKNXSqnGJY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bns/e1/HsnxpUNhcuTlPF8uxb2i1ceW2DlQ+7uixv
 HNeinJ/x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI/TfGht6Q3gypldbr97od
 tSssuu6i+v6ZplD+8t7cmtVhwhOcOw+mhxfx/5ntdrQruHmVUEYtY51NZeRy4XtTHiVvM5xcrqq
 dlbTsq+eagIUZ/68IPdg720m4eK49z6O+P7+slFp+/b64aw4A
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
index fd9460da1789..4d3a714e255d 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
@@ -173,11 +173,13 @@ int shmob_drm_modeset_init(struct shmob_drm_device *sdev)
 
 	ret = shmob_drm_connector_create(sdev, &sdev->encoder);
 	if (ret < 0)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	drm_kms_helper_poll_init(dev);
 
 	sdev->ddev.mode_config.min_width = 0;
 	sdev->ddev.mode_config.min_height = 0;

-- 
2.56.1

