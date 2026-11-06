Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD86606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVLjkYgC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD4010E424;
	Fri,  6 Nov 2026 14:27:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DA110E424
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:27:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 731F6601E3;
 Fri,  6 Nov 2026 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB41F0089F;
 Fri,  6 Nov 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793975239;
 bh=DRfTGULczNtA9EXXbZGOBo4aGmNY8ZZr3vW1/pnMolc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VVLjkYgC3kPulcZBi87dEE26TyhQTIxBmhalKGAUp6WsjtcLYba+CcyYDvoJ38ZuF
 QaSWt2+RcoApJrKU4WMdymA4JtiPyW9/plo2aDFqnm79Z9nQV0q2O4lh2skHKb2++M
 sFu4fGRCm92uxsrCDd2qoqHJHNu7jVH/dPhCzIUEFwFlXmA4j1rsv/8X2ql/M8d8T/
 3P8y2QE1Ie4xiQ8H/UOkSFscBHyXW41dzQahcquOBa7DwgCS0DJPwyNDX6M2uipwGu
 gGjKs/gMsC0nQ5A6FmC8CE2h9OY+89Ce6cWgbRMYDebb5eKHK20PhHDXJ8n4AcF74y
 kRokbTKzPa/vg==
Message-ID: <sashiko-outbox-201578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] rust: DmaFence: Don't drop on signal
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261106140752.520386-5-phasta@kernel.org>
References: <20261106140752.520386-2-phasta@kernel.org>
 <20261106140752.520386-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:27:18 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] rust: dma_fence: missing RCU grace period in
  DriverFence::drop() [1]
--

commit ee6d42825838039a4b13a90afb76009d7c94efbd
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Don't drop on signal

This commit changes DriverFence::signal() to take &self instead of consuming
self, and decrements nr_of_unsignaled_fences only when the fence had not yet
been signaled.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 897308f60dd3c..c04b68fe67fe3 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -820,7 +820,7 @@ pub fn as_fence(&self) -> &Fence {
>      }
> =20
>      /// Signal the fence. This will invoke all registered callbacks.
> -    pub fn signal(self, res: Result) {
> +    pub fn signal(&self, res: Result) {
>          let fence =3D self.as_fence().lock();
> =20
>          // SAFETY: `fence` is valid because `self` is valid. The lock mu=
st be
> @@ -831,14 +831,15 @@ pub fn signal(self, res: Result) {
>                  // must not have been signaled yet, which we check direc=
tly above.
>                  unsafe { bindings::dma_fence_set_error(fence.as_raw(), e=
rr.to_errno()) };
>              }
> +
> +            // SAFETY: `self.data` is valid because `self` is valid.
> +            let fctx =3D unsafe { self.data.as_ref().fctx };
> +            let _ =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
> +
>              // SAFETY: `fence` is valid because `self` is valid. The loc=
k must
>              // be held, which we acquired above.
>              unsafe { bindings::dma_fence_signal_locked(fence.as_raw()) };
>          }
> -
> -        // SAFETY: `self.data` is valid because `self` is valid.
> -        let fctx =3D unsafe { self.data.as_ref().fctx };
> -        let _ =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
>      }
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can FenceContext::drop()
free the context before an RCU grace period has elapsed [1] when
T::FenceDataType does not require drop glue?

FenceContext::drop() calls rcu_barrier() to wait for in-flight RCU callbacks
and concurrent dma_fence_ops readers before freeing the FenceContext.
However, in DriverFence::drop():

rust/kernel/dma_buf/dma_fence.rs:DriverFence::drop() {
    ...
        if !core::mem::needs_drop::<T::FenceDataType>() {
            ...
            unsafe { bindings::dma_fence_put(self.as_raw()) };
            return;
        }
    ...
        unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence_da=
ta::<T>)) };
}

When needs_drop is false and an external consumer still holds a reference to
the underlying dma_fence, dma_fence_put() does not schedule the RCU release=
 of
the fence and DriverFence::drop() returns without calling call_rcu().
Because rcu_barrier() only waits for already-queued RCU callbacks rather th=
an
a grace period, FenceContext::drop() can return immediately while a concurr=
ent
RCU reader in dma_fence_driver_name() or dma_fence_timeline_name() is still
running:

CPU0                                  CPU1
dma_fence_driver_name()
  rcu_read_lock()
  !dma_fence_test_signaled_flag()
                                      DriverFence::signal()
                                        nr_of_unsignaled_fences.fetch_sub(1)
                                        dma_fence_signal_locked()
                                      DriverFence::drop()
                                        // !needs_drop::<T::FenceDataType>()
                                        dma_fence_put() // refcount > 0
                                      FenceContext::drop()
                                        rcu_barrier() // no callback queued
                                      // FenceContext is freed
  FenceContext::get_driver_name()
    fctx.driver_name.as_char_ptr()    <-- use-after-free

[1] https://sashiko.dev/#/bug/linux-40274ecc-9f61-4d35-b6b3-1ceb72f48227

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106140752.5203=
86-2-phasta@kernel.org?part=3D3
