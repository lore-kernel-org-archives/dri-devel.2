Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26888CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8674011286D;
	Thu,  4 Jun 2026 10:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lRMapgFP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8969911286D
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 10:12:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFB6D60219;
 Thu,  4 Jun 2026 10:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9021F00898;
 Thu,  4 Jun 2026 10:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780567937;
 bh=85lDHkouY1ub4GvNOAvBBQByOOEXW/T952oXZv9cIUY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lRMapgFPLLj0Q1yEUl2H2OXpEGprB1P0Yh/e2nF/AQhNbHAzoXfe8FGvYkuiwFemb
 UB8AlNynY/IIBsBzuctuXnn6lcmo7ICzy1jqHyDnn1nUZdgB5GmFBxhi+QagbF0pIi
 3B05RKG0ktK/jTiYKXatgOstDSx0WpvkN5K5FLsZWqxu5pQUJG6vMRHQSdXovxQ5vj
 3TQOfWX5F9sziLRupJpfWewFRte1xVvUXQ5esnDArLty/azeCBDZshy2pKbDayYJLP
 5WbDqzTYIQUxty6idWVVSAQJm+YYUyB/EfrcoeIdUw4/t8so00pVmiINhhTkLVqT+j
 /qnH6lkJJCg6Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 7/7] drm/xe/svm: Correct memory attribute reset for
 partial unmap
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604095012.367231-8-arvind.yadav@intel.com>
References: <20260604095012.367231-8-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 10:12:17 +0000
Message-Id: <20260604101217.6A9021F00898@smtp.kernel.org>
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
- [High] Concurrent MMU notifiers fail to queue partial unmap range updates=
 due to list poisoning, causing unmapped regions to retain stale attributes.
- [High] Disjoint partial unmaps are silently ignored during coalescing, pr=
eventing their VMA memory attributes from being reset.
--

commit 63782c32791ae66c7e1c022f8db4a4b168c0d897
Author: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

drm/xe/svm: Correct memory attribute reset for partial unmap

When performing a partial unmap of an SVM range, the memory attributes
were being reset for the entire range instead of just the portion
being unmapped. This could lead to unintended side effects and behaviour.

> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -127,6 +129,34 @@ static void xe_svm_range_free(struct drm_gpusvm_rang=
e *range)
[ ... ]
> +static void xe_svm_range_set_unmapped(struct xe_svm_range *range,
> +				      const struct mmu_notifier_range *mmu_range)
> +{
> +	u64 new_start =3D max_t(u64, xe_svm_range_start(range), mmu_range->star=
t);
> +	u64 new_end =3D min_t(u64, xe_svm_range_end(range), mmu_range->end);
> +
> +	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
> +	if (range->base.pages.flags.partial_unmap) {
> +		if (range->partial_unmap.start || range->partial_unmap.end) {
> +			/*
> +			 * Coalesce overlapping or adjacent intervals.
> +			 * Disjoint ranges cannot be tracked in one interval
> +			 * without covering still-mapped memory.
> +			 */
> +			if (new_start <=3D range->partial_unmap.end &&
> +			    new_end >=3D range->partial_unmap.start) {
> +				range->partial_unmap.start =3D
> +					min(range->partial_unmap.start, new_start);
> +				range->partial_unmap.end =3D
> +					max(range->partial_unmap.end, new_end);
> +			}

[Severity: High]
If the new partial unmap is disjoint from the tracked interval, the overlap
condition evaluates to false. Because there is no else block here, does
this mean the disjoint interval is silently discarded?

If so, the garbage collector might only reset the VMA attributes for the
initial subrange, leaving the disjoint unmapped region with stale memory
attributes.

> +		} else {
> +			range->partial_unmap.start =3D new_start;
> +			range->partial_unmap.end =3D new_end;
> +		}
> +	}
> +}
[ ... ]
> @@ -135,12 +165,14 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm=
, struct xe_svm_range *range,
> =20
>  	range_debug(range, "GARBAGE COLLECTOR ADD");
> =20
> -	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
> -
>  	spin_lock(&vm->svm.garbage_collector.lock);
> +
> +	xe_svm_range_set_unmapped(range, mmu_range);
> +
>  	if (list_empty(&range->garbage_collector_link))
>  		list_add_tail(&range->garbage_collector_link,
>  			      &vm->svm.garbage_collector.range_list);
> +
>  	spin_unlock(&vm->svm.garbage_collector.lock);

[Severity: High]
Is it possible to lose concurrent MMU notifier updates here due to list
poisoning?

In xe_svm_garbage_collector(), the worker thread removes the item using
list_del(), which poisons the list node pointers, and then the lock is
dropped:

xe_svm_garbage_collector() {
    ...
    list_del(&range->garbage_collector_link);
    spin_unlock(&vm->svm.garbage_collector.lock);
    ...
}

If a concurrent MMU notifier fires for the same range during this unlocked
window, xe_svm_garbage_collector_add_range() acquires the lock, updates the
partial unmap bounds, and evaluates the list_empty() condition above.

Because the pointers are poisoned, list_empty() evaluates to false, and the
range is not re-queued. Would this cause the VMA attributes for this
concurrent unmap to never be reset?=20

Note that switching to list_del_init() would allow it to be re-queued, but
could that introduce a use-after-free since the worker then destroys the
range?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095012.3672=
31-1-arvind.yadav@intel.com?part=3D7
