Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D86606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMQsHFl8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCEEF112303;
	Fri, 13 Nov 2026 09:03:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B433210FE76
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:03:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1E4146643;
 Fri, 13 Nov 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560578;
 b=MYBvUjhIqov9wYNQPI5n5uNjFwAMETO0at1x76lLqpCSUqX3A5VovMeTtjyMpwloX1x3
 EW9BT3fwLhQst84+XB8b3UoLNMjgcllZbb1f6bMovJNA7inJYL9Ics0o/uZghTcLaNeH6
 5/JyRvD5pgpNs6iEldf5ROBfqYkNwsMVH7gVv2rMhKKhGHwf/2aQX+N7rnhQxVypnj3DM
 L0ypEH3oPuKGc/FEmta8jwlFXsCcpVqQMg+GIl73JL/oMOK9fzBpZL9W6SWQr63mBLNfI
 bgZYG5z6RcMh2V034w3ljGVVXIBVZf0rpgKbjHGLe/nOj8TWtyx76iheEawVvK66Aug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560578;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=qKQbIBQVkuBmzobAegRbv3RcqSfYgh1xoUFQCM/sy4Y=;
 b=ogI8gC1fWUpGIo5JVwVJZJyJoGVwlES3pq/6XAf3r7K2tv5/gmIS2/HNz9XXHoePHfne
 uXrzRygw7ryazmF+1jyXmyvtVkrpXWVSiqVV+6dVbWMKPqqvlrL+9hvE3la3rVufGSCge
 CIw0L0gJU8NiwdWd7W6J5j6pX5/61pwfWz0tKY/NyFzZ80EX1PtuTPwXizL4F8i3ycUwc
 PmqQ7zbdFc2YJipdjv19n+lWOEOIaE6fY7P4q/wFSkrUg9NOIyrxLgBpHZ43R6VH+NLcM
 DVpe+Z6zuf8zIwfyakgnO/irD4wA8HkCHuVa7NsNAiaVPWyuYIDwRm/irUjZ0ANytIA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F3E941F00925;
 Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560578;
 bh=qKQbIBQVkuBmzobAegRbv3RcqSfYgh1xoUFQCM/sy4Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=QMQsHFl88Fzdxxe0NAOWdq7uuFEGhbp0qOx2dxrQe0BxR36GSGLMA8udOQQ19U9n6
 mREz5m2hHbpRXSU+f+DaA0PyuPCNiYUxJ6azqmhNx4gY+76ijGx46cJHS4AQifTZp3
 ysgrGyUOFjO42LtKP4vRG5GrbPwSEDegSS73T5INMgshJs9C3vl7468simDdN5kleG
 LtzJFBMfK1DI/LxAupHIHB/4lmi7fVpxNkWCYR0yVA+d6+D/4xVCy7BJ6RB2izQ22V
 H3So5X2i8Ynfz/Kq9UK3FJ7KxwVMHsjZm1EX1Z0Kv35fgP7ZQ2sUVc9DPL09M3xr9C
 zprRz0+EYD4oQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DE8494770A;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:03:06 +0000
Subject: [PATCH v3 14/14] drm/panfrost: Name the BOs around an unhandled
 page fault
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-14-80ae78d38f6e@gmail.com>
References: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
In-Reply-To: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=4678;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=d/aq5E7s0lLnKK4oq+vNSf9/KY6xDmq3f+c+8fC2zVE=;
 b=a4sXLSUioChd74Dl/jK6+02bY2FhkTFPB4eqbLD788envSDCFkMB/rkxAfTPOWCFVqd0FcDG6
 phWxHkE/sWpAozz9bRt0Q/4Gl2lUHf5L6NyTKh3QU7JlKvQbTB7EALo
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

An unhandled GPU page fault reports only the faulting VA, which does not
tell an access just past the end of a buffer from a stale or garbage
pointer.

Also print the BO that contains the address, or else the nearest BO
below and above it: VA range, size, distance of the fault from it,
heap/noexec and the label userspace gave it (Mesa labels its BOs with
use, format and size). A freed BO has left the address space, so an
access to it shows up as a hole between its neighbours. Mappings whose
last reference is gone are skipped. For an OpenCL image read on a
Mali-G31 this gave (with an earlier version of this patch, which also
printed "mapped"):

  panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA 0x000000000A181000
  ...
  panfrost 1800000.gpu: fault bo: below: VA [0xa041000-0xa181000) size 0x140000, fault at end+0x0, mapped, noexec, label "Texture format=r32g32b32_sint extent=25x128x32 array_size=1 mip_count=0 samples=0 modifier=0x0"

that is, the texture unit reading past the end of a 96-bit-per-texel
texture, which userspace can avoid by padding such textures.

Heap growth faults are not affected.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 2cf67d932..29dd575f4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -594,6 +594,86 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
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
+ * Report the BO that contains an unhandled fault address, or else its nearest
+ * neighbours, to tell an overrun of a BO from a stale or garbage pointer.
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
+	/* The nodes are sorted by address. Skip mappings being freed. */
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
@@ -973,6 +1053,7 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
 				exception_type, panfrost_exception_name(exception_type),
 				access_type, access_type_name(pfdev, fault_status),
 				source_id);
+			panfrost_mmu_report_fault_bos(pfdev, as, addr);
 
 			spin_lock(&pfdev->as_lock);
 			/* Ignore MMU interrupts on this AS until it's been

-- 
2.55.0


