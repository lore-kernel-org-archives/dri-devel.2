Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAEBC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC1510E2D9;
	Sat, 11 Jul 2026 03:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="MqY76b6M";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B6010E2D9
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3AeSIPFTHInpFBZex7sCRQVC5oe9krpzogwOZ2qz3KI=; b=MqY76b6MbAqA/boBB3v5Q+UuUY
 +xaCarOav7d93r03GHytHuTX+u9FR6ey0PCLSmCnT97Pk+93F3MBLOURRTD4y4B5Hw8jRRExGJKu9
 CFD5Ve3FADeTmdy0K7zVqXGZEXb2/na9TP3gBaQLhdkRP6QZTXYPkcvj8ZunJ4vSJnnJKom9XojmA
 sWXV0Egq+8Z2uGcX4j8XBNqLkGaaVMgTvd7gAJ29OZj0Pqv7/yzEgwa1L2j9fyHexLKmbTVS5907S
 bnHFPHWT5/uS5z0CG4ggS//HPPhk8hHerRZTzqJ88VSVdhKpQkvTtc1wjb+AaiM+3rLm3GKQqokXE
 vY7MdXNA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wiOiC-00000008aSw-1nnc;
 Sat, 11 Jul 2026 03:49:08 +0000
Date: Sat, 11 Jul 2026 04:49:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
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
Subject: Re: [PATCH] lib: test bitmap vs Maple Tree performance for region
 allocations
Message-ID: <alG9NEYLCkMMYTEI@casper.infradead.org>
References: <20260711013910.349586-1-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711013910.349586-1-ynorov@nvidia.com>
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

On Fri, Jul 10, 2026 at 09:39:09PM -0400, Yury Norov wrote:
> Compare the cost of allocating and freeing variable-sized regions using
> a bitmap and a Maple Tree. Both implementations process the same randomly
> generated sequence of region sizes, ranging from 1 to 32 entries, until
> the configured capacity is exhausted.

I'd suggest the IDA might be a better comparison than the maple tree.
Essentially it's a sparse bitmap which plays some fun tricks to lower
the cost.

Eventually, I expect the IDA to be reimplemented on top of the maple
tree data structure instead of the XArray.
