Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C63FCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FA510EB2C;
	Fri,  9 Oct 2026 19:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KR2gzxIh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2578D10EB2C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:26:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D45043803;
 Fri,  9 Oct 2026 19:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F091F00893;
 Fri,  9 Oct 2026 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573979;
 bh=zmk1wWN7zFKcLKjBWdtmNfpfOCdqsYRJmRtnUQ5gt70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KR2gzxIh0qoDwWwBHyavDlKxab5wh0+Kt2BfBmLpZqjkRtIsfS3Ey9W++eF3J4Ze1
 tqCuh8uSmpka9dgfZjzc+JjUzSQu8dZTZsPoe/ddq+CpGIs/r6P4bEMD1jzHL+cQCm
 ZPxhWwTuAHyvnAxldy95ecAB0qhNri8tGWNCdIWhi623FASvnxLafvPOM9lBYVJZqP
 7sfHtosDhDwUBIPvf3c2k7h37diXvDiId9Ut1Pn9BgmLsFAgNHSJi1FxuFjzl3ADZn
 DF1s2ymLcCTwkH22VYcECME8GOc2k/Ufp7Mx2ikYtaV5+LbDoHnnTDNXjlOU+BS+kr
 KfWdRafl5FAHg==
Message-ID: <sashiko-outbox-166001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 3/6] rust: DmaFence: Don't drop on signal
To: "Philipp Stanner" <phasta@kernel.org>
Cc: media-ci@linuxtv.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 gary@garyguo.net
In-Reply-To: <20261009191124.1022902-5-phasta@kernel.org>
References: <20261009191124.1022902-2-phasta@kernel.org>
 <20261009191124.1022902-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 19:26:18 +0000
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
- [High] dma_fence: counter underflow in DriverFence::signal on multiple ca=
lls
- [High] dma_fence: sleep-in-atomic bug when dropping DriverFence under spi=
nlock
--

commit 79012d18b924ead15254b36baf7e1933525374af
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Don't drop on signal

This commit decouples the dropping of a DriverFence from its signaling,
changing the signal() method to take &self rather than consuming the fence.
This allows the fence to be signaled multiple times and defers its
destruction to when the object goes out of scope. The intent is to avoid
dropping fences in an atomic context where deferred deletion is problematic.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 0028124e6aa64..b67121c7abd41 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -806,7 +806,7 @@ pub fn as_fence(&self) -> &Fence {
>      }
> =20
>      /// Signal the fence. This will invoke all registered callbacks.
> -    pub fn signal(self, res: Result) {
> +    pub fn signal(&self, res: Result) {

[Severity: High]
Could the unconditional decrement at the end of this function corrupt the
nr_of_unsignaled_fences counter since signal() can now be called multiple
times?

rust/kernel/dma_buf/dma_fence.rs:DriverFence::signal() {
...
        let fctx =3D unsafe { self.data.as_ref().fctx };
        let _ =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
}

If signal() is called twice on the same fence, it looks like it will
underflow the hazard counter, causing a delayed panic when the FenceContext
is dropped.

[Severity: High]
Will this decoupling of signal() from drop() lead to a sleep-in-atomic bug
later in the series?

Since dropping is now deferred to when the DriverFence goes out of scope,
it appears to conflict with other patches in this series.

In patch 5, call_rcu() is replaced with synchronize_rcu() in
DriverFence::drop():

rust/kernel/dma_buf/dma_fence.rs:DriverFence::drop() {
...
        synchronize_rcu();
...
}

In patch 6, DriverFence is dropped while a SpinLockIrq is held:

rust/kernel/drm/job_queue.rs:JobQueue::complete_jobs_up_to_seqno() {
        let mut jq_locked =3D jq.lock();
        let mut jq =3D jq_locked.as_mut().project();

        let mut cursor =3D jq.running_jobs.cursor_front();

        while let Some(job) =3D cursor.peek_next() {
            let mut job =3D job.remove();
            ...
        } // `job` goes out of scope here, triggering DriverFence::drop
}

Dropping the DriverFence will call synchronize_rcu(), which sleeps, leading
to a sleep-in-atomic panic when invoked from the JobQueue lock guard.

>          let fence =3D self.as_fence().lock();
> =20
>          // SAFETY: `fence` is valid because `self` is valid. The lock mu=
st be

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009191124.1022=
902-2-phasta@kernel.org?part=3D3
