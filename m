Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63C606A339
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrNKwZwA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7333B10E86F;
	Sat, 14 Nov 2026 18:58:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2140210E7FA;
 Sat, 14 Nov 2026 18:58:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E86760E15;
 Sat, 14 Nov 2026 18:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705CF1F000C4;
 Sat, 14 Nov 2026 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794682711;
 bh=fbMRE2X5e/AHLMS1eoGd56ly9fU3NIj/Z6Js5YflNNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QrNKwZwAQuneaTtIjhUo4EUrUSYJ0Tgqq+BeI6i3EclcZg5Aj0cKdFRA2jWkaRwVM
 o89/ZYvAdf+R+m4hwUnNiti7YkwNBxWtmrgYa16vUWoUKDg2kwR8Pyn2ppXAWGc1rE
 Odhrb3oyldEOoXHE8VirjW40E7ouLZcuaBg2Uvct+GTJGPFpgY/zNGoh4D1P7J8bcn
 b2LWJ3PKD+DMr0cigxJqKKOi4hps0f2zLWEdtnX4RYGDbBO2mJSQHrkOmPTL9ujpE7
 VFFpA6W+fv+gE1ajgBImOn3GCzZXx606MCvodl4cErNAR6jXS0Okksz/7gb8sBZdSa
 6cOWGRzdkaSmg==
Date: Sat, 14 Nov 2026 18:58:21 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chris Wilson <chris@chris-wilson.co.uk>, Matthew Auld <matthew.auld@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/i915: consider vm_pgoff in vm_access()
Message-ID: <avivB9Pw8I_oMbpk@gremlin>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-2-988a5c470db2@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-access_shite-v1-2-988a5c470db2@kernel.org>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:08:58PM +0100, David Hildenbrand (Arm) wrote:
> vm_access() treats the start of every VMA as the beginning of the GEM
> object. After a VMA split, vm_pgoff identifies a later part of the
> object. Debugger reads and writes through ptrace or /proc/<pid>/mem then
> access the wrong bytes.
>
> Properly consider vm_pgoff just like the fault handlers already do.
>
> Fixes: 9f909e215fea ("drm/i915: Implement vm_ops->access for gdb access into mmaps")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

And since this is an mmap-an-fd driver thing there's no need to worry about anon
pgoff etc.

Looks sensible to me so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> index 6b337684dbfe8..e3b24dc8e94f5 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> @@ -511,13 +511,15 @@ vm_access(struct vm_area_struct *area, unsigned long addr,
>  	struct i915_mmap_offset *mmo = area->vm_private_data;
>  	struct drm_i915_gem_object *obj = mmo->obj;
>  	struct i915_gem_ww_ctx ww;
> +	unsigned long obj_offset;
>  	void *vaddr;
>  	int err = 0;
>
>  	if (i915_gem_object_is_readonly(obj) && write)
>  		return -EACCES;
>
> -	addr -= area->vm_start;
> +	obj_offset = area->vm_pgoff - drm_vma_node_start(&mmo->vma_node);
> +	addr += (obj_offset << PAGE_SHIFT) - area->vm_start;
>  	if (range_overflows_t(u64, addr, len, obj->base.size))
>  		return -EINVAL;
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
