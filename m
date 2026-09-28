Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA29DC98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B238F10E75C;
	Mon, 28 Sep 2026 04:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ln6CHw7z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE5710E755;
 Mon, 28 Sep 2026 04:33:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D5DE643702;
 Mon, 28 Sep 2026 04:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE59EC2BCB3;
 Mon, 28 Sep 2026 04:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790570016;
 bh=YwPpbFVrdO5EkkKuY0LiZH1/d7Y7QXqvVXT05SzMsSw=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=ln6CHw7zAcNZ62D99Phds6aFD63FSgqS8b1FO8J1QjHwBXxMOvJ7E7ZTphISkM0Lm
 7r6FTasSF0meSU56T3sRrFGCUB96jqRLSczfffaqCXpDZfVcFEzf7VUI35zZJHKUQ8
 w9EKJ56s38fPsIoSsGJBVEE490xOM8XaJjmKSyc/eZxic1DlD2AudgA5+DOM7YsxhX
 8wrJpDTyJtZ/0rmM+14RfezYg8Sv/jmS4ed6/wTsOlLpVMyrDItWRRZbjizxdJQRRl
 1O9UXj1s2Umja9JdjgIUZgwn79yMgN2Kbu0NMZFx4ckF1FP8wysllVMuzZvh76G6Ii
 fYyprnhR95MWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8A93DC9833E;
 Mon, 28 Sep 2026 04:33:36 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 28 Sep 2026 14:33:26 +1000
Subject: [PATCH] drm/msm: vmalloc fall back for msm_gem_submits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-msmdrm-submit-vmalloc-v1-1-8b24b1325855@samcday.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQrCQAwF0KuEv25gDDjYuYq4GNuogaaViS1C6
 d0F3wHejtBmGii0o+lmYcuMQqeOMLzq/FS2EYUgSXLq5cIePjbnWO9uH968TtMycJJz7jWLVM3
 oCO+mD/v+3+vtOH6S71DOZwAAAA==
X-Change-ID: 20260928-msmdrm-submit-vmalloc-02569e622ae6
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790570015; l=3464;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=4To87PoB5Gy7rINqfb6PWjdKecVIeYCcY9gOzBdSoHg=;
 b=cS5sp8BtOVWAHABMobEZSHj7WaVmRb2cpyvVR+lCff9hhAouttlFUkpO9bW6IUBerMJquE2XB
 mHQ3OnCMf3/CkdWzxZyvtvNOKl3W2jst3Y101Kq680ELxAIo8mD6wec
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Sam Day <me@samcday.com>

On low memory boards like the DragonBoard410c (1GiB), if memory
fragmentation is severe enough, large submits will fail when allocating
the msm_gem_submit bookkeeping struct.

Mesa was consistently triggering this issue when running its full piglit
suite on the DB410c - the vbo-subdata-many drawrangeelements test
submits ~32k BOs, which results in submit_create() attempting to
allocate ~1.05MB, which requires an order-9 (2MiB) allocation. When
fragmentation is severe enough, this fails.

Switch allocation to kvzalloc() so that larger submits can fall back to
virtually contiguous memory. The msm_gem_submit struct is only used on
the CPU side for bookkeeping that submit.

Since submits are implicitly limited to KMALLOC_MAX_SIZE with the
current kzalloc() path, we make this limit explicit with the switch to
kvzalloc().

Link: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/16414
Assisted-by: LLM
Signed-off-by: Sam Day <me@samcday.com>
---
The kvzalloc switch was tested and validated on my DB410c, the explicit
bounds check was added later and compile-tested only. Performance has
not been benchmarked.

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 5862db05297a7..1631bdeb64b20 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -42,14 +42,21 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 	sz = size_add(struct_size(submit, bos, nr_bos),
 		      array_size(sizeof(submit->cmd[0]), nr_cmds));
 
-	submit = kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
+	/* We previously allocated submit with kmalloc(), but that's
+	 * problematic on low-memory boards with high fragmentation. Now
+	 * vmalloc can be used so we retain the previous implicit sz limit.
+	 */
+	if (sz > KMALLOC_MAX_SIZE)
+		return ERR_PTR(-ENOMEM);
+
+	submit = kvzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 	if (!submit)
 		return ERR_PTR(-ENOMEM);
 
 	submit->hw_fence = msm_fence_alloc();
 	if (IS_ERR(submit->hw_fence)) {
 		ret = PTR_ERR(submit->hw_fence);
-		kfree(submit);
+		kvfree(submit);
 		return ERR_PTR(ret);
 	}
 
@@ -57,7 +64,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 				 drm_client_id);
 	if (ret) {
 		kfree(submit->hw_fence);
-		kfree(submit);
+		kvfree(submit);
 		return ERR_PTR(ret);
 	}
 
@@ -121,7 +128,7 @@ void __msm_gem_submit_destroy(struct kref *kref)
 	for (i = 0; i < submit->nr_cmds; i++)
 		kfree(submit->cmd[i].relocs);
 
-	kfree(submit);
+	kvfree(submit);
 }
 
 static int submit_lookup_objects(struct msm_gem_submit *submit,

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260928-msmdrm-submit-vmalloc-02569e622ae6

Best regards,
-- 
Sam Day <me@samcday.com>


