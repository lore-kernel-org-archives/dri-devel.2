Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EE7C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214C210E21B;
	Fri, 31 Jul 2026 13:28:18 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com
 [216.40.44.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB3010E21B
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:28:16 +0000 (UTC)
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
 by unirelay05.hostedemail.com (Postfix) with ESMTP id EF5564042A;
 Fri, 31 Jul 2026 13:28:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by
 omf12.hostedemail.com (Postfix) with ESMTPA id E384117; 
 Fri, 31 Jul 2026 13:27:45 +0000 (UTC)
Date: Fri, 31 Jul 2026 09:28:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, =?UTF-8?B?SsO8cmdlbiBH?=
 =?UTF-8?B?cm/Dnw==?= <jgross@suse.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, David Hildenbrand <david@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Chris Li <chrisl@kernel.org>, Kairui
 Song <kasong@tencent.com>, Uladzislau Rezki <urezki@gmail.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, SJ
 Park <sj@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Mike Rapoport <rppt@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, ziy@nvidia.com, pfalcato@suse.de,
 agordeev@linux.ibm.com, ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table storage
Message-ID: <20260731092825.36992dc9@gandalf.local.home>
In-Reply-To: <9ac33752-b587-4901-b5f2-473e573d7ede@arm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-2-usama.anjum@arm.com>
 <6xah74eadjmo2bozyr62wcxo4hhpsiufx2mshh7tztyy2dzzps@63m327m7pl5u>
 <9ac33752-b587-4901-b5f2-473e573d7ede@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bk4wphtnyr8oskxq6ok6poi7ogrp6zg4
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E384117
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188VTzKisaRifdK5JzAhtUj+tNTYkibFXo=
X-HE-Tag: 1785504465-704596
X-HE-Meta: U2FsdGVkX1+okbaURBZ2Qkn+l9IgiK40Gqe8ZThpseNdxUoxO6+yJtshZ3puroffdGsnNQX9lyVqqMfMDNqtsaiMVrZRSqd7CxcOf+tlTFcxBWBx10qhJ57MkLj8ndzBOYoA/OODEfAwWEkK0Ynym/vN8RHly0+jRGqqJSDy6cHg7VOGub/UmsJX6TfoBSOwr0+39CvO+c3eZRPTPuO9wuZjY0AitKZFKa26poYwhlLhVPb0FYC1FMbtcEIPwcv0BUAY4FqESIdzLvKNozpw1fVotcfhrX1NJojLWeahTii05xgjJv7utljWLfUJzJrqYVN7s4pCcDgRjK7TriyixEP+/JmhkJIq3qIe3n8mNyiV8HHld6EP1z7IlvkGJKR3
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

On Fri, 31 Jul 2026 11:19:32 +0100
Muhammad Usama Anjum <usama.anjum@arm.com> wrote:

> On 31/07/2026 6:49 am, Anshuman Khandual wrote:
> > On Mon, Jul 27, 2026 at 05:46:52PM +0100, Muhammad Usama Anjum wrote:  
> >> pte_t is used both for logical PTE values and for entries stored in a PTE
> >> table, so pte_t * does not distinguish a pointer to a copied value from a
> >> pointer to table storage.  
> > 
> > Should we rather call them as "Linux PTE" and "HW PTE" instead ?
> > 
> > Some like "Logical PTE" does not really sound very clear on what it represents.  
> Yeah, I should make distinction more visible in the cover letter.

Just as an outside observer, so take this with a grain of salt and feel
free to totally ignore it, the term "Logical" and "Physical" to me would be
that the Logical one is created by software and is not mapped to hardware,
whereas the "Physical" one would be backed by hardware.

Just using the terminology from LVM where there are Logical volumes and
Physical volumes.

But if that doesn't represent what you are trying to accomplish here, then
it is indeed not the appropriate terminology.

Again, feel free to ignore this comment, but I just wanted to give an
outside perspective of the terminology that I see.

Cheers,

-- Steve
