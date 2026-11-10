Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA760A2601
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmHk+BoH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D9910EE7F;
	Tue, 10 Nov 2026 08:10:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2753010EE7F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:10:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D000540370;
 Tue, 10 Nov 2026 08:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FB01F0089F;
 Tue, 10 Nov 2026 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794298229;
 bh=K3Wp8UVVrf5H3V18BPbLB5d0YvAYmu8wRxAxyoQIV2M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FmHk+BoHSRtGpvG6omrB/oqFRHTliWoq6eSEGrMxJWZsWtmz1sNRFf0xLFWgjI2i4
 2ShqAHrGDPw1A1f+8hpDeitbGQlODuKly8Xrg53y4rOwn1LCNz5AjTN/WNsAwFUSZs
 YFtPJa0nryam049CEpdhIZ+L573TFMkgBtyse/rnOZbWnAer3OtqM6bvMr1Yv5SBD4
 IDhQoMMEAAPcAGtrvnZMCgO3TzQRduj0gjKI+g1ofE5l9hevZGuZkxMTQ6mOU/Mutl
 v9/O8Wrzk10/ch7bpEP4MnobUMc3p4sQjqEDRBqGPviS05lj+e9jLi5z2/gq0ZB8t+
 dDN07jw3ZuJ5g==
Message-ID: <sashiko-outbox-206570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] drm/panfrost: Name the BOs around an unhandled page
 fault
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-panfrost-long-jobs-v1-7-24508939ae8d@gmail.com>
References: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
 <20261110-panfrost-long-jobs-v1-7-24508939ae8d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:10:29 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/panfrost: UAF on zero-refcount mappings in
  panfrost_mmu_report_fault_bos()
- [Low] drm/panfrost: unmapped BOs are removed from mmu->mm before fault
  lookup
--

commit ead4ad306bba42948b358f03bb31d38d71c27615
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Name the BOs around an unhandled page fault

This commit logs the buffer object containing an unhandled GPU page fault
address, or the nearest buffer objects below and above it in the faulting
address space.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 13728b0c46efc..b0319d680b12c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -595,6 +595,86 @@ addr_to_mapping(struct panfrost_device *pfdev, int a=
s, u64 addr)
>  	return mapping;
>  }
> =20
> +static void panfrost_mmu_print_fault_bo(struct panfrost_device *pfdev,
> +					struct panfrost_gem_mapping *m,
> +					u64 addr, const char *where)
> +{
> +	struct panfrost_gem_object *bo =3D m->obj;
> +	u64 start =3D m->mmnode.start << PAGE_SHIFT;
> +	u64 end =3D (m->mmnode.start + m->mmnode.size) << PAGE_SHIFT;
> +	u64 dist =3D addr < start ? start - addr : addr >=3D end ? addr - end :=
 addr - start;
> +
> +	mutex_lock(&bo->label.lock);
> +	dev_err(pfdev->base.dev,
> +		"fault bo: %s: VA [0x%llx-0x%llx) size 0x%zx, fault at %s0x%llx, %s%s%=
s, label \"%s\"\n",
> +		where, start, end, bo->base.base.size,
> +		addr < start ? "-" : addr >=3D end ? "end+" : "start+", dist,
> +		m->active ? "mapped" : "NOT mapped",
> +		bo->is_heap ? ", heap" : "", bo->noexec ? ", noexec" : "",
> +		bo->label.str ? bo->label.str : "");
> +	mutex_unlock(&bo->label.lock);
> +}
> +
> +/*
> + * Report the BOs around an unhandled fault address in the faulting addr=
ess
> + * space: the one containing it (if any), else the nearest one below and=
 above.
> + * An access just past the end of a BO that a hole follows is a GPU over=
run of
> + * that BO (userspace or hardware), a fault inside a BO whose mapping is=
 gone
> + * points at the kernel, an address far from any BO at a stale or garbage
> + * pointer.
> + */

[Severity: Low]
Can a BO whose mapping has been torn down ever be reported as "inside" and
"NOT mapped" here?

panfrost_mmu_unmap() is only called from panfrost_gem_teardown_mapping(),
which immediately acquires mapping->mmu->mm_lock and removes
mapping->mmnode from mmu->mm.  Once a mapping is torn down (whether on
handle close or shrinker purge), its node is no longer in mmu->mm, so a
fault at its old VA will be reported between the neighboring "below" and
"above" BOs rather than inside an unmapped BO.  Conversely, for nodes still
in mmu->mm (outside transient setup or teardown windows), m->active is only
false for a heap BO that has not faulted in its first chunk yet, while a
partially mapped heap BO has m->active set to true even when faulting in an
unmapped chunk.

