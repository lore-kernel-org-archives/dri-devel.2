Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530BCC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858DD10F1E0;
	Thu, 16 Jul 2026 08:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I9mjGOjl";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF8E210F119
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:16:47 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ccf2360620so22053545ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784139407; x=1784744207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+q3csfDWWlHf03esSbv28913HL95J8hCqGqZ6tTf+OA=;
 b=I9mjGOjl9vYkBWbyALx0O0Pf6UCaB727hvbwkRo6EABA2FEdzcjmVtlIX0e9lmUZrs
 5p5W1vbitBZpOBPol0HtLycOwlYDfS2RyisXR9nqX36lyPrbnA2XZqA2mMIZvfmTJai3
 K8cLP+ZiGyY+DBvEfDXLV3dz+CMe9lDY/W0P1xuVyRcCzMSyNxpgiwNSjpY80agmDMIX
 Nlxl8P2pVv5Gs3OEgzordQ3W5rrzjKapc925AYhW+oaviVtJDBUvgSfWXbIpq+Nl5nhd
 QKJTreAmWCmBxjRh06CZJrAechmpIqVdYldXQS6QNjnx2uMTeNqqUQ0TRO4AhpAITJTA
 T4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784139407; x=1784744207;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+q3csfDWWlHf03esSbv28913HL95J8hCqGqZ6tTf+OA=;
 b=axlWymDVJg5HPtrOw48u557V++lfmxJMT4xRoKb2+X6mF33UujXIab49ZgyTy2+8Nl
 4gs0mKMGn/rW449vb69zHL/7oIXZHmDxQO9af87YTBtQy2dXIamh27w+nK7BjW3kynoz
 YNf2oKCxCqOvbPxJZ48xetkFo50S71HGesdOZITtNuc5vBav7N5CnyoZ69fxSUv/6qwC
 jcR+wZwmyMjWv183z/Hqmom9srynhQ/2ilT/b9DJzzTIxHSJI8LlXVd4VD0WzDSL1Cx3
 nHHODxUXTrlfHRgAbGpjqN4x4sTk+l4qz5jl47rky38SaGuZ/d41XIipzT2uD4N7VrVR
 Trbw==
X-Gm-Message-State: AOJu0Ywxb4DF9TmN0iMWFm4ElNK0Wcf8n4V9LObAxFLA21k+9Ah1lIxZ
 LMqSpHhhbLjZgJH5+eFosve0rG+eb15z65qyCvCLVIcoozfjKyInTeao
X-Gm-Gg: AfdE7cmIXy7EOXEOlYmQ3xKpYcZBVAa4w7aypg2sRMVGp3Nig596TpEwBa3siTR4Kb9
 cg3jIcbI3PI6ruSwYGe97OhQTn/sEBH3qMw2wZp/poutcHJd+HN8K+DkMfPr8BZVkTnmFUnClBs
 u9qqIAQxNDUtecBUgEnjDzhMfvEw98LskwXuePzi1pJot88TgzZWzTFAndQoda5fYUS+ciIFoCt
 TpPcFS1MQI7XrodvDVeH5Yhz3XBhy5cHA2jbdJnosk2sUdZif87lDMTwpciNCWsZG3SZFRaV+a2
 ZaHrT2nDPZzzYteahFWTyOCQ30mzF8WnSY0pWtcIPcm5MwuSrsmqGkkoYrCUBjhzleMG/CTeTEm
 260mdOwQAh2LThtjvWkf5CmuKqnyPj3AWTR7R2oA3cN6NidiYP/4IWsaGu7nCH/7bVnPMWt/vfB
 igVYZN69nYsZJr8yAQcX6WJlNx7C3Cg8Xypl8dg9Qm2ej7y5Ka4WgZay97mA0=
X-Received: by 2002:a17:902:c94a:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2ce9e9a175bmr176469515ad.15.1784139406969; 
 Wed, 15 Jul 2026 11:16:46 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf1055d661sm6778695ad.42.2026.07.15.11.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 11:16:46 -0700 (PDT)
Subject: [PATCH v9 7/8] accel/amdxdna: Use hmm_range_fault_unlocked_timeout()
 for range population
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
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Wed, 15 Jul 2026 11:16:44 -0700
Message-ID: <178413940486.1155966.10368807598827608499.stgit@skinsburskii>
In-Reply-To: <178413903133.1155966.3904063656020521607.stgit@skinsburskii>
References: <178413903133.1155966.3904063656020521607.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

aie2_populate_range() takes mmap_read_lock() only around hmm_range_fault().
It also open-codes the mmu interval sequence setup before each HMM walk and
retries -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes mapp->range.notifier_seq for its internal
retries, so the driver only needs to call the helper and then validate the
sequence before marking the mapping populated.

Pass HMM_RANGE_DEFAULT_TIMEOUT as the helper retry budget for each HMM
population attempt. This scopes the timeout to repeated HMM notifier
retries while preserving the existing outer loop that moves between invalid
mappings and restarts when the interval is invalidated before the driver
updates its mapping state.

Keep returning -ETIME when the HMM retry budget expires, matching the
driver's existing timeout error convention.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/accel/amdxdna/aie2_ctx.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 54486960cbf5..b5b4ca263002 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1034,7 +1034,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	bool found;
 	int ret;
 
-	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 again:
 	found = false;
 	down_write(&xdna->notifier_lock);
@@ -1061,24 +1061,9 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 		return -EFAULT;
 	}
 
-	mapp->range.notifier_seq = mmu_interval_read_begin(&mapp->notifier);
-	mmap_read_lock(mm);
-	ret = hmm_range_fault(&mapp->range);
-	mmap_read_unlock(mm);
-	if (ret) {
-		if (time_after(jiffies, timeout)) {
-			ret = -ETIME;
-			goto put_mm;
-		}
-
-		if (ret == -EBUSY) {
-			amdxdna_umap_put(mapp);
-			mmput(mm);
-			goto again;
-		}
-
+	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
+	if (ret)
 		goto put_mm;
-	}
 
 	down_write(&xdna->notifier_lock);
 	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
@@ -1096,7 +1081,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 put_mm:
 	amdxdna_umap_put(mapp);
 	mmput(mm);
-	return ret;
+	return ret == -EBUSY ? -ETIME : ret;
 }
 
 int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq)


