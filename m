Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684CFCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A7310E61A;
	Thu, 14 May 2026 21:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="MKWJK1wn";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677A410E558
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:14:58 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-651c36a7ee9so1321484d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1778764497; x=1779369297;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=29KtfuJlXrDbhr12CTsDbe7NtrYpv9Xo28OIJR4h52E=;
 b=MKWJK1wngZACbYxQaxPF0/O2uKkeymOLdBZ+VpIw8LihYulpm3v8UfsxsCXGDWPoNn
 bDEL3jL9vwUt9E4JryNTHYx7VBU8qoa8qbAjlT3a539/t6nyXfFzcZezYunMM2xPbZPk
 Lg2FquLrfhZGyRQ5TtUka7ygghm3bIKaBDiW42gCJumXqBkMkIw+HzKA2sqgmEja7kvD
 oAHuGqj/8w4RzD55etxT1l1R1ZfERReIASjVbjd2opZQNeyBCpw3tQXDgc0POSjbBlAv
 9urJNNQGyzRWTGs82IEiI0bTtKHxrqxcf1YV7B+52rb6onuaoJLMxTbkTPrU+ZAgZ04S
 zi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778764497; x=1779369297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29KtfuJlXrDbhr12CTsDbe7NtrYpv9Xo28OIJR4h52E=;
 b=l9r74+eBmyHouEJrUnJpkTIM3sa4BoV53FKPFfMDXcH0yT3MvCNFF64Qms3TxqL9Cx
 5ogTnZDqsU19or57aCG6Y+eIzi54fTQUcRm1JQAWRRqmCwIhwAWz4KEuPc0qS6DJP7o1
 GLuK3SR1MSmBjOq42nn3Cwnmp6U8mGG3aITn7b4sGC6BxTUnZGhM1OI8q7kKZUIcNQxp
 PY/d3Rh176/whxwKof/lObzvW3Min7SOoW3XtXsIr26lA36ktdPahS5hPJVgN6wYJGAk
 XJbnpH1zmelHNYIQOb0fFGwM0vFpqVY9aC9qujUcvTatQpyCSKxavYJnpKSaeEK2fuAH
 MTlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QsHZKAmURaEZ0wU0Rp5ZvSRY8YsVktM5QzmNh+Bz+isZpBRZbxxY+symTK1adFc7hEXHN7a07yL8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNG+mAJSMMTYhrHU0PPOx21Fb3Psq3gcmuKAcY3ALep58sM7Lr
 bS/+jX3gr3QeKddSiAngkuShKmGqhAoW2Uy0EZPFWtnQwAskMTsyzQ5DfWd6d+jWNB1d
X-Gm-Gg: Acq92OHXAMC9JOC/rqOLgoZPNx/yAZAYunccrIDlIUxS7uWUVK1fLlPDc0FBJ7Ov0iv
 OdmwmeD0kBBjJGpnuukCol+YNYuKcJZ9efD3OzWt29WK58Uaqal5KImjTQSCf0lXXjRl492M6wc
 98rJDcNpZvD9TXZkhRmhuRjdAFrm+V3qQ6xUE1xrJZ0bS+HMiA4qD4TMrxVOe91am328Xkc6DaE
 In2oY/iz3RG4bbuesuWacuFaNcNtQdafSWWDQMvL2nxvqAEnmhI+rklF8HSYrMrfqtat00vx4yB
 WME0Qu1JfseMO2ThtAq+nDQefnq0vHLar0znRMly4UyrbZoy6GB8T0IOcRfYt9YEt5jjv7j7UaZ
 u7BbidF2O4Rmq+/6nFixO2YHOCVvSLjiIS2V8LFmeQVjeibl5U28J4MekuO/RDXUs7x9PeF3Rxo
 MtHS0J9QncvDHTbNnf8QXP9JCpMUpRgdlI5nJTf2CKIdpfEY7nkF+X79MqResyhVhKxG4v+Q6hY
 gGuuq1Zg+ZkHsY=
