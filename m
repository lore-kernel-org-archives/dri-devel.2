Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD9606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=VjjXHV99
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AF110F02D;
	Sat, 14 Nov 2026 16:25:07 +0000 (UTC)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011F7112625
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1794582513; x=1794841713;
 bh=mGrf7JaZq0O646GLAmSYUiskE8wdIOIlTShy4qrY0vM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=VjjXHV99mmbhtDEufZikm/ZoocZH2bHKzB79O7HL50lCrWV08l4ZdvUKK9LlfKvlq
 WBB9Fmp8jeZFKOUuVNCwNqkLgV8ER/N8zkKwfUZilAZJVQn21Oo5G7D3UlIFL3V+rU
 UVbj9q4xyw7HCXaP/7BcttQjG0dxrQMLuy0iA41CfpIfhLFQ9dnAXxe3ZB0+xlSKNi
 A0B9fFKkbFxwDupVTk2iK1XZg00lGJy/FsEp70Qf9mPccdrNe5UnO6Pv6czkvKxi55
 PAMYo7rf+mI1xY/nUyonFJdlcea2mLBzSnCddY2rqQsBJS3ZAzgCHr/LMHQXXYf1Rb
 wmtmR3IAPl4XA==
X-Pm-Submission-Id: 4jR0y74PzRz1DF5P
From: Michael McAllister <me@michaelmcallister.org>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: clear the DMA buffer pointer after freeing it
Date: Fri, 13 Nov 2026 15:08:02 +0000
Message-ID: <179458248277.51880.11276326781897812340.msm-dsi-double-free@michaelmcallister.org>
In-Reply-To: <6m4cssgagnpvm2wawyj62veoqbglxv62rcqgxzaxvjynhn3dts@tlkaxvd6ph3n>
References: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
 <6m4cssgagnpvm2wawyj62veoqbglxv62rcqgxzaxvjynhn3dts@tlkaxvd6ph3n>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DSI host survives component unbind. On DSI v2, freeing the command
buffer leaves tx_buf pointing at freed memory. If a later bind fails
before allocating a new buffer, another unbind can free it again.

Clear tx_buf after freeing it, as we already do for tx_gem_obj.

Fixes: 5e05be782645 ("drm/msm/dsi: free TX buffer in unbind")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/bug/linux-6f5085d3-ef49-482c-86e4-a2438bc1b91f
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hi Dmitry, thanks for flagging. I've addressed the double-free in a separate patch.

Thanks,
Michael

 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 64fc54dff4..3feb260a31 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1301,9 +1301,11 @@ void msm_dsi_tx_buf_free(struct mipi_dsi_host *host)
 		msm_host->vm = NULL;
 	}
 
-	if (msm_host->tx_buf)
+	if (msm_host->tx_buf) {
 		dma_free_coherent(dev->dev, msm_host->tx_size, msm_host->tx_buf,
 			msm_host->tx_buf_paddr);
+		msm_host->tx_buf = NULL;
+	}
 }
 
 void *dsi_tx_buf_get_6g(struct msm_dsi_host *msm_host)
-- 
2.39.5

