Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9692DF8A178
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CDF010E8AF;
	Thu, 16 Apr 2026 13:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dfcYE4pU";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8083910E8AF
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:37:28 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso30408345ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776346648; x=1776951448; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lZMYklE0oIcY7A30/kkaKk7kqGcT3s+a+U2u9EfvBxQ=;
 b=dfcYE4pUa7JRzeafQzIDbUwQFbm+2xQ3lYrE2fMPzceDOAbGZuHdSs+rKC1npdlTlt
 aJEmGbBpy3Nw+ZN/U3JS3OQnCq/RDnKBP8T6PI3L1mZETqQEICURzhp9Ur9CKnAvk9If
 D038dgve9p4fyFF0xz5Aifbd4j0CCeqUasHaKDYf7jmIWqDJ7IJXH2Y5170Njxn98dir
 UM58zXYj6MyjwQCzbR2qGaYwCRVohu2IMucKYPWYbLo6D5X8LLRTcCVzzFOv5WAg7j5A
 3twmd+BsH99oIotE8BPrtjeMnWe/MQmxgXYkupXkgAzCHuYbhAeSFAKtgdLscDp662Rv
 oeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346648; x=1776951448;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZMYklE0oIcY7A30/kkaKk7kqGcT3s+a+U2u9EfvBxQ=;
 b=i6Q6p1pLVOolzEccmD2MQirE8LwlIL/SoWcET9bHMlkovY4DScRfHDkokLvlKqDfLT
 IWnn9IoQYk9cAcxKQaeUkVb0gT076EKmk+EUKszEVgBVjGFH3HNlgc1ejTEzj3DPXuuL
 nFSbS2Xo9QmkmRtKAygFmam60jG8vzuKBkaCySaadrOo1e/8Iem6P91Oa2hKeA9bPytw
 qipNwsjZ7NTtsyhPSeaF0Utwdf9Sb77MjAwHdkgmJseFIYNzO8VtmQLcLnSX5p7rRCjw
 C57+s56zPZAXOopAAtIcB0Sb5DuZcbKh5NhK4Od+lTTw+gGgxAB9N6wfdUCCq8OPDa4o
 Ruwg==
X-Gm-Message-State: AOJu0YyjRDkjCbcr1av8lIQl1jK/zohUS4pF1wV2zvftGph80psn/ea7
 f9ApjXIgAYHSvmg7RuFYBxGzYDf7agw6vbpcETc6h3b8CfbnQBw9QrnW
X-Gm-Gg: AeBDieuF744n2It48zIQP9IteayKRMwpt5+xgK6NZECjOX3NcJshDK8EqVzU8yolziE
 Gh8ma2K+Pkmv9UyT1VIptqJ0RqsI7IZ6lXnpRs8g3QjkhSm+8mynloagRcd3gKx++rb7lQVNS0h
 Dxkdb4uAZPN6jwGPXFjOkHg5fx3lDOR06zLcNOi4Z0OkPfXMR2d8VXOMYelwDY7BBRDm78At44d
 NM5mKKNR0a9atfv6xItazCo/lHcBfOj/mZklKa1O0x8RAAkWSRXnoqSsZcFG7jsbjl7XQgupmbN
 VN9Fcr2s5uVgJWfRUEAhstQYzQtwa2ksbDJbmRpvIB91rjdoU9C+MIcjCTUvqXaXnQMkJiWp9gA
 xqVGlSAfOjFTdnK3HpWNFEBpSmNukxivLN8tHpwaCA2u7wHvAHEe7vHDMVt0WXpw/u2oJAwl38D
 fn0sM/2F3zrYG8xjjf5q724AsAOMcQoIHHT02Ezbzt25Xp+4TjAUhHmtp1Aal97D9eVAYrrhZ9w
 ve8jkocQaITFnkLgpYHqVB1sExlI/eDpi2kkPDOLw==
X-Received: by 2002:a17:903:3a8b:b0:2b0:5626:f75d with SMTP id
 d9443c01a7336-2b2d5a1c699mr267563285ad.26.1776346647760; 
 Thu, 16 Apr 2026 06:37:27 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478130350sm55925335ad.34.2026.04.16.06.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:37:27 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 16 Apr 2026 21:37:23 +0800
Subject: [PATCH] accel/amdxdna: Fix memory leak in amdxdna_iommu_alloc()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-amdxdna-v1-1-30c13008365c@gmail.com>
X-B4-Tracking: v=1; b=H4sIABLm4GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3cTclIqUvETdNBOzFAMTU0Njg8REJaDqgqLUtMwKsEnRsbW1AMw
 GBvtZAAAA
X-Change-ID: 20260416-amdxdna-f46d045130aa
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776346646; l=1223;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=TDWR+eKGZ6caELc8JQbNeT/BZzn78biakeSPP++Nm+Y=;
 b=VaZ3ya7AglXqREpLZ5ruBdQsHnbPOCale0d1J0dl8eh/ZuF3MAy4VO4p8VlHSSS2SOsNdTbB6
 vLkK8BAoS25AvtoIdTrXXnwO8SVhgYBfyB20vjQBiPsgx6CNhQ9hk7W
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
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

In amdxdna_iommu_alloc(), if iommu_map() fails after successfully
allocating both iova and cpu_addr, the code jumps to free_iova
which only frees the iova, leaking the allocated pages.

Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
index 4626434d4180..a2e8d8ac0901 100644
--- a/drivers/accel/amdxdna/amdxdna_iommu.c
+++ b/drivers/accel/amdxdna/amdxdna_iommu.c
@@ -110,10 +110,12 @@ void *amdxdna_iommu_alloc(struct amdxdna_dev *xdna, size_t size, dma_addr_t *dma
 			iova_align(&xdna->iovad, size),
 			IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
 	if (ret)
-		goto free_iova;
+		goto free_cpu_addr;
 
 	return cpu_addr;
 
+free_cpu_addr:
+	free_pages((unsigned long)cpu_addr, get_order(size));
 free_iova:
 	__free_iova(&xdna->iovad, iova);
 	return ERR_PTR(ret);

---
base-commit: 936c21068d7ade00325e40d82bfd2f3f29d9f659
change-id: 20260416-amdxdna-f46d045130aa

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

