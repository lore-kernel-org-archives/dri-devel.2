Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3D4606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXU6RRzf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1CE10F542;
	Thu,  5 Nov 2026 14:21:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B2D10F6F9
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:21:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46800605FF;
 Thu,  5 Nov 2026 14:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725361F000C1;
 Thu,  5 Nov 2026 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793888500;
 bh=31yWxOs9e1iJZk6xVV67wQMmt9/ZTBkRSn1PGXFcvjQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TXU6RRzfW2JZrAXBgDTrDVlUYCI4zLoeBxtgNxeh/60rLhvluic/5RN642dKeDNCE
 +53HyG25JkHmYonoiYFw4r7Y0gm0p4nRrg7+FqIATmKdhwS7HMF7m3Rl7LLPUzpWDI
 YfawjxTFDbSoZKN0tax8p8Je5/G3wzmvSbID/dOfjTg9/paYg2aBbaxTDxehMNFOc6
 /9zEqxXhVyEi9Hs5wpV9PhDxaFYMUS5rewwIxGxuR3ZElq7j2yv5Rf8Bt5SQLyQR+q
 CiWvOsK3MZucNz1X4gRMYWcj673sqtk/e86l9ptYRxNb5hwiDZ15nU+7dc1pt3deBR
 FxTq+BZD5gqUw==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH 3/7] MAINTAINERS: Move Tegra DRM under drm-misc
Date: Thu,  5 Nov 2026 15:21:23 +0100
Message-ID: <20261105142127.708219-3-mripard@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105142127.708219-1-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Tegra DRM driver is excluded from drm-misc in MAINTAINERS, with a
dedicated tree at gitlab.freedesktop.org/drm/tegra.git.

However, the last pull request from that tree was sent in April 2023,
and about 150 patches have been merged through drm-misc since, most of
them applied by the maintainers directly. The driver is de facto
maintained through drm-misc already.

Remove the dedicated tree entry and the drm-misc exclusion for tegra to
reflect the actual maintenance path.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f25c296665e5..5bdb8e1bb32c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8900,5 +8900,4 @@ X:	drivers/gpu/drm/msm/
 X:	drivers/gpu/drm/nova/
 X:	drivers/gpu/drm/radeon/
-X:	drivers/gpu/drm/tegra/
 X:	drivers/gpu/drm/tyr/
 X:	drivers/gpu/drm/xe/
@@ -9083,5 +9082,4 @@ L:	dri-devel@lists.freedesktop.org
 L:	linux-tegra@vger.kernel.org
 S:	Supported
-T:	git https://gitlab.freedesktop.org/drm/tegra.git
 F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
 F:	Documentation/devicetree/bindings/gpu/host1x/
-- 
2.55.0

