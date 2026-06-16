Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E4ACD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF6810EB97;
	Tue, 16 Jun 2026 16:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="BNogqe4N";
	dkim-atps=neutral
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch
 [109.224.244.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8008D10EC83
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1781627738; x=1781886938;
 bh=P2r8RWkNdoFBCLrjIXLOkZZ8fH3MNFSSDE0O0qYF6ug=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BNogqe4NJSTrXOs4CMdDsbFTEMDm+K6W9ODrr/FMiCgu8IPVCldAUGpNYsM+s7/ol
 ecj/xutzHQw54+MFvOHyc3HfAkMV2PM97gUUZY6Alkahh0vts+BZKC3yxzXZEdvWBa
 MgbPy2Wae4urKGibQJcqahhRTPKFsZLwjC47UZ+quN850YZukaVOEYEOK2kTOihmNd
 +yGTk3kU1gTygDcnV3g4b6tK8xVJHI9DaA5rKzJdtJFslc2plwGQxI8XBz8Is0ysyO
 RJcBjahrNHh2HxZGLqHmmhovyZJl5Ezurk9YFbRJBedyqthKpt1HBC+SSfieK70gz4
 AFI8iISJLDpIw==
X-Pm-Submission-Id: 4gfszk6rs8z2ScsV
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@mailbox.org>, Philipp Stanner <phasta@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rcu@vger.kernel.org
Subject: Re: [PATCH v2 5/6] rust: Add dma_fence abstractions
Date: Tue, 16 Jun 2026 19:35:26 +0300
Message-ID: <20260616163529.6880-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DJAKVXTHQJ99.152VRPFJDPTRU@kernel.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
 <20260616082819.2943886-7-phasta@kernel.org>
 <20260616124755.460550-1-work@onurozkan.dev>
 <d074d3105a2c1d4f594bc6d7b0b09e62757790d5.camel@mailbox.org>
 <20260616145112.14201-1-work@onurozkan.dev>
 <DJAKVXTHQJ99.152VRPFJDPTRU@kernel.org>
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

On Tue, 16 Jun 2026 17:28:04 +0200=0D
Danilo Krummrich <dakr@kernel.org> wrote:=0D
=0D
> On Tue Jun 16, 2026 at 4:51 PM CEST, Onur =C3=96zkan wrote:=0D
> > repr(C) only makes sense when the type have multiple fields.=0D
> =0D
> I don't think that's universally true. repr(transparent) guarantees the l=
ayout=0D
> and ABI match the inner field. The wrapper is passed through calls exactl=
y as=0D
> the field would be. repr(C) guarantees C-compatible layout and makes the =
type=0D
> follow the platform's C ABI for passing an aggregate, which isn't always =
how the=0D
> bare field is passed.=0D
=0D
I was too focused on the field ordering perspective during the review, sorr=
y for=0D
that.=0D
=0D
Onur=0D
