Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F27CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3092710EB1A;
	Fri,  9 Oct 2026 19:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n+pKX+wh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7C810EB1A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:24:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E62760267;
 Fri,  9 Oct 2026 19:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738FD1F00899;
 Fri,  9 Oct 2026 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573892;
 bh=duePJVZhZ+VHOvgM7Bl18oz6HNXP6TedsT31z7ADUsM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n+pKX+whOwrwVDfHFwtCRTjTus+rXWCSgGXaOeFP4atomnrjyGQqsWiZZzDPP91xj
 zafAMM4/Fxk2BX2/nJLV5T0CAxoYNEhXtEDJfrIfkhm3YNdd4EvBhvCEgxMu/59DWv
 T51A1erhujlVRyBwGqymwNSnuGTFJ6PHbQTkRcy4UAU//O+0yRBpdVzaKi5qeg7Krb
 XCJAqCh5YZPT7wYk9Y5c0Kv99U8Q24GAzXpXRHzHcxsQ18oftMv9Yu57Jxj3hVAVc7
 A6QUv3hvFiyXKmwmwmOXCDesnMBpo4PJTTeluS/dbmWRqdaMgSHY6UaOk3jW7CFe3r
 RkTQfuUJyusng==
Message-ID: <sashiko-outbox-165999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 1/6] rust: DmaFence: remove static lifetime
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, media-ci@linuxtv.org,
 gary@garyguo.net
In-Reply-To: <20261009191124.1022902-3-phasta@kernel.org>
References: <20261009191124.1022902-2-phasta@kernel.org>
 <20261009191124.1022902-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 19:24:51 +0000
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
- [High] rust: dma_fence: lack of scoped API for FenceCallbackRegistration =
causes UAF on leak
- [Medium] rust: missing Safety doc for unsafe fn FenceCallbackRegistration=
::new()
--

commit b4625b7afb0f7f8aedcbc49f28795f7e749ceb88
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: remove static lifetime

This commit removes the 'static lifetime bound from the FenceCallback trait
and makes FenceCallbackRegistration::new an unsafe function.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 18a43e1bb442f..eef2b9e93f356 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
[ ... ]
> @@ -326,7 +326,7 @@ impl<T: FenceCallback> FenceCallbackRegistration<T> {
>      /// On success the callback is pinned in place and will fire when th=
e fence
>      /// signals. On `AlreadySignaled` the callback is returned to the ca=
ller so
>      /// that owned resources can be reclaimed.
> -    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, =
CallbackError<T>> + 'a
> +    pub unsafe fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit=
<Self, CallbackError<T>> + 'a
>      where
>          T: 'a,
>      {

[Severity: High]
Could returning a safe impl PinInit type here create a soundness hole?

By removing the + 'static bound and making this an unsafe fn, it appears
callers are implicitly required to prevent the returned object from being
leaked to avoid a Use-After-Free.

If safe code leaks the returned object (e.g., via core::mem::forget), Drop
is never called to unregister the callback from the C backend. The C backend
can later access freed borrowed data when the fence signals.

This seems to cause a concrete Use-After-Free in a later patch in this seri=
es
(commit "rust: drm: Add JobQueue") where JobQueue::add_dependency wraps this
in a safe API:

rust/kernel/drm/job_queue.rs:Job::add_dependency() {
    ...
        // SAFETY: The registration is not forgotten. It drops with JobQueu=
e.
        let registration =3D unsafe { FenceCallbackRegistration::new(fence,=
 waker) };
    ...
}

If safe code leaks the Job via core::mem::forget(job) and then drops the
JobQueue, the callback remains registered.

Standard Rust idioms typically require a scoped API (where the callback is
unregistered at the end of a closure) or a strictly 'static bound to safely
support callbacks, since relying on leak-prevention is unsound in safe code.

[Severity: Medium]
Additionally, since this is now an unsafe fn, should it include a # Safety
documentation section explaining this strict leak-prevention requirement to
the caller?

[ ... ]
> @@ -693,7 +693,8 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCont=
extOps> {
>  ///
>  /// let cb_data =3D CallbackData { };
>  /// let waiting_fence =3D ARef::from(fence.as_fence());
> -/// let cb_reg =3D FenceCallbackRegistration::new(&waiting_fence, cb_dat=
a);
> +/// // SAFETY: `cb_data`'s content is not forgotten.
> +/// let cb_reg =3D unsafe { FenceCallbackRegistration::new(&waiting_fenc=
e, cb_data) };
>  /// let cb_reg =3D KBox::pin_init(cb_reg, GFP_KERNEL)?;
>  ///
>  /// // TODO signalling guards

[Severity: Medium]
Is this SAFETY comment misleading?

The comment implies that the requirement is about not forgetting cb_data's
content, but the actual safety requirement is that the registration itself
must not outlive the lifetime of the borrowed data.

The registration must not be leaked so it can be properly dropped and
unregistered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009191124.1022=
902-2-phasta@kernel.org?part=3D1
