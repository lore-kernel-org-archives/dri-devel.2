Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180DCC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6195F10E6C0;
	Thu, 17 Sep 2026 16:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FDMtiq7w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE89910E6C0;
 Thu, 17 Sep 2026 16:50:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 005BA60A65;
 Thu, 17 Sep 2026 16:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7466A1F00893;
 Thu, 17 Sep 2026 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789663842;
 bh=FpOzlcBd2kqK7eeHO5VWE9VsuJKh2BhaFuW479O+5t4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FDMtiq7wwHPUwDYB5WFIXJNvT9Lqjuucb7yM6csDCStP89r/VO3mXv3CtZRel3KPk
 viSacpBIs2PBDu5xak3HCp/7mi9i7ImFR0xTY6qaMwGEDRILpYCrWNr1tFL1055OuF
 KB6EJAMbmCYtuLce0pZlaE2p4nwMMnrKPpHpf2kQru7atsV2woYffK9lzZ+erZgBFN
 p9BMkBMP5qHHMxWkmW+E4o22q42AnXkRO0hVrHJ6Al25roVBHxd1hRAlG2/tkflqB/
 n0kDDP1/u7sE92sAEPkFJ62j0YImwXxRvLHJ9DtSPkytI3jFXjCyWBOlqZ5OREVQju
 j/A+EyR+sYy2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260917163553.1742580-2-talesam@gmail.com>
References: <20260917163553.1742580-1-talesam@gmail.com>
 <20260917163553.1742580-2-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:50:42 +0000
Message-Id: <20260917165042.7466A1F00893@smtp.kernel.org>
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
- [Low] drm/xe: data race in xe_tlb_inval_fence_timeout() reading seqno_recv
--

commit ef794f6bbaafa679257b9fec9405245af4942e68
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe: Capture devcoredump on TLB invalidation timeout

This commit adds xe_devcoredump_gt(), a variant of xe_devcoredump() for han=
gs
that are not tied to an exec queue or job. It hooks this new capture mechan=
ism
into the TLB invalidation timeout path to capture the GuC log and CT state.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tl=
b_inval.c
> index 7c3bf32d9258b..7a0c04fac60aa 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
[ ... ]
> @@ -97,6 +107,16 @@ static void xe_tlb_inval_fence_timeout(struct work_st=
ruct *work)
>  		queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fence_tdr,
>  				   timeout_delay);
>  	spin_unlock_irq(&tlb_inval->pending_lock);
> +
> +	/*
> +	 * Capture the GuC log and CT state so the firmware side of the hang
> +	 * can be inspected; there is no queue or job to blame here. Must be
> +	 * outside pending_lock as the capture takes sleeping locks.
> +	 */
> +	if (timedout_seqno)
> +		xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
> +				  "TLB invalidation fence timeout, seqno=3D%d recv=3D%d",
> +				  timedout_seqno, tlb_inval->seqno_recv);

[Severity: Low]
Does this code introduce a data race when reading tlb_inval->seqno_recv?

In xe_tlb_inval_fence_timeout() in drivers/gpu/drm/xe/xe_tlb_inval.c, the
pending_lock spinlock is dropped just before this block. Because seqno_recv
is read locklessly here, and concurrent updates (such as those in
xe_tlb_inval_done_handler()) use WRITE_ONCE(), reading it directly could
result in a data race.

Could this lead to KCSAN warnings or logging a corrupted value in the
devcoredump reason string? Would it be safer to read this using READ_ONCE()
or cache the value while the lock is held?

>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163553.1742=
580-1-talesam@gmail.com?part=3D1
