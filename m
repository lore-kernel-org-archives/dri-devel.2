Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0627DC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDDC10EBC0;
	Tue,  4 Aug 2026 20:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hKBj0ztn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2636110EBC0
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785875766;
 bh=Y+VxpJ/tVKNDAdbF7mD8tcR0cc6wGQyOBfUCadGI1Qw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hKBj0ztnf3IrJJVFipmj2QIrMNWESuskauBwvI4H+dcjljw+kxv8NvBXiSZbS+3vC
 UXRpW/wPnEuDQ/Qqmfp07gusBzpWxRvPq6LZ3lEvrckekpfnlz6z1PFxADpH3n+0DE
 QoXWOh107Cerby/cY6cP5QZl0ihH0PzdCvDCoBV9fja6AxNGi+pVPtKUk+vH1Efc5f
 td82gZNKaDOGgeIRxEwdiak+YzZqlPMpPLZHo10hABz9TNcazjQLEiGwnfSKb16b5f
 q11Snf2WAyOR/FVqNNDe5E1WfKGJk5yfllwhJO/qTOPqAJLrsmXDPOdiuZiPg1GImB
 2AYVQ2iotm1Og==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 39D5317E0243;
 Tue, 04 Aug 2026 22:36:02 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] drm/vkms: test sRGB and inverse sRGB LUTs using more
 samples
Date: Tue,  4 Aug 2026 17:33:49 -0300
Message-ID: <20260804203351.148521-10-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
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

We're currently using srgb_eotf.lut_length samples in
vkms_color_srgb_inv_srgb(). This does not exercise any points that are
not in the forward sRGB LUT, although it exercises points that are not
in its inverse.

Let's test with more samples, to also exercise points that are not in
the forward sRGB LUT.

We chose 4096 samples. LUT inputs are u16, so we could have up to 65536
samples. LUT sizes are usually not higher than 512, so with 4096 we have
at least 8 samples between each LUT point.

We can see a minor error bump with this change. In the next commits we
replace such LUTs with non-uniform optimal ones to reduce the error.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/tests/vkms_color_test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
index 571b1b579310..78f67bba33b5 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
@@ -123,14 +123,16 @@ static void vkms_color_test_linear(struct kunit *test)
 static void vkms_color_srgb_inv_srgb(struct kunit *test)
 {
 	u16 srgb, final;
-	u16 tolerance = 119;
+	u16 tolerance = 122;
+	u32 x;
 
-	for (int i = 0; i < srgb_eotf.lut_length; i++) {
-		srgb = apply_lut_to_channel_value(&srgb_eotf, srgb_eotf.x[i], LUT_RED);
+	for (u32 i = 0; i <= 4095; i++) {
+		x = i * U16_MAX / 4095;
+		srgb = apply_lut_to_channel_value(&srgb_eotf, x, LUT_RED);
 		final = apply_lut_to_channel_value(&srgb_inv_eotf, srgb, LUT_RED);
 
-		KUNIT_EXPECT_GE(test, final, (int)srgb_eotf.x[i] - tolerance);
-		KUNIT_EXPECT_LE(test, final, (int)srgb_eotf.x[i] + tolerance);
+		KUNIT_EXPECT_GE(test, final, (int)x - tolerance);
+		KUNIT_EXPECT_LE(test, final, (int)x + tolerance);
 	}
 }
 
-- 
2.55.0

