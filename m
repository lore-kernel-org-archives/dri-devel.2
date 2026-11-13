Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E6606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afiXnqPt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C391C11224D;
	Fri, 13 Nov 2026 09:03:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B611121A8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CD1446630;
 Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560576;
 b=cyPn7/fP+fB2vJ/mOrS5hHAVaEFGmDGPo+c6kXFsjtM9luBBZk9REeTpse4XrzU6Z2ik
 DBizdm2r8VWKSdIBNBr8YAJXPU1vBPgsNoTZeROxgdC+TyKOf4vHepsK41BTT23Ahc8RS
 +yNWV0d/aXLGqYOEvy/v8NRrAcD2jRFaxfLxdSQx+I0FMpmaRthRFAAPHVx6UGF5e/Czs
 rqXotpEVVp0EaKJ03+/ika1eCmfx5X+iyzNOnXegOp+sVM5W+hJDuiyQ5SAmbskXhK4IP
 yAlKrrdtFOlH+nGI5CYj7zu7Up7BtgqvIuQft8aerVdyyNotd4zII7iTvRl6cVbJG0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560576;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=1V9h+Zk2JXursouI9MpK2JJMP8iy0ZumgVOKr78+gRw=;
 b=h3gMIVSuJmD1WKdDigZi/Dz/Rr5VjM006g9QSYHtewFveiQ5+4mjLrq91AS+udB+9oPV
 SK1aVYByh/vxmTBECUPnEhkaQ+RQY/SrCu09NQu/T7HIKRzqY6f5Qsvi71JNfJZ5BV8WJ
 Fg4B4kI6PAJnR/FzMz1y/CZ9mR1VPQ7wKQ8ll6hRL5ONBCvY5yFwuyL4+SIqJhCKsHURp
 rRWrDNUYa1BYE3OgOyg+EGSq5nSOaJ1F8qifhszI0JY/GiodvgRfoHldmVercJJVeKrbO
 8i1XaZCK2PL/2pRNF1IRw+J6TFlmQnPfr9yo0D/qHLV2YoxMBJgUZ3ZswDpK//d0Aew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8BDAE1F000CE;
 Fri, 13 Nov 2026 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560576;
 bh=1V9h+Zk2JXursouI9MpK2JJMP8iy0ZumgVOKr78+gRw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=afiXnqPtegKGbPy/6jo0t+0a6K0yPjof9ZecrNUq0cujEShJ1lQN0ZkicUzK1QYPd
 GMCDvT7e9IwR8U18H9wqWGzh01oTRkLSLeJPRL/cUleL0N9+oBU7quS4tyRN22PH59
 cQBxMEQgziEVrPxIMyVjp7ibAw1va0djSK8xwFcwW6NTKV1S432SrwBmi++TVH8LaE
 11ZVtWtf4Lg4IyT0QlksKAJmInHyY+/QC2M7JghP1mrW0ApSF1/INm9AnWF8JW0phY
 uvYi5UUOP3WmtSbv3JhP3S60+CQBffx9kqV+7VDqHe6+Gg5CKmZjilYaq1RmOg58Lf
 Rxr3XjvpcHHJA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2C7FC476E6;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:02:57 +0000
Subject: [PATCH v3 05/14] drm/panfrost: Unwind a failed GPU mapping without
 dropping its pages
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-5-80ae78d38f6e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=2634;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=LXM9VChP6RJ9mS+vj0CLjtPS49692Z/f9+u89B3GkZA=;
 b=MqoXiCgstl33RWQ2qXYpmFv+GQxEShO1FeDlRNYIrvTk38M20DjyVj8zr8v/J2d4I6jIXrtsL
 PYLsx8KCUG8ATmv4YT6VwybdXLGrW97TP4ti2m8MyyYvla0e1/b1EtN
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

Two error paths of a BO mapping leave wrong state behind when an
allocation fails part-way (memory cgroup limit, io-pgtable out of
memory):

- When mmu_map_sg() fails, panfrost_mmu_map() calls
  drm_gem_shmem_put_pages_locked(), without the reservation lock it
  asserts. The only page reference drm_gem_shmem_get_pages_sgt() took
  belongs to the sg table cached in shmem->sgt, so this drops pages that
  shmem->sgt still maps (for an imported BO it underflows
  pages_use_count). Keep the pages and return the error.

- When ops->map_pages() fails, mmu_map_sg() does not unmap what the
  failing call itself had mapped (reported in @mapped). Those PTEs stay
  in a VA range that drm_mm hands out again. Unmap that part too, and
  flush the unmapped range.

Fixes: 4da352cf8fb1 ("drm/panfrost: Handle page mapping failure")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 74fd159de..efa4a3bb1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -442,8 +442,11 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 
 			ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
 				       GFP_KERNEL, &mapped);
-			if (ret)
+			if (ret) {
+				/* Unwind the pages this call mapped too. */
+				total_mapped += mapped;
 				goto err_unmap_pages;
+			}
 
 			/* Don't get stuck if things have gone wrong */
 			mapped = max(mapped, pgsize);
@@ -459,7 +462,10 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 	return 0;
 
 err_unmap_pages:
-	mmu_unmap_range(mmu, start_iova, total_mapped);
+	if (total_mapped) {
+		mmu_unmap_range(mmu, start_iova, total_mapped);
+		panfrost_mmu_flush_range(pfdev, mmu, start_iova, total_mapped);
+	}
 	return ret;
 }
 
@@ -483,18 +489,15 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	if (IS_ERR(sgt))
 		return PTR_ERR(sgt);
 
+	/* On failure keep the pages: shmem->sgt holds their only reference. */
 	ret = mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
 			 prot, sgt);
 	if (ret)
-		goto err_put_pages;
+		return ret;
 
 	mapping->active = true;
 
 	return 0;
-
-err_put_pages:
-	drm_gem_shmem_put_pages_locked(shmem);
-	return ret;
 }
 
 void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)

-- 
2.55.0


