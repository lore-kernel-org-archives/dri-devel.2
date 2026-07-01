Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2483BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF94310E329;
	Wed,  1 Jul 2026 09:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hn05lo+y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771A110E329;
 Wed,  1 Jul 2026 09:56:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 253FB411B6;
 Wed,  1 Jul 2026 09:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEB71F000E9;
 Wed,  1 Jul 2026 09:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782899768;
 bh=uFnqjfO2nGnpQRfkiFUM7kAq9hpq2gQ/a+iAbNQdyDY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hn05lo+yqTo162vzSSvmLgoHkc8sZFXTO73a3zpugE032j41FtZRAcgR5cC/mIsWC
 oqb+WxZyigte/GQZKBkZXaiYmAep0fVWbliyTXXxFOHdLIA7ZB+tMSio0XPY3sBbJD
 xp1cndGs6No9+YfwSniB6tXQcpWnVEn7s0jLOOyrTHsS3hH1QGk++EdC7x7glsCzx2
 ooQPJops5d+rLUK2ebXz4gbnEltEwqB5O9z9G9A+zLJBaWmKUz/FSVMRs5+u0CJBcF
 9YJUExToRs6x/TXjrPjHcKoRJgS2PsOr32tKYv6tYSwkl+1flbn88u/WCVI5PjKVif
 CCXDS3L8jpcpw==
Date: Wed, 1 Jul 2026 10:55:46 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Ankit Agrawal <ankita@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 "Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, 
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Kees Cook <kees@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-sgx@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Message-ID: <akThthi2yrXY1meF@lucifer>
References: <cover.1782735110.git.ljs@kernel.org>
 <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
 <akPrTU96BwQJoygw@pedro-suse.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPrTU96BwQJoygw@pedro-suse.lan>
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

On Tue, Jun 30, 2026 at 05:16:51PM +0100, Pedro Falcato wrote:
> On Mon, Jun 29, 2026 at 01:23:16PM +0100, Lorenzo Stoakes wrote:
> > Update the file comment to clarify that both file-backed and anonymous
> > interval trees are provided, referencing the relevant data types for
> > clarity.
> >
> > Also add comments to indicate which parts of the file apply to each.
> >
> > While we're here, convert the VM_BUG_ON_VMA() to VM_WARN_ON_ONCE_VMA().
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>
> This is fine for now, but I'm wondering if it doesn't make sense to, in the
> long term, have:
>
> mm/rmap.c - common rmap mechanisms
> mm/anon_rmap.c - anon rmap gunk
> mm/file_rmap.c - file rmap gunk
>
> or even something like mm/rmap/{core,anon,file,ksm??}.c
>
> While working on my file rmap patches I noticed there's so much stuff just
> splurged all over rmap.c - interval_tree.c - fs.h - fs/inode.c.
> It's a little silly.

Well, Wei had something like this idea a way back, but I'd rather avoid it.

Firstly, with scalable cow coming, I'd rather us not make anon_vma a special
citizen in any way, and I'm going to be heavily modifying all this anyway.

On the interval tree side, I'm simply going to get rid of the anon side of it
altogether with scalable CoW also so that can live as it is now for the time
being.

In general we try to have generalised rmap walk logic for file vs. anon with
rmap_walk -> rmap_walk_[anon, file]() for one obviously.

But obviously there's separate rmap walker logic for file vs. anon.

I used to harbour a belief that we could make anon like file-backed but now I'm
kind of thinking that's not possible :)

So I guess the real answer is - yeah, but let's revisit it after scalable CoW
(and anyway I'm likely to do sensible architectural breakouts as part of that
work anyway).

>
> --
> Pedro

Cheers, Lorenzo
