Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EDDC44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E4410F204;
	Thu, 16 Jul 2026 08:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="G9Ads1/5";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4755510F152;
 Wed, 15 Jul 2026 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=u1xTcKNYwdOUdwgNpbyIzAcPowaOLgUaHPOaAeLqzfg=; b=G9Ads1/50L6jZQcaHXYJq/Psc7
 AryEJZcuGxV76jnQvR75aByyQN2+s4KISlfDdk2TV92ezj8Mb4OV3LQF0ZVYbq4Bwq7lXV48A3koM
 4dW7xh0EelhZHZsLKX5Terjo3G/wY4H4bI5wxUs6ArdrtWB1DCY3d3mbi6Xxwegu+cmC0ufKyHXMu
 AqLncMI+gSugHyCRPWyTnaJ8K+c0jt3rkv99sJlwJf7PJ+dQ563sPdXLBXOHRlyBfZi2YB6bdEe6v
 /P14vLsGTAZrR7gY0vy5J00O3llg1vnu5Lm0yJTpk8XtVFADXa9x0/iPQC2akptOn3wrnWTNwWmxS
 CaBTrBPw==;
Received: from [38.23.173.23] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wk5fh-0000000FpH0-1NIX; Wed, 15 Jul 2026 19:53:33 +0000
Date: Wed, 15 Jul 2026 15:53:23 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
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
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>,
 Peter Xu <peterx@redhat.com>, 
 Kees Cook <kees@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, 
 kasan-dev@googlegroups.com, linux-sgx@vger.kernel.org,
 etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, kvm@vger.kernel.org, 
 Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 03/33] tools/testing/vma: use vma_start_pgoff() in
 merge tests
Message-ID: <p6bhkbzvrdz6bb4a6cdmd6bmlwuwxfjd3lx5opq334o7nwjhwa@ctqdd3i2daon>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-3-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-3-2a5aa403d977@kernel.org>
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:21 +0000
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

