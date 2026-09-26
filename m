Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602EBC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 02:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAEE410E2C5;
	Sat, 26 Sep 2026 02:20:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hb8QgQs7";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234A110E2C5
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 02:20:36 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ab17a156so22909a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790389235; x=1790994035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A35dxfOiF0vku1a8AiorVl5ekNNXinTf80Wsr1D60yQ=;
 b=hb8QgQs7GVr9D7VskSNY/J3zSfgIJO8vPx0nQJDma6TIobU26vwpR4Qx2AGj4tKqo0
 Ws+Ux9M8T42dgcX/MJueaSv8FjngeUxozGRz3BeH96/zgr7P2GzD97R70fS5FbCTySlA
 I/1Wwe/F7t1HY4ZF7RVPuXMEi/cLhM+Ux+3vCu+HVv1k7bWeaE/MfxXlEqlce2ba1LEb
 dRTApoTZAe7iQr8D30fiT+aZs3mEpw6FZi9s/gwuT4Hz/sWKdFzdH+dBYxt6de9AUp6e
 vqhxznKliDlt7ZDgYP6v+qWzEPk6ej1SoYVUuRugkmXsvORRT2HeVtymFY/QXPpSol/z
 EH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790389235; x=1790994035;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A35dxfOiF0vku1a8AiorVl5ekNNXinTf80Wsr1D60yQ=;
 b=26fKRPtWlY/dLuWV5+JbZWn1limeDsWUZ2UyNJ6vMAUwYgLqyGdtrIW2Yfphi83Wd0
 XKikR65XXwiIGEtVZH98J7yDfdk4fNTnHVP/A0E59hDyIbKBN3u49V/xGX83uBECvr/y
 60AtIQ91ZW8El7P+0TQFYWsuUN304uxYd6Pd1NLuO2ZXHH+hJ1xpC5BXiwZVEB0UYgNO
 KqpHmxOtfGJOctT2stVrM9MO/uLWGBITclyBXn8EB47K2qhNJOfp0p7E9+hyRrS7TKbh
 3X6hxILiAbmphP1HG1EmnyM5l7t+FwiN8xSftLqzCvYyIV2a80Kxuwx9q+q5yRndJXt7
 0XAg==
X-Gm-Message-State: AFuF++lbucyPOZB5W3arLYWjUdd7ySfceJQQZDQQo0UCp4fgvmDNmapX
 y8hxbrghhKHgFSsw1hpSElx2CvjW8bXPCkjmrbopNVELwM4g4Zvz+QqOq5stDQ==
X-Gm-Gg: AYBFou0UYQ6qTzKg+QONBC6ug91WAe+mSOpW7izd0e7v2jB5VCndLFnUWqWT/ouTBZ1
 jJQCZ6JoVqQ88EQE1pBV80c+CQKsOsMS4xjAQKxTeHYpWOk7frQOthPqlHTT88gk3vFPYeiSnIP
 YQVzY3O7a3XLM66ZvEaOpP5Lc4w1zqZ7cXEK0gkqxxkiV+KohxEVKQn5hhbpsksPbJ+OmsE2oIb
 r/ePIdAWgFZsoQbYl84YA2cZ7cfomcIFVha9I1JwjMz55Z8z7APkVoyI3UMSSO5YU+p+7Bze2lF
 ox4vduFClLEe1V/z1lJ9UCLs72WN9y8+CSeR58Qdq7x+Cag4vd6T6n+dU701209N+wcJ6Q62h91
 jYrvHdgUWxdFDk07LuMbupZYsBKBMAwoXNksp9ACVVr7sJMBXP+gmgSkw84gkPxMv4/LZy7jETe
 qPd/GqWFn+fk/nwiThEZMfQytLfSD9RAoCUCWpYjpLUO4/Hc9pWrjN7zJDZl4VDODXdi7PA8ITq
 rWujlYdaolBWQ==
X-Received: by 2002:a17:902:c94c:b0:2db:2846:ce3c with SMTP id
 d9443c01a7336-2df8e59a4e9mr65359735ad.1.1790389235476; 
 Fri, 25 Sep 2026 19:20:35 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df90fbac49sm17687415ad.3.2026.09.25.19.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 19:20:34 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Bryan O'Donoghue <bod.linux@nxsw.ie>, Dmitry Baryshkov <lumag@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>
Subject: [PATCH] Revert "dma-buf: Make DMABUF_DEBUG default to y on
 DEBUG_KERNEL kernels"
Date: Sat, 26 Sep 2026 10:20:17 +0800
Message-ID: <20260926022026.10539-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
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

This reverts commit 143755bdabaa96776c24f878014608e9cb44f930.

That commit fixed a dangling reference in the DMABUF_DEBUG default
and thereby enabled the option - and with it the page-stripping
sg_table wrapper that dma_buf_map_attachment() hands to importers -
on every kernel with DEBUG_KERNEL=y, i.e. virtually every distro
kernel.

drm/msm is broken by the wrapper.  Both of msm's map paths consume
sg->length and sg_phys() of the attachment sg_table:
msm_iommu_pagetable_map() for the per-process GPU pagetables, and
iommu_map_sg() (via iommu_map_sgtable()) for scanout.  The wrapper
zeroes sg->length and strips the page pointers, so mappings of
imported dma-bufs silently map nothing, and userspace observes
arm-smmu translation faults from UCHE, e.g. during hardware video
decode (clapper, chromium) on Adreno systems:

  gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
  type=TRANSLATION source=UCHE

Bisected on a Snapdragon X1E78100 laptop as v7.3-rc3 good,
v7.3-rc4 bad, culprit 143755bdabaa9.

Switching msm to sg_dma_address()/sg_dma_len() is not a trivial fix
either: those fields are only valid for sg_tables that msm has
dma-mapped itself, which native non-MSM_BO_WC objects' sg_tables
are not, so the conversion needs more work.  The msm maintainer has
therefore requested restoring the previous default for v7.3, to be
revisited once msm no longer consumes struct page and sg->length of
imported sg_tables.

Link: https://lore.kernel.org/linux-arm-msm/20260923074256.9357-1-liujianfeng1994@gmail.com/
Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 drivers/dma-buf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index e4f078a326a41..7efc0f0d07126 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -43,7 +43,7 @@ config UDMABUF
 config DMABUF_DEBUG
 	bool "DMA-BUF debug checks"
 	depends on DMA_SHARED_BUFFER
-	default y if DEBUG_KERNEL
+	default y if DEBUG
 	help
 	  This option enables additional checks for DMA-BUF importers and
 	  exporters. Specifically it validates that importers do not peek at the
---
base-commit: 93f51579e7df248780214094418f205253383cc5
branch: revert-dmabuf-debug-for-7.3

-- 
2.47.3

