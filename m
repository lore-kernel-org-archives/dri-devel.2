Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8191C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705CA10E7CE;
	Mon, 13 Jul 2026 07:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="TY+HyRD4";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763F110E221
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:20:50 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-92e5c92c389so65821685a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783711249; x=1784316049; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xFW+QIJ4JFkYmnZudtxzUHG1gsom4gRJfGrSXFnz7n8=;
 b=TY+HyRD48lqEUvHl6p1DwjQPs/0dfYX6Au/RqNxKjr/aUkc12Aausna7ipf+ZQ+O1Z
 dN5oaPomTamDEmRlK4jeyb0GdUjX8uO0npdtwu14kaGrdyphFL8tQrbycXy8NPdzqbVI
 jS2XddpXL6842sCzHqONZN4lyc7wxqy+/Zc19/TPWbFIo8eiGM/ByVVCR8OFsPWQUbgc
 qk1mStwJfrre060xlxjjSg4tIqXFUXa8Cx1+44AkaSAN83YEpeONvi0nkFgElxkefElD
 kuFIt1um1KiRn3wmtjyXdCAfokHt/0FRi5kWzBLaLnM4fy11OZMZURRkOAKI7LnHsJlD
 YspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783711249; x=1784316049;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xFW+QIJ4JFkYmnZudtxzUHG1gsom4gRJfGrSXFnz7n8=;
 b=O/Lda3Qbo2L45qTriZIIbZyL2M1uG4ZBPBo1gAXEwk/6YXuRbqcP/AHl4AeuBt2BzG
 5VZi7PIrP8vfTmK/jZ2FunImZx7V/0iNuXsvi6011IUeevFXDDL9AEOMk/SbwBfq8lP2
 PDYlf65FLP2vwCkXTHusfLknBz73vvKlY1rid4ong1TRQ3HiqlH8UtlxBP4DMY2qUXuj
 HChMmXCRNwr9meDEzooO1Xsid2OQHL9x5e37874kxduhHCPqMi7Jsc/aNTgmQSt8IzKC
 L9cLwfjKYg6V26/Gh1Bg4sh6/2QGttuTHWiag+T26T3FG6QzWgNmpsZtr1SOrtj4qLzx
 jLrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQEq9JePXJvBl2R924h/cb19ZLnvAR0zZ56oed+Ls+X3qm0JKe3vJuVQoI0127yKC5neTDbhf/Gow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWXc2qcVG9vrXao61/xV1ZDKYBkRc8TSfnXZLkJ1uljyeRsl/5
 Yh9kGFvEL1RLVE0yfrBL16vG6AZPTQF/86tNjQttTY+WtPrX6466866pssQ+AkBiknM=
X-Gm-Gg: AfdE7cmWkoq0mmktyVwZ6RE90lGHBEi/RiiIW72niBEgy53Ha+/s7f+y5DTGa72jlSf
 7QzpVWgojYaUMPp/BJsTPD7GlPoh/HBXfVovAZf6E4CvaDIsGiRp2JAfihbtv+dnmvcFni4NDWl
 XbOZfzsAlYtSnIYbhZL9tOXp1hDox25VaV8bD4KVsM+O4lJHpcymPYLjLcmtGQW+42V2hvj9KlH
 fgIBsRT+lNDTpfcObsHMCrQBkIxxes6oQe1b0Hi0nq/LbMkRsjwUJQocrbe/1Oqe5yZcu0RIIL0
 ue31mgjZRUxJJGnzoypx1RNhsGl9ygh5HNIQ23vAezKMDqs+7tVvyalSF8HTUNglDIBCrnJ+izE
 GA3b7a5DhokdBBitbYVRO5iJKmpE8FR2okUIvnveE6wMzNyb83POnBMmjInk4ZdqE4yTjz8tinA
 sbGv2qW30D5pEyLWIBySbE6osx39MCQQ766ICLePDw9cN+ivmO4Y+2VLVW7GHQ3ZoCsWrI
X-Received: by 2002:a05:620a:44c3:b0:92e:c117:5ecd with SMTP id
 af79cd13be357-92ef2d107efmr56266185a.77.1783711249227; 
 Fri, 10 Jul 2026 12:20:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b8b3f2sm268883885a.13.2026.07.10.12.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:20:48 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:20:43 -0400
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
Subject: Re: [PATCH 26/30] mm/vma: introduce and use vma_set_pgoff()
Message-ID: <alFGC3Vq-sbf56lV@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <37f4d951897641f304dba26f6f91ade03a50eb01.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f4d951897641f304dba26f6f91ade03a50eb01.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:37PM +0100, Lorenzo Stoakes wrote:
> In order to lay the foundation for work that permits us to track the
> virtual page offset of MAP_PRIVATE file-backed mappings, we abstract the
> assignment of vma->vm_pgoff to vma_set_pgoff().
> 
> We additionally add a lock check here using the newly introduced
> vma_assert_can_modify(). This asserts the VMA write lock if the VMA is
> attached.
> 
> We also assert that, if this is an anonymous VMA and unfaulted, that its
> (virtual) page offset is equal to the page offset of the VMA's address.
> 
> In order to maintain correctness given this assert, we also update
> __install_special_mapping() to invoke vma_set_range() after it's set
> vma->vm_ops (which determine whether the VMA is anonymous or not).
> 
> We do not use vma_set_pgoff() in vm_area_init_from(), as at the point of
> forking, we don't necessarily have correct locking state.
> 
> Updating vma_set_range() covers most cases, but in addition to this we also
> update insert_vm_struct(), compat_set_vma_from_desc() and nommu callers.
> 
> We also update vma_add_pgoff() and vma_sub_pgoff() to use vma_set_pgoff().
> 
> While we're here, we drop a BUG_ON() and update insert_vm_struct()'s
> comment to reflect the fact anonymous mappings can be added here.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

