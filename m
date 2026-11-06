Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513D606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=SV6fsh71
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9268E112FF2;
	Fri,  6 Nov 2026 20:19:37 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E03112FEF
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793996370;
 bh=2/Ga56h/DR/xKTT7FlBHJ6QUFChcm7dTb0PVTI7+a18=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SV6fsh71pClwNSw2U91vBc9B1JX+voODnTfaoDQSDV2d0QqKyaoXBmRuMbwnCNFz8
 9wCC+PfwyK1u4hCuPA4+ug16mjmPUa2sB4INgCr/ZJK44La5fhWifcPah7N61mV1UD
 jo8bNqq/KdSEKK4tHJNESNNT0GZEVJ8jHWfZ3kwEStEBOsbjxVw8SuzzUe5/vYgujR
 bE5f2ytPffKQeHxHC3XLgNr8oL950hbO7ltwQOo2xp0tjyNR0Keh7QcsGtWBmEir1z
 cfftUtdpEB0N0AZMUCnqrmquDhW/n2zUgFHtZh/yn9N+B4uGx1aHsh0GyNViucFK3u
 zoVwoKv4kOtYg==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D8FBC17E066C;
 Fri, 06 Nov 2026 21:19:25 +0100 (CET)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] drm/vkms: test sRGB and inverse sRGB LUTs using more
 samples
Date: Fri,  6 Nov 2026 17:18:11 -0300
Message-ID: <20261106201813.129911-11-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Reviewed-by: Robert Mader <robert.mader@collabora.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/tests/vkms_color_test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
index 238f4d21ebc8..86d9b14f847b 100644
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
2.56.0

