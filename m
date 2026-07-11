Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CB9C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7620610E2EC;
	Sat, 11 Jul 2026 06:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EPG2DeF4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E99410E03D;
 Sat, 11 Jul 2026 06:33:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 141F2600C3;
 Sat, 11 Jul 2026 06:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80AA1F000E9;
 Sat, 11 Jul 2026 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783751598;
 bh=IhuKekt2PQXuM2aC1ZwPWPJ0ZHIWcPpVLch8ZcQ+oPU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EPG2DeF4UTCSaR61iBwMXCgHQEn643ddtwajqsHEeGX2acXFY9ki43vFQ7gy8Bl0W
 BuXOW3LXg2kAEBfh13Hs0ZYMFR91r8JsrHpYYyQ3iVnNER02xUYKPYy+XAphOKNsC9
 WxQoVUhR1TUlCSyiEB/VspCyJtQW/GzjedFjyCgZJPJ6Q/gQG6rVW2boHGQqSDe7fZ
 b4ZROnX7C4o1b1i8MbQJXaxv8hBq+sorHlvvkjlhjEhEf1cNal0kos9Dmx4MMB3uPX
 +caq0W8QPJajr44BSXmfelnlwPZUxmrKpz84RfDbyY5pbBa8+xpkhUS3UCT0amuC6h
 49Cf5nI8dBADw==
Date: Sat, 11 Jul 2026 07:32:51 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, 
 Pedro Falcato <pfalcato@suse.de>, Russell King <linux@armlinux.org.uk>, 
 Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
 Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 SJ Park <sj@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
 Kees Cook <kees@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, kasan-dev@googlegroups.com, linux-sgx@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 33/33] tools/testing/vma: output compared expression
 on ASSERT_[EQ, NE]()
Message-ID: <alHjL4lT8WLrJ1uj@lucifer>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-33-2a5aa403d977@kernel.org>
 <alFfopehgN0dkMzM@gourry-fedora-PF4VCD3F>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alFfopehgN0dkMzM@gourry-fedora-PF4VCD3F>
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

On Fri, Jul 10, 2026 at 05:09:54PM -0400, Gregory Price wrote:
> On Fri, Jul 10, 2026 at 09:17:14PM +0100, Lorenzo Stoakes wrote:
> > Update the macros to output the compared values at hex for easier debugging
> > when test asserts fail.
> >
> > We have to be careful not to re-evaluate expressions as they may have
> > side-effects. So update the code to take local copies and use these for
> > both the test and the debug output.
>
> Aw you found it before i reported it :]

Claude did :) I take no credit for it :P I guess I thought the re-eval wouldn't
be an issue but obviously when it's a side-effect and the userland tests do do
that, it's very important you DON'T re-evaluate :P

Human 'meh that'll probably be fine-ish' vs. robot/Gregory laser-focused vision
doing the whole 'Sorry Dave I'm afraid I can't do that' ;)

>
> >
> > Also remove unused IS_SET() macro.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>
>
> Reviewed-by: Gregory Price <gourry@gourry.net>
>

Cheers, Lorenzo
