Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE7606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+siPjM4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6234510E89F;
	Sat, 14 Nov 2026 18:59:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8F410E894;
 Sat, 14 Nov 2026 18:59:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEC7660E15;
 Sat, 14 Nov 2026 18:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B311F000C4;
 Sat, 14 Nov 2026 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794682748;
 bh=9RzpuEYsnkvuLxM7zo3RdF3Gc3FUtoCDNsh2Uv68tmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=g+siPjM4yAFSviPGPS/cwHbu8OZzs8PoMVBZNdEnXQLMBPyyPFkTXapgCKl/hjAae
 dCJNWlK/TEWojBDTpL/ghuz087T3k/gyiU1eB4mNldla+3S52rlDtKLQugauMusEqP
 6RRTxZxPcFw62PN+1KM6bBdAb6eh04dR903SHM9pa1o6uQw8B29gZKllO+p9VBvKP4
 AykfttBIFa99OrjXCIgHJOPgJL1GKmxAXilXFDc6jR9GA0S/RI7teedpBYOyDfm618
 MHfCc3/0hBDuNZP996VXFGHsvBIYJnGDN7X2XFBKb+zgXGpV+9xAoBHm8lRzgwoq1R
 tW/dULWGdjNCw==
Date: Sat, 14 Nov 2026 18:58:59 +0000
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
 dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] drm/i915/selftests: request read access for mmap
 access tests
Message-ID: <avivbKZSctYksFqd@gremlin>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-3-988a5c470db2@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-access_shite-v1-3-988a5c470db2@kernel.org>
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

On Thu, Nov 12, 2026 at 11:08:59PM +0100, David Hildenbrand (Arm) wrote:
> __igt_mmap_access() reads the buffer with access_process_vm() without
> FOLL_FORCE, but creates the mapping with only PROT_WRITE. Request
> PROT_READ as well so the test remains valid when we fix the ->access
> fallback to properly check VMA access permissions.
>
> Fixes: 9f909e215fea ("drm/i915: Implement vm_ops->access for gdb access into mmaps")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Seems sensible so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
> index 303be698891fd..d9c828032a1aa 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
> @@ -1460,7 +1460,8 @@ static int __igt_mmap_access(struct drm_i915_private *i915,
>  	if (err)
>  		return err;
>
> -	addr = igt_mmap_offset(i915, offset, obj->base.size, PROT_WRITE, MAP_SHARED);
> +	addr = igt_mmap_offset(i915, offset, obj->base.size,
> +			       PROT_READ | PROT_WRITE, MAP_SHARED);
>  	if (IS_ERR_VALUE(addr))
>  		return addr;
>  	ptr = (unsigned long __user *)addr;
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
