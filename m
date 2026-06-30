Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E9CC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D30810EDEC;
	Wed,  1 Jul 2026 07:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="N0R36bUM";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A9A10ECAC
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 15:42:25 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-92e65e18969so87345085a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782834144; x=1783438944; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QB3LlP562wM9vhAInyZtqjaYedctMNHlJgLHcqpXNiE=;
 b=N0R36bUMJOutGoUOvmv7ZJ/ABI56fapBFrAmu7wXRjOwq1G+C+/Fc1s4IqX4BfR6TF
 9WHzSXoegY88mw0u+111hPKD8/x3sibj8320e2R/1vx4m/m4XM39oUmBtmsxfJmpcjCd
 zAvjCkqKawVHGH1H08f3WvnYA9Mhj1jblFcyd93zbtAXgVD3f78mdZySwj3aEj7uZbID
 CuhL5jPGbH4WbbOUMODe4P0OCOvOOhcNIjGYH+XQ2NCOC+ZIRQHFPlrw1bvSDK0eIiXp
 frdARXk8I+py/P7EdieSKBrl2/SOyRu/3l9L/FT82g5tsSKFPjmcO8c7DPFnIa9swQXJ
 MZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782834144; x=1783438944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QB3LlP562wM9vhAInyZtqjaYedctMNHlJgLHcqpXNiE=;
 b=CTth9ZzWlGc+RdjczWYHHZKdoZVvVRh8LUsoqvMrHhcjYL1hXY2acYD3hHPLiK/ZZl
 FoSWLFqAOFv51yyCN4n3zFxvASht3h/1nusxNosNd6fA2D41oLDo5xE2rycE5E8kBV5x
 fuid4lPVDrby2dTbve0SKB6sggwk70g3Z74g0jYnptvGuy1wl1ZgmN4v48R7jmW1BT4r
 RZAnL3y3nFCONuAT462ZUlCJZlXg3W2FlmZnbMg1UGMtE4Qf9vpaxB9A9pyklK4wBXkm
 vK0bGf8+EZu8agvLFHG1Y1d1OTwMZtXIvtcCcIv0je6lFNU9z5QZ/ckasadkXfgdaV+E
 tnSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8B0KajsQfgi5bEYpcnwBO+wZpEuPY2CrrklGlltV59poqW4/JAl+r+USntO7i0oVZWv5Q5G9qZxWE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKurLmvF0kJQG52MP618d3BnRbI4G5Z8RsS7TmCDq60iL+5U5M
 IZXH59+wQv3lQOlUfSFWM7t8lheB0QNnHkLFAtAbB+K2xFIP545i+xcP7IDq88TUyvg=
X-Gm-Gg: AfdE7clGer6i2mKmieAa+8JFXjHLN+4uxRKK4YqFdLcn0P1GugXYYuSHR+lI8eAGpcx
 kUNERD7E/YvkdYhqry4g/7NYj67TKfSbHKE75YttdjZIxxHbg90C9NK5cEusIH8JuYmuYZTGsJJ
 1GgQtovpLWxOCAuKEcK//c7X6oonqqOUNssV2m1/LGknJGsl29eB+3y4qn4oEgjZTDb7/7Jx0H8
 5Tpw++fugQmy7Ors0oJ3Orh4FnQVxMBHy4ZALFdTWahL69mphq4qyFgAWskjWdJKfcPdKI843ku
 Cw9qNMEDgpM8MzGP0eCkuFU5VKqs1r5ETlc/a/KzcsOmFhyyXXO9XqtVdQmXo9mRcGGwZl+gWcN
 oYOGKf01yOxduGPTFvLr3tqMqsxoDV5rkHHs/wvImhE3FDABczUguvwb3DpBOYxI2ZE3kJ2e5+c
 vfD2GKp5AnyH3oGvsIqdxC2YRI/685fYPsa2Yl9zwcyHCS2XUKfxfnIs52tHXVm9mwXZWB
X-Received: by 2002:a05:620a:271d:b0:91e:712d:f79d with SMTP id
 af79cd13be357-92e6984d3d1mr270456885a.40.1782834143842; 
 Tue, 30 Jun 2026 08:42:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e6234dc50sm263249085a.39.2026.06.30.08.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:42:23 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:42:18 -0400
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
Subject: Re: [PATCH 08/30] mm/rmap: rename vma_interval_tree_*() to
 mapping_interval_tree_*()
Message-ID: <akPj2snngOp5nOYq@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <f95462457025370efd047b9dfb039e76bbddf58b.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95462457025370efd047b9dfb039e76bbddf58b.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:10 +0000
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

On Mon, Jun 29, 2026 at 01:23:19PM +0100, Lorenzo Stoakes wrote:
> The family of vma_interval_tree_() functions manipulate the
> address_space (which, of course, is generally referred to as 'mapping')
> reverse mapping, but are named the 'VMA' interval tree.
> 
> VMAs may be mapped by an anon_vma, an address_space, or both. Therefore
> calling the mapping interval tree a 'VMA' interval tree is rather
> confusing.
> 
> This is also inconsistent with the anon_vma_interval_tree_*() functions
> which explicitly reference the rmap object to which they pertain.
> 
> Rename the vma_interval_tree_*() functions to mapping_interval_tree_*() to
> correct this.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

obligatory "naming is hard", this patch helps, thank you.

Reviewed-by: Gregory Price <gourry@gourry.net>
