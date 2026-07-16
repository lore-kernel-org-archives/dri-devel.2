Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65373C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C572B10F323;
	Thu, 16 Jul 2026 14:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="Cl/wl1+M";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87AF010F323
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Yw0qM4Vl6ROJvhog0C+oQL24gbChejWRt36l3chQZbM=; b=Cl/wl1+MgZhok8096gtrdntDpt
 8ErM4TVKXRHc1qtPOoeKk26yYhJKxsdrznzzOZv/FbtgdbAWO+bDSeO7mXrcEE+bWkjkm6ICE5hBo
 PbZdfWZ5Fn4xv8IHkt30L1eKNU22DeVQXgut74yui9pSxvTcyVa/LaiUgporSJn9w68dWLN+fXzcV
 qe9KyI6G9vAP+fKHJnMyKkLGIxgAdtHhFomSMoc9DZe/9TJTtr0J0HCut9ub4SAePa+Zew9qj+No4
 7DEzwTaf0YXRy9/P1/+iAHJUm9oEz2RT0veCn6sV7VWtSjRqlreO35JWWJvma9K7mxBJ1pR+O0zXL
 /FEognJA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wkMf6-00000002dWs-1Zg2;
 Thu, 16 Jul 2026 14:02:04 +0000
Date: Thu, 16 Jul 2026 15:02:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Eliot Courtney <ecourtney@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Simona Vetter <simona@ffwll.ch>,
 Tamir Duberstein <tamird@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
 Trevor Gross <tmgross@umich.edu>, Yury Norov <yury.norov@gmail.com>,
 Zhi Wang <zhiw@nvidia.com>, maple-tree@lists.infradead.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance for
 region allocations
Message-ID: <aljkXMNLkciazVVi@casper.infradead.org>
References: <20260711063602.426311-1-ynorov@nvidia.com>
 <alf1lUH0EDf3CRMl@pedro-suse.lan> <algrZLHyYcR2mwzX@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <algrZLHyYcR2mwzX@yury>
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

On Wed, Jul 15, 2026 at 08:52:52PM -0400, Yury Norov wrote:
> The test is very well motivated by that discussion. I'm not saying
> it compares apples to apples. I'm trying to quantify the answer to a
> very specific question: what is better for NOVA ID allocator. Or more
> broadly: what's the best data structure for range ID allocators of a
> given capacity.

From my work with the IDA, there are definitely ID allocators which
allocate only a single ID, less than ten or less than a hundred.  Could
you scale the benchmark down to 10 and 100 rather than starting at 1000?
