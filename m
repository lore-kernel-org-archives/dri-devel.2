Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F2606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkL+ZB2a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB311123A9;
	Thu, 12 Nov 2026 22:09:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BA81123A9;
 Thu, 12 Nov 2026 22:09:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF1774646C;
 Thu, 12 Nov 2026 22:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B891E1F000C4;
 Thu, 12 Nov 2026 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794521381;
 bh=eKtXaU18XWDmrm51FUDVoZxTbd+Jzy0nR5+iJLVT/Yk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jkL+ZB2a4fUwx27qOVIEV+ckZQ/gSjMPP3h29FpAk4PlOjb9LirgSuhw4zlbzw+TM
 9Ys06V8UM5KILDGz4kcDcXHt+QdS6IwpIYUNxkrZqklga3AHuZI28CAqsvB6rRKJQy
 wQcEkO6mrSXip4E8TRbKqS4h6HYP8KFB6IJW4x5SDlh8OyCRis7XriaS13txq3yP1j
 VjXVrSbG1x1f/e5ytJhhy+FJeef365J72+LX8ayB4cIYe5oD5G+I9hI6Sh9TFxGJH+
 0jiRerzzmMrSsTaodVJVb8P7sjITxHF4ma/FIxHnXjPAMdZXmioymUii/zY17u1NVp
 yh2WD0W8m2Nkg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:09:00 +0100
Subject: [PATCH 4/5] powerpc/spufs: consider vm_pgoff in
 spufs_mem_mmap_access()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-access_shite-v1-4-988a5c470db2@kernel.org>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
In-Reply-To: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Willy Tarreau <w@1wt.eu>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=david@kernel.org;
 h=from:subject:message-id; bh=PQPxNnQpVVFHjjbqHgG191KRAqKJhGnNL5teRs7niOM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+WfwvmXrNbfL1DTr7E26IRJ7XFjTl6ms4FpmrJVG/6
 pnretUTHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzkURQjQ9dyu4gpkQX8Sr0C
 BvVLG3omPVjE/fyifL1Ezg6x9ZxvgxgZpgskTX6gKFW7IzR7p2TykkUhix0bJs+usdJ6c5drnc1
 CVgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

spufs_mem_mmap_access() calculates the local store offset relative to the
start of the VMA and ignores vm_pgoff. After VMA splits, debugger reads and
writes access the wrong part of the local store. Mappings created with a
nonzero file offset have the same problem.

Properly take the vm_pgoff into account, just like spufs_mem_mmap_fault()
already does.

Fixes: a352894d0705 ("spufs: use new vm_ops->access to allow local state access from gdb")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 98c47bafaf678..0a46d6f7178ab 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -248,7 +248,8 @@ static int spufs_mem_mmap_access(struct vm_area_struct *vma,
 				void *buf, int len, int write)
 {
 	struct spu_context *ctx = vma->vm_file->private_data;
-	unsigned long offset = address - vma->vm_start;
+	unsigned long offset = address - vma->vm_start +
+			       (vma->vm_pgoff << PAGE_SHIFT);
 	char *local_store;
 
 	if (write && !(vma->vm_flags & VM_WRITE))

-- 
2.43.0

