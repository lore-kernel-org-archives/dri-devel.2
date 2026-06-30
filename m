Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5230EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 00:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2D710E132;
	Tue, 30 Jun 2026 00:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jqp6ovtc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4554A10E12B;
 Tue, 30 Jun 2026 00:12:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE866416C4;
 Tue, 30 Jun 2026 00:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE721F000E9;
 Tue, 30 Jun 2026 00:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782778329;
 bh=a64RIiIV5g7zUCoZKk0RU0OaXgbT9t9LC605MaLKQjE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jqp6ovtcMAfA2KsMjewBOCot7QpQU+TrwAfxpD4Z2sngOCSXsbtBGzMV9G2ihxMHM
 EzM3eseuwxS3lItVuSkojLNHBqFP3vNnQ7f74LgzTWcF74FCHDNVqjJE/2L0pngBX5
 gHusJa7fgFXjvZ2gr7P7DuPcmzUz2z1vHLvTd/ED0uDeglpI2akCIFXOgpQzRgOQWi
 Q0iY57hEsRtpqz+c/SFniyhcocpVuLTtp2G6H7RrLeqeMiJqBbULCYWQ0A5BmBRBcN
 23J0bzYvOxk4uOScV4cjUhEepr5EM2xby41+WS7MQIwK59rUYp8rz4o4bmldVkGa/E
 EeHN1s4Rihftg==
From: SJ Park <sj@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
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
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
 Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, damon@lists.linux.dev,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 16/30] mm/vma: use vma_start_pgoff(),
 linear_page_index() in mm code
Date: Mon, 29 Jun 2026 17:11:59 -0700
Message-ID: <20260630001159.140651-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <33d79008948391d30bab38db5ae31072ce12f0a1.1782735110.git.ljs@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Mon, 29 Jun 2026 13:23:27 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> There are many instances in which linear_page_index() (as well as
> linear_page_delta()) is open-coded, which is confusing and inconsistent.
> 
> Additionally, vma->vm_pgoff doesn't necessarily make it clear that this is
> the page offset of the start of the VMA range.
> 
> Doing so also aids greppability.
> 
> So use vma_start_pgoff() in favour of directly accessing vma->vm_pgoff, and
> linear_page_index() where we can.
> 
> This also lays the ground for future changes which will add an anonymous
> page offset in order to be able to index MAP_PRIVATE-file backed anon
> folios in terms of their virtual page offset.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  include/linux/huge_mm.h    |  1 +
>  include/linux/hugetlb.h    |  3 +--
>  include/linux/pagemap.h    |  2 +-
>  mm/damon/vaddr.c           |  5 +++--

I quickly looked only the DAMON part.  Looks nice and cleaner, thank you!

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
