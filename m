Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B52C624DE
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF4810F3D3;
	Thu,  3 Sep 2026 07:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=x6u.co header.i=@x6u.co header.b="OAKDrtxa";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6211E10EDF7
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:09:02 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-85aeb506b78so3217217b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1788282541; x=1788887341; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b1WtM+yGxMA6nGtYPUfHvkwWZoT/FUK2b2ZzSHby/Yo=;
 b=OAKDrtxaa6wwVVNiw5j1b0HiQfzT9HL+EMXipxeVyrRbkiSuqgmJMTF0h16pDp3b1c
 6lLMvHKGv/xE8+HU2lp2Yf6aX4QJ0AZGnMY/7D67FY7jrJdzEA1JRVOpYV3A7EbuavoH
 aEg4YRXkXh7DhcUGNoIud7Xb7WYCH3GFlM/Y3OFQx6WNNnwWX1GdlXtJjVkb9tLfFtwj
 /QbGPUlvddXKy1zXnyrgtrQhxz2GL5vDM6BFQiik+bzXODFsah3algjp9ZoBnL5NkOmR
 D+DbqFIuZyfRtGZkRs15am6uM5NfruZDuiqOjyLvaasREEj8Xj6NeeBpwoSGpWYuP0fN
 c2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282541; x=1788887341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b1WtM+yGxMA6nGtYPUfHvkwWZoT/FUK2b2ZzSHby/Yo=;
 b=IXfM8m2YC30sVE7KGZ6wDMOVj3g9HE9uefMWjktlK1ExRI6vpZDfO1BZTFk2HqHP8X
 IlnxcbHPXMo0KiYOZS9/cZA7RDnOugKWGc8ppk7bLW3zoQTHFpmgGm/JY4AIDunHRaKZ
 0HIFcOhmJLLewtqk4cA4JHufeUDrKISaFtfU8Nj4OGe1oMeObO8jpL3d1oF2BgoAYhMa
 qXZSSqcOTo1hVFIme8GXgzvuLtlAwoEzVcHNfRI1pXrEmDkABk9o1XCrbHLMOH5rOJkT
 F+z84aqPnnYBIfSpLLE7ZJMJLweQVl1aD1aciP+4+iSnZemNdSo6+Tzkhw3Cs+0X9Ld5
 mh9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhS8+8J/9I+S6Hg5oewFdgxw4KRC7CsDusKPtaRVYg0kiFCm+987mIcEhial6qZyw6ngcATj1txBs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mB1FjUkHy5XYFmVhq5DttWyaTjQ2Fm8sMTY6Trfdir70lJ0DWW
 kU7/jSG9xi2PH9mfNmmGIdLIPQ4FduoiichpHYy4hHq8hqlNt6u5Qqsi+zWSI5oF6orG
X-Gm-Gg: AYBFou1pCELj6p6PAIa5Ru1QORGxBWJvS9/gOeyOCOuB0QT4hzO24xujevnLgcAzfsu
 +yMJleGIQuTLkyXc4dH4TMEZe0VF2GAXG7yDABqRuxyjJT/0XHAxDn+34/uC6kdYfyaktLp87Va
 cVR6j51iwt30cwcPAg4ZW4HSI0WSPmTCgiXf44DdMCblS/Rl21n5qxsmGyK4g4QG/eMhaBvdV8C
 zu9SxRAAc8tThIM74Dnxoaj0uFnEPS6kyRLhuRxqb/Y1rUTOi/P382UOIAbFzoA9MBoTEGiniJh
 nMw7dFE6k8YRB02D6OCJU1O8KoVLlPYY0fTJqQtPHYy3LcER1gYXv12Fnu7p4+fCYwa3X/daHcm
 hd4awUMeOtfL7EXtPO7Icwx0l3j7+xNaoZILfDDN8YzFakHrP1mrfQycQLPE29CFY+cyoyrq0tW
 xH46MBYx9KCjhD1ytB8IxwMZzSvwc0joCjQ49T5tcSLOphhRH4miBJjipyuhRstiKwWoDUfIrZe
 dkLXBKfX7N4bOmprz0KJLRqu/6uQ441CPqi8P6g8nCMZazyc+r4Pxq+gYc8Pa/W/MXAoJ72e3k8
 ig==
X-Received: by 2002:a05:690c:c3f1:b0:81e:98d3:cac7 with SMTP id
 00721157ae682-8686f52fe19mr38821267b3.12.1788282539975; 
 Tue, 01 Sep 2026 10:08:59 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e65f146edsm79761867b3.32.2026.09.01.10.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:08:59 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: alex@shazbot.org, ankita@nvidia.com, chriscli@google.com,
 david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, jmoroni@google.com,
 kevin.tian@intel.com, kpberry@google.com, leon@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com,
 xuehaohu@google.com
Subject: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Date: Tue,  1 Sep 2026 17:08:47 +0000
Message-ID: <20260901170849.4052816-1-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

From: David Hu <xuehaohu@google.com>

This series address two related issues in scatter-gather mapping,
specifically for the MMIO based dma-buf mapping. The fixes ensure
sgt mapping is correct, and proper for large MMIO regions.

Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
(Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
phys vec to sgt)
https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/

Patch 2 Splits sgl by largest page aligned chunk
(Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/

Changes in v8:
 - Combined the two patches into one unified series to avoid merge
   conflicts.
 - Collected Reviewed-by tag from Leon Romanovsky for Patch 2.

David Hu (2):
  dma-buf: Fix silent overflow for phys vec to sgt
  dma-buf: Split sgl by largest page-aligned chunk

 drivers/dma-buf/dma-buf-mapping.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
2.55.0.897.gb25b4bd76c-goog

