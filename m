Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC4ACCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5341126C9;
	Fri, 16 Oct 2026 09:04:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A48A1126C9
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:04:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FC7060008;
 Fri, 16 Oct 2026 09:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBA81F000C4;
 Fri, 16 Oct 2026 09:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792141476;
 bh=lB2XWzYyug6nQurJcFsS3iMgbHqy0ptYmGVg0FDbZsQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aeeBkT1LpYiyskJzxEFXRKpJKhxC+ACmsT3xat7JHQYrvWhv8zTDU8LE4skyzuAdF
 On+n/nTtC7xYijOE8b39QCnUD/7n5wrBrpOOFocS9OjJaRhWV1F/o87Nq0BwsQnRyR
 TZIPHs+R0QhuJwNA/PTiU0ncI+/di68XzX7M7YfJst5CG5tK90wi3xxLGVEN/YGbrN
 SG3K61ZWLPkiUiqU6bg9m86m9TmTwTs6WCYA3EnDc0DgUAq4m/YS/pUXBFzN/iyzPT
 /plV2O7YxPVghJLu438BHvELL0QxpFxW3bG3+/QoVrko3r5qautBPOIW68c4Q4KkRC
 vbAqYIEnsnt1g==
Message-ID: <sashiko-outbox-174048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 3/5] rust: DmaFence: Don't drop on signal
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261016085724.1031766-5-phasta@kernel.org>
References: <20261016085724.1031766-2-phasta@kernel.org>
 <20261016085724.1031766-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:04:35 +0000
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
- [High] dma_fence: counter underflow in DriverFence::signal leads to panic=
 or UAF
--

commit 2af2d8c956b06120d0b00ac40ad908be8f229a7d
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Don't drop on signal

This commit changes the DriverFence::signal method to take a shared referen=
ce
instead of consuming the object. This allows multiple or concurrent calls to
signal() on the same fence object, avoiding unnecessary drops in atomic
contexts.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 0028124e6aa64..b67121c7abd41 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -806,23 +806,23 @@ pub fn as_fence(&self) -> &Fence {
>      }
> =20
>      /// Signal the fence. This will invoke all registered callbacks.
> -    pub fn signal(self, res: Result) {
> +    pub fn signal(&self, res: Result) {
>          let fence =3D self.as_fence().lock();
> =20
>          // SAFETY: `fence` is valid because `self` is valid. The lock mu=
st be
[ ... ]
>              // SAFETY: `fence` is valid because `self` is valid. The loc=
k must
>              // be held, which we acquired above.
>              unsafe { bindings::dma_fence_signal_locked(fence.as_raw()) };
>          }
> =20
>          // SAFETY: `self.data` is valid because `self` is valid.
>          let fctx =3D unsafe { self.data.as_ref().fctx };
>          let _ =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);

[Severity: High]
Since signal() now takes a shared reference and can be called multiple time=
s,
will this unconditional decrement of nr_of_unsignaled_fences cause an
underflow?

When called repeatedly for the same fence, this decrement executes outside
the if !signaled block and will occur on every call.

This could cause the counter to artificially reach 0 and bypass the panic
check in FenceContext::drop(), potentially allowing the context to be freed
while unsignaled fences still exist.

Could this result in a use-after-free when those fences are later queried by
the C backend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016085724.1031=
766-2-phasta@kernel.org?part=3D3
