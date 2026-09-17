Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC11C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0AA10E95C;
	Fri, 18 Sep 2026 07:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="byPXcWCB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F2110E0AE
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9E7660216;
 Thu, 17 Sep 2026 16:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0441F000FF;
 Thu, 17 Sep 2026 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789663126;
 bh=lLYk3o3B0/wt5kKG7m+ibDGyo2yi3t47XmKybZiJ1Rs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=byPXcWCBqQ2k/JxAm0NOmPWYbT6DeEbK75BKRpWKfzp7+QTfB6gD6Jwr5+NtnYFbF
 vANP/UXdPyvEOeRBtYogU/57/nulluJHybMAJOC35jvz4xD2wPVFBI91Aw+YsOC+sP
 6aNwYISVKfiJjWMFVvcA55zNh95pCsarrRKnXr7KWJWILUFd3HUcYcuPpIxzLPlFhY
 ycbrt4mv4ZS4RVqRxw1P4RGv/E/7Aff2Vt9c+5Yo5G9KPZl7lvt2riK4lE3Gcrd8f1
 cHDUqHsQw2H28rT4egz7snB+IabetMBAx5sqYD1rZ08IBRgGxzunW/DzNmOVsFjYOB
 FaMAt505vgJZA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 17 Sep 2026 17:22:40 +0100
Subject: [PATCH v3 31/40] mm/vma: introduce vma[_flags]_is_persistent()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-31-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, 
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
 Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Michal Hocko <mhocko@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Xu Xin <xu.xin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
 linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3843; i=ljs@kernel.org;
 h=from:subject:message-id; bh=g+DP477oZGptEtdcgQ46pNPCZKGp7Qm9RMjCOcTExak=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLWCB8u6fNauyHdvmVJ5W6uovZ+1YSTvTFcx3vNJj9Ue
 7bq3cw3HaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiIpxAjw8Wj14sVjnlLqEpf
 alzq8/uu46r80HPN9mFnBc0937Q0H2P4H2is/PxS+84+HRY92StXjVg7lJTdbzpWtfbv3MIVqFD
 GBwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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

Introduce vma[_flags]_is_persistent() for the purposes of identifying
mappings that are persistent in the sense that bytes to the mapping stay
there, and bytes read from the mapping are the same unless changed by
actions taken by userland.

Kernel-owned mappings do not fall into this category, as their owner may
change the contents without the user having initiated it, and nor of course
does memory-mapped I/O.

We exclude fixed mappings as these are singled out as being unmergeable and
so cannot be guaranteed to persist user data.

hugetlb mappings are fixed mappings, but their contents are entirely the
user's, so they are explicitly carved out as persistent, as the MADV_DODUMP
check already does.

It excludes droppable mappings, which by their nature are ephemeral.

Use this functionality to update the madvise MADV_DODUMP check to test for
persistence rather than open-coding this.

This replaces the VM_SPECIAL check which means it no longer checks for
VMA_IO_BIT, however this is safe as we have established the invariant that
only kernel-owned mappings may set VMA_IO_BIT, so we implicitly include
these.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 mm/madvise.c       |  4 ++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 154fc25c9efa..0579e6afb19f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1741,6 +1741,50 @@ static inline bool vma_can_merge(const struct vm_area_struct *vma)
 	return vma_flags_can_merge(&vma->flags);
 }
 
+/**
+ * vma_flags_is_persistent() - Do the specified VMA flags imply that the VMA
+ * contains persistent data?
+ * @flags: The VMA flags to test.
+ *
+ * Persistent in the sense that - if you write bytes to the mapping - do they
+ * stay written?
+ *
+ * If the kernel or a device could write to the memory independently of
+ * userland, or the kernel could arbitrarily discard it, then it is not
+ * persistent.
+ *
+ * Returns: true if the flags imply this VMA is persistent, otherwise false.
+ */
+static inline bool vma_flags_is_persistent(const vma_flags_t *flags)
+{
+	/* hugetlb is a fixed mapping, but its contents are the user's own. */
+	if (vma_flags_is_hugetlb(flags))
+		return true;
+	/*
+	 * MMIO mappings may not store what is written and may be changed by the
+	 * device. Kernel-owned and fixed mappings may be changed by their owner
+	 * without the user having initiated it.
+	 */
+	if (vma_flags_is_kernel_owned(flags) ||
+	    vma_flags_is_fixed_mapping(flags))
+		return false;
+	/* Droppable memory is discardable by definition. */
+	return !vma_flags_test_single_mask(flags, VMA_DROPPABLE);
+}
+
+/**
+ * vma_is_persistent() - Does the VMA contain persistent data?
+ * @vma: The VMA to test.
+ *
+ * See vma_flags_is_persistent() for details.
+ *
+ * Returns: true if the VMA is persistent, otherwise false.
+ */
+static inline bool vma_is_persistent(const struct vm_area_struct *vma)
+{
+	return vma_flags_is_persistent(&vma->flags);
+}
+
 /**
  * vma_kernel_pagesize - Default page size granularity for this VMA.
  * @vma: The user mapping.
diff --git a/mm/madvise.c b/mm/madvise.c
index 0922d5f07a12..e15973292f94 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1584,8 +1584,8 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 		new_flags |= VM_DONTDUMP;
 		break;
 	case MADV_DODUMP:
-		if ((!vma_is_hugetlb(vma) && (new_flags & VM_SPECIAL)) ||
-		    (new_flags & VM_DROPPABLE))
+		/* Non-persistent memory cannot be dumped. */
+		if (!vma_is_persistent(vma))
 			return -EINVAL;
 		new_flags &= ~VM_DONTDUMP;
 		break;

-- 
2.55.0

