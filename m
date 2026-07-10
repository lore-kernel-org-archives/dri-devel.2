Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19FFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A4110E7C0;
	Mon, 13 Jul 2026 07:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="eGy6i2tG";
	dkim-atps=neutral
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B6210E21D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 18:59:22 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-51bfbe05683so7570171cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783709962; x=1784314762; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=74B4rm3uR5k1lRSPUh5wFwkcdLxEy4GniWsMlOdHPw0=;
 b=eGy6i2tGXQuVmjLLv6CHTSXtof9bNVgtij1xPHQNabZnWRFqiFAJ2lX9hUfrk/tNo2
 ZDMnHBUMDRlHeeQArW059DLD4+kZ9GY7hABrs6q0n0C7W9YkSSUBDVpqagLo8hgWLdJN
 WpTm2xU8/hIjhGhhIHUzIghMY5/CLrTLlUo8pDdTvAKqFQlPkK57iATkHv0TcoFm4wk3
 ot5FrimV4MO3cDjJiB5I8OnWiTUjlbBARgi9KiDlLMhMG6mIEOVYIJAbFAiRQTvNu172
 L7HPgdJxaU2d6XmRKE1fAqtI45ynBtjiwhJkIDzi9LFeXXAX+07y4MyTRi6FZmx/tBku
 kBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709962; x=1784314762;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=74B4rm3uR5k1lRSPUh5wFwkcdLxEy4GniWsMlOdHPw0=;
 b=ghuJaZMjOcqWNS3k2kdmuQzi6e/OlGaQK0xoSOYmO+rMnaAvTWAoTeKSU+Zm7tgqhd
 TK9RcjdcUou+vvCVPaHr8M2188EhPfgw9iEYnLHdc67RPo4kPid7q5lfunFGgzdFDmBT
 fYDjneMYXtISpyxI7+neR9mn4D/OqCIItNcBL0gBnmTD89zIJsHLwP0YP73Q860UyOJ8
 PAUNWQcG5seGQuT/r9QfFeyv/uVb7yRlyMBkBaGAKAVlt+fOdJbscNb8/krZe0D/YjVS
 McbDz0hH3eMu6lmHjgborCaweJYeVjD8QsVT5Zm58ityvx8XhsF/uCuWe67r7DFr1qw9
 wPlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RremwkNgvo25G+JQOSGL5uPVsDriQKeVpoRLDD1STKAQFypVkg9Re4iixO3d/V6vBL+WLln4w6QbHY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjwOCAXWNd3Jg0tsraOK2g1UB+WKXw4U9Lw14x1aK6srlDtbOZ
 FeFk9Sdfd92x9oOPtXNAZiX+3pLOqx7R5h3Yjrs7vPJWbgTaOTNVZA+fbpqUoGHoyY0=
X-Gm-Gg: AfdE7cnI/ROUicorsC4KEyFwj0I6zOsE7XwJNsxp/fqI1zveZKMvcJnMjpsF+B9LuiE
 bTniTe7w4V5VLRV4YokhONRk0dBW6FrslUruD88VX9Ve1FUx/j3pngJTVcsba+reHXJ3C2DorGA
 zvWC5TIQLXg5lR/3Kh7JIdjKbntnITHcN0VN24AR6rwa6stkSgiOzhhXmURmTNQS/XzvZp4HEyM
 5MllBHDJsxE79+bJ15NL/NcWDdJW8X0/1Vz/ru/fNjtaWozvmIX6VG3w+QT+eDFviU5H4OZvu/P
 ZBtALYlt790P/jimejasNyBd6Igv/bdmM2qkDH4Ykz3sjgHGM68C7gY4n9NY/Tt8BLsRQ7O1C90
 LZ6Cnd5LKcbosKrg9RDAvS9i85ISTfPHphkwRUp4ygOOZ9g/UwSH4NG/TC3OC9jalHodiy2mTj2
 IRZ3lZrpUFC5SKYbOTaQzc+TJgBlDtXrnHlUUo5cCVbfJi8K+R6NTqjsZr38T3HqIk5T7j
X-Received: by 2002:a05:622a:1b17:b0:51c:2101:ef with SMTP id
 d75a77b69052e-51cbf156814mr1787851cf.19.1783709961653; 
 Fri, 10 Jul 2026 11:59:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51cb884e0cfsm12321961cf.29.2026.07.10.11.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:21 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:59:16 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
 Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH 24/30] mm/vma: update vma_shrink() to not pass
 unnecessary pgoff parameter
Message-ID: <alFBBGN6a30A3bQ9@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <6dd744d57d778f94d2fef8fd623d7c4ed8010d93.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd744d57d778f94d2fef8fd623d7c4ed8010d93.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:35PM +0100, Lorenzo Stoakes wrote:
> vma_shrink() does not need to adjust vma->vm_pgoff, we were passing this
> parameter solely to satisfy vma_set_range()'s requirement for pgoff being
> specified.
> 
> Since vma_set_range() is now isolated to vma.c, we can simply introduce
> __vma_set_range() which sets only vma->vm_[start, end], and invoke this
> instead, removing pgoff from vma_shrink() altogether.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

