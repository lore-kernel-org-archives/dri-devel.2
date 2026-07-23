Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3B6C531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B816310F1B7;
	Thu, 23 Jul 2026 17:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GIBI3gAV";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12ED10F1B8
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 17:36:53 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-848595b338cso1031764b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828213; x=1785433013; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WVIK4CTS2ebWqFuX16f+6TzH9lK4l3CZHr+WHLsMqrs=;
 b=GIBI3gAV/auUOjUKihcBSyBtMaOATzPUlXKGtM3CZYTu2BuDNcG5CAtu7K2srC+mZH
 4QMeGJyD3q0s+QG+Cc1pPdfgDA7Ck8vRUsxUO3z5LQauPXf9Cbjlq8Msz1HVt+IxZoi1
 0u1W/IJDtNeAwUlI5l/l6q8TGOrPbprEiwE0X2Pz/I7OAfbghIgEHMuJiTEnQZRL7PZ4
 n7AcjuhnpKuuwRvVcXUcvBGoCu1T1TAqsJX2yT2iyUMgqdEfgFX4UBDaOjo9K2HCpkEd
 Vl4a78S/cfsVnyeJjL0vfYVZGuDf7yRSt5nhPVvuP/ouit6dHrsxQg6YrnsbPmk7xkti
 LMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828213; x=1785433013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WVIK4CTS2ebWqFuX16f+6TzH9lK4l3CZHr+WHLsMqrs=;
 b=QymplD0cBi0zsUcqSoobqB75Ry/WupSWP5xC2ZPjRwGWmBaRZeci0Mg1W9yiXRsUYc
 kWUBZdNWsgMTN8kxYTpmaRcvjkTgeR7zCH7Y40OMnb/z2Ya15p/EveQwT7JpMkqTYaEM
 phwF1LAYstn7PzjwAuS5ZjQJGYrLoEm45RASJyNRnqrDk3OtJnimIl/Qfju8AGBmbrzS
 siE/J0Gba/gRztxRQwZhOfyZfgtg2WROUZYiq2/dHHqV/CiGLSrP5tJz7bqqR6bYjmh/
 /dMcH2d9VnBM/gFNznWIZsd/WujA9zisk7rVXEzTiztGXF7WVyNVEMTzT14ht5m8p7mv
 TEBw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5+lG0lt5wguwFKBfsqNA3rX+olJIFT23JmolX+SQ0o1mZ5YYjwJULbyabiDAtgZraXAsViqt3wb8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzZAZ0ckyKPOgoSmvuLRE/F1BYDnNbRnMPMK6v2rUMMOx+rkik
 oIIWQuRp4HnJlLVu+Z8L8yEmTqaRMgDJAxliSRMrNKmXDiKp6F5JXOh0
X-Gm-Gg: AR+sD12Fub83ombx1JQoqO7+CYTG53vL3cf+c7IEcpHhKV/ZuPMGKjcEUCNUaY+ZV3x
 Zj85xgIPOHmDxUdwoFDY6iqAmYJp2NjrJrjnIXkqecamQZovqKlAH8sio9gEMjy7Fyf9r6a0926
 J5vX2ryHW6aUgG8MA0jg3NxWrp1OXSgDIk0zDpiqmBuFA6kMVw1KkvCSlfWUiMolzKFDCMNxIbP
 WToBtzOPhkbTARow5KLcqtQfbIfb0RiC75dsIJmc3Wx8qjtlODA3Ml4Ro3to6ManPtlx2QApJiK
 gHmFo59l7+itiYCX8JnCHu5g+jYNm5lNfvZwsi8Hsyqql72DKLezxLW68xi3fjEUSKqkShFo6NI
 eJtwLOBLuHKaCQiqy6dHuK5EnK7BB/sY0LTT68qLQTxSowSBpnU0+Zec4qkA48uFVVUFvDbB04T
 5SqIjxSRnpjmNq16TFxLqAdr+VYkMQDFMlGcu09Xfdx/qNKTS3
X-Received: by 2002:a05:6a00:278a:b0:848:42d0:bc91 with SMTP id
 d2e1a72fcca58-84e2b7f4d38mr4894542b3a.12.1784828213088; 
 Thu, 23 Jul 2026 10:36:53 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e20622dedsm2691612b3a.11.2026.07.23.10.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:36:52 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:36:37 -0700
Subject: [PATCH v11 5/8] drm/nouveau: Use
 hmm_range_fault_unlocked_timeout() for SVM faults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-hmm-v10-v11-5-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
In-Reply-To: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 Oded Gabbay <ogabbay@kernel.org>, skinsburskii@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828202; l=2163;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=KaVy0LDD2WZ56zIlG4jDVljfxrz2j27JL0AnOSACkpk=;
 b=KV2nZSPyVg1Dt5uSSiSffiKfkGgb7W3sWOI6CSqvJIxSZb1CjTMqYYugO/lEA7iz8WZFfaBr6
 LbFOvRd/oG3AQDmUr73ZTQ/tVrKY3HQM715K46T+2IVDrVm2X1nPXe2
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=
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

nouveau_range_fault() takes mmap_read_lock() only to call
hmm_range_fault(). It also keeps a single HMM_RANGE_DEFAULT_TIMEOUT
deadline across both HMM -EBUSY retries and post-fault
mmu_interval_read_retry() retries.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes range->notifier_seq for its internal retries.
Nouveau keeps its existing absolute deadline in the outer loop and passes
the remaining jiffies to the helper for each fault attempt, so retries
caused by mmu_interval_read_retry() do not reset the overall retry budget.

Nouveau still validates the interval notifier sequence while holding
svmm->mutex before programming the GPU mapping.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..58735446d783 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -678,20 +678,22 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 	range.end = notifier->notifier.interval_tree.last + 1;
 
 	while (true) {
-		if (time_after(jiffies, timeout)) {
+		long remaining = timeout - jiffies;
+
+		/*
+		 * The HMM timeout only bounds retries while HMM is walking and
+		 * faulting the range. This fault is handled by a kernel worker,
+		 * so fatal signals from the faulting process cannot stop an
+		 * endless stream of invalidations here.
+		 */
+		if (time_after_eq(jiffies, timeout)) {
 			ret = -EBUSY;
 			goto out;
 		}
 
-		range.notifier_seq = mmu_interval_read_begin(range.notifier);
-		mmap_read_lock(mm);
-		ret = hmm_range_fault(&range);
-		mmap_read_unlock(mm);
-		if (ret) {
-			if (ret == -EBUSY)
-				continue;
+		ret = hmm_range_fault_unlocked_timeout(&range, remaining);
+		if (ret)
 			goto out;
-		}
 
 		mutex_lock(&svmm->mutex);
 		if (mmu_interval_read_retry(range.notifier,

-- 
2.43.0

