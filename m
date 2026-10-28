Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2EE606A327
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MY8Bz2nL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD7910E627;
	Wed, 28 Oct 2026 10:31:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58E510FB26;
 Wed, 28 Oct 2026 10:31:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D41FF600C8;
 Wed, 28 Oct 2026 10:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8751F01828;
 Wed, 28 Oct 2026 10:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793183501;
 bh=PfEI1YUa/HhHcLyCA1iZ77nrn1ZFqkyErvh1cXMHDSs=;
 h=From:To:Cc:Subject:Date;
 b=MY8Bz2nL+PTd899FTbwG4Iy8SvwsF4kA8O4XR35dIlvoxnDhGB6PtSq5MXfdjNsEi
 JVkPv97O0vBR06J+Rv1kaowstEbGljr7XhCjORwOtYfUd9la54cosiY8NWbfPeW0AY
 xygn4yLlSnIdBP/ftYfrNemp6xcRdJQ/Wbdpaa8vdK7k6wN2AJjt654yqcMXmkwOwz
 o3V1bYMQeYoL03D2vpS2TICjHzDSa/zRI5Yv2hT6ETvW6cTyzlzy6XRcCIZKkQCf0i
 Si/Fi0gcHq31Rqe0lE92gnC3xSuX804jh3A4TqkVAP54u6Iv3pnsFOt/XDwi4/Yadn
 cJ/uMcMiduZ1Q==
From: Philipp Stanner <phasta@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 1/2] drm/etnaviv: etnaviv_fence: Put base class first
Date: Wed, 28 Oct 2026 11:31:29 +0100
Message-ID: <20261028103129.1036380-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct etnaviv_fence contains a struct dma_fence, which is its base
class. The base class should always be the first member of a class.

This allows for removing a deprecated callback in a subsequent patch.

Make struct dma_fence base the first member of struct etnaviv_fence.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 5c23182f4d33..e51a310c8d70 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1148,8 +1148,8 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 
 /* fence object management */
 struct etnaviv_fence {
-	struct etnaviv_gpu *gpu;
 	struct dma_fence base;
+	struct etnaviv_gpu *gpu;
 };
 
 static inline struct etnaviv_fence *to_etnaviv_fence(struct dma_fence *fence)

base-commit: 731ba09867520c047c7de53f92e384808e0b638e
-- 
2.56.0

