Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E003606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NOZVqhEE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23C2112BC5;
	Fri, 20 Nov 2026 16:17:44 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF65F11297E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:59:17 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3b0bbdeae06so475201a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 03:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795175957; x=1795780757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S6IS/mU9CGQB+CxcqZArg7eMwtn8KJF1AGNkVI6J8eA=;
 b=NOZVqhEEr52/MD1FkzBufTnId6ONL2GB5ethGRvT8oRNDgM5eYBRxT4mf89acKWnY6
 9mULbK2oN21jJVU8PWjttzT5EgFkViXxf688YFyQYCu2hab8Yq9hRovsb7hn0EdHax7p
 oR8H1a3Csta2zQDQWt9NgHzR4VT5dJ7xtNj5B/t+G3r00tJiiifeGPn3Cjbi9dzFOmfl
 745R/QHyykPiV1Xfz0fYH40xf2HiOXxVCoywOpRT45zxZEdxRattuVtALBwhgnvNQSRV
 tG+P6FvfRiCpOjyivXsdD9YXfQoSUq11/CS1G3b5Fv91/snFmV16cuYoVXNWGx0Eki16
 EjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795175957; x=1795780757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S6IS/mU9CGQB+CxcqZArg7eMwtn8KJF1AGNkVI6J8eA=;
 b=2e9zoWM2H0STzkK7li1XB+LhNaSBdznedUXZLMEABLMR5E9ElJ9y0O7F9ltnJd8mkV
 110vqBLF9ALH3l06qD+bwvPR+cjtto9uawhC2Tcj7UdTR+EIP3lFXWEgTww/eTZqzDjG
 01tp8C/CN9veleai8kJna4vo0OvtRDz40/XDXGQcG9TmdSu/VPtPmlRAcUOYfSLtNnUD
 XA9pc7iUVDrnZaFeMY/bXkfz3uG4hCfornaSorga+QhMonj/uLPMeHldd/BJ7ZpTIeJ7
 QTi7QiV05WGVmHyCbjKLV0AYKPBixdtcXx9NbLQ0CeEA0kQ/g96hmffKHRoEv2w0+p4f
 4FmQ==
X-Gm-Message-State: APuU4Z8pf+pDE6bATtPJzeTd56qjDEyeP0CbaV5QnVqNg7Ls8qYJGsNg
 7noHCV2lZud2Ei2vA/5g1Pwd4sp3lKZBkSaKcGnTajVhWkGUkxlnVucw
X-Gm-Gg: AZFdTZdKi5X12y9lOroujgc2RYfNNKD24t0KM+ue9WzbLezWfqFlYFM4qRbcvi+/3uZ
 +Yn0iz4ylKp2JcaAX+RmAub9Fm/DoI7rfaD/P9eKiDZvoUQ4aROOBuiIB17mGsFDiaIWQmRt0Cs
 WFvTFcueFN6E4yCGCGqh4n9upKFX3BYmZuYeR3ocRx+R6atFjdLxBGse+7eMSRrwSzvRJ9eG4eP
 eTp7hBpMJDF86LcieH7a/GsWqBbwsuCaqpVi1sGqZGyX7YaPWI2vt58dSeHvvYkgxKYkuKqwxiQ
 tyRcHy6togln7dXFzx6LIyY6vpWG14wImDcwY8hslSg4fgP8YvYy/RWAUcFzQm7Tj4M6fOsojnh
 vt+Yakh+5fqYlRYIgc+feEY2d0QS9MJinge6gmDIwBvWaP2vZ1AXmM0TnbRRG2817JHiUrFwNG8
 g6wkEHlJKcsASdotTom0DJ/Yy+oh5q2SpkClhpCC+IDlILDZG+V9Al0a6hdNBXeejawJmrLkpR2
 v7cLmEm50Bmf0Ir0DvYfz973xwEreMUu7XzccgZzi1tFnUnDwzwUSWgMvawKBspzbfMxBSDPYsr
 ROLm4Ywa21pTo9OFact7KpV+xfA0hY3+0wISww1Sr3sD7+SBe6loa6AJzmXeq1kwF/Ii2cee3qc
 5rcrelwZORA==
