Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C3FC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9C710E0BF;
	Fri, 24 Jul 2026 22:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="ERT00G5o";
	dkim-atps=neutral
Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BD710E0BF
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:21:49 +0000 (UTC)
Received: by mail-yx2-f3.google.com with SMTP id
 00721157ae682-81dd189c50fso168187b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1784931708; x=1785536508;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ewz9X+tvTo9tg+O07861T4ZUwv6Fnxp75VK26mEaZHA=;
 b=ERT00G5oMDFXQrmlsYBUMCS/+cpqMfeRKjdCoejN26Dnu3Ce5x3C4auc7As0lTD2BO
 v3p14fyFLNaSK1E8FNTXqPhy7vaAXP6V5iReSRCzeLmtTjXN6w+ViteS0AJbDWaMQFIg
 mvwTC14RTNvlm9QA+hMUqu3iIOsmWe5m7LeWvEmqOQDUPqWEjXzBO2Jh4EbErdwMIeBo
 lUOuYgsXbD/aJbNH8WtWgbf8jxYcFEpENcxsAW8xkMytCgK1wi/sJiiih2pq5CT1xk0l
 XLzNIVrnfUf0UHoXF4KHZszvf5GL5JoTRdk20OXcjd7jOjwra6bnP93m75LiZcW3w7pj
 P4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784931708; x=1785536508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ewz9X+tvTo9tg+O07861T4ZUwv6Fnxp75VK26mEaZHA=;
 b=K/DPNRE9i094qkgczq9fMnZERaQdK+5vJtbrAJBlulEXsnNFqT6KqQHnoVqVRP6B+C
 g0qoNyUwfVZ3VUlzslaAlI7lRF95cekMqx+HL7keIBxeseeQpnfv02THLA8L4Y1X/UnO
 Q4Es0YCEQMtjmlC9d8giTkRsXuq2YOlFCvmJEwGQ6U+HYWz6PicEZUeZ5yEK9ilt2Lh4
 AOTFwX7BcVOV4DAPVmx+cALJB8aOeoywwCpoLFJTmer1HG9509lrvBe3YVOtA0ywXb0I
 I6MIQFqcutxlqM/gZXwpkUJg+DNzdNFvkE2OUxEKGaGnfQyXiB6Q5EK/eZa43iz0/PID
 eLZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmM4d0Y5A0MwUJsvfUfJxRvZGrJKUy2/eKtjH0FL2cBAGvtGaC3z8BFVmmNV9CqNkLwV85YNo/M9k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUIxlv3B9AL4UbabX6W1Ugq4z58GP8sI49kaX8L4dfHSiwQnko
 HKJwvtw1wgWNuyB9kOtuVVWFbW04a07FjWH0t+3HsRcAfR1XnGzNs4uWHFAJhAViM6bL
X-Gm-Gg: AR+sD13vHbRRrXk2Wzv8+kFEJT7TIj36+qzjBEctZFXQQHEho1s5pqfXsGe1QCPFFqJ
 9jJ+Aoc0J4n30Y9x1uA8EgiadHdw2Le59fM8B0p7zmhVvXql3Ifqb/CWF7XRLVftLD7cCPOqEQj
 K5BnG2Mw05zndmcRjzjcIPKfdZHR39gDxm9iO2hjjxIQEmnuvBJMJjDTHZ58JIAh7Mli/InEa7G
 Fl99E8GjftB5XhEnVCi8GVlPn2H7Lrps9KXCCXdq1nYNafg8iDh6ivm4Lbefby9ZKH0EOddm0Hw
 wTd58qB3p3mk2bqwknGbREVruuq05r6RJ7mv7TJlXBQb2JQMua5EfHiTgsFv6Ni8mj9vaauEESr
 485oDvFVOuz1gHPKj1GzJIRHvPblcueYfHyt6AhSdAn8aSjcJLjjs0U5SERhb8pszcF96X8Y24g
 5zHNeyISqjb/nt5HOvv+Mt5Drfzy+cpD2u4+ykpXchiGglbQdnFLtpJKgQzKcvCLoTSg==
