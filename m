Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6C6075545
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ul93LtzQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5C110EE70;
	Tue, 10 Nov 2026 07:45:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644DF10EE70
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:45:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 229484177E;
 Tue, 10 Nov 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794296700;
 b=sSi2v1D6lpcZOexEppnFLCjAnqZNpyeGcKDxmfe5sjLg++MAxUfEe0uHwjLwDzce136w
 XDbDv1xBoxKYACOeqLTFmzJQXlFzoF7VKJKxT/idj/akZr7lzfPL+UatfX0FGpSSfI4z2
 FGUd1Ey1dUqyj3ldVyNVQRfYGCvaObcriPSe0pozL1lpyAgKO76yusDLd6FPdTJ7TNmys
 JdkbwyleunfRewWAM5fpfO7kQcM4GhHqBugj1lDJz3hB369BP/sIcY2lbCpBL3DbKtaGO
 PLj7scEwqN2zgCO2kWONCyzKS2qSd3E15U1nyEuewWiJHEC7/2iD91alKMfHu8dMQPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794296700;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=hM5Y3UKyTTBxfSlTJTGUNszVKAm0qhVvKu+GIeLvcu4=;
 b=iy8t+u1+0LFE0bxShh+Z5tydFduuHFxw0hohcNfX5R9jSbSi9Nay6sVoXzERsiVgkA6s
 oousmnrwcGS1GhWtuoCD3KFrsAzsnctQEYuNkVSrvPXgtcsvPKu0zJcevJJ4eHdpcu5Bt
 0BFWixiOg89O1UzJk5eaq6D4ln5pNiq50wXuPP4gN0kip5VZyGCyAQ8gBP9EWTNQ0IFxC
 OgXpgkhS4GNIvvy2+l6lkGYWWlXc5o6Oq3FnFERwo1zSjuyDV/PwKX04/i1Zts1nrDebQ
 gN3FFgMthHzG90Owgy8PNrQqpxPTslp4PHXVsmf0kL/SjlzNZpuZbcMYPtPAET/5U8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 077DD1F0089F;
 Tue, 10 Nov 2026 07:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794296700;
 bh=hM5Y3UKyTTBxfSlTJTGUNszVKAm0qhVvKu+GIeLvcu4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Ul93LtzQsOod6SFfPl5Fj4eqpeo/yOG1BzH6kQMZ9l1nmadbn7NX5cFE7vcqZLCe+
 8jGq2rl+m/szdTyKcsDdM13q9FfaGp0O7f42bHDvVs2WRGWwzrxigTJSpn7BbM9rlx
 r497Xo6/ZkSotqR+GaMj/mmd4r2mKi5VzQWK7L6nSw39jESUd2lMLcQC9Rd0UpKCPN
 jwmf+dXxbgshhtvxoOTcHR8yIcWKDuNUdKVgi/HMNo3dKby7FaDZ+t4W6HX6LPAYmU
 AiLSoQd7Ckx0l1kO6detkzWgaKV4JVrCWW8KGGLjQtOkxA+h4CRylpx4gypjZhTDTa
 N7QmXBwNglHaQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A37B048A26;
 Tue, 10 Nov 2026 07:44:56 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:45:02 +0000
Subject: [PATCH 7/7] drm/panfrost: Name the BOs around an unhandled page fault
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-panfrost-long-jobs-v1-7-24508939ae8d@gmail.com>
References: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
In-Reply-To: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
To: David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794296695; l=4912;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=9pt+9zxspvcPYoCvJUbuQTbXv7CjJ23ldIGjznYrXko=;
 b=20c9Asou0gkJSeCspFzbAB/rV/bY4dYlFVnBFG4iz2cujTFukeTUQnoNjIuiQYonBmSs3tZ2X
 ghlJ9YHCD/DAkXcNHf/EbkLUG/hscnxePuPCODy2Q/ek7e+iQcwDCbN
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

An unhandled GPU page fault only reports the faulting VA. That does not
tell a GPU access just past the end of a buffer (a userspace or hardware
overrun) from an access to a buffer that is no longer mapped (a kernel
bug) or from a garbage pointer.

After the fault report, look the address up in the faulting address
space and print the BO that contains it, or else the nearest BO below
and above it: VA range, size, the distance of the fault from it, whether
it is still mapped, heap/noexec, and the label userspace gave it (Mesa
labels its BOs with their use, format and size). For an OpenCL image
read on a Mali-G31 this gave:

  panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA 0x000000000A181000
  ...
  panfrost 1800000.gpu: fault bo: below: VA [0xa041000-0xa181000) size 0x140000, fault at end+0x0, mapped, noexec, label "Texture format=r32g32b32_sint extent=25x128x32 array_size=1 mip_count=0 samples=0 modifier=0x0"

