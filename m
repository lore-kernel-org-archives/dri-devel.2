Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BFBC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907B210E5D8;
	Mon,  3 Aug 2026 14:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dJhPz/bf";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6BFDC10E5F1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:21:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2CCE1595;
 Mon,  3 Aug 2026 07:21:40 -0700 (PDT)
Received: from e135116.arm.com (unknown [10.57.0.74])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17DAC3F632;
 Mon,  3 Aug 2026 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785766905; bh=4CJhajy18FhKKEtxtQelzRWT70J1u2W4WYVGHD/S0C8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dJhPz/bfVnGss2yjBsBV116eXhaLoOkzluq9Yw7sYl74DIp/gALyANPDPWgXByl/c
 ljMDq4jhOTnQsQ2xuFEbfW5ic4SUTcQ1LBTrfW4nt2TVYVbjuQuWWjDqCZ/sXDSFTF
 Jsl6pEUexuInWjXNzGaKC9z3CI4WfY3SdxHuwTTs=
From: Raveendra Talabattula <raveendra.talabattula@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Raveendra Talabattula <raveendra.talabattula@arm.com>, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, james.qian.wang@arm.com,
 asad.malik@arm.com, vincenzo.frascino@arm.com, nayden.kanchev@arm.com,
 charvi.mehta@arm.com
Subject: [PATCH v2 2/2] drm/komeda: Set display/writeback clone masks
Date: Mon,  3 Aug 2026 15:21:22 +0100
Message-ID: <20260803142122.4127851-3-raveendra.talabattula@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803142122.4127851-1-raveendra.talabattula@arm.com>
References: <20260803142122.4127851-1-raveendra.talabattula@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Since commit 41b4b11da0215 ("drm: Add valid clones check"),
all encoders attached to the same CRTC must advertise
each other through possible_clones.

Komeda creates one writeback connector per CRTC. Allow the writeback
encoder to be cloned only with encoders that can drive the same CRTC,
and update those encoders reciprocally.

Do this when the writeback connector is created rather than modifying
every encoder registered with the DRM device from komeda_kms_attach().
This leaves encoders associated with other CRTCs untouched.

Signed-off-by: Asad Malik <asad.malik@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Raveendra Talabattula <raveendra.talabattula@arm.com>
Signed-off-by: Raveendra Talabattula <raveendra.talabattula@arm.com>
---
 .../arm/display/komeda/komeda_wb_connector.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 41cc3e080dc9..4872253a2449 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -143,12 +143,17 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	struct komeda_wb_connector *kwb_conn;
 	struct drm_writeback_connector *wb_conn;
 	struct drm_display_info *info;
+	struct drm_encoder *encoder;
+	struct drm_encoder *wb_encoder;
 	u32 *formats, n_formats = 0;
+	u32 crtc_mask;
 	int err;
 
 	if (!kcrtc->master->wb_layer)
 		return 0;
 
+	crtc_mask = drm_crtc_mask(&kcrtc->base);
+
 	kwb_conn = kzalloc_obj(*kwb_conn);
 	if (!kwb_conn)
 		return -ENOMEM;
@@ -176,6 +181,34 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return err;
 	}
 
+	wb_encoder = &wb_conn->encoder;
+
+	/*
+	 * The writeback connector is associated with a single CRTC. Make its
+	 * encoder clone-compatible only with encoders that can drive that CRTC.
+	 *
+	 * possible_clones must contain the encoder's own bit whenever it is
+	 * non-zero. Add both the encoder itself and the writeback encoder when
+	 * updating the reciprocal clone relationship.
+	 */
+	wb_encoder->possible_clones = drm_encoder_mask(wb_encoder);
+
+	drm_for_each_encoder(encoder, &kms->base) {
+		u32 encoder_mask;
+
+		if (encoder == wb_encoder)
+			continue;
+
+		if (!(encoder->possible_crtcs & crtc_mask))
+			continue;
+
+		encoder_mask = drm_encoder_mask(encoder);
+
+		wb_encoder->possible_clones |= encoder_mask;
+		encoder->possible_clones |= encoder_mask |
+					    drm_encoder_mask(wb_encoder);
+	}
+
 	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
 
 	info = &kwb_conn->base.base.display_info;
-- 
2.43.0

