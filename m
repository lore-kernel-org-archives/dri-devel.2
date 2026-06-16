Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A46CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699DB10EC14;
	Tue, 16 Jun 2026 14:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="X4coiT7B";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E798E10EC14
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 14:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781621221; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DNVmsKpeTIy+wSI0pgrLE93ZrZuNOCwGbM9rpgAJJ48YUK0mJgWLomGFOepkDYKjVZBnyUirtYEN7IDjyri+LGK/ecNL+JPizaRGK5jwuUP+Mf2AfKonDCHuT+GY9wyMyhnyBiExksM7QgVu5FfU3L8kEZBCeXoWgw4I8JkMGEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781621221;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=v4LrMqhbvgPFkFsGK10X4Qkdp/LjJ86FBm6U+s+d58A=; 
 b=L3h8ffO85sn18KoaxLV6e6kMuHudQdaTHi9TH9oRamrf/N8aw3lFOGAqu/41N9IT9kkmZM5WIgLJWUtOqXA4N0Bb3SQDqSG7qL4CkcBFv5x1aTGjtVEgRWHjAIEi1C5J6xWlDZ14feAfztlPHyurVrLzc7p2Vc6A6CsaLIkAx3Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781621221; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=v4LrMqhbvgPFkFsGK10X4Qkdp/LjJ86FBm6U+s+d58A=;
 b=X4coiT7BxY4op2AKVeke3SRavK4R6+UrGsHbsjjhHGmu2BfYTU1iIFqLiKeyKcxw
 XY8smoa+GHDi+50W5eUqHlTbh12oNkKg90N0bWMDlRCTpLggna54BV3pmXwrv/lUL/B
 Qgp+ywP9+PUnAOEETywipjDgH+/F3MQiKGCjV4js=
Received: by mx.zohomail.com with SMTPS id 1781621220921446.4987902370344;
 Tue, 16 Jun 2026 07:47:00 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 16 Jun 2026 15:46:44 +0100
Subject: [PATCH 2/2] drm/panthor: Fix comment to reflect actual struct
 field name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-vm_bind_checks-v1-2-956198602ae3@collabora.com>
References: <20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com>
In-Reply-To: <20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=803;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ydrCe52eIu8cUQMCYgJXnybsTahH4KMgHzemZvmGz2M=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqMWHcGYajsY3zEoZMSrHl18ptcrTZV7kyG1deC
 rSEavD1WP+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajFh3AAKCRAOJn5M7lND
 PS/JC/9Oxus+v/mG5e1CyTRsv8vfSqlDp+h6CsKuL5wGn1onZVWyD2hhieUbwrrthTuiJhylVTs
 nhJOLfKdTBuilaLt/pz6J0MwA2n+vLz4N2ohTAS5BGFsZbwAs20uKDPNYabFz9vPasquG/jZLkj
 OAdqZYgh6zAIHtthS6Sk1DQJGvxRrBQhALAG1VI/F1YwoD7YBZfjUsuI2z+eMKdMFFKHHIZNJ9t
 IHVO6KWNmCnmYzctwfTvljjXeYrr2ssaB9F6ETy+iRuEMjy0M9tZIWBcz8FQX2hdt2B7xSK0Oyl
 7kYMYUmHsKjukiREtYDRJ2MoNW+ZqoXSL2WdBp5l9zsDvOEobS09lak00bohULNDZjkV5mMV8Gs
 ucq3+glf3Pe5mp61QwpXtW0dt4IMFckbjS4QrB9dZwgdSwTYw0BMUqcVHnEL9pMm1pwQowlOZsm
 gKm74rN/kqVEnewlLjpk8hxU7g0g94G6NtF+LOP7jICu75GGjweYPj3MJ6jPBBNewybds=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

The mismatch would pop up when building the kernel with W=1.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 5625f3d34031..ab7a1698c327 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -315,7 +315,7 @@ struct panthor_vm {
 		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel BOs. */
 		u64 start;
 
-		/** @kernel_auto_va.size: Size of the automatic VA-range for kernel BOs. */
+		/** @kernel_auto_va.end: End of the automatic VA-range for kernel BOs. */
 		u64 end;
 	} kernel_auto_va;
 

-- 
2.54.0

