Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55DCC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024A310E079;
	Wed, 29 Jul 2026 17:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m/6ZIUL/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2208E10E079
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 17:18:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD7F141398;
 Wed, 29 Jul 2026 17:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C0E1F000E9;
 Wed, 29 Jul 2026 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785345518;
 bh=V4fqphSqGLyY1OSa6m/tjYmdpF1YTGlh/6RPGHROYy4=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
 b=m/6ZIUL/eN8niD4PQkGkB/eF57W/SS8FJfNsbWh+uqFg0jzNTdx658Uf3rlqDMGE1
 oceZyiGSu2q9luzkAMpax5DHmnnrM9scd97SyAQ1FK/Sl3MEQnwlQS6cOfKAmM9SLY
 Y3HQarbZzD6Rm+9juCY0juSef+9crMHDuNi1aW8+OlkOha6Mip9XBb2YZwUVIUAIUM
 A9rse78v0SgTk2hXd2NtaKwa2A5cNplN917nHkoB2u+75hBJ45d1uinT5MuXWsbZkh
 OmwG0cWcQznlXI5u3QNyv+/HCxyj9Q8QWQDIaU+57oaX79OsrVVec/OfcFDgRhityn
 359/LtegkSwTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 5116CCE0B67; Wed, 29 Jul 2026 10:18:38 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:18:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Lyude Paul <lyude@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Eliot Courtney <ecourtney@nvidia.com>,
 Mirko Adzic <adzicmirko97@gmail.com>, Timur Tabi <ttabi@nvidia.com>,
 Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Subject: Re: [PATCH v7 3/5] rust: sync: Add abstraction for rcu_barrier()
Message-ID: <296c71c4-4d2f-416d-bfbe-40fd911b44db@paulmck-laptop>
References: <20260729094542.302965-2-phasta@kernel.org>
 <20260729094542.302965-5-phasta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729094542.302965-5-phasta@kernel.org>
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
Reply-To: paulmck@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Jul 29, 2026 at 11:45:40AM +0200, Philipp Stanner wrote:
> rcu_barrier() is a frequently used C function which is always safe to be
> called.

Just checking...  Here "always safe" means only from task level, with BH,
preemption, and interrupts all enabled, correct?

In contrast, if you do this:

	preempt_disable();
	rcu_barrier();
	preempt_enable();

the results won't be safe.

							Thanx, Paul

> Add a safe abstraction for rcu_barrier().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/sync/rcu.rs | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b..7031ca5d2473 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -50,3 +50,23 @@ fn drop(&mut self) {
>  pub fn read_lock() -> Guard {
>      Guard::new()
>  }
> +
> +/// Wait until all in-flight call_rcu() callbacks complete.
> +///
> +/// Note that this primitive does not necessarily wait for an RCU grace period
> +/// to complete.  For example, if there are no RCU callbacks queued anywhere
> +/// in the system, then rcu_barrier() is within its rights to return
> +/// immediately, without waiting for anything, much less an RCU grace period.
> +/// In fact, rcu_barrier() will normally not result in any RCU grace periods
> +/// beyond those that were already destined to be executed.
> +///
> +/// In kernels built with CONFIG_RCU_LAZY=y, this function also hurries all
> +/// pending lazy RCU callbacks.
> +///
> +/// Note that this is one of the RCU primitives which must not be called in
> +/// atomic context.
> +#[inline]
> +pub fn rcu_barrier() {
> +    // SAFETY: `rcu_barrier()` is always safe to be called. It just might wait for a grace period.
> +    unsafe { bindings::rcu_barrier() };
> +}
> -- 
> 2.55.0
> 
