Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23113CD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A71113EC3;
	Thu,  4 Jun 2026 10:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MtgbZvfd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D99113EC3
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 10:14:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 717C960222;
 Thu,  4 Jun 2026 10:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5371F00893;
 Thu,  4 Jun 2026 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780568096;
 bh=v541KZ82iG6XXd4r0++bAMmqEJ4yFDtHfT4MSu7sr4s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MtgbZvfdJOleXMkWbuTml4yf+sSMbrU4RAnCYXzodOalsYvxkLMBTmR61nTSz/g1S
 UzxUPjIii3fuuSpL+iswqXTLwZleZ5OcPgba664URdxKY+O7M01uuVJeJs66EdzVa5
 zwsrkn6dF7pe4ve2j9/owBf+fNhq6oCMErSISS+4Q+oGjCiRgOsPLR03NJCCgde0V/
 6JIEU6tz9g9MNq0uTSCiZCpoHfA6lcS/ewg17l9oNJq+d+Md6PeA5qNYn+mfNqIqdW
 KOzkONj0ZdAz1v5rox3Ktkia83n4FLvvSaw2HmsJw5fqZxq5tY7jGu92SnHc+2gfY7
 dx8XaQAokdwGQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 4/7] drm/xe/vm: Add madvise autoreset notifier worker
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604095012.367231-5-arvind.yadav@intel.com>
References: <20260604095012.367231-5-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 10:14:55 +0000
Message-Id: <20260604101456.0E5371F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Returning false for non-blockable invalidations incorrectly preven=
ts the OOM reaper from unmapping memory.
- [Medium] Redundant VMA splitting for partial overlaps when the VMA alread=
y has default attributes.
--

commit fe0b22bc527cb1c9caa55068f36be5982435fd31
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe/vm: Add madvise autoreset notifier worker

This commit adds a worker to reset madvise-managed VMA attributes when
userspace unmaps CPU-only mirror ranges. It uses an MMU notifier callback
to record pending unmap events and widens the range if multiple unmaps
arrive before the worker runs. The worker then resets attributes for ranges
not covered by a CPU VMA.

> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_v=
m_madvise.c
> index c4fb290041956..c2abe712598a1 100644
> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
[ ... ]
> @@ -732,3 +738,501 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *fil
[ ... ]
> +static int xe_vm_madvise_process_unmap(struct xe_vm *vm, u64 start, u64 =
end)
> +{
[ ... ]
> +		has_default_attr =3D xe_vma_has_default_mem_attrs(vma);
> +		seg_start =3D max(addr, xe_vma_start(vma));
> +		seg_end =3D min(end, xe_vma_end(vma));
> +
> +		/* Merge adjacent default-attr VMAs when possible. */
> +		if (has_default_attr &&
> +		    xe_vma_start(vma) >=3D start &&
> +		    xe_vma_end(vma) <=3D end) {
> +			seg_start =3D xe_vma_start(vma);
> +			seg_end =3D xe_vma_end(vma);
> +			xe_vm_find_cpu_addr_mirror_vma_range(vm, &seg_start, &seg_end);
> +			if (xe_vma_start(vma) =3D=3D seg_start && xe_vma_end(vma) =3D=3D seg_=
end) {
> +				/* Nothing to merge. */
> +				addr =3D seg_end;
> +				continue;
> +			}
> +		} else if (xe_vma_start(vma) =3D=3D seg_start && xe_vma_end(vma) =3D=
=3D seg_end) {
> +			/* Exact VMA match, reset in place. */
> +			xe_vma_reset_to_default_attrs(vma);
> +			addr =3D seg_end;
> +			continue;
> +		}
> +
> +		err =3D xe_vm_alloc_cpu_addr_mirror_vma(vm, seg_start, seg_end - seg_s=
tart);

[Severity: Medium]
When a CPU hole partially overlaps a GPU VMA that already has default
attributes, will this fall through to xe_vm_alloc_cpu_addr_mirror_vma() and
cause redundant VMA splitting?

If the overlap is strictly partial, both the if and else if conditions above
fail. The fall-through maps the overlapping portion with default attributes,
forcing the GPUVM infrastructure to split the existing VMA.=20

Since the existing VMA already possessed default attributes, this split
appears to be redundant and might needlessly fragment a single large VMA in=
to
smaller identical pieces. Repeated partial unmaps from userspace could
artificially fragment the VMA tree and leak xe_vma objects.

[ ... ]
> +static bool xe_madvise_notifier_callback(struct mmu_interval_notifier *m=
ni,
> +					 const struct mmu_notifier_range *range,
> +					 unsigned long cur_seq)
> +{
> +	struct xe_madvise_notifier *notifier =3D
> +		container_of(mni, struct xe_madvise_notifier, mmu_notifier);
> +	struct xe_vm *vm =3D notifier->vm;
> +	u64 adj_start, adj_end;
> +
> +	if (range->event !=3D MMU_NOTIFY_UNMAP)
> +		return true;
> +
> +	if (!mmu_notifier_range_blockable(range))
> +		return false;

[Severity: High]
Does returning false for non-blockable invalidations incorrectly prevent the
OOM reaper from unmapping memory?

Because the callback implementation is entirely non-blocking (it relies on
down_read_trylock(), spin_lock(), and queue_work()), there seems to be no
technical limitation requiring it to block.=20

Returning false from an MMU interval notifier's invalidate callback signals
that the invalidation could not be completed without blocking, causing
__mmu_notifier_invalidate_range_start() to return -EAGAIN.=20

Since the OOM reaper operates in a non-blockable context, receiving -EAGAIN
means it cannot retry indefinitely and will skip the VMA, failing to reclaim
the memory and defeating the purpose of the OOM killer. Could this safely
process the event and unconditionally return true for unmap events instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095012.3672=
31-1-arvind.yadav@intel.com?part=3D4
