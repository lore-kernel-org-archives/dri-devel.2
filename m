Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753E6073C42
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msmgCSss
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971E110EE6E;
	Tue, 10 Nov 2026 07:45:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9787D10E944
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:44:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BB4C63785;
 Tue, 10 Nov 2026 07:44:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794296698;
 b=TjtTABtDXzTXIbk4qx0uCrRIkc2m7K7y0DM4vUNwPWSbZHxHt+tgAmfbN4t7NGPHuYR/
 likfelH0tTa1Anaqg9EqGB61Go5IiGh4iuKI3mzldcoxvFF2boIs/z2oqMqUIdt8oK9O4
 zeG/SV61ALZz6+SOMqne/nZXZPV+ugH0vxBe195FDaz6CAxjeIiK8xzEgo+AbGQbO+y43
 vPnDUfmVmhQswWcJjs/6GygFJy+iuX+WPgFjY/YxBsp+BJ7SX4W0en+79AQK0Fm7QDp/8
 t4kd027DiIE906FYjBDsiXLwzK5Xra303dnS+BQS89GLrQKb+prIV2T8lKyO73g9KaA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794296698;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9XrgnRTD0mDuOgnf+3Az2+jSdGZPjgVozgVIVDYQPbw=;
 b=xWcXezitloQyiKdmhj6zHXwCmb+OSz/xoviblI0Gqigo5Fg5wFcERDBiRx4Fs4esjUpA
 5ctaXD2Bx0/KVa7ZecwCxphb5pZs5OKnZY1E8tfyjGUJAAaGUzFqV+856kivKu6mv7ong
 IgJAGYYJEiR45zPoR/46x07hRApyvhipgS6GbNy1yo3PK+y1Lb4ew632GOHkZso5R0h3I
 GWImetTqiZaVWpI+n/jKs3qhu4Mvzz/Ie5R6InwAfsrHTLAKUrLh92Fm1klgFg6jboOI2
 WZU2wJJvuQerUmzKgwvGzpDBKy49l55Rn+lFOj2BKGR8SjCjES39PYXm80XdoZ7JQWQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C43F61F00902;
 Tue, 10 Nov 2026 07:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794296698;
 bh=9XrgnRTD0mDuOgnf+3Az2+jSdGZPjgVozgVIVDYQPbw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=msmgCSssLCDrhhBmk9LWr1wm6jV0ScnTwkP3s9Zor+MqLNyPERG66L8w40yEKc1vq
 aQvESI5mw/Kw2gzVfPFzFI7o5MLzak3pOB51xAsBGVrkce4NoI9aN1DOuqdWWhyvdp
 rw94KXDLHGmQOncg9rvERF8qVpqL7CucuRay6Ym0IhRc0u1KgU4tkaVStewzqUR1tn
 cdAClScDRRp3LVqlDy6HlKHYRvh++VSy6oTaGL3VOvnfzYgzaQD3QVt89h5132wHrX
 tCiIyutJgJIy+1jyOe1DI4t+Kzy/h8nMNK5YoRG7rlr86mQrdkOfe7GdyaMS50z9GD
 bv53CFNNrRmog==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 496F148A12;
 Tue, 10 Nov 2026 07:44:56 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:44:57 +0000
Subject: [PATCH 2/7] drm/panfrost: Unwind a failed GPU mapping without
 dropping its pages
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-panfrost-long-jobs-v1-2-24508939ae8d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794296695; l=3059;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=qcEQM5Zp3QQH8GD0avsBqzcMV8oVI5whRT62sutCDKg=;
 b=qEPahRwq3Y/E+KqON/OMdJdyJiT6QIWrmpoRrXdVbsvrXDHuOTO1RcBO7013GP71aZNpSP7lL
 RMD83IWZfXIAwRDCzvIViXugaUjl6GgOPsqLn/F6x+R0G7ii9VnH1Qv
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

Two error paths of a BO mapping leave the wrong state behind when an
allocation fails part-way (memory cgroup at its limit, io-pgtable
running out of memory):

- When mmu_map_sg() fails, panfrost_mmu_map() calls
  drm_gem_shmem_put_pages_locked(). The only page reference
  drm_gem_shmem_get_pages_sgt() took belongs to the sg table cached in
  shmem->sgt, which the object releases when it is freed, so this drops
  pages that shmem->sgt still maps (for an imported BO it underflows
  pages_use_count). It also runs without the reservation lock that
  helper asserts. Keep the pages and just return the error.

- When ops->map_pages() fails, mmu_map_sg() unmaps what the earlier
  calls mapped, but not the part the failing call itself had mapped
  before it failed (map_pages() reports it in @mapped). Those PTEs stay
  behind in a VA range that drm_mm hands out again, and the next mapping
  there finds them. Unmap that part too, and flush the unmapped range.

Fixes: 4da352cf8fb1 ("drm/panfrost: Handle page mapping failure")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 56e642f73..ba37da499 100644
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
 
@@ -483,18 +489,20 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	if (IS_ERR(sgt))
 		return PTR_ERR(sgt);
 
+	/*
+	 * On failure keep the pages: the sg table cached in the shmem object
+	 * owns the only page reference drm_gem_shmem_get_pages_sgt() took,
+	 * and the object frees both. Dropping it here (without the reservation
+	 * lock) released pages that shmem->sgt still maps.
+	 */
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


