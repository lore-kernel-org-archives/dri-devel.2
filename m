Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA613606A886
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMiV1LJT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34FB10EED9;
	Mon, 16 Nov 2026 10:31:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81D610EECE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CED662887;
 Mon, 16 Nov 2026 10:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBB81F000C6;
 Mon, 16 Nov 2026 10:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825067;
 bh=U67F5j5Dqh5PdOSmzAG4nx/Og+yHDlf8WMmrmXskry4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hMiV1LJTLQ9ijcEzuHvoM2gBpSqO6rAMyjKBjBeAR7ehDKDNDLo32TVIDHgM45B+3
 01q4wPAgkUn0Eb/RT3SPXhnPMJEiR0VPRiaDaIsjYRYVe3vs7DKerrvf35xuJ7f/UA
 nX+BxgBloK/xX1ByE6wKK4RIXszWAwD6bWIEj9OTzZzn2s0H8X5ikkdvavOmHjNWeX
 cx3IEGP8JJbYq1yO0BcaHWyo9TaNlcHTeMcrqE7T/0gFfAbPR+CyMgyOdf63Ddis5L
 eKKoEkDrzYkJFA83CSDmJls8pOpYnGOB/kjgmiCcl+IGxSgvP8F0yNTwNdGC3OLnlw
 GqSIxguPE/8+g==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:19 +0100
Subject: [PATCH v2 03/64] drm/hdlcd: Fix drm_atomic_helper_shutdown() on
 the probe error path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-3-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2426; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/7x/R+DJL7DXJ5SzjPizvDYUrLM8l9yFT0MPJ+hFQzI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjtelnS6FaZfKLL+htSBgwI7eKpl6xtDrb7UX9aOE
 9ffwhTUMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYimMLYsGmtxEPbxVcSrJbf
 nCWw5mu01ezDSuszjl47Y1Ue8kLITkvsQutDPzXTZ38PLd4598vPq4wNsya1pz9NnMB4ZftefoV
 G3Wsf5k1yCPy52zCs/SdbVmqBjO3surSDDRKbjS18g5f/vbMMAA==
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

The hdlcd_probe() error paths for pm_runtime_set_active() and
drm_vblank_init() fall through to the err_pm_active label, which calls
drm_atomic_helper_shutdown().

However, both calls happen before drm_mode_config_reset(), so the CRTC
state is still NULL at that point. drm_atomic_helper_shutdown() will
then go through drm_atomic_helper_disable_all() and
drm_atomic_get_crtc_state() to drm_atomic_helper_crtc_duplicate_state(),
which trips its WARN_ON(!crtc->state) and returns an error.

Move drm_atomic_helper_shutdown() to the err_register label, the only
error path where drm_mode_config_reset() has run and thus where
shutting the device down makes sense. This also brings the error path
closer to hdlcd_remove(), which calls drm_atomic_helper_shutdown()
while runtime PM is still enabled.

The pm_runtime_set_active() error path now jumps directly to
err_unload: runtime PM hasn't been enabled at that point, so calling
pm_runtime_disable() there wasn't needed either.

It will also be needed when drm_mode_config_reset() gets replaced by
drm_mode_config_create_initial_state(), whose state allocation can
fail.

Fixes: d664b851eb2bc ("drm/arm/hdlcd: Reject atomic commits that disable only the plane")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-199498@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 340b1bb38bf9..f2bf9a61979d 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -297,11 +297,11 @@ static int hdlcd_probe(struct platform_device *pdev)
 		goto err_unload;
 	}
 
 	ret = pm_runtime_set_active(dev);
 	if (ret)
-		goto err_pm_active;
+		goto err_unload;
 
 	pm_runtime_enable(dev);
 
 	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
 	if (ret < 0) {
@@ -333,14 +333,13 @@ static int hdlcd_probe(struct platform_device *pdev)
 
 	return 0;
 
 err_register:
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 err_vblank:
 	pm_runtime_disable(drm->dev);
-err_pm_active:
-	drm_atomic_helper_shutdown(drm);
 err_unload:
 	hdlcd_irq_uninstall(hdlcd);
 	of_reserved_mem_device_release(drm->dev);
 err_free:
 	dev_set_drvdata(dev, NULL);

-- 
2.56.1

