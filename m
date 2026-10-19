Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BF606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EQB7szLg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBDB10F2E4;
	Tue, 20 Oct 2026 07:36:27 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7421710E0B1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wi
 SgM3R8DltnKlDzzq9tlD8y5p7AFM+owbcZ0ZWu3QY=; b=EQB7szLgTbN//+NwUS
 c8q6q/m/FZn8ajNiWgUXAckWVsse7PYoHse542HImhUTVd+ApBmAetAsooz9dq5Z
 XJea61dXJ73X4NIrS2db8GbtfLBBHndGKDqYpozzUQ2OAzd6J1j1c7XlE+CNGRcv
 PDrIrngDu11I9hh7CZpGJvDks=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDnt9ng19VqcQOlAw--.9091S7; 
 Mon, 19 Oct 2026 16:42:18 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, David Rheinsberg <david@readahead.eu>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 5/6] drm/ttm: reject empty range manager sizes
Date: Mon, 19 Oct 2026 16:41:37 +0800
Message-Id: <20261019084138.1821477-6-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019084138.1821477-1-yaojiale02@163.com>
References: <20261019084138.1821477-1-yaojiale02@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnt9ng19VqcQOlAw--.9091S7
X-Coremail-Antispam: 1Uf129KBjvdXoWruw48Wr4UCw48tw1kuFWkXrb_yoWfXFc_u3
 y8Xrn7WrW3G3sxAF1DAw1fZFyaya15uayvvw1Fqasxtr98Z348X3429r97XrykX3W7GF98
 uan8tw1rtr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt5l1tUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wpAemrV1+o3BAAA3u
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

A zero page count reaches drm_mm_init() and causes its zero-range BUG
check to fire. Return an error before allocating and installing the
range manager.

Fixes: 77ef8bbc87be ("drm: make drm_mm_init() return void")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/ttm/ttm_range_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c b/drivers/gpu/drm/ttm/ttm_range_manager.c
index b818836f0726..5fd484ae1706 100644
--- a/drivers/gpu/drm/ttm/ttm_range_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
@@ -184,6 +184,9 @@ int ttm_range_man_init_nocheck(struct ttm_device *bdev,
 	struct ttm_resource_manager *man;
 	struct ttm_range_manager *rman;
 
+	if (!p_size)
+		return -EINVAL;
+
 	rman = kzalloc_obj(*rman);
 	if (!rman)
 		return -ENOMEM;
-- 
2.34.1