> +static void panfrost_mmu_report_fault_bos(struct panfrost_device *pfdev,
> +					  int as, u64 addr)
> +{
> +	struct panfrost_gem_mapping *below =3D NULL, *above =3D NULL;
> +	u64 offset =3D addr >> PAGE_SHIFT;
> +	struct drm_mm_node *node;
> +	struct panfrost_mmu *mmu;
> +	bool inside =3D false;
> +
> +	spin_lock(&pfdev->as_lock);
> +	list_for_each_entry(mmu, &pfdev->as_lru_list, list) {
> +		if (as =3D=3D mmu->as)
> +			goto found_mmu;
> +	}
> +	spin_unlock(&pfdev->as_lock);
> +	dev_err(pfdev->base.dev, "fault bo: no context holds AS%d\n", as);
> +	return;
> +
> +found_mmu:
> +	spin_lock(&mmu->mm_lock);
> +	/* The node list is sorted by address. */
> +	drm_mm_for_each_node(node, &mmu->mm) {
> +		if (node->start > offset) {
> +			above =3D drm_mm_node_to_panfrost_mapping(node);
> +			break;
> +		}
> +		below =3D drm_mm_node_to_panfrost_mapping(node);
> +	}
> +	if (below) {
> +		inside =3D offset < below->mmnode.start + below->mmnode.size;
> +		kref_get(&below->refcount);
> +		if (inside)
> +			above =3D NULL;
> +	}
> +	if (above)
> +		kref_get(&above->refcount);
> +	spin_unlock(&mmu->mm_lock);
> +	spin_unlock(&pfdev->as_lock);
> +
> +	if (!below && !above)
> +		dev_err(pfdev->base.dev, "fault bo: AS%d has no BO\n", as);
> +	if (below) {
> +		panfrost_mmu_print_fault_bo(pfdev, below, addr,
> +					    inside ? "inside" : "below");
> +		panfrost_gem_mapping_put(below);
> +	}
> +	if (above) {
> +		panfrost_mmu_print_fault_bo(pfdev, above, addr, "above");
> +		panfrost_gem_mapping_put(above);
> +	}
> +}

[Severity: High]
Can kref_get() in panfrost_mmu_report_fault_bos() race with
panfrost_gem_mapping_release() and cause a refcount addition-on-zero and
use-after-free on below or above?

When the last reference to a mapping is dropped in
panfrost_gem_mapping_put(), mapping->refcount reaches zero before
panfrost_gem_teardown_mapping() unmaps the page tables and acquires
mapping->mmu->mm_lock to remove mapping->mmnode from mmu->mm:

drivers/gpu/drm/panfrost/panfrost_gem.c:panfrost_gem_teardown_mapping() {
	if (mapping->active)
		panfrost_mmu_unmap(mapping);

	spin_lock(&mapping->mmu->mm_lock);
	if (drm_mm_node_allocated(&mapping->mmnode))
		drm_mm_remove_node(&mapping->mmnode);
	spin_unlock(&mapping->mmu->mm_lock);
}

If a GPU job accesses that BO while its GEM handle is being closed,
panfrost_mmu_unmap() triggers the unhandled GPU page fault while
mapping->mmnode is still in mmu->mm with refcount =3D=3D 0:

CPU0                                  CPU1
panfrost_gem_close()
  panfrost_gem_mapping_put()
    kref_put(&mapping->refcount, ...)
      panfrost_gem_mapping_release()
        panfrost_gem_teardown_mapping()
          panfrost_mmu_unmap(mapping)
                                      panfrost_mmu_irq_handler_thread()
                                        panfrost_mmu_report_fault_bos()
                                          spin_lock(&mmu->mm_lock)
                                          kref_get(&below->refcount)
                                            <-- addition on zero
                                          spin_unlock(&mmu->mm_lock)
          spin_lock(&mmu->mm_lock)
          drm_mm_remove_node(...)
          spin_unlock(&mmu->mm_lock)
        drm_gem_object_put(...)
        kfree(mapping)
                                        panfrost_mmu_print_fault_bo()
                                          mutex_lock(&bo->label.lock)
                                            <-- use-after-free

Using kref_get_unless_zero() (or skipping nodes whose refcount is already
zero while walking mmu->mm) would avoid grabbing a dying mapping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-panfrost-l=
ong-jobs-v1-0-24508939ae8d@gmail.com?part=3D7
