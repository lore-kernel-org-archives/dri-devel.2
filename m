Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166DD606A885
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jEDfccdw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6225C10E0FF;
	Mon, 16 Nov 2026 10:31:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE7910ED7C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38A7A461F7;
 Mon, 16 Nov 2026 10:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D70A1F000C4;
 Mon, 16 Nov 2026 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825086;
 bh=f2fy59n0gjGHDyiXt8QI5UIvnqgoPFFaIAgKHI6NNec=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jEDfccdwwo1b5Ld6UhBQHca5Vgb/RYdKSCMScuFk9Zv7m3nzs3e7RcV7CIoPRIB/0
 VuUJdQqdcgfmPCGuIvkHOV0PK4FIjYSBOSbuyRcMcQThP8OIhxaNSwoSwf6rgkmR5U
 t38zsSPd+qcxhKH4tspVSHMhU9//SuBZSOCvcKAEcyAEfeaDgpw99V4XtBYq6YqlZr
 55WeHFjJWSfqmSfouLhr43WxQac4qVb4Cd+r0Ahb9ynfRJRa9k4aI5sFk2NTf6qOkL
 e0eHmcm/LzGni8PV/QxzWakuAwXDYb6iBsANVJahaj/lVldbcGYozoNmuyJHZ/dFjq
 AdsQvYRpeJu9Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:25 +0100
Subject: [PATCH v2 09/64] drm/hisilicon/hibmc: Remove hibmc_unload() from
 the load error path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-9-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FYJue8xO9P5CCjNgF9HZD+9G8SAJaD1ti586WpW4nHw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/brv88XLbX6Ntt0XOcttK7m1ql/o5ci88vZ8zcTv/s
 sdXI0qvdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJJDMyVrO2OIcZ3maqz59+
 P1bV4Mdhti2bw4NTymN5uwsOXNaTmjVRxP3s9QOJ16wmTLWq6gm9x9gwadUjtqkTCrcnBuasvae
 lsfRO53zvnetcVWyuyojNMbpr5LJXxGkdz+b8F335Z/8aP9MHAA==
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

The error path of hibmc_load() calls hibmc_unload(), which only calls
drm_atomic_helper_shutdown().

However, all the failures handled there (hibmc_kms_init(),
drm_vblank_init() and hibmc_msi_init()) happen before
drm_mode_config_reset() has run, so the CRTC state is still NULL at
that point. drm_atomic_helper_shutdown() will then go through
drm_atomic_helper_disable_all() and drm_atomic_get_crtc_state() to
drm_atomic_helper_crtc_duplicate_state(), which trips its
WARN_ON(!crtc->state) and returns an error.

Since the device hasn't been registered and no atomic commit ever ran
when hibmc_load() fails, there's nothing to shut down in the first
place. Remove that call.

hibmc_unload() is still called by hibmc_pci_probe() and
hibmc_pci_remove(), where the initial state has been created.

It will also be needed when drm_mode_config_reset() gets replaced by
drm_mode_config_create_initial_state(), whose state allocation can
fail.

Fixes: b11bc1ae46587 ("drm/hisilicon/hibmc: Add MSI irq getting and requesting for HPD")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-199610@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 602930964e93..272a8ab6427a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -417,11 +417,10 @@ static int hibmc_load(struct drm_device *dev)
 	drmm_kms_helper_poll_init(dev);
 
 	return 0;
 
 err:
-	hibmc_unload(dev);
 	drm_err(dev, "failed to initialize drm driver: %d\n", ret);
 	return ret;
 }
 
 static int hibmc_pci_probe(struct pci_dev *pdev,

-- 
2.56.1

