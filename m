Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3F60A381B
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6hlp7rF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D7A112247;
	Thu, 26 Nov 2026 09:37:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D8A112248
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AEC6611A0;
 Thu, 26 Nov 2026 09:37:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685847;
 b=yl6B4hv+ZlmW/bHm5Ga9xeZwLydKmgKDX1cWmuYOfTe44W/TT22oSlFdSs/BBCchh6gv
 6zcK/HY8igmojcBW07wdo4SpYmmfJO3sa/RjfWHV5IoD6KaDDRkNBzkEv3PwYRxahMTC8
 s5jsKSCNb5+coDCb1vy14c6gI0A4Fy7ht+NkHs+y+YxmCGx6PGXwIE1p1DYxdGYzxBZYb
 LOAiCDPs8DJuAtn8tH9O+R7fsNeBd/3XBMnzmVIUmN/TR8eB/X8OTs7j93LzKnMipWZiK
 6G/MMyG1BrQlzis7JqNJsRDjrWHDD64K1o7v7dEf5GxtNP68PywYgZr3CQyywIRY4Ag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685847;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Ku8Lde1pTwJvjjDGXTmZ0bVu/ruUS4L3CLcssOQUhrc=;
 b=ad8nXwJOvhP+pa0dKCBIHHKiGbRUJhsAyyd8wRP59/fXrbP4S5JJJdQ+sh+xN24e7EWR
 HXo8tvn+L00bje3bc9MliOPuKsB7v+odzS8LnZf++/fpyPCYTid9MLHAgpoDgUzFE//u5
 RQOI7xW11WhaOdJk+hGSvkYbrdbHd0nXyvCV3CTDHvlrjKF1qdy34DZ9PqM4Ouajgx7h6
 zhdRQpNnNzhmDpnMt4iC3fV6nuLEd8jT6qMrskZydNrQL+JvlKwQMfYZla73vaLP7cYoB
 IjI1er2fdN3PMzKc1/vYkpaldc03qsjn/SUnqSQtUwXLiIvipggAgfYqPAWN3EyP6pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D78311F000D8;
 Thu, 26 Nov 2026 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685847;
 bh=Ku8Lde1pTwJvjjDGXTmZ0bVu/ruUS4L3CLcssOQUhrc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=j6hlp7rFbwniThRGlwbWN5C8nxR2MVYf/YzfZ2TIlH5C0zoW9x7iod0daD/1+OPHQ
 UwS3NqyRk49IhQPFHFaCvGgJyWZMAfWesoma3UF8/2JBwrVxAOPoY2E1SNN8D/O/IF
 Vep/wYtRUpoLlHqyrfTNvK2YCW8xAYFmVXCQWFJfoYX0577Qd+9NKo40qhVN3NJ8WJ
 NjkWdgxwa4+ENcauP/GuIslvIedcgxQcmXKq4KfDmLIUl1qjs4E7MustKiUkCSyj4N
 ELjrwwLKfkPVmR4dmnIdFTL8q88TA8v0W3hZwtqbOT90igVAtYV77lOSdx6ZZ4B61h
 MHFqwRAqUZhAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CA96D4D380;
 Thu, 26 Nov 2026 09:36:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:36:48 +0000
Subject: [PATCH v4 05/17] drm/panfrost: Don't WARN when a GEM mapping
 cannot get its pages
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-5-23579629ceca@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=937;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=hdFsu+ufPKv8in/ecsLdKRwpVjdp/Cx/nRmtEw1md78=;
 b=G9l9NCsTi3gdq3JOaw9J0+OtII0yATQmHqZRW+eGiZtaZKSFqJ2tBopqDpmyMmmn9VEN3QkRf
 GZU5txhwxirDppgwWJ7S/4TWOOUy93HUN/1QIzD2W/LtUbI9lkOT+Of
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

Failing at a memory cgroup limit is an ordinary error returned to
userspace. Drop the WARN_ON().

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
v4: shorter commit message.
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 789a64fd3..e70ae393e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -480,7 +480,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 		prot |= IOMMU_NOEXEC;
 
 	sgt = drm_gem_shmem_get_pages_sgt(shmem);
-	if (WARN_ON(IS_ERR(sgt)))
+	if (IS_ERR(sgt))
 		return PTR_ERR(sgt);
 
 	ret = mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,

-- 
2.55.0


