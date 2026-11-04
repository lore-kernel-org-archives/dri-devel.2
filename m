Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464ED606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE13610F973;
	Wed,  4 Nov 2026 02:53:31 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DB610F973
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:53:30 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowADH8_0onupqt+Q+AA--.9984S2;
 Wed, 04 Nov 2026 10:53:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/jpeg: unwind the ring when sysfs init fails
Date: Wed,  4 Nov 2026 02:53:37 +0000
Message-Id: <20261104025337.1527305-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADH8_0onupqt+Q+AA--.9984S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xJFyUAw1fuw1kur1rZwb_yoW8XF1rpF
 WfCrs0kry8ursrt3WDAa4UWan093W5XayrGrWrA34Sq3W3ArZYyrykZF4YyF1kJFZrCFs3
 Ar97G3y3ZF4qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
 v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
 McIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
 kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
 wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnU
 UI43ZEXa7IU5gZ2DUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMBA2rqY-nieQAAsZ
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

jpeg_v5_3_0_sw_init() returns directly when
amdgpu_jpeg_sysfs_reset_mask_init() fails, after the JPEG ring has been
initialized successfully. amdgpu_ring_init() allocated the ring buffer,
writeback slots and the vmid fence, and only amdgpu_ring_fini(), called
through amdgpu_jpeg_sw_fini(), releases them. Because the IP block's
status.sw is only set after sw_init() succeeds, the upper layers skip
sw_fini() for this block and the resources are leaked.

Unwind with amdgpu_jpeg_sw_fini(), as the other JPEG implementations do.

Fixes: 4aeaf3cbfa9f ("drm/amdgpu/jpeg: Add jpeg 5.3.0 support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 8ddd12740a04..f2b049700989 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -109,8 +109,14 @@ static int jpeg_v5_3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
-		return r;
+		goto err_jpeg;
+
 	return 0;
+
+err_jpeg:
+	amdgpu_jpeg_suspend(adev);
+	amdgpu_jpeg_sw_fini(adev);
+	return r;
 }
 
 /**
-- 
2.34.1

