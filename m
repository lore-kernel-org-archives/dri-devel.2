Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837D606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mHcNn0J8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E34110F2F7;
	Tue, 20 Oct 2026 07:36:32 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD8710E88E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Nu
 0yQN7bhLhr8bDqdr0q6HH12zA2QVcA+U6iZqh2KIw=; b=mHcNn0J8DjY6J6LhIo
 J/CAkIMpmbvADsjUthx34hFLFsqQIS542R07Puek3+nFCpuOJDRWROA4Xpr4W8Ez
 0tldTLOTTFuCC7giXI+aFGdhVPlurkGLSWbPqYZkGZt1taEYkvhc15jrj6/zBSm0
 ybbfQ9pbV53YR0Xepr/QotIEc=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDnt9ng19VqcQOlAw--.9091S8; 
 Mon, 19 Oct 2026 16:42:19 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 6/6] drm/vmwgfx: reject empty VRAM ranges
Date: Mon, 19 Oct 2026 16:41:38 +0800
Message-Id: <20261019084138.1821477-7-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019084138.1821477-1-yaojiale02@163.com>
References: <20261019084138.1821477-1-yaojiale02@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnt9ng19VqcQOlAw--.9091S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW8Xr1kuw4DArWxKw1xKrg_yoWDKFg_ua
 y0yrn7XF4UuFn8u3ZFk34fZFyaya1kuFs5Zw4fta45t3ZrtryxWryjgr97X348Gw13Ca4k
 ur45Gw4ftFsrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi9YFtUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wtAemrV1+s3GQAA3z
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A VRAM size smaller than a page becomes a zero-page TTM range and
causes drm_mm_init() to hit its zero-range BUG check. Reject such a
range before creating the VRAM manager.

Fixes: 37205891d84f ("drm/ttm: make ttm_range_man_init/takedown take type + args")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 0f101aedb49a..33284a776fa6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -692,6 +692,10 @@ static int vmw_dma_masks(struct vmw_private *dev_priv)
 static int vmw_vram_manager_init(struct vmw_private *dev_priv)
 {
 	int ret;
+
+	if (dev_priv->vram_size < PAGE_SIZE)
+		return -EINVAL;
+
 	ret = ttm_range_man_init(&dev_priv->bdev, TTM_PL_VRAM, false,
 				 dev_priv->vram_size >> PAGE_SHIFT);
 	ttm_resource_manager_set_used(ttm_manager_type(&dev_priv->bdev, TTM_PL_VRAM), false);
-- 
2.34.1

