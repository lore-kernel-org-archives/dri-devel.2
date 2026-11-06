Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E682606A333
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VJmA5S2i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5C2112FE5;
	Fri,  6 Nov 2026 20:19:06 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5507A10E460
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793996338;
 bh=+qaehktjH1TRurnQUB45IY+MTI8NWLyDc82TPymYJHk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VJmA5S2iXqN1L9dGh1NcbxIuZf8bf8H8Pq0G97rksuS3xpBS3UZeS25uk4lW0K877
 01HfQg/s+HoXNkwV+YRS+sD/MRRHLO0lpFIURwwc/rNojwRCMZ+wE+qzv/Z6S9Pmd8
 GhgfzuvKF0AXgMsFLDjJB8So7bQWcn69Z32AkBnP61iMgX4YyWwtek/Mux26cdF2bh
 8CUMWAkEbFJMW0akJBSpdb6VUPvr9yW0POddCaAEVMjI3rkphLK56l5o8ZUTuB1q8v
 tsn114NUaGw/XefsCgfFKxLeUJIvC00CXb/BW0g8t8zQg+QwmbThSeMKG7XeYlnWuq
 vJzCPoe3qQGzw==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 229D417E00AF;
 Fri, 06 Nov 2026 21:18:53 +0100 (CET)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] drm/vkms: remove TEST_LUT_SIZE
Date: Fri,  6 Nov 2026 17:18:05 -0300
Message-ID: <20261106201813.129911-5-leandro.ribeiro@collabora.com>
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

This can be replaced by ARRAY_SIZE(), so drop it.

Reviewed-by: Robert Mader <robert.mader@collabora.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
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
2.56.0

