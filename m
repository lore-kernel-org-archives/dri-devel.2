Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C49CD98CF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE7F10EA0A;
	Tue, 16 Jun 2026 11:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cQq18BbZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA4610EA0A
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:02:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2198C40B65;
 Tue, 16 Jun 2026 11:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE3B1F000E9;
 Tue, 16 Jun 2026 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781607735;
 bh=FZdmkJa6dqoSyrKuaAVidWmX42dvojCrnG29qH9XCgw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=cQq18BbZC4JXqTwKwf+CBS3TKAMMmefYiM1Ym96bLGdhPIzG7Co8NkIkLjH9MItPx
 UGCD6xe0cbB2mVyBbPOBRhKMH+kNEYv+T0uZr/bTpYrn7ZhQS/ArXVCWIY9mTf61cG
 wUV4zW91EJMYL4P0ChI9nnkmPJO6qJDpMiE9soBsKIqhEFk4ftie4xNalLTUp1Lxpi
 zffNy1CQtg9ngSo/OcREICPqxInKJ34VEzwoBPmAJt/PZYROHgrZaBJ/XtiYB1mPzK
 HPvLFPyr62rbPgRJdRFpA0hbS0AMG3fMNxH8RtfdasRvEvut+gK64S5hSmJzDtm6zu
 aboGmQh5BSdbA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 13:02:07 +0200
Message-Id: <DJAF8AXHRRIX.2E0FNAQP3DOWK@kernel.org>
Subject: Re: [PATCH v2 0/6] rust / dma_buf: Add abstractions for dma_fence
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Igor Korotin" <igor.korotin@linux.dev>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Krishna Ketan Rai" <prafulrai522@gmail.com>, "Shankari Anand"
 <shankari.ak0208@gmail.com>, <manos@pitsidianak.is>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rcu@vger.kernel.org>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
In-Reply-To: <20260616082819.2943886-2-phasta@kernel.org>
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

On Tue Jun 16, 2026 at 10:28 AM CEST, Philipp Stanner wrote:
> Changes since v1:

It seems that some of the comments from v1 [1][2] are not addressed, did yo=
u
forget them?

In particular the pin_init_from_closure() looks unnecessary and can probabl=
y
replaced with something like (untested):

	let mut callback =3D Some(callback);
=09
	try_pin_init!(Self {
	    cb <- Opaque::try_ffi_init(|ptr| {
	        // SAFETY: `fence.inner.get()` is a valid, initialized `struct dma=
_fence`. `ptr`
	        // points to the `struct dma_fence_cb` field within the pinned all=
ocation, so it
	        // remains valid until `dma_fence_remove_callback()` in `PinnedDro=
p` or until the
	        // callback fires.
	        let ret =3D unsafe {
	            to_result(bindings::dma_fence_add_callback(
	                fence.inner.get(),
	                ptr,
	                Some(Self::dma_fence_callback),
	            ))
	        };
	        match ret {
	            Ok(()) =3D> Ok(()),
	            Err(e) =3D> {
	                let cb_back =3D callback.take().expect("success path did n=
ot run");
	                if e =3D=3D ENOENT {
	                    Err(CallbackError::AlreadySignaled(cb_back))
	                } else {
	                    Err(CallbackError::Other(e))
	                }
	            }
	        }
	    }),
	    callback: callback.take().expect("error path did not run"),
	    fence: ARef::from(fence),
	}? CallbackError<T>)

Please also see my previous comments regarding DriverFenceBorrow, it still =
seems
to miss the lifetime and it should probably use ManuallyDrop<DriverFence>.

It also seems the patch series was created without --base, what's the base
revision?

[1] https://lore.kernel.org/all/DIW3ZK5NLKU3.1QYMQB0ISHFBG@kernel.org/
[2] https://lore.kernel.org/all/DIW42TO5HY6H.2RLL8V8H48A5A@kernel.org/
