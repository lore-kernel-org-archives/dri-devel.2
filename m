Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8420C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C4210F213;
	Fri, 31 Jul 2026 11:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L6L9YNwf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277C610F213
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:10:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0774F4126C;
 Fri, 31 Jul 2026 11:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472491F00A3A;
 Fri, 31 Jul 2026 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785496255;
 bh=ytqivL4jFHX4nTrfGKiLg4ZD46ph+c7BxWubgoutGSs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L6L9YNwf7IOE8Y7SKl9wy9kaMf4ZUQ/idSSKCL0Umzqx/JlQG5XJ7htEIpx8SoJEg
 Bt1oCeplePQFH4WZgcdvIeY+aneSr+zcseRLt5PUaqwjyh/yRuVFqXYkKDCeRK0A98
 G+SzUQXDISUECxdL8diV56hVIFXnTgX8YFiXpnUk2jpIQH8A5H0X18Cd9Ht2f+jh1w
 oo0GGJswWKi465nW847qOrGH/DxelRnU4BEQeKo6f+UTFTtvAmtXoLAtdYIQX6Le6N
 j8hdPSugqQ94n++zcl2WjcfY7Y0WOGtbUyfjywj9jPK/rtZl/ew314pt817qRNigfK
 Ee0sNJJBGI1lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/tegra: fbdev: Remove offset into framebuffer
 memory
Date: Fri, 31 Jul 2026 07:10:52 -0400
Message-ID: <20260731111052.3596094-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731111052.3596094-1-sashal@kernel.org>
References: <2026072951-goofiness-shank-618d@gregkh>
 <20260731111052.3596094-1-sashal@kernel.org>
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

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit a18b6e30ecd69096beda4a0c96d2570900c3879a ]

The screen_buffer field in struct fb_info contains the kernel address
of the first byte of framebuffer memory. Do not add the display offset.
This offset only describes scrolling during scanout.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: de2ba664c30f ("gpu: host1x: drm: Add memory manager and fb")
Cc: dri-devel@lists.freedesktop.org
Cc: linux-tegra@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.10+
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20260421073646.144712-3-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/fbdev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index 43a504ad4f38..b7de5819029d 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -75,7 +75,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	struct fb_info *info = helper->info;
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct tegra_bo *bo;
 	size_t size;
 	int err;
@@ -112,9 +111,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -126,9 +122,9 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	}
 
 	info->flags |= FBINFO_VIRTFB;
-	info->screen_buffer = bo->vaddr + offset;
+	info->screen_buffer = bo->vaddr;
 	info->screen_size = size;
-	info->fix.smem_start = (unsigned long)(bo->iova + offset);
+	info->fix.smem_start = (unsigned long)(bo->iova);
 	info->fix.smem_len = size;
 
 	return 0;
-- 
2.53.0

