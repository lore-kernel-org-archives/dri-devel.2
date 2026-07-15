Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FA6C44513
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F1C10F1E3;
	Thu, 16 Jul 2026 08:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rmUMAKGZ";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AC410F130
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:16:32 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cacf197759so40564755ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784139392; x=1784744192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4IcjMhwypTXX14WXh1GVYxiUX1ayGU/csb6g5Y2UiV8=;
 b=rmUMAKGZRAIFQsIeT8yjt6wWzuwzlqMJRcL0sDoxltpVKp/hTBLzkDtN8S7E/o/KLW
 NS41/J5+7zjc0AX0J1P0B3s4UC3l14JcRTLCrvqwChuQWsrU6EEEbBZJgehl9rh/Xo9O
 6R1Cxr4mukJyszkS75j6PuaSYtx5bMY1N60GOAszlWGaPdQ3z1MdgafHOlVcHMkOMpfo
 6PzdB1LrQ44QQpijs0haPuGIuKmzjXFXhTzDYzUyqtMGn78DAYkz4s3zaWivhHPZsxSy
 gtYEepyeVbCJJjwWUnLwMuJ9nGHRXT2V7wFKK1FVdSGXenbvghR5EqC6sSCGP0zAXftj
 rOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784139392; x=1784744192;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4IcjMhwypTXX14WXh1GVYxiUX1ayGU/csb6g5Y2UiV8=;
 b=QsuSnw8QuFhbduKqvv0rZYSSImi0cBA9RgDyzHCNxi/UNDE7bR/F0b1KsJyVuCY7sK
 dYsYHLqY6VqGT6OYqrV9lbAF9x/JK+ARZbJCs8lC8HNLQMmJLXO60A33aEesoqjeOHLf
 UEy22QiQiZtZo+c9Zd5HLaxTtpa82BKweMo9nl6NAJpra6TQ25pcj00Ehaqom3zF1Lys
 sd+7l2QCWE6Faq6/0ygeCsn+9O6KfSfhZvP/RKf5RNmWrZGs7pcvy541T75/oaubP3qe
 L0zlXRsscVAsQzymv9DFoZOSOckUGzp4ZD0g+I51lQMm914OtMgovc8+tw0bGX8jWiqU
 9AQg==
X-Gm-Message-State: AOJu0YyNJQ5OAbIReF9dLo0QaIYgYVX5iur37jQF2EN2CqW5z4WmfOHS
 uNTwyq0UFhHfA7vy5Q9GuUUpd32tHiRiIPFjZ4f8rouIX80j2JcoMwH5
X-Gm-Gg: AfdE7clgIhTqHAUKd5134iVzCKoGOqyaCniNte8E/xl7/c/2CgypdqWfg+axFhbuMai
 Pjug+87ohtjXIcSM/NXWUTWsPiutZmL2Ilk3sSrr8+bGl4/iSWDsAyvurdHnrDg15dlsujMxPBc
 6bUnzaYj1s/RzaClzSGUzCooBdORRGrytHP+5lcNnt6o+agsph9gctXaKrVR+AgzFNcdkkAgu++
 KCXB5Z6+GV12QN6IakIDxwKkJhC5oaCnth5xLtRau61TnO5X1iqtAw9Bz/xncgZrLKIjEjOALSN
 6uJOVh0t2pxcygcYgtyy6cibHvrurR0tN389NeeYaIFD0WxKUkskXOyWH7nuuJUc6J0kCNDvek2
 yaMMI1cAJKNtDsnBJqiRCfKtZ/pTcuef8TWfvyBiSR5mrwuCzu42BvNZA05I5yYtpXypliXnTyw
 yP2WIun2x1RN5cQCxvQ4/tZ07p1LOcmSj7sY5YhRlZHAJwOr+JaGfrP+Dm5iU=
X-Received: by 2002:a17:902:f645:b0:2c9:fc14:588f with SMTP id
 d9443c01a7336-2ce9ec0f95fmr181359435ad.29.1784139392357; 
 Wed, 15 Jul 2026 11:16:32 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e3946sm6817295ad.4.2026.07.15.11.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 11:16:31 -0700 (PDT)
Subject: [PATCH v9 5/8] drm/nouveau: Use hmm_range_fault_unlocked_timeout()
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
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Wed, 15 Jul 2026 11:16:30 -0700
Message-ID: <178413939024.1155966.6246787744253724390.stgit@skinsburskii>
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
 drivers/gpu/drm/nouveau/nouveau_svm.c |   20 +++++++++++---------
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


