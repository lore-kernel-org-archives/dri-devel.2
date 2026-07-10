Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA020C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4089210E7EA;
	Mon, 13 Jul 2026 07:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pkUl3JwF";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EAB410E3D8
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:27:01 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8485fad302bso1397828b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783718821; x=1784323621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=i81Mvoxwiz31acM23+HpM6LiopJwdOVnXlQ0p0m7OMc=;
 b=pkUl3JwF1sKKNS25JsP2bET0UDmcZ46g7aGnNi0AtqO4x70E0nOgOgwDWzntuVm+Hi
 EsrJ4JLqMVOZFrUcGKrIhtFHJPa6CVB2RHbmBifux4EFFYJFKCqDqG5gEYksrS53QGC7
 h9uBAOI4WcLqkFfpYxxe8v4CA79+k+u3mXBWayuOVlTWfveuBBghG58SkEIj1SDBbqXN
 XfKzghAjZNAaPw7r4kSctYBpLdyFYURmb5j42aMS0RQtwR7tMr/2N2/OHvpQK7ApWqB1
 Jp8Q4af4GVK3CawBTV1H1v8Wm0AjJZDbn9AHYklAsYtgJoQ3giwIHejwaaEp+EHu+6gA
 WhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718821; x=1784323621;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i81Mvoxwiz31acM23+HpM6LiopJwdOVnXlQ0p0m7OMc=;
 b=RpHAKF47v0PrwKHkIyNcE/dAfyxwq0mStxWeQeaRjMFRpTWQ6ownMVNfjj0bha2M3c
 bMcgpXTSdPqabOVfwFWGQjBd5udp+WuKNkKXw3H9PtXbnUp/fCV7loFXQxl8y7X/hdpa
 vWfLpKepjy/nA/01De9Rpzv7ohC6xzHO0axBdMEsju63Jmndo5cqZrqZuqMeajRe/+h4
 SRZp6tH6902RgSn38gh5NtbGbZbn+t7f4biBRRWLoMTHezujcy5X5wRgEBbjNjFwUvq1
 jSO0dN/QXVPifcuC1bHUpjKM7XiYz91Lm7uZh5GgjQm/yRKk0KdboyHdOPzDPcnh7/4A
 TpSw==
X-Gm-Message-State: AOJu0YwdzhSlcoLl2WDSD7UeNpE/AzZAshBHe9DNs4Hn1dw5w769baUf
 05eh6wxKwtQxLuER2qlDISf4cvBj/oHvE7Qe73UBlLPOn99EQam0VLsS
X-Gm-Gg: AfdE7cm9hsEQxowe2eG/2YPC782voMOQK/ZzuffdA5Ec2K22UgQKQXmw4JsduUyKjqb
 NmTLqorG24p/319i9YtNzlh0u1fDW8VAPQL8aHzd8hAnrW78NOyhy4fRE4fIKWQS8B+NvyTQTV9
 G5C3wsh7IDPyU2XBBgUTdmIQti7Y7zy6ezeLMvxB+3YKmqj6iHrN5miw7MGGZBTffmwRIi4WUdn
 G4efgYocjX41W2g5RnWxrda6bQEQ3pSKTSxAiD3FdxoCiHGXb6Rogwi+sXst0Xj9Vwu3uIWzDSZ
 6Zp6CAmmfdz0cUCqT1UePAq89WJf6bQBEuukG2DBpBClA+EoRsLNXySrKU++xbvVw1aIO9Atit9
 p49twfWZTBiFe7FjLV14Mao5mZeaW59MCO/jbBSOPM6Ym2X2rj+z1Z+mKzPZHc6pcz2eohQBj8X
 MlA7TK0EwE129K0Dohu1yFJNlCTAuG54zvDbB5F1XeuSUUannFiHNyuX1A4X0H10F7XSb11Q==
X-Received: by 2002:a05:6a00:a0e:b0:847:7f38:27ad with SMTP id
 d2e1a72fcca58-8488975299emr661948b3a.53.1783718820769; 
 Fri, 10 Jul 2026 14:27:00 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8482b333d4fsm6649821b3a.54.2026.07.10.14.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:27:00 -0700 (PDT)
Subject: [PATCH v8 5/8] drm/nouveau: Use hmm_range_fault_unlocked_timeout()
 for SVM faults
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Fri, 10 Jul 2026 14:26:58 -0700
Message-ID: <178371881847.900500.8789369230260725500.stgit@skinsburskii>
In-Reply-To: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..4cfb6eb7c771 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -683,15 +683,11 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 			goto out;
 		}
 
-		range.notifier_seq = mmu_interval_read_begin(range.notifier);
-		mmap_read_lock(mm);
-		ret = hmm_range_fault(&range);
-		mmap_read_unlock(mm);
-		if (ret) {
-			if (ret == -EBUSY)
-				continue;
+		ret = hmm_range_fault_unlocked_timeout(&range,
+						       max(timeout - jiffies,
+							   1L));
+		if (ret)
 			goto out;
-		}
 
 		mutex_lock(&svmm->mutex);
 		if (mmu_interval_read_retry(range.notifier,


