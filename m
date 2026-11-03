Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87831606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.a=rsa-sha256 header.s=default header.b=KT1j+fa1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6EA10E87F;
	Wed,  4 Nov 2026 08:58:28 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Tue, 03 Nov 2026 09:06:35 UTC
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4B810E7CD
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 09:06:35 +0000 (UTC)
Received: from [10.25.10.139] (adaptive-ssl-xc-proxy3-entmail-virt125.gy.ntes
 [39.170.111.5]) by smtp.qiye.163.com (Hmail) with ESMTP id 5350805c8;
 Tue, 3 Nov 2026 17:01:26 +0800 (GMT+08:00)
Message-ID: <064da7ba-58ca-4027-88a9-12fb41e8b7d4@hdu.edu.cn>
Date: Tue, 3 Nov 2026 17:01:41 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ack.rusin@broadcom.com
From: =?UTF-8?B?5r2Y54Wc5p2t?= <242270054@hdu.edu.cn>
Subject: [PATCH v2] drm/vmwgfx: unpin BOs without revalidating placement
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1a0a4549e03a2kunm95a19b8011cb1a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSU9DVhlDSB0fSBoeTB9JS1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlIQlVKTEtVSkpKVU5ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
 b=KT1j+fa1v4x30RLRI9lyHgJnG6ysskUGLpJLz7rJk0ItRg8pijnJZxdijNFTFibbDPodQahxvlt+vaFktlYTsJKUQaurS2bsN1wzITC+dXKMC31QE9vq7hOm56dZGqumLhiFIMDNY/JO0wtnyj0cVbmorSl7YKyH4zvRrk4lxJI=;
 s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1; 
 bh=AAvT4oaR+HyN+G7lEV1yPMDfRG3OafQ1aTdZbcSjPog=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I apologize for the repeated mistakes in my previous messages and patch
submissions. Thank you for your patience. This version includes the corrected
Fixes tag and an unwrapped patch diff.

Unpinning a buffer object does not change its placement. Avoid calling
ttm_bo_validate() on the unpin path, where a placement validation failure
currently triggers BUG_ON() and crashes the kernel during PRIME cleanup.

Keep validation on the pin path, where it is needed to establish the
requested placement before pinning.

During PRIME/GEM cleanup, vmw_gem_object_unpin() calls
vmw_bo_pin_reserved(vbo, false). The latter currently calls
ttm_bo_validate() for both pin and unpin operations. In the observed Linux
7.3 QEMU run, ttm_bo_validate() returned -EINVAL on the unpin path; the
following BUG_ON() caused a kernel BUG during process teardown.

The path is:

  exit_group()
    -> GEM/PRIME object cleanup
    -> vmw_gem_object_unpin()
    -> vmw_bo_pin_reserved(vbo, false)
    -> ttm_bo_validate() returns -EINVAL
    -> BUG_ON(ret != 0 || bo->resource->mem_type != old_mem_type)

Observed report excerpt:

  [BO_PIN_TRACE] before-validate pin=0 old_mem_type=0 target_mem_type=0 flags=0x10
  [BO_PIN_TRACE] after-validate ret=-22 old_mem_type=0 new_mem_type=0 ...
  kernel BUG at drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:342!
  RIP: vmw_bo_pin_reserved+0x36d/0x380

The change skips placement validation when unpinning and retains it on the
pin path.

Fixes: fbe86ca56791 ("drm/vmwgfx: switch over to the new pin interface v2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhang Pan <242270054@hdu.edu.cn>
---

Sorry, the previous submission was damaged by Thunderbird's line wrapping.
This v2 keeps the diff header on one physical line. I verified patch
applicability to the clean Linux 7.3 index after normalizing email CRLF line
endings; runtime verification of this exact patch is still pending.

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c..14d28e2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -308,6 +308,11 @@ void vmw_bo_pin_reserved(struct vmw_bo *vbo, bool pin)
 	if (pin == !!bo->pin_count)
 		return;
 
+	if (!pin) {
+		ttm_bo_unpin(bo);
+		return;
+	}
+
 	pl.fpfn = 0;
 	pl.lpfn = 0;
 	pl.mem_type = bo->resource->mem_type;
@@ -321,10 +326,7 @@ void vmw_bo_pin_reserved(struct vmw_bo *vbo, bool pin)
 
 	BUG_ON(ret != 0 || bo->resource->mem_type != old_mem_type);
 
-	if (pin)
-		ttm_bo_pin(bo);
-	else
-		ttm_bo_unpin(bo);
+	ttm_bo_pin(bo);
 }
 
 /**
-- 
2.43.0

Regards,
Yuhang Pan
242270054@hdu.edu.cn

