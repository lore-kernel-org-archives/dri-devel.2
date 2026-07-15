Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D22DC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DF610E1F2;
	Wed, 15 Jul 2026 20:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="j1/mN7ts";
	dkim-atps=neutral
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A398D10E1F2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1784145735; x=1784404935;
 bh=4QqeuF5FUcRt5pFIExp1uYIABYGFvYOct0RfvBryi2M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=j1/mN7tsc7BUeIEdRM7EQzx9zri2n42/KPuvQ+WuRj+XQw7RXh4p+1yWVEyg9ZWhM
 VsWRzo4DRZMYP6xxVJdLyJAQBQ4zXnojPCGIfDwJctnfw40e+ZN8b+TRDGMInnJPvX
 R+BTnE0tgMd48acQzULIDu23OM6QWNoEaBcLZ7EfMNcYB7mggSgWq1MbWJRtYojL1J
 P2ea+jTzoG1Q2dBoLnNXT9oQvAv87RMVANGDYretM7/cvdATiNE8D5T2qwZWorERr8
 OVV2g8la2rv7Bbxg74o/OHvh1xvitvpXkabPaW0F/qofOlp5vXQ8OftenB5ghnmSnO
 3WklqdoF88K7w==
X-Pm-Submission-Id: 4h0nBg2hrLz1DDpB
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>, Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v5 3/5] rust: sync: Add abstraction for rcu_barrier()
Date: Wed, 15 Jul 2026 23:01:52 +0300
Message-ID: <20260715200156.47101-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260703073141.3962604-5-phasta@kernel.org>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-5-phasta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 03 Jul 2026 09:31:39 +0200=0D
Philipp Stanner <phasta@kernel.org> wrote:=0D
=0D
> rcu_barrier() is a frequently used C function which is always safe to be=
=0D
> called.=0D
> =0D
> Add a safe abstraction for rcu_barrier().=0D
> =0D
> Signed-off-by: Philipp Stanner <phasta@kernel.org>=0D
> ---=0D
>  rust/kernel/sync/rcu.rs | 20 ++++++++++++++++++++=0D
>  1 file changed, 20 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs=0D
> index a32bef6e490b..7031ca5d2473 100644=0D
> --- a/rust/kernel/sync/rcu.rs=0D
> +++ b/rust/kernel/sync/rcu.rs=0D
> @@ -50,3 +50,23 @@ fn drop(&mut self) {=0D
>  pub fn read_lock() -> Guard {=0D
>      Guard::new()=0D
>  }=0D
> +=0D
> +/// Wait until all in-flight call_rcu() callbacks complete.=0D
> +///=0D
> +/// Note that this primitive does not necessarily wait for an RCU grace =
period=0D
> +/// to complete.  For example, if there are no RCU callbacks queued anyw=
here=0D
> +/// in the system, then rcu_barrier() is within its rights to return=0D
> +/// immediately, without waiting for anything, much less an RCU grace pe=
riod.=0D
> +/// In fact, rcu_barrier() will normally not result in any RCU grace per=
iods=0D
> +/// beyond those that were already destined to be executed.=0D
> +///=0D
> +/// In kernels built with CONFIG_RCU_LAZY=3Dy, this function also hurrie=
s all=0D
> +/// pending lazy RCU callbacks.=0D
> +///=0D
> +/// Note that this is one of the RCU primitives which must not be called=
 in=0D
> +/// atomic context.=0D
> +#[inline]=0D
> +pub fn rcu_barrier() {=0D
> +    // SAFETY: `rcu_barrier()` is always safe to be called. It just migh=
t wait for a grace period.=0D
> +    unsafe { bindings::rcu_barrier() };=0D
> +}=0D
> -- =0D
> 2.54.0=0D
> =0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
