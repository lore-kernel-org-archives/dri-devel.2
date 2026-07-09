Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96A0C44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF64D10F7B1;
	Fri, 10 Jul 2026 07:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="CZibdNbK";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D836110F629
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:56:00 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-51c1805b8a7so20092991cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783612560; x=1784217360; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QupnWz0oLATZw6wM2bylQaqDWCRhZF5lJVU8oFwJF/g=;
 b=CZibdNbKVl+B0N1tXFXJv4MIeg/eUW9EAI9YxLKLB4nJgaIixS0P/cxPjEOB6aZSWY
 v7Ixj2I798Z01ASD8LPnyFks/2H1PqlWJrorSOebE2zTFiK5oLVY3PY7aoouptBXX7zR
 dnjrtjFEGanUbiyTBsYa4BxbKxGNVO1egrrKIvLhSCwRKKO5chVs42sMOAkH06zDVRrk
 MTUDbmlgxorTFE5l7qMY+IdPQ29mSjgb2+SEiQby0FGWY4Ln7/mx0rXwYHyzNC8aYF6T
 UE/T41hffTA+59uQs56AzV6mioS5+0MeTywY/WP4tcvzD78lXYe0P0MI0zq6Qdme82+u
 9R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783612560; x=1784217360;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QupnWz0oLATZw6wM2bylQaqDWCRhZF5lJVU8oFwJF/g=;
 b=B+nEcYTDHUM6fxQNkIMl+02hIMOSx+XS//BYwc8ZZcaSdamDk6MiF10607640SSqju
 Ca7wQYa9wPviGr3XCbt+Y6se6TXlm/BE+JAkwCSQkPqEdncvXbTZOyUAgljmzaKaxIxG
 8t4LmkoBD/wMKkTFneoVfu/qjJhmPQCIO9TdqVSqJaC1jEu8w3wku5iPckWiVIAx2ch9
 9z2CVv73b/ZO/sDA1R7rkhT1WIpA7SREmjVF0ipL1yl4Zduja/BzIlnH8Y3CXENh04pE
 iGXC3OGbdIaKlH8JSZBXfZClYICfToTkC4NK0rBmMJw6jSZ8CAMT4LKssoDtxaR0tEx9
 GSkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRz4ap8Q+m2WRt0Hp5PrhKzMXGBr/m/cpPnob2uWhjpLU1esDGTd9+IWFkWAQSdwzqP7yrLTyrcBI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxo+Bqjh7oSjcpZka5HRFcAS7cYGz3QRom+EmhzHnNz930TJ65k
 U1dT63IBEWsQV4+cYanveiMuxofR0vzKc5165mkWe8lITrjfSwxkPPHHOgZTrPTL+rY=
X-Gm-Gg: AfdE7cmx7mSXT6037n+SU6JQ8RIeHCfI5PBTwIHxD7tvRCq5QyFPTu9M8Fj20buvPSn
 E/D+TZKFGDxXiLJWUDTfVM1MiU2A+qJFCIM44lxPw8rY4ugm5zHAQwFNnHxZ6yz9Odc5P/CPWKw
 7FUUH/uTgMe7TSdzbC40EcecX34ft5U6HqDqsovA9ULVJ//oup5q28CMbPBWrpIM2mwyadlOPtO
 DEMOR3o5kZPDyRg2v+Touy2uBOl1hbWr6CXTj1C2hrQj/wKd0ZfS9QepF9sg19m2B+gtSxXPimN
 nD/UGRxWonE2BAYxNUyOv7z5FPUu3QCVIx9r+ZyY7NCa/PDM8Q9UyNrMbBmlw0D1unokWF1PmgL
 glvBvRjM8t1aw1s6h/YS9dAZhpK9B15cdmr9RoHJWvJjJi5P+8mm4oJgdJ9w+fJ/hhY3wW0M5xN
 5hY3MouDr4p6E6B1wmVwCMvVoMu5YP7Fneqo0arBFH9bZqMeqXVGyAqLdoKElbA/SZPSwR
X-Received: by 2002:a05:622a:311:b0:51c:185b:29e0 with SMTP id
 d75a77b69052e-51c8b2ae67bmr82998651cf.10.1783612559586; 
 Thu, 09 Jul 2026 08:55:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm169684691cf.17.2026.07.09.08.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:55:59 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:55:54 -0400
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
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
Message-ID: <ak_EivwcDDdn1Xvp@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:06:09 +0000
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

On Mon, Jun 29, 2026 at 01:23:30PM +0100, Lorenzo Stoakes wrote:
> There are a number of places where we open code what linear_page_index()
> and linear_page_delta() calculate.
> 
> Replace this code with the appropriate functions for consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

one nit

Reviewed-by: Gregory Price <gourry@gourry.net>

...
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index c09bbe04be6c..536c25d8dcee 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -25,6 +25,7 @@
>  #include <linux/fs.h>
>  #include <linux/comedi/comedidev.h>
>  #include <linux/cdev.h>
> +#include <linux/pagemap.h>
>  
>  #include <linux/io.h>
>  #include <linux/uaccess.h>
> @@ -2462,7 +2463,7 @@ static int comedi_vm_access(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	struct comedi_buf_map *bm = vma->vm_private_data;
>  	unsigned long offset =
> -	    addr - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
> +	    addr - vma->vm_start + (vma_start_pgoff(vma) << PAGE_SHIFT);
>  

Obviously correct, but was this intended for a different patch?

~Gregory
