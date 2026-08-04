Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F78CC55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0961E10EBB3;
	Tue,  4 Aug 2026 20:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Mm3BLinL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BD210EBB3
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785875735;
 bh=2jRN8rwrRgeGr4RF+ksvmSwJJLOcbqfv+sijzUxkuY4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mm3BLinLbXzaxbcg1K/bxVTa6ZALym7fGNHNdmMzImQmhyyWq0j51mzUtgubgGrkS
 CTcgjqxHPhRreCpA+5PPR5OeAXmfszlTAiRe19SW7ssAiKGIlU7J3JEuUJeeAj0+VX
 1gDxzNdf8erIN7NjqOUCYvO9NLrcfGn1GkEcVIJnSQWj64cqYzCML2vN61fgQ+2mOG
 YOdsgdcCxmnOzSDQbuO78LlC5PU8oc4uVbTJ3ThgRgHE3FAQSEDyWyPhzs/Z0RZXpj
 a8PLJRNHWJYGOKGDTrKWV4L0V2azDvF6V+5OX2W5FxnBj6Z45hWaK5afV4l2wxt0Zy
 P1qqpoT8vR7kA==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CEF7817E0243;
 Tue, 04 Aug 2026 22:35:30 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] drm/vkms: remove TEST_LUT_SIZE
Date: Tue,  4 Aug 2026 17:33:43 -0300
Message-ID: <20260804203351.148521-4-leandro.ribeiro@collabora.com>
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

This can be replaced by ARRAY_SIZE(), so drop it.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/tests/vkms_color_test.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
index 18e73a8a5c31..3489513af352 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
@@ -8,11 +8,9 @@
 #include "../vkms_drv.h"
 #include "../vkms_luts.h"
 
-#define TEST_LUT_SIZE 16
-
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
-static struct drm_color_lut test_linear_array[TEST_LUT_SIZE] = {
+static struct drm_color_lut test_linear_array[] = {
 	{ 0x0, 0x0, 0x0, 0 },
 	{ 0x1111, 0x1111, 0x1111, 0 },
 	{ 0x2222, 0x2222, 0x2222, 0 },
@@ -84,7 +82,7 @@ static const struct vkms_color_test_lerp_params color_test_lerp_cases[] = {
 
 static const struct vkms_color_lut test_linear_lut = {
 	.base = test_linear_array,
-	.lut_length = TEST_LUT_SIZE,
+	.lut_length = ARRAY_SIZE(test_linear_array),
 	.channel_value2index_ratio = 0xf000fll
 };
 
@@ -96,7 +94,7 @@ static void vkms_color_test_get_lut_index(struct kunit *test)
 	lut_index = get_lut_index(&test_linear_lut, test_linear_array[0].red);
 	KUNIT_EXPECT_EQ(test, drm_fixp2int(lut_index), 0);
 
-	for (i = 0; i < TEST_LUT_SIZE; i++) {
+	for (i = 0; i < test_linear_lut.lut_length; i++) {
 		lut_index = get_lut_index(&test_linear_lut, test_linear_array[i].red);
 		KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(lut_index), i);
 	}
-- 
2.55.0

