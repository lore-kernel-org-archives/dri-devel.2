Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B405CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD6011A892;
	Fri,  5 Jun 2026 13:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OG9k2hxv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC0711A891
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:38:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF9BA40E17;
 Fri,  5 Jun 2026 13:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC281F00899;
 Fri,  5 Jun 2026 13:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780666688;
 bh=aUElHjjSr/wCG09eJuAWs4nSH4fgcOTWg+17svsiIlI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OG9k2hxvR7H2l3Di+gaBO9Fb8HG8b8OClHLonP12Pco4CU2InrbxU6oKfTgPHc3Yf
 R0RxTjGZvVVsyHPCEZAUb2ZooIcRogCXWwZ+4IizG/D45HB4YLFrgPwCfq3ifdxfF1
 GEZX/hDzzIjra+QC0+mHU/nF0vhDm4MrhG+X2yRmmeoeF3EZMhXqCjKdfX14WMiq0Q
 IHNE5HuVOuLyeyGDjFHTdGXQQEd51QZa7IWb/aYV9lMjkS4LissMYQItBUl6nuRfjV
 2u4EIY9Gtwe1NwqtM4TBoWF4rc8OJYtgy+ib6ebNdAqqR75H0UVhSFvf60EBJKQz3e
 qZQPS9CqZXJqg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id E1F9DF40069;
 Fri,  5 Jun 2026 09:38:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 09:38:06 -0400
X-ME-Sender: <xms:PtEiatK6eLii7KziBaBTT8wjRaVWmcjLxXTg6xUvAOnv2sFTLGq5eA>
 <xme:PtEialm4ZzymOsemKfvmeIS0Gr-Ca3sAfyuazH0pkyee80LMDt3rzBkSQnzegHoqN
 XlQqG-Ac7dCnEukcYvf-nwTQUobIsaEP_LSFNJzDb-28Vblqycsow>
X-ME-Received: <xmr:PtEias--sxLWQymblUXu_M6gKU8ZmrKVjAysmr96GKYhelqxwByh3SmIPto>
X-ME-Proxy-Cause: dmFkZTGM2UkizV+reMWXsdwOJhYIOL/j/0ZD8k5LsRt//sPW6kjaf/1MAAJ0mS4qvAWJgr
 15+ZE9Ned2LtlVaSIU/hTIK31lh/ZiF7B+6Dl48DgBzoVccKuJMd4aizR50L5yXembF5zd
 WRdevGEw5pSn1Aeg5KzCaeplPe5IioSwoezYandUOrmoD1L54WQwDc3vi5fY5g9Iz4hip2
 IA22r8289UO0Sed2c+lFj+GJ/uNQW+50/kDj0dlPgjjbwaStax/Dtg4Ihfe4AAFyy9lyV3
 ytF+09oOPt2XLy/4hGi7Rjmwe+luN8JXrhtMX41ZDdPdr5SUzyVc0wPipMuMMsFN/qP7Y4
 vlvWIn4oKFFs5cDfKtpLIOpgf0tvY+jUlf93fzbNnDt/68bk08iWkzm7a9LZAXFi0jcjja
 anStgXfOiYQc7NykiIvESKjdbaAXID9EkTiRRiWRazyjO7ppNO+ohdQu+2KGRK1Ci0Yy72
 u53VtHJSqNlNswggi6/fGyg+BW1RItpPEyNZR3/EAnYagL4E3XpEuPq5mK9lPEUG7lm9rU
 W1v3pmB/5ZQjAjGPD2kDPlrHwv57tADfi7fYLHCdP5sqxfxbTrepoQxetAxKlCQvqLgiy+
 rD6Re6dvHNNw2pbagIyYAr/zUHrG7mA5sTaFd93oywdG8moYw+mbia+m4AXA
X-ME-Proxy: <xmx:PtEiak5UH5o2U2bQZ6whoDhkH6AfADeDIOpZuV26jyf4VZLbvvJGYQ>
 <xmx:PtEiakpe4HQpkkrrqd7v3fu_o0beu-hZzcO7RbSBSXe2jVZrdX3xRQ>
 <xmx:PtEiaoCY9saDv-squihWfpTXi638dd_gwAadllMsnpKtunPHWfqOhA>
 <xmx:PtEialPj464sUHdR_5m-FdX7cd0CBs_DHCoUCnQ2LeoxYcQ0AvbLMw>
 <xmx:PtEiavnekmERjw_NDs5-r3W_q4_Gbg9GasfZUCgXgpghQvfc6CsXkau3>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:38:05 -0400 (EDT)
Date: Fri, 5 Jun 2026 06:38:04 -0700
From: Boqun Feng <boqun@kernel.org>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH 1/3] rust: rcu: add RcuBox type
Message-ID: <aiLRPNuS9hDMVUJc@tardis-2.local>
References: <20260605133541.22569-1-boqun@kernel.org>
 <20260605133541.22569-2-boqun@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605133541.22569-2-boqun@kernel.org>
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

On Fri, Jun 05, 2026 at 06:35:37AM -0700, Boqun Feng wrote:
> From: Alice Ryhl <aliceryhl@google.com>
> 
> This adds an RcuBox container, which is like Box except that the value
> is freed after waiting for one grace period (via {kvfree_,}call_rcu()).
> 
> To allow containers to rely on the RCU properties of RcuBox, an
> extension of ForeignOwnable is added.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> [boqun: Make RcuBox generic over Allocator and add tests]
> [boqun: Add type alias for Rcu*Box]
> Co-developed-by: Boqun Feng <boqun@kernel.org>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---

Please ignore this duplication...

Regards,
Boqun
