Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDCECA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4702810E150;
	Mon, 28 Sep 2026 20:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.b="CmuOiVI8";
	dkim-atps=neutral
Received: from dormouse.ash.relay.mailchannels.net
 (dormouse.ash.relay.mailchannels.net [23.83.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C5D10E150
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:08:55 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9650B4C07F1;
 Mon, 28 Sep 2026 19:58:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com
 (100-96-4-183.trex-nlb.outbound.svc.cluster.local [100.96.4.183])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 427C34C0721;
 Mon, 28 Sep 2026 19:58:54 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cure-Bubble: 092205985063c709_1790625534443_1514188764
X-MC-Loop-Signature: 1790625534443:3676939605
X-MC-Ingress-Time: 1790625534443
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.4.183 (trex/8.0.2); Mon, 28 Sep 2026 19:58:54 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4htsZP4FqNz1M8; 
 Mon, 28 Sep 2026 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1790625534;
 bh=yOAkVbw5Y5WdGtxF4n15J0FVVkDgFz6f2VlHyqeejmM=;
 h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
 b=CmuOiVI8qzmfoAnqG5j1/7WpYSMA0vlkpOjhVprIfukN+4P/Cs9FZdFfxBOTBDI9J
 2MuKYqZ2CkgDM12jnOGsKEv58b3TlP74UbmzmXJnxtwpaQuPxBZpFm2TM3YQeaX/bZ
 C7E22i/XT+Lc0F/kr4wqS3yQxfwbRAuAmOCTuq5HvDAoZgVNIvyqN8wvD6+yyCsDL2
 FgMA+HgGOanHBLA7Pr8ApDPEWUD0aGrlgftkYtk2Jh7DsAOhsyE6oBhe4/xdn7drpz
 02xchyO9HiJd/HXyhPUXzZdpLzXQZQ1+cX7js6jbTIt1u22adh2MOaKg0HUXCUxCwv
 mvSlsILtDwpeA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com, tjmercier@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dave@stgolabs.net
Subject: [PATCH v2 1/2] dma-buf: validate the attachment before asserting its
 reservation lock
Date: Mon, 28 Sep 2026 12:58:49 -0700
Message-Id: <20260928195850.1982569-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260928195850.1982569-1-dave@stgolabs.net>
References: <20260928195850.1982569-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

dma_buf_phys_vec_to_sgt() asserts the reservation lock before its
NULL checks run. Validate first, then assert.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/dma-buf/dma-buf-mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..e6ecd6c80587 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -102,12 +102,12 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	size_t i;
 	int ret;
 
-	dma_resv_assert_held(attach->dmabuf->resv);
-
 	if (WARN_ON(!attach || !attach->dmabuf || !provider))
 		/* This function is supposed to work on MMIO memory only */
 		return ERR_PTR(-EINVAL);
 
+	dma_resv_assert_held(attach->dmabuf->resv);
+
 	dma = kzalloc_obj(*dma);
 	if (!dma)
 		return ERR_PTR(-ENOMEM);
-- 
2.39.5

