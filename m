Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02D7C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F2810E52F;
	Wed, 23 Sep 2026 07:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mBd+2U3G";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2B510E6B8
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:43:23 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39666bed441so79011a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790149403; x=1790754203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/3yqINp8iie30Eysp9fZFTFNFw0R4zJwE8ZATQluE4I=;
 b=mBd+2U3GUYLmQ6mDDJFyUe27YV1R2/++bJA7J7lKiQIyf5YRtvQZPsRlcm4/UkHBkA
 tf5F1uLp0gWwyPcOyLE24Hsvp+MCgVxjl62XmagB85Nmk+NcPyZuMpxMVZHGFKJZ/s85
 TMqXekQnwECmHJT66HVfCc7M+qPLj/l12XRCA1+7tgTO+flMK+h7uXFY3/0xcAUzpOw6
 I2QEqRONr9EbO7QXZXa3+YFqox9vO53ghc3dzXsaJ5+E65MIbv2T4BOOFb15RARLJcmM
 yi0wiB9iQgMJqCbilFFreiULOC1tdFn1/85tUBIycxd1XSL948P1a0CW43M4SDdZ07Wq
 LRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790149403; x=1790754203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/3yqINp8iie30Eysp9fZFTFNFw0R4zJwE8ZATQluE4I=;
 b=ydclO1Ib7R2QIq0wX/O7vrubjiF9eGWD8rrkZzw1yIS60W4uxRX8tjTOHD5nF+n+1d
 jKip3RL0QA+8UK/zlTY06VFwthipO3CHE0ZRF3jpOWZdY9YXVEi/3rp8femQhQruT9Vq
 PSla7hlMOeLT/lSZ76slyHOQWBMJ2fsa7bWqRd3vghD026acoyTb1/qRDQVJ23HVwi7u
 LhvlBBT+3Lkzc7drkIKK9255CbLiQld1pqLYUy3ND45nWwLjzUwKHvIx33kc8/PWVCFD
 jah3cOtkJPBZRTEG6LzH7wdKGx+Zm4HMgM/z9D8VPSUprcUYzLUXxqw6xe3zlTxEX7go
 is6w==
X-Gm-Message-State: AFuF++kJeWOtmDci5og8L/6rFG7Sj6gbi+HN0hdqbpWGj2hY3qLmLkYA
 SuiZunrEjUHIxyM8puWUfPjmIFRRontvbr0RE2ej7osNmJDAuE3ZiCh4DBscAjGh
X-Gm-Gg: AYBFou0B0WB6jdx89VOYdM/L14y//euFRpz4dKPVUbAmOop3ywzhYFr2sySpKIe38W/
 Iu1LzqIV0YMfgSdYEv6lOR1Rlm7SWfQp6rbDaPj9oGAwp9YBNiz33MQR79irPJmet4t07t0l5jJ
 MHhLcAVK3w4ivOpjE4doNzTX9ykURKfouPmg7sumqSx9ze5crYF+94rVht7WJ+oz5flPGO9pVgV
 IF3pY8QvLQhVLBs1JiFN9d2unudOIG9St4VRd7tgx+DWUCsg3ya5g19Pqcg7hd3BKun+3o4sumw
 SP2k8v2mBv3tUHne+pBjzbguUj4DAg9r+M2qzLew7oN0zId/cndOj8035f1PzKfo9iUzc9i49RI
 aV5k6Tz7/dVZJ8FdF+7gYvLPuaqFnFl1raUgzAiPSlpSiAWy+RbvMIhbnOtqdvVS5GCIyXgWRTm
 b0nzdVfJsN+dg3tIGDjMsMQRCst4rjd+qt2GuK3WBuSuPRYMAsqxPT0CI5KvZOrMspG+iwEygfB
 ZGnd9Zk5GfvqQ==
X-Received: by 2002:a17:902:d2cb:b0:2d6:3c1a:85ef with SMTP id
 d9443c01a7336-2df69e1769bmr25554635ad.4.1790149402890; 
 Wed, 23 Sep 2026 00:43:22 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5d9273sm6406785ad.50.2026.09.23.00.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 00:43:22 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, freedreno@lists.freedesktop.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Subject: [RFC PATCH v1 1/2] dma-buf: keep DMABUF_DEBUG off by default
Date: Wed, 23 Sep 2026 15:42:22 +0800
Message-ID: <20260923074256.9357-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923074256.9357-1-liujianfeng1994@gmail.com>
References: <20260923074256.9357-1-liujianfeng1994@gmail.com>
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

Commit 143755bdabaa9 ("dma-buf: Make DMABUF_DEBUG default to y on
DEBUG_KERNEL kernels") fixed a dangling reference in the DMABUF_DEBUG
default, which had the side effect of enabling the option (and with it
the page-stripping sg_table wrapper handed to importers) on every
kernel with DEBUG_KERNEL=y - i.e. virtually every distro kernel.

drm/msm is broken by this: it maps imported dma-bufs into the GPU's
own pagetables with iommu_map_sgtable(), which needs the struct page
of the attachment sg_table, and it fills the GEM object's page array
through drm_prime_sg_to_page_array().  With the debug wrapper in
place both silently produce garbage (the wrapper zeroes sg->length,
so the page iterator yields nothing and an uninitialized array is
kept).  The VM_BIND map job then fails asynchronously after userspace
has already enqueued GPU work referencing the mapping, which shows up
as an arm-smmu translation fault from UCHE, e.g.:

  gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
  type=TRANSLATION source=UCHE

This breaks hardware video decode (clapper, chromium) on Adreno
systems; bisected on a Snapdragon laptop as v7.3-rc3 good,
v7.3-rc4 bad, culprit 143755bdabaa9.

Revert the default until importers that legitimately need to build
phys-based mappings have been converted.

Fixes: 143755bdabaa9 ("dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL kernels")
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 drivers/dma-buf/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index e4f078a326a41..b3c581ef4c987 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -43,7 +43,14 @@ config UDMABUF
 config DMABUF_DEBUG
 	bool "DMA-BUF debug checks"
 	depends on DMA_SHARED_BUFFER
-	default y if DEBUG_KERNEL
+	# NOTE: keep this default n.  The page-stripping sg_table wrapper that
+	# this option installs for importers breaks drivers that build a
+	# second-stage IOMMU mapping (phys -> iova) from the attachment sg_table
+	# and therefore still need the struct page, e.g. drm/msm with its
+	# per-process GPU pagetables.  Until those importers are fixed, making
+	# this default y breaks hardware video decode and GPU workloads out of
+	# the box on affected systems.
+	default n
 	help
 	  This option enables additional checks for DMA-BUF importers and
 	  exporters. Specifically it validates that importers do not peek at the
-- 
2.47.3

