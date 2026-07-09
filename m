Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4C2C44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2961E10F7B7;
	Fri, 10 Jul 2026 07:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="KTmDNI5p";
	dkim-atps=neutral
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9AE10E6B7
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:50:48 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-51bfbe05683so13019271cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783612247; x=1784217047; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4H58DRU6wxIzBQ0PfS3OOFxFy6X9tDniNwjExlFI+ak=;
 b=KTmDNI5pkxDItmaa5c+IAdAYJTZZozTzGCk7axMtROa9cemzzhHcJrWWF2vK2aArnO
 jybpJ0OyM8gv5IRKIMUkOWjzUd+E8XzWysayZUnXGDC26lVmORnVSDrgZJp9vVOuk00y
 TReANSYX3cWp+CZC22SfpTaYc18Nz/LV52JTQ9nPvMx8oD6hdbjanqOo5KBTDxgHEZqp
 wEb1h8JATBApFzzXNrlNEsUp54AqtbTwMcgSdZxje1CFw44EJticHzcDhfG7LjpTm9UM
 O9e+6D0mvRgqVPmuB47cqtrbmGMztxlGh4popVIoHn2e9HPMfCtwUcEt6VRC7kXBSfZX
 yueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783612247; x=1784217047;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4H58DRU6wxIzBQ0PfS3OOFxFy6X9tDniNwjExlFI+ak=;
 b=nSFdkqVP8RZvbghHrVsv6s1TJVRibLlMy3RJXmZ+0bgFKUA0zMixfj8s0zpQRgzkcn
 l/rvqdZYZoia93galCa+cpuIoxOD3GvDIaBrAfoVy5H6rzZRPnvEhW6CrwUAoF9GF/Oj
 HtFOle3Kn7NchUvzhTTJbm9CW7oYKxr0K88eVl6TQdPrq3dcZNcfEKcH7ItE+P2c+mje
 M/Hl3iGgj9LTwRRHz5oKY6vr4HGM0K0mGMzqOvTN5XfNPx2OpXcVs2XoU4kPn3avMNm6
 1bHAPP6U6Yc/iO0iPBcEl1eNdlZAvnU19l1QqS5rnITsvJO6Ejdf/S2npe+FtDJiE6ii
 EY+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGrowUTDoHfwsJaV00CSKjFofpVxBpOMbfDGkZrd0+matRO/CdBmbJZm1WQRnS/gY8z8GbiQS49mc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiQt9knsU8+fyO+WK5OzO63+wOHB69zK/5fVCJ7Kg3MmW5wPgJ
 ovNla6Sz42WpAd9l9g84gkazDbBphSuQK2IEynqbuJyAiHjj7ZayQi6GW5xAAsA0Ktw=
X-Gm-Gg: AfdE7clq8NBLRMpGhOZa4y5po5WoeBomQdY3K+JRnUrCG7xjLRvoMIWhGvybFJrsGUy
 L3tcccWyx9jc8Fyo3C1gp+91R/SSQg+8mNStuy1fJWH9Ctsh4yXfNWTESmzL6e0khpw+xsDnKwL
 absDP9Kzme9+zhD5/KhGm41F4gNLEDsN5jRmVkGsDGmoocgugtIAeTCBqqHZCGm9W1msR3WTQgr
 teLsh4CtsuVwYJ0uUF8f4QSpqJ1YNeqZJGXUp01Hy+6k2GeyyQDzIuRImDwjS5YHnxz0r74uY1H
 YWyraOJh5w3EIfkDS9ZGc87ve4RGorWRRGc7749Ex82Ew+jAZjFbz7Zy/qf9zs1kewhWfSYPhY5
 FsHr55MRUOCtVMckBFpyXt5Y4zHjSLz7pQnEMuwUNxu2J9af0eCUEcFL/nRB7YIclKqbRlsGC23
 u5TNXK0MYVkG39Eux7V4qX60/Jh6R6AWQa+it5sGJPMkClJ5KmaQSPoPrJZlfS7t1JyRVK
X-Received: by 2002:ac8:5f0a:0:b0:51a:8c9c:7f52 with SMTP id
 d75a77b69052e-51c8b40a675mr79940341cf.69.1783612246884; 
 Thu, 09 Jul 2026 08:50:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c4202366csm161049781cf.30.2026.07.09.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:50:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:50:40 -0400
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
Subject: Re: [PATCH 18/30] mm/vma: remove duplicative vma_pgoff_offset() helper
Message-ID: <ak_DUDt-1tb-V3b2@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <10671c2fc5d0dd4e3bf497181923e63e46053df1.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10671c2fc5d0dd4e3bf497181923e63e46053df1.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:29PM +0100, Lorenzo Stoakes wrote:
> This is doing what linear_page_index() does, so eliminate it and replace it
> with linear_page_index().
> 
> Update the VMA userland tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