X-Received: by 2002:a17:90b:2cce:b0:3a4:967c:6947 with SMTP id
 98e67ed59e1d1-3b41c909001mr2615121a91.21.1795175957247; 
 Fri, 20 Nov 2026 03:59:17 -0800 (PST)
Received: from DESKTOP-TPPBPA1 (36-226-249-217.dynamic-ip.hinet.net.
 [36.226.249.217]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d0575d9sm1226566a12.25.2026.11.20.03.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:59:16 -0800 (PST)
From: Roy <rongh7426@gmail.com>
To: mwen@igalia.com,
	mcanal@igalia.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Roy <rongh7426@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/v3d: Don't free the core's sg_table when PRIME import
 fails
Date: Fri, 20 Nov 2026 19:58:40 +0800
Message-ID: <20261120115840.417741-1-rongh7426@gmail.com>
X-Mailer: git-send-email 2.51.1.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When v3d_bo_create_finish() fails in v3d_prime_import_sg_table(), for
example with -ENOSPC because the V3D address space is full, the object
is freed with drm_gem_shmem_free(). At that point obj->import_attach is
not set yet, since drm_gem_prime_import_dev() only sets it after the
driver callback returns. drm_gem_shmem_release() therefore takes the
non-imported path and treats shmem->sgt as its own: it unmaps it with
the V3D device, calls sg_free_table() and kfree()s it.

That sg_table belongs to drm_gem_prime_import_dev(), which then unmaps
it again through dma_buf_unmap_attachment_unlocked() on its fail_unmap
path. The exporter's unmap runs on the freed table, and the kernel
crashes:

  Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
  pc : dma_direct_unmap_sg+0x84/0x260
  lr : dma_unmap_sg_attrs+0x60/0x148
  Call trace:
   dma_direct_unmap_sg+0x84/0x260 (P)
   dma_unmap_sg_attrs+0x60/0x148
   drm_gem_unmap_dma_buf+0x38/0x68 [drm]
   dma_buf_unmap_attachment+0x3c/0xa0
   dma_buf_unmap_attachment_unlocked+0x58/0x98
   drm_gem_prime_import_dev+0x1a0/0x1e0 [drm]
   drm_gem_prime_fd_to_handle+0x1a8/0x280 [drm]
   drm_prime_fd_to_handle_ioctl+0x40/0x58 [drm]

Users have hit this on Raspberry Pi 5 with Xorg importing vc4 buffers
into v3d.

Clear shmem->sgt before freeing the object, so that only the PRIME core
unmaps it.

Tested on a Raspberry Pi 5 running 6.18.39 with a small program that
exports a vc4 dumb buffer, fills the V3D address space with BOs until
creation fails with -ENOSPC, then imports the dma-buf into v3d. Without
this patch the import oopses as above. With it, the import fails
cleanly with -ENOSPC (60 runs), BO stats stay at zero, and imports
succeed again once BOs are freed. The fix was tested as an out-of-tree
v3d module built against 6.18.39; this tree was not built for arm64.

The bug was found and the fix written with the help of an AI coding
assistant (Claude); I reproduced and tested it on hardware and reviewed
the change.

Fixes: 40609d4820b2 ("drm/v3d: Use the new shmem helpers to reduce driver boilerplate.")
Cc: stable@vger.kernel.org
Link: https://github.com/raspberrypi/linux/issues/7504
Signed-off-by: Roy <rongh7426@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index db95a2f..d0b672d 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -185,6 +185,13 @@ v3d_prime_import_sg_table(struct drm_device *dev,
 
 	ret = v3d_bo_create_finish(obj);
 	if (ret) {
+		/*
+		 * The sg_table still belongs to drm_gem_prime_import_dev(),
+		 * which unmaps it when we return an error. import_attach is
+		 * not set yet, so drm_gem_shmem_free() would otherwise unmap
+		 * and free it as if it were ours.
+		 */
+		to_v3d_bo(obj)->base.sgt = NULL;
 		drm_gem_shmem_free(&to_v3d_bo(obj)->base);
 		return ERR_PTR(ret);
 	}
-- 
2.51.1.windows.1

