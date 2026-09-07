Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCAC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 18:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB4A10E035;
	Mon,  7 Sep 2026 18:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hvYeMkQE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E7510E035
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 18:15:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96778601DB;
 Mon,  7 Sep 2026 18:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BC51F00A3A;
 Mon,  7 Sep 2026 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788804899;
 bh=G+mCSvbuHye2yBVI/OAa/LXl0oj9zqUI1neCRreAeV0=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=hvYeMkQE7bwUwMv5STk20dP0kTxw9T/YYZgdO5DHOulVZpT02Qho8hdv30USGae+Z
 6xaEPdNJGxlYqVZKejChg28HI9oFT3R5ERx23XI3MyD/cBfcDGGHTzVnHYqPdVoqyx
 McvVmqTEZAWwOuq9kFd7aVOqZptCCktiHbRYxNdUGTw50XX0Xnokc8dEZstNPZ8xM4
 e2aKEYBb4lENL561ne3r8OyVoqifgJWm6jTNEcwTftL/Sy9LI+JiwBkDnVQEdlGMkO
 NKXllKX8B27iBasLgEweFwF0V6TwPXUYKO8z+3aPEKCww/Ioipjoufl8381WBs63eR
 n8NPHJiV69kCw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 20:14:52 +0200
Message-Id: <DL9AEUZ4VGV5.2RT33JE0MHYME@kernel.org>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v11 1/2] rust: Add dma_fence abstractions
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Yury Norov (NVIDIA)"
 <yury.norov@gmail.com>, "Asahi Lina" <lina+kernel@asahilina.net>, "Burak
 Emir" <burak.emir@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
References: <20260905085343.1827305-2-phasta@kernel.org>
 <20260905085343.1827305-3-phasta@kernel.org>
In-Reply-To: <20260905085343.1827305-3-phasta@kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat Sep 5, 2026 at 10:53 AM CEST, Philipp Stanner wrote:
> +impl<'a, T: Send + Sync + FenceContextOps> Drop for DriverFence<'a, T> {
> +    fn drop(&mut self) {
> +        let guard =3D self.as_fence().lock();
> +
> +        // Use dma_fence_test_signaled_flag() instead of
> +        // dma_fence_is_signaled_locked() because the C backend wants to=
 get rid
> +        // of the latter.
> +
> +        // SAFETY: `guard` is valid until the `call_rcu()` below.
> +        let signaled: bool =3D unsafe { bindings::dma_fence_test_signale=
d_flag(guard.as_raw()) };
> +        if !signaled {
> +            pr_err!("DriverFence drops unsignaled. Danger of memory corr=
uption!\n");

I'm not sure we want to keep this as pr_err!().

If we really want to keep warning about this I'd either make this a WARN_ON=
() or
dev_warn() (we can easily store a device reference in the fence context), s=
uch
that it is at least clear who's the offender.

My preference would be dev_warn(), as I don't think it is that bad of an er=
ror
condition to begin with. It would be pretty odd to have a driver where a Dr=
iverFence
drops while the corresponding GPU job is not dropped. And further it'd be p=
retty
odd if dropping the GPU job would not imply that the GPU actually stopped
processing the work associated with the job.

For the same reason I also think it is a bit misleading to say "Danger of m=
emory
corruption!". It's not the signaling of the fence that does prevent memory
corruption; it's the driver implementing a proper teardown sequence. And if=
 this
sequence is structurally detached from the lifetime of the DriverFence (and=
 Job)
structure, something is structurally wrong with the driver anyway.

Furthermore, it would be very natural to just require the generic Job type =
to
own a DriverFence. In this case it becomes natural to either signal the fen=
ce on
Job completion, or just drop the Jobqueue, which does the ring teardown and
subsequently drops all the Jobs, which would also imply signaling the
DriverFence with ECANCELED. I.e. I think the fact that the DriverFence is
signaled with ECANCELED if it is still unsignaled should just be an API con=
tract
and not an error condition.

Honestly, given all that, I'd expect drivers to otherwise just wrap a
DriverFence in a new type, which just signales the inner DriverFence with a=
n
error code in its own destructor.
