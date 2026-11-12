Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E84606B724
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMbu48jb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4136110FDF2;
	Thu, 12 Nov 2026 08:49:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F9910EB5D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:48:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03EB04798F;
 Thu, 12 Nov 2026 08:48:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794473318;
 b=QrV4/HONDe6u1lUoV6j4XiqvqicMZj6CRa7Cn7L70YJ4/1nXtb+MsLVGMdd37E0Ibi3U
 JQtldJAA0/aSzJiKsjOyWs3vojfH26j1tf72xKBdVI9jENKhVG9i/sRYI/7orSH3cj5iR
 uLSqouPGdHWzAj58AQ2agLDYwAnucK5FQQXCjvniqrjdwQXDlkIV5ehJ+u4/wOrX3xE6O
 Nhv43Pdl46dle10Cs7o7YX4BX4e6TNFV3rqLWm5SYBfph9NIunXbj9rzfXJJ+0jyC7YMr
 6lUdADB08gtpQD1OT1b+3CY2aO01EX0+HlVTnKNn5UzQKmum3FIGSaaBRH9lpAhOLdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794473318;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=TEHOtvcg8pmwNlr46/3hyiqhp5oP4AzLHASyCL8V+7o=;
 b=Wf0tLHbidOcN6W2tjDW1dWE1ByfU/fLfw+23t8xMXDgcSKkRWx80fCkwRPx/VktkjnGO
 AWVQBhqgo0LArPAvkNI9QIkEuCn2uM5UxHjXDXurjNZ5BPVNE5QKRvAhd6psTF0LVncqA
 P+dZVVV/VPi4uKlw4O1fpN2VN0r+zsxF5B7PKGSf+9ayjgkLOCDrI9i6+2vAZ/0Je65kt
 C3iONL/pVF50kzmvnL7QgIMqfGTKupP9b2KDuNrEF0fYFCq3t4wI1kOoLaJvUjihfS2PM
 7/FLn/jR+MhHJALlID3qopJuSoiS044uzlrcuDQdJc23fuldupcHKHIoAZUutAGaiMw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E912C1F00A05;
 Thu, 12 Nov 2026 08:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794473318;
 bh=TEHOtvcg8pmwNlr46/3hyiqhp5oP4AzLHASyCL8V+7o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=iMbu48jbZesfVIl/arsGMUvy5ujhTVwfjJdPJ/GluBs0XW6LpNgoKp63m2nSExc/P
 lM8d3ek14T52hMadGwAQGLEk7IFse6vqjvVMc5e8xeEIDJqDmRkGnBaN+zWvFEA6g5
 0ZDjA+inGC4ukKMr/fxbm/JZd5k825BTSLxTYmR46BKOAhr6971SurlZCFo0BSKUoI
 bNf0aIZZ7rGsJ//o+HXWbIFrMmrcSUackbQycp95sU3+8ba/EgYl2PxwBYisq35rd5
 0PnH+wpC11wKXelk6sfw0/VIh0TW+mJDZ9YaaemNwB/Uzjqm3Z5f0pJcH6gxdKSMeP
 eTgXZLZOyJ5YQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DF35549405;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:48:44 +0000
Subject: [PATCH v2 11/11] drm/panfrost: Name the BOs around an unhandled
 page fault
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-panfrost-long-jobs-v2-11-a06830da3d99@gmail.com>
References: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
In-Reply-To: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473314; l=5340;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=CXD0bHW8DBV0tvu/BFD5Whm4NSAnnjGvKwePlCoQV94=;
 b=FL0/5+96JG4aOn/kdjVnI+A8iVlG4dq7IWsbIs2UrOwn/fNfZ+cXBh3+5fUhBcvbSuCG1Vgeh
 cbl/tSzCxWVAmpJJb04tSe7+T4y1wRpZeTRINM+nNzpKsOO1C6XCQxr
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

An unhandled GPU page fault only reports the faulting VA. That does not
tell a GPU access just past the end of a buffer (a userspace or hardware
overrun) from a stale or garbage pointer.

After the fault report, look the address up in the faulting address
space and print the BO that contains it, or else the nearest BO below
and above it: VA range, size, the distance of the fault from it,
heap/noexec, and the label userspace gave it (Mesa labels its BOs with
their use, format and size). A BO that has been freed is no longer in the
address space, so an access to it shows up as a hole between its
neighbours. Mappings whose last reference is gone, which stay in the
address space until their teardown takes mm_lock, are skipped. For an
OpenCL image read on a Mali-G31 this gave (with an earlier version of
this patch, which also printed whether the BO was mapped):

  panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA 0x000000000A181000
  ...
  panfrost 1800000.gpu: fault bo: below: VA [0xa041000-0xa181000) size 0x140000, fault at end+0x0, mapped, noexec, label "Texture format=r32g32b32_sint extent=25x128x32 array_size=1 mip_count=0 samples=0 modifier=0x0"

that is, the texture unit reading past the end of a 96-bit-per-texel
texture, which userspace can avoid by padding such textures.

Only the unhandled fault path is affected; heap growth faults are not.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 88 +++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 684735937..9c255daf2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -601,6 +601,93 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
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
+		"fault bo: %s: VA [0x%llx-0x%llx) size 0x%zx, fault at %s0x%llx%s%s, label \"%s\"\n",
+		where, start, end, bo->base.base.size,
+		addr < start ? "-" : addr >= end ? "end+" : "start+", dist,
+		bo->is_heap ? ", heap" : "", bo->noexec ? ", noexec" : "",
+		bo->label.str ? bo->label.str : "");
+	mutex_unlock(&bo->label.lock);
+}
+
+/*
+ * Report the BOs around an unhandled fault address in the faulting address
+ * space: the one containing it (if any), else the nearest one below and above.
+ * An access just past the end of a BO that a hole follows is a GPU overrun of
+ * that BO (userspace or hardware); an address far from any BO is a garbage
+ * pointer, or a stale one: a BO that has been freed has left the address
+ * space, and its range shows up as a hole between its neighbours.
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
+	/* The node list is sorted by address. A mapping whose last reference
+	 * is gone is being freed, and only waits for mm_lock to leave the
+	 * list: skip it.
+	 */
+	drm_mm_for_each_node(node, &mmu->mm) {
+		struct panfrost_gem_mapping *m = drm_mm_node_to_panfrost_mapping(node);
+
+		if (!kref_read(&m->refcount))
+			continue;
+		if (node->start > offset) {
+			above = m;
+			break;
+		}
+		below = m;
+	}
+	if (below) {
+		inside = offset < below->mmnode.start + below->mmnode.size;
+		if (inside)
+			above = NULL;
+		if (!kref_get_unless_zero(&below->refcount))
+			below = NULL;
+	}
+	if (above && !kref_get_unless_zero(&above->refcount))
+		above = NULL;
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
 
 /*
@@ -984,6 +1071,7 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
 				exception_type, panfrost_exception_name(exception_type),
 				access_type, access_type_name(pfdev, fault_status),
 				source_id);
+			panfrost_mmu_report_fault_bos(pfdev, as, addr);
 
 			spin_lock(&pfdev->as_lock);
 			/* Ignore MMU interrupts on this AS until it's been

-- 
2.55.0


