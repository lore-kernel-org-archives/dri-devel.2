Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6A0C44537
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D597D10EB82;
	Tue, 21 Jul 2026 22:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rg0Atn70";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id C5A2E10E1EF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:53:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B67F15A1;
 Tue, 21 Jul 2026 06:52:59 -0700 (PDT)
Received: from e135116.manchester.arm.com (e135116.arm.com [10.33.50.66])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34A633F58B;
 Tue, 21 Jul 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784641983; bh=z+0sbQICk2r/MH87vzYWNV2SevbRD+kWsOGPx/9J1c8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rg0Atn70hgVOQtkjbgVzCXodm5x7Ce3cZc/wnemijvhszkDdHXX8P7FvrNL4I1ypo
 0EMNlyS9UTEg9Z3ghyCV5CWehmKK/SPYx9IClGWJs2g2+tMzuIl6MOxzVVFfjbLGMI
 2SLQHL2TfiiARx/9ntZnvqb0r/LpaN1eKWXK6Zp4=
From: Raveendra Talabattula <raveendra.talabattula@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Raveendra Talabattula <raveendra.talabattula@arm.com>, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, james.qian.wang@arm.com,
 vincenzo.frascino@arm.com, nayden.kanchev@arm.com, charvi.mehta@arm.com,
 Asad Malik <asad.malik@arm.com>
Subject: [PATCH 2/2] drm/komeda: Initialize encoder possible_clones
Date: Tue, 21 Jul 2026 14:52:27 +0100
Message-ID: <20260721135227.439413-3-raveendra.talabattula@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721135227.439413-1-raveendra.talabattula@arm.com>
References: <20260721135227.439413-1-raveendra.talabattula@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Komeda leaves encoder->possible_clones unset, so it stays at 0 for every
encoder. When userspace asks for writeback, the DRM atomic checks
reject the configuration because no encoder is marked as clone-compatible,
leading to errors such as:

	crtc96 failed valid clone check for mask 0x5

Komeda does not impose per-encoder clone restrictions, so initialize
possible_clones for all registered encoders to the full encoder mask
after encoder creation. This fixes writeback validation.

Signed-off-by: Asad Malik <asad.malik@arm.com>
Signed-off-by: Raveendra Talabattula <raveendra.talabattula@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index 6ed504099188..0dcc8c05e86b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -276,7 +276,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 {
 	struct komeda_kms_dev *kms;
 	struct drm_device *drm;
+	struct drm_encoder *encoder;
 	int err;
+	/* Bitmap of all encoders, assigned to each encoder's possible_clones. */
+	u32 clone_mask = 0;
 
 	kms = devm_drm_dev_alloc(mdev->dev, &komeda_kms_driver,
 				 struct komeda_kms_dev, base);
@@ -311,6 +314,23 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 
 	drm_mode_config_reset(drm);
 
+	/*
+	 * Build the full possible_clones mask once. drm_encoder_index()
+	 * returns the bit position assigned to each encoder and BIT() converts
+	 * that index into the corresponding mask value.
+	 *
+	 * Komeda does not have per-encoder clone restrictions, so every encoder
+	 * gets the same mask and is advertised as clone-compatible with all
+	 * other registered encoders.
+	 */
+	drm_for_each_encoder(encoder, drm) {
+		clone_mask |= BIT(drm_encoder_index(encoder));
+	}
+
+	drm_for_each_encoder(encoder, drm) {
+		encoder->possible_clones = clone_mask;
+	}
+
 	err = devm_request_irq(drm->dev, mdev->irq,
 			       komeda_kms_irq_handler, IRQF_SHARED,
 			       drm->driver->name, drm);
-- 
2.43.0