X-Received: by 2002:a05:690e:4004:b0:65c:ca50:a6 with SMTP id
 956f58d0204a3-65df61e049amr4748006d50.2.1778764497126; 
 Thu, 14 May 2026 06:14:57 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net
 (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65e0db69f26sm1009573d50.17.2026.05.14.06.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:14:55 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/etnaviv: honor read-only userptr flag in GPU MMU
 mapping
Date: Thu, 14 May 2026 09:14:01 -0400
Message-ID: <20260514131401.2660079-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

A userptr buffer object created with ETNA_USERPTR_READ (no
ETNA_USERPTR_WRITE) is pinned without FOLL_WRITE in
etnaviv_gem_userptr_get_pages(); the kernel agrees to allow only
read access to the underlying user pages, and the state is
recorded as etnaviv_obj->userptr.ro = true.

etnaviv_iommu_map_gem() then maps the object's sg_table into
the GPU MMU with ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE
unconditionally, regardless of userptr.ro. A submission that
names the BO as a write target therefore causes the GPU to write
pages that the kernel pinned without write permission, including
page-cache pages of files the caller has only read access to.

The ioctl entry points (DRM_ETNAVIV_GEM_NEW_USERPTR, GEM_SUBMIT)
are DRM_RENDER_ALLOW, so the path is reachable from any
unprivileged render-group user. No intervening permission check,
no RO-aware branch, no MMU-level fallback.

This is the same class shape as drivers/accel/ivpu
commit 7dd57d7a6350 ("accel/ivpu: Disallow re-exporting imported GEM objects"),
fixed 2026-04-30. The Etnaviv manifestation has a simpler trigger
path that does not require PRIME re-import. Source-level analysis
only - no Vivante hardware was available to validate the mutation
primitive end-to-end.

Mask ETNAVIV_PROT_WRITE in the call to etnaviv_iommu_map() when
the buffer originates as a read-only userptr. The userptr.mm
check guards against any non-userptr object that might somehow
have userptr.ro set.

This work is LLM-assisted: Codex (gpt-5.5) drove the static
analysis and class sweep that identified the candidate site;
Claude (claude-opus-4-7) drove the writeup and patch refinement.
Operator review at each gate. Methodology context at
https://northecho.dev/posts/codex-vs-claude-code-vuln-research/.
Posted to the public list per the security-bugs.rst exception
for findings trivial to discover via automated tooling, as
interpreted by the kernel security team for LLM-assisted reports.

Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4-7
---
v7.1-rc2 reference: drivers/gpu/drm/etnaviv/etnaviv_mmu.c:303-304

Open questions for review:

1. v1 MMU shortcut. etnaviv_iommu_map_gem() takes a shortcut for
   v1 MMU + single-segment sg_table at lines 278-291, bypassing
   etnaviv_iommu_map() entirely and using sg_dma_address directly.
   For typical multi-page userptr BOs sgt->nents > 1 so the
   shortcut is not taken, but for small contiguous regions on v1
   MMU hardware it may apply. This patch does not address the v1
   MMU path. If you believe v1 MMU also needs handling, I am happy
   to follow up with a separate patch.

2. ETNA_SUBMIT_BO_WRITE per-BO flag. etnaviv_gem_submit accepts
   ETNA_SUBMIT_BO_READ / ETNA_SUBMIT_BO_WRITE per buffer object,
   currently used for synchronization dependency tracking. Should
   a submit naming an RO userptr BO with ETNA_SUBMIT_BO_WRITE be
   rejected at submit time as defense-in-depth? Orthogonal to
   this patch; happy to follow up with a separate small patch in
   etnaviv_gem_submit.c if you would like that.

3. Fixes: tag. My v7.1-rc2 clone is shallow; I could not trace
   the introducing commit for the userptr.ro / ETNA_USERPTR_WRITE
   distinction. The bug is present in v7.0, v7.1-rc2, and
   linux-next (2026-05-08). If you have the introducing commit
   handy from deep Etnaviv history, please add the Fixes: tag in
   your applied version, or let me know and I will supply it from
   an unshallowed mirror.

A reviewer with Vivante hardware can confirm the primitive with
the following pseudocode (before/after this patch):

  fd = open("/dev/dri/renderD128", O_RDWR);
  ptr = mmap(...);  /* page-aligned, page-cache-backed file */
  bo_handle = drm_ioctl(fd, DRM_IOCTL_ETNAVIV_GEM_USERPTR,
                        .ptr = ptr, .size = page,
                        .flags = ETNA_USERPTR_READ);
  /* GEM_SUBMIT with the BO listed as ETNA_SUBMIT_BO_WRITE and a
     command stream that writes to the BO GPU VA */
  drm_ioctl(fd, DRM_IOCTL_ETNAVIV_GEM_SUBMIT, ...);
  /* observe: on unpatched kernel, ptr contents have changed;
              on patched kernel, the write does not land in the
              user page-cache pages. */

I am happy to source a Vivante board (Sabre Lite, Wandboard,
HummingBoard Pro) and post a v2 with Tested-by trailers if you
prefer hardware validation before this lands. Source-only is
offered first to avoid asking for a hardware-spend decision that
may not be necessary.

 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index e3572461b599..c4dcb7ee3e49 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -301,7 +301,9 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 
 	mapping->iova = node->start;
 	ret = etnaviv_iommu_map(context, node->start, etnaviv_obj->size, sgt,
-				ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE);
+				(etnaviv_obj->userptr.mm && etnaviv_obj->userptr.ro) ?
+				ETNAVIV_PROT_READ :
+				(ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE));
 
 	if (ret < 0) {
 		drm_mm_remove_node(node);
-- 
2.54.0

