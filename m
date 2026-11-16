Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6259606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtDARKpr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1565510EF0A;
	Mon, 16 Nov 2026 10:32:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D53710EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9486A628CF;
 Mon, 16 Nov 2026 10:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1D21F000C5;
 Mon, 16 Nov 2026 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825163;
 bh=hDcpcax1LG6C8SRA7xjUDOb7Og76sZTtF/6e5frQzj4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FtDARKprcc+c6Vr6K58KvTWxAgiUOV71gEkCs5qtfrVZXbzb77FTCaxVnZYPWT5xU
 Xn2Xu88Ypv9N/ob3wUrlEZ2b9F5fJmmUp/0hed/blGRn9BidCHPPk9rj/LJ8aOboB8
 mxc+2zVMFeElUSMFSyaXfvfT0tUeOJnQoCgCkNPVk0JdQYclI1zmpvLY34ArSGNgOn
 1TwK+vmxsZZE+p7K3CfkjcX3VIBWLuoeX3gKvZg2ZX4jjBA9Du8l+2gG/K3HDh4Aqk
 Tl3RHTwxRn3BhGM/3CpSChqJbgmM9onteeEZ9CMLbaI5cNHJ9NQYlpCoM73wJ2rTeV
 6v07nx/qoGM+A==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:49 +0100
Subject: [PATCH v2 33/64] drm/sti: Fix drm_atomic_helper_shutdown() on the
 bind error paths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-33-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1I0FCAiUMqPYMqa1pCld/OQKVZ2as8wC7fYq5qTG+xA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bvs9LHwXx7nSQEv3a6i77q65J+cnm9RaaW7SLS5kf
 mwU6nW1YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzE6zRjw0k2lcoV+XE+pb03
 M64/9e4SL3Xa0JiZJcNvsFLzf9Wvqetsc3vz3lYdN5X4xyV+Qs+MsWFn74nr5dL7Dx34VjRfz3f
 5EZ7I77u+yflI/G27kmY+RXxPw7ri4nc8ZUF/M8I9/Pv+uwAA
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

sti_cleanup() is shared between sti_unbind() and the sti_bind()
error paths, and calls drm_atomic_helper_shutdown().

However, on the error paths the initial state may not have been
created yet: when component_bind_all() or drm_dev_register() fails,
drm_mode_config_reset() hasn't run and the CRTC state is still NULL.
drm_atomic_helper_shutdown() will then go through
drm_atomic_helper_disable_all() and drm_atomic_get_crtc_state() to
drm_atomic_helper_crtc_duplicate_state(), which trips its
WARN_ON(!crtc->state) and returns an error.

Move drm_atomic_helper_shutdown() out of sti_cleanup() and into
sti_unbind(), so that it's only ever called on a fully initialized
device. It still runs after drm_dev_unregister() and before
drm_mode_config_cleanup(), as it did before.

It will also be needed when drm_mode_config_reset() gets replaced by
drm_mode_config_create_initial_state(), whose state allocation can
fail.

Fixes: a2b50babc7439 ("drm/sti: Use drm_atomic_helper_shutdown")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-200075@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sti/sti_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 0ca6c6b41f18..794badf199c9 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -171,11 +171,10 @@ static int sti_init(struct drm_device *ddev)
 static void sti_cleanup(struct drm_device *ddev)
 {
 	struct sti_private *private = ddev->dev_private;
 
 	drm_kms_helper_poll_fini(ddev);
-	drm_atomic_helper_shutdown(ddev);
 	drm_mode_config_cleanup(ddev);
 	component_unbind_all(ddev->dev, ddev);
 	dev_set_drvdata(ddev->dev, NULL);
 	kfree(private);
 	ddev->dev_private = NULL;
@@ -222,10 +221,11 @@ static int sti_bind(struct device *dev)
 static void sti_unbind(struct device *dev)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 
 	drm_dev_unregister(ddev);
+	drm_atomic_helper_shutdown(ddev);
 	sti_cleanup(ddev);
 	drm_dev_put(ddev);
 }
 
 static const struct component_master_ops sti_ops = {

-- 
2.56.1

