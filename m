Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F1606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=5MBBv6Y5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E2A10EE31;
	Tue, 10 Nov 2026 08:33:35 +0000 (UTC)
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190D610F244
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1794227533; x=1794486733;
 bh=eerlHc+2nw9LU1blteBgbDf72O/+xt2VeIxgqcPfxtY=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=5MBBv6Y5HpHr3wguQtHSBZaHetMylu67S5tbrJtq9xyxFfFjNu8/uBGd1+RNzDsYl
 MjN1jdQRTG8BMp3We6zvMpRGVYYq1FA5lmyE9gEiKOFPf4ILHQm23xhGIl3wz26Ej9
 x8QTTpJYMBNWAqOJchCYkaMyyD9R4MP9lsDuhSGIP3hEcj5Qh7Eb3xqmceKyfXOMm7
 aKGkXW7/NW072roRpMqRcoAB/BUx1QnMX8NguugA3OaP8qazwGbBR0wxRhnROUm0nf
 JDclYc0VCqAAqKNTz5bDFh7+F0Ccf8o6edAX3zjuWP1pByPCSxbxmKf2yhzZ2JQMqe
 o55mTh2+LBgMg==
X-Pm-Submission-Id: 4jNTgV4YVsz2ScQG
From: Michael McAllister <me@michaelmcallister.org>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: avoid pinning the command buffer on every
 transfer
Date: Mon, 09 Nov 2026 12:32:05 +0000
Message-ID: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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

The command buffer is already pinned by msm_gem_kernel_new() when it is
allocated. Calling msm_gem_get_and_pin_iova() to fetch its DMA address
adds another pin for each transfer, while teardown only drops the
allocation's lifetime pin. This leaves outstanding pins on the buffer.

Use msm_gem_get_iova() to retrieve the address without taking another
pin. The allocation's existing pin keeps the mapping valid until
msm_gem_kernel_put() releases the buffer.

Fixes: 7ad0e8cf6317 ("drm/msm: Count how many times iova memory is pinned")
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hi,

I ran into this while testing display teardown on the Moto G10. The DSI
command buffer is already pinned for its lifetime, so this avoids taking
another pin every time we fetch its DMA address.

I tested this as part of the G10 display fixes on 7.2.9, including display
power cycling, suspend/resume and teardown with the compositor stopped.

Thanks,
Michael

 drivers/gpu/drm/msm/dsi/dsi_host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index d92659d80f..64fc54dff4 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1428,7 +1428,8 @@ int dsi_dma_base_get_6g(struct msm_dsi_host *msm_host, uint64_t *dma_base)
 	if (!dma_base)
 		return -EINVAL;
 
-	return msm_gem_get_and_pin_iova(msm_host->tx_gem_obj,
+	/* The command buffer stays pinned from allocation until teardown. */
+	return msm_gem_get_iova(msm_host->tx_gem_obj,
 				priv->kms->vm, dma_base);
 }
 

base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.39.5

