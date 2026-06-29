Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BAFC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC94F10EB49;
	Tue, 30 Jun 2026 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="gE6AmtIv";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C42810E8F2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:54:54 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8de412e58edso34595716d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782748493; x=1783353293; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4r3nyg8MsZ+G0ckW9OOGJtlL6QAvCNLsDtm+wiwuKtE=;
 b=gE6AmtIvcAnrlmZuI2aTmjZSxErSrnEYPlEPX9q2ha1PmxVGlbdO2UIOg+5NJq4eax
 Mn7FbKdlb8O+cvz4GVvMM/bspGiAf/Miba15t3xlQMZYME/epZqPMNGmRuXk5142454K
 dUzGvP+Me4truIYF3NCN1vqelXgLelf6Cl72xzhknyB7YLLuoXwpMamTCJvaHxSdm9AH
 yo9s/Jd2DwRMrIGpcamamto6hfkRfSr8/WQouAkSQUC13NPYKJSU8G7NO82yT7hGB5Rx
 bVYU74BJBL98NiGPh/5c8ClH8tnMQFMbeGdbbS927Kk7mtwGl0L6zz2dTB8PSKncSAwg
 CwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748493; x=1783353293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4r3nyg8MsZ+G0ckW9OOGJtlL6QAvCNLsDtm+wiwuKtE=;
 b=Afacwgxs/eyv7MxOAu2lVhE6FqhXUWS7+9EFNePggzK1kC34Jf7tM3+zrwiTQf07WD
 cc0L8y/Lz/4SLAfXr0HljrxWQowi5r35BAg8MkuCgPhcL5IB9EoiTl/HzBtXAtHaQ9A2
 q+Oppiz4Y7vVfvskGIrfIubRF2vP7cnfsnLjqKUWWq5xrkNJYA9V1dsGbk2cQ1g6oTqh
 qZzURVSquxDRwY8KULQEHyePqXE5vqh220dz9RHS3M7gycIxNIMz7EcbknEN1q7AN9nD
 9ULTVALjc5S+GVkCmD4L548L3wGqmEaQy9itAPxQ/83O7OKG7k7e8BZgdfzXDbMUthuF
 LA5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTpE07hchAwskFA6F8UD8+sothVGlDyBv2nTY7Cdvig5XNDIcd24lJ/tkydceblUYEvAJDVP+vs1w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuwBCfdHFwRHfyO92MpcOHGx6I2YDUsdYts9A2zIhp/KfPjiZ2
 4dDGnGFfLCYKL4Kvh1GT8FmlRpaqw7nGAmEPpokeRxD7J7DJn9gQ9iogOwIbPYQuxLg=
X-Gm-Gg: AfdE7cmPsa77XiI7+QDWUfLpWXFqXOPoychh2fn4s/xA6xCCQRmQYbCwQIUvew8HILP
 VNeOfJ21WcJre/QdXol4jGATKmLDfv6u6bPPhzllbsLs6shFG9EFR9+ay45JopEQjo1HBHnrnkN
 PLkk4Nfi3jh0LU/TpvbdyKB02O/0gGKCAV8zQ4sMlYPfyaelS3BZY8J3SAfeiVlaquiW1LjUT/0
 Ca7aRe9mO7LAYPqipkrEVSwulr0jI/HtcAICvjlYb51Zskno1/3tJfReCeHwhiNfxQTzQibHbnB
 JfTuctOzQ4rkVQKvLcUtsrPydsdc70dWR/swKH7g3JVkJZDtwMK9w1MsOFV2P9rMNZ7aNDlAn4S
 MgnN2/pfOgQhxfTcqF8bR6uYGiiQhbhVFNIZOryoyVCW3yG+2VGdGa/BvqAES8T24h0mXhOZtWc
 1lQVUB7J1lwnZclSPOXpH8h32f4zX+uPxFBueU/4YwBDlb19q5rUjoERpUhwFhEEUn8IJbCuCjX
 mxempo=
X-Received: by 2002:a05:6214:c65:b0:8f0:5b55:1f6c with SMTP id
 6a1803df08f44-8f05b552223mr58558406d6.43.1782748492988; 
 Mon, 29 Jun 2026 08:54:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a26f1b34sm1726396d6.3.2026.06.29.08.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:54:52 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:54:47 -0400
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
Subject: Re: [PATCH 04/30] mm: introduce and use vma_end_pgoff()
Message-ID: <akKVR2wNSjbLDt1-@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <e379a1cb6a897126ad96e3a263fdb91d6c11f6cb.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e379a1cb6a897126ad96e3a263fdb91d6c11f6cb.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

On Mon, Jun 29, 2026 at 01:23:15PM +0100, Lorenzo Stoakes wrote:
> We already have vma_last_pgoff() which retrieves the last page offset
> within a VMA.
> 
> However, code often wishes to span a page offset range, which requires the
> exclusive end of this range.
> 
> So provide this in vma_end_pgoff() and update vma_last_pgoff() to use this
> function.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

