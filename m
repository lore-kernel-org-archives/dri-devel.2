Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0760A6F7F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l5os0/NQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2DD11267C;
	Thu, 19 Nov 2026 17:11:05 +0000 (UTC)
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F156711267C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:10:57 +0000 (UTC)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b3b5b49cabso2099682c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108257; x=1795713057;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZcdeY/+hHuFAVss5RJRa1CDo+Jz02VmFH4BdGyYa5KQ=;
 b=l5os0/NQwfqQOwqTf4Mq1EiCa0ATi7tnTgPorGxUi2DwNvsl7n/nxs7FujV02maAcu
 pgkbWV8NTiPy9gz7/XTyVXTpuCy568ncrw2w0KODAjv4jTCxiHEKxF3bozm2JRQWnG2b
 fXadyXfZJQ6ZNzhn8aDAkjwSSrtyOhOtFRhLBzeRH9lm0DOPwIznTrL9wRzMtI1mljGc
 lw8M/jp5+Z3Ca9giSSx2g6da64JbPIZ3JAbJypbxNWvKoOgw/SJTUMn6zXQX/DnkP9Fc
 USj46Kbyo4Gc5IL7J4Trg00Fu0VYch/Zj9pDVF7SMvaEVD/VC2HE8PUiV2L5FaYWBNOk
 cO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108257; x=1795713057;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZcdeY/+hHuFAVss5RJRa1CDo+Jz02VmFH4BdGyYa5KQ=;
 b=uO0A5+WHIPS1XMVOPOQk6wwaQcg+MZ4afSBvZjFbEjNuOuNQk5Ws+fEN9Rc6kaXsgm
 Hr/yWc8/l/X0X6jEzIlDNT7XeYR7kYKzfKPx1vJcjxQo8CcT3aMGl0/bhbqw0JIIGWku
 VnvELcJkKfZ8qbgIAEsAkZjiGaXXi8TMPbP2wegMkMgVxW13RinGMA8lgJTRPFEYhzQE
 Dcgmt9Y1qTdgWJrihNOqwh6mlEi+S7VFZn95Y6EsAZiOPvFApCcUdLWzzFc/dWZnh3w9
 ro4sKugXMpXX1hLn41mYD9bdKj9M/BjFZ3mT9r16kgP+0pu7gxGFVxhFCOZ/rhli1+cg
 wBFg==
X-Gm-Message-State: APuU4Z+n87zcTVQr0aCIw6pgqNDE+rE9YUe+YJUekgQXbwshj9aXjvyF
 AiVhsfo/Np0vM8yRAjZY544rJt3+f/5TTWq2qqGGinRUNZTjH6e2ifW2uccaMoE0KKrv3xN7Mh+
 rF0AXS2EqvQ==
X-Received: from dlev8.prod.google.com ([2002:a05:701b:4648:b0:1a7:450c:8b47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ea8d:b0:163:c5eb:d42f
 with SMTP id a92af1059eb24-1b5567c02b5mr259999c88.5.1795108256626; Thu, 19
 Nov 2026 09:10:56 -0800 (PST)
Date: Thu, 19 Nov 2026 09:10:53 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119171053.1537233-1-irogers@google.com>
Subject: [PATCH] drm/mediatek: Initialize ret in mtk_drm_of_ddp_path_build()
From: Ian Rogers <irogers@google.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>,
 Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

of_graph_is_present() returns true when a port or ports node exists in
Device Tree even if it has zero enabled endpoint children. In that
case, for_each_endpoint_of_node() in mtk_drm_of_ddp_path_build()
executes zero iterations and 'if (ret)' evaluates an uninitialized
stack variable, aborting probe with stack garbage.

Initialize ret to 0.

Found via Clang -Wconditional-uninitialized on an x86_64 allyesconfig
build. Verified by building drivers/gpu/drm/mediatek/mtk_drm_drv.o
with LLVM=1 W=1 (-Werror) and -Wconditional-uninitialized; not
runtime-tested on MediaTek SoC hardware.

Fixes: 4c932840db1d ("drm/mediatek: Implement OF graphs support for display paths")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a8bf0690756a..4b15b90b11d7 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1006,7 +1006,7 @@ static int mtk_drm_of_ddp_path_build(struct device *dev, struct device_node *nod
 	struct device_node *ep_node;
 	struct of_endpoint of_ep;
 	bool output_present[MAX_CRTC] = { false };
-	int ret;
+	int ret = 0;
 
 	for_each_endpoint_of_node(node, ep_node) {
 		ret = of_graph_parse_endpoint(ep_node, &of_ep);
-- 
2.56.1.708.g77570a6a1d-goog

