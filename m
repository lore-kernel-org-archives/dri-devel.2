Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E060C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B315210EDE1;
	Wed,  1 Jul 2026 07:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="TBOq91MZ";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDE910E21A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 15:55:19 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51c1d487f2cso3267391cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782834918; x=1783439718; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BHpENWZilS5aqo8aP9kraE35F/fs2tmonTK7cFttpS4=;
 b=TBOq91MZlPJZus6gnhaB7YFR23gswu104GSCPtVX1IdNf3Y43Nt8+UY7ZA0kGwg4tM
 a0MhoXVACeWDXbZ2X0m4SliNjuv6Y7rQ5N3R/GwT1bRf7BtaXNC+WcYhui55Q79KdhKf
 KHhDNBkV8xzCkq9tWsNpeI+qVsTpnVTMpe7u674uOnt5ttDMink7MyEQ9CuQrzcCO/fX
 hHNq5XC7AnNCB/jjVKPHZ5v95Tuh1+1A3OZRemKRDylm7aGyljtf9yHMvcPHq7+n2ycg
 h64os+QwcS85rmadorgoDUOBesoAbMdwdL86qm72VprVe65YhIuRExoj2p1eO1uQscR0
 VJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782834918; x=1783439718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHpENWZilS5aqo8aP9kraE35F/fs2tmonTK7cFttpS4=;
 b=dmRtecarm18yz5T6r/1A2wQYGoMYr8JoXcljC6tUIJ7OBZ1zupYHOxNzy1Eh0B5G5C
 bDpj9I2UMEY3OirF05BNa+RDvx+VTtWv0GbzPOg2iMRyrq2ZcJEZc64Vcb9butcPv797
 cuCzL7G/ZO7/VshgIS1ElvhLKXQXLD/L1kxvWEJIHNU0LerPU2fp7kcWNu/l/EygldP7
 bkEFTNBW5szSVPSmeEHaFUqd1ggQjNBCqbSuGv9Gcb/GRvUymUR5EOa4YT/z6xFRHqxN
 P4NefVWITl3KThii03T/ljWHbuQogzOA6xl3AN6N+1iuD1BCQjSmESXFay8bxBe97ZWq
 RtZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ862jxp9TjFCaBbDphoAyNhWhtQcGGKMa5tRi1H5yVkQicQWDibSw5a91PNNxZqsdM/IMhSG5qNZ0M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8CnNri6SCqhsF0FZYaEwluYY95Pl+iTWVBlq/QR2iDeucYAVo
 5IW1EqYVgT+aPq1C1gbBDvOGa2zo77yCasw+uv+stBDHZgHcvo1SGrPcJod0X/cNEbs=
X-Gm-Gg: AfdE7cmPkXN0xkGP2mEWXk7InlqiasDz+crFx9pW+ocpFArYDuR18vRe3o3KgTXnspn
 gmr1l+kXgEpWXOU/Gyp7d5HjMhxAr2dmcizhwaN77qa6QL9zmegOs5/qqt37XJCAUD/nk5RDvJ2
 0r4tso/2AKBWCO/FjxamjmXM1BaXGeYlq/XjQwAJk+Gww+q9z51YsgbI0gnTlb3uO6elY8Jo8pA
 HXYWx8oR35/I6WBbuvUpRNA+BOdJztAT5yj7yLYETpr+g51wqnxXM7/sp8r/zAUQ7/xvHR1IWtw
 v69xG40j63vYr4EAVzo3lVI2L/EhlGR8tQULn16VdABftKWCVQ93mKU26CRYnhvWldPrr0MOx++
 eRFRfzWpWaKyG/nlKngKWNWoloCgpUxBXrjO5eLgwPeLWjmCp3lfI2mWrSkPn5Q3CYLF/bhy1kN
 qdKxAvMwuUqpzuywz1eq774qlHABS7QQABLO+fQfk2v0nvy8pg3OR88pjVvQik7lJMet1/
X-Received: by 2002:a05:622a:586:b0:51a:8c97:fb94 with SMTP id
 d75a77b69052e-51c10911601mr53620781cf.61.1782834918282; 
 Tue, 30 Jun 2026 08:55:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c1080d149sm23102481cf.1.2026.06.30.08.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:55:17 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:55:12 -0400
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
Subject: Re: [PATCH 09/30] mm/rmap: parameterise anon_vma_interval_tree_*()
 by anon_vma
Message-ID: <akPm4FlwTj0FsZU9@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <1c1df7b905ef340cbf2effef769a4e770a8e0eb1.1782735110.git.ljs@kernel.org>
 <akPk5o_gHD1SxX_0@gourry-fedora-PF4VCD3F>
 <akPlUrNWzl1ZPw1S@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPlUrNWzl1ZPw1S@lucifer>
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

On Tue, Jun 30, 2026 at 04:49:45PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jun 30, 2026 at 11:46:46AM -0400, Gregory Price wrote:
> > On Mon, Jun 29, 2026 at 01:23:20PM +0100, Lorenzo Stoakes wrote:
> > > Similar to what we did with mapping_interval_tree*(), let's declare
> > > anon_vma_interval_tree*() in terms of anon_vma rather than rb_root_cached.
> > >
> > > In each case the rb tree referenced is &anon_vma->rb_root, so just pass
> > > anon_vma and the functions can figure this out themselves.
> > >
> > > Additionally, rename 'node' to 'avc', 'index' to 'pgoff_start', and 'last'
> > > to 'pgoff_last' to make clear what is being passed.
> > >
> >
> > would it be possible to split the pure rename changes out from the
> > changed function declarations?  It's hard to pick out this as something
> > that needs to be looked at as more than just a %s/x/y/
> 
> Hmmm do I have to? :P 

I mean, no :]

> I mean sure I can on a respin potentially, but it is a
> pretty trivial change? Just mechnically as above.
> 

And yeah certainly not worth a respin.  Just learning some of the
friction points of reviewing as I spend a little more time doing it
every day.

~Gregory
