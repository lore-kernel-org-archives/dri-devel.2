Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C3C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC6510E81E;
	Mon, 13 Jul 2026 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="Goi84xSa";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E6910E1C6
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:08:37 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-51a868b6962so12209121cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783717716; x=1784322516; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TOF1lWlhGf+OJbHw+J+MIMmbUwopKgG0YAX8LO7BKt0=;
 b=Goi84xSakmmaMWRvdfWkk+0k0gQqoQi3WHd+l0GsMg1EJPzMn72xwiITsXJqUOpzST
 kVMWXnbCHHIR6A0I9Faa9YSN5/AEQbq/xs49uIWtNayCvz6bStkdlrF6uccJ/j5iY8g1
 dZbrTiE4MlmrAGv1Q0neEIIRsEl3e/zL7j3Sb26n0ZVdg+I7cMiDyrXKxvHKbOtt9+mt
 CzEhxWnf03WNn/Lv3Ae4AknwRNbJPDeznVyaOT0iaHz/ywhTwrx9qwOfPSwez/UaCNL/
 Wojn/i6kxKjHEYSWrQZKPWCl3bXYsq4DsCMcVCWh6+6obw98dZNIHXBJ8c9Xr+aWxbQh
 LxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717716; x=1784322516;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TOF1lWlhGf+OJbHw+J+MIMmbUwopKgG0YAX8LO7BKt0=;
 b=WbXRKL5w9RmttuiV+5YwYv/C2cDiCTjlcdJewuxA0A3sjye/dVQxOtF+flUygjargn
 7b4QYfzqzuQZIrEcRythpASd/qTSmVFLE4Uat0Uo44JK85Bs0uKuPN8F43OxZ6t/7U5M
 5VpVhxOcxBpkmzuoLMCov1SDy7gS+jmF5BXwUj8FAZJWtV96gQ2tOgewEcW+DIMdy5CH
 QsPVege+P45Kwel9hmuOl+yWFAjRLvBVtT9VU3r7uDNneFbN/MQQsaTc87CtCC1PfPC1
 xShULe22YtIfjjkAwgkIyNC9xEpc923nzJBsvcfrNYmv2Q6YccAEY3eKNqEfGB5uo/Ce
 lO5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoR16O+0213BICdMKO8OXItZjn2HXW/NUa7UmrOC9DIkgwHhLCz8ocwIwTxVm0oIO3ZBTx4NIqsD6k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvAfUpy2SdBuUZmKUKP9d7w1/WSzyWEG7VJTW2yKrQ0L1pfKjj
 dXppAYU/7I0z39Wa62rAaBI6J6NqQgzGU3/JnwDfehnsZG55wqjysY+JDsh0LLuqzbU=
X-Gm-Gg: AfdE7cmJLTahCzQYBEfbsmO5ZQCmSW0zTwqSAxzlk3aK7fQ1gXD1kE4FKE0oCPAxmFk
 kgr1/7pkFCHYHch2U8nO64Xsx8rAb1YHli/87ItnyAKRxXOGRd4r4n7vJDCLSh3QVa/0L7ImrPm
 J8hm77Tt2lxvTORuntZO5XqrYB778gQJpo5aHOBeZ9f4N3vRRqDCaX9D5wdKyIiaXEgySI4M8En
 yp0IX5HS72oYyWXltWjcF7ZCmAhfXWr/XLt8PAoyC4bLUTAP1HAsfbJwL4TFwZ5AkUcYOKI/UOr
 T53zEGzUc0mc+q16R/RM5FLNumTiJJas53NHCXvEwaJtp/NZkb5HGcd5u5C9pPie4TtGXbLsJqe
 vievKDXsJk8eu6SA0XkbAc+ZiRfZFau662u2Wq4udOUoMNtLMsHY/Quuc9DsEpapzcjL8LfTraG
 x6ZgYG2KEbZtBCuFfO4UvURGP8PP4zAS8mDyPRX2GYqGvYCA+aJjLNizZiNTBZed6dadxg
X-Received: by 2002:a05:622a:2c2:b0:51b:feae:3576 with SMTP id
 d75a77b69052e-51cbf14a68fmr7022661cf.26.1783717716605; 
 Fri, 10 Jul 2026 14:08:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caacad30asm23910591cf.9.2026.07.10.14.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:08:35 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:08:30 -0400
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
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 32/33] tools/testing/vma: default VMA, mm flag bits to
 64-bit
Message-ID: <alFewd7j_uiNP1Vw@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-32-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-32-2a5aa403d977@kernel.org>
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

On Fri, Jul 10, 2026 at 09:17:13PM +0100, Lorenzo Stoakes wrote:
> With all of the sanitisers turned on, setting the VMA and mm flag bits
> depth to 128 by default results in overly long build times.
> 
> Reduce this to 64 - we can always manipulate these later for testing of
> larger bitmaps as needed.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

I've never had a "too main recipients" error with my email client
before.  Bravo.

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  tools/testing/vma/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> index e72b45dedda5..ef6cc558afe1 100644
> --- a/tools/testing/vma/Makefile
> +++ b/tools/testing/vma/Makefile
> @@ -10,7 +10,7 @@ OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
>  TARGETS = vma
>  
>  # These can be varied to test different sizes.
> -CFLAGS += -DNUM_VMA_FLAG_BITS=128 -DNUM_MM_FLAG_BITS=128
> +CFLAGS += -DNUM_VMA_FLAG_BITS=64 -DNUM_MM_FLAG_BITS=64
>  
>  main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h include/custom.h include/dup.h include/stubs.h
>  
> 
> -- 
> 2.55.0
> 