On 26/07/10 09:16PM, Lorenzo Stoakes wrote:
> Now we have the vma_start_pgoff() helper, update the merge tests to make
> use of it for consistency.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  tools/testing/vma/tests/merge.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/vma/tests/merge.c b/tools/testing/vma/tests/merge.c
> index 03b6f9820e0a..f8666a755749 100644
> --- a/tools/testing/vma/tests/merge.c
> +++ b/tools/testing/vma/tests/merge.c
> @@ -118,7 +118,7 @@ static bool test_simple_merge(void)
>  
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x3000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  	ASSERT_FLAGS_SAME_MASK(&vma->flags, vma_flags);
>  
>  	detach_free_vma(vma);
> @@ -150,7 +150,7 @@ static bool test_simple_modify(void)
>  
>  	ASSERT_EQ(vma->vm_start, 0x1000);
>  	ASSERT_EQ(vma->vm_end, 0x2000);
> -	ASSERT_EQ(vma->vm_pgoff, 1);
> +	ASSERT_EQ(vma_start_pgoff(vma), 1);
>  
>  	/*
>  	 * Now walk through the three split VMAs and make sure they are as
> @@ -162,7 +162,7 @@ static bool test_simple_modify(void)
>  
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x1000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  
>  	detach_free_vma(vma);
>  	vma_iter_clear(&vmi);
> @@ -171,7 +171,7 @@ static bool test_simple_modify(void)
>  
>  	ASSERT_EQ(vma->vm_start, 0x1000);
>  	ASSERT_EQ(vma->vm_end, 0x2000);
> -	ASSERT_EQ(vma->vm_pgoff, 1);
> +	ASSERT_EQ(vma_start_pgoff(vma), 1);
>  
>  	detach_free_vma(vma);
>  	vma_iter_clear(&vmi);
> @@ -180,7 +180,7 @@ static bool test_simple_modify(void)
>  
>  	ASSERT_EQ(vma->vm_start, 0x2000);
>  	ASSERT_EQ(vma->vm_end, 0x3000);
> -	ASSERT_EQ(vma->vm_pgoff, 2);
> +	ASSERT_EQ(vma_start_pgoff(vma), 2);
>  
>  	detach_free_vma(vma);
>  	mtree_destroy(&mm.mm_mt);
> @@ -209,7 +209,7 @@ static bool test_simple_expand(void)
>  
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x3000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  
>  	detach_free_vma(vma);
>  	mtree_destroy(&mm.mm_mt);
> @@ -231,7 +231,7 @@ static bool test_simple_shrink(void)
>  
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x1000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  
>  	detach_free_vma(vma);
>  	mtree_destroy(&mm.mm_mt);
> @@ -324,7 +324,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
>  	ASSERT_TRUE(merged);
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x4000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 3);
> @@ -343,7 +343,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
>  	ASSERT_TRUE(merged);
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x5000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 3);
> @@ -364,7 +364,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
>  	ASSERT_TRUE(merged);
>  	ASSERT_EQ(vma->vm_start, 0x6000);
>  	ASSERT_EQ(vma->vm_end, 0x9000);
> -	ASSERT_EQ(vma->vm_pgoff, 6);
> +	ASSERT_EQ(vma_start_pgoff(vma), 6);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 3);
> @@ -384,7 +384,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
>  	ASSERT_TRUE(merged);
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x9000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 2);
> @@ -404,7 +404,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
>  	ASSERT_TRUE(merged);
>  	ASSERT_EQ(vma->vm_start, 0xa000);
>  	ASSERT_EQ(vma->vm_end, 0xc000);
> -	ASSERT_EQ(vma->vm_pgoff, 0xa);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0xa);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 2);
> @@ -423,7 +423,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
>  	ASSERT_TRUE(merged);
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0xc000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 1);
> @@ -443,7 +443,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
>  		ASSERT_NE(vma, NULL);
>  		ASSERT_EQ(vma->vm_start, 0);
>  		ASSERT_EQ(vma->vm_end, 0xc000);
> -		ASSERT_EQ(vma->vm_pgoff, 0);
> +		ASSERT_EQ(vma_start_pgoff(vma), 0);
>  		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  
>  		detach_free_vma(vma);
> @@ -805,7 +805,7 @@ static bool test_vma_merge_new_with_close(void)
>  	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x5000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  	ASSERT_EQ(vma->vm_ops, &vm_ops);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 2);
> @@ -865,7 +865,7 @@ static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bo
>  	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
>  	ASSERT_EQ(vma->vm_start, 0x2000);
>  	ASSERT_EQ(vma->vm_end, 0x3000);
> -	ASSERT_EQ(vma->vm_pgoff, 2);
> +	ASSERT_EQ(vma_start_pgoff(vma), 2);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_TRUE(vma_write_started(vma_next));
>  	ASSERT_EQ(mm.map_count, 2);
> @@ -931,7 +931,7 @@ static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bo
>  	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
>  	ASSERT_EQ(vma->vm_start, 0x6000);
>  	ASSERT_EQ(vma->vm_end, 0x7000);
> -	ASSERT_EQ(vma->vm_pgoff, 6);
> +	ASSERT_EQ(vma_start_pgoff(vma), 6);
>  	ASSERT_TRUE(vma_write_started(vma_prev));
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 2);
> @@ -1416,7 +1416,7 @@ static bool test_merge_extend(void)
>  	ASSERT_EQ(vma_merge_extend(&vmi, vma, 0x2000), vma);
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x4000);
> -	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma_start_pgoff(vma), 0);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(mm.map_count, 1);
>  
> @@ -1456,7 +1456,7 @@ static bool test_expand_only_mode(void)
>  	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
>  	ASSERT_EQ(vma->vm_start, 0x3000);
>  	ASSERT_EQ(vma->vm_end, 0x9000);
> -	ASSERT_EQ(vma->vm_pgoff, 3);
> +	ASSERT_EQ(vma_start_pgoff(vma), 3);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(vma_iter_addr(&vmi), 0x3000);
>  	vma_assert_attached(vma);
> 
> -- 
> 2.55.0
> 
