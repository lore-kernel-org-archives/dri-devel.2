Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F459606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=SmyYMa2e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA3C710FD23;
	Thu, 19 Nov 2026 07:48:59 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 14:20:37 UTC
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD4D10E7EA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:20:36 +0000 (UTC)
Received: from lgs.. (unknown [101.76.249.61])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5526d7883;
 Wed, 18 Nov 2026 22:15:27 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/kmb: Fix potential invalid free of plane objects
Date: Wed, 18 Nov 2026 22:15:26 +0800
Message-ID: <20261118-324f82bd41-drm-kmb-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ef03375c03a1kunmf02206921a0da2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkkeVhoeHUhDSEJNSx5PSFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
 NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=SmyYMa2eaOOKt127Z8E+MLPCx/gtttlYtf0pf1yUTPtnkCyFu5MLnw5UhDsKWQ7BJP8RKhlvfIKXJu+toF2+8zgwo5zo77f2NoP2up4CWuDEjriNJ0J+Ov969V0qc7LGEnXwMz72xjgrxTS5Rc49BpK0ap8bMcAkfa9kHg3m+3A=;
 c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1; 
 bh=12YV6/V7BYzKRbyPF82dcu8rx/sOSfpIw5BrRnj5HIQ=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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

Plane objects use drmm_kzalloc() but their destroy callback frees them
with kfree(). The managed allocation can also be released before mode
configuration cleanup accesses the embedded plane.

Use ordinary allocations, matching the existing plane destroy callback.

This issue was found by our static analysis tool under development.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/gpu/drm/kmb/kmb_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 1742c2c6dfd8..7c908ca23e5b 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -581,7 +581,7 @@ struct kmb_plane *kmb_plane_init(struct drm_device *drm)
 				  BIT(DRM_MODE_BLEND_COVERAGE);
 
 	for (i = 0; i < KMB_MAX_PLANES; i++) {
-		plane = drmm_kzalloc(drm, sizeof(*plane), GFP_KERNEL);
+		plane = kzalloc_obj(*plane);
 
 		if (!plane) {
 			drm_err(drm, "Failed to allocate plane\n");
@@ -636,6 +636,6 @@ struct kmb_plane *kmb_plane_init(struct drm_device *drm)
 
 	return primary;
 cleanup:
-	drmm_kfree(drm, plane);
+	kfree(plane);
 	return ERR_PTR(ret);
 }
-- 
2.43.0