X-Received: by 2002:a05:690c:c509:b0:7ec:58dc:f23 with SMTP id
 00721157ae682-81f69e5d6bfmr1122677b3.5.1784931708226; 
 Fri, 24 Jul 2026 15:21:48 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net
 (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f657c727asm6088597b3.19.2026.07.24.15.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 15:21:47 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
 christian.gmeiner@gmail.com, airlied@gmail.com, simona@ffwll.ch
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, guoziyi114@gmail.com,
 n7l8m4@u.northwestern.edu, stable@vger.kernel.org
Subject: [PATCH v2] drm/etnaviv: honor read-only userptr flag in GPU MMU
 mapping
Date: Fri, 24 Jul 2026 18:21:24 -0400
Message-ID: <20260724222124.537101-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514131401.2660079-1-clusk@northecho.dev>
References: <20260514131401.2660079-1-clusk@northecho.dev>
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

The userptr interface records the requested access mode in
etnaviv_obj->userptr.ro (set when ETNA_USERPTR_WRITE is absent), but
etnaviv_iommu_map_gem() ignores it and maps every buffer with
ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE.  A buffer pinned without
write permission is therefore writable by the GPU, which can mutate
page-cache data visible to other processes.

Build the protection mask from userptr.ro instead.

On MMUv2 this is a real enforcement change: etnaviv_iommuv2_map()
encodes the writeable bit per entry, so omitting ETNAVIV_PROT_WRITE
clears MMUv2_PTE_WRITEABLE and the hardware refuses GPU writes.

MMUv1 cannot enforce read-only at all.  Its page table entries are
bare physical addresses -- etnaviv_iommuv1_map() accepts a prot
argument and discards it -- so passing ETNAVIV_PROT_READ has no
effect on v1 hardware.  What can be improved there is the mapping
path taken: a single-entry contiguous userptr BO currently takes the
MMUv1 linear-window shortcut in etnaviv_iommu_map_gem(), which hands
the GPU an offset into a window of up to 2 GiB rather than a
page-table mapping of just the pinned pages.  Setting
ETNA_BO_FORCE_MMU on read-only userptr BOs at creation time
suppresses that shortcut and confines the GPU to the mapped pages.

To be explicit, because the two halves differ: this makes read-only
userptr genuinely read-only on MMUv2, and on MMUv1 it only narrows
what the GPU can reach.  A read-only userptr BO on v1 hardware
remains GPU-writable.  Rejecting such mappings outright was
considered and dropped.

Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
Link: https://lore.kernel.org/all/20260508180518.1417371-1-n7l8m4@u.northwestern.edu/
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-5
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---

Changes since RFC v1 [1]:
- Per Lucas Stachs feedback on Ziyi Guos parallel patch [2][3]:
  set ETNA_BO_FORCE_MMU on read-only userptr BOs at creation time
  rather than rejecting read-only mappings on MMUv1 with -ENODEV.
- Commit message now states the MMUv1 limitation explicitly:
  forcing the page-table path is containment, not write protection,
  because MMUv1 PTEs have no writeable bit.
- Two-file change (etnaviv_gem.c + etnaviv_mmu.c) instead of the
  single-file etnaviv_mmu.c change in the RFC.

The same bug was independently found by Ziyi Guo, who posted a fix [2]
six days before my RFC.  Neither patch was merged.  This v2 takes the
approach Lucas preferred in reply to his [3], and keeps his
prot-in-a-local shape rather than inlining the condition at the call
site.

Open question for Lucas: on MMUv1 a caller asking for a read-only
userptr BO now gets a mapping that is not read-only, silently.  I
have left it silent to keep the diff small for stable, but a
drm_warn_once() in etnaviv_gem_new_userptr() would make the
limitation visible to userspace developers.  Happy to add one if you
prefer.

Tooling and testing, per Documentation/process/generated-content.rst:

- The bug was found by static analysis rather than by hand: a
  mechanism-first variant-analysis pass over page-backed buffer
  sinks, looking for sites where a recorded access-mode flag is not
  carried into the mapping that would enforce it.  The same pass
  flagged an equivalent shape in drivers/accel/ivpu, which turned out
  to duplicate commit 7dd57d7a6350.
- The patch, the changelog and this text were drafted with LLM
  assistance (see the Assisted-by tags) and reviewed line by line by
  me; I take responsibility for all of it.
- The MMUv1/MMUv2 asymmetry above was established by reading
  etnaviv_iommuv1_map() and etnaviv_iommuv2_map() directly, not by
  trusting the tool: an earlier draft of this patch claimed MMUv1
  enforcement and was wrong.
- Testing: compile-tested only.  Built on x86_64 with COMPILE_TEST=y,
  CONFIG_DRM_ETNAVIV=m, gcc 15.2.1, W=1 -- clean, no new warnings.
  Base: drm-misc-next abc1e559f8e5.  No Vivante hardware is available
  to me, so neither the MMUv2 enforcement path nor the MMUv1
  containment change is verified at runtime.  A test from anyone with
  GC hardware would be very welcome, and I am happy to arrange
  hardware validation before merge if you would rather have it first.

[1] https://lore.kernel.org/all/20260514131401.2660079-1-clusk@northecho.dev/
[2] https://lore.kernel.org/all/20260508180518.1417371-1-n7l8m4@u.northwestern.edu/
[3] https://lore.kernel.org/all/3e298ed6a361a0aa5526d859b0f3a98c0cd47090.camel@pengutronix.de/
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 13 ++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 10 +++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index b0436a1e10..b043a56e3e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -735,9 +735,20 @@ int etnaviv_gem_new_userptr(struct drm_device *dev, struct drm_file *file,
 	uintptr_t ptr, u32 size, u32 flags, u32 *handle)
 {
 	struct etnaviv_gem_object *etnaviv_obj;
+	u32 bo_flags = ETNA_BO_CACHED;
 	int ret;
 
-	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_CACHED,
+	/*
+	 * Keep read-only userptr BOs out of the MMUv1 linear window, which
+	 * would expose far more than the pinned pages to the GPU.  MMUv1
+	 * PTEs have no writeable bit, so this confines the GPU rather than
+	 * making the BO read-only; MMUv2 enforces read-only per PTE in
+	 * etnaviv_iommu_map_gem().
+	 */
+	if (!(flags & ETNA_USERPTR_WRITE))
+		bo_flags |= ETNA_BO_FORCE_MMU;
+
+	ret = etnaviv_gem_new_private(dev, size, bo_flags,
 				      &etnaviv_gem_userptr_ops, &etnaviv_obj);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index e3572461b5..569f729681 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -269,10 +269,18 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 {
 	struct sg_table *sgt = etnaviv_obj->sgt;
 	struct drm_mm_node *node;
+	int prot = ETNAVIV_PROT_READ;
 	int ret;
 
 	lockdep_assert_held(&etnaviv_obj->lock);
 
+	/*
+	 * Read-only userptr BOs drop ETNAVIV_PROT_WRITE.  MMUv2 honors this
+	 * via MMUv2_PTE_WRITEABLE; MMUv1 ignores prot entirely.
+	 */
+	if (!etnaviv_obj->userptr.mm || !etnaviv_obj->userptr.ro)
+		prot |= ETNAVIV_PROT_WRITE;
+
 	mutex_lock(&context->lock);
 
 	/* v1 MMU can optimize single entry (contiguous) scatterlists */
@@ -301,7 +309,7 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 
 	mapping->iova = node->start;
 	ret = etnaviv_iommu_map(context, node->start, etnaviv_obj->size, sgt,
-				ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE);
+				prot);
 
 	if (ret < 0) {
 		drm_mm_remove_node(node);
-- 
2.54.0

