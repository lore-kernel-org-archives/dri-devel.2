Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E03CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339A811A891;
	Fri,  5 Jun 2026 13:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oO9GB7o9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F35511A891
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:38:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75280601FE;
 Fri,  5 Jun 2026 13:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2D61F0089A;
 Fri,  5 Jun 2026 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780666715;
 bh=rfGnNvqCUgib40545imCPSY/SiAip+ywc+XcFOxOI1I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oO9GB7o9uAXwo+00LhbxLaarHr8hIlPEBbsu8oc3/S5hjrlJe8PXacG046kdH9GVb
 AvAr42tzR2kFzRfQcLOnBeX3k4XMmAXBvmOcj5r4ptTIeV876elVauaRVjeKtZMOOt
 69vWy7AlAolhLTyv83ToNnJCvJn/bMH1Tt43j5bQUE3a0BVLr7p8Jn5/7fhaq1dQJY
 8Mq/IkAEcXGHdB+b0+2rlH/rv75fUTQm20pNFgCmxTWKVQL2pY/EmVnEO4GKmEhrKX
 o02n+dFDYmZVwaJiKgesUTlzFW0q7RIegcRRMAu7NxnMclJImBDymzDrrS992WtsKG
 uZfXVrS2Apa5A==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 45FD5F4007C;
 Fri,  5 Jun 2026 09:38:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 09:38:33 -0400
X-ME-Sender: <xms:WdEiap8kdWuE3YysUwdswOaPA4fijezl3rwvq8QlOJbI407Y7iXhRg>
 <xme:WdEiaqLy6oduWR1UbZXHhGEFv3SKo3dScTwQeFa3ivlNvYZva65JW4ryqNdWLdBB2
 u2xIuKLthdMGopom9GNHrzR2-GGe7qjH2s6hh3q5G2X909ZNk2b6g>
X-ME-Received: <xmr:WdEiauQlPSkr0f6mcCt8ZVO0VRvDXOWOWSL4iQVH4gpW39A2l2XGDL0Fg-w>
X-ME-Proxy-Cause: dmFkZTGM2UkizV+reMWXsdwOJhYIOL/j/0ZD8k5LsRt//sPW6kjaf/1MAAJ0mS4qvAWJgr
 15+ZE9Ned2LtlVaSIU/hTIK31lh/ZiF7B+6Dl48DgBzoVccKuJMd4aizR50L5yXembF5zd
 WRdevGEw5pSn1Aeg5KzCaeplPe5IioSwoezYandUOrmoD1L54WQwDc3vi5fY5g9Iz4hip2
 IA22r8289UO0Sed2c+lFj+GJ/uNQW+50/kDj0dlPgjjbwaStax/Dtg4Ihfe4AAFyy9lyV3
 ytF+09oOPt2XLy/4hGi7Rjmwe+luN8JXrhtMX41ZDdPdr5SUzyVc0wPipMuMMsFN/qP7l7
 1N1Asq6LYd4b2NYnEKOHrpCdd71edu6ZAcfpGU0H1c5F7kO0skdTw2HFVNQC5V5Wtsv7/A
 mjGkPdZn8zsr50HiI8y3gbLIByugJtC0+CMw1KPawpOrDQuIgPQP0pKn36hcgeSxWt0ipq
 We2x35EiJr+P3P6piUmIsF2X7uUWBDNUXdWacFNLBuO0yu7utV+And7dGk9pPqDzifAUN0
 RiAmGQ2yrbn+AiyZgtRwzPKQMKPTPRbN6wl9mC+kWELB4371sMo1QwziOH6wgU4UD8HCFG
 PIo0tJ78ajIuqt+xgU4MGlfE8jKMnAgGhIyxidGTRE8iECgahFadvJAwqEYQ
X-ME-Proxy: <xmx:WdEiaj8WmeIFPgDGITdJlJjt7rAzDJyOUtp-B08Z_iU3iUQXHiUIbA>
 <xmx:WdEiaud3In2TqqlhplDhtdilwE7LwfMwkrICvmEzG4iuj93y6rVxiw>
 <xmx:WdEialmO2nAv5kvLJs6v7Au4-SPQwiT0K1ugtd6k8bM4AlAm7yye4w>
 <xmx:WdEiariG4KWGWFJSC8B6SJFY-vm998RciyHDyrr6-VP8QN1brhiVlg>
 <xmx:WdEiavouDb2amznrBxATu6XcjzM16enOshIRh5SCy4H9n_dMCxHHJroI>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:38:31 -0400 (EDT)
Date: Fri, 5 Jun 2026 06:38:31 -0700
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
Subject: Re: [PATCH 2/3] rust: maple_tree: add load_rcu()
Message-ID: <aiLRV1UbaSYokAO_@tardis-2.local>
References: <20260605133541.22569-1-boqun@kernel.org>
 <20260605133541.22569-4-boqun@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605133541.22569-4-boqun@kernel.org>
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

On Fri, Jun 05, 2026 at 06:35:39AM -0700, Boqun Feng wrote:
> From: Alice Ryhl <aliceryhl@google.com>
> 
> Now that we have a concept of rcu-safe containers, we may add a
> load_rcu() method to MapleTree that does not take the spinlock.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Please ignore this duplication...

Regards,
Boqun
