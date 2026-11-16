Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA48606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqNGgXZJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACEA10EF11;
	Mon, 16 Nov 2026 10:33:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D15810EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 15FEF46202;
 Mon, 16 Nov 2026 10:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9C51F000CC;
 Mon, 16 Nov 2026 10:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825176;
 bh=XGlVbRtaTnXWzANGObeu2EjzWI6NpTfSibHuyiKPESw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KqNGgXZJhi0K1mYvjwRBggOOvEKs7GyoMP4Nnobquz/9GSw0JsiKHZviduywU9dIX
 NXYVftH3ePqB6kautcPwico7eI5CApTFXrxsAxT9zIR0777V+dgrO0HNxHrgPmmSVY
 +zjQE+v7dBQahx34Q0iLkgwF1kH50Te+igPC0cf+9j30D+s+4KhTKF9e2ChOjjpjfF
 Y53vyXPGRcmeA6K2s6hJ8sxeQAlekhIVR/F0B4ouJUXCbwGN7C+CGdVSrnkAo9xUv7
 0qWyX/koKbkLClO1EZvWjrXKg76gFVVkunEPrIN1nemdIBx/9ziBfeMGMxars5k43x
 WhJdGxBm+R13A==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:53 +0100
Subject: [PATCH v2 37/64] drm/tegra: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-37-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9KfsryBfQaevH9S5YYvx2NCrkjUqvlYAFlaU0VCpQaw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bgcUsKzl0eZTc3m26rn391QxIWOtJ0xz89+dEeti3
 JxuL/G0YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkgRdjvedqkynr99WVVavO
 0Lou/qrEZPnnoFWZ8z/08Pk93dpq5N4+NV1irrF7+Tnme5pdJdcXMNZ78FYotIZGih725X52YOY
 6p73/pldksd5t45Zv8tlana4WU6ec9bTXMom5sM5b593pAgA=
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
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>
Cc: linux-tegra@vger.kernel.org
---
 drivers/gpu/drm/tegra/drm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 324480c87fb1..9fdb9e70eb0a 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1243,11 +1243,13 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 	err = drm_vblank_init(drm, drm->mode_config.num_crtc);
 	if (err < 0)
 		goto hub;
 
-	drm_mode_config_reset(drm);
+	err = drm_mode_config_create_initial_state(drm);
+	if (err)
+		goto hub;
 
 	/*
 	 * Only take over from a potential firmware framebuffer if any CRTCs
 	 * have been registered. This must not be a fatal error because there
 	 * are other accelerators that are exposed via this driver.

-- 
2.56.1

