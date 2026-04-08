Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE561073C93
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4982A10E575;
	Wed,  8 Apr 2026 12:45:36 +0000 (UTC)
X-Greylist: delayed 347 seconds by postgrey-1.36 at gabe;
 Wed, 08 Apr 2026 12:45:34 UTC
Received: from 6.mo575.mail-out.ovh.net (6.mo575.mail-out.ovh.net
 [46.105.63.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F39B10E575
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:45:34 +0000 (UTC)
Received: from director11.ghost.mail-out.ovh.net (unknown [10.109.249.22])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4frN1Y2DCcz61lq
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:39:44 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-rvp9c (unknown [10.110.118.225])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5CAADC29B9;
 Wed,  8 Apr 2026 12:39:43 +0000 (UTC)
Received: from etezian.org ([37.59.142.97])
 by ghost-submission-7d8d68f679-rvp9c with ESMTPSA
 id MJC9D49M1mneRSgAk2rvTQ
 (envelope-from <andi@etezian.org>); Wed, 08 Apr 2026 12:39:43 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00223703280-d183-470b-9751-0b51bc554a44,
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
Date: Wed,  8 Apr 2026 14:39:15 +0200
Message-ID: <20260408123916.2604101-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <68595b2ceed038074f5fe0a5739d75aafbcac8d3.camel@intel.com>
References: <68595b2ceed038074f5fe0a5739d75aafbcac8d3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 5516909544000427226
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFJcN3wABJSf2iZpuR5LkA/rJofncb8HPc1lvL14FRcLOhQZE9m65WI7Syzas+A5oU/HMP6qC08qwn2zeFkRR5HvIZrLxMSqek0zFZDYgrkyvfAr5plLRTBX/NT1TF8vFWKq2ajKk0j/79sd/tNec7iFaJQhArVdfqMXgEY9sgx9yGM9FzuJLYJKMjXCETNVsXf+qfrOdOhVic425NTdRHE3a3QPOSdjP3MeHA+GhGkfeLZ3KRIxDswm1v6v1n01idrLScUV3IcfBnSZc3eV7sfBqvJvxU7El0aQnmB3Qejf7phnyndjNdEJ4FQBHv47AIXzCTaI9hPomwTY2P5akDfAaO0cFJ60QpfsIaGzXbWpX0GJ0shSAUjf+R+x9rbRIRx706scn3rSyOA+pJa1ANuumMjZ6jkv53o/70ZCoUedN4tXXuzLx8t1nTOXxP2O6YTueDsD9kvIjx76l0e5cFG5XDCnVRRDxCxiTUFe3102gU6Vim/fW85pE0G5cQWpTVkhQZSKquR0z3JwZUvTJUU/H+tdhcHsWPB7J+0BLfPg97KilbG3yQ4g+ON0WVRxgIEwFdmXTd73j+EsY79gTZNfONXUaCxUqr2JfvaxtnA5ZqGuFyXMY7pipeEC5mpj/QyJfU8sxw8OTrzIK/oIY/ER6HM7Ia7ApzDPtz/XmcBAw
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

