Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E555CC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6BE10E078;
	Tue, 14 Jul 2026 22:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UwKhudcl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E432210E078
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:59:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E3CA437A9;
 Tue, 14 Jul 2026 22:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA75C1F000E9;
 Tue, 14 Jul 2026 22:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784069985;
 bh=m4+duRhElNCpJe0pEU+XLb9jNuWd+TtUXhWZJqKZsPw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UwKhudcllGFy0MglZ+aYFPpxlzVEQdSheKGpmlBjK9sIdRWG1sutlyVX4slCI53jm
 751+YkFDZC2z8jpNTSs0/K6f+wZsFkU8buBcytin6g2Hg/jVE9YQ62Joc630RIzWuE
 woLrBLXznQqzj4nFIztB/Ed3WGeTfXudU2xZxGFRwGaDDmh1HKm213e5DYP6X1d6tm
 Yrti5+4MmVArNFbkOI16oKyJ4iRksQ4duFCepqPhVGTUs8tN2t0mEYlQasIE6RZ1Ce
 g4jZpl1vaKgBFHIJNbUO1/RLeHz7ql95qXFWhvEt3jTfeXTok0/cMDJ4isIyXm2KPk
 roi5hXASV+TIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] fixup! drm/gpusvm: use
 hmm_range_fault_unlocked_timeout() for range faults
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178406770964.1106335.10099816010446253543.stgit@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
 <178406770964.1106335.10099816010446253543.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 22:59:44 +0000
Message-Id: <20260714225944.EA75C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing mmput() on memory allocation failure causes mm_struct leak.
--

--- Patch [4]: [PATCH v2 4/4] fixup! drm/gpusvm: use hmm_range_fault_unlock=
ed_timeout() for range faults ---
commit ece4b74fbf695a6f71fbfd09dfe6eb481688809b
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults

This commit updates the timeout handling for hmm_range_fault_unlocked_timeo=
ut()
by passing the HMM_RANGE_DEFAULT_TIMEOUT directly instead of calculating an
absolute deadline. This keeps the timeout focused on repeated notifier retr=
ies
inside HMM.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index b8f2dd9982f53..76e8a0028c7fc 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
[ ... ]
> @@ -1734,8 +1726,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusv=
m,
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does this error path leak the mm_struct
reference?

Looking at drm_gpusvm_range_evict(), if kvmalloc_array() fails to allocate
the pfns array, it returns -ENOMEM directly without dropping the reference
acquired earlier via mmget_not_zero():

int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
                           struct drm_gpusvm_range *range)
{
        ...
        if (!mmget_not_zero(mm))
                return -EFAULT;

        pfns =3D kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
        if (!pfns)
                return -ENOMEM;
        ...
}

Can this permanently pin the process address space if an unprivileged
userspace application creates a massive GPU SVM range that causes the
allocation to fail?

> =20
>  	hmm_range.hmm_pfns =3D pfns;
> -	err =3D hmm_range_fault_unlocked_timeout(&hmm_range,
> -				max_t(long, timeout - jiffies, 1));
> +	err =3D hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
> =20
>  	kvfree(pfns);
>  	mmput(mm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178406760622.110633=
5.2379450382728057793.stgit@skinsburskii?part=3D4
