Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A38CD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9472710E620;
	Sun, 10 May 2026 10:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="mrLFWYjO";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C559010E09C
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-ID:Date; bh=a83z96YzJ75nDxqS/kiW5XrSRi2azphYRz9D6P97XTQ=;
 b=mrLFWYjOEX+PRjQzFqbHTg95cG39sKhnMFH3jGw4+8sCzT1PfZd+nq7k032pvs
 /nXfg3scgpoKoEsy4wwCiA5J3Ov+FQ7OPZ9GKyhDPrRW8+eoPd/3hjTbJqAviycu
 uCoGI9ne/ZaouwjhxJmyVIOVHDzebR2d1nX8bSwAXCMi4=
Received: from [127.0.1.1] (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXn6Nx8f5pDQlyAQ--.724S2;
 Sat, 09 May 2026 16:33:53 +0800 (CST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Jiaqi <shijiaqi_develop@163.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] drm/rockchip: Fix vmap address caching in
 rockchip_gem_prime_vmap()
Message-ID: <177831563268.322716.16290375245774379615@163.com>
Date: Sat, 09 May 2026 16:33:52 +0800
In-Reply-To: <177831560568.322716.7926332149561323511@163.com>
References: <177831560568.322716.7926332149561323511@163.com>
X-CM-TRANSID: _____wDXn6Nx8f5pDQlyAQ--.724S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1Dtr18uw15CrW5Gw1UAwb_yoW8GF1xpa
 9xu39IyrW8GrWjqrsrXFnrA3ZxK3Wv9ayxGryfKanI93WxWF9Ikr12kFyDJFZrJrsrCFWa
 qr4kA345ZrsFvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUgA7UUUUU=
X-Originating-IP: [42.63.126.112]
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbC7xGyBmn+8XFj8QAA3P
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

In rockchip_gem_prime_vmap(), when rk_obj->kvaddr is NULL, a new
vmap() is performed but the resulting virtual address is only stored in
the local variable 'vaddr', not saved to rk_obj->kvaddr.

This causes three problems:
1. Every subsequent prime_vmap call re-maps the same pages, wasting
   kernel virtual address space and TLB resources.
2. If the gem object is freed before prime_vunmap is called (e.g., in
   an error path), rockchip_gem_free_iommu() calls vunmap(rk_obj->kvaddr)
   which is NULL, so the prime_vmap-created mapping is never freed.
3. Multiple concurrent mappings of the same object cannot be tracked.

Fix by saving the newly vmap()'d address to rk_obj->kvaddr so it can
be reused and properly cleaned up.

Signed-off-by: Jiaqi <shijiaqi_develop@163.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 8afabe2118a9..1234567890ab 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -520,6 +520,7 @@ int rockchip_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 		if (!vaddr)
 			return -ENOMEM;
 		iosys_map_set_vaddr(map, vaddr);
+		rk_obj->kvaddr = vaddr;
 		return 0;
 	}

--
2.40.0

