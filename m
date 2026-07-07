Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF38C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5085710EB9B;
	Tue,  7 Jul 2026 07:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f84UEAOi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DEF10EB98
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12F314351C;
 Tue,  7 Jul 2026 07:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ECD1F00A3A;
 Tue,  7 Jul 2026 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409624;
 bh=jPs3K0/sbtyyQ4BTexD861LzKdzWfnpZmMddb3M3x+A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f84UEAOilWNtAVfMrOWu2s5LhtwnTl5QCQXoTm/Ab6OSin0aLrceaAdK01xVUYM9Y
 nTnBOzh2cQlW6YP0IHG5xuawwovWRXtBDryMLssmYArMiomuAdQYGMIAs/ovK4vYtz
 yOgFN1zo6BpYrfnZ9vuIhxEEn/hJBciArrAtMfMElU7YEqgouQwPGTv+DFzB4povR+
 AQHBEzAZoPhIeuLVSXvEc3msO7mIt/M4n9xZ3FhONtq/VC5t8WzB604N0lLLDPFNVw
 cj1/FOomrd/++p+gn6eG660XTGHT5TzIL/UbMjOmr/VYRFcBSxdTRn91unFnxGv8kQ
 sm5JAa1z8WfrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 27/40] dept: assign dept map to mmu notifier
 invalidation synchronization
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-modules@vger.kernel.org, cassel@kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, "Chuck
 Lever" <cel@kernel.org>, linux-rt-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, "Jeff
 Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 ojeda@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260706061928.66713-28-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-28-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:42 +0000
Message-Id: <20260707073343.43ECD1F00A3A@smtp.kernel.org>
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
- [Medium] Unbalanced DEPT tracking context leak in mmu_notifier_invalidate=
_range_start_nonblock()
--

commit 10f75b8cdecfe9a5cbc6804a1d8ae1770fc9fe67
Author: Byungchul Park <byungchul@sk.com>

dept: assign dept map to mmu notifier invalidation synchronization

This commit introduces explicit DEPT tracking contexts to resolve false
positive deadlock reports in mmu_notifier invalidation synchronization.
It annotates the start and end of the event contexts delimited by
mmu_notifier_invalidate_range_start() and _end().

> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
[ ... ]
> @@ -460,6 +474,12 @@ mmu_notifier_invalidate_range_start_nonblock(struct =
mmu_notifier_range *range)
>  		ret =3D __mmu_notifier_invalidate_range_start(range);
>  	}
>  	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> +
> +	/*
> +	 * From now on, waiters could be there by this start until
> +	 * mmu_notifier_invalidate_range_end().
> +	 */
> +	mmu_notifier_invalidate_dept_ecxt_start(range);
>  	return ret;
>  }

[Severity: Medium]
Does this unconditionally start the DEPT event context even if the
non-blocking start fails?

If mmu_notifier_invalidate_range_start_nonblock() returns an error, callers
typically abort and skip calling mmu_notifier_invalidate_range_end(). For
example, in mm/oom_kill.c:__oom_reap_task_mm():

    if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
        tlb_finish_mmu(&tlb);
        ret =3D false;
        continue;
    }

Could this lead to an unbalanced DEPT context being leaked, as the
corresponding mmu_notifier_invalidate_dept_ecxt_end() will never be called
on the error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D27
