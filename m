Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1969AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7343F10E86C;
	Mon, 13 Jul 2026 08:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Cll6MP5Y";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D45310E874
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783932515; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MVzIV4QN9NDqYnKD4U8SZOTM9SdeCGFt7akyALo3n7muIXawWdWzOzA9QeqGtqpv+sUciM4uzfPZDnFnqqvi2ICWrZlIgAvLaZmmYszSY+tH4EhDSHmiSg7vd2QMCIGalLSE5VsOTNYJ36X41i9r4vK3btcjBSIR3+qSuwUEc40=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783932515;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=N7iewPjkHa2lzcM2bUa0ln2fPA7zBKsXhmZFv/CazSM=; 
 b=jq9QkKakOUjWtZQ1W1SVIdh1kbmuBF2Jd4eRnd7PYXSTVOa6SVSk+Ht4be9STVzt/kQmLyaTh1OsOadFFZhvcp/Py0m4Q2y2ImbytIEn1RVLOSO2C1NBPChf/YVg2e1gmcGM6GGJ3Q01dyOzOzMewgttHRKYMKcrrhWwGdKSee4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783932515; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=N7iewPjkHa2lzcM2bUa0ln2fPA7zBKsXhmZFv/CazSM=;
 b=Cll6MP5YxVsUNxiJAB/dg4LcnztvKIylGBtWI3sZV5gEoxoTHDIJFakqPfgkhdIU
 H7Gg/hRyopoIG+pxJeD41UWZm2yJ99XOLO6lnE8RO4c5SIYXmE/zOi7tJPljmrv9D7G
 4O3ZoLTzEOYRb6PuEaj4o6T8uBFxctFVp/l3GnHY=
Received: by mx.zohomail.com with SMTPS id 1783932514021728.729462264637;
 Mon, 13 Jul 2026 01:48:34 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 13 Jul 2026 09:48:02 +0100
Subject: [PATCH v5 2/2] drm/panthor: Fix comment to reflect actual struct
 field name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260713-vm_bind_checks-v5-2-0d2314af8d9d@collabora.com>
References: <20260713-vm_bind_checks-v5-0-0d2314af8d9d@collabora.com>
In-Reply-To: <20260713-vm_bind_checks-v5-0-0d2314af8d9d@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=hzKj7z3DP+wCsFmaomdGk3tPMuXAxzI9wnMKkmjOfyE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqVKZTn43rS723wfi6Dn5PC5gGCIlvy58FYb6NH
 +Frtsv3j+yJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCalSmUwAKCRAOJn5M7lND
 PQzsC/9oRiXVbDVHylSRHFYHpB5ysJ6TcAVGrfwtnMeqFo1LZEf5zkxU01A3bvX3coQFrcfN1Rj
 dqn4qpzGaYYSlWGC5nLKmcrOoaT76QywjS3Tgu1/S1WojWQ0vlntwPZuoaFl5OpAmS6QDBQBu4Y
 ZWIkqwS+SiGnGtGxw6LDcpL9qSFsfcjWizK4H+NIZshbIYmpmWPaiAo+ID6BIPHwFfA1QO6mE8q
 z4End6Q7rT5eLNeDHHo/7TVB3WGYoVlQgpcvu3cFgWEjUqclB88YUf8Ka97mNcY2i61A+QWymwW
 DW2J7P76b6UhlwGWwE9euBAvxps2Lba/fYn9qwY+JrxUXZMrby69h+1aRXgJhBkO7X/h+KznYge
 S1G0LJlVel5FX6AH4utYaXt07qgNtiAcb2so4+Gmy5mOLu7EAA+4+1DYz8d2kFb1wFDb+meL2MN
 oT+XdIGXLCFioVf+qvySSI392LE7lBKZ3xlOMiemg8WaCse1MTteB1VLjP1ULpF2Px8dQ=
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 910c8e579770..3a1b7dcaaf91 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -306,7 +306,7 @@ struct panthor_vm {
 		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel BOs. */
 		u64 start;
 
-		/** @kernel_auto_va.size: Size of the automatic VA-range for kernel BOs. */
+		/** @kernel_auto_va.end: End of the automatic VA-range for kernel BOs. */
 		u64 end;
 	} kernel_auto_va;
 

-- 
2.55.0

