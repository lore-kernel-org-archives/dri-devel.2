Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15134C44503
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364B210F3F6;
	Thu,  9 Jul 2026 07:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIarAfyR";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0C210EEEE
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:47:25 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cace91f112so40299355ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783453644; x=1784058444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WqmeYeEILR9RvWotHFEqmi/tcbmYPgYQ90HTJiqdd/A=;
 b=hIarAfyRvji8GY0YMYmTGYIiWCldkVOsO3e6YDnnl9rr3U1pp2pzmdZTL30sDGM2Rj
 /hg+txXlcumWH1ejCM585rTAU5gkNyjcSMvRfbiCVlEPrdF86PCUsI/wlX58sS1snIiq
 jeTgzT962mZIA0WJhc6FO6WE3Y1u8gmI16Gh14BrpYBr9dDw5sgQE5605FVMmQVsKUz0
 DKdHLcDu1K2B3uSdXPIXXAJniS7lzDaSkTeqhf8nnWDj8ZfmRjpnEGShhqletAAklOZh
 QTPq3KHfYOfBZjtajnviY5ZGC738nr6Hi2zbpLWJ7GfMA6ORwjJJyhheHd+i0g+tUeyS
 NbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783453644; x=1784058444;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WqmeYeEILR9RvWotHFEqmi/tcbmYPgYQ90HTJiqdd/A=;
 b=YPVgzka+1xfHgdG4VQBP1YbP8IJ4L3LtAvlqD1q5560IJgJJB7srOCTT8gDrIBn9K5
 sV/mJdQmJAChdJKGtw1OkrYZH7YN3EzdZL+r9nJeFlzzkb+7Ihhpd8XqkdhqCmooYN5/
 bkUyxaeyjg5q5sdbwySi6AbPtrmmXQ+55Kb+grl6dxuaf5txYkhfViN77JAEEICg1dQQ
 UcmIq16lFjC2WoGBFYRMDuqIuwnfyQEfUR891Q7VTTc5EAI1TRL6JlqY87J03891OHRJ
 y0MtVmRI4e1jnYxTlmOvvHCwNqnvnRArY4ZbE/udTsOPxU8k4gDN3/SwR86o2fQwbK1Y
 IHeQ==
X-Gm-Message-State: AOJu0YyT8N5ZdbcScq6bpNSkuZEdXt5lPfSlNwmj4eZn3J9aOSt1HBYJ
 quSx+C06KaP2DrX49Gg/olHwUAm4sQ+Azh3cB8t9dseuYcR1Q8Ihue/g
X-Gm-Gg: AfdE7ckeZpQKm/htntlSbJzKLKjovvlF3Epi+8oJcGsY9G0jwJm0Gec0rjyRBTOSlJv
 xBy8BNoxYEbm/fxSiGQdT3Ky6Qp5556tgYbn/nSBFajVUdhGwMnvw3x772mB5vKQhCqmqhhV1QU
 YH7YfJL6pOLeh5C3B6qNPLn7NZmJ9Vh8Ze58Few8Pf2JKLBMF18FO0dIjEtGp6FnKdeWZMfpptv
 55w5n3YDZtp2GZaSqYB6rg1SulDdaMRMmPYjRWSsfmkNFXrExWwbzwpZM5fBbhzTNG/OlmjIpLG
 4aFKKovWVYRWaC3H3R6glvx4GA+iRfikVb67MB2NI7IWpobpSG4phwBFXoyHfUFr4blRqGOn+/W
 musz4UR/1oajcsiurTId/TBLZhISlCWKhK69v25ghcFkrGdl7ZFx61G/gPoKY/OrrZPzuu4x5l2
 ZNezrU4tjJiDx9+5QXNrVpP8OzKr9gIcsRAa9JTPp00P3s6jEIGn7RdLnwzYpM7oxrjxMntQ==
X-Received: by 2002:a17:902:ea03:b0:2c9:d8c6:1dc3 with SMTP id
 d9443c01a7336-2ccbdc41f65mr54794995ad.0.1783453644502; 
 Tue, 07 Jul 2026 12:47:24 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb7e9sm17819615ad.10.2026.07.07.12.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:47:24 -0700 (PDT)
Subject: [PATCH v7 5/8] drm/nouveau: Use hmm_range_fault_unlocked_timeout()
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
Date: Tue, 07 Jul 2026 12:47:22 -0700
Message-ID: <178345364273.660027.15274510603185163961.stgit@skinsburskii>
In-Reply-To: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..ba93273341af 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -683,15 +683,10 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
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
+				       max_t(long, timeout - jiffies, 1UL));
+		if (ret)
 			goto out;
-		}
 
 		mutex_lock(&svmm->mutex);
 		if (mmu_interval_read_retry(range.notifier,


