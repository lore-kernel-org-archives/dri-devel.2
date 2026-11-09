Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9B606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfsvoSIR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A1210E5BA;
	Mon,  9 Nov 2026 22:34:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC2110E2B3;
 Mon,  9 Nov 2026 22:34:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6F5E61D01;
 Mon,  9 Nov 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794263666;
 b=nmgRxoy7/6xLpgph0WBZ0fQ3WXfK+9TBP5sULIdVP30q8FQz+Mtwuf6kOUMmfkktooLz
 dXdxnmfOKRXEaxf7qViwBJWp7yavzF4yVC1irt5k6eFOSWn3pAOLtmeXWoY6aNiLJaIU0
 jTHN6wkhHWZ9aQXyuQk7AinjdknzgTRPv7ACVRKTrbzQkGRZu9tYFgWfF7lLZDzAaHwUL
 v/Vd+q019ZFMeF1LmmhEsgHSZzLTbPS1h8EIkTzt5fP/izr0vwZNSfDQ7R6M3vws1mney
 JoaABh3sfB2oEwQq7D8w887/7opqysDbu7MQo9gjrtHi1us5ThHTOqPdMA549IPdmtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794263666;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=DYbgwv5/wE0ydlOHRocDA+zVb+YmXkIhVpD9KeynjC4=;
 b=wZqKFnJQmS6iOiq0Job9k/aoipdLWZgjnduV8JrU7ZHhbKjl/R6FFiq8hGIb0uOtWLFO
 8bWowmL4J2Sk31GdSYtKGqbL3O3WIBw9AZnQIiGEhjlC4LkfIOagcH6M5vuGtnzlrh0up
 vMfylrseI7UCUjSp4KKDXaifCkdyE0uNXS+NadNaawNCbzNP3bWPSDfPU3bL3G+R1gZKt
 AQNdg/7fnibFAjZYzxg6e0TXrZ0zDvIykIxlWkONlU7+CxuGiE54xfwiaoLD5ScB1QkeL
 GU6rjYdpJHt3NEmFGv/fxubZOwQCGVYtsACL4CICnDvMlVJ5HFMGK7zLAt1aQl6YkLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E4D401F0089F;
 Mon,  9 Nov 2026 22:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794263666;
 bh=DYbgwv5/wE0ydlOHRocDA+zVb+YmXkIhVpD9KeynjC4=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=XfsvoSIRyWUpQovt5hVF6VLYUakctMVMGHOnXyFyzV/6edCsGa3echU945ER0Y/Ec
 nAGzjBEH0b7As3XJTyffvc1n+A5kPnQNeeLxsmNfdAdlqLSmn1+8Ak8Mo+OBW2Lqoa
 qC5SzmSBySZwqwk0kLK0skmF1g3rL7DA8HuPlJKckf/HI+yBfglYgGgu8NVFaUUZen
 CjcrZ0MUUrs8XBzgE4m8ScOi0jKzq/j1a31eRYA5UvFWRJ3gz7W6EvIIHzkP2XSJK5
 gO/CC9njFXn+vJ/PFtqr2A5fxoQvQGXgL9iQH6lzXgQMnuAx5P8RXbI4Okwhacj3sH
 8Ge+MvaGGs1WA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 779A94869D;
 Mon,  9 Nov 2026 22:34:25 +0000 (UTC)
From: Gaurav Suman via B4 Relay <devnull+gauravsuman007.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 22:34:24 +0000
Subject: [PATCH] drm/msm: align kernel-managed GPU VAs to 64 KiB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-msm-va-align-v1-1-2e9b576d2e4e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG9K8moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNL3dziXN2yRN3EnMz0PF0Dc6MkUwtTA2OLxEQloJaCotS0zAqwcdG
 xtbUAN7gbFV4AAAA=
