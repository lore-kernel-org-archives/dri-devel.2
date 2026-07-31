Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B6CC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF2A89CCE;
	Fri, 31 Jul 2026 06:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QC02GEhf";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D76F289CCE;
 Fri, 31 Jul 2026 06:59:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1361D204C;
 Thu, 30 Jul 2026 23:59:40 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F1523F86F;
 Thu, 30 Jul 2026 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785481184; bh=OAzUPG308bSFiJus+9fUvVqFx60KXPL0dOljxnhzkyQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QC02GEhfCiI0em67YgTLHRPfaCb/dfs+G3WtGfvhepMbRXWH055GKUXJXt6pMlijz
 hT9rJRKzYW9aKfsLaUp7wjeWgB7ykVkZ7QlwPmt8SYdkcC4HSzMtMhiD9uqxfhjbvP
 vXMSQz6l2emXPCT4oaiM9BcgLtdshUgS/uOEQARE=
Date: Fri, 31 Jul 2026 12:29:40 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 David Hildenbrand <david@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, 
 Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 ziy@nvidia.com, 
 pfalcato@suse.de, agordeev@linux.ibm.com, ryan.roberts@arm.com, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 kasan-dev@googlegroups.com, 
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table storage
Message-ID: <dzpt4ays25vvoyt56oy4iatfbqwp7z4gdsxumirv3v2nbvhoy4@73upph7f2hbk>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-2-usama.anjum@arm.com>
 <6xah74eadjmo2bozyr62wcxo4hhpsiufx2mshh7tztyy2dzzps@63m327m7pl5u>
 <41414c5b-e98a-4a55-ac87-ca982b248ca3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41414c5b-e98a-4a55-ac87-ca982b248ca3@suse.com>
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

On Fri, Jul 31, 2026 at 08:53:46AM +0200, Jürgen Groß wrote:
> On 31.07.26 07:49, Anshuman Khandual wrote:
> > On Mon, Jul 27, 2026 at 05:46:52PM +0100, Muhammad Usama Anjum wrote:
> > > pte_t is used both for logical PTE values and for entries stored in a PTE
> > > table, so pte_t * does not distinguish a pointer to a copied value from a
> > > pointer to table storage.
> > 
> > Should we rather call them as "Linux PTE" and "HW PTE" instead ?
> 
> What about "SW PTE"?

Both Linux PTE or SW PTE would be better than current Logical PTE description.


