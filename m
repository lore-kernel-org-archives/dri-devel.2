Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C67C531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F9A10F189;
	Thu, 23 Jul 2026 17:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLhq7Qya";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A479710F1C2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 17:36:56 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso981442b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828216; x=1785433016; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/3EHZQlaXq9sLmhVgtuP5ODA2wxc36yvs54yemcncOc=;
 b=ZLhq7Qya/YSzA+8eG5ACSRxKnyEuHU8/+Wgz14+FUdYxp2HBpQFwhB6PydHR3beucT
 /luFIXwpAwV5otRaJJQ+qMXYeHqSgsJOv/78AZFqjyXV1/JL8RYLBPoCm3HDfrr7kH6i
 rtlmUkEf/nunvPAaZBCyU+eOuEEEVjwANh7upUOPR1NiEzqYypYTnO7npRWlGopPpx9b
 AoqtQtw6BKP+FRIUiFz1Kxfy3JefTKKkJp8E5NMD8ptb2hYrISExe4p/eARnAgayRF7J
 qy+VRQ9oxmFJJf3aeesL+6vixYujbrxCWjFIo/MmWJwBEbOQhR6c84pq6K/j9ll+KS2v
 kWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828216; x=1785433016;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/3EHZQlaXq9sLmhVgtuP5ODA2wxc36yvs54yemcncOc=;
 b=NNECdPeFtdgfcU7oILrVFmFlk/jgyz3Q2ukFN/IMqB/F9kYUaycOV5RySRZXFPgfOX
 Ao6QUI09s7Qbl7Pbs6ZwPLFGelcA2h9Q02sRJpIGnt85LWLcDT/Ee98GQCo+L6Pf4gU7
 EucuyDXtVMXkZQdYkZ9qjrC+YJ/fMyFEb/lYDW7qCA0l6aho1cN4W2PHbzV2RO7Z0Sln
 b99+nwqOUb5Wf2TkBwH3MkV8EsejqT5/kOfrNqyZw89QiTN2I6+itbtTbYl/QbUNf99S
 FGNunN/GCAjUeVk2WaZBh+GWmc0Mm+1X/twz3jTDLXEBzjxrA3GvBF2AQzK1LYJwPsVv
 AzAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTJpiS1Tc6Od1g4W4ylPe3fc1UKVTKJOnT4up6T4SdhsQovT49l/VHPxlgxZqHTOvsgB0UeQGfSP4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzok8EK+ZNeJx2YrzVqp9HdNZlU2jGQwbfX8xVPguUn1GjdqNNo
 BnaHlDx+l2PBkUV4lP0D5ceB4qzphM055R+V1SO3kF9K3ScjO4n5GDWR
X-Gm-Gg: AR+sD13l5EDTWv7aVz8oKviSBDtMInUcxbV2vOL0fJWxQkfjqYiHt1y94uK7QM0i26r
 re8hT2j1RPV5qWD3wU7BXxbt8T/0pwcf5rWhHwDsoan7fy5kXaGEppsKS3NRs7iL8wFXRwCDW3C
 qwLhcO0DZxC9aI3EnyyL8iWWJYWfA5JaByHh4TEDD9bLTC2mfoLJdWfmkaNp+Zgkq4flMPiVZRz
 6Kh7iqluKqSJEn/kg7Gc58SPsPOcgtxGuee7Dd4sJ29NQT5mURpYcU3+uJ6sdXouonlJ3EMYLOX
 3WjAbg/nehadc+lQ4d57XjY4KAWVHcSg1xs02XQDSNudLrD0QVAKTpVDTAvutgBz+8BYXcn5gd8
 acCoL4ozzn3OTmXGkQ0Q+mSUBfL9u5XTomBsi61OGdPaUpmudLtvnGoymzIyg2iv4fgSIEBc5pB
 rByZLIYCLQkXIdeNJnLwe1GFQfyp0QeTRF6rBJcHRjTpMc0Ox9
X-Received: by 2002:a05:6a00:4482:b0:848:47d3:47ec with SMTP id
 d2e1a72fcca58-84e2b8ab6d2mr4797080b3a.31.1784828216068; 
 Thu, 23 Jul 2026 10:36:56 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e20622dedsm2691612b3a.11.2026.07.23.10.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:36:55 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:36:39 -0700
Subject: [PATCH v11 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-hmm-v10-v11-7-c55b003a4b61@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828202; l=2650;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=Js9Z5fScNTLs9yZDEPq5MMQDWBFdccrrYdkvKMfBR0c=;
 b=UoKX2QEi16TQG/XSPiXepu/KONklG+8l1kn86LgWhqxQQe32BnNrpIu04JJYOeap8yhmhRNnI
 Xgchah8NIfnDwgLdxf/plAUECr/N2GDtTgg00z0Czhp7vw9hyXoBoqQ
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
 drivers/accel/amdxdna/aie2_ctx.c | 23 ++++-------------------
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

-- 
2.43.0

