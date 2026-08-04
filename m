Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EAFC55182
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 02:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9271910E086;
	Tue,  4 Aug 2026 02:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z01yZjOU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD5F10E086
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 02:38:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1C4D60A6C;
 Tue,  4 Aug 2026 02:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DFB1F000E9;
 Tue,  4 Aug 2026 02:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785811107;
 bh=JBRQ5Hv4QOoPkMoFQEkv875IjQm4M/it8+esaiIpj24=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z01yZjOUXc4ZQdxFJ4OPrG0mXxBY5c/ZW0gLF/kBs9BbHgc67hlvmYMBPl+/srUXi
 cPtZea+mHc1L0C/hsG1LSO3TTaQDVf9QjNrgc6ZrszW5bgHwjGqyzsgZMy8rlPuPYZ
 Lk3EvpDslgHHg65UYiCh/mI7YzJXIyBoO8Vj7HS78kb9IcHreMq4haaMUDwjYmG/7B
 IgTJB9IIyyWArHz8feaR90k+IiyRHmsU5+RRxtytehIVN8hAO3K3vOuMTZ3btcGRfM
 EKDCd32S037nphag4MQJ8AauXBHCsSJ2/4ThuIHeML6kfoWruC0h7V3fjdK+Y95EAY
 paoegNysgWMqQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] drm/xe: Kick GuC while TLB invalidation acks
 are overdue
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804021441.3054424-4-talesam@gmail.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <20260804021441.3054424-4-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 02:38:26 +0000
Message-Id: <20260804023827.50DFB1F000E9@smtp.kernel.org>
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
- [High] Unprotected MMIO access in `xe_tlb_inval_kick` can cause a crash i=
f the device suspends concurrently.
--

--- Patch [3]: [RFC PATCH 3/3] drm/xe: Kick GuC while TLB invalidation acks=
 are overdue ---
commit c7a516f0e42fcf29db699b7dce1432a3b42378cd
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe: Kick GuC while TLB invalidation acks are overdue

This commit adds a delayed work to periodically poke the GuC when a TLB
invalidation ack is delayed. This provides a workaround for a firmware stall
issue by re-reading the GuC status, flushing the CT fast-path, and ringing
the GuC doorbell until the ack arrives.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tl=
b_inval.c
> index 9dd04d5bc4cd2..16c32d5669f36 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c

[ ... ]

> @@ -268,6 +285,55 @@ static bool xe_tlb_inval_seqno_past(struct xe_tlb_in=
val *tlb_inval, int seqno)
>  	return seqno_recv >=3D seqno;
>  }
> =20
> +static void xe_tlb_inval_kick(struct work_struct *work)
> +{
> +	struct xe_tlb_inval *tlb_inval =3D container_of(work, struct xe_tlb_inv=
al,
> +						      kick_work.work);
> +	struct xe_gt *gt =3D tlb_inval_to_gt(tlb_inval);
> +	struct xe_tlb_inval_fence *fence;
> +	ktime_t inval_time =3D 0;
> +	int seqno =3D 0;
> +
> +	spin_lock_irq(&tlb_inval->pending_lock);
> +	fence =3D list_first_entry_or_null(&tlb_inval->pending_fences,
> +					 struct xe_tlb_inval_fence, link);
> +	if (fence) {
> +		seqno =3D fence->seqno;
> +		inval_time =3D fence->inval_time;
> +	}
> +	spin_unlock_irq(&tlb_inval->pending_lock);
> +
> +	if (!seqno)
> +		return;
> +
> +	/*
> +	 * Poke the GuC: read its status register, flush the CT fast-path and
> +	 * ring the doorbell. On ARL with GuC 70.53.0 the ack for a pending
> +	 * invalidation sometimes only arrives seconds after the request even
> +	 * though the H2G was consumed immediately; a doorbell ring while the
> +	 * ack is overdue usually unsticks it within ~250ms (see Link in the
> +	 * commit message). Keep kicking every interval until the ack shows
> +	 * up; the TDR bounds how long this can go on.
> +	 */
> +	if (gt->gtidle.idle_residency)
> +		xe_guc_pc_c_status(&gt->uc.guc.pc);
> +	tlb_inval->ops->flush(tlb_inval);
> +	xe_guc_notify(&gt->uc.guc);

[Severity: High]
Could this lead to an unprotected MMIO access if the device suspends
concurrently?

When pending_lock is dropped above, the device is kept awake by the
runtime PM reference tied to the pending fence. If the GuC ack arrives
concurrently on another CPU, xe_tlb_inval_done_handler() will acquire the
lock, signal the fence, and call xe_pm_runtime_put() via
xe_tlb_inval_fence_fini().

Since cancel_delayed_work() does not block if the worker is already
running, is it possible for the last PM reference to be dropped before
we reach these MMIO accesses in xe_guc_pc_c_status() and xe_guc_notify()?=20

If the device suspends, accessing these registers could trigger a PCIe
timeout or master abort and crash the system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804021441.3054=
424-1-talesam@gmail.com?part=3D3
