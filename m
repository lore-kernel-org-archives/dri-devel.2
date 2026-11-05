Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C255606A32E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1X3NtNO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05ED61127A5;
	Thu,  5 Nov 2026 15:32:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3111111279D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA06560A56;
 Thu,  5 Nov 2026 15:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03941F000C1;
 Thu,  5 Nov 2026 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892751;
 bh=MTZqhm0aGJreZPGGbuUZEYlXZJP51jJf8Z0bzy30p1U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j1X3NtNOIx2pyXLn3oT7Y7E8bJdJXXM6Hio2RKWNyJSVi4aY4cy2FiFhunGyr6Btf
 LmQYAUp4nsznA8k0SCBSPjdyg2VIvmbVQPgHxt+JvrBd9cZFuR1TEr7FoAfQ2gKbYV
 RbhJSk6nmOP13lleBrpJf1d60XNNXUHGhkwMXnKzac5hCeJK6TI5yETpNdXgPlrmxd
 RbEk8YtF9PljaDHpJ855MTVUknZ7x0/p2BGEGvgr5aFVk+FsFqqBi/qGvnTj+gSydJ
 urWJfTJlPkVNJUD+S4BZuXu0FCu0AFSDEq4xUCqvEecQdFWHZjIqy332RUkUz+jTCT
 6QbNirWwEQWfg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:47 +0100
Subject: [PATCH RESEND 38/83] drm/rockchip: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-drm-no-more-config-reset-v1-38-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org, 
 Andy Yan <andyshrk@163.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=mripard@kernel.org;
 h=from:subject:message-id; bh=u+F3Q/slyAJ4WB/81jUsRNlDARO7Uo/iUhGPQMLGiXk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrxLnii00Wvyl/U7e6479SkX+XdyynLe4s3W0e2rl
 5xqLhrbMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbSeo2x4TVHwf1/WxZvf3fi
 pO/aB0JPZ0gWHfDzv6xgq1k663uiSabvQs3KA8UXa3L2/vtlln6skbE+fu4zwS3/f7KYfqq5vyj
 708mn77NuMb/NMbmzY/OfXddfb/Dy5As6+MFAqOzaz+DYGeo9AA==
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
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 3099408e9d05..1fc6134f6900 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -191,5 +191,7 @@ static int rockchip_drm_bind(struct device *dev)
 		goto err_iommu_cleanup;
 
-	drm_mode_config_reset(drm_dev);
+	ret = drm_mode_config_create_initial_state(drm_dev);
+	if (ret)
+		goto err_iommu_cleanup;
 
 	/* init kms poll for handling hpd */

-- 
2.55.0

