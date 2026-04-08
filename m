Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386301073C93
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881C510E464;
	Wed,  8 Apr 2026 12:50:30 +0000 (UTC)
X-Greylist: delayed 574 seconds by postgrey-1.36 at gabe;
 Wed, 08 Apr 2026 12:50:29 UTC
Received: from 3.mo560.mail-out.ovh.net (3.mo560.mail-out.ovh.net
 [46.105.58.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B1210E464
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:50:29 +0000 (UTC)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.110.58.129])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4frN2s6KWKzB4gt
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:40:53 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-mb8kg (unknown [10.110.113.134])
 by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 923D91001F4;
 Wed,  8 Apr 2026 12:40:51 +0000 (UTC)
Received: from etezian.org ([37.59.142.111])
 by ghost-submission-7d8d68f679-mb8kg with ESMTPSA
 id xi9IBtNM1mmC/xcAWGcN2g
 (envelope-from <andi@etezian.org>); Wed, 08 Apr 2026 12:40:51 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S00502917d8b-fe65-4101-a4d9-a01200ae7c8c,
 D209C671E6EFFA79B5C95F157C9E47DE85B2B2E2) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.82.31.9
From: Andi Shyti <andi.shyti@kernel.org>
To: christian.koenig@amd.com
Cc: janusz.krzysztofik@intel.com, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 sumit.semwal@linaro.org, Xiang Gao <gaoxiang17@xiaomi.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH] dma-buf: fix UAF in dma_buf_put() tracepoint
Date: Wed,  8 Apr 2026 14:39:16 +0200
Message-ID: <20260408123916.2604101-2-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408123916.2604101-1-andi.shyti@kernel.org>
References: <68595b2ceed038074f5fe0a5739d75aafbcac8d3.camel@intel.com>
 <20260408123916.2604101-1-andi.shyti@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 5536331319964046554
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFz5CK8pll4+m5rzR24T746LhjYj0+P7SPwAVsk3wZFnbp+RFDWAosALJb5nVkuVD1j5uaxE3Q2sgEtavEjgrNJlsQ6p+mnK8Qlhi0kzcJwEgnoUBVKWrsVVpQ7R/Y+9BwkJcgqgm25Q2u/F9PiAsMNwOCgi8TL/5WLXNpdsfoLSd1BWZKbZ9S7GFLaJeqB5t12xoDsqbrrHVeB2JRmOd716PcPxqa6FrDi+Nr4Lropz4Ey1GayttEWMbI7tmWXMHtER0h++jPXdEVXopxjePU8Ff0ssrpUzGvE6lfQumSM7er0ehIPkgcyj0Nzujs8ITbFvT+IaQ4L8GPlRPmrjDZBJ98d0lE8mdmB2zfmbzmwm5Px7B3fSs5ru/5XE6tfxqfMCP4iMRELaw+dpSGu9ThNrGvYr2ksf5kLd6hy2OKbELck+1XDBgYk6WOtP++sk0mcvdnj/KcdN/7ua6Qk/dyc4Da0AqO5tHWv0FaDEpt/irhD4YmXinKQtR2pxsx6NGPmDzKiyEHHqVRTnJfxOmIfql8EctniM5iKDefhI/5YZ9+7uiUr+HjZkN8EoX/tCN8LgXsZvFc0jYjLecIkB0XeG/sjOlwo5scc3drqcfwjTtPUas9o8AvlAdwrndKMm4DYnw6BDo8H2lvzgXKQJ93hKgtvXoVXCuMeaOCWQxQdfw
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

dma_buf_put() may drop the final file reference via fput(), which
can free the dma-buf. The new tracepoint invocation was added
after fput(), and DMA_BUF_TRACE() dereferences dmabuf and takes
dmabuf->name_lock.

This leads to a use-after-free on the final put, visible for
example as a spinlock bad magic fault on a poisoned 0x6b6b6b...
lock.

Move the dma_buf_put tracepoint before fput().

Reported-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Fixes: 281a22631423 ("dma-buf: add some tracepoints to debug.")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Xiang Gao <gaoxiang17@xiaomi.com>
Cc: Christian König <christian.koenig@amd.com>
---
Hi,

I believe this patch fixes the issue reported by Janusz, I haven't
tested it. Perhaps we can add some more checks in DMA_BUF_TRACE.

Thanks,
Andi

 drivers/dma-buf/dma-buf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a202a308c079..b72932c57cb9 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -845,9 +845,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
 	if (WARN_ON(!dmabuf || !dmabuf->file))
 		return;
 
-	fput(dmabuf->file);
-
 	DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
+	fput(dmabuf->file);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
-- 
2.53.0