X-Change-ID: 20261109-msm-va-align-072b585038aa
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Gaurav Suman <gauravsuman007@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794263665; l=3102;
 i=gauravsuman007@gmail.com; s=default; h=from:subject:message-id;
 bh=jgOwJ2FL7GTVl1ehT01v9Wyso8hTCmJQBXKc1hdLWFE=;
 b=ZwtuXkntUilUgklhqwAwOwthlQCa5WxHHtyOfF7o8H8qaTEv5zMIZWw18/XTo6OaFTJUfuPPZ
 oGRybGxy7EwB/fHyzPAkDe9tt5lR9XXh9ylBqqk1S9hnSZfGzNYe+1G
X-Developer-Key: i=gauravsuman007@gmail.com; a=ed25519;
 pk=lnUC0mQfc0KyA0LE73pQ4+QWYVRaCD8Sd3XWxLZO+JY=
X-Endpoint-Received: by B4 Relay for gauravsuman007@gmail.com/default with
 auth_id=1467
X-Original-From: Gaurav Suman <gauravsuman007@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: gauravsuman007@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gaurav Suman <gauravsuman007@gmail.com>

On an Adreno 640 (SM8150, LG G8x) GNOME Shell triggers SMMU
translation faults with source=CCU, about ten per login, when
freedreno uses GMEM (binning) rendering. FD_MESA_DEBUG=nogmem or
=inorder hides them.

A stall-on-fault capture decoded with crashdec shows the faulting
address at an exact 64 KiB boundary (FAR 0x110690000) while the pass
drew to MRT0 at 0x110695000 and depth at 0x11069f000, all in that
64 KiB block. The block start belonged to the unmapped tail of
another buffer that was not part of the running submit. A ring
buffer of pagetable operations confirmed this for every fault: the
CCU reads the 64 KiB-aligned start of the block holding a bound
render target, and msm packs kernel-managed VAs at 4 KiB, so that
address often belongs to a different, unmapped buffer. Batch
reordering makes this common, which is why inorder hides it.

Align kernel-managed VAs to 64 KiB, falling back to page alignment
when the range is too tight (a6xx_gmu_init() fails with -ENOSPC
otherwise).

Tested on the LG G8x with Mesa unchanged and GMEM enabled: in an A/B
run in one boot, 4 KiB alignment gave 10 and 10 faults per login, 64
KiB alignment 0, 0, 0 and 0. No faults in three further logins, a
GMEM stress test or the full device test suite; glmark2 is unchanged
within noise. Userspace-managed VMs (VM_BIND) are not changed; Mesa
may want the same alignment there.

This was investigated, written and tested with the help of an AI
coding assistant (Claude Opus 5.5, Anthropic); I reviewed the change
and the test results.

Signed-off-by: Gaurav Suman <gauravsuman007@gmail.com>
---
Tested on LG G8x ThinQ (SM8150).
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f687a629629d348b54ebb379d3a2fa956b8e472e..2af43291289945d54326287affeffa7e72645880 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -388,9 +388,20 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_gem_object *obj,
 	if (vm->managed) {
 		BUG_ON(offset != 0);
 		BUG_ON(!obj);  /* NULL mappings not valid for kernel managed VM */
+		/*
+		 * On a6xx (seen on A640) the CCU can read the 64 KiB-aligned
+		 * start of the block that holds a bound render target. Align
+		 * kernel-managed VAs to 64 KiB so that block start lies inside
+		 * the buffer itself; callers with a tight fixed window, such as
+		 * the GMU, fall back to page alignment.
+		 */
 		ret = drm_mm_insert_node_in_range(&vm->mm, &vma->node,
-						obj->size, PAGE_SIZE, 0,
+						obj->size, SZ_64K, 0,
 						range_start, range_end, 0);
+		if (ret == -ENOSPC)
+			ret = drm_mm_insert_node_in_range(&vm->mm, &vma->node,
+							  obj->size, PAGE_SIZE, 0,
+							  range_start, range_end, 0);
 
 		if (ret)
 			goto err_free_vma;

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261109-msm-va-align-072b585038aa

Best regards,
-- 
Gaurav Suman <gauravsuman007@gmail.com>


