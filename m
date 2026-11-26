Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2A606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjNN/EYl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C3E112249;
	Thu, 26 Nov 2026 09:37:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C1E112248
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D504413DD;
 Thu, 26 Nov 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685858;
 b=oDSaY1A0RL6nOHOJtlpUo3h/U1lU3wcuc56ktY6lYBWYb0Mui++gCltlIyRH7oKoKlkZ
 U2HINJwlqwV32lYismd9uCEnNqcKeGXsvF2MHeSsk0Eoa8AV6yUotl9335k1gztFz8Vnm
 SEmMlTOJzx3J9sTTXGC+CK3rWj816aUkVebvkkdg++ZIF+YamQtoWDEAjQsecA0HCr8GL
 u9QxxoTArdFZbbFcW/i8F98oCdMg3kh1ImWF1xY1Yaejsysh6PGYO9ITBFeYEO8cTC8Kv
 RReL5u7/wChlKWyCkXtJJevm7nwwd5wXNY7AWu8qBaNsRPJ0H0xci3yTiETWzm4Gtjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685858;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=tGnTiWlCRmiSff2N/n/FoqfL2LYbJESkUupzqrlMD2c=;
 b=MkNHYjHjyPQl73hwXhSS/kOrLrFWAoNbRLricZVL9MkrIGPWtedyWfgsnEqe7GEd6C4Y
 O3PrhD0wO6iTs2dV1reWwdNp/Qjb64xUJIfpOFJYSagTiXQkpeAwDrpn3d++t6ecQ7U9F
 w+jire15OgcTkcJ0L/NQUm8PSSqeOGeOKwqmtNIVffD9MFvNkfgHOPVhXn69j5R3arNoS
 8XRHT4XNqo2/HSzIrPrdLQ26e73d+i3sqkjN5Kf9vJ3/VfpPn3swAtTO0/wLcgfPaomP/
 G4rGPvEZhM+tr3FkDvISXbAbboUUY52rPxWrrFyb4CdzmdRvG/dqBUNqgdRB3qJniEA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 16D081F000D2;
 Thu, 26 Nov 2026 09:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685858;
 bh=tGnTiWlCRmiSff2N/n/FoqfL2LYbJESkUupzqrlMD2c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XjNN/EYlhUFuu2JNeQZf9MVgNogUbET0eZ3HW07CB10YhExjoTIDcsyqgIyR81gYv
 jdukxdTw15uYPoe0pxlWKyPztFbv3+9vbAWvbPDl/sIEpigzzWfYeok4UkCRFvnlw7
 AsZF+FH9v2CGk7PdPZvTwaTQE858dDFKq0sYX63K0H/HQzaSOQVriA0q8FtD5dUrUm
 Nl3TECli5Fw4v56HXpj+O5Fdz/3Xa/BDGm+cSBIzeZWx/tHwzMczGupkbP1bQInJvk
 BdIkJFV3WsAnVEcnNQhEoucUdXQ95lDybewHSfTCdAiBkfvG3k/BLL0FF/x8zEJd6K
 QSb5ResYzSKyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5F4E44D3B0;
 Thu, 26 Nov 2026 09:36:49 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:37:00 +0000
Subject: [PATCH v4 17/17] drm/panfrost: Name the BOs around an unhandled
 page fault
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-17-23579629ceca@gmail.com>
References: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
In-Reply-To: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=3787;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=5eVur+mtkqF3KeuduvBSAt8Mmx9XxQ3xEdEtH3eF7lE=;
 b=6DgG0L6amlfQCNH71sbOl9d0AKUzh0BVys1PGlJVDOixRBgplaFV6tjDYiJblGrGFllDlxT86
 JPnWRYDVZiPCdQrhAB5JUj2M/WNEWAEHvPrL0kCvK94D/7Bhme7j7Fm
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

An unhandled GPU page fault reports only the VA, which does not tell
an overrun of a BO from a stale or garbage pointer. Also print the BO
that contains the address, or else its nearest neighbours: VA range,
size, distance, heap/noexec and the userspace label. For an OpenCL
image read on a Mali-G31 it showed the texture unit reading past the
end of a 96-bit-per-texel texture. Heap growth faults are not
affected.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 76 +++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 92a4d2963..0f81fee10 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -590,6 +590,81 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
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
 
 /* [start, end) is whole folios: it can reach past the 2 MB chunk. */
@@ -964,6 +1039,7 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
 				exception_type, panfrost_exception_name(exception_type),
 				access_type, access_type_name(pfdev, fault_status),
 				source_id);
+			panfrost_mmu_report_fault_bos(pfdev, as, addr);
 
 			spin_lock(&pfdev->as_lock);
 			/* Ignore MMU interrupts on this AS until it's been

-- 
2.55.0


