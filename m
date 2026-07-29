Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B83C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF1089089;
	Wed, 29 Jul 2026 18:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RupjfiUe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4983989089
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:58:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BF3D40290;
 Wed, 29 Jul 2026 18:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD61F000E9;
 Wed, 29 Jul 2026 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785351524;
 bh=a7xQnZiq/bBhFVL1TMInPD93nGWgpZ8+XaCM3fzGCUQ=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
 b=RupjfiUe9ot/VVh0BFkPolgJigl1mNHSVogjNJPzkceLbZcRO3tKy5t9rAn8oX4Ff
 bosOwYXIXIPZk1rXLh8hwj29hinId2E8M9thaTarxrCct/OOnl43VnXUGwEcNje7dw
 R/XdnOwJmQVuHfrcNuO1lvf/YWZb+0MxAq2FRspnof3XBtz24l8AcyjrhtFATGF+eK
 N50fEXvs4//aoienjBWZqLrLwkTApIP2AhfmpKPYO7zjkBm8m2p+dlUDQ7VxYWYY4L
 69S/bls7q2q4aX5G5yINLBtAygomTF368kXXrKMNUHrft4y11HNuHvGXm3EDcqj/zu
 nRaeFxH45/vkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 05987CE0B67; Wed, 29 Jul 2026 11:58:44 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:58:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
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
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org,
 Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v7 3/5] rust: sync: Add abstraction for rcu_barrier()
Message-ID: <f680fb1b-ecbc-47b4-a252-b792933bfe3e@paulmck-laptop>
References: <20260729094542.302965-2-phasta@kernel.org>
 <20260729094542.302965-5-phasta@kernel.org>
 <296c71c4-4d2f-416d-bfbe-40fd911b44db@paulmck-laptop>
 <DKBA29HOEUIX.H4CDPOQQXRD0@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKBA29HOEUIX.H4CDPOQQXRD0@garyguo.net>
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

On Wed, Jul 29, 2026 at 07:47:46PM +0100, Gary Guo wrote:
> On Wed Jul 29, 2026 at 6:18 PM BST, Paul E. McKenney wrote:
> > On Wed, Jul 29, 2026 at 11:45:40AM +0200, Philipp Stanner wrote:
> >> rcu_barrier() is a frequently used C function which is always safe to be
> >> called.
> >
> > Just checking...  Here "always safe" means only from task level, with BH,
> > preemption, and interrupts all enabled, correct?
> >
> > In contrast, if you do this:
> >
> > 	preempt_disable();
> > 	rcu_barrier();
> > 	preempt_enable();
> >
> > the results won't be safe.
> 
> This is same for all sleepable functions. In order to avoid having to mark all
> sleeping function unsafe, we've decided that sleeping from non-preemptable
> context is "safe", but is a bug regardless.

Got it, thank you!

I tried to resist parameterizing "safe" over things like execution
contexts, but obviously failed to do so.  Besides, there is a name for
that sort of thing, and that name is "precondition".  ;-)

Adding Julia Lawall on CC based on her recent work with preconditions,
which might be an act of kindness or of vandalism.  You guys get to
decide.  ;-)

							Thanx, Paul
