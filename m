Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26A3108E1FB
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CDD10E983;
	Thu, 19 Mar 2026 12:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DY58x/fs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B928B10E983
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:01:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 512A843986;
 Thu, 19 Mar 2026 12:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C521EC2BC87;
 Thu, 19 Mar 2026 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1773921702;
 bh=VN6CnRcD1cEEmdKQOxkAcabrskj4q90iDzQnQm2rak8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=DY58x/fsYrFcSvWC0zvxkISldjag1r1b71ARY0l+IzEk8PCQoqdxMETAXoRDEFBGJ
 DKFW2GMzMP60oe10+jhTaP1wfF3BYkDOluLJRWCxgG/RqXjxjZfaGOE/F11Y/nzzfw
 CBSOa62f0zpVbe1K9fj12RJl+EfeAkCAAA30RhNQ=
Subject: Patch "drm/exynos: vidi: fix to avoid directly dereferencing user
 pointer" has been added to the 6.6-stable tree
To: aha310510@gmail.com, airlied@gmail.com, alim.akhtar@samsung.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 inki.dae@samsung.com, krzk@kernel.org, kyungmin.park@samsung.com,
 linux-arm-kernel@lists.infradead.org, simona@ffwll.ch, sw0312.kim@samsung.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 19 Mar 2026 13:01:23 +0100
In-Reply-To: <20260227045953.165751-3-aha310510@gmail.com>
Message-ID: <2026031923-spinner-guidance-e9b7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    drm/exynos: vidi: fix to avoid directly dereferencing user pointer

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-exynos-vidi-fix-to-avoid-directly-dereferencing-user-pointer.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-219910-greg=kroah.com@vger.kernel.org Fri Feb 27 06:00:25 2026
From: Jeongjun Park <aha310510@gmail.com>
Date: Fri, 27 Feb 2026 13:59:52 +0900
Subject: drm/exynos: vidi: fix to avoid directly dereferencing user pointer
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Jeongjun Park <aha310510@gmail.com>
Message-ID: <20260227045953.165751-3-aha310510@gmail.com>

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit d4c98c077c7fb2dfdece7d605e694b5ea2665085 ]

In vidi_connection_ioctl(), vidi->edid(user pointer) is directly
dereferenced in the kernel.

This allows arbitrary kernel memory access from the user space, so instead
of directly accessing the user pointer in the kernel, we should modify it
to copy edid to kernel memory using copy_from_user() and use it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -252,19 +252,26 @@ int vidi_connection_ioctl(struct drm_dev
 
 	if (vidi->connection) {
 		struct edid *raw_edid;
+		struct edid edid_buf;
+		void *edid_userptr = u64_to_user_ptr(vidi->edid);
 
-		raw_edid = (struct edid *)(unsigned long)vidi->edid;
-		if (!drm_edid_is_valid(raw_edid)) {
+		if (copy_from_user(&edid_buf, edid_userptr, sizeof(struct edid)))
+			return -EFAULT;
+
+		if (!drm_edid_is_valid(&edid_buf)) {
 			DRM_DEV_DEBUG_KMS(ctx->dev,
 					  "edid data is invalid.\n");
 			return -EINVAL;
 		}
-		ctx->raw_edid = drm_edid_duplicate(raw_edid);
-		if (!ctx->raw_edid) {
+
+		raw_edid = drm_edid_duplicate(&edid_buf);
+
+		if (!raw_edid) {
 			DRM_DEV_DEBUG_KMS(ctx->dev,
 					  "failed to allocate raw_edid.\n");
 			return -ENOMEM;
 		}
+		ctx->raw_edid = raw_edid;
 	} else {
 		/*
 		 * with connection = 0, free raw_edid


Patches currently in stable-queue which might be from aha310510@gmail.com are

queue-6.6/drm-exynos-vidi-use-ctx-lock-to-protect-struct-vidi_context-member-variables-related-to-memory-alloc-free.patch
queue-6.6/drm-exynos-vidi-use-priv-vidi_dev-for-ctx-lookup-in-vidi_connection_ioctl.patch
queue-6.6/drm-exynos-vidi-fix-to-avoid-directly-dereferencing-user-pointer.patch
