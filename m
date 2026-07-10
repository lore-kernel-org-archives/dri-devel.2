Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722F7C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9A810E83C;
	Mon, 13 Jul 2026 07:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="ZO8Xl9K2";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85BF010E1FB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:12:14 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-92e99ef0902so73766485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783717933; x=1784322733; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pf2tO4nh1364RXnPDWacirAQrZ5x9Oo1qInEIWqsetg=;
 b=ZO8Xl9K28t4WkfQWPfLOK1FSN5NOOVxX4gJMXGZNy431OpKB9jOCDf56REoU1f+ppy
 PtGt9g146EUuInWPyHJ3Cibh/daT7fksxZCCX8mdQXMshQfuThpguVBDj73D/KTW3GDx
 RSndWle+lirrSVoVRnIBd6NV8spEmdnrPHspvPQx3HYo5rvQgNq+HzJwIpVO/FZBHwZK
 wDHbZeLi8Qe3PpAAFOQ4Nw0ygDSJE5yKSArcrxYsYIQSXuXhOhJPIa6oehUalkYn/n3B
 yIObp4KD3snDv1x3h2lTW6GULOHoVqxQmo3ezPZoVUC3Z6xp0BWBmBL0Nn9iHSHReVj0
 FYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717933; x=1784322733;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pf2tO4nh1364RXnPDWacirAQrZ5x9Oo1qInEIWqsetg=;
 b=XZiAo0wPrcNXy7P55BFlWncXmcEch6tgyMLIg1/x+8Ar+5S3T2pfFezIMV8OBpO/Ee
 uXtRLv7ZJoA6VeTQzXaGC2CBjbn5/bAvHSWBmaySglZtk0mqknRPWw/q8r3z7xfp3wHN
 1Qdn4uWsiTGr2R2OOtlQXB5YZFzYoExoiAGQYpEPvZmDHZSnw5oyCsOqW0eoDMytczkD
 DIU9MOjn4qe7bM/P2QYDjicsuCJeJkhT8e9velW7js7Mt9vR1th7Zk0tO2KW9U6A/rf2
 VcO00/YX6D+90lrn9z+1hOWQOFaXDo31EgsXdKO/rEDTHqqUO57m7sZCLMX4QNLCmhke
 61Xg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6pHYMLAEAltKslQlDtbQeTnnMJ++Z8nB6jEVFsa/7C9094HE93ChKymNd54U3z6/0wZPE6tYny0M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOX37M3c7AWMn+VkOvmiAUxBIsc7AuenX2BBpKdir5PNlRQi+U
 QEJSLeDtaJO5LMslrTjSYf6Et1Y1llH/1IiH9fwBOfLfEH4QKBrnrkXqUl30Dt9irkM=
X-Gm-Gg: AfdE7ckuLNEEDp2ikKpgqrFYtdtDvmcEYsTIFmvMgbTAWE1/cgeC9sysUupCEi+M8PG
 5aWsL5V4zdPANxbkKjx8J1ShbZ9iiP/ceNYLZCrvqDzeTzA4iSEnh1g6bp9oyNNzyOsXhK6iTdG
 AHdIflevx4aq5DWi+HaDN67Qvm9Qupd4rSyj/YODn953bq2bG6RSh/kk6HqbYqFCWJUN0HG4U1G
 L2wvRZ3LPm4k1Cy9OpntidAb1wXuk2+GlU8MeWy4BqHKI2m+6/hw1psBe+kViP04YHozJ5wdS1/
 oijWO8zm+3L1ETdu9pXS6OE/mpF67Olqfg78la48MaJ0YUWrDM63Xq2wJLgHMbT+2EhLD5202Y7
 T6+VvsTHvbVqYuC2Y8nYUtZJlkoGR6oy+WTqfDTRwLTwmuGw+9oGweA+fcyYfEm/WOa75dmAPTE
 PAZ036fu3a0L49j93CXd2+o30Dl7VgdtjT+z6Ue48vexC0g5CAR69iL6pJTF16ECgwJExp
X-Received: by 2002:a05:620a:1a24:b0:92e:7c7e:9c9a with SMTP id
 af79cd13be357-92ef2b32433mr108915185a.31.1783717933240; 
 Fri, 10 Jul 2026 14:12:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5cfcb0dsm290194785a.25.2026.07.10.14.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:12:12 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:12:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Byungchul Park <byungchul@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
 Kees Cook <kees@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 09/33] mm/rmap: parameterise
 anon_vma_interval_tree_*() by anon_vma
Message-ID: <alFgFakGEcg6hO6E@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-9-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-9-2a5aa403d977@kernel.org>
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Fri, Jul 10, 2026 at 09:16:50PM +0100, Lorenzo Stoakes wrote:
> Similar to what we did with mapping_rmap_tree*(), let's declare
> anon_vma_interval_tree*() in terms of anon_vma rather than rb_root_cached.
> 
> In each case the rb tree referenced is &anon_vma->rb_root, so just pass
> anon_vma and the functions can figure this out themselves.
> 
> Also update the VMA userland tests to reflect the change.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

