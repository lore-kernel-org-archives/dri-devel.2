Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDC6C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6953C10EF33;
	Wed,  9 Sep 2026 06:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vs0Mg3ar";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F25E10E4BE
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:12:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 250E7432BA;
 Tue,  8 Sep 2026 20:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD5D1F00A3D;
 Tue,  8 Sep 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788898376;
 bh=QHHORr5JJz/ySIh3gX90PJx9IHB99angztW63GXDee8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Vs0Mg3arwsVcSXEmxq5o+FmpfXNpdelLwiHrc7m63iGLN9sQgp9XuYAVxV7u4es1v
 EYlQHJVyUm+HFIzM+g++Vu0aB8BBgKEhIYVyz32b4rPamI4g9ttd0hX4qKFlcWkF0F
 vkAQ/8EILn9v1PML95T62JXW1ZTSvMN0tdnZSpv2cuRX1fFjF2eg+/l7q/LTFMI7DC
 TDTjZBO9aHEmBiqhIpY4zmmAvLfFGav5kJrIjJSZBGNNPp7yDiE9hiEMYqbnnV2ItV
 R5moZ1pKmsOpaiF3U7rO1+W1T3kkCX0UTSaLY4kcTgeJLg8nT7gpuZA4W1VkZwChT3
 BHmriro6ICMOA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 08 Sep 2026 21:01:26 +0100
Subject: [PATCH 22/39] mm/mlock: clear VMA_LOCKED_MASK over mmap callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-22-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
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
 Wei Xu <weixugc@google.com>, Xu Xin <xu.xin16@zte.com.cn>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2741; i=ljs@kernel.org;
 h=from:subject:message-id; bh=owzDO9vl5baUVRjHzuAZ7IOE+AaPo04FqzxJP0WdolM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIWZG5hfPr/NsPvDJ/+8pAC7cn//z6fOuly7nvLy42ml
 uGz7pjd7ihlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEcoQY/jvaS7b92s3ie+H8
 ZL0yzoUWRuLhJa8SN/Zl3L7Ctqru2z5Ghv1N02uV9r9a3tfQneR7au+uk7JXl3mf/rVKvjMtWFD
 PkQEA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

Currently there's a confusing mess around VMA_LOCKED_BIT and
VMA_LOCKONFAULT_BIT.

It is permitted for drivers to set any flags they like, with the VMA
already possessing lock flags.

This results in the absurd situation of a VMA possessing both
VMA_SPECIAL_FLAGS and VMA_LOCKED_MASK flags, which is not permitted.

This has resulted in mlock_vma_folio() having a very silly check for this
scenario to work around it.

There is no need for this - just clear the flags before invoking the hook
and reinstate them afterwards if they are required.

Nothing relies upon this being set during the mmap operation.

mmap_prepare is unaffected by this so requires no fix.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/internal.h |  9 +--------
 mm/vma.c      | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a86b9803a4c3..6e27d3b10c01 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -975,14 +975,7 @@ void mlock_folio(struct folio *folio);
 static inline void mlock_vma_folio(struct folio *folio,
 				struct vm_area_struct *vma)
 {
-	/*
-	 * The VM_SPECIAL check here serves two purposes.
-	 * 1) VM_IO check prevents migration from double-counting during mlock.
-	 * 2) Although mmap_region() and mlock_fixup() take care that VM_LOCKED
-	 *    is never left set on a VM_SPECIAL vma, there is an interval while
-	 *    file->f_op->mmap() is using vm_insert_page(s), when VM_LOCKED may
-	 *    still be set while VM_SPECIAL bits are added: so ignore it then.
-	 */
+	/* The VM_IO check prevents migration from double-counting during mlock. */
 	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED))
 		mlock_folio(folio);
 }
diff --git a/mm/vma.c b/mm/vma.c
index 526428753218..cb0c4c625756 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2594,6 +2594,11 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	if (!map->file->f_op->mmap)
 		return 0;
 
+	/*
+	 * Driver-specified flags may make the lock flags invalid, so clear
+	 * VMA_LOCKED_MASK and reinstate it afterwards if appropriate.
+	 */
+	vma_clear_flags_mask(vma, VMA_LOCKED_MASK);
 	error = mmap_file(vma->vm_file, vma);
 	if (error) {
 		UNMAP_STATE(unmap, vmi, vma, vma->vm_start, vma->vm_end,
@@ -2607,6 +2612,15 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 		return error;
 	}
 
+	/* If VMA flags still valid for locked mask, reinstate. */
+	if (vma_supports_mlock(vma)) {
+		const vma_flags_t mask =
+			vma_flags_and_mask(&map->vma_flags,
+					   VMA_LOCKED_MASK);
+
+		vma_set_flags_mask(vma, mask);
+	}
+
 	map->file = vma->vm_file;
 	map->vma_flags = vma->flags;
 

-- 
2.55.0

