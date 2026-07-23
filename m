Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BA0C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 21:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6C510E602;
	Thu, 23 Jul 2026 21:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PqDGtK1y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E241C10E602;
 Thu, 23 Jul 2026 21:22:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 738B8408E9;
 Thu, 23 Jul 2026 21:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E381F000E9;
 Thu, 23 Jul 2026 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1784841764;
 bh=8LsF46xxakxlsARFJxGTWxEVy+kM0PIVoXm+jBklc8Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=PqDGtK1ymZc6iwXzb09CtmFYmLViI3ZUzwC4EZJzeq9zwSf91u2vNh/4wCIJIHPWO
 e15iO8gkDRLbbRBA2tojf2jKWmot7imPS0HbTnDJI9D1VtypOpQwHATciE7rioefeK
 s0fKBNhwMPvzspt/Hs40GfWyqW0dMZJpQhg7C0tk=
Date: Thu, 23 Jul 2026 14:22:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuah@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Min Ma <mamin506@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-Id: <20260723142242.5d3f87208d47819d873ae458@linux-foundation.org>
In-Reply-To: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 23 Jul 2026 10:36:32 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:

> This series extends the HMM framework to support userfaultfd-backed memory
> by allowing the mmap read lock to be dropped during hmm_range_fault().
> 

Thanks, I've updated mm.git to this version.

AI review suggests there may be some problems.  Sorry, I don't recall if
these were considered in previous versions of the patchset:

	https://sashiko.dev/#/patchset/20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com

> 
> Changes in v11:
>   - Reject unstable address spaces in hmm_range_fault_unlocked_timeout()
>     after taking mmap_lock and before walking page tables.
>   - Compute the remaining HMM timeout budget before the time_after_eq()
>     check in drm_gpusvm_get_pages() to make sure it can't result in zero
>     and lead to infinite HMM range faulting loop.

Here's how v11 altered mm.git:


 drivers/gpu/drm/drm_gpusvm.c |    4 ++--
 mm/hmm.c                     |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_gpusvm.c~b
+++ a/drivers/gpu/drm/drm_gpusvm.c
@@ -1422,11 +1422,11 @@ int drm_gpusvm_get_pages(struct drm_gpus
 	struct dma_iova_state *state = &svm_pages->state;
 
 retry:
+	remaining = timeout - jiffies;
+
 	if (time_after_eq(jiffies, timeout))
 		return -EBUSY;
 
-	remaining = timeout - jiffies;
-
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
 	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
 		goto set_seqno;
--- a/mm/hmm.c~b
+++ a/mm/hmm.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/mmzone.h>
+#include <linux/oom.h>
 #include <linux/pagemap.h>
 #include <linux/leafops.h>
 #include <linux/hugetlb.h>
@@ -806,6 +807,11 @@ int hmm_range_fault_unlocked_timeout(str
 		if (ret)
 			return ret;
 
+		if (check_stable_address_space(mm)) {
+			mmap_read_unlock(mm);
+			return -EFAULT;
+		}
+
 		if (timeout && time_after(jiffies, deadline)) {
 			mmap_read_unlock(mm);
 			return -EBUSY;
_

