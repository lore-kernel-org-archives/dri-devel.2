Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E8606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPk2Chlf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEF110E3D8;
	Thu, 26 Nov 2026 13:35:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A658210E3D8;
 Thu, 26 Nov 2026 13:34:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B157F61F63;
 Thu, 26 Nov 2026 13:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4DD1F000CF;
 Thu, 26 Nov 2026 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700097;
 bh=DOZLBVC8e5T2seSjbwKw7gp2SlRqgI2Mm69LObxIeMM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=jPk2Chlfcc+IlMa6Se9qcdVl2MRCZbIG269JsvJ0CbIPZDz1JU66TuQAA+AdJsV1l
 EGBJzAt2tG/NXMaeDYV5+L1mbNwUYHX79mfAL7PFBE1yOI9FXZMu5ZnJpALpNFlspo
 PhQElUGVk9bMqYQYZNxJfEMMT/u+h/gDiw4JtJEB9uyQ9SLhjcjEiS/69Nk/tBchK4
 CeMAzFSbcQhGowxJ3XYiefjwuQBdtmlXkn2cSgsGEv047zb/vAEEySltSxicUCiGFv
 H2dljJBG7iaK6A798ZvQHvmgTXoD6t+GSL1+JrBDQiahVEzAdecunEzQXBcnCrgfWH
 2ee3yQ7ER6sGA==
From: David Hildenbrand <david@kernel.org>
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
Subject: Re: [PATCH v2 0/4] mm,drm/i915,powerpc/spufs: vm_ops->access
 related fixes
Message-Id: <179570008611.16270.17870262980565551144.b4-ty@b4>
Date: Thu, 26 Nov 2026 14:34:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 18:55:17 +0100, David Hildenbrand (Arm) wrote:
> While working on vm_ops->access related fixes in core code for FOLL_ANON
> and VMA access permission + size handling, I stumbled over two driver
> issues.
> 
> Fixing it all in this series, because it's all intertwined. Only allow
> FOLL_FORCE to bypass VMA permissions, similar to what GUP does for other
> VMAs.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: core-7.5.access

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/4] mm: do not call vm_ops->access with FOLL_ANON
      https://git.kernel.org/mm/core/c/775abaa4
[2/4] drm/i915: consider vm_pgoff in vm_access()
      https://git.kernel.org/mm/core/c/95553038
[3/4] powerpc/spufs: consider vm_pgoff in spufs_mem_mmap_access()
      https://git.kernel.org/mm/core/c/50df2688
[4/4] mm: check permissions and bounds for vm_ops->access
      https://git.kernel.org/mm/core/c/8ef1926a

-- 
Cheers,

David

