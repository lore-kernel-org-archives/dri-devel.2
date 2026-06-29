Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF44C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AD310E6E5;
	Mon, 29 Jun 2026 07:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DZycwxwD";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA5E10E6B0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:13:57 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-845e363246aso947370b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 20:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782702837; x=1783307637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vIf1UjIu4HobsLfku1GIoLJNf/dF/mUSSo+eQGmmVZs=;
 b=DZycwxwDACPlZHStMnCcBGxmbHl/VtCgBCu3oCJy2WG7Db1eIWz9+XhlPBzwnQR3vL
 qscIwn4HOUcUDi3iqGalEn/GEr9yn0Elk2J8qUN3D6m7lVUkulNPwy2EXTIwtCtzJ5uf
 bCJUGiYXEx3hODMSWD+6oOClSyzBZ19rwhtWCXNzs7kis82VbM42tThi/EWWPGgmXwJ8
 l85o0nnGI6j7Tobc/COdVIokPldAEXJdlIFuMgrsyl2nFCOKYUURcJZUk87AkpliFfUZ
 7BcbLRPSZNUb49k8rYpBHB5XuFHHmc/vbBkswXm1r7LBvEsN/wz7pFpfD9+eNFY8RtYl
 xcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782702837; x=1783307637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIf1UjIu4HobsLfku1GIoLJNf/dF/mUSSo+eQGmmVZs=;
 b=HoM279RZ+k+bfvjQ33w86Y1N7Xx7tMysc+M43+cZd4Glu2NmVmyQFgvnKDjeZHm0xF
 UEzQY5sJp/xwQUTQhwrGH8bNIhVLTAzM5A/e8zNTVIbjCmLZadCvRzKIsv1mM6uX8lKP
 ycdJOH/qAb4DWCydeJd2dTb3ZLtKHsBXHMgnv+cKgsuhjHYhAniHD9g4wAChzmbxblsQ
 hNAmW4+OweAHgCHEaSgohLfhKFzM+xcWhRJ9mUxHdbHS/zMq3mLclfVvSvSMw0ItRRCF
 IxZibm7A9PEY59qrU1uw1fvJLMw6IgtzFBWnoi/X1Jdt6HJutQosMEaa9ZaQ6xVW5j1c
 SkNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjyT8C97jiQLPP5YSgJ7QrMzgJWFl61vYD5XSU0MszGLtsUbHDBLxTg2Rt7ZIaWD+mdjwpcQ4wwtY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUE0x7O+tcJNYrPf905upcb/wWEz66+OGM82YkNmQIEG/qGehM
 tJChzb7qmF7oxEzNNVmpxjG5cuR2uby+GVHX3f17/2mZTzmFlPUjgkoY
X-Gm-Gg: AfdE7cnIWv29ydwqMpTTjB77jTM6vXWkI8omBcCQtKyQn8LMIGgcekx3dYcU4Erinhk
 PaA307tpGSjbE/q3WaGdS4981xNoOMzS+9PTCmf3LDce5AQGEcrkaKlRylP6wIMEHOpW95izr0s
 +fmGR5g2RNIUHerXtsDgl2d/SyKMi5uPJPMg2X+/aaQMWUhQkBQ8xbSR5V7rcFm8iuD6yaWkMBk
 PD0xPBGBau5eKhOyambALDMNLMG1SG51uUpA9XHuSyMxGU2CS0sdkaVDtdlDZY/9EQa6n+aTsl8
 7HINL0i66tM7pGBhUwJ2Q49P6B/dKenhOA0yEN/2gDs67HSBwbIY7PgF/Ly8ywD9chckMRySjDu
 OqbTS/hab4JcPAjT/Qa9/DjGV0yS+Oeg01b7asJVeYyZeT7pR/ONVVp4uhrYzxzj7dWkG/xTsZW
 cZQseywlBsJg+2d55+89tKrFh3Pyvn
X-Received: by 2002:a05:6a00:94f1:b0:847:88eb:1e00 with SMTP id
 d2e1a72fcca58-84788eb24femr987190b3a.49.1782702837428; 
 Sun, 28 Jun 2026 20:13:57 -0700 (PDT)
Received: from localhost.localdomain ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a4121fdbsm10761359b3a.51.2026.06.28.20.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:13:57 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner <phasta@kernel.org>,
 Akash Goel <akash.goel@arm.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH] dma-fence: Make dma_fence_dedup_array() robust against
 0-count input
Date: Mon, 29 Jun 2026 11:13:46 +0800
Message-Id: <20260629031346.3875683-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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

dma_fence_dedup_array() returns 1 when called with num_fences == 0:
the for-loop body never executes, j stays at 0, and the final
`return ++j` yields 1. This contradicts both the kernel-doc ("Return:
Number of unique fences remaining in the array") and the natural
expectation that 0 input gives 0 output.

All in-tree callers currently filter num_fences == 0 before invoking
this helper (__dma_fence_unwrap_merge() bails out via the
`if (count == 0 || count == 1)` fast path; amdgpu_userq_wait_*()
cannot reach the dedup call with a zero local count because the
amdgpu_userq_wait_add_fence() helper guarantees num_fences stays in
[0, wait_info->num_fences], and wait_info->num_fences > 0 is enforced
at the ioctl entry).

However, dma_fence_dedup_array() is EXPORT_SYMBOL_GPL, so any future
caller that forgets to pre-filter the zero case will get a misleading
return value of 1. Depending on how that caller uses the result, it
could dereference an uninitialized fence slot in the array, since the
caller's array may have been allocated but not yet populated.

Make the contract match the documentation by returning 0 early. This
also skips an unnecessary sort() call on an empty array.

Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/dma-buf/dma-fence-unwrap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 53bb40e70b27..364cbf79ad73 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -97,6 +97,9 @@ int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
 {
 	int i, j;
 
+	if (!num_fences)
+		return 0;
+
 	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
 
 	/*
-- 
2.34.1

