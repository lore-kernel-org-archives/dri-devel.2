Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E5606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=W+SsKTAA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DBC10F31E;
	Tue, 20 Oct 2026 07:36:56 +0000 (UTC)
Received: from proxy25212.mail.163.com (proxy25212.mail.163.com
 [103.129.252.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1256010E0B1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wh
 cwWcGUKRfvtRwNpcj2S48Yg35okxV42v9ufuqcUeM=; b=W+SsKTAAxDCRa/2MyW
 7zwswFvwlpPCDRlltEZ6E+KT3p5mq8UV4sv+a4IF2KMh5C+zcUmpysq+ubRRPi3J
 iL3hGfLCqIJFXAGLjmHqL4FxmxdDIzbKa47RmRvysgh7NA4n0oa/lrTrfpGao2U6
 n1EYUuUgdyKUVkGdCIUqmVwmM=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDnt9ng19VqcQOlAw--.9091S4; 
 Mon, 19 Oct 2026 16:42:15 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 Dave Airlie <airlied@redhat.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 2/6] drm/nouveau: reject empty VRAM ranges
Date: Mon, 19 Oct 2026 16:41:34 +0800
Message-Id: <20261019084138.1821477-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019084138.1821477-1-yaojiale02@163.com>
References: <20261019084138.1821477-1-yaojiale02@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnt9ng19VqcQOlAw--.9091S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUZw17Xr1kArW3ZF18Xwb_yoWDXFc_CF
 4xXFn3Gr1kKrWDtw4DAr43XFW2ka1UWF40vrs2qasxtry7XrySg347Xr1fXrykC3WIgFZ5
 G3Z0van5KFnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJManUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgc-eWrV1+czqwAA3Y
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A VRAM range smaller than a page becomes a zero-page TTM range and
causes drm_mm_init() to hit its zero-range BUG check. Reject it before
creating the VRAM manager.

Fixes: 37205891d84f ("drm/ttm: make ttm_range_man_init/takedown take type + args")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/nouveau/nouveau_ttm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index cfc0868e2dd3..99c74c3b5976 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -181,6 +181,9 @@ nouveau_ttm_init_host(struct nouveau_drm *drm, u8 kind)
 static int
 nouveau_ttm_init_vram(struct nouveau_drm *drm)
 {
+	if (drm->gem.vram_available < PAGE_SIZE)
+		return -EINVAL;
+
 	if (drm->client.device.info.family >= NV_DEVICE_INFO_V0_TESLA) {
 		struct ttm_resource_manager *man = kzalloc_obj(*man);
 
-- 
2.34.1