that is, the texture unit reading past the end of a 96-bit-per-texel
texture, which userspace can avoid by padding such textures.

Only the unhandled fault path is affected; heap growth faults are not.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 13728b0c4..b0319d680 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -595,6 +595,86 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
 	return mapping;
 }
 
+static void panfrost_mmu_print_fault_bo(struct panfrost_device *pfdev,
+					struct panfrost_gem_mapping *m,
+					u64 addr, const char *where)
+{
+	struct panfrost_gem_object *bo = m->obj;
+	u64 start = m->mmnode.start << PAGE_SHIFT;
+	u64 end = (m->mmnode.start + m->mmnode.size) << PAGE_SHIFT;
+	u64 dist = addr < start ? start - addr : addr >= end ? addr - end : addr - start;
+
+	mutex_lock(&bo->label.lock);
+	dev_err(pfdev->base.dev,
+		"fault bo: %s: VA [0x%llx-0x%llx) size 0x%zx, fault at %s0x%llx, %s%s%s, label \"%s\"\n",
+		where, start, end, bo->base.base.size,
+		addr < start ? "-" : addr >= end ? "end+" : "start+", dist,
+		m->active ? "mapped" : "NOT mapped",
+		bo->is_heap ? ", heap" : "", bo->noexec ? ", noexec" : "",
+		bo->label.str ? bo->label.str : "");
+	mutex_unlock(&bo->label.lock);
+}
+
+/*
+ * Report the BOs around an unhandled fault address in the faulting address
+ * space: the one containing it (if any), else the nearest one below and above.
+ * An access just past the end of a BO that a hole follows is a GPU overrun of
+ * that BO (userspace or hardware), a fault inside a BO whose mapping is gone
+ * points at the kernel, an address far from any BO at a stale or garbage
+ * pointer.
+ */
+static void panfrost_mmu_report_fault_bos(struct panfrost_device *pfdev,
+					  int as, u64 addr)
+{
+	struct panfrost_gem_mapping *below = NULL, *above = NULL;
+	u64 offset = addr >> PAGE_SHIFT;
+	struct drm_mm_node *node;
+	struct panfrost_mmu *mmu;
+	bool inside = false;
+
+	spin_lock(&pfdev->as_lock);
+	list_for_each_entry(mmu, &pfdev->as_lru_list, list) {
+		if (as == mmu->as)
+			goto found_mmu;
+	}
+	spin_unlock(&pfdev->as_lock);
+	dev_err(pfdev->base.dev, "fault bo: no context holds AS%d\n", as);
+	return;
+
+found_mmu:
+	spin_lock(&mmu->mm_lock);
+	/* The node list is sorted by address. */
+	drm_mm_for_each_node(node, &mmu->mm) {
+		if (node->start > offset) {
+			above = drm_mm_node_to_panfrost_mapping(node);
+			break;
+		}
+		below = drm_mm_node_to_panfrost_mapping(node);
+	}
+	if (below) {
+		inside = offset < below->mmnode.start + below->mmnode.size;
+		kref_get(&below->refcount);
+		if (inside)
+			above = NULL;
+	}
+	if (above)
+		kref_get(&above->refcount);
+	spin_unlock(&mmu->mm_lock);
+	spin_unlock(&pfdev->as_lock);
+
+	if (!below && !above)
+		dev_err(pfdev->base.dev, "fault bo: AS%d has no BO\n", as);
+	if (below) {
+		panfrost_mmu_print_fault_bo(pfdev, below, addr,
+					    inside ? "inside" : "below");
+		panfrost_gem_mapping_put(below);
+	}
+	if (above) {
+		panfrost_mmu_print_fault_bo(pfdev, above, addr, "above");
+		panfrost_gem_mapping_put(above);
+	}
+}
+
 #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
 
 static void panfrost_heap_put_chunk(struct page **pages, pgoff_t start,
@@ -965,6 +1045,7 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
 				exception_type, panfrost_exception_name(exception_type),
 				access_type, access_type_name(pfdev, fault_status),
 				source_id);
+			panfrost_mmu_report_fault_bos(pfdev, as, addr);
 
 			spin_lock(&pfdev->as_lock);
 			/* Ignore MMU interrupts on this AS until it's been

-- 
2.55.0


